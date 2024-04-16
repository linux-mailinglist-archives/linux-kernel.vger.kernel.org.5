Return-Path: <linux-kernel+bounces-147441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB88A7430
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5D3B239FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8E13A3E8;
	Tue, 16 Apr 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4kccgOM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06413473F;
	Tue, 16 Apr 2024 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294117; cv=none; b=VRMUPGoUUlm4WvmIB4k5xRPEqeRce68gz4QS0pCrXg+Ap6kt4tCMMUeZbxO84x3ptyGEoxjFohfoj2dzKOKcEaq1Sr7gBKNg1l0zVuKvW6agwOtxid+hAJppdUhyl7px9WvvnWnz3ERAynpMwdMUlqXaipllDa7VXC+bSxzJeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294117; c=relaxed/simple;
	bh=Iqa1jZFbSawQjr+CJUz7nVCyrQTIWjYRq/y+SFNwWHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=buIWiyj92RdIaL58E0VDSz6GD2j2V4dLRxGPrYRbcIybLgOXl05su7HIh++/ekzDvwAjmDLr4H/XjHIohsGL8P7p/im17frvAwAy+e0ZEuoz1MClp3iKU54kccSZu5iYSyfYj00XZRSjyFtHCcIQb8Yql3u3JnYTlPyvZbZIyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4kccgOM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a523524e5baso581109566b.3;
        Tue, 16 Apr 2024 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713294114; x=1713898914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZpJcz4q96m6H/9BjAU0EaM5FaeOMwdztZTURkwBQn4=;
        b=h4kccgOMtt4cuiihkEbZv9W4jVNGW6/Cx5Bcwu1d7Nh8iGC6LmrIQpZZE8ttyAhp65
         MfAErLRTnR/CjOkcrTMI5ZZQm1GhwpoZtlHGffEwSxb35chPwCbndEFoW74UvSjRG5hN
         CmDjqkY80VFs4VVhejJznEIEzfrJmoulC8SZq3R81V1KN+9GUNcVQ67ArgGn34VezDPt
         6/5Hr8UxhJFFzWV4+wROb1fm4bRx5CryP96W8EMSt7s/xOTjXLxgVyZMEUWPPwZreXjW
         MqqetXuCB8rUOyqEq+FK4yVVwt4paaFFtZ7TmwhkOA2xv2iaenCVo2heJlJQhy7sI6/9
         o3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294114; x=1713898914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZpJcz4q96m6H/9BjAU0EaM5FaeOMwdztZTURkwBQn4=;
        b=ElV1k+eUbj9Aj67AKEERP96yByGm73mvJCKG/S9DN8gBYJTzQ2eVPNrman6zel5uHc
         6SYt8HcHAPInttEsh7zq0walBH0WhktXIr8+dbOJm/bErLB/wG4sLfyHsI0epdJA5Ljt
         nW/Ts5R2porFNwywp/dh+90mgMZY5fD63PrByNbr1LgbecyrjiG64uDlMNMJt2SlNOwP
         vxp8MvGcxt3NAB4gZT3oQgFIP+chUkL4jMUHSs9IgDeNiykV0pLhMIogcJcZKhv4DuT9
         ZodvMG5KkYXFjtkQ/0yvjYruVWWDJdhCKWcA7Msbz8YJo27kogK1JugQOpCwowRpvr/x
         tGqg==
X-Forwarded-Encrypted: i=1; AJvYcCVcqQSEh1Fp9Fuhwi8/44tYMJhc3EA52HiArSm/nciZvDPKIBPgTfOSWI3k2WvWH9ZDXiHXPBFE3XcgIQT0tmKbo5pbwsIA2R941MQr
X-Gm-Message-State: AOJu0Yz44zK2ICv28HAj0XpLsfKTTfN/8v3fIDhjIm+OVSev1WRa88Ds
	I1g9p6kOAzWurgNPHjip2hnCD6t4UrGGnPxVP1bHbyBkGVx9FvzKEk3uSI1y
X-Google-Smtp-Source: AGHT+IFtz5PGkW2Z9Ps1y2/0w7YPPFU74m3LSkzcbMbLPyvEGuQON7EzjEJ/yIrXR1c1c/POvEskiQ==
X-Received: by 2002:a17:906:5799:b0:a52:6c4b:cc18 with SMTP id k25-20020a170906579900b00a526c4bcc18mr5099905ejq.71.1713294114162;
        Tue, 16 Apr 2024 12:01:54 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a524531a580sm5247981ejb.152.2024.04.16.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:01:53 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] net: dsa: vsc73xx: add structure descriptions
Date: Tue, 16 Apr 2024 21:00:55 +0200
Message-Id: <20240416190055.3277007-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416190055.3277007-1-paweldembicki@gmail.com>
References: <20240416190055.3277007-1-paweldembicki@gmail.com>
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


