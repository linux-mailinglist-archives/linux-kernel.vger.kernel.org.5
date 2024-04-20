Return-Path: <linux-kernel+bounces-152330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA88ABC7F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4FC1C211D2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8B62E3E5;
	Sat, 20 Apr 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTGWXk7X"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7BDF5C;
	Sat, 20 Apr 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713631776; cv=none; b=kISpHrxmfHf2Ia6N3M6BwA4CbHyNkylTeQVFQdVxwbxNTE5otOZ9wDTASM5rkjrRDddNqZ6uv8CbnB+/JUNU1mD9SKs+910ARx0PPLSGVc0zP6SDkSoaHHPKHpPF6QAaO39AVKlgVqZD2B9qG28x5sCvqo3Ut9m+2qolnEcyGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713631776; c=relaxed/simple;
	bh=AFcotACDcJRyu84ZjzhlmYw7TtupFwi8odfUPJq6o0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mAYaUd1orTxy0tokAxvmUwOQRHVQOeG94I7M2vyYftabj1hXBOYnb9R8SQJYq0qTc5GS56/dMcnxiC1aAuVCgVBPd/5+8eq7U3dca0Saja88nbkt0+0VgiaFf3KSbj6sO9+r5YkH0p+zYULb0cJ8QYB/qrvIYHRoInpOiVUK++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTGWXk7X; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2126747a12.0;
        Sat, 20 Apr 2024 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713631774; x=1714236574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFGGelLXC0bK4wv+0q4LIoOIgMei/K0MtGWHfMmN//M=;
        b=aTGWXk7XxPPOn0wJ+8T5EO6/T6zsJyjmolTpyVCicThdQKAdVSQKuZHRDPHll1MJia
         YvfFP8jrIMShBmgK1gXIzUXUTpZnwB8166ecdKkmKUeLDyHl765Iijj0SLUdFrHsfpvx
         PGw2lFZcN2r0odoKnDJwD4HZf699M8QIjNm7wZ311jMuxaIY4mwet2sKZjS3louQuk5V
         e4OmFNUNI5/8B7GI7Q6acFhyVeL9CE9/HRovsUETIwZbWtVHtwbJrKZMUuHM//vOaXL+
         phL4zPVll8gNnDU8EA0R48EFMcVxoQssk1EYLLc38KYDc/hL7z1TXUtcUU3DXa2bkPYx
         7Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713631774; x=1714236574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFGGelLXC0bK4wv+0q4LIoOIgMei/K0MtGWHfMmN//M=;
        b=Ure0hnsn7sRg6YScnH3hiCye1AI8+TLwHpTWBicttCyKwjjKiuHsDrtioas9qfsMms
         cQHcAiFpXQGp17srmSfm1lv+DROjjBHzVhTVQ0LQWo3R1+MbdW9eGuYzq/o1LQREHyC7
         cSmHYlv9PKxyAaTA5c8CD6jLANvSgPHffgqNTOegHSxNMdmjsbAvkL5Xpc8PjKPmjAbj
         yyfgb0awgeU347xz0C2YyqIFtV7a8Dt3Qw2KcxGQ1rClZeq9Qs2eQ3CqPsM5aP9A7QKt
         eF0DHGTHpCQvvnAUBQtytIoR0G8uDzG3mxx+LmbdJ6ZNk2sfZOFAw28HXb5YhcJgNrXz
         qEkA==
X-Forwarded-Encrypted: i=1; AJvYcCU/7GmdzDVmmVTVopiZ+0jLVyIlrDzyxMohXybTk9sAB5zmwk+Qvoi+9pErE4+870+dX3NA8w44RbIREd6gOaG8hJckLgT/2lTaFlw2
X-Gm-Message-State: AOJu0YyCfKxzZh1GrcTJvwkD/CFI/BmPxkWoEEgcsp1Q65D81eXwKl/9
	Fv5coJUSOetFYQXM5mq+d9kPWQ6kGnAUHt2F4GkDt2boYPq1Dzco
X-Google-Smtp-Source: AGHT+IGa9YqH/kSK4pUjp3OHiz/++Bqslkz5SaAy7qgTBZzgLrYVAY2dQGNELVaRh2GbRWu/tQXvaA==
X-Received: by 2002:a17:90b:1894:b0:2a2:7494:15df with SMTP id mn20-20020a17090b189400b002a2749415dfmr8425231pjb.9.1713631774445;
        Sat, 20 Apr 2024 09:49:34 -0700 (PDT)
Received: from kernel.. ([2402:e280:214c:86:1d7e:e04:acd5:6aba])
        by smtp.gmail.com with ESMTPSA id nv5-20020a17090b1b4500b002a2f055e52csm6563433pjb.34.2024.04.20.09.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 09:49:34 -0700 (PDT)
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
Subject: [PATCH v2] remove indentation for common path [linux-next]
Date: Sat, 20 Apr 2024 22:19:27 +0530
Message-Id: <20240420164927.15290-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added check if pointer is null and removed indentation for common path

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: sundar <prosunofficial@gmail.com>
---

Fixed nitpicks in code according to comments received on other patch.

https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/

goal is to get rid of of_node_put,but sending this patch first to do one
thing at a time.

Changes since v1 - fixed the typo error for spell from identation to
indentation

v1 patch link - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/

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


