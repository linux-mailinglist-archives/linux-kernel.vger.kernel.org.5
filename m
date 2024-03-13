Return-Path: <linux-kernel+bounces-102429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5497C87B1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BC31F214D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91D61670;
	Wed, 13 Mar 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAldaJHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06118612E7;
	Wed, 13 Mar 2024 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358081; cv=none; b=YJiWw2+23ZDAk5lfGjJefzYjNJQfmdH1gYz5kUP6EXnOcZo3Sk5ycUSeGTR1RkTKSfw8GEIkpp//XtVokjDJfb61Ayzt++IcIraiOjCmfX4yW49YhnxMQAvYKHMmPhe3pkUSAWHf/ZroazxeHJDkaIefwbOFQWOYmI6V4w3ByqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358081; c=relaxed/simple;
	bh=/GCyxSfrHic3KB1iBiRlnxUIfPEy4O/Ui9ksRYOEhtE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RqXX39Ybdztx0hsC7BPYMzhQJVMBQR8r5AH54v1GlBtruIROQxPSY+fp+eAHmjv867KPoUDpOj59Yqatq9upLAXfyfxHBp2TT5lEMX9nc6bbzlDByolGu3qf+sw8voMNtz5htF/xUMJ5Iod/7auVqpkb1yu2xZGrHR/+yBg4Bi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAldaJHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D42F7C43399;
	Wed, 13 Mar 2024 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358080;
	bh=/GCyxSfrHic3KB1iBiRlnxUIfPEy4O/Ui9ksRYOEhtE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XAldaJHvse8/QN78QHctsrDNMNYZZDP0sU19+qqSKPaxtzRnPqONp6x6b3wucmgEv
	 s3ibGC+o4NhYQpG76HdwNy4cRHxgUK4vexzqmq604wLWXZ6QzN7gxWxpFqyFn81XnH
	 Fx8SX5cJggt//CQzsd/vRwseOqaXhaFpd0uVGgMyvFpFZKdC7A0eame7xHnDRTTpng
	 GScs+6v9Rpwt55e80HMs9CXsdDwMld3tIjP0gKsqzS/HZWAS9B6q5np3c8T1pliOd/
	 rhwxjv+6seGE51oxsSF1roXWL953OgNQwLGNDV/9Zya801GpuEkOX/MroqTO/7ZFkG
	 5EznRh4O9gniA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3430D9505F;
	Wed, 13 Mar 2024 19:28:00 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i-nMb_TiYUxEQvzuUER_6fAs8Or96EU1isyrAywMPm1w@mail.gmail.com>
References: <CAJZ5v0i-nMb_TiYUxEQvzuUER_6fAs8Or96EU1isyrAywMPm1w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i-nMb_TiYUxEQvzuUER_6fAs8Or96EU1isyrAywMPm1w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc1
X-PR-Tracked-Commit-Id: dcb497ec993265dfc5fffa60b486c1ad353e9ad5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 259f7d5e2baf87fcbb4fabc46526c9c47fed1914
Message-Id: <171035808079.9850.11148575419742504090.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:28:00 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 17:01:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/259f7d5e2baf87fcbb4fabc46526c9c47fed1914

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

