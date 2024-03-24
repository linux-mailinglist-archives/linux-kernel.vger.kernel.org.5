Return-Path: <linux-kernel+bounces-114005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE03F8887E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27FC8B246DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A943143C7F;
	Sun, 24 Mar 2024 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQCUDu59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451061F4194;
	Sun, 24 Mar 2024 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321152; cv=none; b=MVEEnblDJJKYzWpkR4e63YPZq/D3a+jUcVX29srGnAGzbgVjeyzumDD/XzuUPW3EfpwivjWEOi66QbF2p9398fFMOQ74XKTpcgrwplg9bDScwU+Xixl1BRFGBfgYQSHv1tyHA005rZ9S+YMlJR5Noo0gph92QXMomsytK78h2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321152; c=relaxed/simple;
	bh=CfxFWkTfsBESS/GwFKfzk3MraKGs6JZMMEDMjxEd+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNyl/+xIUD79WKdBvjML5IYWyXsrTqVpc4e3hNcX1ZFpAXRYjI5wVBD3f5tzTYFxZiZdLyNNv1CriINqMsaA+ikYzq+NMzD5v+LKoWdmbSBKm1GupYVaSVz3DJQzcYaMUMi2vn1pXgqBAd5U+ruU5iwQf0iI4vzwJtPsAHG5YdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQCUDu59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A57C433F1;
	Sun, 24 Mar 2024 22:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321151;
	bh=CfxFWkTfsBESS/GwFKfzk3MraKGs6JZMMEDMjxEd+Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQCUDu59RBjPptqathrfZMa23reMfo0AIm4I363+IaJhI+xQkwdSV+nPr9UEcmjLR
	 Hykwyy3tHvxUBYVtgwtEligaGatKomyAaLAdFIG0cZueKpmAPHwRfxXPv7si8+587W
	 RzwspMSHA7hmpsYA0xK3n0QxJIy7Kp7p97fmlhiiL2sk5AOFFQskTsB3xwSKPfptFp
	 bunGrGH2bbEh2qqeoTFIZBYCqPeXXnw1i+VL9FuLTebRuwEwC1iZ/K6WNPy6qwh7NZ
	 JSggacnwFGizMbu7tLJVadQBD5omDhmKNHf2xwsUwtqe2ivR/xvdMACAIDG/BVX4qm
	 fRz5lU/gMevOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 713/713] Linux 6.7.11-rc1
Date: Sun, 24 Mar 2024 18:47:19 -0400
Message-ID: <20240324224720.1345309-714-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 00c159535dabe..c5b534f459dac 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 7
-SUBLEVEL = 10
-EXTRAVERSION =
+SUBLEVEL = 11
+EXTRAVERSION = -rc1
 NAME = Hurr durr I'ma ninja sloth
 
 # *DOCUMENTATION*
-- 
2.43.0


