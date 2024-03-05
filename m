Return-Path: <linux-kernel+bounces-92922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4140872831
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6030028C401
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667E12A16A;
	Tue,  5 Mar 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc5tbXzh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9591272CC;
	Tue,  5 Mar 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668833; cv=none; b=kH1G1CNh1xEDq1Uc7Iy6FCJdfu1GQ6VANCpIPq3FnQnGYoNR/ojVqSXsQgdZTKdLFdNFSlQRqi607ZMNBwVTHDf48ePHeV9akuarcSoJguTRZCc4njAiIdPpPLBvLRiKPAfxXxw1NHXkN7Chl2X/DNrDl3ZIlcFRnwXSVhwsp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668833; c=relaxed/simple;
	bh=9xBvEf4prS3iut14em+VSKNMOHTjGO6VQ6nZWv1dzq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JHgNcVgAateU6NhNQiutmfxipOjg1Kv+3Vw7PghvwXGSxyWPlCPJGcAHoOPgZFlzPiEbMc4Q6AD8fgYmrOPppuHlmhhSX4qiF3q38Q95lWozCA71tBAUOifEajUTantiW4RXfY79GqJmBGT4XOAPke0qirA4ISYXUmQnffZnmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc5tbXzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 135D2C433C7;
	Tue,  5 Mar 2024 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709668833;
	bh=9xBvEf4prS3iut14em+VSKNMOHTjGO6VQ6nZWv1dzq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xc5tbXzhOvIdwKDJGbcuseVY0UFx2FRbeuxTR9M2TeYJmbH+qw2KSQuGp3BklOm7l
	 SKtLUoNAgDxcX7JDD0WMyyFpc3+2iCRtVQ+GGICrfocySJkOD+EokME1xP09rCaQ3E
	 5D7mPWU6DKY2Cxmz9NyEhD8EaPxjHG7iMTkqYwdG93d+/z63j767EcW8D/ewFa8UzM
	 wkVVKdD/0/f5VczSZF09yoq3YOhofmz0/jDhkLcMwiioi3gQgM0HoOk4tW1Jz1/NlR
	 FkhhjuDzz1+3DuQtE/Xcr4QAuG7Nd12DS1+/JKZKatSWNU9INFe14ZkXRD6HIqMfSu
	 4a5OVovToZ0AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB81AD88F81;
	Tue,  5 Mar 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: fc3: Convert to platform remove callback returning void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170966883295.18762.14661053302967043118.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 20:00:32 +0000
References: <20240304091325.717546-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240304091325.717546-2-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: richardcochran@gmail.com, min.li.xe@renesas.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Mar 2024 10:13:25 +0100 you wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Here is the summary with links:
  - ptp: fc3: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/60d06425e045

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



