Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287477CC5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344089AbjJQOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbjJQOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:15:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6F11A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:15:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdf4752c3cso34561725ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697552148; x=1698156948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iqwQ+7rqqmIMspEGesJUa+9eYiX8AvPDFecFy0NEhJI=;
        b=MWRpqap0jSV/33P+VyV9Sjgz6Yb2JS66xc0vnurT6pes9obGOw07jjG+hXDH2v2njd
         VVi8X8S6fkhGsj26Pw+B2QIy0qJowc4cIytKDq/gWbqk8YA+WG7XBVOOMqtvcwsxV4V8
         t5uHVOe9mlt/+4Bja8uAjrY9L3nnivyB/MRe3pQrzYGay1Z+Dt4vif/QlVMYIHWV9dEU
         YB13Qqy38+qWRKd7OudJtHSbxIPY8akE376Uuu3p4mAmNA92KSRet+RdbIV6GbFGYCTb
         I7FHEdS1B1yEEF/+VDiTZb2Cw/T+tdvY2VoyfX3iu1oiiQndiH+IOmWAyh5Fmtd7Xgi0
         adrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552148; x=1698156948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqwQ+7rqqmIMspEGesJUa+9eYiX8AvPDFecFy0NEhJI=;
        b=AQOQSnFJA5Z2I/XvHkDtnHGAY275WEeyRScPzQzKbDbDoD/k80WucB9EaIt/xIMbd4
         kYiXDkRsL9+d76PVAsWxgsEZvQgsZvgtR7IXzrQIhwjrlbbtDv2bKYUIT3mS5d2HA/Qc
         1ZYqSAxSwRWM3ViYPCvM9KqhgMxmGJYdVbspk02IfvBW7kKmKYa+m6R7OohSJ3O28aLs
         rz1w1uTxArFu01bvTFqvBM0XYU2cHB3gtr9NcFUxASdipIojf6dmtFH3EZhunTa/p8bf
         7D9Lz/Ce6DhviyNeqLiyodmWxnQEttAd7pIYNxxBH8qQz2H8FKRTHZbZ71DrYy9Ha3WU
         7ANQ==
X-Gm-Message-State: AOJu0YyXRR+80o9uFvnVTYth8+H84Sge93TMLbFAVhrvsnmAp93a+5gE
        LcWZyWPqBLcLCGO4njTQ73Y=
X-Google-Smtp-Source: AGHT+IF8Inum4AWOsUaWcagEsQj6+/PfIsPVhtsv0RSbpX2fyBRJjPYdaXNrpnHmFrhnnxoznYFOcg==
X-Received: by 2002:a17:903:487:b0:1c9:ff46:162d with SMTP id jj7-20020a170903048700b001c9ff46162dmr2294311plb.22.1697552148350;
        Tue, 17 Oct 2023 07:15:48 -0700 (PDT)
Received: from ubuntu.. ([122.181.68.128])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001ca222edc16sm1590234pll.135.2023.10.17.07.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:15:47 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] staging: vt6655: Type encoding info dropped from variable name "bUpdateBBVGA"
Date:   Tue, 17 Oct 2023 19:45:10 +0530
Message-Id: <20231017141509.351301-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
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

variable name "bUpdateBBVGA" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/baseband.c    | 2 +-
 drivers/staging/vt6655/channel.c     | 2 +-
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 7d47b266b87e..f7824396c5ff 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2087,7 +2087,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		/* {{ RobertYu: 20050104 */
 	} else {
 		/* No VGA Table now */
-		priv->bUpdateBBVGA = false;
+		priv->update_bbvga = false;
 		priv->bbvga[0] = 0x1C;
 	}
 
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 6ac7d470c041..c11bc2dbc356 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -86,7 +86,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		return ret;
 
 	/* Set VGA to max sensitivity */
-	if (priv->bUpdateBBVGA &&
+	if (priv->update_bbvga &&
 	    priv->bbvga_current != priv->bbvga[0]) {
 		priv->bbvga_current = priv->bbvga[0];
 
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 68bfadacfa7c..b166d296b82d 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -246,7 +246,7 @@ struct vnt_private {
 	unsigned char byAutoFBCtrl;
 
 	/* For Update BaseBand VGA Gain Offset */
-	bool bUpdateBBVGA;
+	bool update_bbvga;
 	unsigned int	uBBVGADiffCount;
 	unsigned char bbvga_new;
 	unsigned char bbvga_current;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index b08fcf7e6edc..b654fc24d725 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -179,7 +179,7 @@ device_set_options(struct vnt_private *priv)
 	priv->byBBType = priv->opts.bbp_type;
 	priv->byPacketType = priv->byBBType;
 	priv->byAutoFBCtrl = AUTO_FB_0;
-	priv->bUpdateBBVGA = true;
+	priv->update_bbvga = true;
 	priv->preamble_type = 0;
 
 	pr_debug(" byShortRetryLimit= %d\n", (int)priv->byShortRetryLimit);
@@ -423,7 +423,7 @@ static void device_init_registers(struct vnt_private *priv)
 	/* initialize BBP registers */
 	bb_vt3253_init(priv);
 
-	if (priv->bUpdateBBVGA) {
+	if (priv->update_bbvga) {
 		priv->bbvga_current = priv->bbvga[0];
 		priv->bbvga_new = priv->bbvga_current;
 		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
@@ -1040,7 +1040,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 	long dbm;
 	int i;
 
-	if (!priv->bUpdateBBVGA)
+	if (!priv->update_bbvga)
 		return;
 
 	if (priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
-- 
2.34.1

