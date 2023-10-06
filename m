Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C269C7BB55A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjJFKfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjJFKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:35:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE629F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:35:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5068692b0d9so532766e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696588506; x=1697193306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDKNYOcEsBFqMrb3wRrzCP0mxdH1YRbc05OaBLwf4hI=;
        b=AN/IO7vfm7fpq1brOHJrff7TAgMYZVkX6yZ7QrEeyYMgE8nmrtnPl7yp/jXeNrkot/
         AbYvdvSMYIyDX2kLQFdxhPV3KeEcUL/91gIvgvlcilO9dlkb3+S8XrDoYRXc2usQzw/v
         6SY6V+0bO5KNH3r1tEZEfR6yXSpLTSYqQ9TiHPin1RIJaX4eOZAu3Z4n59tUeOMINBEw
         r+18bWnVnvE17JXHqqBcNGxxZXS0jZq+XzulYDRMWJvzpSbKPkhakMbrDBPPWV1+gSzu
         WwWW9ylSmIoyXFK1G9npWUe6ets9ouPC92BYSxomp/54oX5ZeflAFaIN1m7zM3WJkqvE
         eNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588506; x=1697193306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDKNYOcEsBFqMrb3wRrzCP0mxdH1YRbc05OaBLwf4hI=;
        b=UX/Tnf0ntxgFaa4O58kGx/WQPDqzVK0CI76kZ4FYLdMyq7NJQaavb2Fm/fNYE+2omT
         qLLo1p2BmXug9ESNNSYruApKbKqWoWNs4Mq2Lz1fh+u99F7NCALPiWIjmwlZENzaMFf4
         X+ESBQ0rwpiZyB4w9Xucg2N9MTCMMfUxUbXMmzfD3vsO+W37cYDQKY0hH6vPJLsoZ39r
         +q7NBmVcWS+4wN9v2VOCj9tngbDD6dC7vklUzEb1RptxmCcp+pLufVkr21o82Es5IiPu
         RShKLtJIID6syoCL8oozkKysB94A+0Hvmr4xSUNBZe16EmLptcmWGXlLo8P79wJfrGAO
         UglA==
X-Gm-Message-State: AOJu0YyNTrVo+zDKJzk4itKw5Eo0yu3MgbNGc7NqaOvr9QazbcUchsWZ
        NfOwYA9e91bvjR1YwWW3gIWk+g==
X-Google-Smtp-Source: AGHT+IEd+1rkwzUT09GxzwWsq6l0mV4x0bcd9Nx7ouA0iriK2HD32CfqtgEjU0x0dQ08/XXlTE5nXw==
X-Received: by 2002:a05:6512:2095:b0:503:5d8:da33 with SMTP id t21-20020a056512209500b0050305d8da33mr6525614lfr.20.1696588505433;
        Fri, 06 Oct 2023 03:35:05 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8f44:72b3:5bcb:6c6b])
        by smtp.googlemail.com with ESMTPSA id l9-20020a1c7909000000b00401b242e2e6sm5664963wme.47.2023.10.06.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:35:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da.xue@libretech.co>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH v2 0/2] arm64: dts: amlogic: add libretech cottonwood support
Date:   Fri,  6 Oct 2023 12:34:58 +0200
Message-Id: <20231006103500.2015183-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Libretech cottonwood board family.
The 2 boards are based on the same PCB, with an RPi B form factor.

The "Alta" board uses an a311d while the "Solitude" variant uses an s905d3.

This patchset depends on the usb support for the gl3510 [1] and [6]
Without it, there will be dt check warnings and usb may not come up properly.

Early u-boot support may be found here [2]. It will be submitted after
DT is accepted in Linux. As usual with Amlogic, u-boot must be packaged
with closed source binaries ([3] for the a311d, [4] for the s905d3)

Prebuilt bootloaders are available from libretech [5].

The devices are shipped with libretech's u-boot pre-flashed in SPI NOR.
If necessary, the boot source may be changed to MMC using the onboard
switch.

Happy hacking ...

Changes since v1 [7]:
* Remove extra dvfs opps
* Rename Alsa cards
* Reorganize leds for DT schema while keeping meaningful node names
* Change blue LED trigger to heartbeat
* Set panic indicator on the orange LED
* Move hub reset from under the usb phy node to the controller one
* Drop npu node

[1]: https://lore.kernel.org/all/20231002122909.2338049-1-jbrunet@baylibre.com
[2]: https://gitlab.com/jbrunet/u-boot/-/tree/cottonwood
[3]: https://jbrunet.baylibre.com/pub/amlogic/fips/fip-collect-aml-a311d-cc-20230701.tar.gz
[4]: https://jbrunet.baylibre.com/pub/amlogic/fips/fip-collect-aml-s905d3-cc-20230820.tar.gz
[5]: https://boot.libre.computer/ci/
[6]: https://lore.kernel.org/all/20231006101028.1973730-1-jbrunet@baylibre.com
[7]: https://lore.kernel.org/all/20231002141020.2403652-1-jbrunet@baylibre.com

Jerome Brunet (2):
  dt-bindings: arm: amlogic: add libretech cottonwood support
  arm64: dts: amlogic: add libretech cottonwood support

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-g12b-a311d-libretech-cc.dts | 121 ++++
 .../amlogic/meson-libretech-cottonwood.dtsi   | 614 ++++++++++++++++++
 .../amlogic/meson-sm1-s905d3-libretech-cc.dts |  89 +++
 5 files changed, 828 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts

-- 
2.40.1

