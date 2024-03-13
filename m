Return-Path: <linux-kernel+bounces-101800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482687ABB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB15DB24568
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8967C71;
	Wed, 13 Mar 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV3Nfd2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E167C53;
	Wed, 13 Mar 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347656; cv=none; b=htRSqf0aBF4iT9bqJLbDrrfhYBEziAtqHijqJn92G2pl51BcpVBmHHG5a7olyGBxx8zh6UwwkL8Chud1doaRU+8AvI+YCdbIemNeN+3Apl6jXZOJU4PcTBtdjKlqJuf6iPFO6f3uko8XSWfGk6OaKB4QSEd/EXYqT5zQqqzwpdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347656; c=relaxed/simple;
	bh=4DGnZQ7Br5zPmZQv56suMtojECsF+HYSfWTB+x7PDX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcHOCQ2x3shehjGIKfvhewmi6nYclSvQnVh9ApW0z93NbHEI9WRqdoeEgOTXCF2EBIo7sF6QqpwNRVacmPUEAbFkf/TjFlaYdgODqBMR6qmKuPRoNWIL2Bkk+V6IqifAFtnK/u0JBHlJuopDy8Ome8BXJIX+NLRIhnLbFqWnkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV3Nfd2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC5FC433B2;
	Wed, 13 Mar 2024 16:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347656;
	bh=4DGnZQ7Br5zPmZQv56suMtojECsF+HYSfWTB+x7PDX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KV3Nfd2fRFvw/Ayi9C8YsBRrXjYVdKq9lthD9aH1yf2FxcRLeR4yqmVxM4EI2Dlat
	 uzN/bEfOnIRyasFmH5R9rrFjtXG/ZGnU5DNNVsjp6SJ7Y+xedObNo6SmI6F546RYqO
	 1QiFXjzKGOOw+Btc0ot60fy6O6aywKLW/E70LV74Ne+ir/dlPXSmbfOsYbTct/5NGa
	 TfcqCIRR/oCNQdh5aZKcQ1s8EsqyEbibexjU7cttQIEza6kZ/XbL7MmheBpZtgID+S
	 UkJ5zFFjdN/W5+UgEsPtl904HSkikkrOHO4eqXjQep79o6dxEqTjepPTTH4WQ6li/3
	 Kl057xprnF8iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 61/61] Linux 6.7.10-rc1
Date: Wed, 13 Mar 2024 12:32:36 -0400
Message-ID: <20240313163236.613880-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f1a592b7c7bc8..76b44693956a8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 7
-SUBLEVEL = 9
-EXTRAVERSION =
+SUBLEVEL = 10
+EXTRAVERSION = -rc1
 NAME = Hurr durr I'ma ninja sloth
 
 # *DOCUMENTATION*
-- 
2.43.0


