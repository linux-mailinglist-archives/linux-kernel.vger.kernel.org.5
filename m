Return-Path: <linux-kernel+bounces-139162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDED89FF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84901283FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F99C17F396;
	Wed, 10 Apr 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReWBIiYq"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177916F0DF;
	Wed, 10 Apr 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771905; cv=none; b=A6CalG6xOlKVXI/+aKshHX+YZeXAOoGOpMMXWQmMoy1w/U4oePquklR0u7dH7w3IHMWkHsyI4b7XiR0qoNiyGAK8ZMTY+P9DxYcIabQdJVcMZ2Hm/hKfYqRxwCP+Md41cyHzxTLm9NlEvAyk0ZvL2lZnSRV26NAZlWyBIJ+bjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771905; c=relaxed/simple;
	bh=n8peC+EIG/a9HUUKrSv5qENbNMLag8eMAMK0Sjz/42E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eze0VNxQ1R/99q3gwol6SSURyrYTikQfUFpf3B+j7iTcpeS/ieoNZPITgbbkXtx67rz0DBqtE0P61P4Cu5eR9VIDgU97hKXMLfbq8FF/SHLTEYiJ7HGuHzTzkg87fikLwXrHVnO05PbzmBIPdZGFAuTtIz2lx71RtcH+lM329aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReWBIiYq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dff837d674so59052035ad.3;
        Wed, 10 Apr 2024 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712771903; x=1713376703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BA53vZ23xswdlLcoUk2Y4AIOap+yNyuRbnAkk9erdXw=;
        b=ReWBIiYqhesKfclMeBxx6SpRUBBRJsefLa0gBpCXOBVzmRh3NK6EcVQ8hMQtopAxBW
         ohsdKl0cigyA7HYGJygOf4edD1cX3Zg4THPX2IhooPrQ7UuTWwcD8MUqLSstHhRqM2YP
         shNR4CkVVRW2pBKNb+rxJyNFXTiMhUv+B2/Q0oDUVkUtktIDW3hUpaQUUDJRzAS/usZO
         pTC5nrMK+1UH1Vdf2rkhWRK6OaCdU3BemzAbFjq1d6sfm/0wSLDOR2ab1hgo6W8lsDmh
         9HS6mnxadFTQjkMZ26gxdpAaCZUvMMWqpM1gU/U9sxpgsNs2tS05Qs/V1Q/Cj0xT0Nxx
         gsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771903; x=1713376703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BA53vZ23xswdlLcoUk2Y4AIOap+yNyuRbnAkk9erdXw=;
        b=M+dZkZwMWjZ6FWUeyBMb8V7WquMaiMwFErp/mY+htwCF/tpwRupkYoR6O7ih3VA0ln
         x+sh97PX6FBn/DYvFXCIlk2vOx5Km3yQCRfV2jcEUrcELIEfIAfonBVJ4TnnSbPJFFXa
         OvnUEtmq8qqfzMVhD04QiOiBberroXIpDrUmHD7iODoyaQIRhUjp0MRbltJUMT9YN3gv
         v5AryeX+vT7BRB4HAu/VruiSMR+goJzeWiayX0r1/UKTDRLg7OnnCr9ufeJgmSyoDxoq
         IGl1NkBCaBlBO1DmhGiobAOU4RF6YW53wDWDdDppbsEi72iuKB7SgnkBUwfJhZobykAL
         G4Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUnryN119IPdNS6U+dObyNboZLseIctR/B/qdv/ukBcOqEP67Fdw2yAfLqyIZtGUeIfJR1hpVsq4HeIJysh5iTvmUXy0PK8Nwxib2FIyaiO5Kc/FK3R1wPtRrM5fzwgw2KaOl6vXpO2
X-Gm-Message-State: AOJu0YzVmoUWt2Hrkq9ee3/qeMwGYH1aUKbh2oIC3YC9X6Pho+O1sQJ6
	f78Owu8ckZ7KgTOzNtWOGRCcCjgAZPzXHy34LEGaM/hNgr9RH7zt
X-Google-Smtp-Source: AGHT+IExXRj4eP1ewSxSK1VXgMlrx8JCFj7bH4tSSbcsZqkY1ZQFD9EitLH/4+lFJvTk8AXLI4WAMQ==
X-Received: by 2002:a17:902:aa8e:b0:1e2:7fb2:b0b with SMTP id d14-20020a170902aa8e00b001e27fb20b0bmr2922327plr.68.1712771902653;
        Wed, 10 Apr 2024 10:58:22 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:5ab4:9b65:f1e:96a9])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001e2bb03893dsm11030746pld.198.2024.04.10.10.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 10:58:22 -0700 (PDT)
From: R SUNDAR <prosunofficial@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	christophe.jaillet@wanadoo.fr,
	u.kleine-koenig@pengutronix.de
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2] usb: typec: mux: replace of_node_put() with __free [linux-next]
Date: Wed, 10 Apr 2024 23:28:04 +0530
Message-Id: <20240410175804.5195-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use the new cleanup magic to replace of_node_put() with
__free(device_node) marking to auto release and to simplify the error
paths.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---

Link to v1 - https://lore.kernel.org/all/CAA8EJppfzXEzzrQ_11O94MVn2dhcF2kGd9RR8ctJ1GmK=6C+ZQ@mail.gmail.com/

Changes in v2: reverted the structure declaration to top of the function.

---
 drivers/usb/typec/mux/nb7vpq904m.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index b17826713753..3009a6fc7fdb 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -315,29 +315,27 @@ static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
 
 static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 {
-	struct device_node *ep;
+	struct device_node *ep __free(device_node) =
+		of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
 	u32 data_lanes[4];
 	int ret, i, j;
 
-	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
-
 	if (ep) {
 		ret = of_property_count_u32_elems(ep, "data-lanes");
 		if (ret == -EINVAL)
 			/* Property isn't here, consider default mapping */
-			goto out_done;
+			return 0;
 		if (ret < 0)
-			goto out_error;
+			return ret;
 
 		if (ret != DATA_LANES_COUNT) {
 			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
-			ret = -EINVAL;
-			goto out_error;
+			return -EINVAL;
 		}
 
 		ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
 		if (ret)
-			goto out_error;
+			return ret;
 
 		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
 			for (j = 0; j < DATA_LANES_COUNT; j++) {
@@ -358,18 +356,11 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 			break;
 		default:
 			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
-			ret = -EINVAL;
-			goto out_error;
+			return -EINVAL;
 		}
 	}
 
-out_done:
-	ret = 0;
-
-out_error:
-	of_node_put(ep);
-
-	return ret;
+	return 0;
 }
 
 static int nb7vpq904m_probe(struct i2c_client *client)
-- 
2.34.1


