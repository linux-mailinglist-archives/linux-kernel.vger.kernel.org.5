Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D207A7F01E5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjKRSFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjKRSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:05:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB2D78;
        Sat, 18 Nov 2023 10:05:20 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso4197136a12.2;
        Sat, 18 Nov 2023 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700330719; x=1700935519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBFVvNKhAX+OR3ALwztSAgxwFpQwZtLHeEc/T4Eghog=;
        b=WGOXmJEidN+cDr8AD1D47nzEkMzjYeh3Sob3AwND9W27Ms1Fq4wJ+pzTW7H52X2vV2
         ludrrpy2nqJmzI7ro9TU08xpFneh8vEXZ0uzyHlVc7Td+TBHQ9iGyX5EvdkshaB9PX8V
         C36i1v9oHQjxq625z5vl5+xZlmIh0NC4Wftn9bSsktZtlOBXcchHGwJOwUSkBkWe1siW
         Fa2rTArM+oqJ4byXuRX7RFwjMxB/uy9pnx5nLbGAfY7uPMcGLvOSz+6RUuEfj4oI2+ML
         TmAIKPNXRWh803g2UoZDeSS37wqWW9grEbFVNmrv/4q79WZP7+RxcpuYsvZH2lBYJUaG
         3Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700330719; x=1700935519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBFVvNKhAX+OR3ALwztSAgxwFpQwZtLHeEc/T4Eghog=;
        b=a/zaz3OH4+aY/iIuN1jZ1pqt9P+xk8UpiMJozj75e222ePGzcHtVoUlk6zomWYBO0t
         x3NTtzvE5Mw06e3caMnUHd5OJyrnfFWumA8/glwB80ElL2v6HKALhYCcPGiH0/Dpvep9
         6HNAiBjmZwYgJIjLo8SP/UYF3wNoWtzp2qvXIqd+DBKio5QNyyOQqcpTRCR2Kx90MBo7
         1Nisvr7XCxJ9nHY+iFdKIWLXa9l4gCGawnRvYFqnjz7FXiy22EE/SDwezua4NGwOY1nG
         zLqxchZY9pmIaBvScAfpAgWjGdkylEGlpXyCUNWTpsondzJtgJX0Y0AOCTO2o8W7f1BI
         TLzg==
X-Gm-Message-State: AOJu0YwT+Dm2DNPhjoG8irkxq3QF7H45F6Peb9MJdR/CtQ82ncFIKAHG
        qOa+w6RmBn62LnVF9sOi8I4=
X-Google-Smtp-Source: AGHT+IFLsodyE/iGxrAmK8Q8vjZyjsPvFWVlPjnusFENJcGXHtsHvV5fnFXdcbYSztPvp0PMT52eOQ==
X-Received: by 2002:a17:906:5185:b0:9e6:da40:50bf with SMTP id y5-20020a170906518500b009e6da4050bfmr1970039ejk.8.1700330718903;
        Sat, 18 Nov 2023 10:05:18 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm2079456ejg.151.2023.11.18.10.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:05:18 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Jean Delvare <jdelvare@suse.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] drivers/i2c/busses/i2c-ali1563.c: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Sat, 18 Nov 2023 19:05:04 +0100
Message-ID: <20231118180504.1785-11-hkallweit1@gmail.com>
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
 drivers/i2c/busses/i2c-ali1563.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
index 55a9e93fb..307fb0666 100644
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -390,7 +390,7 @@ static const struct i2c_algorithm ali1563_algorithm = {
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
-	.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD,
+	.class	= I2C_CLASS_HWMON,
 	.algo	= &ali1563_algorithm,
 };
 

