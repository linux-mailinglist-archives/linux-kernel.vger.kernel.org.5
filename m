Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEA7B1696
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjI1Iz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjI1Iz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:55:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8F6196
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:55:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690d2441b95so9709239b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695891353; x=1696496153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/sdOlcXE7ArUd8KEI+Ou653U6fYu+6M8SJReaicXQGI=;
        b=hc/I5BWNQBGAISJW5VBcpuzKorusaB96Qbb6pHNt9PkAS6u44nHS1OOAD7DLPZ9GfU
         rxxcPDuauTfq/XXivswAp0Xot6BBW2vDUE6sEdHIsYAnljL/iVsXdwwU01vpCXkuxZkg
         TiPmOclSqP5N/5YrSP8E38MdCJbflY6BZhsc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891353; x=1696496153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sdOlcXE7ArUd8KEI+Ou653U6fYu+6M8SJReaicXQGI=;
        b=CjfR3kiYiWWT+I2sUqn2pSbt7NVPQRMNSfB2otH2FSESq9iFyzBCanFFCXLIgXevzX
         joeg/vnwrv96KfJID0wkjJTmdZpBb1GvK+DPdxZdWkv18yEjYfhZM0aG1OjaIQI8bqKX
         URyPWOxPJlPGxGgCw+jl0RV8axniJ2vDhwVCe6pgfVaZYGPDBWjBGxJXk7Vo77leFEEE
         kHQe1VXr7b1YA/vDp0xos6zwqDiJy+722iUC8OoL8J1InHVJ9eraMrz0C5RTHRu/XddE
         8MqYK8BR/1dww1nbr/p3VnmIP1zk+LyxxBsrITNDkhfDnDDhEPta9zCxAEKNubFCXffH
         y9qQ==
X-Gm-Message-State: AOJu0Yx5CyHMBaJEABxw/E7zV/IgKJkaTtCdp6lbLRPil4fgQhKyCmFv
        MBnqJwnP5ohosy7zSzAqDyvjDQ==
X-Google-Smtp-Source: AGHT+IEI8T9mq3VV9UeQdxGlMaLRhG25/OW4vQBRwyKCoDxbtH0SF9mjkZjWAbJN/hzLXSZMgcnIKw==
X-Received: by 2002:a05:6a20:8416:b0:f0:50c4:4c43 with SMTP id c22-20020a056a20841600b000f050c44c43mr1154054pzd.5.1695891353387;
        Thu, 28 Sep 2023 01:55:53 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6747:c12a:dbfd:2cc7])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78047000000b006879493aca0sm1754016pfm.26.2023.09.28.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:55:53 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 00/12] regulator: mt6366: Split out of MT6358 and cleanup
Date:   Thu, 28 Sep 2023 16:55:23 +0800
Message-ID: <20230928085537.3246669-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v4 of my MT6366 PMIC split-out-of-MT6358 cleanup series. The two
PMICs are mostly identical, except for the regulator bits. The MT6366 is
missing the VCAM* (camera related) LDOs, but in their place has a few
other ones. This thus requires a separate compatible to handle the
binding differences. The hardware however does have a chip ID register
that can be used to differentiate the variants within the driver. Thus
a fallback compatible to the base (MT6358) model is included.

Changes since v3:
- Rebased onto next-20230928
- Patch 2
  - ldo_vxo22 and ldo_vusb moved to properties in the original binding
    conversion
- Patch 5
  - Expanded commit message to mention why a fallback compatible is used
  - Adapted to ldo_vxo22 and ldo_vusb movement to properties in previous
    patch                                                               
  - Split example into two, one for each variant                        
  - Renamed regulator node in examples to just "regulator"              

Changes since v2:
- Merged "mfd: mt6358: Add registers for MT6366 specific regulators"
  into "regulator: mt6358: Add missing regulators for MT6366", as
  suggested by Krzysztof.
- Reworked the bindings so that all the regulators are commonly defined,
  then filtered out by compatible, like every other binding does.
- Added some missing end-of-string matches to the LDO patterns
- Added patches to reuse the MT6397 regulator binding macros
  - regulator: dt-bindings: mt6358: Add regulator-allowed-modes property
  - regulator: mt6358: Use mt6397-regulator.h binding header for buck mode macros
- Dropped "regulator-coupled-with" and "regulator-coupled-max-spread"
  properties from the DT binding example. They don't make much sense
  without the coupled regulator.
