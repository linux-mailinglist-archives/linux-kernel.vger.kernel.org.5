Return-Path: <linux-kernel+bounces-129583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F5C896CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C151C26B01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394CC1494CE;
	Wed,  3 Apr 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToED8iKR"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E771419AA;
	Wed,  3 Apr 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140717; cv=none; b=LGGy0MP60m0LY+qoypYFHmzAtvZAjSjY84h8KtE5MlTCXEBB/CtDpufshgQST+f7OBRvjv47y0LhnohDOOXG1Yv9ZdDyBMWgurpl9tQNlK0Bj/AvcLOp1etX4zdm5mER/odfHlLG/Owft7KkMPIJqlMcfNLNizhIM9kkoBnFjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140717; c=relaxed/simple;
	bh=47HaZ9iiUTmn0HmyKp/1gfi01AjpPDV/EJVz59beY9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3LGQbTWvxTRfiISF7ewzlWlFeMka5Y8uOauXgHZWY53muJh1sdZILD98j07n0rw7L3x/Dlrjjl+0Obt+Ez8RZuPk+YAnyOQZTDxLP0RcxIj9mX6VUvA+nw51HbbImUyByD/aZTmQGqkubQBAaKfhxvj8SFplD5oJiSv1LMXn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToED8iKR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4e60a64abcso128781066b.1;
        Wed, 03 Apr 2024 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140714; x=1712745514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF2bOF3/jwwcVqWoPFtKOD/xnMrgqW0YdoBVjA/194c=;
        b=ToED8iKRKhDRbeqmJITW/mKvpDtur3H5poHZUM1ENlfUv6g2brEe8V74hSIDpSxi5I
         ZcuR5odm+Cx6/ngGJFg6uUywuPDoZ6Rw3+1nQX2UirDEmSdpxbcnC+rR/q+no2sKDaui
         YTiVcC1UvT73sixJnwR2DLAc3o17qPCbHIWI4b9OmrizeLV/39peMhG15zoeFTrcLVWH
         0wDtY6fFaSDQX8vLKUG3hicJGfEhtwmT9memCoM/RnKVJLI7rQPMlmSutbHts2AkoFDg
         H+3GPrKasX4d2Sx4HJsqjA9NxPugPBVWEigyVR/li6hDioVCWToEL2vuvqn0IcAbsib1
         dp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140714; x=1712745514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF2bOF3/jwwcVqWoPFtKOD/xnMrgqW0YdoBVjA/194c=;
        b=YdYh3xqm77se3mNboc8XevQfc7wLDlNyMy+KeJRwbi9Kd3Nrh9Vm8UqfSJPQwZ7+R0
         q6L9zHuzo5cPlfgl7BdwSIaxm5gfpzYpLI1fuU1FkgZu+DUW2Jt3e/bYh1Tlw+zoX0XY
         YyMnpmVp9fpzz+uacV86FZJtCUgMUwoCFf/UiTDwSiVJ+deu1Pua1jHY9X0pMM2qd4cw
         8ejcjCdL0e9sMQVVheLprmcaEm9Vr4eSHRUZSmOTd7sAikNnULhvJssx7BP3zQFhSUyP
         GY4/YktBeTB4JZs+v0FWJibFMNF20XESOoe6F40Yip4ryZNx7AIlO9M+mmncGBEyx82Z
         ygcg==
X-Forwarded-Encrypted: i=1; AJvYcCWcslqMd/hhJ93hFf90t1LHBI85C9qkqevmekB+Ht2UQhPDKMCcrrWf9ZbovO2Iz5fDfwrAO72I+0e/Ypq4phibuZuRC+fDPLFI/AJA
X-Gm-Message-State: AOJu0YwUOlvsSQvC6z3UQ1VYyMQswPDuolw22fFcU1JLTfHwd9URfTS/
	qCDUNd6kv9OO7NWL3aSvZXpRJoyc2qfnobyZSecs04b1Y+br5zy3M2vtogFjo7w=
X-Google-Smtp-Source: AGHT+IE4WaOtGTFw+6pFgN5rRZBSGE/muyZZ8UvEBGzKf+AQNEq15KPG1OHqj7l/s+1mIl3uzW8DlQ==
X-Received: by 2002:a17:907:7da5:b0:a4e:9cb0:b644 with SMTP id oz37-20020a1709077da500b00a4e9cb0b644mr2191148ejc.13.1712140713856;
        Wed, 03 Apr 2024 03:38:33 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:38:33 -0700 (PDT)
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
Subject: [PATCH net-next v8 14/16] net: dsa: Define max num of bridges in tag8021q implementation
Date: Wed,  3 Apr 2024 12:37:30 +0200
Message-Id: <20240403103734.3033398-15-paweldembicki@gmail.com>
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

Max number of bridges in tag8021q implementation is strictly limited
by VBID size: 3 bits. But zero is reserved and only 7 values can be used.

This patch adds define which describe maximum possible value.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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
  - introduce patch

 drivers/net/dsa/sja1105/sja1105_main.c | 3 +--
 include/linux/dsa/8021q.h              | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index fc262348a134..155fd28419f9 100644
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


