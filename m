Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71517CCC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbjJQT1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjJQT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:27:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5CEC6;
        Tue, 17 Oct 2023 12:27:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so5658559f8f.3;
        Tue, 17 Oct 2023 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697570869; x=1698175669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WIYTERMpa/hQ3nYRT3WjhR5KvI3DYiqFx8C9H6a/AQ=;
        b=mN+Kr5BmdVMGY371zJxVibPw+3d31Zy3jAgCCo4GNabPH2fl+7gNrRlr9ORmrgEgpF
         BLN54B9UlEfuFHVmY9Ynf11/GFUUjxsjeuVxUkxKujgCdSPQGgjT8tdDF5O8XdVD2FS8
         Kyvu2YCEANJRPXEbc7sw76VzuXpbHDyEGJDgRP8Tx1PaO930ihKXf3g1QRpV9dumAOFb
         EWWPEZ65YU7S3CzohLXx9Bu5rqqtQ5keBb0nnIYmEAVhSD9guf/jzxrZJ2LlKe2Y0U6f
         iOcJxUX92JUzTvHoqJdaLtFzRvJAf62TFA6KsTwriX6o+mF33QHkTFIt0uOdf84MvP6k
         XdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570869; x=1698175669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WIYTERMpa/hQ3nYRT3WjhR5KvI3DYiqFx8C9H6a/AQ=;
        b=hz3clvnV8/cDZXV0hb7E4wGl+uSreKniDYaP+hxL9qKGsljU4OkjfycSQcLDiNogt+
         ujFJIZnuPP1DO5AKjU4T+rLnaP5uNjlA+YrZnn1tSUZd8wLbMQmn0zQvhxk157C/c9Q7
         S4GoZ23iZHMnQj5i6aqAn5b/iO9NsQpCTfLvTYimfA/Hwy3Rtib7IDYRvlGsfP4SAfNE
         aUuqcA7Quqk9Kw7ejAV4oPkkpa9IJlk654BcPAmswnppfAt2NYELqd42edT5xAGNS82n
         W7khQ1hkdp9g1RuttxmYbb7LuMRrq5NGVsG+PPVDWuWl4JSnQgQ89rwtb4eBExeEMk/N
         SG4w==
X-Gm-Message-State: AOJu0YzAScHD0o1XxSMFfbWeP/t4N2OVSaY4R8iyJzh1VcvKIuk8K6CA
        9/JsxjDfBCom7LU2LrPqSIsK6e+FZRA=
X-Google-Smtp-Source: AGHT+IH1sIJVj6vXFk3PsUqXsDejVqOQyTaC/4Gh2c9aKr1SO/xiGQdSW9KnyI9IseCxWCSAKxk3+A==
X-Received: by 2002:adf:f7c3:0:b0:32d:89b5:7fd9 with SMTP id a3-20020adff7c3000000b0032d89b57fd9mr2562686wrq.56.1697570868914;
        Tue, 17 Oct 2023 12:27:48 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id o2-20020adfeac2000000b0032cc35c2ef7sm435897wrn.29.2023.10.17.12.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:27:48 -0700 (PDT)
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
Cc:     stable@vger.kernel.org
Subject: [net-next RFC PATCH 1/6] wifi: mt76: fix broken precal loading from MTD for mt7915
Date:   Tue, 17 Oct 2023 21:05:05 +0200
Message-Id: <20231017190510.27163-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

