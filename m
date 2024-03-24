Return-Path: <linux-kernel+bounces-112802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434C6887E52
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747931C2104F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFE3BB52;
	Sun, 24 Mar 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQLHSpwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283D3B2B6
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304762; cv=none; b=hZ0+vz0PAsQTSAgaylEq868v1SSoPU8iVVjIfdEDCH04ETALBhOIfYssUzGguqWNYekrdP5h/nZhy/RgOvGZHVknpBgHIgP/lhjdQyOP69ZJVjGWKsw5IkldDpoiH0oupjY1zUlfsiEvbMEp6xeq2dhTb7JmN76wDRvKGDqzqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304762; c=relaxed/simple;
	bh=l3WlzYY+bZspT6r9JtEwt8y6MrcVLMdYrsFfJI6ZPv8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uxMQ1eqaGw4YN0VzAdqo0a4ul5znc4kpaxEeJfIHHLPmsnYNR8xoQzXPUxKdz8rtukR3X7+OqW/PBn5unTFaYaKjtxBMB/0zrgHE2cgTgtLLw+XvtB9l5/aFQohp1A3YWqeROP9fjBcjxvpIRdQjSVEtKABMvGAMej+zNqkkd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQLHSpwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2A4BC433F1;
	Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711304762;
	bh=l3WlzYY+bZspT6r9JtEwt8y6MrcVLMdYrsFfJI6ZPv8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vQLHSpwHPIlg4BAOU+FU4fdNNvlzr7B2fth7SA0SHgO8hyQZ7UvcSkmOyOGmf+uWx
	 IcKZFORo2c8MtlRfOp26xP7YyZ1WsW8Z+2jg1FmMynZNrXR7RL5w86SfpaBDQNAavY
	 /b1/O3wT9UPrpET3Fw+OBVila1L9D8RXua8KAyzYgH7pS+Ocx+NmKvauuPj89McYDR
	 3KcQJfyhn4p96UwA7vxtSisrs4PObNqoZaVit5hjWAQ++Q5n/pV4rqRK/Bdpbe0cex
	 who9fLBtp8BBSG0a1sHF7nIW30s3Z+Yg5I1riKIVxzauugA7nlTEoYBSuj5Tu1eUu8
	 3GSIpykOxfyKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8DF3D8BCE0;
	Sun, 24 Mar 2024 18:26:02 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <171129691819.2804823.13323681878641552052.tglx@xen13>
References: <171129691660.2804823.9714349244324963954.tglx@xen13> <171129691819.2804823.13323681878641552052.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <171129691819.2804823.13323681878641552052.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-03-24
X-PR-Tracked-Commit-Id: 9843231c97267d72be38a0409f5097987bc2cfa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e74df2f8f15eaa1ebbdfc1f6fef27a26d789de8
Message-Id: <171130476268.9900.5853104806404159570.pr-tracker-bot@kernel.org>
Date: Sun, 24 Mar 2024 18:26:02 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Mar 2024 17:15:33 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-03-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e74df2f8f15eaa1ebbdfc1f6fef27a26d789de8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

