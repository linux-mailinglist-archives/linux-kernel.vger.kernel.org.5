Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87627F5B82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjKWJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjKWJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:41:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC84D50;
        Thu, 23 Nov 2023 01:41:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548b54ed16eso899757a12.0;
        Thu, 23 Nov 2023 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700732462; x=1701337262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoOuxVfYX3lHdi36PKjYbl3tsLm17OpynR1y+9rBRUM=;
        b=njKKRA1xeZ0YPPMTB9xB3fUKJ9aCj4TrC51CWaENnDqPGU8di8X3WBiAslbmRbFFt9
         goHIsDNXzchKvUQ/zdOX0a1IA3XvdcCfjeC/KN46y1ysbGzywzKq3PuJECAZHhxtGiLo
         G2QQ0+U0DHnmgVrgNjg3Y1Uo/8PR3WQNwIUWzzQpV8Qjw4fy3xLimerLI52kAPzu+wev
         eK3D7qI1VXjYwThjgaR6n2rEJNDnPGcwUe7MOqsI9ZnFixYN/jEaTQHfgIwmXTRl0ANW
         AJwvZL4TRezK7rAnGpELy7t96SY2lxffEfIn597LbV8M2XgkL0HPF/gQSV9nRK7SMwHr
         bdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700732462; x=1701337262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoOuxVfYX3lHdi36PKjYbl3tsLm17OpynR1y+9rBRUM=;
        b=HLKbzzfbEZ2J5KV5llYxY2LIuhoyQPldLL5xYCuLnUH76d1EjFn5JRQlZvFFtLp73o
         t3PKfso+mcqaT41ytAhx9ibgitfbVumnfCXhmkIUTfuVUQ6Tki+HNiUbMVKTWrb00D/G
         qHZu+N7cqCkNLI4eXE+3Qmv3VKZh/waofz6rEBZ4H+4CWlwnKsT7thwqvig7BxJ8q2i4
         M+rAJX2tHdUAiSSXf5j5IeMOoPZGQiWPhF4bhwSsC11KCSVKedUfVgCUplg0lQC2ltsF
         9njM35ce9zL5KNPCfjD4HCavvD1o7h3zUnAye3nIecKEY0IvMl0pSmgDEkjIB6vdVu3U
         2Uyw==
X-Gm-Message-State: AOJu0YwXTp4TnYU3NLWAUZfk5azdP6hTnD6C+jfHjqriyVy7yus7deqq
        g67pb6hTHAkFB/oTwyijXogNkZERp/E=
X-Google-Smtp-Source: AGHT+IF2ce8O4Dy0JVMTvh8ywPgv8CHjTNcsicVHS4uyWnf5FWv5HXbuEkjOnpvoMHQySO7ke4A8Qg==
X-Received: by 2002:a17:906:8a:b0:a03:d8ea:a264 with SMTP id 10-20020a170906008a00b00a03d8eaa264mr3680644ejc.2.1700732462058;
        Thu, 23 Nov 2023 01:41:02 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c23-c0f2-3200-2223-08ff-fe18-0310.c23.pool.telefonica.de. [2a01:c23:c0f2:3200:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id s9-20020a1709066c8900b009e5ce1acb01sm546199ejr.103.2023.11.23.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:41:01 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/20] include/linux/i2c.h: remove I2C_CLASS_DDC support
Date:   Thu, 23 Nov 2023 10:40:40 +0100
Message-ID: <20231123094040.592-21-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231123094040.592-1-hkallweit1@gmail.com>
References: <20231123094040.592-1-hkallweit1@gmail.com>
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

