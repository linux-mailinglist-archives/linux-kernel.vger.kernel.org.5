Return-Path: <linux-kernel+bounces-91306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C9870D0D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60ADB1C20D80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EADB7C6CC;
	Mon,  4 Mar 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJsRK9Rf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E997BB12;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587827; cv=none; b=UszZGb8eo2W3mErxDgOlTFh3RRelYHBZXItcaNV3zq3uS+T/ll1d4NaEZk39YuBhZc+nBlCarJwTUOD70KopmyfQ9EYnK3efTyRNAU7uiEKxSK9jS5XuErWgc3dbTbR2hbKDK+uMAw+E5a+RQuMKb2ssxP/tdbIV5h+79mXq6wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587827; c=relaxed/simple;
	bh=OUfeK5e6niTAqbSVycAFu/p0/23JImxIBKyCA9rtu7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vBFsJ/aFXNGGEPjzuZhAi1F/YkhOLaqEhRijMs+8b8YWWgy9yCkQZRaICG0ipBlDZ3d9QaqHwoHAGxaUeelcdKQIKiQUJXqJ2kUG3PIdeT4sq4P2/BsMukNOJZotNziBRKtr86ydNKl6qqKv0o8V/Jy7NwHGpddT28Y1Y+XPbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJsRK9Rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53B70C433C7;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587827;
	bh=OUfeK5e6niTAqbSVycAFu/p0/23JImxIBKyCA9rtu7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJsRK9RfjoaYsP8A5eWv+50Hg7D7XHWoyLmXtVIllY+UPhHp5d9dabzz034gt6f9F
	 39tGo40mH0zqdffzmyT2HnpWqegsYH1poWRccMCeQCM/zoDfS9ev2DlaeT7vY5ZKW4
	 Efuap+AM6DXhJb+GebOZkkSLe8jz3KbNZMoZXC/AZTvMc6ey4egeRvrqfZZ4Fehgrz
	 dtEMZ80tjA5ng1lR+khrNd32R6I+bmS+Snm74odG5asFQyKL6D/I2jVU+yjgUTyDP3
	 EqTQM2vx1mHDi1u66rAWwEmfzyf9m2nXmS3l8jWQkO1dPcfbELmCI7vTWUDxFSVPio
	 purT7Z8Nil1+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C4FEC3274B;
	Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: mgmt: remove useless NULL checks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170958782724.29902.18161431292915050332.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 21:30:27 +0000
References: <20240301133916.1268403-1-r.smirnov@omp.ru>
In-Reply-To: <20240301133916.1268403-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 s.shtylyov@omp.ru, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 1 Mar 2024 13:39:14 +0000 you wrote:
> Svace reports NULL check after dereference in
> mgmt_set_connectable_complete() and add_ext_adv_params_complete().
> The following patches remove these checks.
> 
> The second version has a more compact subjects compared to the
> first version.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: mgmt: remove NULL check in mgmt_set_connectable_complete()
    https://git.kernel.org/bluetooth/bluetooth-next/c/9f67e5ba6f6c
  - [v2,2/2] Bluetooth: mgmt: remove NULL check in add_ext_adv_params_complete()
    https://git.kernel.org/bluetooth/bluetooth-next/c/3da5589ad808

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



