Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDC76E21C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjHCHyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHCHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:53:35 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC1C5593
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:43:23 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a76cbd4bbfso139230b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691048578; x=1691653378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wcQgKLzUEDCQTRYm49e4K1eJ/gD3SsCDYx79kxO5Jk=;
        b=lxmBti7naxFncDx+danzQeW9Ae4PH8ymvcBAYbncEatj2ordC1uXqCq1hQDn0J8Hs4
         M3gafNZz5gtrMlWOriWt+vk3Y1apTrzyGuPCr9/lJPtJzuFZsPG/eCGxFRbkpzMjM7+Z
         ND37OklDyGfg81mWexD/wxVQ59qyNmzpdSwqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048578; x=1691653378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wcQgKLzUEDCQTRYm49e4K1eJ/gD3SsCDYx79kxO5Jk=;
        b=DRlfoqEREw7rvT8dJJQbY5729vopOx6Ma9xZEP9FiV+1rUnNwlKQChfL0OJd5AKQ5N
         Bq6HZYVBZdv4VdWR/mOHu51oR7sibETg0cXBxqE3jjD7zf+twBbJTHYvIirpNTSP/psV
         zvDsJPvzZThlZP3ydy640moHCb6QaYudXqT6qZqWc88HOJvF8VPZzZhtFkm13GI0MStb
         psMpq2KQlitkgnV7fRcZv8ou7HmeNvG5y0UuHceeGoaztEKJS4up9rKRypv5TwnpXXC2
         7HFgCTV+3Wg3Tc+WyuNDm8A+eu5s8bz/PqREIRNs5fBSQtNAhmlnY0WwUZhzHUkFuKv7
         rabA==
X-Gm-Message-State: ABy/qLafVQPdgpE3YhUQA0CAJyjETRqh+ccC9gblZT+AfhaBFehe5lRL
        YNgodBgUpWbodmz5q+7Y7z3uWA==
X-Google-Smtp-Source: APBJJlE6UT0T4AwfmsNqza3+1zBspZtZF++zc77ynB+tf5wLZLaPVCNPN77k7YeQhSxF5KVnRC7RGQ==
X-Received: by 2002:a05:6870:f623:b0:1a6:c968:4a15 with SMTP id ek35-20020a056870f62300b001a6c9684a15mr19659252oab.4.1691048578025;
        Thu, 03 Aug 2023 00:42:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f3e:66ee:db46:473b])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a72cb00b00262d079720bsm2095753pjk.29.2023.08.03.00.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:42:57 -0700 (PDT)
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
Subject: [PATCH 0/9] regulator: mt6366: Split out of MT6358 and cleanup
Date:   Thu,  3 Aug 2023 15:42:38 +0800
Message-ID: <20230803074249.3065586-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series splits out the MT6366 PMIC from the MT6358. The two PMICs
are mostly identical, except for the regulator bits. The MT6366 is
missing the VCAM* (camera related) LDOs, but in their place has a few
other ones. This thus requires a separate DT binding and compatible.

This depends on my previous "regulator: mt6358: Remove bogus regulators
and improvements" series [1]. The series is still in flight, but I think
posting this earlier would help get reviews underway.

Patch 1 splits out the compatible string for the MT6366 PMIC, so that
it no longer falls back to the MT6358 one.

Patch 2 adds new register definitions for the MT6366-specific
regulators.

Patch 3 adds a new entry for the MT6366 PMIC to the MT6397 mfd driver.

These three should go through the MFD tree and put on an immutable
branch for the regulator tree to consume patch 2.

Patch 4 adds new binding for MT6366 regulators. This was previously done
by Zhiyong Tao [2] from MediaTek. I cleaned up the patch based on previous
review comments, simplified the regulator names, and added regulator
supplies. Bogus regulators were also dropped, like what was done for the
MT6358 [1].

Patch 5 simplifies the MT6366 regulator names to match the new names
specified in the binding.

Patch 6 makes the MT6366 VCN18 LDO regulator configurable. This is one
of the differences between the MT6358 and MT6366.

Patch 7 adds regulators that were missing from the originally proposed
binding and driver.

Patch 8 adds regulator supply names to the MT6366 regulators

Patch 9 adds an entry for the MT6366 PMIC to the MedaiTek pwrap driver.

As mentioned, patches 1 through 3 should go through the mfd tree on an
immutable branch. patches 4 through 8 should go through the regulator
tree, on top of the aforementioned immutable branch. Patch 9 should go
through the MediaTek tree.

[1] https://lore.kernel.org/linux-arm-kernel/20230721082903.2038975-1-wenst@chromium.org/
[2] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/

Chen-Yu Tsai (8):
  dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366
    PMIC
  mfd: mt6358: Add registers for MT6366 specific regulators
  mfd: mt6397: Split MediaTek MT6366 PMIC out of MT6358
  regulator: mt6358: fix and drop type prefix in MT6366 regulator node
    names
  regulator: mt6358: Make MT6366 vcn18 LDO configurable
  regulator: mt6358: Add missing regulators for MT6366
  regulator: mt6358: Add supply names for MT6366 regulators
  soc: mediatek: pwrap: add support for MT6366 PMIC

Zhiyong Tao (1):
  regulator: dt-bindings: mediatek: Add MT6366 PMIC

 .../devicetree/bindings/mfd/mt6397.txt        |   5 +-
 .../regulator/mediatek,mt6366-regulator.yaml  | 154 ++++++++++++++++++
 drivers/mfd/mt6397-core.c                     |  31 ++++
 drivers/regulator/mt6358-regulator.c          | 127 ++++++++++-----
 drivers/soc/mediatek/mtk-pmic-wrap.c          |   2 +
 include/linux/mfd/mt6358/registers.h          |  18 ++
 include/linux/regulator/mt6358-regulator.h    |   3 +
 7 files changed, 296 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml

-- 
2.41.0.585.gd2178a4bd4-goog

