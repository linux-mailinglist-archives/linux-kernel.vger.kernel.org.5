Return-Path: <linux-kernel+bounces-102183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05087AF34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B161F27840
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C060DD0;
	Wed, 13 Mar 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3XCw7ch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21860DC5;
	Wed, 13 Mar 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349455; cv=none; b=gDPHZFsF3qPxJheFIfmu6k4bV/VVTAeciQaSvt2jPlrhF+5vHVV7IX0XoyzOIuWwe4iEKxrYwrULizXHIQeudThi/jXF953GO8204+rdE6c25UJX41n9az8GYV8ihczuckGfgu19zQn6o3xw7zEk8dbcnphLfORXcPEUoiLqoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349455; c=relaxed/simple;
	bh=BDIl1cvSvW8S5vsuKRez53UPEBZIo1SuJDpx//KJG80=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MhXolrbe3vkaPxg5mLCRj+omxPZ2ZHN3+AHTCb2+tG/tMXwNAcAUYvY7hmTzYJMUZvFcBd0nDC8ZGABaaohK+HDN6SPLAjnf0gmj3dxjaWwqxouOC4YzZUrew3fA/weRID7piFjO1SA6ONxIoO2OqQONTEyeJAA04CXN4pwMYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3XCw7ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0768DC433F1;
	Wed, 13 Mar 2024 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349455;
	bh=BDIl1cvSvW8S5vsuKRez53UPEBZIo1SuJDpx//KJG80=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S3XCw7ch4FWZO4iZofb5SAQh2+hLI4TRmE7kkeumdaVEnivrwbjdVrPSR1paFiXIw
	 xwfDbk538KNcgGUMzGybBMU/4jTQDSG/iDoRZb3ROSdn0gBOHgxLC6YmUHdisIUmWk
	 weHq4JE0V5KU0mC2qxr6vizHY8u/tB2C19KFGLjKM72DP9I7aI+USgVMxobxGM0zAP
	 vX2HKCU5E8rI57AQAonh4wwrNHIXFLL1Fs/PaOj0iMWOQFjJ6DCJZKeqZE5vAJh5Xv
	 tAyZohFaiNQweuFZjXnPjZW189tRV1JlhOPj0Ihu6OM5dMESqlrRAdRDwxLg/6MXAv
	 ORf33uiGIV3Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2015D95054;
	Wed, 13 Mar 2024 17:04:14 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <Ze7KrT5is81WGTRT@8bytes.org>
References: <Ze7KrT5is81WGTRT@8bytes.org>
X-PR-Tracked-List-Id: <iommu.lists.linux.dev>
X-PR-Tracked-Message-Id: <Ze7KrT5is81WGTRT@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.9
X-PR-Tracked-Commit-Id: f379a7e9c3b5c325ff550e911ea42092295695de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c9c2f851b5a58195ed7ebd67d7c59683d1a02bc
Message-Id: <171034945492.7471.16989171136485157697.pr-tracker-bot@kernel.org>
Date: Wed, 13 Mar 2024 17:04:14 +0000
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 11 Mar 2024 10:11:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c9c2f851b5a58195ed7ebd67d7c59683d1a02bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

