Return-Path: <linux-kernel+bounces-103656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F066287C280
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA4F2856AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065E87604D;
	Thu, 14 Mar 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acpUAXme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C67581D;
	Thu, 14 Mar 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440434; cv=none; b=LTpQrziw5KUuP9I5tRAKgEqcqr6HeKPW5PXzeXUzqQVuMyDYN+8VIr4CIiiUYBy9BJFG1yAD4UEcyWDjYc5J7YQJiIOMkmyraKnGAX/mu1bNz6CPWj4jEW66SOC/nCyLFWbtL8bER4EvFp1Isx3+VQK2H+xhzV3t3HOcvO2T2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440434; c=relaxed/simple;
	bh=L80vniTzXf8c2SqXHXwT3toW1K6rBS+VAnyFtEwQNWM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PIhoIc9XEnmOLKV8qrit+tSML5DTgRnUdgB6rc5RWJ/1g9oALr/UOkgYv6xXnS+/34pW3epMtn/daIgUK25ZsZLqCdqmiSQtmYqNddLqn5HneHlBALsdpoaqaGKZbYWPlvA0734aHbll1kW9haumoD6kSKQ2+w5owFqw+o+cR3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acpUAXme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D690FC433A6;
	Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440433;
	bh=L80vniTzXf8c2SqXHXwT3toW1K6rBS+VAnyFtEwQNWM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=acpUAXmehg3/OWU+chOiSdjCRSaZBVge+ND3jN9Tlvabea/d4DWbEEhf9/z+rnIln
	 SChy7mymRoX8tpWqEbIoyzP6g9cazzCZzNWz3ibhGPQUPtS/ZpcKwH4iTuCc0YiscN
	 yuYQmNW6mBOyUUn9mkxXjoqXsTBhGlVF/O3BxO7JRovUgx4btnHVx7PFRFrjwzIeKE
	 wg3yDRTR6m75iArbb2CRzqnyTh8MlsDJTKetiOYPLsh8QSqaq1n89NGN21yvib4kXZ
	 lHvn2eNXL6XhMYKssvFbyXXeBB7eHS6G7hlAsN8FozhqbQi9vRoI8Ye9LdYDJ+mUOF
	 2la0KPx1YsWnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEDBFD84BAA;
	Thu, 14 Mar 2024 18:20:33 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <yzrnq4aybdxv5pilsrn7bsntj66odx3dhvkfocyjdmctxlcy5a@a43bag4p33ju>
References: <yzrnq4aybdxv5pilsrn7bsntj66odx3dhvkfocyjdmctxlcy5a@a43bag4p33ju>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <yzrnq4aybdxv5pilsrn7bsntj66odx3dhvkfocyjdmctxlcy5a@a43bag4p33ju>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.9
X-PR-Tracked-Commit-Id: 4e61f1e9d58fb0765f59f47d4d1f318b36c14d95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44f89c6d3c54761114b2bc0509144e3e5ced40b0
Message-Id: <171044043384.24196.15359986125767166280.pr-tracker-bot@kernel.org>
Date: Thu, 14 Mar 2024 18:20:33 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Mar 2024 23:13:39 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44f89c6d3c54761114b2bc0509144e3e5ced40b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

