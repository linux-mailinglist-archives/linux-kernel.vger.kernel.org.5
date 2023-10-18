Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283A17CDCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjJRNLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjJRNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:10:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8EE121;
        Wed, 18 Oct 2023 06:10:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40839807e82so6244565e9.0;
        Wed, 18 Oct 2023 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697634648; x=1698239448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGsOIe2+gPILwGffb1seZvDCNStpRAryY2lIF4RhpfU=;
        b=P12hSEyKzWUjCTpsnuYPfSMIaiBzDveTQlI055qzkKokR+prIbcWABw5lld2BLtmYy
         /kVZp0DgfFhhd214UHSlmGZNX4ivk/s+ffwZHekKmOWU2BKVNwJrMXQ40ffvFBDKjiQs
         NJ1qkLjBjqGqqIFjJ1Webo6CBlu045v3pdaiCR4dlVui2lelATmhifQ+utdQqyHy+ejz
         YzSDFoWlS+k2RsLVy3bh1tgrDfhtsp8TSb3j6Nf0pERG23cQtRlWmKAB5kjT6tt4cpSO
         uNiUoF+ebxRrUM1pLXtarSH932O1QdGMVMPte2nhgPnNoFVAcADlqqocaCld75EHJyCw
         WNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634648; x=1698239448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGsOIe2+gPILwGffb1seZvDCNStpRAryY2lIF4RhpfU=;
        b=KRFMWbPJxSlSsF+TSd63B+S2KRzdHQUpC64+Ja1oUMFSc94wJ22kgMIx5tnUwDI4h6
         pdalNdH/DVlzUityngV+8B5NitbA9RLdq5gtC0tGJaff28H+m3rqqtrOdyCo1RTtODSN
         IMJdSkX1vS1iMtLKH+RPXwcjoQMudw4IaaGe/VNMJsw+CdrndZWjg+WQGC2jZ8mYca6r
         aCzLZ4uXSeyBI7jhguOQK+8YLK0IUI6kiCkpC7tDlZj+4VGqk/rZc1RuVpeYxZra6MUB
         OOGpCN+s36dA1cxNOr5NpdNoarrxmMElAq5kn3wrUt78lozN/4GkcQxNsKqr7XaTramJ
         psww==
X-Gm-Message-State: AOJu0YwI/PTeTHzcTqqE9hGe8zyA9a1Z09e/m3kZ7iujg3uGH6LoyHY6
        xSTR2A4E/RnodGv4c3M5RI4=
X-Google-Smtp-Source: AGHT+IE+sCuWLXpMpKKSnIlfOUq+4N22pU9jPx36Nsbry/7Ty+ZgoJU7ODY9iOR5ZJrkAcpV+SNbSw==
X-Received: by 2002:a05:600c:4ecb:b0:3fe:1fd9:bedf with SMTP id g11-20020a05600c4ecb00b003fe1fd9bedfmr4798254wmq.11.1697634647542;
        Wed, 18 Oct 2023 06:10:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u6-20020a05600c138600b004064288597bsm1677426wmf.30.2023.10.18.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:10:47 -0700 (PDT)
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
Subject: [PATCH v2 6/6] wifi: mt76: permit to load precal from NVMEM cell for mt7915
Date:   Wed, 18 Oct 2023 15:09:42 +0200
Message-Id: <20231018130942.31187-6-ansuelsmth@gmail.com>
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

Permit to load precal from NVMEM cell for mt7915. The NVMEM cell must be
named "precal" to be correctly loaded.

NVMEM cell must already account the correct offset and be placed after
the EEPROM as the function expect the data right from the start.

Tested-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 5228f710b3da..3bb2643d1b26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -11,6 +11,7 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 	u8 *eeprom = mdev->eeprom.data;
 	u32 val = eeprom[MT_EE_DO_PRE_CAL];
 	u32 offs;
+	int ret;
 
 	if (!dev->flash_mode)
 		return 0;
@@ -25,7 +26,11 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 
 	offs = is_mt7915(&dev->mt76) ? MT_EE_PRECAL : MT_EE_PRECAL_V2;
 
-	return mt76_get_of_data_from_mtd(mdev, dev->cal, offs, val);
+	ret = mt76_get_of_data_from_mtd(mdev, dev->cal, offs, val);
+	if (!ret)
+		return ret;
+
+	return mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", val);
 }
 
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
-- 
2.40.1

