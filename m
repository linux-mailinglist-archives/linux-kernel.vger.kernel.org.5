Return-Path: <linux-kernel+bounces-157399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10CB8B1105
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCD8B278CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBF716DEA4;
	Wed, 24 Apr 2024 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1ddCwIm"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BB15F406;
	Wed, 24 Apr 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979651; cv=none; b=bPJSGAcI2O6ZXqBbILXKbZESNkpERboLNPARFulFuqu3cA2iFDtpAIyKxpNcq7Tpdwl88O7NG29Wlan+qN7244Vo55Sj5rz3tfpOv5t9FPfvUQyuzmP0YhD0gKixdh3ljsyPP+fYC1Bwf9zuAxdzNcpbqhibTkb3ikF5gIMJ6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979651; c=relaxed/simple;
	bh=FZ+Pgkqd8y2D123NpFglQwHxbuuQXAB//6dAe54EE0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pAyHclvyOzCth2ki1ew4SUAPf58kXsFggGVDgg2q9bXzrGziCmMlgw7/pd3MTPToe7m8Vxxtt2dHcz/E8dYgXet/d1q+VeWnlgMv7UIjgnnGUiXwX7h7ia57g1NVzWGi5f6d25qcptgR1QEzdPHfzDCoxy7O9JlIxxKiYnA5ICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1ddCwIm; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23981fd7947so89081fac.3;
        Wed, 24 Apr 2024 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713979649; x=1714584449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5k9S8O6G9jVgPuO7ZGH5fOvLZYQkQseFM2dTBLGUM0=;
        b=O1ddCwImRhUnEM40Mm0CDAHA19E/8o9m6tf0LFRUnsa/Osk7fRNF1YbHpBcx7mByUT
         h3ejDEM+iiIwZGPhX2IapXS83Jp3aUWe7o6U3sMjrTktoxSp7O8xYREj/0NuM9zVI4xt
         fyFENF44iUcZvTRvJc3F8m4hxnisMAW5ovCuhESHx1tmNFoeaIPbyrpp0NkuLDCw1OIj
         +8P+EY7IUjYPEHV8rB2++fdg53GND4csYw8XFD+GCMz+/nmnKlKd5Qo1Souwq6FZv2IA
         3Mtlv+ZQxddrJq9Hj02+3SIdg9JKguFfJZHLYNx/on7u4geiYDOQLcTstlZz3vB8Fio5
         UjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713979649; x=1714584449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5k9S8O6G9jVgPuO7ZGH5fOvLZYQkQseFM2dTBLGUM0=;
        b=mfEtm+yhMvAQO3sOcjQ3EibHJzRa0At1TjSAy0ReY26d2bsYyv3Vc7CNxt7T1wX9ji
         U8l+7dbMldWs5MmeD4WLgk0KWHjqKz9Yboj50k2lbIATaO8yp7iQC2Sybxy0Ff8bTh2h
         Z3k4DWzE+ZESgHKsiN0z1jqEKr0k9cBf909BGo3iIgUJT97+QI1b6jqyT0V7cXB4J7EY
         S3Pov5B/vAwyG6BAwH1t6JfaqVFyXGTOSDw6Xrz6HcftU9WzJqpoXDyCP3nIBnU+Kamy
         DBhrRz6KJEQJ2nMueAG1DYSqFZgwuR5XoPawQQqUhQDAji+PGXdfKYEt91xR3Al6Xumh
         H6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx4O+i5E1VdCZ9B6QhSVJ93PTFvBkk39cOg5qMKNysq9eP/pnk23BsEBldUV0kqhtrlx979bbrSXmm+KR0UjKgh/qNmudOiMMWKCCM
X-Gm-Message-State: AOJu0YxPqpLihpYaa8uFltem3sDCKj3NILVcaFmKKj74LeDwDWZ63Or2
	L2R2A8pniXzhWXZ76POhGSEp932YUshdbNXfcnOOZ8qURECN62OPoCABTneY
