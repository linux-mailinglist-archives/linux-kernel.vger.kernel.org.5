Return-Path: <linux-kernel+bounces-91467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C58711F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C028393E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096679EE;
	Tue,  5 Mar 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THL7BIc5"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FA5C83;
	Tue,  5 Mar 2024 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599751; cv=none; b=MQb3nBC+gyJBdW155VwXklsZTaUXc91OQCIXyL7Z98oOAXJ3wO12UqVr/Pu20uCtKA0Ln44QWE1gkXq/sdoTo0pbqj/qCHCJUgM4agn2DIPo4OE9RHIGwgUYRYtES9PQ6WnjopEGtP+6SVTCosee8ct+uZpzqN0Xd1KgINjAF7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599751; c=relaxed/simple;
	bh=0PpSt6rvjbDQ3SybZDVtfCFRovmYHgovSpROWxh7dVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7GrrCInZXuzkRfhCd8oE+28yzqlQrTkW5O7Wwzt+H27clBowQg6SiigX+DIiXfP/go1vNAWDeoLkdxpt6riV5WKDpEJ9B0Cgid14LGCqMN4IkPRzYpbXBb+CyCSpRv3BitBXw1BZcZfRvtH3oPwxCSrX5VgzKrNuy98JINWK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THL7BIc5; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c843eb31f7so62415439f.1;
        Mon, 04 Mar 2024 16:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709599749; x=1710204549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbMkt4JH9fQU1k/SM3hjf0aOsa5Ez6LXN7/VqqW0kvc=;
        b=THL7BIc57p2z1JG04c8pdrPd2C5qzO+3aULPqTgWIqJv53EvVNpaaUlyFTPmVmyfHK
         7tD2Yvz8+NUnQGSRn2qUbKEItnrbEkXxclnzZqaglqzxIzrTnsNZ0laSW6okpwYqpb/Q
         +RFeoGChMmIXbdLVa95Ywr8HZXyR7bfooXwPtOmABY48T6ChnkXVkxZbA+0BZ0csyd7o
         MFWy8msTH1D8wSiSV6jpIYnvhAsbqx1+pDTS+JCwIVBTtB+XAb+X4KYhnKBB0g8F0mTr
         9ltRlXQQCsar47/FxyxKJXPW3p9Ss1W6lX8dumajc0pt7se2T2/7e3WB8hypIvlpQoF4
         Uc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599749; x=1710204549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbMkt4JH9fQU1k/SM3hjf0aOsa5Ez6LXN7/VqqW0kvc=;
        b=mc0gFinWajrSziv3F0lj/LPpT9tK1CUz4nnaVaC8taZcZm74SaGi/uXYhZ/Zuqc599
         9VbhkmhY/jIUYS7OopshLLUMrFRgPI0/LJA+GxxHrDT2uu2Xc741shRayTuSOUusoHDc
         9PlXl2ohG1NwyqQ3KODdsMVv6rV1HMo1e5giDQDOu3S7txmxjQbWcy/Ti/pa461jgvYc
         0o43O4RIwaY9gs/ZUYvDDLpXEFlWqX08Hq6HMQx2NLkvzsN+JrLqmGjc5TztkTyAjO9t
         EVUzE7qG2JMVBHDyzpDT50kqvr2NrDFVnDSeii3EQ0PJslROYNuvQSSCeEz8iyvhtz/Z
         eyKA==
X-Forwarded-Encrypted: i=1; AJvYcCXymgpR45774FZDf/OBVBpIIe62TbIjROTGO6DkouQVMyX5QkNA+wDla3lzWEkmy1pn3qusNdu5U5VmIuViAOmoLauEW+WdAglCDsA7V26WloTx70vRh73jO0nR8uAtBa7gXvCPLbXxZg==
X-Gm-Message-State: AOJu0YxKS2J/oIS53y0dx4pigAcVOa3QyVhlBp4zxsxTqjVq9F+oFWU6
	htgWhe9cFj3Rvde83XjL/cfMQWfTlZOte5ZZAHNx7wUyzs5QmV0c
X-Google-Smtp-Source: AGHT+IEw6edKSWyLjziH3r6j5+b+3S3cO5883mFBAzNRhvz6MbZxITGLrOquyH+Wdhvdz/oFR1TNWg==
X-Received: by 2002:a6b:d802:0:b0:7c8:55d8:7f12 with SMTP id y2-20020a6bd802000000b007c855d87f12mr4434882iob.10.1709599749414;
        Mon, 04 Mar 2024 16:49:09 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:8c4f:ad40:e7e2:538])
        by smtp.gmail.com with ESMTPSA id i20-20020a02cc54000000b00474d40f8381sm1931209jaq.122.2024.03.04.16.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:49:08 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com,
	laurent.pinchart@ideasonboard.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] drm/bridge: adv7511: Allow IRQ to share GPIO pins
Date: Mon,  4 Mar 2024 18:48:57 -0600
Message-ID: <20240305004859.201085-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQ registration currently assumes that the GPIO is dedicated
to it, but that may not necessarily be the case. If the board has
another device sharing the GPIO, it won't be registered and the
hot-plug detect fails to function.

Currently, the handler reads two registers and blindly
assumes one of them caused the interrupt and returns IRQ_HANDLED
unless there is an error. In order to properly do this, the IRQ
handler needs to check if it needs to handle the IRQ and return
IRQ_NONE if there is nothing to handle.  With the check added
and the return code properly indicating whether or not it there
was an IRQ, the IRQF_SHARED can be set to share a GPIO IRQ.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Add check to see if there is IRQ data to handle

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index b5518ff97165..f3b4616a8fb6 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -477,6 +477,11 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
 	if (ret < 0)
 		return ret;
 
+	/* If there is no IRQ to handle, exit indicating no IRQ data */
+	if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
+	    !(irq1 & ADV7511_INT1_DDC_ERROR))
+		return -ENODATA;
+
 	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
 	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
 
@@ -1318,7 +1323,8 @@ static int adv7511_probe(struct i2c_client *i2c)
 
 		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
 						adv7511_irq_handler,
-						IRQF_ONESHOT, dev_name(dev),
+						IRQF_ONESHOT | IRQF_SHARED,
+						dev_name(dev),
 						adv7511);
 		if (ret)
 			goto err_unregister_audio;
-- 
2.43.0


