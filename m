Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFAB79B5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbjIKU6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjIKMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:32:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C161B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:32:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fbd31d9deso793060b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694435520; x=1695040320; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kKTe1T75lovUyiyBDcmoT8Re7ucuewSdAO9f367BwM=;
        b=Rwxc/xLGcPRixm/1KE48FAQqsgQ2TLg59eRneGqU16+po4ZCUWMuN/AROV96wmEH60
         HIdp+Jp0g+Ryf/gzQZarWLaMohbxQsgABHZKwThV251V3/I4unTKvWWTIFxKc2NgITM2
         BP7YiE3RRNZimAYL/plVag+IwoyLVd3feHE4cXj8Gct39DzCSQKWBQlXXekwcXGrBS4a
         NVPMyzPiUbXomAkrMLIxtNoh8bneg5FTnqdrANKbqRa0JVXTstx7f4vyIMS4Gj9nhB2n
         5DKdCDIpt1dWe8YJVvwMtRVsv950XnsP9C48dv7EPeOgqAenekpr/OGB8x6Ra7wigs1Q
         uyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694435520; x=1695040320;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kKTe1T75lovUyiyBDcmoT8Re7ucuewSdAO9f367BwM=;
        b=KwqG3Z+QGqxyniQNHbFQwzDxUDjDoZ8TH9hKA4QPl8F9GZq43womOGSK1ZknX4WgGu
         E+wQI7SwNbZ8I/TU505J8l2Uqnz3BPUEGa/KpvR8i2725bMzQWCXdmxCYq3DSqqeRHCS
         4mr0Fg1BpWj7jLDac5iUEg8/O5GYihJp0myGbHAs80phL9/x7gGpJ6Xa8tCNdlLtbh9M
         q06LwviR3sn1AidPuDnkPeCZXpIzwAEhudb+S5BaDL33/acKXiJA0btI4KJHLCNOfUVl
         EEF7tQGOBf6jOflJHdxjCVEko+IpuHGjjAF/Wrg+Bhpl5c+2uSghPErBUk0rT9isQSqd
         Jdtg==
X-Gm-Message-State: AOJu0YwydVTc+gsUjvF7B7Kr6k2h6Od1P1wLvqIzzm5YJgMC+2gFXWxG
        2dCwQbS56fgyPiRFnxLqRj8=
X-Google-Smtp-Source: AGHT+IEMabRYMAN4VuhMD5tbvhXixocNtk9qgXw0p2/MmKHXYFDqDg9GCB9eM1hRn/wvRYOfYrptqA==
X-Received: by 2002:a05:6a20:7349:b0:153:7978:4faa with SMTP id v9-20020a056a20734900b0015379784faamr9399342pzc.37.1694435520166;
        Mon, 11 Sep 2023 05:32:00 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([106.205.101.29])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0064d74808738sm5492186pfm.214.2023.09.11.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 05:31:59 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:01:55 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: vt6655: Type encoding info dropped from array
 name "byVT3253B0_"
Message-ID: <ZP8Iu+Hh8YD+VhYH@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

 v3 -> v4: changelog modified as per patch submission guidelines

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

