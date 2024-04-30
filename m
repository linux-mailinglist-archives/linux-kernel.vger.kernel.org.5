Return-Path: <linux-kernel+bounces-163243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822178B6796
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1341F23741
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B621CCA64;
	Tue, 30 Apr 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3JNYZuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC84E1FBA;
	Tue, 30 Apr 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441231; cv=none; b=pFvKwOC86QFG5eDqR1F2poxB+/SbyzOKOEB9+dyM06E+pWxPKQHc5L0vrUWyCss9QeoHTDUoInXZg702JfJJY4ymVZ3a0YkDlCFbrY6KmW+Ok9OIhfK67xS+pYTamXOvRn17Z+J96i1L0FvS5SReu9Gz6HA4I0HvWoUKtk2/VZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441231; c=relaxed/simple;
	bh=P+BuV6K7FPuh79AePzFKW3h82Dku1szdWqLoVyyuHKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ia1jieotP1TUPneTiGENZiys8n8dnkXjNKrVOz/39yedWQI/FHW45KfRsoA7YcbtIllWmwNRYsz3Nh2u7ezmqrc06yAMUxwkHCxleCpKla4s1SrAAcqcpFrlZ4+rRgfqZHPwWd17caSs6yb+ZFQSbNKThVx5ydEE7nuWEl7I5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3JNYZuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76E88C4AF1D;
	Tue, 30 Apr 2024 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714441230;
	bh=P+BuV6K7FPuh79AePzFKW3h82Dku1szdWqLoVyyuHKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y3JNYZuw7vjOB0JOt6wa93/8cHUoPN54FbSgA2XsDW9fywxQOLLTQemmj6QGb2jrd
	 oZLBXF1RzKr1tbe1sgQuVFlXBEGUSSQi1mOVBS4NaPNi4Eq7lDaIxLKe4wsK1IBfCK
	 c3n7+fJjRHrzMbsvLBgMa+FXYgJni+KYXdiOfGmLSITinKf1vw6gpY5ivaptGVK5xY
	 XCpOLNYNOHJ7dxPQfs8LYqG8SvzC6BvFRyy64z2gxUqaJWcYNskk0tZ0VzN/LD2UBz
	 oAQt0bTKGXTozcB9k7lHzIeOI3QiqfIpdlJc/sIHaoxtIcUihZD3EyP0FozARSrpM9
	 XUY3dyK6xCekg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B0F5C54BA4;
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
 <171444123043.8598.17705280071551125756.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 01:40:30 +0000
References: <20240429121343.v2.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
In-Reply-To: <20240429121343.v2.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
To: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 lalithkraj@chromium.org, chrome-platform@lists.linux.dev,
 bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
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



