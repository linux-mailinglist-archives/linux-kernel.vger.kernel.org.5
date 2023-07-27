Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95CA76583D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjG0QGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjG0QGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:06:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE54110;
        Thu, 27 Jul 2023 09:06:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so1994110e87.2;
        Thu, 27 Jul 2023 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690473973; x=1691078773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ghQ9oJMe79WnJT3o+FUEMqmGRHeXyn/vOaNIARdZMlo=;
        b=EOqkESrPKZDi2asIGomeoS/PVI+Cy/lYXLKVovdy3GHfINcwdwn71gDzA8UoVVw6Na
         mAfub10O2W4J3jc2BEhv5n+VGRpT2HLGnpOgMJcARUaf5Z9QUnULMsNWcBPfHQBotdUb
         R5AbAzgfrYVozRho2FNgjvjBMuXGRLx2x22QkCqwlaHsIad9B/54RbZMFDu2qo4r2lpz
         Ny1/jPCUE8xzr++66MCTfh4TkJOsUH5zUVbbg4I9YqX9izrnMUNaiFuAPvFQLVKEIXig
         RGICu2bGSkJyhEzaxWweyhydyY5osp1gNgCnIQI/eT3wvhr4VhC7xKb/85QFPggIKhA1
         5LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473973; x=1691078773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghQ9oJMe79WnJT3o+FUEMqmGRHeXyn/vOaNIARdZMlo=;
        b=HGTaUSu5Pcpu26vc/ZXQCGeossbNIs5G1eylX/AmUSt9Dc5xnilFVUVSv3s70SueAu
         H2axrOr9d7ytuDuXWeauLwePZbOq7J6Tdsa6OKx5XLtd1bLJF0+QIb4joEUkFdMLEzAL
         iA/DE7vbwBWt8ehqVmGpiV5wJeoYri5/0sQYmAzsRB38JMW3FKi2rCiSSmfSTNVKmmKU
         AGgEoRCQz8MOlBYTZx5CTEt2PiVtuvJCqiO1EiVe97vU+avh+LaPn+I1NovpdLO7I8e4
         S7r/lUF6HVn26DPJI0GFSP1bAnVPULRbSOvFNTzdjknlS1Cb/N3p47JyZrRfbxL0ZCKZ
         RJcw==
X-Gm-Message-State: ABy/qLbAVZ5MREset+6QG6hASSXh0gKz4N6Wmp36S1wTBcLDgpmL59CN
        4M4RTjuwk8LdxXqkrcPVFdKjSsWJyLvkmA==
X-Google-Smtp-Source: APBJJlEDau/OEQAlt2Uep+ZFJvOvk3bQOsegjqUV0hCFuyNJUHWOXdPZczeu+7v+frotSsRQ4gBV4g==
X-Received: by 2002:a05:6512:2107:b0:4f9:5d2a:e0f5 with SMTP id q7-20020a056512210700b004f95d2ae0f5mr2048763lfr.19.1690473972727;
        Thu, 27 Jul 2023 09:06:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe78:868])
        by smtp.gmail.com with ESMTPSA id ck8-20020a170906c44800b00982be08a9besm936540ejb.172.2023.07.27.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:06:12 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matus Gajdos <matuszpd@gmail.com>
Subject: [PATCH 0/3] leds: Add Broadchip BCT3024 LED driver
Date:   Thu, 27 Jul 2023 18:05:22 +0200
Message-Id: <20230727160525.23312-1-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sending a series of patches to add support for the Broadchip BCT3024
LED driver. The first adds Broadchip to the DT vendor prefixes, the
second is the DT bindings documentation and the third is the driver
itself.

The Broadchip BCT3024 is an I2C LED driver with 24 independent channels,
each with 256 brightness levels. It is targeted mainly for mobile phones
and other hand-held devices.

As we use the chip in a device that needs to keep its power consumption
to a minimum, I added support for the runtime PM to let the kernel
disable the chip and its power supply when brightness is set to zero.

Any comments are welcome.

Matus Gajdos (3):
  dt-bindings: Add vendor prefix for Broadchip Technology Group Co.,
    Ltd.
  dt-bindings: leds: Add binding for Broadchip BCT3024 LED driver
  leds: Add Broadchip BCT3024 LED driver

 .../bindings/leds/broadchip,bct3024.yaml      |  89 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-bct3024.c                   | 564 ++++++++++++++++++
 5 files changed, 665 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml
 create mode 100644 drivers/leds/leds-bct3024.c

-- 
2.25.1

