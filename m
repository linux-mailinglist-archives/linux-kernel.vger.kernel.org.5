Return-Path: <linux-kernel+bounces-58862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C084EDF1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6CEB28EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D49E52F96;
	Thu,  8 Feb 2024 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+xo+lV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1752F6A;
	Thu,  8 Feb 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434173; cv=none; b=ERSMmCxpAs1nvMhOqgL6XpgkVdPFeVH3QiC9LLW8YhBVWl9VqM5XyYy0mrKRu6GraznuVT0dorIIeKq6LW2Nzs1GwkjCYp6EiKQUS7YkinRgiVJvzHtfxyEUin3MJFdV4q44W+D9xMWGcSTLL6Rg5HNoxD26OmtTZai1j+jIcMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434173; c=relaxed/simple;
	bh=WwRsAGRyMOkVqfIJK6eEDbJqNUNUm6yEHpdbYl/k6kM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VCkMRH19xgnNz0g2M6yETlXwPv7+ipiDOStfkDr6wI6utr5u2POoIyopxKbNkPHHpDtV9Fwn7AvR/3j/R/6Z1PSLmV3BuNdQ70T5eyrJoxzYdLc8F0KygtbxPYAe2eqemJPXx1YW1GRbQvvqXfqTcueWMxVf6sczgAJ3gVwnhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+xo+lV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4C50C433F1;
	Thu,  8 Feb 2024 23:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707434172;
	bh=WwRsAGRyMOkVqfIJK6eEDbJqNUNUm6yEHpdbYl/k6kM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e+xo+lV2pZ3CfeaaatcqP/pNk9YdxeFlvHMX8z67WJ9SOJwGZXYe/eqglgixyBX3z
	 wWZ8Kxdz/5ZINYqtV4s73Ji+VdxZCFy+WFdYlH/m2ki19Y+vJFDbSvo//RCXJwGBcG
	 yftLAv93J13GaNDf1y8pn51t4cV/JO9Z2Ey247lVGAfQGSN5/47KDGMMhElRdpQyfD
	 kP7Dj8i70ZGAfHtVQ0vXZFfb+8PyKdup7Yg/02xs0pwrLhl7iEaWzdlIv0W0/fr3F9
	 pKOhnYUjSZxKUKpMdv1+xm3fYUn1a1ndjQ94I8p9QNMEBEcMJ/86qZer8Qo9NQQnI8
	 jxiQ79f34Yo6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C16FEE2F2FC;
	Thu,  8 Feb 2024 23:16:12 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.8-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240208151237.48692-1-pabeni@redhat.com>
References: <20240208151237.48692-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240208151237.48692-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc4
X-PR-Tracked-Commit-Id: 63e4b9d693e0f8c28359c7ea81e1ee510864c37b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f719a2f3fa67665578c759ac34fd3d3690c1a20
Message-Id: <170743417278.5821.13222503852884384390.pr-tracker-bot@kernel.org>
Date: Thu, 08 Feb 2024 23:16:12 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  8 Feb 2024 16:12:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f719a2f3fa67665578c759ac34fd3d3690c1a20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

