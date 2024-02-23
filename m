Return-Path: <linux-kernel+bounces-79173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E2861E74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84BF2841F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E7153509;
	Fri, 23 Feb 2024 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0uYtcE7"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F111152DE9;
	Fri, 23 Feb 2024 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722182; cv=none; b=Fsw7kWamShKZgg14CWaRpxRnK5RksncYAaiJDHz5F6jh6FKX+1AVal5RFjBhnvcsxetrXah59KTM5AGJ4y64+txRnaCZJXV59mzFWyxRsEBIl0XC+V+p2MfLxmR+h1wDxJXsvs2riHx8CBDSEllo2lQkzsEY1IcVCq1b6553TjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722182; c=relaxed/simple;
	bh=NbST3xiq/8f/mXsRyb+dmsw+eV52rzAmQa09GQXYbtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFshRgLy63wq5ZsqpP8xgC/w7Jae7oTZgW/MPEpHD8jP8M7Iu1SG86OZDZz36fBwcL0dT6Lx6pVjpkb7PDc4+G8hkgN5DBj4RniHIsqONXX1PwDLQS5Bzbe9Pj/Dcq2KZWewYUlTN+KimvqL0HPJQBba0mCCw1UJIC4669MQY+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0uYtcE7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so126469666b.0;
        Fri, 23 Feb 2024 13:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722178; x=1709326978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tztr1+TqGO5v+hvzGEs9lKsceCvS2t24CDtG8/HmH0c=;
        b=G0uYtcE7St9lo9QEdODm242GVehp9ba4gi5Zb8XNTXlyiD3/CYIheGkA3uCU5vX/xU
         tnGGWxB+uHj/f0JOQX5zfFdEjmX63MrnTFue23HzvrREsFjPTWDQCZ9+vEd/EASixfzM
         AcCdtZoIACuMGQvlXHRjk6BJpcTd/jolEXQ/m7JAJ7SlCXWj6sdqaG0IIt6gZ+2FGTJw
         8klSFDfb74a5OSCaeUVuUr+GxC/SnPIns7Myi1lnteOcZKrymbWqWknxCyvmqQCNj8y8
         kWYoxv5b4rX09CxU4BsYCc3OjanZgfOk3qua0UPWCBZnx4+0F2NSz/1rFBVhdsks31G/
         a+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722178; x=1709326978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tztr1+TqGO5v+hvzGEs9lKsceCvS2t24CDtG8/HmH0c=;
        b=WCnSHEeVRaEJl8uWPyUq16PkL1LsYHebnPAsX6OTfHu6C0aAzbVdZ0G/iTrfPX9Scr
         qR841/Rd4lGbPW0hZdcOT2YGO2+2PUxVd8H7apgWObztCcssB1kMM5hQAqEPU44VApPp
         R7pBSE8pvKvwq+4nH3HT8mDAyIFID3LGZ3YO9sTvq2DmEH2Sj74emYvgo9ORrgw8OCDQ
         AGdEn01y+I+JMyydF9MSj/rNbkH2q5DSOlqZOwlXx6g52IjPRQsrMSRLPevRZMJhAoFu
         5osk3br//i+FMHbgjbPeg/MCngAEhW3r0fQYLnEv+huA+onVoDXYDeTG3HKO0SbjkizZ
         ZdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaJy6kWwYzN2uTiyAJVtbN8PENs9qGkCwFtqLOSVIciRVFLJWSTU4zLIf26MMkeOtDRIDrMfpJT4dNKUH+d/hfJBOcrRfZunJRKRca
X-Gm-Message-State: AOJu0Yw7hK0daIDejxgqgyT7iHOG5KqXHxOhzuU9RYF1bBlVbJg5N49/
	h92BvlbnUu0zoOlJKsQxQv36kvoN3mZMKXpLSWz7bslDOJ+1etksyOZFq0HLOiI=
X-Google-Smtp-Source: AGHT+IHpO8gJUSAkISZp8PUFUv/4uG9dMlgn15urd9qo/QSRVfaKl9cd4f9RvZEAkkYgq9pKXkpfrg==
X-Received: by 2002:a17:907:20b9:b0:a3e:6aae:d342 with SMTP id pw25-20020a17090720b900b00a3e6aaed342mr641518ejb.47.1708722178402;
        Fri, 23 Feb 2024 13:02:58 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:58 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
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
Subject: [PATCH net-next v5 14/16] net: dsa: Define max num of bridges in tag8021q implementation
Date: Fri, 23 Feb 2024 22:00:44 +0100
Message-Id: <20240223210049.3197486-15-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max number of bridges in tag8021q implementation is strictly limited
by VBID size: 3 bits. But zero is reserved and only 7 values can be used.

This patch adds define which describe maximum possible value.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v5:
  - added 'Reviewed-by' only
v4:
  - introduce patch

 drivers/net/dsa/sja1105/sja1105_main.c | 3 +--
 include/linux/dsa/8021q.h              | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..6e22d7a6bfa3 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3156,8 +3156,7 @@ static int sja1105_setup(struct dsa_switch *ds)
 	ds->vlan_filtering_is_global = true;
 	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
-	/* tag_8021q has 3 bits for the VBID, and the value 0 is reserved */
-	ds->max_num_bridges = 7;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
 	/* Advertise the 8 egress queues */
 	ds->num_tx_queues = SJA1105_NUM_TC;
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index f3664ee12170..1dda2a13b832 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -8,6 +8,11 @@
 #include <net/dsa.h>
 #include <linux/types.h>
 
+/* VBID is limited to three bits only and zero is reserved.
+ * Only 7 bridges can be enumerated.
+ */
+#define DSA_TAG_8021Q_MAX_NUM_BRIDGES	7
+
 int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
-- 
2.34.1


