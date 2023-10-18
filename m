Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC137CD570
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjJRHW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjJRHW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:22:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4EEB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:22:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso64960241fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697613773; x=1698218573; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoRqN8nq4xU0Rb9NQMP0I5wSP4CEw6dhL4qiAUpbwUE=;
        b=Kx82ieDm7EqtMZ9rKqOnJ8DmLnr07upFMW3AyMeLhFIv1Bm3qxH9ZgoMXVRvkLDlWf
         w0DtUU6xDdsE5uuM5zUOv+im2kdMwqBAGCb7evtNd50INwj9E9ZEutlv/AQVhUalRJR9
         BFKGRZks+X0gzuFtOXaIHfwkeIxADywtXSpgEJgz8VBziIZanxF+t9tKVSdTAISLgL6K
         Mw4PpANWwx6LsU4GQ7qCM0yHYyNKLq0yszP/nnCPde80S0hC3v1l/i+pt5U6YIOfFXVa
         GT24DU878RqRZ1qgtEgxrvQpjEu+UkBYfSEdmMnYpie4li0FrUbzxRqWM3Kh1NWKRULk
         2X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697613773; x=1698218573;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoRqN8nq4xU0Rb9NQMP0I5wSP4CEw6dhL4qiAUpbwUE=;
        b=Hzrz8lQL2Z+OyxLvC5gI+mHsukCedGEedJ2i747pQew6lmFJBtx5b+9ahhElb32/Cb
         Q4TrRypbku1MfUbhK9fEN+TTASewMnXe6inobCKPyOvsvYNCnYtPjNjsGDvAmz6VZ924
         wkVO8FdUr0IPFGEJZXwe/PQPKEb9c8ir6ptJQAqwbGjr17+qBeCMRqPPzB6xXbbYZosz
         Qlf3Ro3CbCwiV1IW+i9J3L13TAK+Jc8iWin0yOXC3CS6+hO1ocT7ZgGq6RGHeyFBzC1s
         Ya1LOb5fXfbyuAGGHcIsNfpQFpr1EHbFQMc2oPKMhwbmCgpmxVSF1N7D09snDwy7dg0d
         nf+g==
X-Gm-Message-State: AOJu0Yx5cbxPsopCRpqoCQShF1zXJmlkrFhhPKGmDtq8Q5Orgq9EeQup
        O4uUQfZEgX4Rd5W8RalZcpo=
X-Google-Smtp-Source: AGHT+IGKaB4yvC1oF7905KuD10H9N3nfHc03HLQ6r7JxWgA9fWmlH/7k9Fz+ed4a8t4Vw/HdoOr+FA==
X-Received: by 2002:a2e:9214:0:b0:2c2:8f22:d9c2 with SMTP id k20-20020a2e9214000000b002c28f22d9c2mr3433351ljg.22.1697613773303;
        Wed, 18 Oct 2023 00:22:53 -0700 (PDT)
