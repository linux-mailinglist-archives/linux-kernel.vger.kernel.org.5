Return-Path: <linux-kernel+bounces-125878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE73892D59
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DF9B21A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC97481D3;
	Sat, 30 Mar 2024 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfFAcjY0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C545013;
	Sat, 30 Mar 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711832099; cv=none; b=fFwhavABou7GwPxkIxmk2NuhWePNQa7fhfVJmiPIt++aHbj8wbGTqmJfUfhvdR5b3uAvBQzlVkXIgv9hXkxXHm9K+2eG4Dqur63T42xrUjgJjyiqolc7twp6T3nRlz5DB/4F8H80dwEhvrVDi+OYxoxDstUiLETW96wg0UFh1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711832099; c=relaxed/simple;
	bh=OvB05eC0srBrl882gqpsOkFD1GR6tK+CjYUURbWL3bE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HA1p7P9oHu3od5a6F8fCA11J9dYSLFhiWhclxyWt9LIT93lP0EBW4lOMw0Nbb4CMBeeQFPBufkmjAUwbqAHdl3StY3s6wbF77H/pyq2S9OaaGyppX/7v3s45WQUMSKEDS2CS4mC5jyOnfFJAhgdxN9za7QgIrwK27HgD1jRPCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfFAcjY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7289C433C7;
	Sat, 30 Mar 2024 20:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711832098;
	bh=OvB05eC0srBrl882gqpsOkFD1GR6tK+CjYUURbWL3bE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hfFAcjY02/srwRJIl4kXS8gMjxtGByTGurxxR45Y0ufh5t86ivB3aYukJdhWb9Efk
	 ce74cy6n0jX/kDAG30kEe52lN/34QC1R5iHmCQoyCsC6TpDEzJ4b81NDPBWFt/AQWk
	 1xj/qeCL37XbnU++FmRpC3zLHSII8JkM9V2Ee1aIe7DPbn9FM5UMgCYroNPMgEGfxo
	 2o3epztAnMHPlCsTjuYcwzvA+jS25ANHn69sLAfzM4xFNdLz/4y40HZxsEVRDT8pmo
	 Ws1J8V7g/SBBN0xaXo5SNjS4o/mOFiUF/LU6q3wfjz7H4g8bCyfSedHChZqMiv+8Sk
	 o2I0YIa0Qk4ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C08BBD2D0EC;
	Sat, 30 Mar 2024 20:54:58 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <c2a8563efc26259bb0a852f5b781e3dd303e7a3d.camel@HansenPartnership.com>
References: <c2a8563efc26259bb0a852f5b781e3dd303e7a3d.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c2a8563efc26259bb0a852f5b781e3dd303e7a3d.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: c214ed2a4dda35b308b0b28eed804d7ae66401f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe764a75cffea6ab128a40b5ad3df25b63959723
Message-Id: <171183209878.22117.18244298603818673753.pr-tracker-bot@kernel.org>
Date: Sat, 30 Mar 2024 20:54:58 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Mar 2024 13:30:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe764a75cffea6ab128a40b5ad3df25b63959723

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

