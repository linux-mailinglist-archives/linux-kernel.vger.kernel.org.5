Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406047F05E8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjKSLaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjKSL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:29:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6355C10FE;
        Sun, 19 Nov 2023 03:28:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so2689429a12.3;
        Sun, 19 Nov 2023 03:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700393327; x=1700998127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoOuxVfYX3lHdi36PKjYbl3tsLm17OpynR1y+9rBRUM=;
        b=DaKm0WFpw4PtuyW50BcNwa8kUrDaTwYYr1CQlZAj9eJdibdWWJ67dKTENpbRoVTQpQ
         GYHo1dQY5j6Qihfxkbd/YzlEvMWeJVMomZUXC1qOhVp0mf9jEle6VMA6ZsbVToBKe3+1
         mvoFxtOgHOJEkmL23D0aypRezsZRBsQoVX7CRn6xpJzJbSbgxRXLDDVfB2mPC/KNzeC2
         imqbD66+H1e2N5DNuYTs2jTrujMQ9ChfzqVilgIp3vTjBU7pIHwjEappI42aJWeRuuJd
         KfBkPzF+Qdvt2b/XG0RbiBa8EjY30dJXH0OCHphd+pMxPh6DrGy3KCF+fQqbBz9/ibcQ
         Syzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700393327; x=1700998127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoOuxVfYX3lHdi36PKjYbl3tsLm17OpynR1y+9rBRUM=;
        b=n4lPx4I3PnHPESx0UpnHmTgjrr1AOFFxyCMJATwaDIhMzoHJq9VZKS5YRRIZze8VvT
         SESZOaO10G3g9P9erl/LwJEpAOdXQDUGFI+dlcok7z/AbRZWyRFfxa95Y8mx6jbtyazU
         GDYfQE28Z8laPkNnA3+1aeY80HPE1iVUy2BcEXLNYea8a9OCb/dwd7yY95gZ22PWtrx+
         mteuZW7f1WatSDnZH/WPV6F3Ee1WgwfbFEfji5F7jouLrZztNAIHJiRxY4p7z/G9nket
         QDtp+efIvMj7yBKOY98v6CMoNeTMqpzGTk4XhedspCHi+P/IxrAUtPWEHTl+Cqs8O5XA
         6QPA==
X-Gm-Message-State: AOJu0YyfOpvnu6Xu0F7xk5okZNiqm5lcweHqqyHio4UXC1jQfjwiRAzl
        gFLgA26w7mlGThivUTpdAJ4=
X-Google-Smtp-Source: AGHT+IHfngVXlSW4LUIjnlkKJhW6cPwJdp2SIROIb9ruMWWShNHesG1OZE+QGCvwGdrnD4kqvy0Bvg==
X-Received: by 2002:a17:907:2da7:b0:9c6:1143:b52 with SMTP id gt39-20020a1709072da700b009c611430b52mr4489746ejc.55.1700393327195;
        Sun, 19 Nov 2023 03:28:47 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-bde4-3e00-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:bde4:3e00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b009f8af454d0dsm2420378ejj.112.2023.11.19.03.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 03:28:46 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/20] include/linux/i2c.h: remove I2C_CLASS_DDC support
Date:   Sun, 19 Nov 2023 12:28:25 +0100
Message-ID: <20231119112826.5115-21-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231119112826.5115-1-hkallweit1@gmail.com>
References: <20231119112826.5115-1-hkallweit1@gmail.com>
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

