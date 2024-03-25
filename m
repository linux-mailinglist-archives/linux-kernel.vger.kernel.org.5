Return-Path: <linux-kernel+bounces-117964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5188B1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62BD1C60F19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C46EB69;
	Mon, 25 Mar 2024 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOpa/Ooo"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D406E610;
	Mon, 25 Mar 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399491; cv=none; b=BH0c9btCu8bPoPdmd6L4Gp5KIp0XiWJI4j2F9VFCFirjWqp6lzaNRM2WW4371Ww0D6lpG1SzEf44LEVhD7pboN/o4ZsaJe5wLWvDI13p9zTCjAIjxKnO33hhRik5hYxRzg+dJmqYnkVcrfvkf39qb4ca8sgaIUeVcOzp8G9iOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399491; c=relaxed/simple;
	bh=mD1M3LVfb5RknNH730RDEoVVN+tgv1mN6PW++COOwB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wf28x0xUddsYvbsTwVXFzVVpSylOyPPqu9/lysNaRnGOlBXG/SG0XtPYzFtFthqH1bvamVI/TpF9ZNzBDn/Y28aaUbsxEVTO6Xhh2Gy6oR6xR/yhictJMhsERv1P14jZDT2meqn6aaZ8VHUt/NXzTeswqespdQIUNg08F9jD944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOpa/Ooo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46de423039so275348966b.0;
        Mon, 25 Mar 2024 13:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399488; x=1712004288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRdG6NQnSKMzq/RbCCRDnlTZbYIKa3h23JrZEJ03gXg=;
        b=MOpa/OoocJ2O9CEFM4Sb4N7+B/HG8DdtHavQpUl4Eq+UFsor8eV5Ofnq+BsIDR5Ew/
         Sn0WxE7Im2t0y8CyvtEEX9X/XH2YgB/9n6D+CwvQIr/63EmcjB4i36cMfPVfNvVx0BcA
         gjTLTsic7PmjVFMYbF8yosVQbKCrSJXwvZMawp0BxX1QP3kbozc+sbvW4Mjc+knADLTj
         NcPEmHdD7x+b/XlqSS3h84RvzhykZc3KWN8PeP/tNp2QTB7M2JYGKMeym29gZ6s+UagV
         u/ERFhJ6DZxqnyCvdWye74Nsp6gh41JMfMGf8uoXuHXxOXubTan9oErkIjdus7RnlTCZ
         dtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399488; x=1712004288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRdG6NQnSKMzq/RbCCRDnlTZbYIKa3h23JrZEJ03gXg=;
        b=OIZFae6fIHbDZDlPKvwRcKF2jnVTtlAziAaOezE++YGAxgimZ3DpdVOk5qNsPqaOaw
         2+2BRUdzR+HkobBxLqKtFdUxICq+kfat3fqByQ1poh07MnQaRCrjZ0kOxW9TcnG1GeLR
         SWme59ZKd42RfShv+LfOp0h1R0o1sf0huEgRz4CIN2QtVF0tE+nTpR/4D9UZM4CPn9/o
         7WSxtvwH52m1FAMDVW4S4zaNRPPOyjlPbCcxTxJSSfu/YdWF0S4YzqjvGL+mm1lZSPTl
         P2nBeIhwFvcAwfPFE7xOkxyXS3znE14ByvDEHJtEjnT47k5YoxzfHQga4I3ezKJ+sYg2
         foUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcl/eGGLnzE5Oc/rGGwaEtKA0rhBplC7bj5mmICzIKfars1Ny59kwxWynasDI589RY3a7fXyRhgmt/X6lHjqWAJPn0nYe60sXlCmBE
X-Gm-Message-State: AOJu0Yx19h5ofQcpb8dBN3SR01ROjj15EJSCl6B+AuODCobtor5ZMdld
	z1BzNIzEvB2bLdNINA0zvYmph8oABqGvitO4t6bJBsk0wrTyof1YWKPxsVVLmt8=
X-Google-Smtp-Source: AGHT+IEK+CPromJgklE4wCB81BT8DIB+yArFcjEsyESiitoBU+L4dC/FDbRDBZJpBJmzba2X7u6oFA==
X-Received: by 2002:a50:d4d9:0:b0:566:43ab:8b78 with SMTP id e25-20020a50d4d9000000b0056643ab8b78mr7237870edj.30.1711399487998;
        Mon, 25 Mar 2024 13:44:47 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:44:47 -0700 (PDT)
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
Subject: [PATCH net-next v7 04/16] net: dsa: vsc73xx: Add define for max num of ports
Date: Mon, 25 Mar 2024 21:43:29 +0100
Message-Id: <20240325204344.2298241-5-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
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


