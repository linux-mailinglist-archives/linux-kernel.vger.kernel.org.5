Return-Path: <linux-kernel+bounces-144238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E38A4376
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9D52817B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288E1369B5;
	Sun, 14 Apr 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl4xc13I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEFA134CE8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713108765; cv=none; b=XVOBFHJasc3liQfQKEQtz2v8hp7pj18dytflLPOU3rVB2sAaO8lmNMi3r3mrPrCoBylS7KdUqow1YWcEqoahImg5tgHMbRKnCFPNnvHMKdj5As/1A93qsk4mFhRmQszgR2kuzpTv8WYxkSa7z9/GOVA67c8V8k8oZCpJw/9Ii5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713108765; c=relaxed/simple;
	bh=eOD+pY6Oui9HSbYxTAiv8AlRymab8T1LAk021Ri9JVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fjOw0SHUa1Pzj4wI9FlkZ8T53GmC7Q93N4gKeNSv5I5MrJ7mCaBbjVVqOwysnlFptEdnB7smISicbY+KOAS8hdhN34Dm8CpLrXerGF+B6PmDfjYQdmZkMEsmKL6XC8eB5w7RT1bzxZeMfkDLC7yzmFGInP4/TP3Hs/OF7GcFpR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl4xc13I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9046BC4AF52;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713108765;
	bh=eOD+pY6Oui9HSbYxTAiv8AlRymab8T1LAk021Ri9JVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hl4xc13I1oNk1LM6SH1ng1DYnSoZu2/jOkoLxW/x2pw0NzzJHh4V0L+Q+O222gLaq
	 5mReJl5UW4x4D2j78i9H6RiG+qjc8nOtijf27eEbt0xTB6nmRmlflhJJfhxn3bs9XA
	 Sbv9YyQ4BE3xQiZcYWC6r+LQI7Xclic5o2aPeBpKzxI5I+YlT3PDTIChFlrjyaLSX4
	 UObpiOj5RVkWSeHlkRVBMIH1RajfuG001ekledCroY8XUzf6ntt1vcwUNGAeR0X46d
	 dXvogcOeW4IGCJpS/U+MupU2jtU6tGYgFROBkDx4jMzHy1fn/TVNjuqjucAX+w8tcn
	 ccOP/JsupEdkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83D9BC32751;
	Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V3] f2fs: add REQ_TIME time update for some user
 behaviors
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171310876553.3156.14471633770093926825.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1710915736-31823-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hongyu.jin@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 20 Mar 2024 14:22:16 +0800 you wrote:
> some user behaviors requested filesystem operations, which
> will cause filesystem not idle.
> Meanwhile adjust some f2fs_update_time(REQ_TIME) positions.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> v3: modify some update conditions according to Chao's suggeestions
> v2: update patch according to Chao's suggestions
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V3] f2fs: add REQ_TIME time update for some user behaviors
    https://git.kernel.org/jaegeuk/f2fs/c/fa18d87cb20f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



