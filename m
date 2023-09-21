Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4680D7AA1AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjIUVFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjIUVEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:04:33 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBD63BE29
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:17:57 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-578d992c8efso650211eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695320276; x=1695925076; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2v/I6FDfxwDewdHfLw9/C7Dy7lwZoTd7fAGsGtJI1Q=;
        b=OK+GqjSC4OyCbGAi/a48iKkVPdPktJYDmIzNJnRMxfJOdnfeO9WCPlIV4qwBYHGLKc
         zuhOxtK7Pfb6R+7HC1MmEsR+2CDaJFWmjbmCEC7mfZv6hED/ZcmYD9qxlriAGRREa7Z7
         +BVabKuVzpnmi2yn2tGihuTzG1csnKZfU5oNnFoBu15pmPZVHF8u1kSU9g2nVW2me2TB
         3SQbSj3Dmp1lqF1B4vaWYuI216KWX52Jb0mGklNhctOW8m0VxdCuLlfVIkjqVg+FTMLk
         0mFDxL/uho/dNWP9V52GEhEp7h8bttrpG29Asy0FUXoSb31jLNJcE/in6hGdHIVWrHm1
         IR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320276; x=1695925076;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2v/I6FDfxwDewdHfLw9/C7Dy7lwZoTd7fAGsGtJI1Q=;
        b=m43uFs5VB+YaoFfaOFuYMtMHww/byZC58wPkncLSG2V18Vt2Y3m2tMdSZVTD62WeKd
         +5AR3uTFOaZDBHP1rl5mjC8UNGGF5rfu6hiZTTDoF33kK7XMyo0dXm4YXw88ggbdpkJg
         G24ZwMz7imtDrxiyf1jT8cP22CWt54DH7/WnOL16eZDomBQU4DoDucwp5aH08qkEX8EP
         pWtJZvsyFxU0/UbFkF595k7SFZefD8C5Gr6TubpJtAWwsKu6QNFIx+y9vxYQ7wKdTJJ1
         AV8swHzpp3QvgsCbwujKcSKnjuyrm1XERQ1cV6ufCPJHwjdr6WUC/xLTa5sDfF2ZpL1G
         Du+A==
X-Gm-Message-State: AOJu0YyuN15119qnuX49hb55C+GiQJNxcURWHIb9lQ6ws/JDSw7yKAyb
        XSIhtU4L08Ttr8zp3vTHozBPuOwbnlI=
X-Google-Smtp-Source: AGHT+IHzNJ+MR2WYl99AUt8jzIB78HYqXd8OJrcNXJ/4aiHdcHf6sg9cBICT6v7sIgOvlzIVVG7O1A==
X-Received: by 2002:a17:902:e541:b0:1bd:f7d7:3bcd with SMTP id n1-20020a170902e54100b001bdf7d73bcdmr5602780plf.50.1695298122441;
        Thu, 21 Sep 2023 05:08:42 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.162.88.67])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b001ab2b4105ddsm1322951pld.60.2023.09.21.05.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:08:41 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:38:37 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Type encoding info dropped from variable
 "byRFType"
Message-ID: <ZQwyRXFHA9hTLcyv@ubuntu.myguest.virtualbox.org>
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

variable name "byRFType" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/baseband.c    | 12 ++++++------
 drivers/staging/vt6655/card.c        |  4 ++--
 drivers/staging/vt6655/channel.c     |  4 ++--
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/rf.c          | 14 +++++++-------
 drivers/staging/vt6655/rf.h          |  2 +-
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 55224918794b..0ae2ab3987c6 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1979,7 +1979,7 @@ bool bb_write_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
  *  In:
  *      iobase      - I/O base address
  *      byRevId     - Revision ID
- *      byRFType    - RF type
+ *      rf_type     - RF type
  *  Out:
  *      none
  *
@@ -1992,10 +1992,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	bool result = true;
 	int        ii;
 	void __iomem *iobase = priv->port_offset;
-	unsigned char by_rf_type = priv->byRFType;
+	unsigned char rf_type = priv->rf_type;
 	unsigned char by_local_id = priv->local_id;
 
-	if (by_rf_type == RF_RFMD2959) {
+	if (rf_type == RF_RFMD2959) {
 		if (by_local_id <= REV_ID_VT3253_A1) {
 			for (ii = 0; ii < CB_VT3253_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
@@ -2024,7 +2024,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->dbm_threshold[1] = -50;
 		priv->dbm_threshold[2] = 0;
 		priv->dbm_threshold[3] = 0;
-	} else if ((by_rf_type == RF_AIROHA) || (by_rf_type == RF_AL2230S)) {
+	} else if ((rf_type == RF_AIROHA) || (rf_type == RF_AL2230S)) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
 				vt3253b0_airoha2230[ii][0],
@@ -2042,7 +2042,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->dbm_threshold[1] = -48;
 		priv->dbm_threshold[2] = 0;
 		priv->dbm_threshold[3] = 0;
-	} else if (by_rf_type == RF_UW2451) {
+	} else if (rf_type == RF_UW2451) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_UW2451; ii++)
 			result &= bb_write_embedded(priv,
 				vt3253b0_uw2451[ii][0],
@@ -2064,7 +2064,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->dbm_threshold[1] = -50;
 		priv->dbm_threshold[2] = 0;
 		priv->dbm_threshold[3] = 0;
-	} else if (by_rf_type == RF_VT3226) {
+	} else if (rf_type == RF_VT3226) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
 				vt3253b0_airoha2230[ii][0],
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index c680925b9c92..bec39c72d540 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -228,7 +228,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		}
 	}
 
