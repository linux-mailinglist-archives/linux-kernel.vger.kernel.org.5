Return-Path: <linux-kernel+bounces-141509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48E8A1F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661D528854D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE9117C6A;
	Thu, 11 Apr 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq+BUUua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996817BD4;
	Thu, 11 Apr 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862561; cv=none; b=ZgbaEJQDnobN7q7VBfvW7qKf0dyCqfJN/vtzAkhJO6AKyp8ig5TBUaXcca8K1p0MlQBKMKWtT01xMrteJRelZRR10zVmt08XE1HJLx8eg4/NL9vqEgOYd+32b3nUdMnQ414tfGizuR7WZvK/YbApeZKX1x/VMfuMrFdRS6c9Y9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862561; c=relaxed/simple;
	bh=BHC7zYRMjwFCO+jH+MlVDp/eBcPB1tCFsigfLJvxQ4s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G7W5i6y+/3nYKpbHtD/9qNTC1js+WpA3WIMQ8SQ2LthpWTlM2eRrqf1iHGrYYtp3H2BrOGHJhwCpMxXa6KoTP/r6YPUea3TcOYpAa9cyfK3VC/BETaAFhapGUnybPsnvuuEc1Ypy7lE2xndqSG3dCdD0/X4cxHuNghQTgdCgPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq+BUUua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BEEFC4AF09;
	Thu, 11 Apr 2024 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712862561;
	bh=BHC7zYRMjwFCO+jH+MlVDp/eBcPB1tCFsigfLJvxQ4s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zq+BUUuaWn+BpRg0SlMdH+1iJPCysJjfqEpCZigohRszcqdAMgkGI4frh33hdnFQF
	 mFitNWPdqc0VylwQAg5Zl/ZR0aUkYczPHOv9CdKN2UogJ0qwt5Gr+CMAnvymrJ3euQ
	 BMcTpVUMFHON0h6GUJX7Ti0vKne+UDEf2LDUtBlyyD4uqK5APvsHMGsq4spbMDkUGg
	 cU1XCNMUKkkgRxiDgox/91sCldn8XYzvF7/cOtaIfaH8FkhSZMM/UnchHNV3PIjVl9
	 SyWFhFTQBCDEevRx3/ntc25fD8HNFOFQilNX//ht7iBlbkrhay2ygsW5HdfVb5E+es
	 RzlOU4dZge6mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 087E2C433E9;
	Thu, 11 Apr 2024 19:09:21 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jH8rKc3=rNzDdWOobGb4xCCjK46eYoE3U729yRwpgCFQ@mail.gmail.com>
References: <CAJZ5v0jH8rKc3=rNzDdWOobGb4xCCjK46eYoE3U729yRwpgCFQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jH8rKc3=rNzDdWOobGb4xCCjK46eYoE3U729yRwpgCFQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc4
X-PR-Tracked-Commit-Id: d7da7e7cec9868b24f0e39298156caf0277e82c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00dcf5d862e86e57f5ce46344039f11bb1ad61f6
Message-Id: <171286256103.2172.6895591074258411583.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 19:09:21 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 20:06:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00dcf5d862e86e57f5ce46344039f11bb1ad61f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

