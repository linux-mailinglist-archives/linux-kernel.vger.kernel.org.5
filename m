Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF177B3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjHNIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjHNIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:16:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A19106
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:16:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so36418975e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001005; x=1692605805;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1P+7jhSSNcltObBqcyP3huFreuMp7RiZ1kKqWA9BdTU=;
        b=QNHpiT7CaXxRuYW7wplRo1hM0BIwfS/5U3VNJMClXwpDK49QfOCqp11ER/vTMWkJqP
         tVGRpr+vxyYS0/3BfhIE43SYUv2gyH/LYjRu+FsuLccS7otPdjMNrZj+EsKIif8a3MWE
         3c1hRee5MeSgQ/gOpGq7YwUXOGBfG4PETsB0ER9zOifFMX6XUEF/a+FZB+GK3A8T11lI
         l8Npq5fgiX700a9rtgke8nbGM8DpSQd6ffAgWRAum0JD6rJdUgMHmwj8fnA0QAh4HlSl
         SiQnr8rsCg+vQ4jwwbq5CHIEJpcBSIOWI3HJNnW1e6t3Kn1gdWsUIhZK441Pj8ZSyloQ
         D67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001005; x=1692605805;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1P+7jhSSNcltObBqcyP3huFreuMp7RiZ1kKqWA9BdTU=;
        b=EGLpFp1Zfv3Q7zODC8DWcp3cPl1r+UdtgmvSL31AfArZVSNQumiU3hY5KkM+vs7I45
         r+UDJknA2kyusQyvaBj6flIkF+Hc2GMHpvoDX8IBYSer99AmkYyYfR8kNirPjw2TjOQh
         t3n6OQbNfC+/l3+rXvRlzpMHbcCV9cmSI2SesmzTuH6rA6n47LKxaSGfGbxsLiEBhOOo
         J+NIn9usVQW5BXYxHCAqp7D+4xNHMk9GxvXF2ie6niPRbFH+WGfikOv1P9a2qgBgsKhT
         2FDF7WyqoOd6a4E9MnvZzXH0uApeiogK2IVT9/czX23bZpWXqoFT1IfxKKZMDSJkxRUW
         BMdg==
X-Gm-Message-State: AOJu0Yx+357M4O4MIfSTFVmxOJhyXFQ0s6m9TAWVvlU8rEvttE7fE0QT
        IB5twgK33qebQPi1HaGpkYFgKQ==
X-Google-Smtp-Source: AGHT+IHtsrQFTxvyDoKJq0zJhTadqcM+XG7I+k33MHdMnKAw7Jjir0xPCJuUc09N6AgAGh0jgp8xRQ==
X-Received: by 2002:a5d:4448:0:b0:317:f537:748d with SMTP id x8-20020a5d4448000000b00317f537748dmr5220459wrr.64.1692001005329;
        Mon, 14 Aug 2023 01:16:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d4281000000b00317a29af4b2sm13542994wrq.68.2023.08.14.01.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:16:44 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] pinctrl: oxnas support removal
Date:   Mon, 14 Aug 2023 10:16:36 +0200
Message-Id: <20230814-topic-oxnas-upstream-remove-v3-0-04a0c5cdda52@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTi2WQC/43OwQ7CIBAE0F8xnF1TIFbryf8wHpayWJIWmqUSj
 em/S3sxXozHmcObeYlE7CmJ0+YlmLJPPoYS9HYj2g7DjcDbkoWqlK60ljDF0bcQHwET3Mc0MeE
 ATEPMBFgramxTOyISRTCYCAxjaLtihHvfl3Jkcv6xTl6uJXc+TZGf64Msl/a/sSyhgr2x+6Oz0
 lrpzr0PyHEX+SYWOKsPVuvqN6YK5kyNRlvC46H9wuZ5fgMPKRwuKQEAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=svL6aI+Ivh8BepAtDKpiDrwHSHdF9+dU0wkSJh9amZ0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk2eLqbnzULI5saow0fVSkLtRpOAARsRIwaipWDhVx
 lsLLaj6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNni6gAKCRB33NvayMhJ0cmvEA
 CvB0XkWPo2+wZVpZSUMFe6ciE43WkhMmHVwX30myPEwI4x0DUu81GxN1KDeMCIIf6gvbSNQhf4jhux
 Pa5rErjAnLfNSMU2x8B/RJ/ENNjzU8RALcgV5Pl915uoCHTOwxw3JqDhQ6SYtA2rGcQpCCoyHVrghj
 JRvWtnJbE5gSRtA2nnFyiUyTVQZnLl2BdBkxXVTW8cvgi/oXnVxbKvVdJSelWpMfSbwkwBde+3PBvm
 DadHl6Z35P/rZzQhPwMQmQg4u8mxvRpQKfvpdkdOq7L40qJZq8zQXp3S93+POeFcSgkRy/E6kZecU5
 plgKiyRUXDl/PgGSzECnCAAVqXJfPD4elh9ukb0YgdKRdLo0KVWUZoBXh5/mmBmQp7x3upVF9RJeg+
 NobaW8Z5h1OLSi2NpYMatz/qAtm551wWVTWn0YEncwE7dC2v6F3MzL19mbxxoj6vFdwYwmnbNXDDaW
 4VbxNV2r6utPtXxaB7FWngH5ugU1hn3ufZbojuKukVVepzsFmcIJmJqWc2Xsw2IrYEIvi8YRSF2Dwd
 Hedc0ksfNGBKzoOt5SOr+H2ckOYss+L8j09/iZmtLBQICJcsLH5bwrswVKmRno59Pq/vaR/6wxWb5g
 5yhQWrzswT9b4eb3zaomgEryjl0Tbrme0H4Mgmim+a5NKx+OKQRbCgL63iwg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With [1] removing MPCore SMP support, this makes the OX820 barely usable,
associated with a clear lack of maintainance, development and migration to
dt-schema it's clear that Linux support for OX810 and OX820 should be removed.

In addition, the OX810 hasn't been booted for years and isn't even present
in an ARM config file.

For the OX820, lack of USB and SATA support makes the platform not usable
in the current Linux support and relies on off-tree drivers hacked from the
vendor (defunct for years) sources.

The last users are in the OpenWRT distribution, and today's removal means
support will still be in stable 6.1 LTS kernel until end of 2026.

If someone wants to take over the development even with lack of SMP, I'll
be happy to hand off maintainance.

It has been a fun time adding support for this architecture, but it's time
to get over!

This patchset only removes pinctrl/gpio code, and is derived from:
https://lore.kernel.org/r/20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org

---
Changes in v3:
- Removed applied patches
- Added Andy's tags
- Reduced for pinctrl, rebased on pinctrl devel branch
- Link to v2: https://lore.kernel.org/r/20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org

Changes in v2:
- s/maintainance/maintenance/
- added acked/review tags
- dropped already applied patches
- drop RFC
- Link to v1: https://lore.kernel.org/r/20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org

---
Neil Armstrong (3):
      pinctrl: pinctrl-oxnas: remove obsolete pinctrl driver
      dt-bindings: pinctrl: oxnas,pinctrl: remove obsolete bindings
      dt-bindings: gpio: gpio_oxnas: remove obsolete bindings

 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   47 -
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |   56 -
 drivers/pinctrl/Kconfig                            |   11 -
 drivers/pinctrl/Makefile                           |    1 -
 drivers/pinctrl/pinctrl-oxnas.c                    | 1291 --------------------
 5 files changed, 1406 deletions(-)
---
base-commit: c9b2572f488c3ed3974a0ff6885bb059b1751c86
change-id: 20230331-topic-oxnas-upstream-remove-a62e9d96feee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

