Return-Path: <linux-kernel+bounces-2242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4611A815A1B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D0F1F2371C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4E530CE1;
	Sat, 16 Dec 2023 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNUXbh4s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB430352;
	Sat, 16 Dec 2023 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so18275115e9.0;
        Sat, 16 Dec 2023 08:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702743133; x=1703347933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cokl3LuwGBmLMkAOd5vR5wXsVLEjgGEmnr03uCIMe70=;
        b=DNUXbh4szx25rnYEsnFQTGejWvxVejXYw2i0vmHusz4q5bvcLwA/gzvCRK8wk/m3uq
         6jCEvWq9SFfsDaxhpBUpTx/X+TLs3EFccr+BEyQCEm/vijKsf1TBNcAle9Fw5ttnTqq1
         syarkaqZY9SMQ9ARPOWf7gZPvmvHvKBJTSORiswG9ALNvMzcfDOLjpjAWgzkbDMN+1Pe
         7j+yJtr0/u3MkOdV7xilpe5KuimWcylMDz4f+aX30zTafDNAxWlZhSDEJPN9x+cAJZVK
         DvUgP3mjVraFtgqUoz5+LEFUlCfwCv/Vt9y0qj5reky/7x5INkO6apVQxtfNVF2yy148
         Olwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702743133; x=1703347933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cokl3LuwGBmLMkAOd5vR5wXsVLEjgGEmnr03uCIMe70=;
        b=Ktld7DaXdYXlQUNhQD59LA4HTXQTu5Lf59jiUCt7JUTICEXtRpK0VRzl6S3U/XEUQ0
         MW32Emg8nen/neJn/OGdFLFTiSZcFh2TvDkogF00mLKFfHBP55DNT/ZELuX/rB+dK1Nq
         GeVo8GNUxuQ3D/OuS/FUEIdbn4Z3y/jltFF4kv2XiT4sKga+d2Yi7+8QesFHa8EqE9ZF
         sCYp2SjIUb9LrXc0zM3H9ELoNbzh84m5fNJgIONQlya+ickw19jSsYf0+bncWrRcBr5p
         7o8YadVRySSTlkp2zjTHNaeuv0M0g273HlnGlBjaX4YfMt6U9VyP5mrmuJhUayDKsy2e
         gcRA==
X-Gm-Message-State: AOJu0YxbzWm9vXrZdaupWT53N8jNlFgo7CIk4qAYU/c23C+4qprVaULO
	TCdjNqOP2/sAh7U7S14mKCQ=
X-Google-Smtp-Source: AGHT+IGWclf3Klwf2dyJ2veSDySklMp4+jGhuWI8fOrteSyRGofMF6BX5BpyVedw9ED/jgKEHbBIdA==
X-Received: by 2002:a05:600c:1e02:b0:40c:6862:4244 with SMTP id ay2-20020a05600c1e0200b0040c68624244mr1630089wmb.111.1702743132962;
        Sat, 16 Dec 2023 08:12:12 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0040c3953cda5sm30818925wmo.45.2023.12.16.08.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:12:12 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 1/3] net: phy: refactor and better document phy_speeds function
Date: Sat, 16 Dec 2023 17:12:04 +0100
Message-Id: <20231216161206.1729-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231216161206.1729-1-ansuelsmth@gmail.com>
References: <20231216161206.1729-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the phy_speeds function to be more readable and understandable
and add some documentation on it.

While on it extend it to take NULL speeds values to make it return only
the count of speed modes in the passed mask.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy-core.c | 50 ++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 966c93cbe616..f3f5e4c41c97 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -317,17 +317,57 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
 }
 EXPORT_SYMBOL_GPL(phy_lookup_setting);
 
+/**
+ * phy_speeds - return all speeds in mask
+ * @speeds: pointer to array where to put the speed modes
+ * @size: size of array where to put the speed modes
+ * @mask: mask of speed modes to compare with
+ *
+ * Take mask, test bit in mask with the settings table and compose the
+ * speeds array based on that as many as size permits.
+ *
+ * With speeds NULL, only the number of detected modes is returned and
+ * no array is composed. (size value is ignored)
+ *
+ * Return: the number of detected modes in mask.
+ */
 size_t phy_speeds(unsigned int *speeds, size_t size,
 		  unsigned long *mask)
 {
+	unsigned int curr_speed;
 	size_t count;
 	int i;
 
-	for (i = 0, count = 0; i < ARRAY_SIZE(settings) && count < size; i++)
-		if (settings[i].bit < __ETHTOOL_LINK_MODE_MASK_NBITS &&
-		    test_bit(settings[i].bit, mask) &&
-		    (count == 0 || speeds[count - 1] != settings[i].speed))
-			speeds[count++] = settings[i].speed;
+	for (i = 0, count = 0; i < ARRAY_SIZE(settings); i++) {
+		/* Inconsistent mapping with ethtool modes? */
+		if (unlikely(settings[i].bit >= __ETHTOOL_LINK_MODE_MASK_NBITS))
+			return count;
+
+		/* Skip. Speed not in provided mask */
+		if (!test_bit(settings[i].bit, mask))
+			continue;
+
+		/* settings struct is set in descending order with
+		 * ordered speed modes. Detect a new speed mode by
+		 * checking if it's different than the current one.
+		 */
+		if (count == 0 || curr_speed != settings[i].speed) {
+			curr_speed = settings[i].speed;
+
+			/* With speeds not declared, we return only
+			 * the number of detected speed mode in the mask.
+			 */
+			if (speeds) {
+				/* No more space to put new modes */
+				if (count > size)
+					return count;
+
+				speeds[count] = curr_speed;
+			}
+
+			count++;
+		}
+	}
 
 	return count;
 }
-- 
2.40.1