- Fixed up selector values in pickable linear ranges

Changes since v1:
- Switched to using MT6358 compatible as fallback compatible
  Differences are detected through chip ID register
- MT6366 regulator binding merged with MT6358 one instead of having two
  separate ones
- Added patches
  - regulator: dt-bindings: mt6358: Convert to DT schema     
  - regulator: dt-bindings: mt6358: Add regulator supplies   
  - regulator: mt6358: Add supply names for MT6358 regulators
  - arm64: dts: mediatek: mt8183-kukui: Add PMIC regulator supplies
  These bring MT6358 regulators to the same completeness level as MT6366
- Dropped patch "mfd: mt6397: Split MediaTek MT6366 PMIC out of MT6358"
- Dropped patch "soc: mediatek: pwrap: add support for MT6366 PMIC"

This depends on my previous "regulator: mt6358: Remove bogus regulators
and improvements" series [1] and patch "regulator: mt6358: return error
for get/set mode op on linear range LDO" [2] patch. These are still in
flight, but I think posting this earlier would help get reviews underway.

Patch 1 add a compatible string for the MT6366 PMIC, with a fallback to
the MT6358 one. This should go through the MFD tree. There are no build
time dependencies.

Patch 2 converts the existing MT6358 regulator DT binding to DT schema.

Patch 3 adds the "regulator-allowed-mode" property to the MT6358
regulator binding.

Patch 4 adds regulator supply properties to the MT6358 regulator
binding.

Patch 5 adds MT6366 regulators to the MT6358 regulator binding. This was
previously done by Zhiyong Tao [3] from MediaTek as a separate binding
file. I cleaned up the patch based on previous review comments, simplified
the regulator names, and added regulator supplies. Bogus regulators were
also dropped, like what was done for the MT6358 [1]. In v2 this was
merged with the MT6358 binding, now converted to DT schema.

Patch 6 makes the MT6358 regulator driver use the mt6397-regulator.h
binding header for the operating mode macros.

Patch 7 adds support for the regulator supplies to the MT6358 regulator
driver.

Patch 8 simplifies the MT6366 regulator names to match the new names
specified in the binding.

Patch 9 makes the MT6366 VCN18 LDO regulator configurable. This is one
of the differences between the MT6358 and MT6366.

Patch 10 adds regulators that were missing from the originally proposed
binding and driver. This includes MFD header changes and needs an ack
from Lee.

Patch 11 adds regulator supply names to the MT6366 regulators

Patch 12 adds regulator supplies to MT8183 Kukui boards.

Patch 1 should go through the mfd tree. Patches 3 through 11 should go
through the regulator tree after Lee acks patch 10. Patch 12 should go
through the MediaTek tree.

[1] https://lore.kernel.org/linux-arm-kernel/20230913082919.1631287-1-wenst@chromium.org/
[2] https://lore.kernel.org/linux-arm-kernel/20230919083647.3909889-1-wenst@chromium.org/
[3] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/

Chen-Yu Tsai (11):
  dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366
    PMIC
  regulator: dt-bindings: mt6358: Convert to DT schema
  regulator: dt-bindings: mt6358: Add regulator-allowed-modes property
  regulator: dt-bindings: mt6358: Add regulator supplies
  regulator: mt6358: Use mt6397-regulator.h binding header for buck mode
    macros
  regulator: mt6358: Add supply names for MT6358 regulators
  regulator: mt6358: fix and drop type prefix in MT6366 regulator node
    names
  regulator: mt6358: Make MT6366 vcn18 LDO configurable
  regulator: mt6358: Add missing regulators for MT6366
  regulator: mt6358: Add supply names for MT6366 regulators
  arm64: dts: mediatek: mt8183-kukui: Add PMIC regulator supplies

Zhiyong Tao (1):
  regulator: dt-bindings: mt6358: Add MT6366 PMIC

 .../devicetree/bindings/mfd/mt6397.txt        |   4 +-
 .../regulator/mediatek,mt6358-regulator.yaml  | 250 +++++++++++++
 .../bindings/regulator/mt6358-regulator.txt   | 350 ------------------
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  28 ++
 drivers/regulator/mt6358-regulator.c          | 250 +++++++------
 include/linux/mfd/mt6358/registers.h          |  17 +
 include/linux/regulator/mt6358-regulator.h    |   3 +
 7 files changed, 443 insertions(+), 459 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt

-- 
2.42.0.582.g8ccd20d70d-goog

