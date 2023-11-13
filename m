Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA67E9B28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjKMLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjKMLZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:25:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C956170B;
        Mon, 13 Nov 2023 03:24:22 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso34971665e9.2;
        Mon, 13 Nov 2023 03:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874659; x=1700479459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoOuxVfYX3lHdi36PKjYbl3tsLm17OpynR1y+9rBRUM=;
        b=GtdfHXI0k12P2G1LUTZR3BxFJkrj+r53lQ0Dq663uR3hRVMnfdCLCuiBiEvRNDEEP4
         XEMMEqiRP+ZbwFj2qSSwOBtNzEk0PikKFgski5Wl08Gfez14v+zdI/q26JgAdV3MqFqz
         7qFRkyeV7RdeQCTgUHeoKITIjRBW3uezdCGRAlbQotIZRxJt4KZPHyVQi4VFPZVq+eMl
         f/RvLyLk/abKiBEMat4VV2PgCX7iTjnSELob7QowJ/yGnRsbnf1KvctxIk8D5HGhM83a
         ILbEWg6r3GK+wY3o9k4/vJzhIW9aeG2ixzLsKgmncUK04++clnM+7H6tcB7SIBKaOKAo
         ZXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874659; x=1700479459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoOuxVfYX3lHdi36PKjYbl3tsLm17OpynR1y+9rBRUM=;
        b=pP0lklbzBb+JTOg+mTdczMc8sv7JBf2Inft0bitUKxS47rmx52jzmBIHBS7DoAdI3x
         fU9R2Njy1dfRQUP8USayCfT9geszS/pqdnXNo5m7caW8JtfBG2HFb+6j7W2ClYFXXfVL
         BZY9JzOAVsxWppw+QMJfeU724Po+yt/8t5tD57pGowSHvG7cUIIPTq6X6KElvhgpKVcf
         LCGECjMECw659yslUkek3gcXhcbEXKzaHugpCOLqBoV6GoI9GQhQgbf8TrxPnQAV16T9
         zLWWZ6w2TosivDAr65VdMfJPMNMT09ZX9PhKjrzmvc13UXPtMSWnDjahngwpWxbg5udR
         PAOQ==
X-Gm-Message-State: AOJu0Yx+A+yMJqfB9L7ZXYlCf5jhbzrbbBT4KvnK/VqQhMyGYPPRAZ8R
        Phx3ID0DK7UDrk+VloiINMM=
X-Google-Smtp-Source: AGHT+IEcSCoJJCtKw0cUKdyxA/i9aoxyvRl/VBlDIOLftNjw3V8Q9Fgj9csSOWX0cVuMdK1DBzX1NQ==
X-Received: by 2002:a05:600c:230f:b0:408:3d91:8263 with SMTP id 15-20020a05600c230f00b004083d918263mr4941165wmo.13.1699874659168;
        Mon, 13 Nov 2023 03:24:19 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:18 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] include/linux/i2c.h: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:44 +0100
Message-ID: <20231113112344.719-21-hkallweit1@gmail.com>
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
 include/linux/i2c.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0dae9db27..d029aade3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -850,7 +850,6 @@ static inline void i2c_mark_adapter_resumed(struct i2c_adapter *adap)
 
 /* i2c adapter classes (bitmask) */
 #define I2C_CLASS_HWMON		(1<<0)	/* lm_sensors, ... */
-#define I2C_CLASS_DDC		(1<<3)	/* DDC bus on graphics adapters */
 #define I2C_CLASS_SPD		(1<<7)	/* Memory modules */
 /* Warn users that the adapter doesn't support classes anymore */
 #define I2C_CLASS_DEPRECATED	(1<<8)

