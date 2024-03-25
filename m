Return-Path: <linux-kernel+bounces-116384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ECB88963A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CCA2989EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB90130ACE;
	Mon, 25 Mar 2024 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjQoFYO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E114A610;
	Mon, 25 Mar 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331664; cv=none; b=gYr37ZC1XsxDdAcxzNHmCY6nk/tl40yhdYP3Z8DdXF2nDt+TW4WLO+0R9uJu8+ipE5wgl7894jV2plWO/l3aDRLjB6DdjHdPI+UhUHtxeKBiyajFJNBjXiEA5+RefNDdKMusu22Pi4L7AQdHMm2bq6nS8F3M23LLEFLXCV195RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331664; c=relaxed/simple;
	bh=dGLtw9o76VTvjUB+GuC8G2B7iCbg1wM87eRGdun2uOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MBam6I4higyBM2Kr/epz7V3B1zAux0YqWiBsVrUxPqJQM21baPuV7DbJ+dprpNZIzjt/77y3/cnJd4wv3cp3s/DogVvKri+JSgulkaX8dG/uUGbuV+XDNJqqiEZh8RpdyQ4LzfiPffo/Lvwgm7sTdpLAyFfuaNlpV3OlVBYU+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjQoFYO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF215C41612;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331662;
	bh=dGLtw9o76VTvjUB+GuC8G2B7iCbg1wM87eRGdun2uOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kjQoFYO8fKJjz7H8xbUKF/K53JEivEvIdq37UDC2aubs3ODACU3XSRfqdop2h0w9e
	 HwI5RuI/feZ6YWtgKXQ89L6b9KdTYsfXwZJPmz+mp4Ulcv37nZQqs3Ing2JhalmGj1
	 sSCg1nZmphjRrNHc3zmNMXQVY7cPiKZOFFRK7jkzWtHnMiyrTnuKl6SLU1aGjTisPc
	 TZwctn0kfMqDF62Mkh/uQYmvPEEUVmwQVx0EwsvswwrS+ENEyoq+KnbsQN3nmfApLl
	 kLlIRLvkTJg4viHnObpx0LTjqYg77X/RxwkPYCkcWW4gED/S4C07flrvcVE7/jdZia
	 Y9RTPpjXbrXnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F29DD2D0E2;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
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
 <171133166264.9916.12747204402586368718.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 01:54:22 +0000
References: <20240126095721.782782-1-lma@chromium.org>
In-Reply-To: <20240126095721.782782-1-lma@chromium.org>
To: =?utf-8?q?=C5=81ukasz_Majczak_=3Clma=40chromium=2Eorg=3E?=@codeaurora.org
Cc: gwendal@chromium.org, tzungbi@kernel.org, biernacki@google.com,
 wim@linux-watchdog.org, lee@kernel.org, bleung@chromium.org,
 groeck@chromium.org, krzk@kernel.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
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



