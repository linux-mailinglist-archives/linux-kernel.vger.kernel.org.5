Return-Path: <linux-kernel+bounces-68252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A655A8577D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91701C20B26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A8B1B947;
	Fri, 16 Feb 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX499UtL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1517C76;
	Fri, 16 Feb 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072828; cv=none; b=mPz/AyFZsAEiM1rTfL7p9qTJ76ghMO1kP6qOQyJxoypo7+ac2Kg1coUMIKGldi9K/fLB4bMDkVeFr1dP/4pvIS262AuzXaTdA9OLt0FIFMHZKmEJbb15BhkkOjOuFsL9DZLC+DHanNuRoStKip1SDYlBOAwCUSMguWWoqjHaYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072828; c=relaxed/simple;
	bh=NQc1ij17nNGhGaB5awK0ymJiY6GTndqpbo0GW0Fva9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6anpRIOwEwPwSMwhep9ualdKDWrTfh85Jx15CJ6t5gA1KA/R/Tt61Fa9r4Wb7HWCXOEYTv3HcKlBby4kdTw3K4jR/6k04tkVCagSCLlnca41hOtvoL82VBWmdNqiyeunIm3e/OmZOuDinVbrViHfRtr2S3y6iVbgilNQK4jnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX499UtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C664C43390;
	Fri, 16 Feb 2024 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708072827;
	bh=NQc1ij17nNGhGaB5awK0ymJiY6GTndqpbo0GW0Fva9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fX499UtLZpfei/zqq0Send+wMqjwzkWJvN9OUxHfFZ70H60uy5olg2CLFFtPLx0+E
	 tpDl6USTP7dYGe9gQjp+9Lzz84n5q54suZ6nzmTy/IsOY9oDDesaCVNhSzsw0ilH1v
	 fwp1w24xo8pQBlH/CtEkWfLD6xay7zGAyx+/zRJnwE3pya6bkuX4z0Up/uHAbSIJZS
	 x5xozrEPm9KtOA34orfJOsZMSJvh/7Ghyg+v+jwsHyvF52LncXL4IQ9ulN3VVtTt0y
	 u97qtLJehhb0SAWvz0f5FRw9QpX/0BowK5WVb10qokhzsHQtVHgP/fz1TMBwR2AlKd
	 zgbIzUw8dGHaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C8A6D8C97D;
	Fri, 16 Feb 2024 08:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] net: ravb: Add runtime PM support (part 2)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807282730.9247.15391405559385840916.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 08:40:27 +0000
References: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, biju.das.jz@bp.renesas.com,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 15:57:54 +0200 you wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds runtime PM support for the ravb driver. This is a continuation
> of [1].
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] net: ravb: Get rid of the temporary variable irq
    https://git.kernel.org/netdev/net-next/c/a260f080660e
  - [net-next,v4,2/6] net: ravb: Keep the reverse order of operations in ravb_close()
    https://git.kernel.org/netdev/net-next/c/a5f149a97d09
  - [net-next,v4,3/6] net: ravb: Return cached statistics if the interface is down
    https://git.kernel.org/netdev/net-next/c/bbf2345fa658
  - [net-next,v4,4/6] net: ravb: Move the update of ndev->features to ravb_set_features()
    https://git.kernel.org/netdev/net-next/c/7bddccc9911c
  - [net-next,v4,5/6] net: ravb: Do not apply features to hardware if the interface is down
    https://git.kernel.org/netdev/net-next/c/a71a50e391bf
  - [net-next,v4,6/6] net: ravb: Add runtime PM support
    https://git.kernel.org/netdev/net-next/c/48f894ab07c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



