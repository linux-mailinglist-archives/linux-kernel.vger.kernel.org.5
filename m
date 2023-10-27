Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641727D92AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbjJ0Iwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbjJ0Iwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:52:35 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3510EA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:30 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-581e92f615fso1019794eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396750; x=1699001550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt5cbLVG/omYbe37e1faZ93UM/A9SfQku0KpypeCMxg=;
        b=OcgCDxaIIVxuCX4EMoXClsLBBtEDJSIXPNjmQNhmScqr/t9qk3itpxbH3lq9REyphw
         bHRhtiJknYQ4QvNjWUD1C2BVt5mGUdyjvk1GquZAYEeEHzh74QcJNoPyW7rZuMc8+VNS
         MFv/uGZH+xbrLi5tuizRgDdWEUDFnu2/Unpcka9wAUFInYtdFCl01wMWlTSdJVfmed1m
         keuSzEZlFQMK92J+APAz4nVovqm3URh8whtF9nvf18B+fvEntf5MtB8tMECmmlVdgoTs
         z8zj1TygAMLG4yB90Xau5jToj29NPrPJqRVG1xiD3AbP1CmZ8WKl/YRjueHykvS9K9nr
         4SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396750; x=1699001550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qt5cbLVG/omYbe37e1faZ93UM/A9SfQku0KpypeCMxg=;
        b=La6+/kaQbpe/fOxq0embzIlb7U4K/PDaptaQMNf8UOBxg966cjLojO4U8+YT003onc
         Kx6cKFJOG7Qbu4amFCZ85ZRBnfl+uHMIiILvU+O9UHiTwZN2QuUVSmd1OASYnQRWLGNz
         D5txBAr9vcqUQZa0eZcjo7x4qr9NQV/oPtgGcfNdcBbbXZz3sOm/lMLdOjpJ8gXoJFgY
         PO5GAOMOh/Uz2WzUnbzIED2Xpea9y46jCjPJyqoTFCrI96y+yeauqfq0rXACQ+GsjzRd
         QVxHi4LB39uB5gftNkL3G1oWalXaRhd8msHS/kN+rnbGurn+vnquzrc+UI0qp2V7Ha5U
         kAwA==
X-Gm-Message-State: AOJu0Yz+U0G1Za5tiNJK7x5021YSnTD5Gc8DaaVjFvQPOAlaa+IDhdtc
        gpnxEo1iK2Wm2yDNcLJvKTk=
X-Google-Smtp-Source: AGHT+IGrfpg0unlf6WB5+iDDQzGUt0B3wt5mtqV2QaYEGX2UU/qLr34soMOKdnr20FHJfwoz0QbI4w==
X-Received: by 2002:a05:6358:7252:b0:168:d31f:9fe3 with SMTP id i18-20020a056358725200b00168d31f9fe3mr2847686rwa.23.1698396749436;
        Fri, 27 Oct 2023 01:52:29 -0700 (PDT)
Received: from ubuntu.. ([122.174.106.169])
        by smtp.gmail.com with ESMTPSA id h12-20020a63b00c000000b0055c178a8df1sm698825pgf.94.2023.10.27.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:52:28 -0700 (PDT)
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH 06/10] staging: vt6655: Type encoding info dropped from variable name "byPacketType"
Date:   Fri, 27 Oct 2023 14:21:55 +0530
Message-Id: <308813545f9364da18dfc3cdb051ed59eca18f7f.1698396278.git.opensource206@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698396278.git.opensource206@gmail.com>
References: <cover.1698396278.git.opensource206@gmail.com>
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

variable name "byPacketType" updated like below:

a.type encoding info dropped from name
b.camelcase name replaced by snakecase

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 4f73da832b6a..c58a25032a03 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -265,7 +265,7 @@ bool card_set_phy_parameter(struct vnt_private *priv, u8 bb_type)
 		iowrite8(priv->cw_max_min, priv->port_offset + MAC_REG_CWMAXMIN0);
 	}
 
-	priv->byPacketType = CARDbyGetPktType(priv);
+	priv->packet_type = CARDbyGetPktType(priv);
 
 	CARDvSetRSPINF(priv, bb_type);
 
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 7773b19a5788..d9ee0b7401fe 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -188,7 +188,7 @@ struct vnt_private {
 	unsigned char cw_max_min;
 
 	u8		byBBType; /* 0:11A, 1:11B, 2:11G */
-	u8		byPacketType; /*
+	u8		packet_type; /*
 				       * 0:11a,1:11b,2:11gb (only CCK
 				       * in BasicRate), 3:11ga (OFDM in
 				       * Basic Rate)
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index c6627c10a462..17a323800ce9 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -177,7 +177,7 @@ device_set_options(struct vnt_private *priv)
 	priv->byShortRetryLimit = priv->opts.short_retry;
 	priv->byLongRetryLimit = priv->opts.long_retry;
 	priv->byBBType = priv->opts.bbp_type;
-	priv->byPacketType = priv->byBBType;
+	priv->packet_type = priv->byBBType;
 	priv->byAutoFBCtrl = AUTO_FB_0;
 	priv->update_bbvga = true;
 	priv->preamble_type = 0;
-- 
2.34.1

