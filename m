Return-Path: <linux-kernel+bounces-84170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B6F86A34E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CE41F2AC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14E59176;
	Tue, 27 Feb 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="otVC6l8S"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C656762;
	Tue, 27 Feb 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075112; cv=none; b=nGkJOX41UNK+g8bAWaldAX+fivSWYFM4eoDmmZBobEsKpICmUBuVZvHiu2rs9I5lXcRFmP2oDbL60afUtzK/eMeBuXL81scJ/g2v/7Fj+HYM1ABg9rmY915u7NUT3kXjYoafT7NbMt5aM0/OV65Z0NfldbEuPi7tjIZG6+bPTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075112; c=relaxed/simple;
	bh=w97gAq5uciLvnevc4CCMhUzgcuwEpOO5fWctBUO7emo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kk7kB4Hack0ZjjQcsm/Rg2dobvD2SvlGMHHkJ8+LlOiZkUwMvnFQ2HA0j0nQRynx+hkOtD4X6aH4G8527/XXIdkJK25EkCu+Y/6mh/kuW78jODhbvU1D69aM1gP2ZKzSFgZpDHiQ4BFstMFitzQ4vUzX8Ec3kp7UkCgiu4icDOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=otVC6l8S; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10E95FF806;
	Tue, 27 Feb 2024 23:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcVFj58DWatdZCpW23XgyZzih45dzb/RtLzeIt09wSA=;
	b=otVC6l8SzW1nAz68yxHvaEK+AT6fcQ+BCgD97fRa4PXi5QdvjoqJ3NaOuphLD5FBjA3bTg
	QwCAvDyfEWwS2JlGVYd+QNXKZGdxAwL5xkrs/LeaDzUjUslyhucFWjLP5irSJjTki/Mjd1
	cxdzAf3jRcIKC0HINKtI6HSQwfy10X8PtwRThRYhMMfpZ+qV+P/GlT7U82ogRZdT7S5opG
	ox8zBHtLOgPYQ3Ed72PQarmPMOSDxB7WMbAlIYhlhdiNsZDQIBxOhG6Tx9IZXvW8S0Sa9W
	zB7PYjFppHX7+gq+pxkzHQlezmqNtErGXgNcydx+xQtlzkuYvHkjs3SPZbpRLw==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] rtc: ds1511: drop inline/noinline hints
Date: Wed, 28 Feb 2024 00:04:27 +0100
Message-ID: <20240227230431.1837717-12-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
References: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

There is no reason to not let the compiler optimise those functions as it
wants.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 39efd432e8ea..edb8d90812c5 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -71,17 +71,17 @@ static DEFINE_SPINLOCK(ds1511_lock);
 static __iomem char *ds1511_base;
 static u32 reg_spacing = 1;
 
-static noinline void rtc_write(uint8_t val, uint32_t reg)
+static void rtc_write(uint8_t val, uint32_t reg)
 {
 	writeb(val, ds1511_base + (reg * reg_spacing));
 }
 
-static noinline uint8_t rtc_read(uint32_t reg)
+static uint8_t rtc_read(uint32_t reg)
 {
 	return readb(ds1511_base + (reg * reg_spacing));
 }
 
-static inline void rtc_disable_update(void)
+static void rtc_disable_update(void)
 {
 	rtc_write((rtc_read(DS1511_CONTROL_B) & ~DS1511_TE), DS1511_CONTROL_B);
 }
-- 
2.43.0


