Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840D277C9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjHOJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjHOJDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:03:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5251BC9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:02:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686b9964ae2so3309814b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692090142; x=1692694942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw0ARtvgnK9eBWm0hqqYBsE7PAKIFaPy/RiSwt2xSqk=;
        b=f7XXEf7tFaWgEoGIQtBEemyNQGodu1G427wygI3OnQe/2du59CwHn5caGSfDXLH5iC
         cOEeZqkzJgMyDQQvYaFa8KZ3I5vCZOLMchV9M76pkwkIS5tci1t/N+pztDtHMR9tKZuF
         vrjlz5LjysXbQ0sQ2eW0X4KB2n2kjfPq3Q1TscC02Z8dTZ5T2zTMIxAHrI8nvgwDUHep
         KmoajzSlvnhDZOUaR+/s0fV8URtBwioisXFXE/cv6aRU2ADulIAFmSMANQbL6MYjqqw1
         WKS81hferpTBRkLKUU+UwbonndqOhD1DWXJ59ZxnCXdDgz8bWv8coW/UjU3Io6xaRs3H
         cj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090142; x=1692694942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw0ARtvgnK9eBWm0hqqYBsE7PAKIFaPy/RiSwt2xSqk=;
        b=TQ4mLchNgA4kVqgcX/8sOLwRk13xG/0R+xN3d0KJaMJOTvG/rW5Ao0U1TYCwtYNBx/
         biiJUjTn61TWpyCQ/ueYRaUDFC63iFsYHD0uFY2LmKE0tImHQCRhn4mjz5p3eD30pJSk
         vsj//yFPNvfpULGqt5fmSJB5J9XYChQYmh0TVmmyIdgD3skQKBPwSRWziAVypxvJlMG2
         hmyAf+4aNWWb1HfsDKxlFymJ7VJ/+RhsRycLPX9oES08xveckLH1Jp0CiZlYsPH1XhT9
         Wd7327w+nTDUgqVsFSWejx5HXWtCFW+yB3rTWXGG9AzgkWFCVvmmjt2vu9l2tv4WggtX
         8CVw==
X-Gm-Message-State: AOJu0YyUAPk6Vo44oczQF6HEN5IQjDyv4vYgjGoJx0+OmUB/M7wvRvJq
        cZdxxgAOx84cOAxbVEUmcaeQNQ==
X-Google-Smtp-Source: AGHT+IENe0tU9RHLk0BkjpQbNw1pxKpJ2/NeGr23TOm4HJozI30zEOhEU5UnWi95cBI6wsaH1tmURg==
X-Received: by 2002:a05:6a00:130d:b0:687:5434:bd14 with SMTP id j13-20020a056a00130d00b006875434bd14mr9078461pfu.11.1692090141951;
        Tue, 15 Aug 2023 02:02:21 -0700 (PDT)
Received: from work.. (1-161-171-111.dynamic-ip.hinet.net. [1.161.171.111])
        by smtp.gmail.com with ESMTPSA id c22-20020aa78c16000000b006826c9e4397sm1264700pfd.48.2023.08.15.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 02:02:21 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     nick.hu@sifive.com, zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v3] serial: sifive: Add suspend and resume operations
Date:   Tue, 15 Aug 2023 17:02:16 +0800
Message-Id: <20230815090216.2575971-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the Sifive Uart is not used as the wake up source, suspend the uart
before the system enter the suspend state to prevent it woken up by
unexpected uart interrupt. Resume the uart once the system woken up.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
---

Changes in v3:
- Fix the conflicts on tty-next branch of tty.git

Changes in v2:
- Change Signed-off-by: Ben Dooks to Reviewed-by: Ben Dooks
- Remove the unnecessary check

 drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index e2efc3f84eff..d195c5de52e7 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -1019,6 +1019,23 @@ static int sifive_serial_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sifive_serial_suspend(struct device *dev)
+{
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	return uart_suspend_port(&sifive_serial_uart_driver, &ssp->port);
+}
+
+static int sifive_serial_resume(struct device *dev)
+{
+	struct sifive_serial_port *ssp = dev_get_drvdata(dev);
+
+	return uart_resume_port(&sifive_serial_uart_driver, &ssp->port);
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
+			 sifive_serial_resume);
+
 static const struct of_device_id sifive_serial_of_match[] = {
 	{ .compatible = "sifive,fu540-c000-uart0" },
 	{ .compatible = "sifive,uart0" },
@@ -1031,6 +1048,7 @@ static struct platform_driver sifive_serial_platform_driver = {
 	.remove		= sifive_serial_remove,
 	.driver		= {
 		.name	= SIFIVE_SERIAL_NAME,
+		.pm = pm_sleep_ptr(&sifive_uart_pm_ops),
 		.of_match_table = sifive_serial_of_match,
 	},
 };
-- 
2.34.1

