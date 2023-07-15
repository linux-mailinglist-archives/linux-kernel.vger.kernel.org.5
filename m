Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC647547AC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGOJSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOJSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:18:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6902C35B7;
        Sat, 15 Jul 2023 02:18:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so42149921fa.1;
        Sat, 15 Jul 2023 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412709; x=1692004709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68KK9nMb/YMaoape6Ajka+6g2rtnhepcU3LV7qa+nM8=;
        b=bfn57QW6XodUliCuFKdi9Wt3QhFAThlbWatDzeTGyjXfTyWb6U3wEBLqkjU8ocesc+
         Ru6FipAGz7YCj7l8Mv7hMa0gA5IZ36ieYug0HyIwuuOtlCAVdZyl6vwqkNGDMq33JqOc
         AypdOp+/6MKch8NmyGnbHNSEQEmch7tov55O01gCCuQDNyuhZ4ufyME2gSg+Rblo+uWL
         oMNH0P/xS+JVu2tHBkEjsUw2+d6lMcrim55vfTaUo7kQIDdVBCFIG8+KxmBYPG6hepGE
         YLzLLyjMT4qz0zLSlDbApejjyWvIdYjO4d1pj149ohceqVJYbAXYRgUiYUT0yBtpjIld
         ZHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412709; x=1692004709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68KK9nMb/YMaoape6Ajka+6g2rtnhepcU3LV7qa+nM8=;
        b=kJIWylUl2DdKKwcTfCDQBk4XyPxW9k4DYiabnmIxf2pjJ/SN6VZkGA9RyI0Zq6pBB1
         SC9Fsr5RqmHk6DhVSjjIyW3xX0QY4fG7lWcXS2EcyrZfdwjv+8MI++kZem+wvBUI6Y8e
         R2iEAJzpnyhMnLaOCx9dkTF7Bb6TICP9byH9hlY3CpIwiUna/SwTtSMtTgu5YYTItueZ
         SxOOftRoigI72zMJOUf82aSkYwN5EvHr6TX8paFINqSYN89E4NYpeHKvhS+NlHO7McYr
         9LDOzVVMuAzQZWJyKkPgxDozyJK3XmlPBJs6FZOAFfLfrjtah33qGqZCSxxeaZouvWjI
         bPHg==
X-Gm-Message-State: ABy/qLa78bNg+3TPwt4kh4V253e0IXbkodcrnNdhL/p1qNUCyILBz3VZ
        EQBc7iteUsLyEIZhThI34/JRG0uHcWVLLg==
X-Google-Smtp-Source: APBJJlFGNRjxeR4VqbwtcC7QCL/trfcaEw9mhlBfy0pd8SJcEXD8F41MebiZaa0xN5qVjoHQABdRoA==
X-Received: by 2002:a05:651c:157:b0:2b5:9f54:e290 with SMTP id c23-20020a05651c015700b002b59f54e290mr5276895ljd.0.1689412709072;
        Sat, 15 Jul 2023 02:18:29 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id b17-20020a2e9891000000b002b840f283a7sm561784ljj.36.2023.07.15.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:18:28 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v9 0/4] Add support for Allwinner GPADC on D1/T113s/R329/T507 SoCs
Date:   Sat, 15 Jul 2023 12:18:12 +0300
Message-Id: <20230715091816.3074375-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for general purpose ADC (GPADC) on new
Allwinner's SoCs, such as D1, T113s, T507 and R329. The implemented driver
provides basic functionality for getting ADC channels data.

Change History:
v9:
- Dropped fixes tag
- Reworded commits to remove 'This patch'

v8:
- Added patch that changes Kconfig description for previous Allwinner GPADC
- Changed Kconfig description for this GPADC driver
- Fixed 'reg' range for gpadc node in 'sunxi-d1s-t113.dtsi'

v7:
- Fixed typo in DT bindings property

v6:
- Fixed DT bindings regexp for channel properties
- Dropped checking the max number of channels from the drivers code
  (This is redundant as we raly on DT bindings check)

v5:
- Fixed DT bindings properties for child nodes

v4:
- Fixed DT bindings warnings
- Used GENMASK to clear the irq register
- Minor formatting fixes

v3:
- Added DT bindings dual license, fixed property order and example formatting
- Added explanations comments for timeout and mutex
- Dropped unnecessary regmap and used readl/writel instead
- Added error message about getting channel number
- Renamed labels and variables to make them self-explanatory

v2:
- Added lastch flag to avoid addition work for already selected channel
- Added reset assertion on module remove
- Added dynamic channel allocation and dropped iio_chan_spec arrays
- Changed IIO_CHAN_INFO_SCALE type to FRACTIONAL_LOG2
- Dropped separate compatible strings and configs for T113s and R329
- Fixed includes
- Fixed Kconfig description
- Removed duplicate probe error messages
- Used FIELD_PREP for bit setup

v1:
- Initial version

Maksim Kiselev (4):
  iio: adc: Kconfig change description for Allwinner GPADC
  iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
  dt-bindings: iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
  riscv: dts: allwinner: d1: Add GPADC node

 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    |  91 ++++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  10 +
 drivers/iio/adc/Kconfig                       |  12 +-
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/sun20i-gpadc-iio.c            | 276 ++++++++++++++++++
 5 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
 create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c

-- 
2.39.2

