Return-Path: <linux-kernel+bounces-139012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C92D89FD74
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF6F1F21CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731817B517;
	Wed, 10 Apr 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0LhBut/"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858517B501;
	Wed, 10 Apr 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767980; cv=none; b=G12Thz0FD/hvuGh93hoRb4hYNbMw1pxSCKbadkTs5CfeYJPSsxZBuzd6gq8OS24CdKvdiKJqWjCeLQj8l9YIm5z/Cp015aB+s2L4VHxtaj00HBCb9IZ6d/S1xHu9DPRlnnapMki+Ep1WggoPT1r5/Ezozs2lyEpNGYmN/QZLQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767980; c=relaxed/simple;
	bh=fK29KdVynk9C7SWeqbVe0dVCapcWLfjSXa++Xi1xlqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6FG0Cj/8it4wotvXKzwSUbRfHf67QhhmwOTa0KyYku+/LgVhI9UUXvBU06D9/Zf023x94pB6GFg36789/WgDvupGLYwwQgfVxX0kxXcs9lmTSJMzsxiPDuyQSlsCDJPIrU9Fetsrg0ijFrp7Bfsuynrm3wTyu1R9yZnqkTOb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0LhBut/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecfeefe94cso27413b3a.0;
        Wed, 10 Apr 2024 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767977; x=1713372777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5R/StqwNvnLNfNHVrdYriOCSIktxINMdwb5WzUGl08E=;
        b=M0LhBut/Z7lDHGEewsBXdEzEou8VY1NcZzbrdNd/GdOnerZWTF6N7cebFIBOVP6yGs
         IH9BK5IF7Upxeja6VfdiXiZNOOvm8Dh+MxIrpU0RTSi8jL9nnH+SmPVUnSROvuGnFgXd
         Ydt2mQ4hNh7KcbzlxyvC8p6aXS02jeQ9eMQtcDvrRSuLNFq94hx9+qc6m29D8CPkIy1H
         spxU+vnt5t10e1Oo4apWystM6F3FQ9CwcS9ZyJygg5Z5W+lliJJm6pHhdmd3PZM1O7F4
         N6VDapvgEbJ4c2EBc7+ZcoIqfSFunz6mvg/gjQkNriVF2f4GgDRpqTMJctvWfW3YCEL3
         Cbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767977; x=1713372777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R/StqwNvnLNfNHVrdYriOCSIktxINMdwb5WzUGl08E=;
        b=mUMCvMPS8fCV39YdLm3mx9/Cl0du0t2hmUMecX+mWmJe0bFdf+0SPOOia9tSP0jaGw
         dtFQRxn5uE/z45QyeJv4nQup1rtxatJL/EEMPSm8Wz835dLcMg3DhZP9HaJa4p3BoGBm
         rZVq90M1CxF3qyh9Bckt+lNyFkKeymtso9JwlfH+eZPIWfxioPwzoKsih56H7Uf8BgCK
         k4w0PIRCyBtOpb8z8F5h4b8CNvyXWF6jZmSadYiZ/M2Y/CkI+WP9FARu/vy3JXsx3EcP
         dXI5POmVipPj6aLwj/90PHq4cTeypzaVwhV00yjJNxR3XSPSiK7f9KZph17idHO7Kcv+
         FvVg==
X-Forwarded-Encrypted: i=1; AJvYcCWB2zVt9NRX0+5+px0OnZkwKtXt+mrzkrpwLw1BjDoPYsxyUv9cIjUUtHKWoTXuIKaLMZOvVpmn1y/rJf5qazzy38+gKHDeV6Q+bIi6+4qxqV0jeTrS4YXl1UWObuuox4IZ3HJEv3xF
X-Gm-Message-State: AOJu0Yw3eORGruytIT/p0fMa84kERp4IA76NtQBrK8MDaUndSpOkiYfe
	wLZbOYArMSVCzTEHc9CRj3DDXeYQIZf+p62jN+j0gZELM2vXlrPn
X-Google-Smtp-Source: AGHT+IGcx6aUAQtFgOSPaMf0SHayjy6jPe5cMIV0GuzAty9GvNNAwtcqMy76BcK+Kd+Xg0eItUVhgg==
X-Received: by 2002:a05:6a20:f392:b0:1a7:9e84:dc51 with SMTP id qr18-20020a056a20f39200b001a79e84dc51mr270051pzb.7.1712767976602;
        Wed, 10 Apr 2024 09:52:56 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:a922:cbeb:dc9d:2266])
        by smtp.gmail.com with ESMTPSA id d6-20020a63fd06000000b005dc4806ad7dsm10235330pgh.40.2024.04.10.09.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:52:56 -0700 (PDT)
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
Subject: [PATCH] usb: typec: mux: replace of_node_put() with __free [linux-next]
Date: Wed, 10 Apr 2024 22:22:22 +0530
Message-Id: <20240410165222.5192-1-prosunofficial@gmail.com>
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
 drivers/usb/typec/mux/nb7vpq904m.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index b17826713753..72ec9ef3ac58 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -315,29 +315,27 @@ static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
 
 static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 {
-	struct device_node *ep;
 	u32 data_lanes[4];
 	int ret, i, j;
-
-	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
+	struct device_node *ep __free(device_node) =
+		of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
 
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


