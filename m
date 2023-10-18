Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA97CDCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbjJRNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjJRNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:10:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D53BF7;
        Wed, 18 Oct 2023 06:10:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so75787301fa.0;
        Wed, 18 Oct 2023 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697634643; x=1698239443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0xHAajk9RnoZnMNxnlpPx/L53pYS94eDmnmY1A3Dok=;
        b=K3q+w5NJ3hXLor0cf94n7ykfN0ydt9qB6O+TDqOAHGztgZ2n9OBLK+hg2eEdYO+4qs
         1lcQs5W03Lf1QDxDZaCMuETtzKRAFiZpZiT5bc7fkA8mn3veveBoCmiZuAyaS8VDVkZ6
         ahp0vDbgPbqDkMDl9vsr3Fv0dYsdg5cZOtv1c5sBnmKQdwTsdESpE70fIfsUd3ykQDGo
         a2GBXzGpJYF5wbAiJxLK0Y30KCBa9aZhtC+ityYrJUizV80l+hxWQ4XeW6ofEXSQzM3D
         8TO6J97TVdWNI26Yl0jTcm4NkToZCz82uxRGjvxCxQKyxA1qjij+fTsciB+wnRcU2rxn
         dpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634643; x=1698239443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0xHAajk9RnoZnMNxnlpPx/L53pYS94eDmnmY1A3Dok=;
        b=NtOAzLs59j1t7/P7X57cRlwp5vv5kcT7iBXF69rPAkcVgiUmmjlUuJHALkxpMoISoh
         3TDz78SmQx4NUR/XnJdzHVoKBt5twKMlLl8XP39f/BQfPEZbU7jjjMUufeNpNjJgpu8m
         6rcHzENaBvYGtnBBrj6RFxhP/Of5UPxwClGSISEhkNI5Y0ixH1tgIA0Ce52NC/Ma+XMY
         5DwRVxdL7pefdjMo+EdNn2ycmA7a41vSudlKIk+0Zk+8NNQkVF8VyYxFgW66CmmcF4bH
         D28wfi/hl4utFQmIrFE5BYwRAGrmExV0iI+AEwUssU39kRXfwGIDxwhNPrasSE882th+
         LVjg==
X-Gm-Message-State: AOJu0Yyw1FY8uL7yU0pLuKsO/+0vKfqgar+/8VJ8w+6gz05lEQ+dBoKm
        JQM6YfvSSZpOeoTvU8uwqlw=
X-Google-Smtp-Source: AGHT+IHZCFm/FKSHMNPJ/gTl2cJ2yrV7x+5Y+s67036BkIQ4yBSpE954a8LCaTXr/6eaaE0F0B7daA==
X-Received: by 2002:ac2:4550:0:b0:507:9a13:27bd with SMTP id j16-20020ac24550000000b005079a1327bdmr3842384lfm.7.1697634643446;
        Wed, 18 Oct 2023 06:10:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u6-20020a05600c138600b004064288597bsm1677426wmf.30.2023.10.18.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:10:43 -0700 (PDT)
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
        Alexander Couzens <lynxis@fe80.eu>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/6] wifi: mt76: limit support of precal loading for mt7915 to MTD only
Date:   Wed, 18 Oct 2023 15:09:39 +0200
Message-Id: <20231018130942.31187-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018130942.31187-1-ansuelsmth@gmail.com>
References: <20231018130942.31187-1-ansuelsmth@gmail.com>
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