-	if (priv->byRFType == RF_RFMD2959) {
+	if (priv->rf_type == RF_RFMD2959) {
 		/*
 		 * bcs TX_PE will reserve 3 us hardware's processing
 		 * time here is 2 us.
@@ -356,7 +356,7 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 	if (priv->radio_off)
 		return;
 
-	switch (priv->byRFType) {
+	switch (priv->rf_type) {
 	case RF_RFMD2959:
 		vt6655_mac_word_reg_bits_off(priv->port_offset, MAC_REG_SOFTPWRCTL,
 					     SOFTPWRCTL_TXPEINV);
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 4122875ebcaa..e90e0b43505d 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -101,12 +101,12 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 	 */
 
 	priv->byCurrentCh = ch->hw_value;
-	ret &= RFbSelectChannel(priv, priv->byRFType,
+	ret &= RFbSelectChannel(priv, priv->rf_type,
 				ch->hw_value);
 
 	/* Init Synthesizer Table */
 	if (priv->bEnablePSMode)
-		rf_write_wake_prog_syn(priv, priv->byRFType, ch->hw_value);
+		rf_write_wake_prog_syn(priv, priv->rf_type, ch->hw_value);
 
 	bb_software_reset(priv);
 
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index c272a4ab2fa0..8c90539cc3d7 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -153,7 +153,7 @@ struct vnt_private {
 
 	/* Version control */
 	unsigned char local_id;
-	unsigned char byRFType;
+	unsigned char rf_type;
 
 	unsigned char max_pwr_level;
 	unsigned char byZoneType;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 45e5eccadb44..f76f482f4c06 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1792,10 +1792,10 @@ vt6655_probe(struct pci_dev *pcid, const struct pci_device_id *ent)
 	vt6655_mac_read_ether_addr(priv->port_offset, priv->abyCurrentNetAddr);
 
 	/* Get RFType */
-	priv->byRFType = SROMbyReadEmbedded(priv->port_offset, EEP_OFS_RFTYPE);
-	priv->byRFType &= RF_MASK;
+	priv->rf_type = SROMbyReadEmbedded(priv->port_offset, EEP_OFS_RFTYPE);
+	priv->rf_type &= RF_MASK;
 
-	dev_dbg(&pcid->dev, "RF Type = %x\n", priv->byRFType);
+	dev_dbg(&pcid->dev, "RF Type = %x\n", priv->rf_type);
 
 	device_get_options(priv);
 	device_set_options(priv);
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 1fadc2fc4412..bf9a10563b12 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -268,7 +268,7 @@ static bool RFbAL2230SelectChannel(struct vnt_private *priv, unsigned char byCha
  * Parameters:
  *  In:
  *      byBBType
- *      byRFType
+ *      rf_type
  *  Out:
  *      none
  *
@@ -279,7 +279,7 @@ bool RFbInit(struct vnt_private *priv)
 {
 	bool ret = true;
 
-	switch (priv->byRFType) {
+	switch (priv->rf_type) {
 	case RF_AIROHA:
 	case RF_AL2230S:
 		priv->max_pwr_level = AL2230_PWR_IDX_LEN;
@@ -300,7 +300,7 @@ bool RFbInit(struct vnt_private *priv)
  *
  * Parameters:
  *  In:
- *      byRFType
+ *      rf_type
  *      byChannel    - Channel number
  *  Out:
  *      none
@@ -308,12 +308,12 @@ bool RFbInit(struct vnt_private *priv)
  * Return Value: true if succeeded; false if failed.
  *
  */
-bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
+bool RFbSelectChannel(struct vnt_private *priv, unsigned char rf_type,
 		      u16 byChannel)
 {
 	bool ret = true;
 
-	switch (byRFType) {
+	switch (rf_type) {
 	case RF_AIROHA:
 	case RF_AL2230S:
 		ret = RFbAL2230SelectChannel(priv, byChannel);
@@ -470,7 +470,7 @@ bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 	if (byPwr >= priv->max_pwr_level)
 		return false;
 
-	switch (priv->byRFType) {
+	switch (priv->rf_type) {
 	case RF_AIROHA:
 		ret &= IFRFbWriteEmbedded(priv, al2230_power_table[byPwr]);
 		if (rate <= RATE_11M)
@@ -521,7 +521,7 @@ RFvRSSITodBm(struct vnt_private *priv, unsigned char byCurrRSSI, long *pldBm)
 	long a = 0;
 	unsigned char abyAIROHARF[4] = {0, 18, 0, 40};
 
-	switch (priv->byRFType) {
+	switch (priv->rf_type) {
 	case RF_AIROHA:
 	case RF_AL2230S:
 		a = abyAIROHARF[byIdx];
diff --git a/drivers/staging/vt6655/rf.h b/drivers/staging/vt6655/rf.h
index 9fef81846a9f..6f842ac00526 100644
--- a/drivers/staging/vt6655/rf.h
+++ b/drivers/staging/vt6655/rf.h
@@ -58,7 +58,7 @@
 /*---------------------  Export Functions  --------------------------*/
 
 bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData);
-bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType, u16 byChannel);
+bool RFbSelectChannel(struct vnt_private *priv, unsigned char rf_type, u16 byChannel);
 bool RFbInit(struct vnt_private *priv);
 bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type, u16 channel);
 bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16 uCH);
-- 
2.34.1

