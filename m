Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31DA76FDED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHDJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjHDJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:58:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ABB46B1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:58:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f6231bdeso457721b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1691143124; x=1691747924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EANQ1vGlgmb0TMqoj4JWU4zYKE6p+9Gga/nIuxh4/h0=;
        b=AgfEoyYDMfPkL2laoHwN1Qgdw7VZw9qQDEOfZrwmSwRjZlGOxeLB/uj0TPKV63x43x
         sR76Df84ZqYeEE2t20P4YSsF2qxyZ7kUQlMt2DEB/jAUUbA6CJX98XrmPycFRnyDudDK
         QNSaIqci5t8plQY6w9IHdOE9trCZyARkT93fcv+287+pN/OjfInDTPgxd52rj8hIy5Xu
         B9mpeGSb4v2wNK0NVQs4nWG6H9Taw9ChbavkAp9upe0XcZSOgQ996tbM6IGqtS1nVzQx
         1XOEA0Rf+bMyocw0psfJvG/KaPjPSSS4UnWwVJGltUzqlvl5yNb2D5Ofpmx8Sxqfn773
         1bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691143124; x=1691747924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EANQ1vGlgmb0TMqoj4JWU4zYKE6p+9Gga/nIuxh4/h0=;
        b=A4qJQG2M+fNcYeHNZivJ79dvtjrQkaPSZQZd9PeMWf3hfv8U0iD8YlWI2mvR87utJm
         xNTp+vb0nVDRppV5IOYun2XxH+hP0HgUaz0SDZ62NEqig+1qrGl1k2R2QIAQbzFcEYel
         8UT0Xi1pMdiepjTIeQ0efapw89wDObQJtDkmYgbkLYljHqBaEM3QSYm7DI4O6FyxaISi
         bSeI1Ljm2lmpQ1Kj6QtJF+kuX8y/TnG4c/YmpZ/6Ov82Q2OwzjE9vz1jmIEQ8d0hsmQy
         yXvgkhQzyN8Bzv7CK/B9IfN4Od/q15F5fG/ME5cfskL5tre0a+ilCZtyu19UJHzxzjAJ
         mVeQ==
X-Gm-Message-State: ABy/qLabiDeXeMI0hTxFjrCynMJr1SahX5O4yfQM4GIj4zG4MCAx6yWC
        0k5dS7ShsVmpJLBrdzkWcFngIaXu6q3od0cNhUZzOw==
X-Google-Smtp-Source: APBJJlGhX5F+5jzIZxuVB6VUFwPDOTFjj6rWrry5UDitcKd9Ri20UL4wRvSwBf4unPR8KUGKiuPxIQ==
X-Received: by 2002:a05:6a20:4285:b0:133:7a67:b477 with SMTP id o5-20020a056a20428500b001337a67b477mr27384744pzj.1.1691143123889;
        Fri, 04 Aug 2023 02:58:43 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id i2-20020aa787c2000000b0067b643b814csm1259949pfo.6.2023.08.04.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:58:43 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add no-esim sku for sc7180-lazor family and new board version
Date:   Fri,  4 Aug 2023 17:58:33 +0800
Message-Id: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
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

Changes in v2:
- add new entry rev9 with Parade bridge chip
- correct newly create dts files

Sheng-Liang Pan (3):
  dt-bindings: arm: qcom: add sc7180-lazor board bindings
  arm64: dts: qcom: sc7180: Add sku_id for lazor/limozeen
  arm64: dts: qcom: sc7180: Add board id for lazor/limozeen

 .../devicetree/bindings/arm/qcom.yaml         | 55 ++++++++++++++++++
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
 12 files changed, 268 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r10.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts

-- 
2.34.1

