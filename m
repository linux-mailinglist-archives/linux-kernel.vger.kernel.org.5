Return-Path: <linux-kernel+bounces-28855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CE68303CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265ACB22DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38341BF4B;
	Wed, 17 Jan 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTX0pgfA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F81C28C;
	Wed, 17 Jan 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488310; cv=none; b=lDDeAhEZNaw1LHo9vVfBxWfS4kPjgC8OfzJ2ECGKYFw3hNG12Eb0ZGYD1lCuCapNRMs6JFHJxCe2wvif6XyXFiX7P9RyOVLM/DBALY2EPNr8EdiC1S9fA3Lvx2vsvK6P6Lty2KfSuR5SvSPGpueBksEQ+yVUAliQ8B1gwSedczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488310; c=relaxed/simple;
	bh=7ndPbhI5d5AQDciViVHBmYZpN1QDnXUWhOlTjOcJJYc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=HVK+H2UjHMw8tASYDAXJSXgu0UCjlipVfa5Ylu/lXeDyfSoDCB1qy7/yrwsqoFOGdDlNo1uuebEHwcq4M2OQXFbMfFxaAkj6yCMstXgrw0de47sXnhM++Ub6nfd/l99aV4If/NvKfwkJjv1+yMhsCK574u1yhT5d1l1s+Lx8wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTX0pgfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40503C433F1;
	Wed, 17 Jan 2024 10:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705488309;
	bh=7ndPbhI5d5AQDciViVHBmYZpN1QDnXUWhOlTjOcJJYc=;
	h=From:To:Cc:Subject:Date:From;
	b=bTX0pgfAY8Jr5Jpn94oiN/PqUK5smgKzYjG9YMKNQJLKslfomfST2Gowbip+ZSMIM
	 22S35rDUc1owxrKWWIOc50P/qdKGJ5WVcnUBOY0r7/I9FgqITVcw9oaxiVizW9PjZu
	 7ZLdo4EjS8Lk8RochcdPj3vtOgo7bN066Xk9z937QeMXY0/Iv8KwLpN3v5E+U+iVUi
	 HkqnvwRBLWm8dSQrFdoT61kQdXalthjLk/fivH603sm1sDscUqavp1GQW1Tg4qFJG+
	 kVLWFnU1q3SdaRTnBIquNaANcPkv6czz+ayUXLOhuzL0yddmG1E8MpM02qFs31yWIH
	 LyxBzDmIONwVw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: asahi@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Arnd Bergmann <arnd@arndb.de>,
	Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>,
	Asahi Lina <lina@asahilina.net>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: apple: mark local functions static
Date: Wed, 17 Jan 2024 11:44:10 +0100
Message-Id: <20240117104448.6852-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With linux-6.8, the kernel warns about functions that have no
extern declaration, so mark both of these static.

Fixes: 2d782b0d007d ("gpu: drm: apple: Add sound mode parsing")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is for the bits/200-dcp branch in https://github.com/AsahiLinux/linux,
the code is not yet upstream.
---
 drivers/gpu/drm/apple/parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/apple/parser.c b/drivers/gpu/drm/apple/parser.c
index 44aad9a64f9a..ea9f40bb7de2 100644
--- a/drivers/gpu/drm/apple/parser.c
+++ b/drivers/gpu/drm/apple/parser.c
@@ -694,7 +694,7 @@ int parse_epic_service_init(struct dcp_parse_ctx *handle, const char **name,
 	return ret;
 }
 
-int parse_sample_rate_bit(struct dcp_parse_ctx *handle, unsigned int *ratebit)
+static int parse_sample_rate_bit(struct dcp_parse_ctx *handle, unsigned int *ratebit)
 {
 	s64 rate;
 	int ret = parse_int(handle, &rate);
@@ -715,7 +715,7 @@ int parse_sample_rate_bit(struct dcp_parse_ctx *handle, unsigned int *ratebit)
 	return 0;
 }
 
-int parse_sample_fmtbit(struct dcp_parse_ctx *handle, u64 *fmtbit)
+static int parse_sample_fmtbit(struct dcp_parse_ctx *handle, u64 *fmtbit)
 {
 	s64 sample_size;
 	int ret = parse_int(handle, &sample_size);
-- 
2.39.2


