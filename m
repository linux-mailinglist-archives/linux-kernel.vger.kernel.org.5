Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D477A6366
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjISMqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjISMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:46:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FAEF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:46:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c00b37ad84so33897631fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695127564; x=1695732364; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9z07Us7rZb6gq2/8xqzCrZiW902N6IA0/Qa57rZImpc=;
        b=afOu+bj3bvS5xpftK+GPwcqggMusHDEaHeGy93P8OqtScfCzupWEzT5pfz3KZSSTLt
         yKadZHNZlm4I6mXafKBFTqMynlDBFjrT24YJgVej0OUbndcG1EX9+V+1ZTC2BQqg4YMG
         ZyXpK5wRnzEol/MNuTLyvPNHppHJMTuz99AnicM/pZFL0ZkqbOzK6CA1UKV1fSXPOG7e
         7N0lB3g/2M6WgKPZevqu/3YspW7SXPf9EgC7T44uc4LRZ+gjkP2UCdTThcZsrSnVYSwa
         MZqz2lYYruq036l1JvloBeSinaGuEA/DzHTpQ9bi0LRe290uax0PBNenXgQD0aUz0n0C
         9OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127564; x=1695732364;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z07Us7rZb6gq2/8xqzCrZiW902N6IA0/Qa57rZImpc=;
        b=P2g5SRwTjCYc35jiIpJbPu+De7FIiquBaXjEsTtZWiTcXYSupYTagYQuMtTg3ey75U
         VYwgAQOlPBFEsgjBV6xONjw89HkvE/4dBsu5qjaozhzpX5ymPX6v93N7lj+pzW8x9co6
         YOxCAQ/M0LA2rGHQHBdlfDwNx6SpXbSqgpW/VqomD3l8v+geM5AnpAsEtjL5HUMqiJri
         BVOJWrMeJl50KOisxxgbGMMQBkvkdOaP0Myf6tBnQZInY1pNFDoaChbhHXucwRiU1OdE
         zcZ9RvoeAZutYNy3adXz0sGsa+erhnMWdYJg3RNNoDG9Ha1Dmp/VL/zBepUGgFdMdCrm
         ThSQ==
X-Gm-Message-State: AOJu0Yz/8bvcQAxMzqPFr1isG1zOUnuCQZc99TCBiDEy6AFP5Irk6ygU
        w5z/LRP0CI74dWQ2vcQfmTtuo9v6L/ZBAZgg0CbzqPiR
X-Google-Smtp-Source: AGHT+IHNhIbT5BUwfUlNuBFu/j2zIN14WtAoppACWN5FjNtYRlzDPYwsw3kpRqLU5mmUrubIPzBMPQ==
X-Received: by 2002:a05:6512:b10:b0:503:2555:d1e7 with SMTP id w16-20020a0565120b1000b005032555d1e7mr4227843lfu.45.1695127564047;
        Tue, 19 Sep 2023 05:46:04 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00532c1dfe8ecsm635878edb.66.2023.09.19.05.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:46:03 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/7] Initial support for the Fairphone 5 smartphone
Date:   Tue, 19 Sep 2023 14:45:54 +0200
Message-Id: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKYCWUC/1XMwQoCIRSF4VcZ7jpDnQynVe8Rs1BH80Kp6CDF4
 LtnQ5uW/4HzbVBsRlvgMmyQbcWCMfTghwGMV+FuCS69gVM+UskkcUkQDLiiehB9NpIzqtVkJPR
 Hytbha9duc2+PZY35veOVfdefM9I/pzJCiVCTOAk2aa2Wq1OYk4/BHk18wtxa+wCZ7WMEqgAAA
 A==
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to boot up mainline kernel on the QCM6490-based Fairphone 5
smartphone.

These patches only cover a part of the functionality brought up on
mainline so far, with the rest needing larger dts and driver changes or
depend on patches that are not yet merged. I will work on sending those
once these base patches here have settled.

Since QCM6490, like SC7280 are 'yupik' in the vendor-provided kernel, we
can base the dts on it and leverage existing support. Though current
sc7280 support mostly assumes ChromeOS devices which have a different
TrustZone setup, so we need to move some ChromeOS-specific bits to the
sc7280-chrome-common.dtsi file to make it boot on a standard TZ board.

Depends on (just for the #include in sc7280.dtsi):
https://lore.kernel.org/linux-arm-msm/20230818-qcom-vmid-defines-v1-1-45b610c96b13@fairphone.com/

The pm7250b patch has been picked up from this series:
https://lore.kernel.org/linux-arm-msm/20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Add comments why nodes in sc7280.dtsi get disabled (Konrad)
- Mark more nodes in sc7280.dtsi as reserved
- Don't allow writing qfprom when (optional) clock isn't found
- Device dts changes:
  - Stylistic changes in device dts
  - Remove qcom,msm-id & qcom,board-id properties
  - Add regulator-initial-mode
- Pick up tags
- Drop patch 03 "arm64: dts: qcom: sc7280: Move qfprom clock to
  chrome-common", it's actually not needed with qfprom-clock-optional
  patch
- Drop patch 07 "dt-bindings: arm: qcom,ids: Add SoC ID for QCM6490",
  patch 08 "soc: qcom: socinfo: Add SoC ID for QCM6490" and patch 09
  "cpufreq: Add QCM6490 to cpufreq-dt-platdev blocklist", all applied.
- Link to v1: https://lore.kernel.org/r/20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com

---
Luca Weiss (7):
      arm64: dts: qcom: sc7280: Mark some nodes as 'reserved'
      nvmem: qfprom: Mark core clk as optional
      arm64: dts: qcom: pm7250b: make SID configurable
      arm64: dts: qcom: pm8350c: Add flash led node
      dt-bindings: pinctrl: qcom,sc7280: Allow gpio-reserved-ranges
      dt-bindings: arm: qcom: Add QCM6490 Fairphone 5
      arm64: dts: qcom: qcm6490: Add device-tree for Fairphone 5

 Documentation/devicetree/bindings/arm/qcom.yaml    |   6 +
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |   4 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |  14 +-
 arch/arm64/boot/dts/qcom/pm8350c.dtsi              |   6 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 667 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  24 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |   4 +
 drivers/nvmem/qfprom.c                             |   6 +-
 10 files changed, 729 insertions(+), 11 deletions(-)
---
base-commit: b3b1378016952541463ef2369da780d4f9bf02b3
change-id: 20230818-fp5-initial-b6c8210ba9c8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

