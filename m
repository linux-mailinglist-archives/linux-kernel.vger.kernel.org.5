Return-Path: <linux-kernel+bounces-116408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82888966C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764DAB3921D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D851474CF;
	Mon, 25 Mar 2024 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkbd0C7V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FC15356C;
	Mon, 25 Mar 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332790; cv=none; b=jVBnxpX49cN53ksGbxAH34RQQzRFjp2bHX7y1wFjrssuMxGtGg2Xo1EWhl1hKK906cMaHOgQH63TlqWxqVfRdK40gO5rlUcCbnXd3Yxy/uqFr7WNdU6xUXSin4TTtkDGCpSIz3SaQEgY7G7j31C9lW4yJskqga2ujM2Z0YNF6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332790; c=relaxed/simple;
	bh=Wy330H3trj8pdgbhnMuyekSalmsh0eVWfbLRwGAh9LU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ull0JtnucKa2183Jq27mgTwFNpdSQ5MQtJ/hYxPG7fsVMvfgD2NsEZhDGXDOIRUMJgXanZwzRJm83y2H6yaR/a+AvORFWdC+PLop9koKC2GCRCGF482580gPONFfIncz0CzSBxeuIanT6WUaHbXZYHtbFyBhPlzYQevs/WQlx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkbd0C7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8614C4160D;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711332787;
	bh=Wy330H3trj8pdgbhnMuyekSalmsh0eVWfbLRwGAh9LU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bkbd0C7VeJ8DftvdWXOjMfgVpf4Ohocoqw0ZxAiKb33mwEqLrlMHETx7IG73XNLZh
	 FZfwXXciq+Jw+r9zYPkb1J5dTi6hvNd2fcLoNBle64+OqmwChVdnfXr7sH3n5pWj8p
	 wvWTIE+BnYJbmKbISaz8l5is9lhZfkOk6B19XDmcm6T6HENCpNgcN46Bz7UkZ3plPz
	 U333j+0bjOk+8sDrI6h+b4Tzts96ETQ0l5/QUqK2S5TwPEvwOk1KTwSoTLbXU2yz8o
	 9SomN7gt3rkyCIWCZdWs7NnDDq2vqXu+mCUr6yz+FtKsNEZZSt7W+QyRjspxn2DncL
	 D6nJQz79EpBcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA071D2D0E8;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] Introduce EC-based watchdog
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133278769.9916.8679825842016990961.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:13:07 +0000
References: <20240126095721.782782-1-lma@chromium.org>
In-Reply-To: <20240126095721.782782-1-lma@chromium.org>
To: =?utf-8?q?=C5=81ukasz_Majczak_=3Clma=40chromium=2Eorg=3E?=@codeaurora.org
Cc: gwendal@chromium.org, tzungbi@kernel.org, biernacki@google.com,
 wim@linux-watchdog.org, lee@kernel.org, bleung@chromium.org,
 groeck@chromium.org, krzk@kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Lee Jones <lee@kernel.org>:

On Fri, 26 Jan 2024 09:57:18 +0000 you wrote:
> Chromeos devices are equipped with the embedded controller (EC)
> that can be used as a watchdog. The following patches
> updates the structures and definitions required to
> communicate with EC-based watchdog and implements the
> driver itself.
> 
> V1:https://patchwork.kernel.org/project/linux-watchdog/patch/20240117102450.4080839-1-lma@chromium.org/
> V2:https://patchwork.kernel.org/project/linux-watchdog/list/?series=817925
> V3:https://patchwork.kernel.org/project/linux-watchdog/list/?series=818036
> 
> [...]

Here is the summary with links:
  - [v4,1/3] platform/chrome: Update binary interface for EC-based watchdog
    https://git.kernel.org/chrome-platform/c/4d2ff655fb85
  - [v4,2/3] watchdog: Add ChromeOS EC-based watchdog driver
    https://git.kernel.org/chrome-platform/c/843dac4d3687

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



