Return-Path: <linux-kernel+bounces-129573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BB9896CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395CBB2623E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71867145B33;
	Wed,  3 Apr 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BudPPXSE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75A14389D;
	Wed,  3 Apr 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140684; cv=none; b=cQm96Dv01tlMpFeWX4ttDMV7VKmSxbrE01n7pccQY2L8Qbz4cz/ZSxOtJnBxrGeZhoUjzmeFZs94SFpQUUvUi2rxPT5+gdsPBD/x5rE8DvkSxSVFKMVDgKlfNMFjXjvrxCsiWnHKizSCdoaii103bWbp7PONDkd99HFC7Ddo72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140684; c=relaxed/simple;
	bh=O0gHDM0xgUueH7DwBUIjDd0mL0nkucXtLHYMM4BNWPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5uUUa4g7YsjtCO1alduLoI7YPUzGY4cA8BPK7sFAZ07fqDD2oZKYrlk5V0ycJFuasdLnVgc+LFAp7QfdpZTqRf7KGkQlckJrVzCfgXi2+VrjRBIBysQUVpeglgBURxjWYp07eHH/pRj5DaE3VsH7LeqdMVvlb4RRSIkKQWDJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BudPPXSE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a450bedffdfso712054066b.3;
        Wed, 03 Apr 2024 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140681; x=1712745481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bxKD9iMqvGSst570xxVI68A/yARVoT0X5vNdiXsHRg=;
        b=BudPPXSEkIyXjk7YbOcxa5xaLmfbJfvI6BM7SKA8rUSt296nhWwALfw/s7BfpBS8iH
         SbAtdivYJZg3Jejfag6/SIlRF20nP5tCaGwks+aAkfzLe9trqS0TMBYSOzOO9tG7DQjk
         oQc5Gth9hsFQTeIcgCZ7K2N8cNyX05NM/7WD6poc5wxY7tDB4gTsRFdCSN0HXR5aatpF
         iyRdlyZVOdQjhtHT+Q1t5vkWqrOGxXm1WKwgo93D8APrsxBw//RHOKwzNASl5B638Pih
         3F/BgBvWn6b9rY1oMfp8KRcka9faBXfELvqGyDn3bDEBMgJ7pFp1EoFq8DdhAZi4+00x
         bzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140681; x=1712745481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bxKD9iMqvGSst570xxVI68A/yARVoT0X5vNdiXsHRg=;
        b=P05ru4CrjeJ+PbW0Ta2sBadIKtlV92bHmQC1VL8IRQmPjHY1Suq5gXmUlVW6N+DH5u
         5PwgUjWJ371qCFsn91C/RWqWfcAy29t7E9NbNEwYZGaUPqNtLjLU15ei3+ScmQilqMKZ
         C9kEB6sor2W43tpFV4nCb7weDaT7Ur5I4kgeZrn33O6wVS2GNdrtnqd8goKA/4OBVot0
         uAAe2YUy969kyciHS6mc04QL25nmLR+d+sQ9G+KCX3Mgm94T4b9q1JxFDlUFfd07x0mP
         p9JxZvTT+ivtK2BCgfprZ5gIMaeNJnmDqOXGhjOQceOnXZBKXNgJF+eJbvL2DPC0lQk3
         dhfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe5IIK/rWP4+cbpKVdzr10akjFqFHvod39NDRlyE2kCRyQJzUuardcC30tyQseqMCUfqf6XKwip53May6hwfBNFkT4R7pOwIjmrhva
X-Gm-Message-State: AOJu0YzcNWIRciA6pT7gLd7ONnrUPP3bw8LxZjFDElL/x7rOznmDv+Cm
	zAcM3lWnB6saueltwf0eH9fRzKV/jbpDBYy3AvcyRVA8pOC7bt9uBcZjdadoU/g=
X-Google-Smtp-Source: AGHT+IF+UBYNRuU4Ji0qhdJmxh1w4QT2JfShwA9t+CSnMqVfUJOsObm7sSpm5Wl36D/lDzuERRqQ1w==
X-Received: by 2002:a17:906:7cd:b0:a4e:802c:a7a2 with SMTP id m13-20020a17090607cd00b00a4e802ca7a2mr1635685ejc.38.1712140680710;
        Wed, 03 Apr 2024 03:38:00 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:00 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 04/16] net: dsa: vsc73xx: Add define for max num of ports
Date: Wed,  3 Apr 2024 12:37:20 +0200
Message-Id: <20240403103734.3033398-5-paweldembicki@gmail.com>
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

This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
used in the future instead of a hardcoded value.

Currently, the only hardcoded value is vsc->ds->num_ports. It is being
replaced with the new define.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - Resend patch
v3:
  - Introduce patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 13 +------------
 drivers/net/dsa/vitesse-vsc73xx.h      | 11 +++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 8ed8fc997d6d..425999d7bf41 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1180,23 +1180,12 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 		 vsc->addr[0], vsc->addr[1], vsc->addr[2],
 		 vsc->addr[3], vsc->addr[4], vsc->addr[5]);
 
-	/* The VSC7395 switch chips have 5+1 ports which means 5
-	 * ordinary ports and a sixth CPU port facing the processor
-	 * with an RGMII interface. These ports are numbered 0..4
-	 * and 6, so they leave a "hole" in the port map for port 5,
-	 * which is invalid.
-	 *
-	 * The VSC7398 has 8 ports, port 7 is again the CPU port.
-	 *
-	 * We allocate 8 ports and avoid access to the nonexistant
-	 * ports.
-	 */
 	vsc->ds = devm_kzalloc(dev, sizeof(*vsc->ds), GFP_KERNEL);
 	if (!vsc->ds)
 		return -ENOMEM;
 
 	vsc->ds->dev = dev;
-	vsc->ds->num_ports = 8;
+	vsc->ds->num_ports = VSC73XX_MAX_NUM_PORTS;
 	vsc->ds->priv = vsc;
 
 	vsc->ds->ops = &vsc73xx_ds_ops;
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 30b1f0a36566..fee1378508b5 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -3,6 +3,17 @@
 #include <linux/etherdevice.h>
 #include <linux/gpio/driver.h>
 
+/* The VSC7395 switch chips have 5+1 ports which means 5 ordinary ports and
+ * a sixth CPU port facing the processor with an RGMII interface. These ports
+ * are numbered 0..4 and 6, so they leave a "hole" in the port map for port 5,
+ * which is invalid.
+ *
+ * The VSC7398 has 8 ports, port 7 is again the CPU port.
+ *
+ * We allocate 8 ports and avoid access to the nonexistent ports.
+ */
+#define VSC73XX_MAX_NUM_PORTS	8
+
 /**
  * struct vsc73xx - VSC73xx state container
  */
-- 
2.34.1


