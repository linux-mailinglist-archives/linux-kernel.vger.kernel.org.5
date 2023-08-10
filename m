Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE52777B60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjHJOze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjHJOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:55:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C72A8;
        Thu, 10 Aug 2023 07:55:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe463420fbso1481487e87.3;
        Thu, 10 Aug 2023 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691679330; x=1692284130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2564u1RCwp6T70h9ImuxER+KFtiLslRkuYUu2639brw=;
        b=rlgexnSBpRWcYGERk1ufOXcDU9xu+ARb+//tL549YX2UPuhsJBZI3Hod6koOcClTTT
         RWirBWharsZNGFKMhKI7SMHLkXLx8n1BROJxo41jqmjKNZP23vPDUtWNcentLk55PlKD
         8FVugWGPicg8n6pQq3u4c3I7TBhVLYN9ZGDLptK6EW0dBsxNawIBbLS7WM+no2IqkXAk
         EBaX7RDuM0F9mPw0xOG4AG5kdGweAy9m/1NqnBtGWVoOOhmM1O6Rxhr6AniRgOzWyxMz
         1PavFZGnmAmi1qRtlfupsWZh7RaOJ0w8U4PFPvnKxC3Jiw8+QBxpRq9q9jPhmwCa2FI5
         yduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691679330; x=1692284130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2564u1RCwp6T70h9ImuxER+KFtiLslRkuYUu2639brw=;
        b=TxMGgJld4ChUyGBSdjyxca/ZbJGHyhN+tNavUrKzBLT/+vqz/v5jdARuv7CndHAAxV
         X/mfSe09Zff3qPWnVAfEuyQ6gZCF4XjMvefmb9Q0Rn/e+VbdZQbP9egsW308rqEFaj6q
         wI2yGVyefOYPUkSn76skPTX9etsqmQJ+wz2kGzbr6/uYA2PckUyC1H6VQF1J6PYZKXBV
         dNvqcZf8xWvvY+Veqxp/qm5uQXvqOGiAGRa1BdELwQ7wv7OQSH3iFcDZwuoCwofiUcN2
         taocFl23WN/NFphoCxQIdwbOM9O+LqM5+QF8BXgZV8QRjMjr79TvF4nztAb0HVpnFeLN
         vRQg==
X-Gm-Message-State: AOJu0Yx0SipdjXxlDXvtFtB2wnbDNtaLXpDp8nNneHfZc/4HntJKPWOQ
        GAU0RvVETAQDVl801/+SyPlpOorW0R0rQAw=
X-Google-Smtp-Source: AGHT+IGYJ3DnAbqcyDEcR2VWIyf3tdxbEXLnLUz4wdNvOR2aNwCwCaAWXGcie5uSYp6/E/zfOc+ujA==
X-Received: by 2002:a05:6512:3453:b0:4f8:d385:41bd with SMTP id j19-20020a056512345300b004f8d38541bdmr1941957lfr.8.1691679329350;
        Thu, 10 Aug 2023 07:55:29 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id p12-20020ac246cc000000b004fe0de39fddsm308496lfo.290.2023.08.10.07.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:55:28 -0700 (PDT)
From:   Aleksandr Shubin <privatesub2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aleksandr Shubin <privatesub2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date:   Thu, 10 Aug 2023 17:54:25 +0300
Message-Id: <20230810145443.1053387-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for PWM controller on new
Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
provides basic functionality for control PWM channels.

v2:
 - fix dt-bindings
 - fix a remark in the driver

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

v4:
 - fix a remark in the driver

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  86 +++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  11 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 323 ++++++++++++++++++
 5 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1