Received: from lab-ubuntu ([41.90.71.30])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b004083996dad8sm874200wmh.18.2023.10.18.00.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 00:22:52 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:22:50 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        calvncce@gmail.com
Subject: [PATCH] staging: vme_user: fix coding style - remove CamelCasing
Message-ID: <ZS+HyqwvyVyfzGXs@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses coding style errors identified by checkpatch. The
changes include converting camel case names in constant variables to
UPPERCASE. These changes align with the coding style guidelines.


Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/vme_user/vme.h        | 12 ++--
 drivers/staging/vme_user/vme_fake.c   |  8 +--
 drivers/staging/vme_user/vme_tsi148.c | 88 +++++++++++++--------------
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
index fbcbd0204453..0b40859fee23 100644
--- a/drivers/staging/vme_user/vme.h
+++ b/drivers/staging/vme_user/vme.h
@@ -33,13 +33,13 @@ enum vme_resource_type {
 #define VME_SCT		0x1
 #define VME_BLT		0x2
 #define VME_MBLT	0x4
-#define VME_2eVME	0x8
-#define VME_2eSST	0x10
-#define VME_2eSSTB	0x20
+#define VME_2EVME	0x8
+#define VME_2ESST	0x10
+#define VME_2ESSTB	0x20
 
-#define VME_2eSST160	0x100
-#define VME_2eSST267	0x200
-#define VME_2eSST320	0x400
+#define VME_2ESST160	0x100
+#define VME_2ESST267	0x200
+#define VME_2ESST320	0x400
 
 #define	VME_SUPER	0x1000
 #define	VME_USER	0x2000
diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index ae802d6dda7e..0e02c194298d 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1108,8 +1108,8 @@ static int __init fake_init(void)
 		master_image->address_attr = VME_A16 | VME_A24 | VME_A32 |
 			VME_A64;
 		master_image->cycle_attr = VME_SCT | VME_BLT | VME_MBLT |
-			VME_2eVME | VME_2eSST | VME_2eSSTB | VME_2eSST160 |
-			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
+			VME_2EVME | VME_2ESST | VME_2ESSTB | VME_2ESST160 |
+			VME_2ESST267 | VME_2ESST320 | VME_SUPER | VME_USER |
 			VME_PROG | VME_DATA;
 		master_image->width_attr = VME_D16 | VME_D32;
 		memset(&master_image->bus_resource, 0,
@@ -1135,8 +1135,8 @@ static int __init fake_init(void)
 			VME_A64 | VME_CRCSR | VME_USER1 | VME_USER2 |
 			VME_USER3 | VME_USER4;
 		slave_image->cycle_attr = VME_SCT | VME_BLT | VME_MBLT |
-			VME_2eVME | VME_2eSST | VME_2eSSTB | VME_2eSST160 |
-			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
+			VME_2EVME | VME_2ESST | VME_2ESSTB | VME_2ESST160 |
+			VME_2ESST267 | VME_2ESST320 | VME_SUPER | VME_USER |
 			VME_PROG | VME_DATA;
 		list_add_tail(&slave_image->list,
 			      &fake_bridge->slave_resources);
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index d549c22da534..859298aa1313 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -551,14 +551,14 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
 
 	/* Setup 2eSST speeds */
 	temp_ctl &= ~TSI148_LCSR_ITAT_2eSSTM_M;
-	switch (cycle & (VME_2eSST160 | VME_2eSST267 | VME_2eSST320)) {
-	case VME_2eSST160:
+	switch (cycle & (VME_2ESST160 | VME_2ESST267 | VME_2ESST320)) {
+	case VME_2ESST160:
 		temp_ctl |= TSI148_LCSR_ITAT_2eSSTM_160;
 		break;
-	case VME_2eSST267:
+	case VME_2ESST267:
 		temp_ctl |= TSI148_LCSR_ITAT_2eSSTM_267;
 		break;
-	case VME_2eSST320:
+	case VME_2ESST320:
 		temp_ctl |= TSI148_LCSR_ITAT_2eSSTM_320;
 		break;
 	}
@@ -569,11 +569,11 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
 		temp_ctl |= TSI148_LCSR_ITAT_BLT;
 	if (cycle & VME_MBLT)
 		temp_ctl |= TSI148_LCSR_ITAT_MBLT;
-	if (cycle & VME_2eVME)
+	if (cycle & VME_2EVME)
 		temp_ctl |= TSI148_LCSR_ITAT_2eVME;
-	if (cycle & VME_2eSST)
+	if (cycle & VME_2ESST)
 		temp_ctl |= TSI148_LCSR_ITAT_2eSST;
-	if (cycle & VME_2eSSTB)
+	if (cycle & VME_2ESSTB)
 		temp_ctl |= TSI148_LCSR_ITAT_2eSSTB;
 
 	/* Setup address space */
@@ -673,22 +673,22 @@ static int tsi148_slave_get(struct vme_slave_resource *image, int *enabled,
 	*size = (unsigned long long)((vme_bound - *vme_base) + granularity);
 
 	if ((ctl & TSI148_LCSR_ITAT_2eSSTM_M) == TSI148_LCSR_ITAT_2eSSTM_160)
-		*cycle |= VME_2eSST160;
+		*cycle |= VME_2ESST160;
 	if ((ctl & TSI148_LCSR_ITAT_2eSSTM_M) == TSI148_LCSR_ITAT_2eSSTM_267)
-		*cycle |= VME_2eSST267;
+		*cycle |= VME_2ESST267;
 	if ((ctl & TSI148_LCSR_ITAT_2eSSTM_M) == TSI148_LCSR_ITAT_2eSSTM_320)
-		*cycle |= VME_2eSST320;
+		*cycle |= VME_2ESST320;
 
 	if (ctl & TSI148_LCSR_ITAT_BLT)
 		*cycle |= VME_BLT;
 	if (ctl & TSI148_LCSR_ITAT_MBLT)
 		*cycle |= VME_MBLT;
 	if (ctl & TSI148_LCSR_ITAT_2eVME)
-		*cycle |= VME_2eVME;
+		*cycle |= VME_2EVME;
 	if (ctl & TSI148_LCSR_ITAT_2eSST)
-		*cycle |= VME_2eSST;
+		*cycle |= VME_2ESST;
 	if (ctl & TSI148_LCSR_ITAT_2eSSTB)
-		*cycle |= VME_2eSSTB;
+		*cycle |= VME_2ESSTB;
 
 	if (ctl & TSI148_LCSR_ITAT_SUPR)
 		*cycle |= VME_SUPER;
@@ -895,14 +895,14 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 
 	/* Setup 2eSST speeds */
 	temp_ctl &= ~TSI148_LCSR_OTAT_2eSSTM_M;
-	switch (cycle & (VME_2eSST160 | VME_2eSST267 | VME_2eSST320)) {
-	case VME_2eSST160:
+	switch (cycle & (VME_2ESST160 | VME_2ESST267 | VME_2ESST320)) {
+	case VME_2ESST160:
 		temp_ctl |= TSI148_LCSR_OTAT_2eSSTM_160;
 		break;
-	case VME_2eSST267:
+	case VME_2ESST267:
 		temp_ctl |= TSI148_LCSR_OTAT_2eSSTM_267;
 		break;
-	case VME_2eSST320:
+	case VME_2ESST320:
 		temp_ctl |= TSI148_LCSR_OTAT_2eSSTM_320;
 		break;
 	}
@@ -916,15 +916,15 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
 		temp_ctl |= TSI148_LCSR_OTAT_TM_MBLT;
 	}
-	if (cycle & VME_2eVME) {
+	if (cycle & VME_2EVME) {
 		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
 		temp_ctl |= TSI148_LCSR_OTAT_TM_2eVME;
 	}
-	if (cycle & VME_2eSST) {
+	if (cycle & VME_2ESST) {
 		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
 		temp_ctl |= TSI148_LCSR_OTAT_TM_2eSST;
 	}
-	if (cycle & VME_2eSSTB) {
+	if (cycle & VME_2ESSTB) {
 		dev_warn(tsi148_bridge->parent, "Currently not setting Broadcast Select Registers\n");
 		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
 		temp_ctl |= TSI148_LCSR_OTAT_TM_2eSSTB;
@@ -1100,11 +1100,11 @@ static int __tsi148_master_get(struct vme_master_resource *image, int *enabled,
 
 	/* Setup 2eSST speeds */
 	if ((ctl & TSI148_LCSR_OTAT_2eSSTM_M) == TSI148_LCSR_OTAT_2eSSTM_160)
-		*cycle |= VME_2eSST160;
+		*cycle |= VME_2ESST160;
 	if ((ctl & TSI148_LCSR_OTAT_2eSSTM_M) == TSI148_LCSR_OTAT_2eSSTM_267)
-		*cycle |= VME_2eSST267;
+		*cycle |= VME_2ESST267;
 	if ((ctl & TSI148_LCSR_OTAT_2eSSTM_M) == TSI148_LCSR_OTAT_2eSSTM_320)
-		*cycle |= VME_2eSST320;
+		*cycle |= VME_2ESST320;
 
 	/* Setup cycle types */
 	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_SCT)
@@ -1114,11 +1114,11 @@ static int __tsi148_master_get(struct vme_master_resource *image, int *enabled,
 	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_MBLT)
 		*cycle |= VME_MBLT;
 	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_2eVME)
-		*cycle |= VME_2eVME;
+		*cycle |= VME_2EVME;
 	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_2eSST)
-		*cycle |= VME_2eSST;
+		*cycle |= VME_2ESST;
 	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_2eSSTB)
-		*cycle |= VME_2eSSTB;
+		*cycle |= VME_2ESSTB;
 
 	if (ctl & TSI148_LCSR_OTAT_SUP)
 		*cycle |= VME_SUPER;
@@ -1406,14 +1406,14 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
 	val = be32_to_cpu(*attr);
 
 	/* Setup 2eSST speeds */
-	switch (cycle & (VME_2eSST160 | VME_2eSST267 | VME_2eSST320)) {
-	case VME_2eSST160:
+	switch (cycle & (VME_2ESST160 | VME_2ESST267 | VME_2ESST320)) {
+	case VME_2ESST160:
 		val |= TSI148_LCSR_DSAT_2eSSTM_160;
 		break;
-	case VME_2eSST267:
+	case VME_2ESST267:
 		val |= TSI148_LCSR_DSAT_2eSSTM_267;
 		break;
-	case VME_2eSST320:
+	case VME_2ESST320:
 		val |= TSI148_LCSR_DSAT_2eSSTM_320;
 		break;
 	}
@@ -1428,13 +1428,13 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
 	if (cycle & VME_MBLT)
 		val |= TSI148_LCSR_DSAT_TM_MBLT;
 
-	if (cycle & VME_2eVME)
+	if (cycle & VME_2EVME)
 		val |= TSI148_LCSR_DSAT_TM_2eVME;
 
-	if (cycle & VME_2eSST)
+	if (cycle & VME_2ESST)
 		val |= TSI148_LCSR_DSAT_TM_2eSST;
 
-	if (cycle & VME_2eSSTB) {
+	if (cycle & VME_2ESSTB) {
 		dev_err(dev, "Currently not setting Broadcast Select Registers\n");
 		val |= TSI148_LCSR_DSAT_TM_2eSSTB;
 	}
@@ -1504,14 +1504,14 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
 	val = be32_to_cpu(*attr);
 
 	/* Setup 2eSST speeds */
-	switch (cycle & (VME_2eSST160 | VME_2eSST267 | VME_2eSST320)) {
-	case VME_2eSST160:
+	switch (cycle & (VME_2ESST160 | VME_2ESST267 | VME_2ESST320)) {
+	case VME_2ESST160:
 		val |= TSI148_LCSR_DDAT_2eSSTM_160;
 		break;
-	case VME_2eSST267:
+	case VME_2ESST267:
 		val |= TSI148_LCSR_DDAT_2eSSTM_267;
 		break;
-	case VME_2eSST320:
+	case VME_2ESST320:
 		val |= TSI148_LCSR_DDAT_2eSSTM_320;
 		break;
 	}
@@ -1526,13 +1526,13 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
 	if (cycle & VME_MBLT)
 		val |= TSI148_LCSR_DDAT_TM_MBLT;
 
-	if (cycle & VME_2eVME)
+	if (cycle & VME_2EVME)
 		val |= TSI148_LCSR_DDAT_TM_2eVME;
 
-	if (cycle & VME_2eSST)
+	if (cycle & VME_2ESST)
 		val |= TSI148_LCSR_DDAT_TM_2eSST;
 
-	if (cycle & VME_2eSSTB) {
+	if (cycle & VME_2ESSTB) {
 		dev_err(dev, "Currently not setting Broadcast Select Registers\n");
 		val |= TSI148_LCSR_DDAT_TM_2eSSTB;
 	}
@@ -2359,8 +2359,8 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			VME_A64 | VME_CRCSR | VME_USER1 | VME_USER2 |
 			VME_USER3 | VME_USER4;
 		master_image->cycle_attr = VME_SCT | VME_BLT | VME_MBLT |
-			VME_2eVME | VME_2eSST | VME_2eSSTB | VME_2eSST160 |
-			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
+			VME_2EVME | VME_2ESST | VME_2ESSTB | VME_2ESST160 |
+			VME_2ESST267 | VME_2ESST320 | VME_SUPER | VME_USER |
 			VME_PROG | VME_DATA;
 		master_image->width_attr = VME_D16 | VME_D32;
 		memset(&master_image->bus_resource, 0,
@@ -2384,8 +2384,8 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		slave_image->address_attr = VME_A16 | VME_A24 | VME_A32 |
 			VME_A64;
 		slave_image->cycle_attr = VME_SCT | VME_BLT | VME_MBLT |
-			VME_2eVME | VME_2eSST | VME_2eSSTB | VME_2eSST160 |
-			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
+			VME_2EVME | VME_2ESST | VME_2ESSTB | VME_2ESST160 |
+			VME_2ESST267 | VME_2ESST320 | VME_SUPER | VME_USER |
 			VME_PROG | VME_DATA;
 		list_add_tail(&slave_image->list,
 			&tsi148_bridge->slave_resources);
-- 
2.34.1

