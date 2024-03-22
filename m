Return-Path: <linux-kernel+bounces-110823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A661E88645D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA801F22A34
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17710F2;
	Fri, 22 Mar 2024 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHBOs5SH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B81376
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067559; cv=none; b=sm9hXlTLU7J1dyyMj2UHp+I1mkL/KktKrRoEfWJ6kOCOrSPKS8BN8h7Ph+qZ7YhTtLY9xU242wY8gMpvecpiD1agDxRG/ijzlN8uvQjEqawow1J/EdjQAFYPRHeIBEzKoLhKhfmKQ1L8/i03YHKkEVMDcGLYjxR+RNq0hC4wrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067559; c=relaxed/simple;
	bh=UJ+IvcfplAEeZ4WEQ3DOOJwWhbS+5sC5iaRrAlOv4fc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kgKYgUpGIhOahkXuPn2mkvvMpjLjJLE7L5W8KXBBaz761VJy2oDfpGXSuFSpGs46K06rhWC97K6owUVoWfo/xIJiAJYx97lFvLx16Vg0GPIOWKAtt4MfW1SgTp1noeiyFCtjNJVKZDDDc6rsDnBOkykERyrIWZXFcSLBOXudxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHBOs5SH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 896C2C433F1;
	Fri, 22 Mar 2024 00:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711067559;
	bh=UJ+IvcfplAEeZ4WEQ3DOOJwWhbS+5sC5iaRrAlOv4fc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HHBOs5SH0O4cbT+99O+YVg0kluFPRVLhPacoMR9kdF4sWjjGvyRqsAMqBmADUKnuk
	 kX0GNKu/Ovnkl5M8nr5IETpsh7CN8hlVf6GcdnFvpogNoFPZmY7DNVVXZos3ZCgkGR
	 D8S3HOls0sVbDWmukwVEWvgS2cSEu3Qnq+YM5X1FeY9e+WJUfTr5tfXcng7esv1cY2
	 EIC2ajDpUWe7Qn140CRAZRZDS3RxrlEL0YW0Gp8o5YbJc0iPH6JeZuszwX+IqnHz18
	 oT3fBOaT0nFdKBZ2kdoH+iI3Tyob8+fjFzR69xdi3rEfbUaOiCWYKu+3eIkOZSZld6
	 V7BBr3GkNe8AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8375ED84BA9;
	Fri, 22 Mar 2024 00:32:39 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZfzMKqtxAfHwHY3p@arm.com>
References: <ZfzMKqtxAfHwHY3p@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZfzMKqtxAfHwHY3p@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 1d63d1d9e5c5cb2e7c7ca75751a5eaf67c5623a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 661dc19066ef0fdcb2db3e2542c45744a4067e87
Message-Id: <171106755953.26768.8786185219134503802.pr-tracker-bot@kernel.org>
Date: Fri, 22 Mar 2024 00:32:39 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Mar 2024 00:09:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/661dc19066ef0fdcb2db3e2542c45744a4067e87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

