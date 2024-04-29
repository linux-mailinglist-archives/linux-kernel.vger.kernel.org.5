Return-Path: <linux-kernel+bounces-162696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA1D8B5F31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA45EB2292F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EED8593F;
	Mon, 29 Apr 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToXBhwQk"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D484E1B;
	Mon, 29 Apr 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408665; cv=none; b=YE7jFgrQnhzg1/SedOzXOCJp/Y31NkeSWOOx4Qpy8AWytIPFjc1GXjP2HOc+slu90I4akCiBUr6goRz+EVAsUIXmIMztL85qHWPephQhN6KgNOhy0b92Hj7oABWCk1rRrEoYVRG7fnBatrcbS/pQ3L9+iq+UIItxWKDPunjLhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408665; c=relaxed/simple;
	bh=OeUx0WulkbmAUZTlM5p+CWWRdM6Y3YIPpKpm4CojpHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnQmQvdMSEXSW4992K/n+Cbps4steuHTBNiOPK9WjfGoYV9fWNq50UvdjwJsTFtgsZQ09ZqnRAOWalEjRnxDQxWiO0CXDjok/7XrNru+bP5jmsJcRkp8pPenVijO6c1qrtrwWnFizwH5OOQdsUVKu9s0hfXSOrtADlexK5Z7EH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToXBhwQk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso33584905ad.3;
        Mon, 29 Apr 2024 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714408663; x=1715013463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nh1QMqmY0q3lT8X1D2igxqckoalEPLGeYeihyTrpcK0=;
        b=ToXBhwQkPQmTheD21Mqkvdkl2AzXXbuVAk1D2j1v4egELW+5juOeIYptI8RX8PdeuG
         PuRO4f9/I1RJCoToAgTNIujXnSwtmR/vd7Dhr0U3Kg9ujy1CxJP4VDMFSjTiB9oYl562
         QuKS1V0NqMgn4WSSioAYVADEYvBMv9xBj8gC4dOIegmwVqBsPaTeccuJzazZjIsj/4aG
         W73A75gh0ImGNYC6Tyhj+d5kbMYWANufq7LQZYPhcmXzV/Wg1ur+7IAvJcZJhuC2/tjk
         eYE8tqUG7v2fAZDqRH93ppgtX8A+8hZkioYllzRsnNhUwKnbqMZgO5vXM4R/xPi1RLEm
         bYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408663; x=1715013463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh1QMqmY0q3lT8X1D2igxqckoalEPLGeYeihyTrpcK0=;
        b=jTiH1YGuF3URxtGAs7Xfxa3OWcQ+ZsHrQdd2LxAt9/29FzxtCpGDfSj6JdW27pqZNu
         0H7rTaUUVpoYxGlsV6mD3W5hwrQnDsQV7iVZKdrw+sInkje1Z7cO6DA0O7h17CQWb9q9
         ZHVtGSuTC3/XMFnoFhHL4Hdes519mP2CQZxpWlQnxIoKDwsSn3IzLkYUPv3BeOmmjy8S
         +Fon+4oZ83x3eC6lk9jhNnuhKF5f32Q4/V8spLMCtAzW3e/6hans72EvPHlpQXGpqhSd
         dcJN1jDzTVR6tWuLeNeqFsC24xpQfa4ro60Gakd5xqlU6s46DLppsw6nVityD7p2NPmU
         oLyg==
X-Forwarded-Encrypted: i=1; AJvYcCUDPe1Pi7Dt4YOHnuO73ffcyUCD+8ZfXzmMO045LuuZw6cMjvqqbRu88TMKbIT+wSJMBuCYyUkd6Cu0HIcTIRDd8b+729ko1y/Y6/Si
X-Gm-Message-State: AOJu0YwiDaK2JMODgJJw2zgFIFEBvoNOvkZGsZoUL0e4mk2agimlzBY7
	2H5+rIBbfT8QWHuJi6fQ/sXyqyT71giegL5XXElU+j67vIcjGz/y
X-Google-Smtp-Source: AGHT+IGBZ46HBSYk/xVb2U8JQjbSO6DNoTWbYpVh0rnlkofznPRkH9XvOBXYRt0Fj4c0gn/RnB740w==
X-Received: by 2002:a17:902:ce08:b0:1e5:62:7abe with SMTP id k8-20020a170902ce0800b001e500627abemr9677273plg.3.1714408663207;
        Mon, 29 Apr 2024 09:37:43 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:9744:8dfe:8ee3:9c0a])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902ed8d00b001e4464902bcsm20539571plj.60.2024.04.29.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:37:42 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: benjamin.mugnier@foss.st.com,
	sylvain.petinot@foss.st.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	R Sundar <prosunofficial@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2 linux-next] media: i2c: st-mipid02: replace of_node_put() with __free
Date: Mon, 29 Apr 2024 22:07:36 +0530
Message-Id: <20240429163736.11544-1-prosunofficial@gmail.com>
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

Changes since v1 - 

- Added missed out __free() marking in mipid02_parse_tx_ep().
- In mipid02_parse_tx_ep(), In error case, return value is always -EINVAL.  so
sending the -EINVAL instead of ret variable value. 

Link to v1 - https://lore.kernel.org/all/20240427095643.11486-1-prosunofficial@gmail.com/#t

 drivers/media/i2c/st-mipid02.c | 37 +++++++++-------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index f250640729ca..bd3cf94f8534 100644
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
+	struct device_node *ep_node __free(device_node) =
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
+		return -EINVAL;
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


