Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2177F8A82
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjKYMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYMFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:05:51 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D883B10F0;
        Sat, 25 Nov 2023 04:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1700913953; bh=zKpVtX7Z5H9TZTsQOclY81dc6bXE/cpnlMLFfUR5Xww=;
        h=From:Subject:Date:To:Cc;
        b=UkzJHV65Jci8IOmF/dHv0v4Fn9igrezDyUVbJ/0zsLZ27rH2WgiRJwUOYot+4KRjD
         IdwFfboMBpfESNcwpUUKSBU1QTimTxszBFgNbvEFDSGYk1Oau823UwLgHAMvjMGBPh
         zqqIivIxZasutTXoG5L+e9KYTAOVf9pKbFVM2fTY=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v3 0/3] Add support for HTC One Mini 2 smartphone
Date:   Sat, 25 Nov 2023 13:05:32 +0100
Message-Id: <20231125-htc-memul-v3-0-e8f4c5839e23@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAzjYWUC/3WNOw6DMBAFr4Jcx9HuGjBOlXtEKfiYYClAZAPiI
 +4eg1K4STmrnXkbc9oa7dgt2pjVk3Gm7zyIS8TKJu9empvKMyMggQDEm6HkrW7HN5cx5VmCsqK
 4YP7/Y3Vt5rP1eHpujBt6u5zpCY/rr4IYVCbkwJUshUKoM8jVfRXdMF7nZT2i/wyZ6kRmUqCCM
 jCO3YmCLYpDk7yZKSQVQ5HWKgnNfd+/Dbf2Kg4BAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=zKpVtX7Z5H9TZTsQOclY81dc6bXE/cpnlMLFfUR5Xww=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlYeMSs+NRmunaLtyaZdFlB/P8KODemXW4chf4i
 ke2cYTRtwuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZWHjEgAKCRBy2EO4nU3X
 VkynEACweUGIoqYRAfsVcS6/bY2w1l4UBb7goLfylbIdLe4Zfbdui2o2BHz0rxMOlFuhqgOEq5s
 wxadr7DwZcZ3m7SpB9pWSDEyc73CgYLdelZkJLLAiiZ45UEAbta/txgpVu96IUJQH3vxp9HPaBd
 NgVjo4YNAvrd4cjwysCO6sOO9Q37usbLg7Gr3GveJPHGE4N7CX3OqE14okfe15ho+l4o+14jLn4
 cVKe/yG/wF5rPW5Eko06fF65WJJ8a1i6hwRdLS3msN9HVfOcdvfVChq54Pl3jiBxOjnNSvHIzIy
 ffoV9GrUZtEP8a1J2zi/vOJkZYyM4eKvstFAemM7owY5bKKljpoCxMN29cD59KiAqi+sw1l73+D
 Y0ah3YTNzKVod1epi+uU1IPx5/2OSV66f5Lgj7OkeMV6VV3tpR/N3YApVFyocMHgHh5Hvp1D8wc
 OMuNDxNkNGVwzRBp0pEkCEVA1WgXCBBDdqE+zGxWiQdLEzwxdFhohYA77fd8DEuWLl9Sxal1Iuv
 Abxs+QnUxaWO9KZ1zYOkePg6ntYpH7A3BX+Gu1ROF1uxdBw71NX2HR0i0u79urrWTlFKybJBOMb
 Q5GkK1eqdBVCxnLteit51rjwAIHDZAs0bewlw6srbWwSJTgYpvzOQS7PjWYBg/1TX1xl1UwIf0K
 8U4NBCDErC5HDwQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for this smartphone from HTC which is based on the MSM8926
SoC and codenamed "memul".

Depends on, runtime-only, bootloader enables watchdog so we need to pet
it to stay alive:
https://lore.kernel.org/linux-arm-msm/20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz/T/

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v3:
- Add regulator-allow-set-load for sdhc_2 vqmmc-supply (Konrad)
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20231024-htc-memul-v2-0-8912940b6f95@z3ntu.xyz

Changes in v2:
- Pick up tags
- Add spaces around regulator nodes
- Set firmware-name for adsp
- Expand reserved memory regions to cover everything somehow reserved
  downstream, leave no gaps. Seems to finally fix also nbd randomly
  failing
- Remove internal storage since somehow it has killed itself on my
  device since last time, maybe by my random memory testing writing some
  not-so-great commands to it. So let's be safe and remove it.
- Link to v1: https://lore.kernel.org/r/20231011-htc-memul-v1-0-76e57873190c@z3ntu.xyz

---
Luca Weiss (3):
      dt-bindings: vendor-prefixes: document HTC Corporation
      dt-bindings: arm: qcom: Add HTC One Mini 2
      ARM: dts: qcom: Add support for HTC One Mini 2

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts  | 370 +++++++++++++++++++++
 4 files changed, 374 insertions(+)
---
base-commit: 15bb585707ae9c4e3acd42a81d8eac9f1e9e50cc
change-id: 20231002-htc-memul-742a8517d24b

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

