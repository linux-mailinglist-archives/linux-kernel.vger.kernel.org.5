Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF617CBCAD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjJQHr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjJQHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:47:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0893
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:47:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50305abe5f0so7008230e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697528839; x=1698133639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JQ6xELgmoE4Fh5HXfTlqwZoaUxUMP9X9H3TeeWmUuM=;
        b=NfpO+Ujv2qjxJgZbDCuqG72tEtnEAOA9KErrM1Z9E0ihKHiM/gkdHXKukzxk87JACd
         A60svqB41w+vsjlvlQu6M0RU4+vQBYwIsQV68HbIlPQalTOWDPaQrdASM2XC2vXsN+DV
         9UHrjxPcADYIGK2Q6SK4fUbEz3MaD1vP5eRSHAJONe+8i+fk4Sn4BKsSeWnHQXnMYXiQ
         X8bIDKXtWAK0WBz61My2FG4aBPrhotf9FDY7pdzEZ6wmYyvLFpw6dwjb0mL/g+4q8ZDa
         mZg7ayVnWnCo3zcHRc3oSsjj9JVdj5wbM1PPvmux42JRZbKffEzcJN5MGZovoI7mUp+q
         EjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697528839; x=1698133639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JQ6xELgmoE4Fh5HXfTlqwZoaUxUMP9X9H3TeeWmUuM=;
        b=YVCCxgFaWuZAJXUmiPS/RdBH9KDu19vtaA8QeYlRY1ie2D5Du2W6p4qC+JL0IT77Hk
         o/d6S8GNAwRgDVs5gsXjJubP5PLEvca0UeZoBbgi5f+hmcdErBrsZeZpw+LWuOwyKQWA
         CDhgHhf0IJDQhNbK4wz8PFw5mnZXbeamwY63P1XAoakQBO1HDwrn3v6kpBReI+R37C/N
         l5zOP/ogcJNVRco6yDXGwfqw2K04PQr13iBDM44dZvEom5ta+ABWSbq4j1mXdneTy6YI
         dvybA0NPeHM3Ju8vvpfWkUUd/F1UFB1zYzo5f/KhtHwxcPcZ9NvERVzj7GtjQH0hYxeE
         cX+Q==
X-Gm-Message-State: AOJu0YzEl9bqdWHcu132SmnjWT0EtqwJe9xnT8E26s5Q6cN+yIBu2XlJ
        S3LtB0CeVmV5CwT02hOe7BBTpg==
X-Google-Smtp-Source: AGHT+IHlHZwQqrTyGPKmgV2WXL2sNBDNFXFUtV0dJXP0gQZmhVIwlGJmwOUIMXuP/U+neFWoA2X+gQ==
X-Received: by 2002:a05:6512:b9e:b0:500:92f1:c341 with SMTP id b30-20020a0565120b9e00b0050092f1c341mr1508285lfv.54.1697528838907;
        Tue, 17 Oct 2023 00:47:18 -0700 (PDT)
Received: from 1.. ([213.233.104.181])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b0053db1ca293asm718688edb.19.2023.10.17.00.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:47:18 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 1/2] mtd: spi-nor: micron-st: enable lock/unlock for mt25qu512a
Date:   Tue, 17 Oct 2023 10:47:10 +0300
Message-Id: <20231017074711.12167-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=tudor.ambarus@linaro.org; h=from:subject; bh=8ZXAgQ2R8FwdwbDR6I4ATP7ZjR/H4BnBjM7H0wHxwc4=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlLjv+MSSshEngD1lT20bTB3F71hHFmXWd4cUpD GB0cvWpbVeJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZS47/gAKCRBLVU9HpY0U 6QqyB/9D8tw7XWJozUL6TBolhqgyRnicYMVwWevIl9BnVCasS7VUJpWXrEpQhXrMBHsKdHh2/cC SYTTBrcwdzJk2ANtEleoZwkHEC/eKJmKkIT3ITT/HfrqzKSi5UhPxIvWiVMqXKFVEAsgOB/yu4Z yH/OJYjHLaQEzrWx4ic+LL8uF+mNztnEG3Mt64eCheSMm1j6+TqaoLdumdNjC+iMpBTQVViRND7 F9+w8bMUuOe1aQf0HUpZboCODFJmxuMVLdkychq7GP0i0fLKzQIDWXYpuJNjnhVv66xNOF0kSBJ ReSl70MdZn5O4JWdr52n2IKCH8n4uSftlPvwZY8lapktZ2Si
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mamta Shukla <mamta.shukla@leica-geosystems.com>

mt25qu512a supports locking/unlocking through the SR BP bits. Enable
locking support. Tested with mtd-utils- flash_lock/flash_unlock on
MT25QU512ABB8E12.

Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/micron-st.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4afcfc57c896..756391c906e5 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -405,6 +405,8 @@ static const struct flash_info st_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
 		.name = "mt25qu512a",
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			 SPI_NOR_BP3_SR_BIT6,
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
-- 
2.34.1

