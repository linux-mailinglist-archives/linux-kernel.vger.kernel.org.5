Return-Path: <linux-kernel+bounces-152305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931858ABC18
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47801C20B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812502837C;
	Sat, 20 Apr 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5ODwT6v"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C8B669;
	Sat, 20 Apr 2024 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713624942; cv=none; b=LhGxdRpAp9LV12GSXOks+6xJsViL5SH8t6dc3EAec64lQlxvOgot7lAQIkflDRSGtvEylEDulNiXXU3uJUd9j2uo83Z9KZVS8FVvF1K7RpuHto+5+GuJk0jHZwnDmU1Jkady13MUuZXV9AoHB+WNPtSIOaMfYfeqd3YABEGVKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713624942; c=relaxed/simple;
	bh=ekJW7KJXVKPQCwez4r6wuycFoYeoSEuzoVBX7feZMlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pazBJP1a3D2P6FqZYDlT46RXo4BBGigOr3wccR8Dp4DAik6plRl8f8PH/DK9bGETt7q4PixJg6Vfd3opJjQZMmau6z+GvLqcD1bb0pcSrta/G8/yhywewedL0K41YIgtas2oD5E+re6Q8GcRSWIuGuXuKCwIsO6/A7BmfgoLMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5ODwT6v; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e65a1370b7so29689765ad.3;
        Sat, 20 Apr 2024 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713624941; x=1714229741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6D/5brtB/j1UmXmMn650rTGCQHfQHPBfhqI0GJ/w+I=;
        b=j5ODwT6vuvzSV4hNDeUoFNtpiXl54EyGcqCrSAiBEnEEQ4O+7D0kUpN2VwUYS0tmHb
         Oa7p5DhK1MkssQJMQa9nPX+qExirvFewOXQOHoisd29msuVkomeVnlgHJM7f4F1TEW0K
         HmPgK2e50EDqrOpQ52uwgsdjS4l0k1W4RF1Khz8Cc9f30jNNBA2Jm+O4jWynwAWPPzIw
         KKYiLLuensObI+le1vKYtFecWW9a2XZLdp6GRVuTF1o6Hw5aRGUuanuYD9edE5yu9Sa0
         6V2kpHDuycS2xL3p6rEoBte/W0N2vl4Lel+SrQyDoWsxyzTO3ZOKSvMDpscVlRsTG0xB
         3wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713624941; x=1714229741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6D/5brtB/j1UmXmMn650rTGCQHfQHPBfhqI0GJ/w+I=;
        b=tP0vjT8UGyKYqbob5slmrVazcoa53N34jDU6swLLR3ejgKY2gfjqL0SbgkzmNkUeJM
         YApzyUuaa5g50vB3NYyK4mBthDfYQ2fO+AHZXMc8KVZ6+VTeNqRycfcpcHOFPBijkW1L
         xR4PzxvHMaI0TpGXRDyJUelHi3HqxWKZxpf2nIc2WXEr7bJoFVJPsuwacWC6TgL2LvwX
         +iJ49soPuL8kZJd27FwU7oOZc1vmGkK2eqLb36KF8Uf+J2WxnqtL3beaPKgDu70JwfDO
         6Mo3N5VpSnXA3sap+jljtt42fYqbaN/+FeAxqQIh2hNKpyt/RAAPG7Qd6AFp5Ge+6ASR
         LG8A==
X-Forwarded-Encrypted: i=1; AJvYcCUqUZuwikPNwNRRilOjjT7R0Yr1jkd7yZZxoW8Cr1AlHTJomL/pf1ATeWnzURwckqWlZc4F3Zo997Xrw+6TOw2p55a+PMJx9wc7c2x4
X-Gm-Message-State: AOJu0Yxr6HeOBpwMxG0zF9VwRBHiPuBo+U+6dF8TcFsaXBSO0HKXKgHq
	P7O4Iu6VMnTdK8Hn2JfWHGNAOuRT4SHU526W1RL57HvptBngQrBaJFro+ott
X-Google-Smtp-Source: AGHT+IE6xyqez7xCXfMfPO5WuyZi/RR1cQ1hxBPGo0FOR9F5KjSXo7xAIdHa9VUFnROSJ0EDf7bf7w==
X-Received: by 2002:a17:902:d895:b0:1e4:b4f5:5cfa with SMTP id b21-20020a170902d89500b001e4b4f55cfamr5850699plz.27.1713624940741;
        Sat, 20 Apr 2024 07:55:40 -0700 (PDT)
Received: from kernel.. ([2402:e280:214c:86:1d7e:e04:acd5:6aba])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b001e5331a0b91sm5138701plh.218.2024.04.20.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 07:55:40 -0700 (PDT)
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
Subject: [PATCH] remove identation for common path
Date: Sat, 20 Apr 2024 20:25:22 +0530
Message-Id: <20240420145522.15018-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added check if pointer is null and removed identation for common path

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: sundar <prosunofficial@gmail.com>
---

Fixed nitpicks in code according to comments received on other patch.

https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/

goal is to get rid of of_node_put,but sending this patch first to do one
thing at a time.

 drivers/usb/typec/mux/nb7vpq904m.c | 49 +++++++++++++++---------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index b17826713753..fe0257840dd5 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -321,35 +321,37 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 
 	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
 
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
+	if (!ep)
+		return 0;
 
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
+		if (j == DATA_LANES_COUNT)
+			break;
+	}
+
+	switch (i) {
 		case NORMAL_LANE_MAPPING:
 			break;
 		case INVERT_LANE_MAPPING:
@@ -360,7 +362,6 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
 			ret = -EINVAL;
 			goto out_error;
-		}
 	}
 
 out_done:
-- 
2.34.1


