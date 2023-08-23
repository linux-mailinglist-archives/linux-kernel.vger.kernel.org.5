Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04264785137
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjHWHNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjHWHNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:13:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62EAE70
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:13:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a32506e90so847962b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1692774816; x=1693379616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PO+Ey3j2yYoRS6DyVlW+DY8b4TN0ziEpE6uBDlFJlcg=;
        b=sSTF4Bzwds7FF7UhrCSf8Fj3jWGfVtl/45AXKdqP34lJDDSfDMdnbzU0afGXqWvr+Z
         YxMXH3royQifT3Do4gu4d9xVZRXqQeQjzFXM44UXAvXPMsFqDtR/NT9gJJu49Fr9h4PQ
         LVh8hlG2Qw5xuISva4D1A5FvhLPzL6DcCpxI5p/9b5xiqsMo9LpuFtLw+kcVwxrg4rkY
         VpmTnx6gHh+G3mR+B1wheOXLkmmMI8kGZiEQg039d2eBbMeznq4xR+SDOOd7/Jf+d0Bd
         qYVgAIoA6BBAvHPTsf9PLx8SCpShRMQm/HX1M3wy3+jPmq5VkNOF7/UO2Jfy7VJHqZWQ
         eFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692774816; x=1693379616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO+Ey3j2yYoRS6DyVlW+DY8b4TN0ziEpE6uBDlFJlcg=;
        b=bIARjv3cXrOhuuLKyGtx7eXnDOY2GGjUlxMdCqKL5h9nwzgOue5E/hOafBb1IyD8AG
         JvleU6RyL1wd9ALUhmEwd4B6TZmw7c689Z+owKAOaMvvQDMjett1RbfrvpsM92ZaWJIN
         UwuPSJ8ChqaAl3j87ct/eKQfn7ttRolk/SBR9iR3Sgly0Y5yd8LHvM7vrmWdrmGXcneQ
         whrts1uu/DyDxMa4sofobSc9LvSVmqr9tOZuaJ49kUWK1AyZlRFOxTpvGhAW8bcfTscX
         ZqmdgZQ3tyvj1goI2upbHguSqnicGS3Sk9iDzeEEOy2749zSFvVZI+qY40RYk1kfmDF4
         mkow==
X-Gm-Message-State: AOJu0YwoabpRhdyL+Elw30z9ShSLX5WmB0mMGGdj9m7ejLh7XM8LFN3b
        YI6fzPAzw4Q2hdCFOkfHzcUm/4kvgQpidiIPhqA9Mg==
X-Google-Smtp-Source: AGHT+IEYGzEh3Vjas2kgJKE67lSNZMqbq+eJ7/gl+/IdNMtaC+7NqH7H0+zbesvyh727jTc4YGcNrQ==
X-Received: by 2002:a05:6a21:78aa:b0:133:7a67:b477 with SMTP id bf42-20020a056a2178aa00b001337a67b477mr15729732pzc.1.1692774815951;
        Wed, 23 Aug 2023 00:13:35 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id g16-20020aa78750000000b0068a690b44basm2520860pfo.31.2023.08.23.00.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:13:34 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 0/2] Add no-esim sku for sc7180-lazor family and new board version for audio codec ALC5682i-VS
Date:   Wed, 23 Aug 2023 15:13:04 +0800
Message-Id: <20230823071306.131373-1-sheng-liang.pan@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Changes in v6:
- commit update, add dependent patch link
- remove unnecessary symbol
- sort out the order of properties

Changes in v5:
- rebased on patch moving rt5682s to a fragment

Changes in v4:
- combine pathc2 and patch3

Changes in v3:
- correct corresponding of new board and new sku
- sort out the node order alphabetically

Changes in v2:
- add new entry rev9 with Parade bridge chip
- correct newly create dts files

Sheng-Liang Pan (2):
  dt-bindings: arm: qcom: add sc7180-lazor board bindings
  arm64: dts: qcom: sc7180: Add sku_id and board id for lazor/limozeen

 .../devicetree/bindings/arm/qcom.yaml         | 31 +++++++++++++
 arch/arm64/boot/dts/qcom/Makefile             |  5 +++
 ...sc7180-trogdor-lazor-limozeen-nots-r10.dts | 29 ++++++++++++
 .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  6 +--
 .../sc7180-trogdor-lazor-limozeen-r10.dts     | 45 +++++++++++++++++++
 .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts | 10 ++---
 .../dts/qcom/sc7180-trogdor-lazor-r10-kb.dts  | 23 ++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10-lte.dts | 27 +++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10.dts     | 19 ++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  4 +-
 12 files changed, 193 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts

-- 
2.34.1

