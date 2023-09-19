Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC07A5FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjISKrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjISKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:47:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671A132
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:47:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c44c7dbaf9so29529465ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695120443; x=1695725243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KWGm7rEFBvHLc7sisUwhAvmPpqKlBaLPdqOGIMWnd7E=;
        b=GPuzohc9sFRM0MUxJUoItB0ckY/DcakzLlLj+CC9tzDL25jshfTEGEJcFKR5KogljP
         RovGyY5un9eRd5itglcshCFnZXVWSeF+67yfM2SVhK1yHZJV0DXZyR1R3Kn/huHsEEZ1
         Fq8hiK3tUzOTxGYCp8FMntoUhNxiWhRrCULGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120443; x=1695725243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWGm7rEFBvHLc7sisUwhAvmPpqKlBaLPdqOGIMWnd7E=;
        b=mP5ZJ5NoAk+4LrBBb0zk+I804x+t7aSBzpZXeQb3FCb0vtGQcXbNz1bPgvOHqCa/P8
         jQ7pua13NVmpi0FXI5fTdNBfkZMFsvCsWZ5BrwoiP3v54dKHuDwdD0i0vGM9tFNDCH0h
         CNfwZ//qpJBVRMrFBS8jqooeb4rHxZ1SkZBTDJrI6pFWE4NRS53+ReN628tH3Li6hsl4
         LrNAivdBpc0467mln5MQSAvWHe2y6TwJBh0FQDC9BgTUCTxfAoBfi5XlbdPl4uaXtezg
         6HvUEDCk17KtARVvBOjIg8D0vz4IQAfUyGSIFvb3jhpXN1bN9kbkBBqLlMWrksogMGjn
         RRGA==
X-Gm-Message-State: AOJu0YwqDcoxJ1ZmV8BWtjN4X0i1NrY79lcCOnk0N6/Ioi94Q9n11fD3
        +pbTOVGsa+Z4wkLdJwDMd4Ne5A==
X-Google-Smtp-Source: AGHT+IGi1Aeqtw4GFcstj89ewGDN7GqUr/PGJ3DhkAfwr8aE99yDTv1Dd8EIte2UBmPkwW10M7f49g==
X-Received: by 2002:a17:903:1103:b0:1b9:e241:ad26 with SMTP id n3-20020a170903110300b001b9e241ad26mr14863164plh.9.1695120443688;
        Tue, 19 Sep 2023 03:47:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:40a:900d:e731:5a43])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001bc445e249asm6719578plg.124.2023.09.19.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 03:47:23 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/12] regulator: mt6366: Split out of MT6358 and cleanup
Date:   Tue, 19 Sep 2023 18:43:43 +0800
Message-ID: <20230919104357.3971512-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v3 of my MT6366 PMIC split-out-of-MT6358 cleanup series. The two
PMICs are mostly identical, except for the regulator bits. The MT6366 is
missing the VCAM* (camera related) LDOs, but in their place has a few
other ones. This thus requires a separate compatible to handle the
differences.

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
 .../regulator/mediatek,mt6358-regulator.yaml  | 247 ++++++++++++
 .../bindings/regulator/mt6358-regulator.txt   | 350 ------------------
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  28 ++
 drivers/regulator/mt6358-regulator.c          | 250 +++++++------
 include/linux/mfd/mt6358/registers.h          |  17 +
 include/linux/regulator/mt6358-regulator.h    |   3 +
 7 files changed, 440 insertions(+), 459 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt

-- 
2.42.0.459.ge4e396fd5e-goog

