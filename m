Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38D7F01E2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjKRSFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjKRSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:05:25 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B153D58;
        Sat, 18 Nov 2023 10:05:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso398915466b.1;
        Sat, 18 Nov 2023 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700330717; x=1700935517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbsbH1CThP42UiUJns2VDtTJbIoXHmLVJdFuam5YX4A=;
        b=Dv1atdjHcnH/I2odaOBenqZknAsMnKzuSQWWgeZPa2HfRKHZJKBv9Sl+MgIYr6Y2zU
         qnt75kcKK3rNa5np1KabUB7otAx/uHdrCDpkfxTNDq2YySVWaLAoA2YD9QzX4ZxnNYAn
         XVNHJxftBKepdmKI+60sTXxmODw1bw19uK0o61ZK2H0EiPa+ynDxqrGRz23vfxuKyx1f
         ISlGzp5f2j8gxxbXmg+xxvRVnWkhM3uSm2d01tFJls9GHsyI55WnagtCAyLLIuygy9hH
         9Pn2xouodlTVkMQo0XJbA0yvvm/qzYoGxjg7v4tdZj2gwffmmA7RyDAw8a9b+g8ucMOK
         WkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700330717; x=1700935517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbsbH1CThP42UiUJns2VDtTJbIoXHmLVJdFuam5YX4A=;
        b=jBrXXt5zX/hyUkTiM5FECe9OmA9I/R14NI2jc0mOG3jWZGQc93wDYNOK1gBqWBxKuy
         GYIF0VsG85tKxcMupytOVm4WcfHZeM7PpgAQcsGrk7Ur3kmRNrAnq8ipleSauB0E9q26
         JK0Fzqm3UGly+7tL64LpYUPeUyYQk3D036e9TtvieHsWSZLiY4BEWoSCe2wAFGDa5rja
         Z5Vyw+OPUdqwpkWsBbprVr9HNC80TpxCEE4GZO1OsW+QIG/MwRQMgN7ZYynT+MfTXZ2C
         04yR6g7bVXByu9UazPaaaZOjb/sgIa8Fw77XkGmjv73QtasT3IpB1GfzCuUIBVQjDLco
         J+TA==
X-Gm-Message-State: AOJu0YxTHejG0lUrJ26vB1CPgidtrfvUJvfOuu9Lorlq3Qrf1rJwcGdM
        dGhqiO3afGPdk1uvGdN5kQE=
X-Google-Smtp-Source: AGHT+IE6NYND1q390q99WYS/6bIoGK12vSvwGzpUiPl4o+SJV3Ry6vIbBPSwfHZdeucyCd1k1/QcHA==
X-Received: by 2002:a17:906:d7:b0:9ae:37d9:803e with SMTP id 23-20020a17090600d700b009ae37d9803emr2558599eji.8.1700330716752;
        Sat, 18 Nov 2023 10:05:16 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm2079456ejg.151.2023.11.18.10.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:05:16 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Sergey Kozlov <serjk@netup.ru>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Abylay Ospan <aospan@netup.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Sat, 18 Nov 2023 19:05:02 +0100
Message-ID: <20231118180504.1785-9-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118180504.1785-1-hkallweit1@gmail.com>
References: <20231118180504.1785-1-hkallweit1@gmail.com>
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

After removal of the legacy eeprom driver the only remaining I2C
client device driver supporting I2C_CLASS_SPD is jc42. Because this
driver also supports I2C_CLASS_HWMON, adapters don't have to
declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
It's one step towards getting rid of I2C_CLASS_SPD mid-term.

Series was created supported by Coccinelle and its splitpatch.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c b/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
index bd38ce444..46676f2c8 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
@@ -289,7 +289,7 @@ static const struct i2c_algorithm netup_i2c_algorithm = {
 static const struct i2c_adapter netup_i2c_adapter = {
 	.owner		= THIS_MODULE,
 	.name		= NETUP_UNIDVB_NAME,
-	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &netup_i2c_algorithm,
 };
 

