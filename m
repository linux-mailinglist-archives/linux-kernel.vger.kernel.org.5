Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DBE7A174F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjIOH01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjIOH0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:26:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C1319A5;
        Fri, 15 Sep 2023 00:26:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf55a81eeaso14698665ad.0;
        Fri, 15 Sep 2023 00:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762774; x=1695367574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2LlgryffFXqAnsB0AaplLotGa39fDQAXZM7QJ4rjkg=;
        b=Snl9Y5XHaZKMjP5OADSAZuSBJ5RqTWFsYoPiVOdg7FvjIMo/mBJ3IsMWEyrfU7OE0i
         xDrzBxwRF2+iO7kh8MzGFkb/nzlh4Yyp3oqweDxiH8iMyByup/5pjXrmUjcKNpNco2N+
         Jjej64Kqdrhe5beAa28R0pYgMBvd9Ujqo1ItGG4JGqMMIba14cIJaojHKwNNvN/XKW9J
         FXHWjwrrx3wbX5HRXxhS+6Tug18rmgXxYEh8xNfSOEnbIFUf8I7xDhRPR1afz7ZgyVQi
         V8D+Bvgj6D4Ooax9YhYABvAYoJH6kiA/wCUIAW3qXy8KToFM9wi3hItOvfqp76Zzkyfm
         +9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762774; x=1695367574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2LlgryffFXqAnsB0AaplLotGa39fDQAXZM7QJ4rjkg=;
        b=cwrS2KtgMe6vjY8iquiolgKk3d+rId7hg8qnEGA+01gZwIgsByFC7Gjnp5nR6nDe4B
         kmEy8FbLvzUJCJSylraSafg5bBL0vmdOr4Y5mqyMg/72jfEKL3QN63D5z00pVrcUmf95
         I1vEhRhkDoZrdqatplRvXaRFVkl4B4ykaRaoRSZczV45gkL6bskZFU21M4LSHCViMiEd
         XEZ03oeuL7jjQz38FwsE3RBGX+zYGS34nJxFYrLyXk/dbjchv9aG2fE6EBXmLTEpRbyz
         QcmW6huQwxIVdfmR5taNZKjAg/fZbjmyRO9X2khRjMCLQcMiPjhs/Ygj6018Qe1TgYhD
         ORZw==
X-Gm-Message-State: AOJu0YxjYeUODBHfsU2ZzN/6uJJugpOhKNffnL928uH8K0fCzDyTZZiK
        2wgX6TPH2UOV4FMuL9aObnI=
X-Google-Smtp-Source: AGHT+IHq5IsXi3VI2LJb1QmXm6E4DKx49u2LCFsrdNeRgmTzjAomgQYQ3nGiPLmT+k5b2KUOcIbwcw==
X-Received: by 2002:a17:902:6903:b0:1bb:b855:db3c with SMTP id j3-20020a170902690300b001bbb855db3cmr667277plk.41.1694762773826;
        Fri, 15 Sep 2023 00:26:13 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902768200b001acae9734c0sm2752110pll.266.2023.09.15.00.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:26:13 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH 10/12] serial: 8250_dw: Add Sophgo SG2042 support
Date:   Fri, 15 Sep 2023 15:25:58 +0800
Message-Id: <20230915072558.118325-1-wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Add quirk to skip setting the input clock rate for the uarts on the
Sophgo SG2042 SoC similar to the StarFive JH7100.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/tty/serial/8250/8250_dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f4cafca1a7da..6c344877a07f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.quirks = DW_UART_QUIRK_IS_DMA_FC,
 };
 
-static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
+static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.usr_reg = DW_UART_USR,
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
@@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
 	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
-	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
+	{ .compatible = "sophgo,sg2042-uart", .data = &dw8250_skip_set_rate_data },
+	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
-- 
2.25.1

