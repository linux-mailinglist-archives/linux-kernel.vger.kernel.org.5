Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B53751575
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjGMAoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjGMAn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:43:58 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37A11BFB;
        Wed, 12 Jul 2023 17:43:56 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76714d3c3a7so13790685a.3;
        Wed, 12 Jul 2023 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689209036; x=1691801036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctfcNvmXCLdilZetDLmDAT5s0h11fEA2yL1kjJ2Bgkw=;
        b=mJVwYx3wT3csIgmwctWrDrMt2cF/8nVp4alI2BuKSulTWJWKTfc2wluKiDs2I0cmzy
         BcdcAHILSt8XtgXiXd8kU4FkwKexsgVkL9EBNSYY4YGEnMohpMXELfrfUT0TmHvpCdQA
         UdeEjhYICVD5yy+DJuPD6iWX5idBjDfIP96SKYYm52w99Y2cwNQxK0FCcAEuQiQX7jgW
         M1gCSfemoCEypb1ifVQFsz8bUKOpVKT9tW4RM/EcCUSOsTvy7guQOXnLKRxHeVLsZibF
         9iYaXWsVm0sdbcd+nK1dISr9UJYdPd1uMM6JimdpGyeoPiLGap4o9iWLkSwMMDFbIyl/
         Pv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689209036; x=1691801036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctfcNvmXCLdilZetDLmDAT5s0h11fEA2yL1kjJ2Bgkw=;
        b=V9inq2VFg5By1IlNg4pW1duY0zhnMIcI6xVvaxN+yefABr/38j6+xwk7veSMwrfv5f
         l8u5t7S0PV+M3OdQb3CXNbRr13aa4UadsQmI4Co4gumpG8QirnoJoGIpMuHM6bITFh2v
         pbwqkLS3ZhpPgukVztJp+umMJefM8j+2KdUVumY248Rr6WGT6xmqTW53gUOjOPwQ7P5x
         hsIr+TJk67Yj/82URxWiYvmIvHZOfplv7ZkxnUvGIHMJu1qjpsffVBWv4xfNOicoXrwZ
         KREAYnTNBYvWx1LurSwIwIeU14uzK6q+hR/NsTswlns/ESqrIrgFGiBiXmxETA1+zMsO
         aDkw==
X-Gm-Message-State: ABy/qLYArjccdywOeqjbyIWeWdn9npJUg8bBwUSSHjBYH1OJXe/rw16m
        tfCMtQwBMBRBmSpkCp3bTQE=
X-Google-Smtp-Source: APBJJlElZlwDd/ckdxtAzGTCyIBFyiQJ+fY0LkGeLvsW3zUUGtawW/nGACd+DKLGxheN2AWglfihSA==
X-Received: by 2002:a05:620a:3187:b0:766:f654:9c9e with SMTP id bi7-20020a05620a318700b00766f6549c9emr53073qkb.57.1689209035714;
        Wed, 12 Jul 2023 17:43:55 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id k10-20020a633d0a000000b0054fe6bae952sm4248687pga.4.2023.07.12.17.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 17:43:55 -0700 (PDT)
From:   Ruihong Luo <colorsu1922@gmail.com>
To:     ilpo.jarvinen@linux.intel.com
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org,
        luoruihong@xiaomi.com, weipengliang@xiaomi.com,
        wengjinfei@xiaomi.com, Ruihong Luo <colorsu1922@gmail.com>
Subject: [PATCH v4] serial: 8250_dw: Preserve original value of DLF register
Date:   Thu, 13 Jul 2023 08:42:36 +0800
Message-Id: <20230713004235.35904-1-colorsu1922@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Preserve the original value of the Divisor Latch Fraction (DLF) register.
When the DLF register is modified without preservation, it can disrupt
the baudrate settings established by firmware or bootloader, leading to
data corruption and the generation of unreadable or distorted characters.

Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>
---
v4:
* Use the old_dlf to hold the DLF register value

 drivers/tty/serial/8250/8250_dwlib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 75f32f054ebb..84843e204a5e 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -244,7 +244,7 @@ void dw8250_setup_port(struct uart_port *p)
 	struct dw8250_port_data *pd = p->private_data;
 	struct dw8250_data *data = to_dw8250_data(pd);
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, old_dlf;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
@@ -270,9 +270,11 @@ void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
 
 	if (reg) {
 		pd->dlf_size = fls(reg);
-- 
2.39.2

