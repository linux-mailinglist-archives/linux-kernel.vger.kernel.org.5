Return-Path: <linux-kernel+bounces-102172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A346887AF08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0CAB270E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA5B196BC9;
	Wed, 13 Mar 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1GMs6Yk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76004196BBE;
	Wed, 13 Mar 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349392; cv=none; b=PpY5QdOT0ZqAUC66WRnNaP2+aw6qAPeBGE0B68yIAem8Xu6vuA35GmhR5z3AC/FEBESHa50WALXhrJrGYiOuTr80w89VBnwxRBHnudxqxJjcl3P30lc/w9D9l/U7Rnc5lubtB+GKYUYuxThJbTYyx6oE5PFAgIbEUMAazfzNnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349392; c=relaxed/simple;
	bh=slHpnqlIk3zauj27BL7j0LP+J6FG+jOLTyDmyXWeOg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aO3Jx8uJWnh++WntfT9R6KQ0ZTedISTJIEgBj3NfCuiT+TB1MrmgQhLfdMbYrvSAjpryzsC3jRh/RBytfEpdILIoHIY66qQjYs7Sj6a2gQFI1LteMPstXaOItz8lpFyJHl1v2h8jLc7WCMDj3po/73hAQx1Hs6rYSCgdvzClxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1GMs6Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8015BC433C7;
	Wed, 13 Mar 2024 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349391;
	bh=slHpnqlIk3zauj27BL7j0LP+J6FG+jOLTyDmyXWeOg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1GMs6YksQ3dQ8iFq0thYHU/qbtmTmb65wY3cVshlKY5/fZJtY3Mb76d2DEEWKQtT
	 AnihBZn3rpSN/P8aAmVqkbjUKK2d2D2GBgpCExXYwFeXIyeczkuvz1Jzsk6UeJU/4B
	 Z44LRJ7w1NVuJlUx85Pkru7kUY6DKT0GgcvuB6Hrm7K49IJQien5uPqeAdEYC9DGM7
	 2HbqwzgGpZ6hH/MCjMw+kGAvW4bWkcMxM/dEJ6/lsp6qnVV/jUFj7NxvMuHJbDXxeW
	 WFA47DBIab/lRULL+fsrWEnzhai+LzLcSkQ/KdwSgIRoVx2qPA19FRH2Zk22ZV00KO
	 FrnVD3/xpLFag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 51/51] Linux 5.4.272-rc1
Date: Wed, 13 Mar 2024 13:02:12 -0400
Message-ID: <20240313170212.616443-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 56e53f77c0378..cafc630fc1470 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 271
-EXTRAVERSION =
+SUBLEVEL = 272
+EXTRAVERSION = -rc1
 NAME = Kleptomaniac Octopus
 
 # *DOCUMENTATION*
-- 
2.43.0


