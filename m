Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B761783BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjHVIpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjHVIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:45:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119AB1B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a5457b930so1122123b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692693930; x=1693298730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4e8PiVON5BPxeakGTSUHXhgF5XGViH7EDdI7UeL+GU=;
        b=a7utS6SkklK51hKqpdsgD/pL/5tiCWABxQrWN+tmBd/pYSitBnMC6dkpENe7hllgc3
         Tdv+f/Gw2xkhqAZHwjg6so6jBzT1+3azaTNLcDn7D3kxMTN1nfj+pS1mz2SqtUo0vo0V
         jG80BWmyWsbONaKs8igg1RoyMw6Iy/+VdixR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692693930; x=1693298730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4e8PiVON5BPxeakGTSUHXhgF5XGViH7EDdI7UeL+GU=;
        b=OPLt8AL5eRsf08RXopzmA7usDgPb6LLIkRP1i8ned9ggZezAXgAPCTcCXHKTAG7bJx
         c1wons0NY4fR3s24qmtxrItmXknsvRQ1svxJUdfCRP9akp2iG56ENYvqa5PEdmGejksE
         AR6FQU+1z6AS9mENQMu4qGyNfnb/u3CpBWoP0RZZ1ZMCuik9q/wHWc08FjrzwCBdribF
         ezRRqzlcPcZDiwuHQX8FROPLX5OwG7aYmJTeN6+tyn0wNfhnDD4ptq4Tol5cl1ChPo2s
         SlSp2BeMWLj3C40d0sTLKiSYreUJF42+haFqh0OJ4dhfxDyFaFpLkSrrM7CxD/x4BEhE
         s/xw==
X-Gm-Message-State: AOJu0YzT+zP8Xe+II3RNcRTcbTKfeJa55ZqkJo3uQyRsJEm3RU2E9yV/
        kaZyITXEa06CJP64/YjwOc8xKQ==
X-Google-Smtp-Source: AGHT+IHrUJp3u16TQLqsQBn/YzOe1/lMaTSHKy4q2aDEAGU4yyXKLxhonCzC+Uan8vuJoILuBL3rXw==
X-Received: by 2002:a05:6a20:650:b0:13e:8ce5:bedd with SMTP id 16-20020a056a20065000b0013e8ce5beddmr7786724pzm.1.1692693930539;
        Tue, 22 Aug 2023 01:45:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e619:3fa0:1a90:6bb0])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00666b012baedsm7304790pfe.158.2023.08.22.01.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:45:30 -0700 (PDT)
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
Subject: [PATCH v2 00/11] regulator: mt6366: Split out of MT6358 and cleanup
Date:   Tue, 22 Aug 2023 16:45:08 +0800
Message-ID: <20230822084520.564937-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v2 of my MT6366 PMIC split-out-of-MT6358 cleanup series. The two
PMICs are mostly identical, except for the regulator bits. The MT6366 is
missing the VCAM* (camera related) LDOs, but in their place has a few
other ones. This thus requires a separate compatible to handle the
differences.

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
and improvements" series [1]. The series is still in flight, but I think
posting this earlier would help get reviews underway.

Patch 1 add a compatible string for the MT6366 PMIC, with a fallback to
the MT6358 one.

Patch 2 adds new register definitions for the MT6366-specific
regulators.

These two should go through the MFD tree and put on an immutable
branch for the regulator tree to consume patch 2.

Patch 3 converts the existing MT6358 regulator DT binding to DT schema.

Patch 4 adds regulator supply properties to the MT6358 regulator
binding.

Patch 5 adds MT6366 regulators to the MT6358 regulator binding. This was
previously done by Zhiyong Tao [2] from MediaTek as a separate binding
file. I cleaned up the patch based on previous review comments, simplified
the regulator names, and added regulator supplies. Bogus regulators were
also dropped, like what was done for the MT6358 [1]. In v2 this was
merged with the MT6358 binding, now converted to DT schema.

Patch 6 adds support for the regulator supplies to the MT6358 regulator
driver.

Patch 7 simplifies the MT6366 regulator names to match the new names
specified in the binding.

Patch 8 makes the MT6366 VCN18 LDO regulator configurable. This is one
of the differences between the MT6358 and MT6366.

Patch 9 adds regulators that were missing from the originally proposed
binding and driver.

Patch 10 adds regulator supply names to the MT6366 regulators

Patch 11 adds regulator supplies to MT8183 Kukui boards.

As mentioned, patches 1 and 2 should go through the mfd tree on an
immutable branch. patches 3 through 10 should go through the regulator
tree, on top of the aforementioned immutable branch. Patch 11 should go
through the MediaTek tree.

[1] https://lore.kernel.org/linux-arm-kernel/20230721082903.2038975-1-wenst@chromium.org/
[2] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/

Chen-Yu Tsai (10):
  dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366
    PMIC
  mfd: mt6358: Add registers for MT6366 specific regulators
  regulator: dt-bindings: mt6358: Convert to DT schema
  regulator: dt-bindings: mt6358: Add regulator supplies
  regulator: mt6358: Add supply names for MT6358 regulators
  regulator: mt6358: fix and drop type prefix in MT6366 regulator node
    names
  regulator: mt6358: Make MT6366 vcn18 LDO configurable
  regulator: mt6358: Add missing regulators for MT6366
  regulator: mt6358: Add supply names for MT6366 regulators
  arm64: dts: mediatek: mt8183-kukui: Add PMIC regulator supplies

Zhiyong Tao (1):
  regulator: dt-bindings: mediatek: Add MT6366 PMIC

 .../devicetree/bindings/mfd/mt6397.txt        |   4 +-
 .../regulator/mediatek,mt6358-regulator.yaml  | 249 +++++++++++++
 .../bindings/regulator/mt6358-regulator.txt   | 350 ------------------
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  28 ++
 drivers/regulator/mt6358-regulator.c          | 237 +++++++-----
 include/linux/mfd/mt6358/registers.h          |  17 +
 include/linux/regulator/mt6358-regulator.h    |   3 +
 7 files changed, 436 insertions(+), 452 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt

-- 
2.42.0.rc1.204.g551eb34607-goog

