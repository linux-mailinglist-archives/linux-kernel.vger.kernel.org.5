Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB2762F10
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjGZIC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjGZIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:01:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C34C24
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso55620465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357996; x=1690962796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU2izS7ltcfKojKR/fjnJHc55e+84FS6l+Y7MexOBa4=;
        b=tc3ftSFSYfLDFqyNY3lha83ooX0LEVhGmAmfhijWboXT7OL8NEWQo0CgIGiy0Xwbjp
         R2p2tgbN1InIHYLx1Ks6LLWjZ7vqGk8j60STJvMP4qpdD0nSUR0qly7PncnmmNneXBTB
         kgTo1LRl0yrJgRFJEYwsZAhcBZm4i2KhMHSAHvB8EBn6yb3PHASy/2uwZZTvdSMyr/1B
         WjlZ2VP2JPh2+66dgd1RCicPUPkLBa/yRZYetx0KVdJat7xrrxbuzdPLemA8Jx+82ER/
         eGXL6GxQKfMTDkF+shdtaUDkPq+D0yOb75mY4330ba5kRoXKLfkNRukgrMkPO+ZaVo3N
         k+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357996; x=1690962796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cU2izS7ltcfKojKR/fjnJHc55e+84FS6l+Y7MexOBa4=;
        b=hEnCEMyx0WCes9sgQgciGZLow2jTzeSowcvGxKBfvcD+vrY7ydcg+/21RzCnA3roTu
         A9mTcl5UczFePy6PA8MereHuscYUtIBNnTL9VJTsFqZvSqI9OhGZAwd5Sb+T3ZtPfPx7
         Nk1vGCd6BzGBHL326J2DFxfzmo9awh09djnDQeS4/4iyHvAWPiTETT+J9hlh6/s4yUet
         ojEbGXPr0UjncAYzMRbbmsuILDZQ6mOj/h+LdI1e1fcVBq5MTx9/LzK0Wv/Ql0gW4QRI
         S71Ku2XwOyfcYcUmXaBUnE3GjviRg2EfQgwWrpeXarbgeHx+ZNjvNeUSVAZF3ZhLHPVp
         b2hg==
X-Gm-Message-State: ABy/qLYWDPXpzW3eyC5vHqYryXjxzrGkS+WHcf3zDlotKOG7UeUjLfdF
        N9iu009KXBKM1g0fta8zff22auP78xikkjtRfNc=
X-Google-Smtp-Source: APBJJlGGKJUPX9zKGu3j7bheBiAy9QpBMFUNiQ56otABz73VtyPfm8rT9IqTE+uw3ImyQfldicdnPg==
X-Received: by 2002:a7b:c319:0:b0:3fc:8ab:762a with SMTP id k25-20020a7bc319000000b003fc08ab762amr790146wmj.18.1690357996247;
        Wed, 26 Jul 2023 00:53:16 -0700 (PDT)
Received: from 1.. ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b003fbca942499sm1264346wma.14.2023.07.26.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:53:15 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 09/11] mtd: spi-nor: spansion: let SFDP determine the flash and sector size
Date:   Wed, 26 Jul 2023 10:52:55 +0300
Message-Id: <20230726075257.12985-10-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726075257.12985-1-tudor.ambarus@linaro.org>
References: <20230726075257.12985-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622; i=tudor.ambarus@linaro.org; h=from:subject; bh=NWgsTDYFKhLtFe1K3wQNDGm5Jii1w6YuOY2WYJMPxYk=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkwNDYxqAXwIx9um/ULZdRtFO/54oPjAlOZo3WV 4xeGJRr5K+JATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZMDQ2AAKCRBLVU9HpY0U 6fDXCACmE/+X59ggt+KG1kP7Do7JSnTBG9Yl+9ZLzTJ60ZG18uQ5N7K62ujAyuU2wGAyoPEpCDJ 6wC9Ec2XzCrD1xCn54hJZ9/KTSQi0EENoBPkvgnQ/ZkF75GungoqAxvvBTaGzT3xwyWziJr4tQN dL/4l46b23943U7VeMjVPPXpISWZeXi9znDvnEy5uw4W1GltVT6rHQ7aYkVGP+9zQAaW2ywWWas xEqPzjfSzC2pN3JagClyNmPlHKDBecOf6jGWpcOasqACbMdCgrmrdX7+53hk5wkKqy2wkEmIUFp c+P07MetPKJt7pckkYdJwOuMTZtECX0QFhpbt3UWETIsxFQP
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sector_size is used to determine the flash size and the erase size in
case of uniform erase. n_sectors is used to determine the flash_size.
But the flash size and the erase sizes are determined when parsing SFDP,
let SFDP determine them.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 1c5671a3751a..30a3ffbfa381 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -873,11 +873,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25fs256t_fixups },
-	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 256 * 1024, 256)
+	{ "s25hl512t",  INFO6(0x342a1a, 0x0f0390, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
-	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 256 * 1024, 512)
+	{ "s25hl01gt",  INFO6(0x342a1b, 0x0f0390, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
@@ -886,11 +886,11 @@ static const struct flash_info spansion_nor_parts[] = {
 		MFR_FLAGS(USE_CLPEF)
 		FLAGS(NO_CHIP_ERASE)
 		.fixups = &s25hx_t_fixups },
-	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 256 * 1024, 256)
+	{ "s25hs512t",  INFO6(0x342b1a, 0x0f0390, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
-	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 256 * 1024, 512)
+	{ "s25hs01gt",  INFO6(0x342b1b, 0x0f0390, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s25hx_t_fixups },
@@ -901,22 +901,22 @@ static const struct flash_info spansion_nor_parts[] = {
 		.fixups = &s25hx_t_fixups },
 	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
 		FLAGS(SPI_NOR_NO_ERASE) },
-	{ "s28hl512t",   INFO(0x345a1a,      0, 256 * 1024, 256)
+	{ "s28hl512t",   INFO(0x345a1a,      0, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
-	{ "s28hl01gt",   INFO(0x345a1b,      0, 256 * 1024, 512)
+	{ "s28hl01gt",   INFO(0x345a1b,      0, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
-	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256)
+	{ "s28hs512t",   INFO(0x345b1a,      0, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
 	},
-	{ "s28hs01gt",   INFO(0x345b1b,      0, 256 * 1024, 512)
+	{ "s28hs01gt",   INFO(0x345b1b,      0, 0, 0)
 		PARSE_SFDP
 		MFR_FLAGS(USE_CLPEF)
 		.fixups = &s28hx_t_fixups,
-- 
2.34.1

