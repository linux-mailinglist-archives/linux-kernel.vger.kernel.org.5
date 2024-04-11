Return-Path: <linux-kernel+bounces-139670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D788A0646
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9F8B2359C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2976013B586;
	Thu, 11 Apr 2024 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMTteVte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95A5D8EE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804262; cv=none; b=DRcZj2lKWSU5GODtO7Z8geEc/U28XbE/FN6SkImOEwUMkl1r2vvXoRnAhscmZH/8dz0weYVX3ekyDx2liU4mLDpv6h3PYQZ0f7S2/2jV3/dk86pCltY4o3HCrUkmY26+EOwmKoIq5X6Gni7bLOq828HwUvEWkTOpd8uVbZNkZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804262; c=relaxed/simple;
	bh=YvMib1htxlZN62R42J4V1VTcUekHBYm1CbpUedIcApM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hAUCsvgJTTFjl4KzVcu1T3gSuvEEL6D5gctrrNYR/Kx4+aOrw3lOrL/azBMrL3nCZP8C5iWWeWrNMHK1DsSzxDGVycP9miF6ukmTAX+NdwlVtM/Wp+VPhORF4z3o2CZ6Re13thkim84f4Erw0s8vmLfCjwAptOmJ/MNKyt/RSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMTteVte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04978C433F1;
	Thu, 11 Apr 2024 02:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712804262;
	bh=YvMib1htxlZN62R42J4V1VTcUekHBYm1CbpUedIcApM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XMTteVtexv9SJQoPJvHsu29jfi3uc/u7XpM5VPqyWgEISizEeOsUuXHPK2lUlJdDM
	 aTzAwRsXsIErYC83h1aSCkWbZ8/MqM0JLZfcJk1/YEXHKxEhOJqDxGhxPsxTCvEXd7
	 xSFJwoOhQ0zL7gG9/tG11GdV4eSRAZYbQ3WRlJ8TnqNPF/koz/iuBXDxuP5L/o+hVi
	 f5BLpjfAcaT1cS7AAqqAbSC8vzGYRV0wLr5Lt3wBm2IYCUEZX/MK8CRm4VVvBrn0ZU
	 CqpdXkWMnutshOWiwOuAA+gKs7Ef1drwl0926KIf5Jj31kDqFPssvUSLD1SNIUt04N
	 mHOBGCe/l2THw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F01CBD60311;
	Thu, 11 Apr 2024 02:57:41 +0000 (UTC)
Subject: Re: [GIT PULL] bootconfig: Fixes for v6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240411100621.d3fd98310487cef580456853@kernel.org>
References: <20240411100621.d3fd98310487cef580456853@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240411100621.d3fd98310487cef580456853@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-fixes-v6.9-rc3
X-PR-Tracked-Commit-Id: c722cea208789d9e2660992bcd05fb9fac3adb56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03a55b63919f4b52b9c323d9a43ccccdc1cdb33b
Message-Id: <171280426197.32383.8302292353508904926.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 02:57:41 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, Zhenhua Huang <quic_zhenhuah@quicinc.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 10:06:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-fixes-v6.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03a55b63919f4b52b9c323d9a43ccccdc1cdb33b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

