Return-Path: <linux-kernel+bounces-116352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA648889E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A31F378C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE229CC3A;
	Mon, 25 Mar 2024 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6+T3Pw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC7E185F0F;
	Sun, 24 Mar 2024 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324383; cv=none; b=gzH/HV6I1Sw0tZMHTZEIQJBQW4Mv6qEwDwqoDd7K9aDPyYU2zGc8EJ56BHuG75i9afBEELQZRgzT9urnJOaslayydRixPhYxTJR2bSC3TIof9of/fEUIQVOB9lJJRHNB8g4gEmKNd9A+9l1sg4k/6UEZeTJDxvSzgE0Pn0NCpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324383; c=relaxed/simple;
	bh=YXHz/LDJi9Lq/bWF7mF1aEuybGMh23jcPOzyOV1E314=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehiZQPi0QCp/r8FdicLRsTQKSq0Q6ERZVNAwGaTtkT6hjlgq/Ju5q1mC22P21BDPOcOKPppkKfEZqCogVhIZBlIZm7fLoSGTRuZf/jq8bWJMxaX2squ2RpW0MUpqqoL/jWiHNkZWo4VZInfFB+SrbgaU+VZf/Hdwv/YZASy9ynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6+T3Pw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549ECC43390;
	Sun, 24 Mar 2024 23:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324382;
	bh=YXHz/LDJi9Lq/bWF7mF1aEuybGMh23jcPOzyOV1E314=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6+T3Pw8ggEjit/bgK60qzalMe4l6aIuSppLzCJbQ/nuhR8xB0SDE/sTTI+ortAjn
	 H644tU32D93w60wVKdvf4gHK/C1+h3v4HF1l/69l/uEcnk+I5uicft5Yn2f/VZOsxJ
	 ad29iOtZi/oVNuxWjjSo6qqo4sS3lOn6ARjWqVoUpJidgQcol5z1bu/koO6wrlBlOL
	 W7+Z+tBmnZYCQ5C/mkkRrj8stBteZOvQ/jv0RiEg9wwY9o1+XZIH2Bl76F9x/08Kqo
	 YTnETHRCA+UMBhPFFx4uvd/dUvAPMbWV/ourQT1tjM8ErWwDmVrlGuRVt47olDGNPY
	 LBUPHZmLtbpXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 148/148] Linux 4.19.311-rc1
Date: Sun, 24 Mar 2024 19:50:12 -0400
Message-ID: <20240324235012.1356413-149-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 96be210bd42b9..ee1f1c3c00e4c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 310
-EXTRAVERSION =
+SUBLEVEL = 311
+EXTRAVERSION = -rc1
 NAME = "People's Front"
 
 # *DOCUMENTATION*
-- 
2.43.0


