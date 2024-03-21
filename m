Return-Path: <linux-kernel+bounces-110756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6115B886341
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E67E1F22D15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73B1369BA;
	Thu, 21 Mar 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pU6rYWCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59556136982;
	Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059922; cv=none; b=UU5Sy+xTMFzLiPb1kRwW3aF9vRQ3Q+3Hj2M/WntoQMYdES5v0BYpbfPc8iI75nIU79BYJhuPt1AulbdwpaJrPzmmnz/vYK+TdkngfpwhB4a8OlE0ClbWmTSQGYhAdlKZ6puRzEPayMXyCgUby+5ttMYoDVqyvM8hTyTmj+qv4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059922; c=relaxed/simple;
	bh=fi7aHAiZniVdG0Ix/kdINY3ArwDoV3J1FeZiTeK053c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ll6/aM1gyuiSMY7Idpk10U8jkFGXA8kP49vyxt8RAivzKJz8pXiwacg3iW1QPYAXplgjXyUoaKDRHfMFVZzrBHmOjXOVY0V+ZbwBxVm8B4XaAjKBfaE6EdAs4DvvRpLK2K2AB4wefOo1wE/QLb4a9ZRA9b4QG3jYhPt0nKF6qx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pU6rYWCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B315C43394;
	Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711059922;
	bh=fi7aHAiZniVdG0Ix/kdINY3ArwDoV3J1FeZiTeK053c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pU6rYWCzr8A6mOj6evcZPDgMw+U0Q8ZdcRHqVBXbmCT50VoHepPqcy3PeoHjNJ7r+
	 FbIA+feb6vdl518pxxFXDksNL6NRK4MYrmrKhPKRmdjl344nsRkK8RRuwtdZfIhC8F
	 scuDtXxDm0iifSA3ujktRdFFsgcPIG4en4Hypcgdl04pRaOnR9RF7jQkSrDi69BHDN
	 owBqUg81JhUvTGuQ2spTRvs70v3UfFN7QjiIcSTlXk+Z0N0UNd1pCZ490IVvqpFgCm
	 m6Ca754DcaOCXZ0LOHCPQP/H4y7/fkA+lpdrzqk3EvXwYdV32cvYa1HTQqG3+kkSyk
	 d+7jS5yOnDsqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22E0AD84BA9;
	Thu, 21 Mar 2024 22:25:22 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240321173325.3227312-1-kuba@kernel.org>
References: <20240321173325.3227312-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240321173325.3227312-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc1
X-PR-Tracked-Commit-Id: f99c5f563c174a49ea1cbf4754539b05cfde40c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cba9ffdb9913dfe6be29f049ce920ce451ce7cc4
Message-Id: <171105992213.29795.12770691855553503458.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 22:25:22 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 10:33:25 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cba9ffdb9913dfe6be29f049ce920ce451ce7cc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

