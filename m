Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2422978960F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjHZKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjHZKsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:48:00 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF6210B;
        Sat, 26 Aug 2023 03:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693046872;
        bh=5UEV9iQkXoRv1ZtDwjdYwDN72SNM+l48hXqNkJ9a9lw=;
        h=From:To:Cc:Subject:Date;
        b=hgUIcYrQJi305OII8XWsT0Mtsso55kouCowVCizAJNNM4/K1GZ3Q2zb6pGXsxnvUf
         NsvteS+38gnJxcNz6CW0jIUInRn3Mx/4QHJmxQ2FNGZ4y+1WSs+DylnIDRNsUOrLvo
         W68cD5JlCKZuOjwoyrOBTj9dX+AM5oKdIknUvrS8=
Received: from KernelDevBox.byted.org ([180.184.51.142])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id BF132ADC; Sat, 26 Aug 2023 18:47:49 +0800
X-QQ-mid: xmsmtpt1693046869t422jo22r
Message-ID: <tencent_C40B301A0F71853A540809BE1BB85AB12D07@qq.com>
X-QQ-XMAILINFO: Mwr+zmslTAZDF1p0d6eRUGiZ59hrZYPpqZdI+aofJC3xa7gNrgDFvNoI2CXweH
         LqQWjCffNamB5km6bQSGJ/Vm/I//whIpYjEYzsGmzYLW+KzN3AO5KqnY4KXsYN+eiBhrhAY0a2aJ
         K4LOH7PxJyDQAsu+IVJfXfTrGdsL78EsvKbJlfmK6pc2PN4ALuqXvp5wlCM0BUjFuVcaz0zQrBYv
         MnKBlbilXEWorLwi2XRB5CDHXAbP1o5lDs6z2a7E7MvMCPzXZb0gnAKno9ffUfU/a4mjqKnp9wwZ
         RjsPNpJiAAkTW2YaaLU8408ZAQ63+iG+WXKAWGqSPkeFW2ebTLwrVHUJjvUCZhvcvbvo2LKtTdkx
         mhvEiPfx17LfGFfX2NYG7O/clnK+AbfxDekFm4sb2Pm6rDnKA1N98yRSvcfuPbAefls1nj1ma8Bq
         MYbX1WYjBRCcvGKrp/6rjgvWVpt7yieLSHpTWTcift9//QyTItNFs0UVsg74/5lNlmQVZiy/r0Zu
         ZL/5g0tMChpDQlMa9qGMLghULtiRbvEw5RvqjSSwZ7d3agBvOtkawM/LsfNmIjEGIiOBfJgVaCAg
         GR7wunOmOIP7CCjCeidQS703GNJcW1fGBmjVBr9DgTGQxy0B78tTc8SWNmD1OVf8SktMU2nPLAwu
         5mtrIFpAePtR+VYzO7YCcs3Cq/0m6gOJTZVz/y43TaDk4+o0csHudz3Zln+ZHwTGqvEnDXF05lXj
         HKhXaVxgOw9a9DMlHGXMRflo8gEPJIG4a4k0eTuDvvSN6QRUZ0YY4F2ttj6Xfi8e9Tzt35wz/Jqp
         IrSPpUac6RwgCfarEzD5PBSGpmj+BGGAgUBvYpjcNYlmCAa+bEAJC42Ffb+dO2hjG37IlgpYEGV+
         PI1L/WrBx4L8CC8M2dwWpRzzRoxkzntwwmb0r+9UPAAZiqniRXfNGJYwv0jr6lyvTOr+t7HMEYyD
         zcTC070pCV2w53POzYLkVajk62BHSTB7MYgFlfgH6iAIcrJb+spEUOUQSHwTiCNrTvGkZZYqIbjt
         RyWkTHIQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     quic_schowdhu@quicinc.com
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] usb: misc: eud: Fix missing IRQ check in eud_probe()
Date:   Sat, 26 Aug 2023 18:47:47 +0800
X-OQ-MSGID: <20230826104747.2264114-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.

Fix this by stop calling request_irq() with invalid IRQ #s.

Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/usb/misc/qcom_eud.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index 7f371ea1248c..b33c615a2037 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -204,7 +204,12 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->mode_mgr))
 		return PTR_ERR(chip->mode_mgr);
 
-	chip->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	chip->irq = ret;
+
 	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
 			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
 	if (ret)
-- 
2.30.2

