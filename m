Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A367A30C3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbjIPN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 09:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjIPN5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 09:57:39 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C1ECD4;
        Sat, 16 Sep 2023 06:57:33 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id BC94941398;
        Sat, 16 Sep 2023 18:57:16 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694872647; bh=MViHkGlLv/u97rBJ/FjSx/gh7zCQGw3oonUyY417+LU=;
        h=From:Subject:Date:To:Cc:From;
        b=mKoRrwHWp+cz81RvemG9kjDpD9/9yhruQMerx8NmQ8nAuZ0pLdZZc7feh9cNcduXx
         LpuXoE/b4gXTHw1yYFsxHBSgqe44W9yGd6HsEOqFJ2BfqZFVSZ+Le1pCCTwRS8Gqgg
         rWqJ2EyfwMPG8z2u4dRziDsvi0v/0bK0i73dGeirP7N/l/z/nw8CFDkpdb978/dlSN
         qomo+NSyXEv0MhVEPClZuQ9vDtp1myd6ENeO7z/2iUbZHaxxLQZVSnD2YUJbsj5r/4
         /sE4vzAbSbBLGubrDqJDv6NF9dBETAdFsYXKPkVjZD98TxshJouWnsZ+biQ3dehnd8
         6KOEKZODqY8Rg==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/3] pm8916: Add BMS and charger
Date:   Sat, 16 Sep 2023 18:57:03 +0500
Message-Id: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC+0BWUC/x2MSQqAMAwAvyI5G7AVxPoV8WDaqAE3GhFB/LvV0
 zCHmRuUo7BCk90Q+RSVbU1i8gz81K8jo4TkYAtbFs5UuC/1h3CoIC2KM3m0AxlyLhgmC6ncIw9
 y/de2e54X+oznOWUAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=MViHkGlLv/u97rBJ/FjSx/gh7zCQGw3oonUyY417+LU=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlBbQ7KqiACdXvoSnyyJIuDr428zEhrxUPmNouu
 sk4hkJqkfmJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZQW0OwAKCRBDHOzuKBm/
 dWNVEACSmRkdD4veP1CKbIDPQpcN4D15jSanmB6UZ+nKgJdUptlOxvtrYr8JX4IGI/8XGzmuPho
 WbcZHvKb89vxSvdMGls0hFBiOIrMxfT/dnqCEviGCJE54vbwYBEmbk9WRh17u5QRvmtXiYyuLoM
 jgSmxEksflHXsgIeZm1E1hOWEiMbwx7rOplBg1YhJu7yXR2Q8iZxVBMiHs9I8uMY/4cIdPVI8XC
 8zRdFkD1EoqFjM+Fv0TM7oJ9M0pxwIqG9SpKlDZemRz+ltKDAAExuhfmJJ5dGWU5pipcQlI3/gy
 +OADrikVkN72MTPiKlu5Kxsgv7f2Su88IfIWIaFPL+C6W/ORoA8P290y+txQgotrVH3VX3E9JNK
 vB7zhGa1/taqKi1m0DFeKN/pxEOAoCl8PVu7554DWTUJe8Nd6IHHQpPpAgsfIb2NCWocLx3MyW4
 0rn+eU4uWP6XMRgE7E8Pg8Qo7zscwrjA8wEhbMNjtX7DCjd22SMNe/OpyMEFnYnqX3iyufln3hD
 BMrKEgj0ZgCP9kIObW3Pnkjl5EnGF+59bFs9BtMlRvqLUEHT9XicNSnqEWocgIy7ZE/j62cEli3
 RsZyxs5jYZmTQlTTGvPvGEbCkIfloYNxW1PV5a0kZWUxdWrZQHl1BoXWRGWwqpW910oMNXmq/F3
 DxCZ+TTIPGWF/aw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables VM-BMS and LBC blocks in the pm8916 pmic.

The VM-BMS is a simple voltage monitoring block that allows the software
to estimate the battery capacity left.

The LBC is a linear battery charger for lipo batteries.

Add both devices to the pmic dtsi and enable them for Longcheer L8150
which makes use of them.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Nikita Travkin (3):
      dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms and lbc
      arm64: dts: qcom: pm8916: Add BMS and charger
      arm64: dts: qcom: msm8916-longcheer-l8150: Add battery and charger

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  6 +++
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 43 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/pm8916.dtsi               | 48 ++++++++++++++++++++++
 3 files changed, 91 insertions(+), 6 deletions(-)
---
base-commit: b74e981ad267d71d7ffcc085b3b9b5de736fa279
change-id: 20230916-pm8916-dtsi-bms-lbc-2fb1b99d1eb2

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

