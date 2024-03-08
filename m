Return-Path: <linux-kernel+bounces-97650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F463876D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BCB1C21173
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D611360BA6;
	Fri,  8 Mar 2024 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3AAXJbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC0605B8;
	Fri,  8 Mar 2024 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936906; cv=none; b=Sd4vrzwYLI2qX7WkLwudSNrp/xAF9lv+InXOf3pPGvaBNAuoWYSy2gKyo0vfjtb25R/W400HQqDwGeHm5noa9dVwdckhIb4PZmfax1JLjK8+qhzxoky4fP/QfZB30229gBCw5SOI5XSQ2UVmghcuKd5/gAxO0nLau8YuX05p/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936906; c=relaxed/simple;
	bh=hA0t16jJzqbFHw4ceKmJetJMI+iD/nbjbEu45u9QSF0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BnLvRAZFjk7E15y3H/axnK8YfTIPhCOx20+/E3jv4d6C02FCW3HZ7KfXtikjB5+CKYhyPPYqc3Dwt1rF7a+B2711pkd95NTqg5GKr4mr/tfXLn7cH4HPnfPgdBaCt1QpZKwNToE5BTAdqEIlicFkFTDvgPtDsvjNcRCUe7Ol+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3AAXJbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04A33C43394;
	Fri,  8 Mar 2024 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709936906;
	bh=hA0t16jJzqbFHw4ceKmJetJMI+iD/nbjbEu45u9QSF0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X3AAXJbpysr+OGq3tJYhkJTxKiLcVNHti+VKjtrIC047rqSwOLU33bpIrFiEmfcX2
	 UikYDGcee+LNhEHuQlxpTAPYo8fH6tp7cDCOld6lk+OnJKulk/yjMi6zRnPpSfFWh2
	 Ci/eFcW4veuFntxLHlwdbnZMZ8Y1XSfQvaWjBrHWN/qpkF4wT/aFQtFHsy0GjU3KlX
	 BcX4m3BAZq4FietnYTdd6PeDfFhSCUsJcgoodL9ffs5LqVKvyYHeDcLIGEyZFWQi7A
	 2VoALaZ1TiEEC5VbT15TAZFDYEHBenuQQNeq7LfeJYlilcE4BZU+DgA5mfpBW45lUz
	 R21qPuHsBYTXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E926FC39562;
	Fri,  8 Mar 2024 22:28:25 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.8-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zeqhkk0HJwEIUZ0D@google.com>
References: <Zeqhkk0HJwEIUZ0D@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zeqhkk0HJwEIUZ0D@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc7
X-PR-Tracked-Commit-Id: fbf8d71742557abaf558d8efb96742d442720cc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a4f31c7765e63e3219eac1e822ab16df09f318c
Message-Id: <170993690595.2485.14719835843243424056.pr-tracker-bot@kernel.org>
Date: Fri, 08 Mar 2024 22:28:25 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 7 Mar 2024 21:40:31 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a4f31c7765e63e3219eac1e822ab16df09f318c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

