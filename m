Return-Path: <linux-kernel+bounces-160986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989618B4571
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6103282B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA900481A6;
	Sat, 27 Apr 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn4/IQLx"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31794597D;
	Sat, 27 Apr 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714211817; cv=none; b=jmM9xya3omMebwTSXokNNfzB/i3SFxb9PMazJaPp4GOpE2yCEiopRGfZA7DhLSj4ow7VMt3wIMlR6LsTFcSMoOzcGX82thsPSCfIn5Pp1FhjpAvWBVgE7y380VpKqaS6PXphe9J20wejtwzz0Hr6MCwPZ+H1dBFI09oSTbZBlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714211817; c=relaxed/simple;
	bh=0HEcIOTfzaBktR7t0NC6etqJxV2GQPY8AhiX3O01uQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AVZgH0aNnXiTSqGbVFLZfr7aXZf6kP0xCdywjre7raIYE1o3p0P2lpNdvXeyt6g4xt7h8IlZD+GyjAPeOWB19/L2c1FIJqwn2syfM6cWtTCAuIh6p1c9PaOkg9cb2wfyHthw8YyyaELrBtzKOSEWcinA++N6CHjCVVQshJJkeME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn4/IQLx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso1191097b3a.1;
        Sat, 27 Apr 2024 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714211815; x=1714816615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02ZdnG7Kw8AagMUQyEdCYdECl3YVQmndomRdbBYfSEQ=;
        b=hn4/IQLxzGZB4sPjLhk3nKzh0H2ps/QKVOZ6e63DL5qf+2A/64pQtQv+SyO/kAKBkl
         /YwdCJlq3usnD0qd0+xTUjV4+pp7Lpw3IlVukXhNPPcxnxLi7O56GJ7Kg0SBJn307D3t
         8ApiQSL11QID+1jl2XvYwXOS14ifvJVVn6AdZmVQUtaR453Uosf/5OvTSLsZILXGF9bi
         RgxrJ4YJnCQganNHC5mmumv9BV7b70GXDjxFUChshcupkio2k2lg/3o0aV4w8x41BOnJ
         CBWC6FQEedBBX0HhDsukCWp4LV7Nyy14KRwnomc2X3uxlA1LJhhyGiZHznHuZhKATk72
         IA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714211815; x=1714816615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02ZdnG7Kw8AagMUQyEdCYdECl3YVQmndomRdbBYfSEQ=;
        b=ga1QRPLIl5VA4WPf+Mv/QK8Fv9T57nsgeFd7XaPVUvIvNMpagOTwAZDYdBtYXO8ZsO
         VR2dw/9t42KuIf1IYZkXZD4olLXN0ap7AfpsQtAOHlUPW499H1f8B+0rrQnwGquEmc0U
         bWe+MTN8CVzAAmYx2mvWEUfl9ZoKsq56liigVDBiD0zLzyeubmdAuaTq2Ov8UQv15EYV
         OstOQD8VGhPBGxNQ+LI/oB1BJ9wJy45MXM92SXSXZXJ7Gyca2wS0qWKhJpnIMwNm6zwf
         A2WwUuVeUCh94p9cWQwNmCh7UXzefhugapdudKXSp1pn70wR1YdKTCte4HVlNyOdPRfX
         w6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKHhC0LdEZB8G/qHRpGTQII4xeGV9XobzXhbefRlT8zDbSJWfSwoXJdUyGtXVbk1pbLRhghESOUBNtp78aGQ7/PcNQ9SnX3VjM2PdY
X-Gm-Message-State: AOJu0YxrfkWQPd+ELSi8lCTIJoPYAa8FSp7rPD06gjpoY36S83l10QJc
	nNksZ9k3K+TIvpAckBHStBZJhATQRKr/HU3M8Zrvqs/ztg3/KRJC
