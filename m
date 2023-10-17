Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8F7CCC43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbjJQT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344217AbjJQT14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:27:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814CC4;
        Tue, 17 Oct 2023 12:27:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d9552d765so4721360f8f.2;
        Tue, 17 Oct 2023 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697570873; x=1698175673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3IL6KY3EzM2BxcqkNoWLsWmWA0zN5X5Kl3affJBzO2c=;
        b=mIlJcPArnJgQomXy/OLwHjgp6ApElaFgJHcObYMEtxFUgwJOpXYr2JHGHWfHQ08GCC
         RLN68dcLJMnYlUsSArEQVAenJxuj+uvaVgKqlxsQ87TNQpP81aDPPQklYBnMKwim0nqm
         r/ZyC5FCVhtwFRtMDjYIwTxlDTozXcRo328GuYQTV6mbqq6kDpeTrLBUcALG1BROc3zk
         OUPpv67bSS/hvEUlqY+XqeljTk4cIHFZmFqESf+6qv7i6Y9G6pEI1rjEiqoaefRys8HF
         Z5hD3afBL59x/UsT63BPl912RF3uZ6Zb6lyyCbUy6GQ5+kDfcO2RPvQRTtKovGJswTpS
         Vfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570873; x=1698175673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IL6KY3EzM2BxcqkNoWLsWmWA0zN5X5Kl3affJBzO2c=;
        b=Zq+wIvdpD+/KkMNKwDQLnZttTz3OnFAtd4aTfQNajBBpESmyogLEahs54hvS0BsTQQ
         +bIha4fiabVACWT/bxOg34pYgpgIikqlOF60DX9B2boAhlD/AQA4x8dGANdb0YTD+ub9
         ErjsJ+oDUenOrH3OSpQbj0gdUmjzXNwIq6eAFcDn0xFnhCd545f0Sw7bUQvoskJS4Adu
         1Lg1c21kMr+2539ZTnw7TFenIsVgWTwmjFOOHAr9ySxY1tLVOLyVGNgGbPblNyf5ILKp
         rhsuLr6HMXK3x9+5CfOUVnUXfiqKGhDFps2vRY0Jj82YfucxOVvPtfNV0ihZOmfFw1tA
         Wkzg==
X-Gm-Message-State: AOJu0Yz7edBWlNjr7qmHN87FXZrKlPx0IO7kK7AOb3942q1Ggs9GeUrx
        x75XpdtNRSleeKGC80VVLHA=
X-Google-Smtp-Source: AGHT+IG5U1O8F0WYcC/ShlvOiLSsSiY7RwLNMBcm6vpZV2ouHYIJnXX4mFscSuxO+x0YZ3wBKSLK9Q==
X-Received: by 2002:adf:f982:0:b0:32d:b06c:80b2 with SMTP id f2-20020adff982000000b0032db06c80b2mr2969857wrr.0.1697570872715;
        Tue, 17 Oct 2023 12:27:52 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o2-20020adfeac2000000b0032cc35c2ef7sm435897wrn.29.2023.10.17.12.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:27:52 -0700 (PDT)
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
Subject: [net-next RFC PATCH 4/6] wifi: mt76: make mt76_get_of_eeprom static again
Date:   Tue, 17 Oct 2023 21:05:08 +0200
Message-Id: <20231017190510.27163-4-ansuelsmth@gmail.com>
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

