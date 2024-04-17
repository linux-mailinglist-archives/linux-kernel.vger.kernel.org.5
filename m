Return-Path: <linux-kernel+bounces-149222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA18A8D51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849251F2142C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0488584D3F;
	Wed, 17 Apr 2024 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN/bVvdT"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375664CF2;
	Wed, 17 Apr 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387110; cv=none; b=dA6d5AWtRChIBJuZObqwZIHGoEqZ7Rd1XdIsu5GBc2+FdmdUVRBmIuL6boGnzU6CLyfW1u5d1BYO7M+9Gz9navyjlHM4d8lju9l/gfk3Mp5OvsnSioVI+hHTvyjfvxbzoiFuM/VbsmHJb2d+wwDHZcwJqkMTex3Xljax5auw7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387110; c=relaxed/simple;
	bh=Ry9ykynfK98Cvf3Q1pp9WYqTt5oOvS+CaaRIRxnqa2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSQelWtLoaIiqYwnlkbBe3I4VH+9QPuE7WyothqlFf8rEJ21TaZp9gAGd8l7dH3ese0Q7KefHSSkVQ48Gh66q+k5xEpBY/d1ygLS84S+/SxE/aMbWoOewZnZ6XOC6DqqKiNAuYCZ3eKIlnHl/eY76r1a/mwmne3XNy52d4xES9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN/bVvdT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a52aa665747so5955166b.2;
        Wed, 17 Apr 2024 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387107; x=1713991907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG7aqADrQaHWXWSQ8K/JRNSWezg0kHHHITZ1GehyH4E=;
        b=FN/bVvdTd4RVaBIWzBgtZYdNYV9lsTA0yLTXckB1nr9xlNPfR7Qt6xr3x/ghwaqvPT
         JhiE6WSv2nTJJoaju8CHAM566jiZSvK8expMsWdFbsjFw43RcYcTjDzbiIINaYMRoDNg
         lJHqmlQAp9wmcEx+AKepb0nWhdkUHJu8kyujJcSE2E77nK6RylU64HAOqPFEOgfplUqM
         ebSHBaz8XY6834iSdEDwgq6NEPAYBqnp9ovU8a6dJrKHdd5DHz2b+T5sDZ2wYt5hm5Q6
         tU1D/yF+OheDEwESm/gz+wd6FllNoEFDTRXQGI9Q0T95Xn5+3BN15q0gi1TXkz/tFjfz
         rzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387107; x=1713991907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG7aqADrQaHWXWSQ8K/JRNSWezg0kHHHITZ1GehyH4E=;
        b=npvGmkFW1srZ/DHOzNB5FYQ9D5Qqu5vcGafOCA6bZMQiuZBCpVs6qkLA/CggJy/wXG
         5AFP9JM+44WlnDQsgQtXp4+gB2ZSNnf2ahflWCiqEvBHPr1ln13g4RhnrDDuBDhmG+kT
         tJA8CRF4AHDx/AV2opIiE6ck/dWvJ7Uf4jLARAdF4tBJPqg/Fpxot/V6GTpRVjrg6LGP
         N8lQPZPuIotQSC0m24p1cQRpIdB95bXHN/9ch9ss6QNijXznB9k2GJhMcyaZz2eBMqqx
         zr4GZzdrW8lSVDflTC70KVie21IIIAXSLxLoqDSmB6uDgLDPN5RPmxEST9Dg45NIX4B0
         oOjw==
X-Forwarded-Encrypted: i=1; AJvYcCU2RPpve9LsNPYVgS+crTTYAPMz+ARbiGLIUkZ7V3vofZW2kMXNnjUqNrXekVxW/Z6GqesyZZIRLX6ECDI+XCWI1vT8wwW23q6KkVvj
X-Gm-Message-State: AOJu0YyhzZjk+d2TwcQj5syuVum4pwGFyWRBPwB3CiM8VICrWtoCaCvt
	e3kQT8YIearUSmLs8du0F24Z6aGiRXWklj+xe+frAKomO4rfnrcVWhym4wJa
X-Google-Smtp-Source: AGHT+IFaGTgQQ2aUYhbgxxYsmIVbcg7oHHOnJq5fwm8d01J7Sixey9WLL/WBFXcl1gd5RmpZENrInQ==
X-Received: by 2002:a17:906:66c5:b0:a52:140c:5724 with SMTP id k5-20020a17090666c500b00a52140c5724mr382349ejp.14.1713387106632;
        Wed, 17 Apr 2024 13:51:46 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a554177a2cdsm31752ejc.85.2024.04.17.13.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:51:46 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/5] net: dsa: vsc73xx: add structure descriptions
Date: Wed, 17 Apr 2024 22:50:48 +0200
Message-Id: <20240417205048.3542839-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417205048.3542839-1-paweldembicki@gmail.com>
References: <20240417205048.3542839-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds updates to the documentation describing the structures
used in vsc73xx. This will help prevent kdoc-related issues in the future.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - resend only

 drivers/net/dsa/vitesse-vsc73xx.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index fee1378508b5..2997f7e108b1 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -15,7 +15,16 @@
 #define VSC73XX_MAX_NUM_PORTS	8
 
 /**
- * struct vsc73xx - VSC73xx state container
+ * struct vsc73xx - VSC73xx state container: main data structure
+ * @dev: The device pointer
+ * @reset: The descriptor for the GPIO line tied to the reset pin
+ * @ds: Pointer to the DSA core structure
+ * @gc: Main structure of the GPIO controller
+ * @chipid: Storage for the Chip ID value read from the CHIPID register of the
+ *	switch
+ * @addr: MAC address used in flow control frames
+ * @ops: Structure with hardware-dependent operations
+ * @priv: Pointer to the configuration interface structure
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -28,6 +37,11 @@ struct vsc73xx {
 	void				*priv;
 };
 
+/**
+ * struct vsc73xx_ops - VSC73xx methods container
+ * @read: Method for register reading over the hardware-dependent interface
+ * @write: Method for register writing over the hardware-dependent interface
+ */
 struct vsc73xx_ops {
 	int (*read)(struct vsc73xx *vsc, u8 block, u8 subblock, u8 reg,
 		    u32 *val);
-- 
2.34.1


