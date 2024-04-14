Return-Path: <linux-kernel+bounces-144329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D68A44B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7861F2127C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B3C136E1A;
	Sun, 14 Apr 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQUpbtkC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5A134CFC
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120483; cv=none; b=Bd258e71J1AnYeS0HZ3bfUNmTIJqHXKdMR0RKI1ajHyZoPjvS3tvLeR1MzbunoIcdRSN5W9nM2dgahd0iNItB8fp7tbUvqJ0PcsEkUL+BHRUldm35v6pF5hHpO+iB6JLCd4iQ+5o++M9dIbPJ4wYUR2+O6YkssK4ZspnzMdm+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120483; c=relaxed/simple;
	bh=SgX8S3ANv517QHnfSXKXjm6sp2flErw58nweeOrtOr4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D0gMuVB/mem6bAOVoto4S2WpISlGOl8lH2XdeW7rpogzxu49fPMucpzoTZCuf0uVlTc0xE3Cs07LEE8TdmIjikj2rqQ1VHzofECZmM+F4K4YM+1SH+VpxKYV9d6FLJTLSHC7rgcua2l2Xtl09EIpurRjLPleac7V8enGu9SGoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQUpbtkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 563F9C32781;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120483;
	bh=SgX8S3ANv517QHnfSXKXjm6sp2flErw58nweeOrtOr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nQUpbtkCxIa1NFUO8PYpGBF9brp+NARf/mS3CUlBaUnl7bWlLZ6U4lGnMaKllgAh7
	 eMCevNy0dNJNe4lh4xBvyZg85bAVYi58GAC4pWJQCLghLfBCN87ngYogG6nXilROb6
	 ob+ELCAuFlBZnPIHBb5BRjwMN7pA3TmIGeQfZDC0z31r+9z5/EeCypvoXg3ueE5Qkd
	 KoF4LPmvdm1Gwxkn8n1Dk9ZBNt4MZ4WHsCjPVEnSr0oYOeCt/JD2Fh1+GU6lmjjMdX
	 257zG6r/Dh48FcCvaqxvRnSKTykERmPRzqhGDuuG/ADdkhJhikNKJpLJ53edrfFhML
	 jcIRk1gkwk8Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B52BDF7857;
	Sun, 14 Apr 2024 18:48:03 +0000 (UTC)
Subject: Re: [GIT PULL] IRQ fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZhuLsx9u+UYKpBZc@gmail.com>
References: <ZhuLsx9u+UYKpBZc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZhuLsx9u+UYKpBZc@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-04-14
X-PR-Tracked-Commit-Id: 80e9963fb3b5509dfcabe9652d56bf4b35542055
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c28275e7434e8e7c3e7cd366ad03b9aac55f8b67
Message-Id: <171312048330.2589.18115851770905246738.pr-tracker-bot@kernel.org>
Date: Sun, 14 Apr 2024 18:48:03 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Apr 2024 09:54:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-04-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c28275e7434e8e7c3e7cd366ad03b9aac55f8b67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

