Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA57CDCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjJRNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjJRNKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:10:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1439112;
        Wed, 18 Oct 2023 06:10:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f613272so3680495e9.1;
        Wed, 18 Oct 2023 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697634642; x=1698239442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2HMXOLF5eJrUMENCt8aiW3aj9mFErqyM1uPwOqtdoQ=;
        b=NBiaamK4tLf/pEsdoBDctC8ja8rrZYlkkF+f+eRusURjMFf56vq1X2tyDyxYxUfo8e
         Fe6KfJGuGMq693I20k3l93yVXjVevxMCrMdIbqZRairIFitnfp4h7rThaxX1PLqXeyJW
         RYp1QavzyLp1VEO7/CBDv2+XpYKogsDjiffO2MjVcC6jBvJjClYZm7KH1AYM0lBoF/+y
         IG1kv1VAKC6ranWF3xkYrX79N0qeTWdq8v3e585ruTlrtPK9swrr0Z+vc1Z2gOq45wKx
         ZMucc2GVZPhzozHJHVwhlGMhKuGL6ZRD0pQwZttnMh32Mfm4K4SGdopR1FIAl/R478+V
         MxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634642; x=1698239442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2HMXOLF5eJrUMENCt8aiW3aj9mFErqyM1uPwOqtdoQ=;
        b=QFnJkHuS+CVEJgA/va4d3nwVjCSDqosLnnoNCSxwRo6oDeknZ0HOuh4tIR6xPgpPvD
         NvXpiUhKRPXtTaZYYeeGmSVU8YgnlrlqRr6pLZvFTvcQKaIW+oIS5dKL1QRFdl17OM2N
         6ZOcUkloMAW4BOB+v4CYaTXzgDhckzlXXEFflUBS/PLimqlVTEGJkptI++B+ixPO0Spx
         LyzTT6ilUMcwPrbSVrzQfmwe6BekmwU1t5A6DZh3NEwFjzzhEhQQKOxd7S/9T344MCW+
         /sWzp5H77lGnImXERAC8Kvz2eOqJ+LaC+0/dlWT86QqC5d4HhxKNnDqhPMiFRyASgsjz
         nVzw==
X-Gm-Message-State: AOJu0Yzpdw7QRNfBucaLq1tTuMIpSAp8QiSXQBOn6fiMJLW5hvg4Prhu
        wrkDcbRDlKCcTbvHecrTeKY=
X-Google-Smtp-Source: AGHT+IGmg6G6k+IuVKLb4jSB/GGObbEUK/LFeHNrmueMinKJQgCi6tbVJYrMJG5JhYp3Ipf9kO4icw==
X-Received: by 2002:a05:600c:3112:b0:406:7d74:a2a4 with SMTP id g18-20020a05600c311200b004067d74a2a4mr4096893wmo.12.1697634642056;
        Wed, 18 Oct 2023 06:10:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u6-20020a05600c138600b004064288597bsm1677426wmf.30.2023.10.18.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:10:41 -0700 (PDT)
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
Subject: [PATCH v2 2/6] wifi: mt76: fix typo in mt76_get_of_eeprom_from_nvmem function
Date:   Wed, 18 Oct 2023 15:09:38 +0200
Message-Id: <20231018130942.31187-2-ansuelsmth@gmail.com>
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

Fix typo in mt76_get_of_eeprom_from_nvmem where eeprom was misspelled as
epprom.

Fixes: 5bef3a406c6e ("wifi: mt76: add support for providing eeprom in nvmem cells")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 2558788f7ffb..1de3c734e136 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -106,7 +106,7 @@ static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offs
 #endif
 }
 
-static int mt76_get_of_epprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
+static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int len)
 {
 	struct device_node *np = dev->dev->of_node;
 	struct nvmem_cell *cell;
@@ -153,7 +153,7 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	if (!ret)
 		return 0;
 
-	return mt76_get_of_epprom_from_nvmem(dev, eep, len);
+	return mt76_get_of_eeprom_from_nvmem(dev, eep, len);
 }
 EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
 
-- 
2.40.1

