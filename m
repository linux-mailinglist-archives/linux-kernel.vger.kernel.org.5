Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3E7EFE8D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjKRIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjKRIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:51:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0535B9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9dd576116e3so82303166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297473; x=1700902273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IeNlXsmBMHoH7xFQOzT7zMDYmFmso5R2YU54hCqJXw=;
        b=UipGlwvtdH3WYGdkeqIjAr2boFzGZ/Btp/WaPEAWsGFxRyPxQoaCV8gsPERJYzzfbr
         GaLfKDSFPXnriHi/npZjrVvdjba0ONLg71iMPERsoDj1V11Md2CJvXv/TiT5VHWbuarU
         Cdxt3JYCk+lxeKNdMgklc9HVcdZFZl4KPytZ+NCc+rLgaWIKk4NFZ/6n7bYyRL2+GfdB
         Ufl1z26YU69ICOKddRkk9fUUDzCu55j3cBNOF232c9i7xaKIbsUvbA44m8/knAwbqEKG
         cWUPJiABjNk+CRW792RWpYafuEE1dh/ZsRX0JUr2b9YRTuzC8fw7m10VVRCrwUgEU0l6
         RTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297473; x=1700902273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IeNlXsmBMHoH7xFQOzT7zMDYmFmso5R2YU54hCqJXw=;
        b=tdwxdd7iM9fpf6E8PemDxFYP//T1TFWoI0XRMEG3UFmY0Z1JiffU2F/IQLNAKuV2V5
         aPp7tN9blD0Goum2ibskTK7FFXQ6iv96vaLXsHQQjLEA0pKKL+sJ3qpmFhg4mMXT3OYd
         GWCyYNd58T2Dl/Bvr9ho1cLgaxIWJHsQr+hj5gC0Qn6bmFUOypFakQvaThU4YCs9DbMa
         6dWc+r+P8KqixRk0epwZEHskXbtSrY1O+38/19WefibY6meZOt2XS2uvBxEKIMTUS6qN
         /y8GcTmhTgiZ02g5TbUtbPtVFVy//7m/eNBls02tQOIkJ+k/l+8y1ubfBFBRETxS0y0u
         VgCA==
X-Gm-Message-State: AOJu0YwR6tP5ZELTcKWcdWHGAqmY1+dJZLiv9HcFcT17shFfEP8HbURi
        rUTvRQAEX98WhFpuON99znU=
X-Google-Smtp-Source: AGHT+IFHwZXi9hQx6GDo7DcH7fcX+4pp9aXtpSY0qesFiSTN77Cf3nH1Vx3COwZRLLVvFj66eHvjOg==
X-Received: by 2002:a17:906:108f:b0:9dd:5609:55b9 with SMTP id u15-20020a170906108f00b009dd560955b9mr1172060eju.2.1700297473260;
        Sat, 18 Nov 2023 00:51:13 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id s27-20020a170906169b00b009b29553b648sm1643314ejd.206.2023.11.18.00.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:13 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:51:11 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Change parameter "ch" of set_chan()
 to u8
Message-ID: <4a76c0e2384d67410d383fdf860d0e0859555d1e.1700296319.git.philipp.g.hortmann@gmail.com>
References: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change parameter "ch" of set_chan() to u8 to combine functions in the
following patch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 995daab906c9..98b25768f614 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -226,7 +226,7 @@ static void _rtl92e_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	netdev_info(dev, "TXTIMEOUT");
 }
 
-static void _rtl92e_set_chan(struct net_device *dev, short ch)
+static void _rtl92e_set_chan(struct net_device *dev, u8 ch)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index adaab56a9fb1..1d0878d1f696 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1469,7 +1469,7 @@ struct rtllib_device {
 	 * This function can sleep. the driver should ensure
 	 * the radio has been switched before return.
 	 */
-	void (*set_chan)(struct net_device *dev, short ch);
+	void (*set_chan)(struct net_device *dev, u8 ch);
 
 	/* indicate the driver that the link state is changed
 	 * for example it may indicate the card is associated now.
-- 
2.42.0

