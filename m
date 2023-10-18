Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0156E7CDCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344557AbjJRNLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344378AbjJRNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:10:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F7112;
        Wed, 18 Oct 2023 06:10:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a98517f3so4752997e87.0;
        Wed, 18 Oct 2023 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697634645; x=1698239445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IL6KY3EzM2BxcqkNoWLsWmWA0zN5X5Kl3affJBzO2c=;
        b=BLrAEY0fgevarBy/LLt4N6BpG4G73s5WtdlTKJdq26tB+I74WxdHRKhqn5BIuwRwC/
         VbF0gzkzLrXo5UWRwfaYhdrcWiEc/PypuXrC0gmdiZZNeM0+z0HeiCxhFwA0DgRBOK6X
         KxlDh65wdshvhJHTzhE7sKVwTbHon2/ZwifOhFxPDmUK5xs8haFOWDGVgzfzvdnZ43KE
         gRfgJOr7A4ahDIEDNckwexMccGNL7wFmmiS1siWHh3fTYNqZGh4dmcaI8GPpTrx9Ez/L
         vyrvT/Pl4HABCL45X+aTs5I4tK0QG6gACDUeKtR923jz5pFQJYbstH4FudlrRGQmA0lJ
         Sf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634645; x=1698239445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IL6KY3EzM2BxcqkNoWLsWmWA0zN5X5Kl3affJBzO2c=;
        b=EOR+TEslv9Lf+L5YTEp46IEHwft30OsDanZUyavsYJDTrxT9CymeEqLBvbfSgKoTEi
         X2U8h8BSA++vOuVnQCk2Ti8vZVRaiFf6QSlHsCJHsY//cI7U+SlRyTgu4qTum+fmCJ1Z
         czdWO1vXpEIdT+QO30YiAuVZK9faqWq3M6b2V/XBqmsbMWZybqRho58Hb+23Xbhv9C+j
         YxPs9c1hpi+6elWWcmwuT6QmxXJRml3xFOIyGat+rpR6WAXm5NwQpw78n+piMrJyKLCB
         VNMY9DBMXSoZgnwYtBBPxoOpjqcDfx753AXmaob8yELvMgweX6E0Guk9PTfV/5gYM2+t
         epLg==
X-Gm-Message-State: AOJu0YwVXz8vQ+YUE5K1cByjlpZiO9vaVd5t1aF6+dW+D5tsH1t2qa3P
        2oxgI4XVP6aXkK9dV333yY8=
X-Google-Smtp-Source: AGHT+IHVrlIY0nKXXNIA7AIoU3XvDxI2gChao7CZ4wvCGgAaU+xe/hqRNOJjT76PDnhKoWnpatNjrA==
X-Received: by 2002:ac2:4245:0:b0:4f8:77db:1d9e with SMTP id m5-20020ac24245000000b004f877db1d9emr4117861lfl.12.1697634644820;
        Wed, 18 Oct 2023 06:10:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u6-20020a05600c138600b004064288597bsm1677426wmf.30.2023.10.18.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:10:44 -0700 (PDT)
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
Subject: [PATCH v2 4/6] wifi: mt76: make mt76_get_of_eeprom static again
Date:   Wed, 18 Oct 2023 15:09:40 +0200
Message-Id: <20231018130942.31187-4-ansuelsmth@gmail.com>
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

Since mt76_get_of_eeprom is not used by mt7915 anymore, unexport it and
make it static again.

Also drop offset arg as it's only supported for MTD and was always set
to 0, hardcode the MTD functio instead.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 7 +++----
 drivers/net/wireless/mediatek/mt76/mt76.h   | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 817074a5d2fc..748f4b643a5e 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -138,7 +138,7 @@ static int mt76_get_of_eeprom_from_nvmem(struct mt76_dev *dev, void *eep, int le
 	return ret;
 }
 
-int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
+static int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int len)
 {
 	struct device_node *np = dev->dev->of_node;
 	int ret;
@@ -150,13 +150,12 @@ int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 	if (!ret)
 		return 0;
 
-	ret = mt76_get_of_data_from_mtd(dev, eep, offset, len);
+	ret = mt76_get_of_data_from_mtd(dev, eep, 0, len);
 	if (!ret)
 		return 0;
 
 	return mt76_get_of_eeprom_from_nvmem(dev, eep, len);
 }
-EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
 
 void
 mt76_eeprom_override(struct mt76_phy *phy)
@@ -410,6 +409,6 @@ mt76_eeprom_init(struct mt76_dev *dev, int len)
 	if (!dev->eeprom.data)
 		return -ENOMEM;
 
-	return !mt76_get_of_eeprom(dev, dev->eeprom.data, 0, len);
+	return !mt76_get_of_eeprom(dev, dev->eeprom.data, len);
 }
 EXPORT_SYMBOL_GPL(mt76_eeprom_init);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f6c850557447..41e4f398083e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1096,7 +1096,6 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_phy *phy);
 int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int len);
-int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
-- 
2.40.1

