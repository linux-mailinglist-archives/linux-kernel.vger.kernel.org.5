Return-Path: <linux-kernel+bounces-69967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B3A8590E9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EBC6B210BE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB467D406;
	Sat, 17 Feb 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOGg1FXy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25057CF36;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708187222; cv=none; b=PGsS3iOlqeNdvHRLAkEGdcfc3MficRB4CFRkSdSjUxh3G05hG71a//9hYgRpsrLKbw6vFYbktzs1AZUmcaFTAAhR55R7EfxtCuk8oTGJ9mODLCyqz5hbdd7IRfspfHcey4d9z/lzhLWcNL+4rNS9FBHyHgcEf+d7xCbJzvhik7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708187222; c=relaxed/simple;
	bh=SqH/c7qeG53/RRwO38FMvUSPvOyyfu4QQ77KEHh9fjU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q0KMviI9uVlqUyCBNI7gQOY2RWZT+YbH+VQCeYmMPvZ+bEzT24rgf7dnJ9ktr0Lko09gwUkBVuR+GgH5uQcsPPqZfsT4ID1XTyzRoa2ITDT5oI01pQrht+gnxLPY3I+Grqq/9M1Uc8Fs+gZjhv2ugNYayvOEDOH+7ZqVJ0UoCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOGg1FXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57C0CC433B1;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708187222;
	bh=SqH/c7qeG53/RRwO38FMvUSPvOyyfu4QQ77KEHh9fjU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IOGg1FXyeHlOrVVW1Y/kmqQjR9saB7BsdfdWMEiPCsTTtQEAbrxXc5f072+PW36LA
	 VsCPnPDQjZOudBFmhOVt5jAC5sn85mV8iu1hLOiys0qsmJasCFoX8yDZa3DD1ddH7S
	 dFFsvSWdigo1QM8Jq9/+81WWTUx85zvjgstrRAX0zJvqkdMfMtiiPveHDPmSBN1Luc
	 awYg/CHgKaP48AjKMhIhOfdfzb3LrQHYRMvikmTIArMoZnlyKpBJ0EOJdiaM6ZX7wv
	 LFtxzG3XNU6EFxWrADygJZLauLmv9ad5+AR4L9AivMjNmNoOgs2zyWucdcc8Qd62o7
	 WGqEGhWPM9roA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38AA0C04E24;
	Sat, 17 Feb 2024 16:27:02 +0000 (UTC)
Subject: Re: [GIT PULL for v6.8-rc5] media fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240217100808.58ef40b6@coco.lan>
References: <20240217100808.58ef40b6@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240217100808.58ef40b6@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.8-4
X-PR-Tracked-Commit-Id: 346c84e281a963437b9fe9dfcd92c531630289de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac00b6546d390bc12d1d2824c2b5d95046097eb2
Message-Id: <170818722222.7289.750606811610786631.pr-tracker-bot@kernel.org>
Date: Sat, 17 Feb 2024 16:27:02 +0000
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 17 Feb 2024 10:08:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.8-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac00b6546d390bc12d1d2824c2b5d95046097eb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

