Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E827617AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjGYLwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGYLw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:52:28 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E561BD8;
        Tue, 25 Jul 2023 04:52:15 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 8258D4040F;
        Tue, 25 Jul 2023 16:52:07 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690285929; bh=y1KchFe3Mtqdnwvhv317kiD4mwvGaKa6vxKUtwO5pSw=;
        h=From:Subject:Date:To:Cc:From;
        b=TYJSlxAVnw3hjR5KPjRv7cn6to4/OJ27KxSL1ZdU4JYmwSz8TLPKfv1ALBb4jUysl
         fzvgY0aWZ86Os90vYaMDHnJ9Yw0a7hmQHtTj875RzumLSTw6Jy3YaHGe/V1E6IKgum
         p5gaGwnKZIHQ+KG/QjSGKPFPutis0nrtUSCvgW1NEuU0tZG0GkEi912wpOpDDVZKG1
         LRIpaSqV0/onyMJ2IYJ0pQ8RXJifTueOVUlYlrJ5K07hFFhdyQzpjQFTzJstDeKv4W
         Kr0mHchQBs3v5VfjG/5UjqMyWOKYhNkpRnLj2Y9/SoBlJUqzyIeV8m8B9aKCQAc0+3
         q0o6aUrRP546A==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/3] Add display panels to gt5 devices
Date:   Tue, 25 Jul 2023 16:52:00 +0500
Message-Id: <20230725-gt5-panel-v1-0-7c787e33a614@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGC3v2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyNT3fQSU92CxLzUHF0TEwtjc/OURPPE5EQloPqCotS0zAqwWdGxtbU
 AR5MN+lsAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Jasper Korten <jja2000@gmail.com>,
        Siddharth Manthan <siddharth.manthan@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=y1KchFe3Mtqdnwvhv317kiD4mwvGaKa6vxKUtwO5pSw=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkv7dj98hpQ9NXKfeX1bFKeSbYE10iDiyYLPm6D
 +H9Tj2UC/KJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZL+3YwAKCRBDHOzuKBm/
 dSj5D/9rpXki2KHyhpR0Z8OzTSYKYC1irSuMhGU9PHIPx/6/Sg9NIb1Jxbb9P/ambdHdGBxx2L0
 73hDtRONopuU3hxy7d1j5SOMwbLSVb9zS/5tAQzeAmhsVP5GxpEfaqg11cYQddB4uqBoXOooo3i
 fIEi/0RNC+f6nh0a78vQX7FiQpx1PedV/xWgxYfGyxzq4/P1LVS4rhEPkmJQ1YjRcfnnsdfVuys
 OQagzamqKRel+uqNovaH2Z/OwuQGMXcrydZhVUFT2cKl1Kiz9cwcM/dARNMqDHwXm2ew582+c26
 qQvyruZGSFXe3CUsHfX1hIptOfyN/ozKpGWsR79BR0HmQj+djPvFrYqaJO2eJ6WVMEagmgyyE2k
 4+fqsCpEx6ijfnwO7QbybAdu4ivfuLCjffu1hkZ6vkWDRSE2037FsJntQhcMdi4EnZtR/PXkNy5
 /I3VDsrOyYy1ZBkGDiSosBrUP369prYziroOpQsm/jviLGXEwOQ/mgaxirHP1aXfe08II3+aODY
 HfCqiMKhmTeZvCHqstsmq4ybO9waelAHi7iWBPKV9JMaWF300SSNdNPU6yvygDkXpluI6U+szWS
 bcTIfjROS1S/15vvNSiYScWv60sramZjVDELgSAywzpm0Xox/7CgW1FfA7rZ702+QgAOEaWkX56
 YYZUbjMqaCeyLVA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds display panels to Samsung Galaxy Tab A (2015) tablets.

Both gt58 and gt510 gain display support and backlight is controlled
with the DCS commands.

While at it, also enable touch-keys on gt510.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Jasper Korten (1):
      arm64: dts: qcom: msm8916-samsung-gt510: Add display panel

Nikita Travkin (1):
      arm64: dts: qcom: msm8916-samsung-gt510: Add capacitive keys

Siddharth Manthan (1):
      arm64: dts: qcom: msm8916-samsung-gt58: Add display panel

 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts | 86 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  | 64 ++++++++++++++++
 2 files changed, 150 insertions(+)
---
base-commit: 5f8e7fdfa482f56c9c884b5c41f40f8f5923d9c4
change-id: 20230725-gt5-panel-448377da7aca

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

