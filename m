Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C231F7EB0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjKNNaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKNNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:30:11 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E151B5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:30:07 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c5249d55so8738351e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699968605; x=1700573405; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M20ZdrtdL4mxBFowxVPsPIZrP+Nk6G9G7Ln02uErXU0=;
        b=Iwa7FL6BDniv0iPHKBBHNj5+75pONPLefd1Nb0d0shFitp62KYE28S/+6vcaTN3t4/
         ukS1KrKm1sSVOTDC4Lul38tQsMHfmcu0NgKHh19C3UTti5iCH7n4voUklnsDkC2TPLdt
         w33y5e00c3fI9rpPKib0ECqt3CXhK3jMC6A4uVJsCFtvgTM72/+DNy3Aiz1EpEk5XYjE
         YMyAT1y6qcTY/l7gL9bsOgbK5JlXNdDWpwM7Ctb16tvEnbcLcJE0COlhhWYN+Ye3slmQ
         0K4nKyB40dnRKxMOpGEhfcp+HR/8MfbPkByQ6lzI58EDum6pu1EklGQKha911nt+zwaE
         8AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699968605; x=1700573405;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M20ZdrtdL4mxBFowxVPsPIZrP+Nk6G9G7Ln02uErXU0=;
        b=AmD0DG27BdvEP/sJ7QAy2eDsnJsIxLqN19BmLqDTcBEejzSTn2RmJ5Xg39pDgyz8OW
         TNn6eMbsiC15u9Y61ANwC90Uz3RS7TKvCkeJrhWLWxPZw0CNhuNz72pNKZ9CObpiVDxj
         NbNS5bT4V3cZ6YM1/QrdLnuF4fn7AgqQR+gFuY0w6w+iTvREwHSHrKJFZueYmEQyRsD2
         6rYW8/p8SQ7SasRenGwC3ZSpfPKRoUxXr1dXpqS2T8TMDcg86eCjjjHAmKPkm5IL/Vc6
         xQmoI+K9l738Y2/2SRBdytb9xrROA2cbwp5dVVHNOkb4ZdZYV4uZf6KWiv3LGoJIimQq
         GCOw==
X-Gm-Message-State: AOJu0Yx4Ztjf8GeB1P9qjxGsL2tKEgUQadGSx4BvjVy7xdujv9fdda7J
        fckJQq9sXGAsQqrn3qPNeTZlNQ==
X-Google-Smtp-Source: AGHT+IGQZ5W8krMJo5A5oV2eHBatfpOu32KBHpFDNp9vB113dOCGQxUYSSQsgX/yfJAV0DzO9TffWA==
X-Received: by 2002:a05:6512:3d18:b0:500:92f1:c341 with SMTP id d24-20020a0565123d1800b0050092f1c341mr9226552lfv.54.1699968604692;
        Tue, 14 Nov 2023 05:30:04 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id t9-20020a056512068900b00507b1783b3csm1339714lfe.54.2023.11.14.05.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:30:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:30:04 +0100
Subject: [PATCH] pinctrl: cy8c95x0: Fix doc warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-cy8c95x0-doc-v1-1-31674103ad18@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFt2U2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQ0MT3eRKi2RL0woD3ZT8ZN0042QDi9REsxQzYwsloJaCotS0zAqwcdG
 xtbUA2CcB5V4AAAA=
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One member of struct cy8c95x0_pinctrl is missing kerneldoc,
which leads to warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311031342.r4To3GaD-lkp@intel.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 04285c930e94..4ccfa99ed93a 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -143,6 +143,7 @@ static const struct dmi_system_id cy8c95x0_dmi_acpi_irq_info[] = {
  * @pinctrl_desc:   pin controller description
  * @name:           Chip controller name
  * @tpin:           Total number of pins
+ * @gpio_reset:     GPIO line handler that can reset the IC
  */
 struct cy8c95x0_pinctrl {
 	struct regmap *regmap;

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231114-cy8c95x0-doc-f3c08ea6d638

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

