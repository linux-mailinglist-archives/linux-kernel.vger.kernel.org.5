Return-Path: <linux-kernel+bounces-102424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E00C587B284
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B75A4B34289
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6768F50A62;
	Wed, 13 Mar 2024 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLw2vgPD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48B3399B;
	Wed, 13 Mar 2024 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358067; cv=none; b=g9aSFzcF1U0XL6X/v6Zpn00WSGq3i5TGrQvvClBoSZUPDnLyE2BI4J9j4GFOp53zMlyC11EWzI4EW2G3tD3t5TC8obnwHoybs8aQ2W0r8Mj5aboCJ5zYkcZhys/R+LBIGNiAlsiRa+9erpY6rYs8T/EdRODYp+GJaUcS26g8L2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358067; c=relaxed/simple;
	bh=evGJ2Q4bkiCsk2u4Cp5atiDD2au77XKmdpAb3cavSqw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o01ikHkC7YeN2YeELDLfpfRcMtcYDuPeC/5Ow7XQOEnEwGruvF0foc+7ASulIdCs4ZibXApHTqJby93mEGC79PxjiE+iImwBe/7vHUNrVHayvHi9DZWSBydUPjh1V0FU7efF2nITtJ3rxSLusyq/7UipawWi3v+o9tCVmvodGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLw2vgPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 865F0C433F1;
	Wed, 13 Mar 2024 19:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710358067;
	bh=evGJ2Q4bkiCsk2u4Cp5atiDD2au77XKmdpAb3cavSqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MLw2vgPDW30sNX3UQ/meP+7gje3RClp3X7XtoK6POEw3ao8NX8yAGy4SfYefYmfhx
	 KuB4xAJ+XhNDSdx2X9uMrxU8ze/n/K5fDrAf5owmEsltWErKeMS8afr4h5E8UCEiMO
	 LO/gOtjD9w5zR6ixnqKc+JecE4eKUfXozOIg+c54BAaniFCgIRguKY3T7/K04MqoUb
	 9Bd1OT9bfK/PoFcZoCy+gtS+7dJ7GAn6VT15qAEjK3uXUg6MvSJsyB+MKr7hI+5NI6
	 tQL3V5IvTmLAXG1nmDZYIFC1c4psjhGE2xPpjGATdEQ+Ww1bMwxEfCXkzq1Tv+YTEw
	 znhA0Z80s/M1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FC3DD95054;
	Wed, 13 Mar 2024 19:27:47 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240311151323.88DE3C43390@smtp.kernel.org>
References: <20240311151323.88DE3C43390@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240311151323.88DE3C43390@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.9
X-PR-Tracked-Commit-Id: be84be4a35fa99cca7e81e6dd21516a324cca413
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cdebf62a159f31351946685b02941c968b96e49
Message-Id: <171035806744.9850.732541920628442793.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 19:27:47 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 15:13:14 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cdebf62a159f31351946685b02941c968b96e49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