X-Google-Smtp-Source: AGHT+IGq+CD2yc6iE2F49K/1lSrAgQkSS+cJ/lmM3REMu4sTgHzp0h6BjboZRz1Cu9Hq5x7K+HoYmw==
X-Received: by 2002:a05:6871:33a5:b0:22e:d092:28e with SMTP id ng37-20020a05687133a500b0022ed092028emr3319138oac.33.1713979648957;
        Wed, 24 Apr 2024 10:27:28 -0700 (PDT)
Received: from kernel.. ([2402:e280:214c:86:cabb:5565:1952:762d])
        by smtp.gmail.com with ESMTPSA id u18-20020a656712000000b005fd81ad7835sm5964963pgf.58.2024.04.24.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:27:28 -0700 (PDT)
From: sundar <prosunofficial@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@pengutronix.de,
	christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	sundar <prosunofficial@gmail.com>
Subject: [PATCH v4 linux-next] usb:typec:mux: remove indentation for common path
Date: Wed, 24 Apr 2024 22:57:16 +0530
Message-Id: <20240424172716.3407-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nitpick, Mostly common path will not be indented.  so rewritten this 
function to check device_node pointer is null and removed common path 
indentation.

Signed-off-by: sundar <prosunofficial@gmail.com>
---
Fixed nitpicks in code according to comments received on other patch as
below:

[ Nit, this function should be rewritten to not work like this, the
"common" path should not be indented, but only the exception (i.e. bail
if ep is not allocated properly.) ]
https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/

Goal is to get rid of of_node_put,but sending this patch first to do one
thing at a time.

Changes since v1 - fixed the typo error for spell from identation to
indentation

Changes since v2 - Shifted the indentation to one level left for the
switch cases as per coding style.

Changes since v3 - Added descriptive subject for the patch and checked
from and sign-off having same name.

Patches link:
------------
v1  - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/
v2  - https://lore.kernel.org/linux-usb/20240420164927.15290-1-prosunofficial@gmail.com/
v3  - https://lore.kernel.org/all/20240421011647.3027-1-prosunofficial@gmail.com/


 drivers/usb/typec/mux/nb7vpq904m.c | 68 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index b17826713753..f7a00b388876 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -320,47 +320,47 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 	int ret, i, j;
 
 	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
+	if (!ep)
+		return 0;
 
-	if (ep) {
-		ret = of_property_count_u32_elems(ep, "data-lanes");
-		if (ret == -EINVAL)
-			/* Property isn't here, consider default mapping */
-			goto out_done;
-		if (ret < 0)
-			goto out_error;
-
-		if (ret != DATA_LANES_COUNT) {
-			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
-			ret = -EINVAL;
-			goto out_error;
-		}
-
-		ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
-		if (ret)
-			goto out_error;
+	ret = of_property_count_u32_elems(ep, "data-lanes");
+	if (ret == -EINVAL)
+		/* Property isn't here, consider default mapping */
+		goto out_done;
+	if (ret < 0)
+		goto out_error;
+
+	if (ret != DATA_LANES_COUNT) {
+		dev_err(&nb7->client->dev, "expected 4 data lanes\n");
+		ret = -EINVAL;
+		goto out_error;
+	}
 
-		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
-			for (j = 0; j < DATA_LANES_COUNT; j++) {
-				if (data_lanes[j] != supported_data_lane_mapping[i][j])
-					break;
-			}
+	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
+	if (ret)
+		goto out_error;
 
-			if (j == DATA_LANES_COUNT)
+	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
+		for (j = 0; j < DATA_LANES_COUNT; j++) {
+			if (data_lanes[j] != supported_data_lane_mapping[i][j])
 				break;
 		}
 
-		switch (i) {
-		case NORMAL_LANE_MAPPING:
-			break;
-		case INVERT_LANE_MAPPING:
-			nb7->swap_data_lanes = true;
-			dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+		if (j == DATA_LANES_COUNT)
 			break;
-		default:
-			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
-			ret = -EINVAL;
-			goto out_error;
-		}
+	}
+
+	switch (i) {
+	case NORMAL_LANE_MAPPING:
+		break;
+	case INVERT_LANE_MAPPING:
+		nb7->swap_data_lanes = true;
+		dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+		break;
+	default:
+		dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
+		ret = -EINVAL;
+		goto out_error;
 	}
 
 out_done:
-- 
2.34.1


