Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BDB7CDCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344634AbjJRNLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbjJRNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:10:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA7610E;
        Wed, 18 Oct 2023 06:10:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40806e4106dso10777995e9.1;
        Wed, 18 Oct 2023 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697634646; x=1698239446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3Xg+Zl530t6+yLtJ2L7UJ10F06niahRGDT6Y4EkH+w=;
        b=ajizf1Mtx3N8lDAFvECtsA8vAnCxX2lzkrr185HbtZfRmLl01RsnB29S1cCGgnap8B
         pH/QY+szFDJQHkJvVBSgjTBIEUbqM34YtbHvZWVt66oIPPtZlK+KUHQxWBbPNicdfg3P
         AY6U5xXlH1b/ETP3lzMrBptUYwoBAHBqq4OC/LTJcEEe7trSviF60OwRtOXNGPaVFttB
         UBaC64la4w8AVAxnrnNAysZpQX1PTD2aNIQUCd04MIL1lbsH1dcTFRvEVekLXoKXFSo/
         LJZA0IGFcfwQTWfDzLGQQfNxhC4y2ik0nuiNtjvFapqSzvbvWnJKQZnnqaSAb3Kj2UCe
         2bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634646; x=1698239446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3Xg+Zl530t6+yLtJ2L7UJ10F06niahRGDT6Y4EkH+w=;
        b=MvP9Cw2PeA6gIdEUQ7U9iojw3ipBG6ayDGyckh+oObuteB8Fp/jXX7XCbUCMCfH4qF
         YfBnODyLvutt1OV5CuZVWFjW9v7WgBJQQvxLlyJXav+TWp9W62evIKgucz/3C+RgGMBD
         ixbazbMkSgTGRY6Wmu49viDJkMkoimmwD9aO/pSJiHPy3s1mwgxdFUlJuE7WOXZwAmZP
         WmvowgR0QMIjFQ2eJUTaPfAGDtcxJXjiG/ohIcC7V/otXxsVLXtkH1iYdA0tIAiCF2kA
         HikIJmDwHRVZCoXdPk3WsTh9/HDPRSflc90Ol+5gjpsvDcOwnrAMWsmr/Kc9WTyxFLVp
         pliA==
X-Gm-Message-State: AOJu0Yzc9Hax5ZQ3HEheRS6XXxQolNYq7x2dv2QtJHrGfUU6ZIAoD0X3
        muJ3OgP0IjiB/NVR6jAnkOA=
X-Google-Smtp-Source: AGHT+IHEbRqesj7l3D4EwIgtEAeke37ZIpRp6Fma1JEUtHbnVo9gJbSp4GsHnwTbRcZjmmaHwkjWiA==
X-Received: by 2002:a05:600c:4d0d:b0:405:3f06:d2ef with SMTP id u13-20020a05600c4d0d00b004053f06d2efmr4621449wmp.4.1697634646084;
        Wed, 18 Oct 2023 06:10:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u6-20020a05600c138600b004064288597bsm1677426wmf.30.2023.10.18.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:10:45 -0700 (PDT)
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
Cc:     Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2 5/6] wifi: mt76: permit to use alternative cell name to eeprom NVMEM load
Date:   Wed, 18 Oct 2023 15:09:41 +0200
Message-Id: <20231018130942.31187-5-ansuelsmth@gmail.com>
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

Generilize mt76_get_of_eeprom_from_nvmem to use alternative cell name by
passing the cell name as an arg and expose it.

Rename it to mt76_get_of_data_from_nvmem to better reflect the now more
generic usage.

This is to permit driver to load additional cell, like precal cell.

Tested-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 8 +++++---
 drivers/net/wireless/mediatek/mt76/mt76.h   | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 748f4b643a5e..ac6c0a0e876f 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -107,7 +107,8 @@ int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int l
 }
 EXPORT_SYMBOL_GPL(mt76_get_of_data_from_mtd);
 
-static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
+int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
+				const char *cell_name, int len)
 {
 	struct device_node *np = dev->dev->of_node;
 	struct nvmem_cell *cell;
@@ -115,7 +116,7 @@ static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int le
 	size_t retlen;
 	int ret = 0;
 
-	cell = of_nvmem_cell_get(np, "eeprom");
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
@@ -137,6 +138,7 @@ static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int le
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt76_get_of_data_from_nvmem);
 
 static int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int len)
 {
@@ -154,7 +156,7 @@ static int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int len)
 	if (!ret)
 		return 0;
 
-	return mt76_get_of_eeprom_from_nvmem(dev, eep, len);
+	return mt76_get_of_data_from_nvmem(dev, eep, "eeprom", len);
 }
 
 void
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 41e4f398083e..c9934258c49d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1096,6 +1096,8 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_phy *phy);
 int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len);
+int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
+				const char *cell_name, int len);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
-- 
2.40.1

