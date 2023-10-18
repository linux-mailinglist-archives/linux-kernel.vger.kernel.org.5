Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7417CDCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjJRNKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjJRNKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:10:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD8F7;
        Wed, 18 Oct 2023 06:10:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso60329821fa.3;
        Wed, 18 Oct 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697634641; x=1698239441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WIYTERMpa/hQ3nYRT3WjhR5KvI3DYiqFx8C9H6a/AQ=;
        b=lNWsNGayi00fyI33JdnRcA9H0i70H+ss+eHrV8nraqgUvwKzP18+oBgmJP/Ffdtxvw
         0uENuC1dN3qRym5YW/ozONK0y+c5vj3Y8NTWz8fYnn0g1Fvyveh5I/mvaADyke2NQpc8
         3/c5s+gfmg7xyQ6IWQGH1DDTXP3fCmL4YZ5FRqHhAXuUIwiuMCjR/PLKVnjNjVtbxDOL
         LPRpFTTssZcZHDVBKi3YkaUEBbybOlRpYeMcBLQtfImmTgEdj57cXT65laoC3+5lHw6B
         B+bHZo2T7wcD8j5xvFcR80LAATYgFb0M4tB8cXBmR7WLVPLCTqWY4iLv3R4/U9tEJIHR
         Nu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634641; x=1698239441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WIYTERMpa/hQ3nYRT3WjhR5KvI3DYiqFx8C9H6a/AQ=;
        b=HBqgwY4fPFv2dkKFCb0c/K4rxLs7JKqb1yJnEJYD4CKxq47RBoMO5B55RMMS52cwFY
         B9SzDM5fu0xZeUFL4ahdA4SZ/+t9IShQ4kcDmez4SfarHHi8QwiyNyHy+jPrYl3jLF/S
         Iy2r3HDLs8fydXUFOsQrhyIj/leH2dFHw4WbPjMMO8LbpoIlKm9z0/nIBIlSeNc4esv/
         wkmGCUvwcr+LdSCXI330u8UdioEpGVUlFR4J2bSZJNIuCfjK5mrcl4sdBQJ4DsfqNU7+
         aEniEwHyy4bb8eururvkNJ9FdGWjQ7QePFc+uyXZ7Z3qt+HxJbruddLCWqcQNz7KC3z+
         hv5A==
X-Gm-Message-State: AOJu0YycjdldEcYZLYx5rRq61bKvoN7vMu8LyUQmfSf0J6ZPfyoi1FiQ
        mT7CFpKh1vm/qURQzyxh4hc=
X-Google-Smtp-Source: AGHT+IGfdJUpk8Rdt2SKdTJZt1PuOoBqvCcCill/y7BxjK6YaWEs7dFTajSyDUWp2IXypz6opVTCQA==
X-Received: by 2002:a2e:9c43:0:b0:2c5:234b:d1eb with SMTP id t3-20020a2e9c43000000b002c5234bd1ebmr3001799ljj.50.1697634640737;
        Wed, 18 Oct 2023 06:10:40 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u6-20020a05600c138600b004064288597bsm1677426wmf.30.2023.10.18.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:10:40 -0700 (PDT)
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
Cc:     stable@vger.kernel.org
Subject: [PATCH v2 1/6] wifi: mt76: fix broken precal loading from MTD for mt7915
Date:   Wed, 18 Oct 2023 15:09:37 +0200
Message-Id: <20231018130942.31187-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 495184ac91bb ("mt76: mt7915: add support for applying
pre-calibration data") was fundamentally broken and never worked.

The idea (before NVMEM support) was to expand the MTD function and pass
an additional offset. For normal EEPROM load the offset would always be
0. For the purpose of precal loading, an offset was passed that was
internally the size of EEPROM, since precal data is right after the
EEPROM.

Problem is that the offset value passed is never handled and is actually
overwrite by

	offset = be32_to_cpup(list);
	ret = mtd_read(mtd, offset, len, &retlen, eep);

resulting in the passed offset value always ingnored. (and even passing
garbage data as precal as the start of the EEPROM is getting read)

Fix this by adding to the current offset value, the offset from DT to
correctly read the piece of data at the requested location.

Cc: stable@vger.kernel.org
Fixes: 495184ac91bb ("mt76: mt7915: add support for applying pre-calibration data")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 36564930aef1..2558788f7ffb 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -67,7 +67,7 @@ static int mt76_get_of_epprom_from_mtd(struct mt76_dev *dev, void *eep, int offs
 		goto out_put_node;
 	}
 
-	offset = be32_to_cpup(list);
+	offset += be32_to_cpup(list);
 	ret = mtd_read(mtd, offset, len, &retlen, eep);
 	put_mtd_device(mtd);
 	if (mtd_is_bitflip(ret))
-- 
2.40.1

