Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB67DC5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjJaFfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjJaFfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:35:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0582CE6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc2575dfc7so25711495ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698730497; x=1699335297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uQtO8M5ioqZ7+MOOU298ue9J+3vWCy5YR1WIv7HeCg=;
        b=HXkozF/nZ0NnQ5r3v14v40G3wsqlhVPYYauwVCSLPt99DuiRj5aHRxDSBkgWAe2rMS
         /s+zBREeBWqJWP5qlDTa03dopl15+MpuhNmnrkx4K5TAbxJQjRNiZwcMcIGDjkHfsCIh
         iEFsgJc1+HtztzWpPGIZVztPX3QW3/qNtVnfaSlqXKRap+DS+zF6oYwawpkDs2GB9KlD
         VE2lSkZJUxBI1UoBwt+uX3lD2A+NBKIKUoGT2TZb22tnTTfUOE3klCmG27QzwUdh5kT4
         Pbz+S5ETdflzpaR0SIpgtq/JQ09x7GmGMTZckKD2o6pArfT2uoekMa8sZRISz/159biN
         h6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698730497; x=1699335297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uQtO8M5ioqZ7+MOOU298ue9J+3vWCy5YR1WIv7HeCg=;
        b=ElEeBornRFLJvROLdDVzBH7+oZAPvMSS6bXLZ7KKV2ncIk8bADSg1LiMIJoTUIzAQE
         5H4/NVVhEpCfb6L2NYroUUErOIgvcco60A9pYyU2AoK3mKhy0oFD56QjnGAD/JVhLcy/
         5sX2TjTgZO48h5IV+bJKm+SIPNcX28XmOEfjyPBUIaD8vt5vKwkMvQIBElilzF2uzi/p
         ciBj8adgpNc2v0hqkvvBfhpiViz0WJuZUopF10HV46JXMBb8ocmDZ65qCsVIBNKy1Q0f
         nPntUnzf/DbunXCtaFmfhuEiNGFXgAjUwcUGcjv7/1Jwkk25qRqK6XF2WRwT1kGjCdk+
         /MEA==
X-Gm-Message-State: AOJu0Yy0rq3knEs5h47+iWLzu5POnZb8CnzqFnArvGrav4wJCbzD+r1w
        QjPjDRwtvqQ0yw0SeR27CH3cBuohP7E=
X-Google-Smtp-Source: AGHT+IGH+Q37s6NRSzSU3WWulvYqXR8L3ot4ArUROzWVEfOM8q/0W2cVvok7wY6SJR2VFqvxXXALzg==
X-Received: by 2002:a17:903:246:b0:1ca:5d1a:e77f with SMTP id j6-20020a170903024600b001ca5d1ae77fmr11216386plh.43.1698730497107;
        Mon, 30 Oct 2023 22:34:57 -0700 (PDT)
Received: from ubuntu.. ([122.182.231.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001c0a414695bsm422211pld.43.2023.10.30.22.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:34:56 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 08/11] staging: vt6655: Type encoding info dropped from function name "CARDbRadioPowerOff"
Date:   Tue, 31 Oct 2023 11:04:31 +0530
Message-Id: <5b264db5a6d5ac936e02f0a7f465e648504a049e.1698730318.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698730318.git.opensource206@gmail.com>
References: <cover.1698730318.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function name "CARDbRadioPowerOff" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c        | 4 ++--
 drivers/staging/vt6655/card.h        | 2 +-
 drivers/staging/vt6655/device_main.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 716fd3632508..7980b93d2b1e 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -15,7 +15,7 @@
  *      card_get_next_tbtt - Calculate Next Beacon TSF counter
  *      CARDvSetFirstNextTBTT - Set NIC Beacon time
  *      CARDvUpdateNextTBTT - Sync. NIC Beacon time
- *      CARDbRadioPowerOff - Turn Off NIC Radio Power
+ *      card_radio_power_off - Turn Off NIC Radio Power
  *
  * Revision History:
  *      06-10-2003 Bryan YC Fan:  Re-write codes to support VT3253 spec.
@@ -351,7 +351,7 @@ bool card_set_beacon_period(struct vnt_private *priv,
  *      none
  *
  */
-void CARDbRadioPowerOff(struct vnt_private *priv)
+void card_radio_power_off(struct vnt_private *priv)
 {
 	if (priv->radio_off)
 		return;
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index ab1193799239..5ca715b415e8 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -52,7 +52,7 @@ u64 card_get_tsf_offset(unsigned char rx_rate, u64 qwTSF1, u64 qwTSF2);
 unsigned char card_get_pkt_type(struct vnt_private *priv);
 void CARDvSafeResetTx(struct vnt_private *priv);
 void CARDvSafeResetRx(struct vnt_private *priv);
-void CARDbRadioPowerOff(struct vnt_private *priv);
+void card_radio_power_off(struct vnt_private *priv);
 bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type);
 bool card_update_tsf(struct vnt_private *priv, unsigned char rx_rate,
 		    u64 bss_timestamp);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 2e2a8da571ab..210c94312310 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -454,7 +454,7 @@ static void device_init_registers(struct vnt_private *priv)
 	}
 
 	if (priv->hw_radio_off || priv->bRadioControlOff)
-		CARDbRadioPowerOff(priv);
+		card_radio_power_off(priv);
 
 	/* get Permanent network address */
 	SROMvReadEtherAddress(priv->port_offset, priv->abyCurrentNetAddr);
@@ -1349,7 +1349,7 @@ static void vnt_stop(struct ieee80211_hw *hw)
 
 	MACbShutdown(priv);
 	MACbSoftwareReset(priv);
-	CARDbRadioPowerOff(priv);
+	card_radio_power_off(priv);
 
 	device_free_td0_ring(priv);
 	device_free_td1_ring(priv);
@@ -1712,7 +1712,7 @@ static int vnt_init(struct vnt_private *priv)
 
 	priv->mac_hw = true;
 
-	CARDbRadioPowerOff(priv);
+	card_radio_power_off(priv);
 
 	return 0;
 }
-- 
2.34.1

