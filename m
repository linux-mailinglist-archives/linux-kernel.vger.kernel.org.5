Return-Path: <linux-kernel+bounces-109485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB65881A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B511C20992
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2048613A;
	Wed, 20 Mar 2024 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaQvzNn8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495285C58;
	Wed, 20 Mar 2024 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710976285; cv=none; b=Mwi5/NNVFIlxwO7xEDKmEqdlYxnYmtY57q9APCh+3LrKppweK8XgpRckPzl+OtmJmQVbbVcJPr6CEGwiAcp6zz74PQikuDZTOIyCUcPcKwjJkEZc+LluX/daIy96q8i1UJILpu5Zdo0/A8xqgBExEZkBU0avoVPm7IKO0y8dX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710976285; c=relaxed/simple;
	bh=hY4R2hNqre5PaNjUAc298/E8unbBIQeHIEpQ+oypxew=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HByfVB0fPYGJ45wu64bCaSpxo9Cq5gCVZGd1T6564U1Q3yUTdzwOq6db+q5mHORCOEuQkM40ooSbhQDNT3lVYb8vlo+Vaz3HAUQ6w6k4+KmLLJOtqnVqAcZTgR/k6cL7LtbbMDhvvlMtoBhAXRMrNx1b7ofEKCnLtUs+eQcGkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaQvzNn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE4CFC433C7;
	Wed, 20 Mar 2024 23:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710976284;
	bh=hY4R2hNqre5PaNjUAc298/E8unbBIQeHIEpQ+oypxew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HaQvzNn8hz2CXt/IATufi39kZQ7zhlpBbMI8SZv/0ppxf6syTmTbpXP9EZD2m8urW
	 XCI941yu/oSrePaSYnbKU6JYbM4mWeNdKyy1OdopDft179Eoo7XlV66gcrRk+c1nNh
	 XlbvYtL7FvpiVcp9EmR01YFilbH03tbmAbLhyXaUswvl7Q9V3gltf7oHCCe+DqQLP8
	 oSMP04gpCSDrgmiUarE0QvJ1bljjTxYqxwxQDRayFgE0iu7Z/2I/6M5SfX14U2Iys+
	 rwHgRDGf+ZoqvDCTxHKRGh4c2raGMcE6o+fBWUHBaGvEzghvgbsfy5RG0qhmQJ6fo4
	 5guVKD6O7OEZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5C54D84BB1;
	Wed, 20 Mar 2024 23:11:24 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <87v85h5hwo.fsf@meer.lwn.net>
References: <87v85h5hwo.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v85h5hwo.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.9-2
X-PR-Tracked-Commit-Id: b8cfda5c9065cd619a97c17da081cbfab3b1e756
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dba89d1b81df749711645bdc201ed67223f35830
Message-Id: <171097628480.20612.10225980927857358809.pr-tracker-bot@kernel.org>
Date: Wed, 20 Mar 2024 23:11:24 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Mar 2024 04:14:47 -0600:

> git://git.lwn.net/linux.git tags/docs-6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dba89d1b81df749711645bdc201ed67223f35830

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

