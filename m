Return-Path: <linux-kernel+bounces-64426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BB5853E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5191F21F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC069D14;
	Tue, 13 Feb 2024 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI5B9SAR"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359469D1A;
	Tue, 13 Feb 2024 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861933; cv=none; b=K7AwKdrHtkqhPBdFTeC9MJ5bIStChuJAIiTFI740WHLT6tWGDeWmVGKLM+Ps53QxAy2ceGZeuEyqAEytZ2q05KX8BVK0IkpPqRcL11LFOHIcFrxhPttvDzndDIokSZJpbOpHpCN79sKOeP8EJ7LvbQnRZHCCgCA0D0m9fq4y/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861933; c=relaxed/simple;
	bh=1fo9tqK0gVYT3dua0dTYP+mwom4X6HUKZw4ewOhVpTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mc0TLr1+n143WAmECUEh+BEE5HNXRBeA5rf8YoSHISiLNQW+MRtmGCzMpVWVOw1QKIRYhkKZL1W2sEfE/d8He0h2vJ7ZIESZjuzWSXX8g42Iwtn8eisYiNsTBdHspFOKrVyxE66dPUUpTpngm6IOBe8LLUvxwaYK/G5ncG8m8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HI5B9SAR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3be744df3fso514014966b.0;
        Tue, 13 Feb 2024 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861930; x=1708466730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9TYnreC1cjtgZPE9uArnAlQVNsjfWDdo5XqTKM9rnk=;
        b=HI5B9SAR3QRF52LQLQjRH9JiSAmXihtv0RB1AbEjyw+7e1eXLK4AYl3IsK+VNgELN/
         DOfawtC22Va5yfqxE7K4CuZZNKnP7K0x4deh6pdCtt8rLZyI7D/tyxPiP23wGDgxMyLj
         dxYEesKxZ14KpYFqqoboBnCjgmkH1Kjt9mhk1Ud+dRjF70m0PO4o3AJsOros8I6hUmDj
         /bXJHoBQ/z01LOPSJ6kbm9iTLD7ElfGoPM7z1b5r+U9wZGXFne1kgmDM59WMcZL5cg3X
         2NiB0p7ztwylJyPVUYT34T7DoaA5Ia58p2yFxoXE6ddjPUbYVTAlTsXkYhHx5+mSoT6z
         c2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861930; x=1708466730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9TYnreC1cjtgZPE9uArnAlQVNsjfWDdo5XqTKM9rnk=;
        b=PGRBb15SsH7/skZOX88r2mj4oYHGjopUgxpgNqAn7FfJRB/CTeR5eFTqdfSeb14hX/
         N/7az++FSmrtRKbyCDnWcT48ASSjZU6uIvq7OQTQPIm95+gy1iMWAGYPhOWeTHqMBG9Y
         47bEEjcECQVnnhExCRko9R2XSamQj0nV5Xf726PzQeZ73tNLqqClYLIu4i105FScpfXH
         mfWyU1HX60dIG4P8mkL4W8Bv8q2yNCsIXlBkdZtoEN8jKpre6BxaiJFkF0oYESEDAfIS
         nfaiykg50ZjtmjslUZKkfGmnBkfvvavr3xJFjzh7tHAPCaz0AJFa2OXayVAtdH6kY1d8
         tJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDIg7d/OxJA23kf85N6+/EXI3NSzpHSNPo2D0d+kYTylmIuj66nOyZd6b2gqzXNTrU8x/5Uxssk+1UVN57z4DhoiSMykGkiZZBglaj
X-Gm-Message-State: AOJu0YwQSE7wDBLdsPWgRKINyIQziXqnE3lmboqI6fI78AVbzj+6Ow9/
	OadlOo2RftpuaCmHj927xoW9EZzoFtLb0eAZIxXWAH36kYPKerSHcDTgNhxbtD8=
X-Google-Smtp-Source: AGHT+IHij6jBh+AZ84+0Ms7NSpNfpFlAKS5ycAYemncvSKYjH7mjEEFSWBURsVKtbIB7AqlU4YXvCQ==
X-Received: by 2002:a17:906:494e:b0:a3d:1378:143d with SMTP id f14-20020a170906494e00b00a3d1378143dmr480648ejt.2.1707861929878;
        Tue, 13 Feb 2024 14:05:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmJZuTch5bGaS2/AjO6RP2r83H/GbJkv1d4TPfzC/UylgiK7INVXoXrbajJqbVxggfp8v2F1eK5g+EPwQIye5XWWuKGvygMCdEvpS7UYMpaLWf6ymSRG8KKep389gt1E583uDchIB0MA0RRz5kqmmj1cxmIVrFRmMZbBrBHzHJU8cvXtPuqf/gQWD7AzQZGMYirWSWu5ONdndEZz+hHKin6aauxzfvQ7yFmHKygFql2UJw1/t5LmjC8IO3OAePBUupLllOc07fJzuhWXksj5BDq0pQ9eiALE3aj7ak4ATgufa9QUB1Z9XFL0WYsYi7q8A1vDdmdBd8ahls9WLsQMmh5Z+uXJA608YS50H5OH0+JdQWCQGr2ZgO3RH211pDavcCBsI0DV3SuLoTWttsMAcFbit2ekr2AUrfAXUIpBYjPECEAW7Pcry9LCrp263VLHYxUXRpy5Pzcw==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:05:29 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 05/15] net: dsa: vsc73xx: add structure descriptions
Date: Tue, 13 Feb 2024 23:03:18 +0100
Message-Id: <20240213220331.239031-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds updates to the documentation describing the structures
used in vsc73xx. This will help prevent kdoc-related issues in the future.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index fee1378508b5..99c5c24ffde0 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -15,7 +15,15 @@
 #define VSC73XX_MAX_NUM_PORTS	8
 
 /**
- * struct vsc73xx - VSC73xx state container
+ * struct vsc73xx - VSC73xx state container: main data structure
+ * @dev: The device pointer
+ * @reset: The descriptor for the GPIO line tied to the reset pin
+ * @ds: Pointer to the DSA core structure
+ * @gc: Main structure of the GPIO controller
+ * @chipid: Storage for the Chip ID value read from the CHIPID register of the switch
+ * @addr: MAC address used in flow control frames
+ * @ops: Structure with hardware-dependent operations
+ * @priv: Pointer to the configuration interface structure
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -28,6 +36,11 @@ struct vsc73xx {
 	void				*priv;
 };
 
+/**
+ * struct vsc73xx_ops - VSC73xx methods container: pointers to hardware-dependent functions
+ * @read: Pointer to the read function from the hardware-dependent interface
+ * @write: Pointer to the write function from the hardware-dependent interface
+ */
 struct vsc73xx_ops {
 	int (*read)(struct vsc73xx *vsc, u8 block, u8 subblock, u8 reg,
 		    u32 *val);
-- 
2.34.1


