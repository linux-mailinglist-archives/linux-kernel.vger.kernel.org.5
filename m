Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586A799738
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 11:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbjIIJ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 05:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjIIJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 05:57:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDB59D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 02:57:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so2399717b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694253464; x=1694858264; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XD+8pYxUi+ogRHv4AC7gYe0Zq88ppHoOhVnzae3sPE=;
        b=PDgILYsmxmqsPDXztLrAy50mhpPVaz1t723nW59gqeshnEMqYru8XAxkjs3ZgTfb16
         ZjO1e+Go8Bu6CJDdVtUuO4SW7GQaibuekdcg1HiIhf4P3w1B/YBGk+2ru5jNNx4FAlGS
         9W2H0bt8Sr9FUfNXvazI+uvsdtgTfcsDZUJg+29Yb+Qv19sez19elsXknHHlI3OYnEIA
         BiRjwwHPrZQgAJQuH9OdDedebwh41mRFDHX3BPQGtxRDOy8Wke8dp2wO50PXNWzkf7cW
         Lmf1jO5btedCbhIY1nSx8S9BG9hYcSTsI2Afga9Y/oE7H7ljHemaEhc1NMWJ0eD2yNZ9
         +wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694253464; x=1694858264;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XD+8pYxUi+ogRHv4AC7gYe0Zq88ppHoOhVnzae3sPE=;
        b=tF/Wr1GUUh68Qz8zpp+KvtjhfoaKD/ppkmbi3YgzKFkE11Np4ym9s8mDIXTieFrljK
         1HbJu6k96j0q28dz5BnQvNv0G5h+Vl8wKCaKAVpVyigxjO8ce2uS4MreTt/MfllhF4gU
         JRXThHtb1w0sGVtKy5mp72ztVNb+Dk8Ht3HQUX8gG/9zvU/GyJuy/YTrw4cnHuHaSfvY
         rrCRPCa3WDsBQKDOQOoqEzLFs8R3WGNRDD5eBpFahWTUHLt2iveE6PuB3C9enNhU315+
         8dtDHkX+F43/b1RXFfDQ3veAnbzaIEF1qXZxkgOqXVasnUoBkXysuJUq4ZOGWXNLr9pg
         CwuQ==
X-Gm-Message-State: AOJu0YxWhrL3Eddqp/AnGLCPvm9eiMGtU1E7VPCCNab69MXANYaELMP6
        QCS40dyStw/VXumDvofwN3E=
X-Google-Smtp-Source: AGHT+IHmTxXaOnLWPjRC22e3VrJ6vLDOa5LDhi++Th5Mt7HyB2rRUET0Dhzo+UO65cQrppH2zg0oEg==
X-Received: by 2002:a05:6a20:7f81:b0:13a:ccb9:d5b7 with SMTP id d1-20020a056a207f8100b0013accb9d5b7mr5531917pzj.41.1694253464534;
        Sat, 09 Sep 2023 02:57:44 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([223.178.252.251])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b001b8a1a25e6asm2922397pli.128.2023.09.09.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 02:57:44 -0700 (PDT)
Date:   Sat, 9 Sep 2023 15:27:40 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: vt6655: Type encoding info dropped from array
 name "byVT3253B0_"
Message-ID: <ZPxBlBG7ObqsDMOS@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Array names starting with "byVT3253B0_" updated like below:

a.type encoding info dropped from names
b.camelcase names replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 v1 -> v2: Name of the tool added in the body of explanation,
            which found this issue

 v2 -> v3: subject modified to more specific detail
 
 v3 -> v4: changelog modified to fix indentation and breif description

 drivers/staging/vt6655/baseband.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 696d4dd03aa2..55224918794b 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -761,7 +761,7 @@ static const unsigned char vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
 #define CB_VT3253B0_AGC_FOR_RFMD2959 195
 /* For RFMD2959 */
 static
-unsigned char byVT3253B0_AGC4_RFMD2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
+unsigned char vt3253b0_agc4_rfmd2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
 	{0xF0, 0x00},
 	{0xF1, 0x3E},
 	{0xF0, 0x80},
@@ -962,7 +962,7 @@ unsigned char byVT3253B0_AGC4_RFMD2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
 #define CB_VT3253B0_INIT_FOR_AIROHA2230 256
 /* For AIROHA */
 static
-unsigned char byVT3253B0_AIROHA2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
+unsigned char vt3253b0_airoha2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -1223,7 +1223,7 @@ unsigned char byVT3253B0_AIROHA2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
 
 #define CB_VT3253B0_INIT_FOR_UW2451 256
 /* For UW2451 */
-static unsigned char byVT3253B0_UW2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
+static unsigned char vt3253b0_uw2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -1484,7 +1484,7 @@ static unsigned char byVT3253B0_UW2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
 
 #define CB_VT3253B0_AGC 193
 /* For AIROHA */
-static unsigned char byVT3253B0_AGC[CB_VT3253B0_AGC][2] = {
+static unsigned char vt3253b0_agc[CB_VT3253B0_AGC][2] = {
 	{0xF0, 0x00},
 	{0xF1, 0x00},
 	{0xF0, 0x80},
@@ -2010,8 +2010,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 
 			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253B0_AGC4_RFMD2959[ii][0],
-					byVT3253B0_AGC4_RFMD2959[ii][1]);
+					vt3253b0_agc4_rfmd2959[ii][0],
+					vt3253b0_agc4_rfmd2959[ii][1]);
 
 			iowrite32(0x23, iobase + MAC_REG_ITRTMSET);
 			vt6655_mac_reg_bits_on(iobase, MAC_REG_PAPEDELAY, BIT(0));
@@ -2027,12 +2027,12 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else if ((by_rf_type == RF_AIROHA) || (by_rf_type == RF_AL2230S)) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AIROHA2230[ii][0],
-				byVT3253B0_AIROHA2230[ii][1]);
+				vt3253b0_airoha2230[ii][0],
+				vt3253b0_airoha2230[ii][1]);
 
 		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
+				vt3253b0_agc[ii][0], vt3253b0_agc[ii][1]);
 
 		priv->abyBBVGA[0] = 0x1C;
 		priv->abyBBVGA[1] = 0x10;
@@ -2045,13 +2045,13 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else if (by_rf_type == RF_UW2451) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_UW2451; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_UW2451[ii][0],
-				byVT3253B0_UW2451[ii][1]);
+				vt3253b0_uw2451[ii][0],
+				vt3253b0_uw2451[ii][1]);
 
 		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0],
-				byVT3253B0_AGC[ii][1]);
+				vt3253b0_agc[ii][0],
+				vt3253b0_agc[ii][1]);
 
 		iowrite8(0x23, iobase + MAC_REG_ITRTMSET);
 		vt6655_mac_reg_bits_on(iobase, MAC_REG_PAPEDELAY, BIT(0));
@@ -2067,12 +2067,12 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else if (by_rf_type == RF_VT3226) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AIROHA2230[ii][0],
-				byVT3253B0_AIROHA2230[ii][1]);
+				vt3253b0_airoha2230[ii][0],
+				vt3253b0_airoha2230[ii][1]);
 
 		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
+				vt3253b0_agc[ii][0], vt3253b0_agc[ii][1]);
 
 		priv->abyBBVGA[0] = 0x1C;
 		priv->abyBBVGA[1] = 0x10;
-- 
2.34.1

