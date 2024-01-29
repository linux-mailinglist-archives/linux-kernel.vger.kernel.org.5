Return-Path: <linux-kernel+bounces-42762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAA9840658
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C92DB2494F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD764CCA;
	Mon, 29 Jan 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mduGf35t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02557629FF;
	Mon, 29 Jan 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533827; cv=none; b=oPQeer/VEEZq+a2YK/+9nZbHIl62KOb/trEeCmRrkjrwt2SRmC2tkCd+U2j3Uap7JLTidoSaEjfjQLjsr3j3QSs2a+dlCHhIo0EdIJMFzxzq+IAxmyKLaoMJbe4NOp7Dw2bkcP9I8rROsD293u4HzuNFRfocG5supAGALRSTbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533827; c=relaxed/simple;
	bh=eCRt0pB1fjFS8/AJeCXrUSGNXRWEjTJFQC9ahUKJ6Fo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMIRiwsmpn3NxldM9BW+N1NqQXUt3+TDuswsgI18SumAAqX3k7FEA6ctq9171mTmdehpUL84PjIg4P6ji0HYFZB6OS1CpCqCYy1Rk5ZCAA1hbMizUpGRu+MWjgyMJI+VanAvzkqo91Q6lDpQe9EsvAz6CIs8BWkKpAAy/SMJ3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mduGf35t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CC4BC43394;
	Mon, 29 Jan 2024 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706533826;
	bh=eCRt0pB1fjFS8/AJeCXrUSGNXRWEjTJFQC9ahUKJ6Fo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mduGf35tKebnvVGWiscGfO55P2MD4itslO+mJ7wiwkNUVvsolsX9bzhY1QB+/kXQ1
	 Jz0t1Cj9es8yP9Sm4vQeqDfMZW23ZtwQBL6Aw9SajR6rg9X0eWDzY/6i+fSbL0GbV/
	 8DP84eKMR0VVlKrwWbsyTzDXqq6GfQoPTr88WvhqlhfrvuLv9Kq0EqCswjQDb5oPNf
	 XcJff2/c2JwT2t9QvQ9zwe6yJ1i/eJnR6Tgxw9v/WhivHOndu+Qru5Y1phyhaWEI4b
	 AJxJmSN3+zGiTp3br/JCCrwW41J/kY/RV+LOrsmAMRBIwZuToJtjiUKjPHyyZuH9ZX
	 QDKfxUy+bEXyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E2C6C4166F;
	Mon, 29 Jan 2024 13:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the
 measured external offset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170653382637.16154.1775024498484815054.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 13:10:26 +0000
References: <PH7PR03MB706498B5804E735C6B681407A07B2@PH7PR03MB7064.namprd03.prod.outlook.com>
In-Reply-To: <PH7PR03MB706498B5804E735C6B681407A07B2@PH7PR03MB7064.namprd03.prod.outlook.com>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, min.li.xe@renesas.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 24 Jan 2024 13:49:46 -0500 you wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This change is for the PHC devices that can measure the phase offset
> between PHC signal and the external signal, such as the 1PPS signal of
> GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
> the existing ptp_extts_event so that application such as ts2phc can
> poll the external offset the same way as extts. Hence, ts2phc can use
> the offset to achieve the alignment between PHC and the external signal
> by the help of either SW or HW filters.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
    https://git.kernel.org/netdev/net-next/c/ea1cc3ee34a5
  - [net-next,v7,2/2] ptp: add FemtoClock3 Wireless as ptp hardware clock
    https://git.kernel.org/netdev/net-next/c/1ddfecafabf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