X-Google-Smtp-Source: AGHT+IFrQuKV0EnRjdy/TpD4BmECdIY2zSCW+1Nt0zvtVl8zC5WAdFw9W/+c1TKbZPVenzFm/S7CcQ==
X-Received: by 2002:a05:6a00:4a09:b0:6f3:e720:cead with SMTP id do9-20020a056a004a0900b006f3e720ceadmr3105259pfb.5.1714211814903;
        Sat, 27 Apr 2024 02:56:54 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:b9a9:7e98:619:b206])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006ed0d0307aasm16070342pfu.70.2024.04.27.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:56:54 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: benjamin.mugnier@foss.st.com,
	sylvain.petinot@foss.st.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	R Sundar <prosunofficial@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] media: i2c: st-mipid02: replace of_node_put() with __free
Date: Sat, 27 Apr 2024 15:26:43 +0530
Message-Id: <20240427095643.11486-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cleanup magic to replace of_node_put() with
__free(device_node) marking to auto release and to simplify the error
paths.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---
 drivers/media/i2c/st-mipid02.c | 37 +++++++++-------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index f250640729ca..d42a306530f3 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -715,31 +715,28 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
 	struct v4l2_fwnode_endpoint ep = { .bus_type = V4L2_MBUS_CSI2_DPHY };
 	struct i2c_client *client = bridge->i2c_client;
 	struct v4l2_async_connection *asd;
-	struct device_node *ep_node;
 	int ret;
 
 	/* parse rx (endpoint 0) */
-	ep_node = of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node,
-						0, 0);
+	struct device_node *ep_node __free(device_node) =
+		of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node, 0, 0);
 	if (!ep_node) {
 		dev_err(&client->dev, "unable to find port0 ep");
-		ret = -EINVAL;
-		goto error;
+		return -EINVAL;
 	}
 
 	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep_node), &ep);
 	if (ret) {
 		dev_err(&client->dev, "Could not parse v4l2 endpoint %d\n",
 			ret);
-		goto error_of_node_put;
+		return ret;
 	}
 
 	/* do some sanity checks */
 	if (ep.bus.mipi_csi2.num_data_lanes > 2) {
 		dev_err(&client->dev, "max supported data lanes is 2 / got %d",
 			ep.bus.mipi_csi2.num_data_lanes);
-		ret = -EINVAL;
-		goto error_of_node_put;
+		return -EINVAL;
 	}
 
 	/* register it for later use */
@@ -750,7 +747,6 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
 	asd = v4l2_async_nf_add_fwnode_remote(&bridge->notifier,
 					      of_fwnode_handle(ep_node),
 					      struct v4l2_async_connection);
-	of_node_put(ep_node);
 
 	if (IS_ERR(asd)) {
 		dev_err(&client->dev, "fail to register asd to notifier %ld",
@@ -764,46 +760,31 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
 		v4l2_async_nf_cleanup(&bridge->notifier);
 
 	return ret;
-
-error_of_node_put:
-	of_node_put(ep_node);
-error:
-
-	return ret;
 }
 
 static int mipid02_parse_tx_ep(struct mipid02_dev *bridge)
 {
 	struct v4l2_fwnode_endpoint ep = { .bus_type = V4L2_MBUS_PARALLEL };
 	struct i2c_client *client = bridge->i2c_client;
-	struct device_node *ep_node;
 	int ret;
 
 	/* parse tx (endpoint 2) */
-	ep_node = of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node,
-						2, 0);
+	struct device_node *ep_node =
+		of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node, 2, 0);
 	if (!ep_node) {
 		dev_err(&client->dev, "unable to find port1 ep");
-		ret = -EINVAL;
-		goto error;
+		return -EINVAL;
 	}
 
 	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep_node), &ep);
 	if (ret) {
 		dev_err(&client->dev, "Could not parse v4l2 endpoint\n");
-		goto error_of_node_put;
+		return ret;
 	}
 
-	of_node_put(ep_node);
 	bridge->tx = ep;
 
 	return 0;
-
-error_of_node_put:
-	of_node_put(ep_node);
-error:
-
-	return -EINVAL;
 }
 
 static int mipid02_probe(struct i2c_client *client)
-- 
2.34.1


