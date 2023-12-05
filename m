Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C87805363
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442207AbjLELtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347024AbjLELtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:49:06 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECD412C;
        Tue,  5 Dec 2023 03:49:10 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id B4FF442C05;
        Tue,  5 Dec 2023 16:49:00 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1701776941; bh=Yd16HlDvjP3jh6i9zmcpxlFM7dpITGvKdCZ43tKOhl0=;
        h=From:Subject:Date:To:Cc:From;
        b=m+JMhi/xYZ7PUc3JXdAMFsiSeHab67mqjXxIPptiHMw5EZqenTskf4AnXvfxP4Y3r
         uH2T8xrPNwyeq5MjPFClpz6pirQGOrBxOKaNCKUXJ+CRqw5EOkupvJJW1vHj627stx
         nhdpO8Oh+z7vwtAA84ejiZfAOtyvMQoCm34nXZSQ9D/a1IyONm5X7Ubnvvmffu3atB
         sJ8gRzVdCjtM33NoUohCWbzQvunXAOO6YN7NdE/jk8xSw4E0mvU6ktNgVBjZYlToA3
         +VWdYyw1C7avR7s6rpX8Tm8SKtVymm++aGzFSQinczsIYqP3142HaTElpSSSpP3Xye
         MyhRxrV7oDdBA==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 0/3] sc7180-acer-aspire1: Add sound
Date:   Tue, 05 Dec 2023 16:48:09 +0500
Message-Id: <20231205-aspire1-sound-v2-0-443b7ac0a06f@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPkNb2UC/3XMOw7CMBBF0a1EU2PkDyZAxT5QCuMPmcaJZhILF
 HnvmPSU90nvbMCRMDLcug0oFmSccgt96MCPLr+iwNAatNRGSd0LxzNSVIKnNQdhjTt5eXb+mgK
 0z0wx4Xv3HkPrEXmZ6LPzRf3Wf1JRQgqbkvHp8rS9VPeFSj7SCkOt9QsaHSqjqAAAAA==
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=Yd16HlDvjP3jh6i9zmcpxlFM7dpITGvKdCZ43tKOhl0=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlbw4oTITqOl1Y7qXTcczKTAySao/I0UAaO1H6w
 lWUzH0j4ouJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZW8OKAAKCRBDHOzuKBm/
 daLDD/9jXXcXmiJ3CV7/NYRtKtrRTF8ItC2cdrJztL9XIFVb9QbmYRjIF2dE4VMO/iSTNELLqix
 87Bt2/jAeYORBDQKIT2ZUpEirERudZkAdxpr4oInw6QJvLIpf/9tvsKKzDl5zvzE5JxchraoiMa
 kFfu0XC2/gYcMSUFTV62cBlm8CgJUkaKLt8UhNuRygZvXHiT2nKe4yUP/gWQcVxBv+RdNce234C
 Ef7FSHLa4B8XVnutUICcUGr1CZ0EzORyz7gewpsVkQzaT3417eWbWRnS1nNJlVDSyK027fl7alA
 0WborvM7Gbp+YNZsEjd7txKmT0ifJHxJCUtCY2cSrE8HU6RYF1NdPe7KtrMlT5X6Xz9ASJuruES
 JCDA92pUr89nlpWQUmUbnsWA7UhS99t7dz8lmbdPmJipGojHPCBgDUXg0I/M+gue83DCAEDNIHi
 OCuHkoHr9sSOMyWoK8U19GA++hfZCpgZpnmxP/E9RESXFszJo8zcPpxL9rQwjdLFSAy7KErMBj4
 ukgkIPEtxgweniPr3fw0ilYhDlPiO3Mzu8KolrEUXJE4RkDEHF1MtwX86IzG3f32QjuIcveR2vq
 NKJ+Uoy8ONqKwxFvu9B8oznk74zWC+zonwhHCQTaBb1Z4/0Fqeoyjp81muH3C9wz+xODEGxWe0l
 pBnfRNR2SvJmkbQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds initial sound support to Acer Aspire 1.

The following sound devices are enabled:
- External stereo speakers
- Headphone jack
- Headset microphone
- DisplayPort sound*

[*] The DisplayPort itself is not yet enabled as it depends on
the embedded controller, which will be added later.

The stereo DMIC in the device lid is omitted from this series
as it requires introduction of the in-soc audio codec, which will
be done later.

While at it, also enable the PMIC RTC that, while is locked
by the firmware as read-only, still allows userspace to track
time with extra tools to save the offset.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v2:
- No changes, picked up tags.
- Link to v1: https://lore.kernel.org/r/20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru

---
Nikita Travkin (3):
      arm64: dts: qcom: acer-aspire1: Enable RTC
      arm64: dts: qcom: acer-aspire1: Correct audio codec definition
      arm64: dts: qcom: acer-aspire1: Add sound

 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 174 ++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)
---
base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
change-id: 20231027-aspire1-sound-53a4c06ac9fd

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

