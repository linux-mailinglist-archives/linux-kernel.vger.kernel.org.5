Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2258A7B4AB8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 04:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjJBCRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 22:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbjJBCRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:17:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9824D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 19:17:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27909dabf1cso1269507a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 19:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696213028; x=1696817828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6b76Ych1HnNWX1i2+SMCurFq8JmPkRVbgEKvHul6Y6M=;
        b=HOzAakugpT5jH49+zsnPAoGSrzC4RQyW/9VDM64hsVYCKqErk5vj91prWqv4SNRaKJ
         5+FTn+BahMoYmBzhLezqiIKWLSb7H/caYdDYpoOv1CMyO5OXnc9iVuKmoQA0IGjtm2GT
         iXvc6meL4x0AxeRFVNWsmyfEvp99k/T8QCA9wilnwLQ6LgoI7RWSQ1/Q6/l1orzeZVV9
         SeQxYOnwFlOF37n3nG65k8ZZY6pnCVFWfpBfGjpeI/nPkILxYQDHjuhW8WmAvX/65mAu
         5JuSP3JWhWahRncrRMmbxi2100BIvGWYRep7oGmMrPSKJhPPjWiAl6sYi3RiaEv73ajE
         h9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696213028; x=1696817828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6b76Ych1HnNWX1i2+SMCurFq8JmPkRVbgEKvHul6Y6M=;
        b=AGckwHtAnXc6s0ra47UwyyQgbtFenNCVDicoMixwKa1woQNz2MMdVGyZ7P2LDWQqCC
         gRYfFEj5DjhzCN6YKg7eY2DKtQToAZi8uKfOJ04r+GdX0gB7rxn13JhL3ZvBniQFXjpA
         jHGP8wF00BCf74Mr03ciqlSJRh2EVYGZgcGM4B5Tbic+B7wl2x7XM+g8WxxwEaImtW7r
         S1CMrw2cv4vnlMHMlQLirlxVDqfaltmQmMC1yydD1I3ahgLyKC2RQk69zfYRxcyNZrLc
         VNzKlRU4YveuPOcIUYaVS+hQ8+t73zYb9xNnqSJaxqlo9imRrwfNEf/43OtFsHQ98csD
         1Hqg==
X-Gm-Message-State: AOJu0YwX7uDSchXk8vRsFrhjSyqx58zih0x8e+fc9EGCcm10JMxEX5at
        BbmYb1IfCIXl0PY7VUDfiijUiA==
X-Google-Smtp-Source: AGHT+IG7F7GjhJnFomtH628B6eLxLuj4n7S9f0mGkASawyhxSQzyDo06i0YtDgv7Hzddo0DyTk9qvw==
X-Received: by 2002:a17:90a:242:b0:263:730b:f568 with SMTP id t2-20020a17090a024200b00263730bf568mr9141074pje.3.1696213028338;
        Sun, 01 Oct 2023 19:17:08 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:7ab1:199:d138:f054])
        by smtp.gmail.com with ESMTPSA id mg11-20020a17090b370b00b002609cadc56esm5278319pjb.11.2023.10.01.19.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:17:08 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 0/4] gpio: add SCMI pinctrl based driver
Date:   Mon,  2 Oct 2023 11:15:58 +0900
Message-Id: <20231002021602.260100-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently working on implementing SCMI pinctrl/gpio drivers
on U-Boot[1]. Although the pinctrl driver for the kernel[2] was submitted
by EPAM, it doesn't contain the gpio driver and I believe that we should
discuss a couple of points on the kernel side to finalize my design for
U-Boot. 

So this RFC is intended for reviews, especially to raise some issues.
(Please note that I have *never* tested the code because I don't have
any real hardware to test SCMI on it.)

1) how to obtain a value on an input pin
   All the existing gpio drivers are set to obtain a value on an input
   pin by accessing the hardware directly. In SCMI case, however, this is
   just impossible in its nature and must be supported via a protocol
   using "Input-value" configuration type. (See the spec[3], table-23.)

   The current pinconf framework is missing the feature (the pinconf
   parameter and a helper function). See patch#1 and #2.

   Please note that there is an issue around the pin configuration in
   EPAM's current pinctrl driver as I commented[4].

2) DT bindings
   I would like to propose a generic binding for SCMI pinctrl based
   gpio driver. This allows a "consumer" driver to handle gpio input pins
   like as other normal gpio controllers provide. (patch#4)

3) generic GPIO driver
   Based on (2), I tried to prototype a generic driver in patch#3.
   As you can see, there is no SCMI-specific line of code as a set of
   existing helper functions, except (1), seem to be enough to implement
   required interfaces.
   So I'm not sure whether the driver should has a "compatibles" property
   of "arm,scmi-gpio-generic".

I will appreciate any comments.

-Takahiro Akashi

[1] https://lists.denx.de/pipermail/u-boot/2023-September/529765.html
[2] https://lkml.iu.edu/hypermail/linux/kernel/2308.1/01082.html
[3] https://developer.arm.com/documentation/den0056/
[4] https://lkml.iu.edu/hypermail/linux/kernel/2308.2/07483.html

AKASHI Takahiro (4):
  pinctrl: define PIN_CONFIG_INPUT
  pinctrl: add pinctrl_gpio_get_config()
  gpio: scmi: add SCMI pinctrl based gpio driver
  dt-bindings: gpio: Add bindings for SCMI pinctrl based gpio

 .../bindings/gpio/arm,scmi-gpio.yaml          |  71 ++++++++
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-scmi.c                      | 154 ++++++++++++++++++
 drivers/pinctrl/core.c                        |  19 +++
 include/linux/pinctrl/consumer.h              |   8 +
 include/linux/pinctrl/pinconf-generic.h       |   3 +
 7 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
 create mode 100644 drivers/gpio/gpio-scmi.c

-- 
2.34.1

