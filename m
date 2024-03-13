Return-Path: <linux-kernel+bounces-101863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29287AC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A1B1F22DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D1768EC;
	Wed, 13 Mar 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SokRgDHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202A76413;
	Wed, 13 Mar 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347901; cv=none; b=igPWLAoMBHT1cARcmbbrzFylyhlAb1HVLWf0y6ShicEwqzyku+GvcMA6akBHnWj9hqTWRLEmWlUlUcx+8mijhqLWVKHsXy2wQ5T2+/94LBZ2tW+isegjZw+WR0zooEOYhJ51/5/a85d4G+ZqWB6KSbVrNFPJE3JvpqMveJx3pHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347901; c=relaxed/simple;
	bh=H5j48NwWTBr0ccYAm9PK0/r1sy0rhsuYf88kq7qMgto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ii/G56UcOLGqiqdRdZqU0+rMdkYGQr+VaKD5WL3FYC+p8WiatqMPmPN4nOxJuwTcdwQVM5iDDtN16yBS8nfxtdYZZmLYK/EpMjQvaT3rG9u5HtVB30AOkww9W2RPbQ63jCgXDWCUHnGYXUb9QxdDgAoxYO4YhoGl7sKpGSEta4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SokRgDHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA70CC43390;
	Wed, 13 Mar 2024 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347901;
	bh=H5j48NwWTBr0ccYAm9PK0/r1sy0rhsuYf88kq7qMgto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SokRgDHUSp1ZLtttOisutonP3AQnhBTB5M9EZlruSxmf0AeRTTKTdKvr52P6LOJyl
	 PzI422jpZFXjyrBjKMaE84DGEclya1Jr3QBoejA2k/1O+JUuBk9856BkMUloQZtBk0
	 HrmUDm4Oh82TEXirWqCaCA9jzUbC1tss186kCxVqjDSW1uxIj7/kY0ASXenbnFmQtQ
	 jIMoZgqrUod9rqc3aWEMHVH6AcMvXVPXVFjWj8hhYRUEzeUL1rpMTYN1KnS3qMqzF0
	 uqnbkOMXPgLorgI1GoaJ550Ag/QVEdRZZ174ZWi0A3OEyaBPRb/IaprMUCSIp6a+5C
	 EyzLIzqZaf+CA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 60/60] Linux 6.6.22-rc1
Date: Wed, 13 Mar 2024 12:37:07 -0400
Message-ID: <20240313163707.615000-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a36819b045a63..48267900c8032 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 21
-EXTRAVERSION =
+SUBLEVEL = 22
+EXTRAVERSION = -rc1
 NAME = Hurr durr I'ma ninja sloth
 
 # *DOCUMENTATION*
-- 
2.43.0


