Return-Path: <linux-kernel+bounces-51484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B79B2848BC7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12641C21444
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6ED8827;
	Sun,  4 Feb 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mll3iZQO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED679E0
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707031117; cv=none; b=J4Njzxm8YlI5zAQD/r106b3i5eCwXgd+CDhDs4qy8yh+oXeFlqp9ntoWgHD7TJU/e8ozdsChAKeyK9PHnz37MnEi2ig1lSF1AHMaPJ+FkUwqJRR0vyJt8FTtcGXTiNqWLgVtFlcUG3pK7Cy/ZFT7xxD6Sply120X1AMgE5yC9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707031117; c=relaxed/simple;
	bh=68XQLYCLiYEoaQmO0gtwGV8KdnfHrx6PNavPSr/TunA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J/5qniHmq9TAW6484gtA0MpNN8Cu9uNz2KPsbU5JTmt03QNiycIVUH5kMHCrNxXR1RDlU09C5Sg4Z/vc8G+AE1WzwmrOA/F0fQy4N273NSjjEdkRTJcU4LpetFAr/eQpeSRKJtcBt74Lm8MvnRMlJdKEXWA5lnnPcJOVs252+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mll3iZQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3E19C433F1;
	Sun,  4 Feb 2024 07:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707031116;
	bh=68XQLYCLiYEoaQmO0gtwGV8KdnfHrx6PNavPSr/TunA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Mll3iZQORalPu8ePjIXEoCR8q4RYlgAG4DTKocZ/Tt3FGCSxraPZq80GfxYx8OM7L
	 ViNtucAGlb2CIAJoRO0RbyydJDyrUtEaaE27Br1pvzJsoU36Qgd4VemElidR7YgPZr
	 3vFxFxKcUXA4p0Az014xNz6lONp0jfSJ+JW+/OlCPxZya+TNTzrD9t55nN7N5yLcVJ
	 IBSMlAlhs3IubWeeICaClBhpJ8CsIrae9Mo0eKhwdqdnBCwJzH9iDD9UZkNd/anWG1
	 GLdEW4jOH6M8b6P1iYM4tFJfwXYsoM9h2ef/020xHUnD9UdSOU5fcDD3FH3B4pv/9h
	 gcTiVKfcVSZXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5072C0C40E;
	Sun,  4 Feb 2024 07:18:36 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for 6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zb5KEtfOS8_8EoUA@matsya>
References: <Zb5KEtfOS8_8EoUA@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zb5KEtfOS8_8EoUA@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.8
X-PR-Tracked-Commit-Id: bd6081be2251c3700eca8a7bbe071e1bb8cd2af4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a0c60a0e47aff4b414708a66fb11edeba6df7ae
Message-Id: <170703111666.23816.17722390874926746779.pr-tracker-bot@kernel.org>
Date: Sun, 04 Feb 2024 07:18:36 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 3 Feb 2024 15:13:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a0c60a0e47aff4b414708a66fb11edeba6df7ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

