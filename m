Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFE7DAEBA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjJ2WH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2WH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:07:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8454FB7;
        Sun, 29 Oct 2023 15:07:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso5989555a12.3;
        Sun, 29 Oct 2023 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698617243; x=1699222043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5EcvsKKWujXN1u8l3ldEd2sae45jZkF+al3+Z3aUziI=;
        b=Ykp3APiPqQ957qiKoZU8smBtJd36q9r27JZx5haEwS9qw5qWbcyb+AeQzQs4ZdV7oI
         CA0tkGSep7ipHhBvH5T8h8h95wk8kBLJXAXikoPAUsZ/ydWmR/ikttcxgD2wsBM+murQ
         8VtifmOw6jy4jP1SFNdPVvzwaEcvAdl1HbAs/04Rc9cy69dJi8dLQwDtaGu6FX/Bg4ck
         HlOyS9BRoMEYZZpfK4pm6QPZRu6I+LSD2sbvn+wkgRanq7A1pXuFvR7qBeSuujBrQJXQ
         VKLGUpzIe/P2lEYPIJ1HtZZgp/Bw4dWjcR7xXQWBmD503IfOrUoJBSzbUe8ZTw+desFe
         YbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698617243; x=1699222043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EcvsKKWujXN1u8l3ldEd2sae45jZkF+al3+Z3aUziI=;
        b=HbJmhJHhrteiCaTvRN9YeMv4qStih127WpaTlhB1qBhyeB3bSqM0u7POcmt0ntKSPh
         1u67zEyP7vTqs/uBNCfocCSRT5UHUKNQ6fG49CcTwCcxow7QAIKuVr/I4ZI2N0g7vtQG
         nYd96+mNWcUDN5P8GbA1DzyHmIB/VCt4EL08ZQFHkAlaXVuJ3KUYqay766Vy9W1U6Krf
         ne+yyyNUj3ckcR8qPAFsp2nkH7MXnSiR1K1oFIgHOalBmEj50euEECQCJwrGtqwIAKyF
         ynSP5PaYQ/u5AIwH3Tj+k1hDltOgr7BCYjrJS0VZl462B1L2FzLmP/duTPUsJXsurEG/
         Fhqw==
X-Gm-Message-State: AOJu0YzU2iDi5qoEaCFLpB+p/0yPOzB/wvAK1KzlZvZvDnuKAxsiw4lm
        JFNFl+Derd7tPWtpSSw9iMw=
X-Google-Smtp-Source: AGHT+IFtGibfskZvbNGDOf/rSmu8ZBvGaUKFm8MxvUBw1WMmiZBYtPrR5i6MNHib1lIHHocKn8ExKA==
X-Received: by 2002:aa7:d50b:0:b0:53e:7d60:58bb with SMTP id y11-20020aa7d50b000000b0053e7d6058bbmr6906369edq.27.1698617242685;
        Sun, 29 Oct 2023 15:07:22 -0700 (PDT)
Received: from nancy-1-2.. ([105.163.156.232])
        by smtp.googlemail.com with ESMTPSA id u23-20020a056402111700b00533dd4d2947sm5073092edv.74.2023.10.29.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 15:07:22 -0700 (PDT)
From:   Nancy Nyambura <nicymimz@gmail.com>
To:     gagallo7+outreachy@gmail.com
Cc:     nicydaniels@gmail.com, outreachy@lists.linux.dev,
        Nancy Nyambura <nicymimz@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Media: omap4iss: Enable RSZB and update resizer control
Date:   Mon, 30 Oct 2023 01:07:09 +0300
Message-Id: <20231029220710.47063-1-nicymimz@gmail.com>
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

Enable RSZB functionality in the OMAP4 ISS driver. This change sets the RSZB system configuration register to enable the RSZB module. Additionally, it updates the resizer control by setting the RSZ_EN_EN flag as required. This change enhances the driver's capabilities and prepares it for future developments.

Signed-off-by: Nancy Nyambura <nicymimz@gmail.com>
---
 drivers/staging/media/omap4iss/iss_resizer.c | 34 +++++++++++---------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/media/omap4iss/iss_resizer.c b/drivers/staging/media/omap4iss/iss_resizer.c
index a5f8f9f1ab16..23089eeaf448 100644
--- a/drivers/staging/media/omap4iss/iss_resizer.c
+++ b/drivers/staging/media/omap4iss/iss_resizer.c
@@ -7,17 +7,17 @@
  * Author: Sergio Aguirre <sergio.a.aguirre@gmail.com>
  */
 
-#include <linux/module.h>
-#include <linux/uaccess.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-
-#include "iss.h"
-#include "iss_regs.h"
-#include "iss_resizer.h"
+ #include <linux/module.h>
+ #include <linux/uaccess.h>
+ #include <linux/delay.h>
+ #include <linux/device.h>
+ #include <linux/dma-mapping.h>
+ #include <linux/mm.h>
+ #include <linux/sched.h>
+
+ #include "iss.h"
+ #include "iss_regs.h"
+ #include "iss_resizer.h"
 
 static const unsigned int resizer_fmts[] = {
 	MEDIA_BUS_FMT_UYVY8_1X16,
@@ -30,11 +30,11 @@ static const unsigned int resizer_fmts[] = {
  *
  * Also prints other debug information stored in the RESIZER module.
  */
-#define RSZ_PRINT_REGISTER(iss, name)\
+ #define RSZ_PRINT_REGISTER(iss, name)\
 	dev_dbg(iss->dev, "###RSZ " #name "=0x%08x\n", \
 		iss_reg_read(iss, OMAP4_ISS_MEM_ISP_RESIZER, RSZ_##name))
 
-#define RZA_PRINT_REGISTER(iss, name)\
+ #define RZA_PRINT_REGISTER(iss, name)\
 	dev_dbg(iss->dev, "###RZA " #name "=0x%08x\n", \
 		iss_reg_read(iss, OMAP4_ISS_MEM_ISP_RESIZER, RZA_##name))
 
@@ -116,8 +116,12 @@ static void resizer_enable(struct iss_resizer_device *resizer, u8 enable)
 		       RSZ_SRC_EN_SRC_EN, enable ? RSZ_SRC_EN_SRC_EN : 0);
 
 	/* TODO: Enable RSZB */
-	iss_reg_update(iss, OMAP4_ISS_MEM_ISP_RESIZER, RZA_EN, RSZ_EN_EN,
-		       enable ? RSZ_EN_EN : 0);
+	u32 reg_value = ioread32(iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER,
+		       	+ RZ_SYSCONFIG);
+	reg_value |= RSZ_SYSCONFIG_RSZB_CLK_EN;
+	iowrite32(reg_value, iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER, 
+			+ RSZ_SYSCONFIG);
+
 }
 
 /* -----------------------------------------------------------------------------
-- 
2.40.1

