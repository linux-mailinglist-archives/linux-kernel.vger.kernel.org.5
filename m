Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4511F7F01D4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjKRSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjKRSFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:05:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1BA6;
        Sat, 18 Nov 2023 10:05:13 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9db6cf8309cso402009966b.0;
        Sat, 18 Nov 2023 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700330712; x=1700935512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvMhLdgxzmvHjkFyHLWsZZ7IOFCpPNkXdifeaawKQLI=;
        b=VxjVD0jUoPbrMJcrPHMUImbdU75PDwjy0z4aAoFwhHZEz/G1qQj2iiMjK+b2V17Buk
         h+zYKK5TEXErteSmwdZ9ab00qYmrckbicwqts+mA23KB4neeDTAG2irtvsplINcOCjwt
         QQYCSgssPXecm9gnpGYjfAjYdV/2f001Wwf7NOOYwVpGKytrAKo1v7TtBaBWAEfK79bs
         eAGa6oqL4mM1+a+3bi3sshuh0KS7u3fz0wyGIhjfJOCeLiX2Zc7O6OQML4xkxlg3pw2b
         t+9yuvz6mqKzVI2l8uICmU/GlbvWY+AwhOj8hN86v5UitQzh1nQghrU/7CCg0Y6TNHOc
         vLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700330712; x=1700935512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvMhLdgxzmvHjkFyHLWsZZ7IOFCpPNkXdifeaawKQLI=;
        b=KmW9mPAfebVObG+7UliNi4f1R6G3ysSII38xxDlsckwF/VIy6r4nNNamlMVojtxHI0
         Rvrr4RfW0i5/QlM6lHbZje3C5ZR28Xhc1Fy3GJfc5dPU1+NYWDYdhHPtnJ7f1vZPXwZY
         ntHaRAP+BD8dHAlNjib+iwCAqaJeIx/6+IuakP8W0f4v32/mJCOUpjX44GCyLEKBjVKg
         tkG+w1vgmxPE6sJOQ+qWpEAR7KHkmQVyWqHpjeZpiXS3PUhd+mYuCBVFXJV87XfriHXO
         PNkivZGR7YB/9ewvJJVzGCgy/ZtTvYyweQaD2Z/1ynwEegUZKI1jc7CrKaFJSl7zRRIo
         ibYA==
X-Gm-Message-State: AOJu0YwaE+Xn+Cu4ihDIEcut4hP8E08jSAPlpt5zhQ3UnnXvobvSazSi
        BxEv9BdNdaNEVOmAtJr3qDE=
X-Google-Smtp-Source: AGHT+IGmY36vyE2njGaUXhkxvF2ffP5gHcb+uEcsV4u6HxS9Gv0SaqYqLLEs3KVtE4jvzvFYDygO7Q==
X-Received: by 2002:a17:907:84d3:b0:9e3:ef19:7205 with SMTP id oh19-20020a17090784d300b009e3ef197205mr1849277ejc.3.1700330712142;
        Sat, 18 Nov 2023 10:05:12 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm2079456ejg.151.2023.11.18.10.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:05:11 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andi Shyti <andi.shyti@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] drivers/i2c/busses/i2c-pasemi-pci.c: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Sat, 18 Nov 2023 19:04:57 +0100
Message-ID: <20231118180504.1785-4-hkallweit1@gmail.com>
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
 drivers/i2c/busses/i2c-pasemi-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pasemi-pci.c b/drivers/i2c/busses/i2c-pasemi-pci.c
index cfc89e04e..77f90c743 100644
--- a/drivers/i2c/busses/i2c-pasemi-pci.c
+++ b/drivers/i2c/busses/i2c-pasemi-pci.c
@@ -56,7 +56,7 @@ static int pasemi_smb_pci_probe(struct pci_dev *dev,
 	if (!smbus->ioaddr)
 		return -EBUSY;
 
-	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	smbus->adapter.class = I2C_CLASS_HWMON;
 	error = pasemi_i2c_common_probe(smbus);
 	if (error)
 		return error;

