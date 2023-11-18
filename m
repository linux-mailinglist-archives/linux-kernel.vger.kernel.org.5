Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C187F01E0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjKRSFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjKRSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:05:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFCEE6;
        Sat, 18 Nov 2023 10:05:17 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991c786369cso426548466b.1;
        Sat, 18 Nov 2023 10:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700330716; x=1700935516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roBdCcPzLstLM8/JSIpHl0j2D5fXKoNfX0rW8q8tWfA=;
        b=VyO97uV0Av7l/4W2GVvwl+0S0J1ojkNjvjYZmUnUUzSRgVcJUBlIuE0lmVKY9qjnUP
         1V0u99zgcxO/wtQ6DGD93pM83Cl4cW6hw0aKlHuf+Pag0IaW7aOvWmLTwLVG5kAtsmOl
         F1TlUI1iv5puxwqff7VEae7GABGpOLqWjWZBEbwVDANorQMXgXtbKZ8XQpVmNLFBfHOb
         ubjUHIUy5r3Tp14k5mX3PhWkI5Bl2SY8cBiG00IZDD7nXAIIY3BN7g0v3Q2kihRd9cqY
         ajLp0eIAqMiQ8ALKzK/37PpO+jkV4n0eZoimyetApy8wZqZmMyKpy98cIbe/aBAr0P8X
         b4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700330716; x=1700935516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roBdCcPzLstLM8/JSIpHl0j2D5fXKoNfX0rW8q8tWfA=;
        b=ulunymfEYwdjSUPHd2ezXR6k8C9dgXyjd9iryHzsnWcmAdrKZXjgs0657M3Y/JiJSi
         8dupmeg7kaapnAt1v5jhVfLpJ6gJWGvfGQd9J0hd5ZzQqrg6p6vCwPkMd9f613xA0kUx
         gyWFoHkAdSYb2hziz8XTHvMWk5hZ6e7iSenq1Xln8FYyNzQgIbA0X08fNMXaDL+ksZQ2
         lTG7mgn0mCQDR7UE35GLihuES9aGfTrzkk68iT86qbBsmC6mO2SJQ44pJ9wWkrgDsBhv
         N+gW85zSvaffzaGO2gbVpdOHJTp3mMCP5E1Fl+1BzjzAiWnhjkcUQ/yYbQcDCB1L0Wjt
         DsCQ==
X-Gm-Message-State: AOJu0YxnQMIJvYwYCPiwldyKkF8exBcMCR2Bv1zUt8ZdJwT4F6gs8it/
        /zlZbRrmRmtSgXuBTZWEzvk=
X-Google-Smtp-Source: AGHT+IFuIGbRgTD4uVbNdcVghcMFD47Oaw8MS2fl2m1153cbcnrxqtCQ1AwH2CiR5GHDmRZ+Ogwx0Q==
X-Received: by 2002:a17:906:f193:b0:9bf:5771:a8cf with SMTP id gs19-20020a170906f19300b009bf5771a8cfmr2174684ejb.70.1700330715918;
        Sat, 18 Nov 2023 10:05:15 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm2079456ejg.151.2023.11.18.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:05:15 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Shych <michaelsh@nvidia.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] drivers/i2c/busses/i2c-mlxcpld.c: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Sat, 18 Nov 2023 19:05:01 +0100
Message-ID: <20231118180504.1785-8-hkallweit1@gmail.com>
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
 drivers/i2c/busses/i2c-mlxcpld.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 6fec64ea6..099291a04 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -477,7 +477,7 @@ static const struct i2c_adapter_quirks mlxcpld_i2c_quirks_ext2 = {
 static struct i2c_adapter mlxcpld_i2c_adapter = {
 	.owner          = THIS_MODULE,
 	.name           = "i2c-mlxcpld",
-	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
+	.class          = I2C_CLASS_HWMON,
 	.algo           = &mlxcpld_i2c_algo,
 	.quirks		= &mlxcpld_i2c_quirks,
 	.retries	= MLXCPLD_I2C_RETR_NUM,

