Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4B775324
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHIGtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjHIGtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:49:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9771BF7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:49:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6874a386ec7so1222574b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1691563757; x=1692168557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edmvXS+sqeFFekj+4pHNaHOAozBfysEAW6b0N27Q20g=;
        b=am0bS8pxzLyYhO/Q9Lg/Rp9JdEKELSWI8hoHxQo5amLvfLD3hf6+CgaAHtd3wX9Z+4
         rLGdAgG6oCXpOwtuv/vxV2OPgyZbCriLTuvJIXAQdCheIp61HtKJfR3IVqfKyKoXiewD
         cL9FGF26IDIFeKBHukRyPnvBA8w1CC8o9k/GGH1immzrKpBoxmJAFS3Xu7plkpni0ti3
         w2UgwB5/RtxzcgK+h3AdZtKbGFViUEPtxy+KXUrEUi4dFMIQseU70L/qzMbSHsuQAt2/
         JVq4aDZYSVul/Y5mXpvxJ3iRlsmrZfZzwQcCmwEF+ENeuHw5aU8vRitVFwHP8w67qCTE
         08ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563757; x=1692168557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edmvXS+sqeFFekj+4pHNaHOAozBfysEAW6b0N27Q20g=;
        b=i2w6YzuJgIzWZOGgE7vvyeTjBWXnW0a1We9oQtQdG+Lenye0KOKpQKCwjOpsV5vUWw
         Q4TxghRiwH/25SQpacJDp+44zVDK9lIsxbXW8U0ZD7O6OPoTO9MI3W22qyKMzEdP6X4T
         bYCS5Nj9ZZ9caf1Ckb9QHcM5tKnoQxeNpGBPB8VBoN+72fpz1iAUBE6f/8ipyVAFARb9
         8T2Y1v/XroYnntkNPgLRRk/AAmPl4u/IbOCViNyhOTAEqmH6x3Nj2KECzwMnbs0jj2qf
         Xx8N/OBjrkFV0nWsvPh54t2sSi99R3kQ8Har1lHjcxyJBBpK0qMjy7f9RR5xwtq2h0GX
         RtUg==
X-Gm-Message-State: AOJu0YxZUpLdAw+9zZBZZ1O2cWccqkEVv7xC0YbV6ssOJpHPnZr3YhyM
        TfXpenoHbSPhrrZHaWNbvyo40oa84M061asAB4uxHQ==
X-Google-Smtp-Source: AGHT+IGkYUW2nZ90eoqdwrKcJRrjTQiAhb43Zol5b0yVHWeKRb/vT7DI9vVu8a2LLANADjsUX8uIYg==
X-Received: by 2002:a05:6a00:801a:b0:668:834d:4bd with SMTP id eg26-20020a056a00801a00b00668834d04bdmr1994975pfb.0.1691563757450;
        Tue, 08 Aug 2023 23:49:17 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b006833bcc95b0sm9184161pfh.115.2023.08.08.23.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:49:16 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Add no-esim sku for sc7180-lazor family and new board version
Date:   Wed,  9 Aug 2023 14:49:05 +0800
Message-Id: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

for audio codec ALC5682i-VS.

Changes in v3:
- correct corresponding of new board and new sku
- sort out the node order alphabetically

Changes in v2:
- add new entry rev9 with Parade bridge chip
- correct newly create dts files

Sheng-Liang Pan (3):
  dt-bindings: arm: qcom: add sc7180-lazor board bindings
  arm64: dts: qcom: sc7180: Add sku_id for lazor/limozeen
  arm64: dts: qcom: sc7180: Add board id for lazor/limozeen

 .../devicetree/bindings/arm/qcom.yaml         | 31 ++++++++++
 arch/arm64/boot/dts/qcom/Makefile             |  5 ++
 ...sc7180-trogdor-lazor-limozeen-nots-r10.dts | 40 +++++++++++++
 .../sc7180-trogdor-lazor-limozeen-nots-r9.dts |  4 +-
 .../sc7180-trogdor-lazor-limozeen-r10.dts     | 56 +++++++++++++++++++
 .../qcom/sc7180-trogdor-lazor-limozeen-r9.dts |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r10-kb.dts  | 34 +++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10-lte.dts | 38 +++++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r10.dts     | 30 ++++++++++
 .../dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   |  4 +-
 .../dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  |  4 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r9.dts |  4 +-
 12 files changed, 244 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts

-- 
2.34.1

