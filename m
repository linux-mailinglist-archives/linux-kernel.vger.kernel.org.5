Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AE57F1FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjKTVru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjKTVrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:47:14 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E8DD79;
        Mon, 20 Nov 2023 13:46:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-409299277bbso17817435e9.2;
        Mon, 20 Nov 2023 13:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700516806; x=1701121606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoOuxVfYX3lHdi36PKjYbl3tsLm17OpynR1y+9rBRUM=;
        b=NJObFDy1D0dyDfAj4tNiz+auUALyeVTm1J2hMFjdWftGR3JnXkdNsjrFmHe7b2MC1U
         B/n7eXLsiERVc4c4lDIQjBU089Qk9TLR0fDN1lMDNnCs78zPEVPcmcomvabflElmHTmF
         w1DHAqm5VH0iPL9z8I9JFOAozeiuvLvKDLgL4JBBAqMx/vpNwWGdii8dVkBSpniuTKH0
         VRiRH0Ahn59+CeCVSHKX+nCND9OnUiwL1TL7WqHYUBvjfNp5HXdB7pr1z7KPLctT+ric
         5bh7H3cFFtmp2cbcikehP8101TEBWkJks1X5ZAc5mM932Gvtc5b8Pje/23dhTaBwmOaH
         7tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516806; x=1701121606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoOuxVfYX3lHdi36PKjYbl3tsLm17OpynR1y+9rBRUM=;
        b=YN8kyODE89DTSodKIXW/zbtOvg0sXhx0MCUxLb6yoX9kfRZDWrJObehWh/AaJpdGFc
         lxKw1Y9xRA3Ot7w3itFY+9pCYoJbOIYIGAVfjqumIApbJdWPeoZb12SkjtmzH2QfKmu/
         vQ6PUFmsS5fhaT/gD3edBZ10xPnZLHtSs+G2E4H2hUFlpYnomv1LRMO1JfLivRnjiWEF
         LA54oACvQ0r8P4Gf57jKaTJZH+7VlYfDbCWEXhUR7itxAxmQQmYWv0NEYrDjMNbTh/l5
         KS/QtMe2hDcF39gi6NaEaEU1zFLohN8LokhhLV09QYBmjf30tGZsBiBcPmWJqcutQSaF
         8b/Q==
X-Gm-Message-State: AOJu0YyUgzmhrBZKkkU65lEF7rpN806mm+UqkRTNVhzKuwMdlVd+Lnmd
        DjusGrC9twnPxm7QkV+2MIScY9kpkzg=
X-Google-Smtp-Source: AGHT+IEqJE/oVNOUE1Qqm8diYpUVGakA8xpgibcOqaJoKcZswdc3zI/IPqN/vZiu77V30PdsZ7piBQ==
X-Received: by 2002:a05:6000:1845:b0:32d:a4e5:d3d1 with SMTP id c5-20020a056000184500b0032da4e5d3d1mr7428728wri.4.1700516805958;
        Mon, 20 Nov 2023 13:46:45 -0800 (PST)
Received: from zotac.lan. (dynamic-2a02-3100-9030-5a00-2223-08ff-fe18-0310.310.pool.telefonica.de. [2a02:3100:9030:5a00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d584d000000b00332cb0937f4sm2667052wrf.33.2023.11.20.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:46:45 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/20] include/linux/i2c.h: remove I2C_CLASS_DDC support
Date:   Mon, 20 Nov 2023 22:46:23 +0100
Message-ID: <20231120214624.9378-21-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120214624.9378-1-hkallweit1@gmail.com>
References: <20231120214624.9378-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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

