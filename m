Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C557E9AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjKMLYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKMLYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47CD66;
        Mon, 13 Nov 2023 03:24:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso37313565e9.2;
        Mon, 13 Nov 2023 03:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874646; x=1700479446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTrCOgNzORg+kX6P4q5KSwq1S4WQ2CSsbEPwGEitBjk=;
        b=CAqnNSxdBdnLnhckMEA3rB5VY2m0qAyQ5xVovcXYG/3mU60K4Rufs4LgDvgvfrIuLO
         59Cc25qcugmwK468tHm1Ga+24IYZBiIwtosBmncmhh53qNhY3sX2ga5TkUTFQvKwi5tC
         ocUsr9kOUqq8SY5s7dwogPKT3v7S/kLULu+pS2qX+a7NaOmKCySZYHd5AkT8/x4O4X+C
         G3Bcm4BYBOufG/YtbIX2xaQKdqZTdTKaAI+2rFrp3vQbpCP9BNRiCqKebqch/1D2Kdsf
         FI9AX6gWJ2qswnrJx1+QhTCQ+Rgid6miSNk34xemIMCH8ydLvPPecYURxMknWQyWCEjG
         KNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874646; x=1700479446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTrCOgNzORg+kX6P4q5KSwq1S4WQ2CSsbEPwGEitBjk=;
        b=gwnyNU89pEX3GDp/fJakdyJSfXChXfNecfWrqzf/37yqyRg/YSWl8t7k7sNO0X3La9
         YseB9u8nfIDmaNgBHFlCP6tdxDx/OcvoOx2QewVXqoK2Ncw+tFcwoCYUPTdo81UMR8I+
         94Xtt21MSZq8z5xcTS2XBiAf1VgfA0NFhtv4o5szU1x07GgcUDR+TlLgsrWUqomtQy2C
         jFrsH3udRAc7sE1XOF0kI+PbStEK01Ivmrpk0ZPahQ96WGf8/7HJYZnogoOaLaLLhSVJ
         UZAtV1YUrKvyfQ4YJGxVTrdqQQt/JYJISZj7JASoZod4Lv070xyLuWPgHDzw2knY92Uy
         mBOA==
X-Gm-Message-State: AOJu0YzSmjKS+4lxVbDrQ4oVQlBAlCXDTa6JD2gBxak9CAlhHDfF1u8G
        LpRrdKQ7kVF491UmgYfOB/8=
X-Google-Smtp-Source: AGHT+IGL3EktaBJFjj+0Glil7T8bNSbTgzf/Pqk4mNBNsYEc7WZFPHt2hi+DW9OAvH9O20i3TarP6A==
X-Received: by 2002:a05:600c:1910:b0:40a:3e41:7df1 with SMTP id j16-20020a05600c191000b0040a3e417df1mr5289314wmq.37.1699874646477;
        Mon, 13 Nov 2023 03:24:06 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:05 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] drivers/video/fbdev/core/fb_ddc.c: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:30 +0100
Message-ID: <20231113112344.719-7-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/video/fbdev/core/fb_ddc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_ddc.c b/drivers/video/fbdev/core/fb_ddc.c
index 8bf5f2f54..e25143219 100644
--- a/drivers/video/fbdev/core/fb_ddc.c
+++ b/drivers/video/fbdev/core/fb_ddc.c
@@ -116,7 +116,6 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
 	algo_data->setsda(algo_data->data, 1);
 	algo_data->setscl(algo_data->data, 1);
 
-	adapter->class |= I2C_CLASS_DDC;
 	return edid;
 }
 

