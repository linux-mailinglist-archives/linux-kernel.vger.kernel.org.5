Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD27476370F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjGZNHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjGZNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:07:04 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB58E1FC4;
        Wed, 26 Jul 2023 06:07:03 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e9e14a558f8ab-348cd23610cso14675225ab.1;
        Wed, 26 Jul 2023 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690376823; x=1690981623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZpGAyDHs3utSJykCSPcJtGLzKU6c3SzT+TtskGDTx8=;
        b=PcTBDrgloMYBZKmXxheIhSpiCZtwzRxE0p6RyX/gucG1H5wWcAAhfpoo430k3SZnk9
         PgXzafJhfUMnaeWV0Te9TVYqeS8jPL6t2D/07H+OZuS5SCF1z764nf6S4QX+YdkV6wkO
         h060Q90E3HZJKWQ31OYPNVV0xoRPjjA2f1d2Qed8PYn7IariQqJVu0EMgE6QdtO3pSLv
         Zs4LvObvRdxsftU2RA9u4A5+KD+PI1alARJ4Go7XEDVBfFluBAIocLeu+/LrR2pFWQNr
         5k7Qs6yEzqtJgNTgi7B1H9AII2SI8g0/TYEEoKcgBLLHLTr1yIMkrB1c5uVVedAzvkm7
         2tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690376823; x=1690981623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZpGAyDHs3utSJykCSPcJtGLzKU6c3SzT+TtskGDTx8=;
        b=E6nvqGd5at3tzRPo8JsWvKQCE08Ogi3i9iqf7h6lecyXPFg3ka3xGmXGWVwrbbye3r
         p+ovf4gy63YhOZq0NwMZRNe64QKQLg+nyULNxjI+8qqvzQsDNQYJoartuI9GCpPpersV
         WsYEX1ihuVUFyeL2BH2zzQlPXY2vBx6VGyDpL/nmCT9ZkrfXyGURSZIXuIB9o+pX7qSG
         ZMDQksNgF0c3XRP9S7S0NQRAvOIpwrjeBKmN36ZkE8NB+HOklr8F+e0vk49/SI3XoQG2
         uqpsYVJsuVqplRX0aC/2LZjbCGRE72q9HVWWBJY6CAsBw8Ockd7o93UVBwHjPdSrt09m
         DteQ==
X-Gm-Message-State: ABy/qLbpbpMazGcV+OFBD6RTn700MhHCSMpDahC2pkISUq6JvJcchF3O
        W3E5+eHT+eTo/6X+4o1SWraQOQ+hJjMPeQ==
X-Google-Smtp-Source: APBJJlHQxJa6dfaPFhn4cNwidJ42nM2kAsqjRX5P42Ca+9d3wJMfY+AopEuetxbnSjx1vUqd8Uio4A==
X-Received: by 2002:a05:6e02:156b:b0:347:7399:e9c1 with SMTP id k11-20020a056e02156b00b003477399e9c1mr2031355ilu.14.1690376823085;
        Wed, 26 Jul 2023 06:07:03 -0700 (PDT)
Received: from ws-565760.systec.local ([212.185.67.148])
        by smtp.gmail.com with ESMTPSA id q7-20020a92d407000000b0034881250ac8sm4399077ilm.28.2023.07.26.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:07:02 -0700 (PDT)
From:   werneazc@gmail.com
X-Google-Original-From: andre.werner@systec-electronic.com
To:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] hwmon: (hs3001) Fix unused variable compiler warning
Date:   Wed, 26 Jul 2023 15:06:02 +0200
Message-ID: <20230726130648.23056-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <11620112-ffe4-8df1-6b38-0f3082c5d16f@linaro.org>
References: <11620112-ffe4-8df1-6b38-0f3082c5d16f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Werner <andre.werner@systec-electronic.com>

Delete unused variable in drivers probe function.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307261819.VMDuxZOM-lkp@intel.com/
Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
v2: Delete blank line between tags in commit message.
---
 drivers/hwmon/hs3001.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/hs3001.c b/drivers/hwmon/hs3001.c
index 17c3455922eb..9972f6bbb22a 100644
--- a/drivers/hwmon/hs3001.c
+++ b/drivers/hwmon/hs3001.c
@@ -193,7 +193,6 @@ static int hs3001_probe(struct i2c_client *client)
 	struct hs3001_data *data;
 	struct device *hwmon_dev;
 	struct device *dev = &client->dev;
-	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
-- 
2.41.0

