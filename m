Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A617BCFB6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 21:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbjJHTCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344511AbjJHTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 15:02:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B935AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 12:02:11 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3af8b4a557dso2740484b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696791730; x=1697396530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SDMbv3k5QVUvMxg0CJCYgtxG7nCL9hfaOwK90RooPk=;
        b=OC6+2XmEGSf5OHKmymMxIAibegBOwZYosJswf3rtYtbllmPsT4BEyrFWqTzwJC0T3z
         Mmb8yYKebMmMS5v00nXrYtsyU/TXV84wX64tSwlcRm6bVVYKMRgNyEfqggsHCMpKqcHd
         haq2c0MKpUjOuMYTQ56fCKZdpz+4X0Kvf301xO4v6UazdrpJBrjTT3+tPcs48ZFJ+kV8
         zP2ecbTejDWd1hVFRA48iP3vfXOwLXw6DfurIvj4yAF5U8JwgeqTyPp7DjB7zB6e3D5j
         6R5Lxv0QVXI2DmG6pATpmGOkbszh94VcJwkzJ6Pyo//Rs396tYRxvoOg6C2XF07S6Xgd
         jZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696791730; x=1697396530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SDMbv3k5QVUvMxg0CJCYgtxG7nCL9hfaOwK90RooPk=;
        b=HvB6bpTYJ53JnCKi2OsSYVyzvqitmko9orR4DvSQ/8LUY8X0TNklpKZrK3IR1hkFFW
         mQzQa6niWQr7WGciV/G/TIa8XQ2W9xd/o/CakcHZwp46Y7V97iyJ92OgR3N0ZGbIsKMJ
         jaTsY/Nspyj6tGSWmGyTL/Wwcf4RuOxa7fpdXMFO/uNqZS7bOOgOMOa5HIS2PBRGzS8D
         y7O4dA3WW33wTfYwmm4Blqn9dPEiQrWlTl9Qob9lEyqtDf0euWBRcoRVCz5PDFCfsKjN
         zHbsY43mf1U8xu15XyJvPGAUMXgji9HXMpjBf9F9e+7xOh7QflhUsx1vEDmXglvNbhC8
         9Cag==
X-Gm-Message-State: AOJu0YzvREXBm8zgbiHGJTc+xqaL7ICSGf/aW0bMrCYjJ69sUggL2HPd
        jcdcL64XhKm9T8TZkKK5PWMJRBT6TPs=
X-Google-Smtp-Source: AGHT+IESYqvj1uKMsOFlZ7x4hvx/Lwfocvzc5y54TVPlmcmVMjH+YkzudjLXS8/QkCt0BBzzgHy3tQ==
X-Received: by 2002:a05:6808:1484:b0:3af:6c30:f206 with SMTP id e4-20020a056808148400b003af6c30f206mr19079473oiw.10.1696791730217;
        Sun, 08 Oct 2023 12:02:10 -0700 (PDT)
Received: from ubuntu.. ([223.178.246.252])
        by smtp.gmail.com with ESMTPSA id g12-20020a63be4c000000b00577e62e13c5sm6018165pgo.32.2023.10.08.12.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 12:02:09 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH v5 2/3] staging: vt6655: Type encoding info dropped from variable name "byBBVGACurrent"
Date:   Mon,  9 Oct 2023 00:31:49 +0530
Message-Id: <f0dfd4d2460f858540d465dd8bcfc920c219e94d.1696791459.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696791459.git.opensource206@gmail.com>
References: <cover.1696791459.git.opensource206@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

variable name "byBBVGACurrent" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
v1 -> v2 : 1.cover letter added
           2.patches sent as attachments in a single mail for review

v2 -> v3 : patches sending in a single mail intead of attachments

v3 -> v4 : version info updated in patchset subject

v4 -> v5 : sending all patches in a series

 drivers/staging/vt6655/baseband.c    |  2 +-
 drivers/staging/vt6655/channel.c     |  6 +++---
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index a19a75f5d761..7d47b266b87e 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2146,7 +2146,7 @@ void bb_set_vga_gain_offset(struct vnt_private *priv, unsigned char by_data)
 		by_bb_rx_conf &= 0xDF; /* 1101 1111 */
 	else
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
-	priv->byBBVGACurrent = by_data;
+	priv->bbvga_current = by_data;
 	bb_write_embedded(priv, 0x0A, by_bb_rx_conf); /* CR10 */
 }
 
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index e20701815db9..6ac7d470c041 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -87,10 +87,10 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 
 	/* Set VGA to max sensitivity */
 	if (priv->bUpdateBBVGA &&
-	    priv->byBBVGACurrent != priv->bbvga[0]) {
-		priv->byBBVGACurrent = priv->bbvga[0];
+	    priv->bbvga_current != priv->bbvga[0]) {
+		priv->bbvga_current = priv->bbvga[0];
 
-		bb_set_vga_gain_offset(priv, priv->byBBVGACurrent);
+		bb_set_vga_gain_offset(priv, priv->bbvga_current);
 	}
 
 	/* clear NAV */
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index b662c74a2dc7..9ae7171d02ee 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -249,7 +249,7 @@ struct vnt_private {
 	bool bUpdateBBVGA;
 	unsigned int	uBBVGADiffCount;
 	unsigned char byBBVGANew;
-	unsigned char byBBVGACurrent;
+	unsigned char bbvga_current;
 	unsigned char bbvga[BB_VGA_LEVEL];
 	long                    dbm_threshold[BB_VGA_LEVEL];
 
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 385848df8848..6990129ceb10 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -424,8 +424,8 @@ static void device_init_registers(struct vnt_private *priv)
 	bb_vt3253_init(priv);
 
 	if (priv->bUpdateBBVGA) {
-		priv->byBBVGACurrent = priv->bbvga[0];
-		priv->byBBVGANew = priv->byBBVGACurrent;
+		priv->bbvga_current = priv->bbvga[0];
+		priv->byBBVGANew = priv->bbvga_current;
 		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
 	}
 
@@ -1058,7 +1058,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 		}
 	}
 
-	if (priv->byBBVGANew == priv->byBBVGACurrent) {
+	if (priv->byBBVGANew == priv->bbvga_current) {
 		priv->uBBVGADiffCount = 1;
 		return;
 	}
@@ -1072,7 +1072,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 		dev_dbg(&priv->pcid->dev,
 			"First RSSI[%d] NewGain[%d] OldGain[%d] Count[%d]\n",
 			(int)dbm, priv->byBBVGANew,
-			priv->byBBVGACurrent,
+			priv->bbvga_current,
 			(int)priv->uBBVGADiffCount);
 	}
 
@@ -1080,7 +1080,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 		dev_dbg(&priv->pcid->dev,
 			"RSSI[%d] NewGain[%d] OldGain[%d] Count[%d]\n",
 			(int)dbm, priv->byBBVGANew,
-			priv->byBBVGACurrent,
+			priv->bbvga_current,
 			(int)priv->uBBVGADiffCount);
 
 		bb_set_vga_gain_offset(priv, priv->byBBVGANew);
-- 
2.34.1

