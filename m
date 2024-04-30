Return-Path: <linux-kernel+bounces-163244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6178B6795
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7345284F67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6102C8DE;
	Tue, 30 Apr 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsqY/n4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88220EB;
	Tue, 30 Apr 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441231; cv=none; b=NheOwP7cVdiLscbJI5lNRAsgzILrcQanpBcP4dvJrc2XRqrB7LtNlLExZwiXe/1kLPO/7Kqwc23zdSak3ZpXUj7ithw0nbs+x1EvXXAvNk/fbGIlQXME0fas1vO1cpKF6UJEpqhKwnWBM0SaX7fnmMrq0QR2gxCB53Epv878OAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441231; c=relaxed/simple;
	bh=RI8f1akC41OX4oSldZpM0iuvb7hFOkwlFixOzT4IYTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SVGw6znQBAGiwYwB0G0UrYz35wyiXIm84PWDPeYFm3QMnIbkOMs0SwpjVCSiAcZpCRQ3fZK03QJLO6e/mrHwmsO5EYDje2gvFIJPiBoKWTrT6D5xp7dcVBdIJ3QfBubU43/D0OWD8J5qTa0wiIuYYDraBM8rIV0HF7PDKbQcgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsqY/n4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46DA8C4AF18;
	Tue, 30 Apr 2024 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714441230;
	bh=RI8f1akC41OX4oSldZpM0iuvb7hFOkwlFixOzT4IYTI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tsqY/n4VGOnmkxhZomkSBiIknTXO2TooUviodMdS4Rh5IAMzOdr/gyPqHynEaHhQY
	 ODWXmimgRdMU+6/o6YH21k78+LobSoaR971xo51ktzgPVfioeYB9jADS0K/Kw4iSFt
	 5DNEwZYYu2tacfxsjN1Yj604MqbvQyX4E7Fcn0Na+VeH7GbgSEpgmDK+xKJcMIvTCl
	 UhAS+MNByQkv/cSh/u4y6AsFLA8N2BtN32aOLcpr28mxlCJZB6FYMe4oSmpEANUf8R
	 r+y8sI42bAC6qnF5mA6Y7hlkCF58lolAb7tV3VMTb/L1XsyjTFHMOtAnV4C+4FtjwN
	 OiGtJJAZCThUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33618E2D48A;
	Tue, 30 Apr 2024 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] chrome/cros_ec: Handle events during suspend after resume
 completion
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171444123020.8598.2760691048321642330.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 01:40:30 +0000
References: <20240429121343.v2.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
In-Reply-To: <20240429121343.v2.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
To: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 lalithkraj@chromium.org, chrome-platform@lists.linux.dev,
 bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 29 Apr 2024 12:13:45 -0600 you wrote:
> Commit 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host
> command and irq disable") re-ordered the resume sequence. Before that
> change, cros_ec resume sequence is:
> 1) Enable IRQ
> 2) Send resume event
> 3) Handle events during suspend
> 
> [...]

Here is the summary with links:
  - [v2] chrome/cros_ec: Handle events during suspend after resume completion
    https://git.kernel.org/chrome-platform/c/2fbe479c0024

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



