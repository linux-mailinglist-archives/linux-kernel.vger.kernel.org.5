Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B04E7E9B19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjKMLYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjKMLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C6FD6D;
        Mon, 13 Nov 2023 03:24:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso33255165e9.2;
        Mon, 13 Nov 2023 03:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874650; x=1700479450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj6lXffwhPaiA+tttg2gWfCsavHU7fIAFEm3bWLvYqY=;
        b=aUSLXbxpet9c4fkSx6LQpXKzDXPHhv4HR5C9HuJJNENqLZRFlcT/u2qNePNrS96zrT
         oncHAPfCZtKmdsdD4dMYYxlj4eOfZ/LAXhK5dCxesmmhHAC/lr1iedqhkC+t7v0BVydn
         5RxwpTQLOMCxvgdju05nhDNR+6wdAqsjruyknbycVVX43HQuvi4JKCGD4QTZ7Dq66s7g
         +llrrW6yvZYriHouJQ96y3yxzUOGDi9pv1X5Nq9FJWdYc/lgmDVO/1W1MVAK9KA2wAJw
         FZdiMfVLxYft6N5iQ2wfTYUgti6aUbnS6Rw0p8UazlS2k2R2cUrgHXg7QBMbzcJsrIaN
         JXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874650; x=1700479450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj6lXffwhPaiA+tttg2gWfCsavHU7fIAFEm3bWLvYqY=;
        b=r/6xSsSwr1IHSJb8YhA+9YIlT3cCLO3uRrwFhG0HCer1ZcEcCi6JSDRme/Vf4Zm/r+
         SKql18J0uX5uvfdLfaeO+aX/VcTIWSm2zRiFFzEKIm0VuOA1Fx9eZj4jC0O0Nr2KGML1
         VlMSS/qPtbwN8idOxv19hCHl+wiavBrRO3q0MetKKkWcipP7PU6if0FWYnst7koss6tB
         RYJO51l1h3RZSI3ipbx3Znfzg2G8cA5OfwuLDSfu8u4hhsTxYSnXVPj4dRoLFDbYjpQc
         m2LG6H+WdRHUno9wZbfusLCPNzg70jLag4VNAFZbaea8ndltUHKTHcpEZMspCP7hHAfk
         Ez1Q==
X-Gm-Message-State: AOJu0Yyy/NnmXRhqkF7H8feT7qGGk/BbP3y1Qm0I+wWVb4agwjCRd3jZ
        ER7SshGrAVM2h75btqmmMNk=
X-Google-Smtp-Source: AGHT+IFLTl+fAOmA9wfAnqq5QL35Y8l0EQWxEuKGeK/UmNhJYPQBWfJpPA26uHWh9GGQv+cTL2zTow==
X-Received: by 2002:a05:600c:348f:b0:406:411f:742e with SMTP id a15-20020a05600c348f00b00406411f742emr5433441wmq.34.1699874649928;
        Mon, 13 Nov 2023 03:24:09 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:09 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] drivers/video/fbdev/cyber2000fb.c: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:34 +0100
Message-ID: <20231113112344.719-11-hkallweit1@gmail.com>
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
 drivers/video/fbdev/cyber2000fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 52105dc1a..79775deda 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1234,7 +1234,6 @@ static int cyber2000fb_setup_ddc_bus(struct cfb_info *cfb)
 	strscpy(cfb->ddc_adapter.name, cfb->fb.fix.id,
 		sizeof(cfb->ddc_adapter.name));
 	cfb->ddc_adapter.owner		= THIS_MODULE;
-	cfb->ddc_adapter.class		= I2C_CLASS_DDC;
 	cfb->ddc_adapter.algo_data	= &cfb->ddc_algo;
 	cfb->ddc_adapter.dev.parent	= cfb->fb.device;
 	cfb->ddc_algo.setsda		= cyber2000fb_ddc_setsda;

