Return-Path: <linux-kernel+bounces-58929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3FF84EEB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0851728B66D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF50D52D;
	Fri,  9 Feb 2024 01:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PyAYN5U3"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E495221
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443938; cv=none; b=plJDYrWGdyHVH6Rj3EqiJjeWejJuo8E7G5ndcrGFQBOzI5EzJbV1y2SlOykYe+xAPL6SiBiAD4k29GRr8pU8s4eNJJCig7W05YBntACEu3ca1SWBkTuSZ8hgDIsRwBMowVU8+Z0qEfSKmNiTsgsMhQh3zq3BpIhT9x+BbwSx/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443938; c=relaxed/simple;
	bh=5q5yd0uOzVxkeI+Nq9RNmm4/GaFC28QWASMAQnWNh2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8rCFT38jY9si9STyv6n16LGgbBQVo3JP6lZl/zpAjVcQha4cerrZaDSFVShsHIslvVwM4fLpD8w7A2EJHc/NcB784Lu24XDtfR3cuXPysoDOZ6j/s+Z9M/p9Ijsx9VDqH9tlQyVuoQ4imvA0PfOfMUroqrlSEHDq/8Mi3I0dII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PyAYN5U3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=zEZx/yqiZ/Xq8ZRCg9io5VCbk6EfjKXq2ELvwxjA4iA=; b=PyAYN5
	U37seEOUaME4GyephpapNYQLQOE/26KcINTRci+ysjZP5cC6uPGTdzLWL66xSywE
	RAz0rb9p4ROA/vO5e+0zrzUnKj0I8EMe3GmJkEJpmyFt4ynDXlsg23fwtIOcSkXm
	3VZiJ14PeesQ/rcHos+xy69pKbgss7MIUNK0KDkbA88SGuHuJI4w34WRcyGEOXFS
	7oLAMdkdJ+ORyVRQrtUqTFd+PSzVCUREyrZ5Yg5lH5cFWKJ6nX0NMUYOIaB53NFH
	RCIKd4xuOFOnfS2XSzzUjd8usPauzsxqnvmcMSwd8m9j42kmmu/QVYWpKUaZtThr
	C7VAgrWztdj+dlog==
Received: (qmail 2792400 invoked from network); 9 Feb 2024 02:58:47 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Feb 2024 02:58:47 +0100
X-UD-Smtp-Session: l3s3148p1@RRvHROkQmLMujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mfd: tmio: update include files
Date: Fri,  9 Feb 2024 02:58:19 +0100
Message-ID: <20240209015817.14627-12-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove meanwhile unneeded includes, only add types.h for dma_addr_t.
Also, remove an obsolete forward declaration while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/mfd/tmio.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 4223315d2b2a..f71d4e507dcb 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -2,13 +2,8 @@
 #ifndef MFD_TMIO_H
 #define MFD_TMIO_H
 
-#include <linux/device.h>
-#include <linux/fb.h>
-#include <linux/io.h>
-#include <linux/jiffies.h>
-#include <linux/mmc/card.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
+#include <linux/types.h>
 
 /* tmio MMC platform flags */
 /*
@@ -59,8 +54,6 @@
 /* Some controllers have a CBSY bit */
 #define TMIO_MMC_HAVE_CBSY		BIT(11)
 
-struct dma_chan;
-
 /*
  * data for the MMC controller
  */
-- 
2.43.0


