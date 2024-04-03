Return-Path: <linux-kernel+bounces-129574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5D3896CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84607282AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB3E1465AB;
	Wed,  3 Apr 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg3mreAj"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC77145FF3;
	Wed,  3 Apr 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140687; cv=none; b=qfDtL8E89S1Fn3WoFL7y7cYUzUK9N121kWnxGboPKQ8R70YYarUN1gVbax4J58V2kJnwFqKTIGpk1yXikBZ9c7g+bb/C1kVmTqZbBaMkaP11i6EzgP7/tePbx7UQkDzOVfXUM7UdD2LPXr9+eDZjqptcifJGG6LsYPKICI1/GKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140687; c=relaxed/simple;
	bh=49XTMBVLCc0luVNpQKQJKHeoXxvxs4Z19mqiiTT9zl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+Pg/TeEpleqn3yJQuKWeFoFGOWyux67ZkLb7mXLnCR6sIzOeop7ULscQg14vQXd5w7Ea/6QyTP5+yoJ7V4/M2WavsGxuzXi6MnIMIuUsJ3eJsJwaMtRQkl3W1svaTkVPwORIEte5JnqDW33deRMC+35OUS+uIf4wt+IjxRDqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg3mreAj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a467d8efe78so773392166b.3;
        Wed, 03 Apr 2024 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140684; x=1712745484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2Y2nxXQnAz5msKA/w9YeANFjXdiyUIanf+P6OBS2YQ=;
        b=Vg3mreAjtGFArmdgrdbOeAWrFtC7TiTjtPluXhD6zqwrQnr0VcNC+BMiMDAHZHj3zy
         jml+23hzHMlBVwL9bgxGC1kgg6aIiYxFf08aXowfHuhUyghiE0iEfgr88TAvBAg9+mmc
         iF6+R/w4IX5rKgbJ3j/SbzavIwMRiL9rO+VUmiFBPSgcEWUojxW1Ev/q7tq5RMweo0U/
         QY9gFfJWUUG5KtmOBT82OgDGUovfbgh3aoURBfewKgSswous4BIgch0Cd96B/rpx5DBX
         12Q6Phc2RM+2HkplMIPunnN9/8PcMctQbDiYwIvjsRSnB1WGAQnTZorVCAp8KyrZ4maM
         Qcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140684; x=1712745484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2Y2nxXQnAz5msKA/w9YeANFjXdiyUIanf+P6OBS2YQ=;
        b=CFH1lq0GkvQvCx/mvlYRllUI0lvzP9PEXVm9mYsHJojafALT9+mfgiC0QiNGyOSko/
         dbTtpi4Jzatzd6bvAepdpqpp2asNhCTVKsKV3l4m1o/WoXWRpOZM8OBBGiQf+B++afu6
         N3N5WOj2ibSjs+aVY0E6s3ERY/GBal5uT6i7QR/PY1KbAolT63xe4pN1yeiAOJ1FTm/j
         Kr6n/bA2NPpnPlsF7+AfFTB542Gzm2mTe7zvH4xxOX8bppTfc6C2fNJHMASbE2fAcgh+
         S5KlNaLMAn0utW+ilzO43xf9fMftD6H0nCSIgpLrn+9sPO9DsHgQY3erN3TWHfpuVTkA
         nMtw==
X-Forwarded-Encrypted: i=1; AJvYcCXFyzvsYeCNMEi0P2an41sHbNmQMYXM49qoZGtyWOYVpMIaVigHpmwRJOa/5hWCMxRQ37YOKyv815twmmWrc/h2+GBxJ7DNp/rmv6an
X-Gm-Message-State: AOJu0Yzp6RQOdS6z3M7UfYWEWpfKK8IonwhPJhkBprpTGFd+8MVfsv47
	DY+W0BUzj+d6vO1ANelk7v/wrSYNaMqbgmyPJapNke3tdcX3qOqFVimFJxvSCKA=
X-Google-Smtp-Source: AGHT+IELbNEoZeGq6rM5Zip/h7WQueJ73Ay9pbr1lXyS8bsGQsTN4JMy65HUqKiTvQYtLv14bFa7kw==
X-Received: by 2002:a17:906:b211:b0:a4e:61c8:a744 with SMTP id p17-20020a170906b21100b00a4e61c8a744mr7263429ejz.47.1712140684007;
        Wed, 03 Apr 2024 03:38:04 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:03 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Subject: [PATCH net-next v8 05/16] net: dsa: vsc73xx: add structure descriptions
Date: Wed,  3 Apr 2024 12:37:21 +0200
Message-Id: <20240403103734.3033398-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403103734.3033398-1-paweldembicki@gmail.com>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
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
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v8,v7,v6:
  - resend only
v5:
  - improved description and stick to 80 characters per line
v4:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index fee1378508b5..e7b08599a625 100644
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
+ *	sswitch
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


