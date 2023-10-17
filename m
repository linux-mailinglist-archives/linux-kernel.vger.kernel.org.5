Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846FE7CCC41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbjJQT2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbjJQT1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:27:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20EDF1;
        Tue, 17 Oct 2023 12:27:52 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4064867903cso66256265e9.2;
        Tue, 17 Oct 2023 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697570871; x=1698175671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0xHAajk9RnoZnMNxnlpPx/L53pYS94eDmnmY1A3Dok=;
        b=EN8fPfmvI0AcO1iYEp9D1Ub6rqBvhphV9l8FPRNFmpLI2ThoNyERs9Q9lCSZZWp/kn
         lNHiDBIi4gXpAAYPd6byKm+Z8JGZy0o0XdixLDoVsbiHVDQEpjfVQ7qhgvG4UP3z8CUm
         2I11cWNMhQ2idwDgQajJMFePOwDJcoKM3AdvXjrFM525SV65kIhEy/hkp7UwM7xP0E3I
         MS0znQjdwvRTXMHY3VYh1zX+NKmzZdz8YoCoVfP3mEhVN+spmfgJ6cvZwVW1DpZGrzDX
         ygVhOjV0MMgmvfp7pd22fVjkf5CpfY2gA+E4RUL3xGNTp6vbxZFOUzbjWnNoL3AyXdGM
         FV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570871; x=1698175671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0xHAajk9RnoZnMNxnlpPx/L53pYS94eDmnmY1A3Dok=;
        b=uw7jHx8MZ9eISXR2CrXRAyCJujJ+ODogRG2h3Ede7n4Sm9n8V/W9i4BwAxLW9utLcY
         /OIv/1sdTkb/h0M77dz+gsay3jmquA4z0flwZt2rXyax9IsSJF3oJ+e52XL8TALfjxuG
         6iA6qoUM14hzeAA0gkgkizFTIM4soqAu1HgI8vCeHSdV6rb7dS92vD2lKrIatgiJRVeI
         x6Ojb9D6a7a5FS/mfx0GsPJpsonk3bspUtzNnU/sLooyBD+xNFZcMw3A8zLdSxGtq7XP
         wrFXXZoh+4ZqRo8shWWqsueBNocMVfXqmCkHxwhxNFhux2qN1FmH4E5DYAD4sKjjFwGD
         jitA==
X-Gm-Message-State: AOJu0Yw/JobiCm61sNzw3VCQFBI/xOBwQB4gaht/5kItgttklhepQpI1
        HfqcIfEXU0IVSghVyUM0mgM=
X-Google-Smtp-Source: AGHT+IHzX9yaXcV3QWlXu9GSfGAVCIcJ0SoqRGEZUbBLGj/4l7W7+zG+ktg0AVC5pcCKK+R9qYOBXQ==
X-Received: by 2002:a5d:5947:0:b0:32d:9e4f:7190 with SMTP id e7-20020a5d5947000000b0032d9e4f7190mr2723978wri.60.1697570871353;
        Tue, 17 Oct 2023 12:27:51 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o2-20020adfeac2000000b0032cc35c2ef7sm435897wrn.29.2023.10.17.12.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:27:51 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Alexander Couzens <lynxis@fe80.eu>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 3/6] wifi: mt76: limit support of precal loading for mt7915 to MTD only
Date:   Tue, 17 Oct 2023 21:05:07 +0200
Message-Id: <20231017190510.27163-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017190510.27163-1-ansuelsmth@gmail.com>
References: <20231017190510.27163-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit support for precal loading for mt7915 only to MTD. Passing data
from DT doesn't support offset and NVMEM require a different cell name
and doesn't support offset hence only MTD way is actually supported.

Rename mt76_get_of_eeprom_from_mtd to mt76_get_of_data_from_mtd as it is
now used for a more generic purpose and export it.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c        | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h          | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 1de3c734e136..817074a5d2fc 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -28,7 +28,7 @@ static int mt76_get_of_eeprom_data(struct mt76_dev *dev, void *eep, int len)
 	return 0;
 }
 
-static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len)
+int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len)
 {
 #ifdef CONFIG_MTD
 	struct device_node *np = dev->dev->of_node;
@@ -105,6 +105,7 @@ static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offs
 	return -ENOENT;
 #endif
 }
+EXPORT_SYMBOL_GPL(mt76_get_of_data_from_mtd);
 
 static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
 {
@@ -149,7 +150,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	if (!ret)
 		return 0;
 
-	ret = mt76_get_of_epprom_from_mtd(dev, eep, offset, len);
+	ret = mt76_get_of_data_from_mtd(dev, eep, offset, len);
 	if (!ret)
 		return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index e8757865a3d0..f6c850557447 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1095,6 +1095,7 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_phy *phy);
+int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len);
 int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 
 struct mt76_queue *
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 76be7308460b..5228f710b3da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -25,7 +25,7 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 
 	offs = is_mt7915(&dev->mt76) ? MT_EE_PRECAL : MT_EE_PRECAL_V2;
 
-	return mt76_get_of_eeprom(mdev, dev->cal, offs, val);
+	return mt76_get_of_data_from_mtd(mdev, dev->cal, offs, val);
 }
 
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
-- 
2.40.1

