Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A45792A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbjIEQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354316AbjIEKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:41:34 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BA71AB;
        Tue,  5 Sep 2023 03:41:29 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9EF8E408E8;
        Tue,  5 Sep 2023 15:41:23 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693910484; bh=r0Errm5grHoZ7a+GZjlkoliB85rDwXGFHNRI1loDIh0=;
        h=From:Subject:Date:To:Cc:From;
        b=WLUAntEBkVQ7yWgix/eaNKSDrfg6B88vTJ0jtYbf6kI5UdQAk18tdKU8W/OYZuDB1
         izd9iNoZjU8Jssqy4aNUvtDwiWPt3PISUT2QpqGAx2JMyKgJeQGfNcm9Grk5/KEKxT
         Gvt0SPcxjg51AgQVWauq8MxtLdqUtqmnV8ri057jgWQRfboGSvx8xqBwYaiOmO040R
         bxnx8QV3/uNzSBq9QFgN5sQWJbVhUUt2nGjJR8KzSXePOCMc90AbR729fJggV+dsc+
         GXCmkDj575rH/0QrdVZUF/F35jyvCsdwMhexM6TzPtQfRzqWp/kLSN5PwufbL6CBx/
         3iek9mggodciQ==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 0/4] sc7180: Add ADSP
Date:   Tue, 05 Sep 2023 15:41:03 +0500
Message-Id: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8F92QC/32NSw7CIBRFt9K8sc8AWoGO3IfpgPKxTFryqETTs
 HexC3B4TnLP3SF7ij7D0O1AvsQc16WBOHVgZ7M8PUbXGAQTF6ZZj9lKrhgalxNSotWikdd+Uso
 EoRW0XSIf4vtoPsbGc8zbSp/jovCf/VcrHBm64I28ae2MnO4bleVMLxhrrV8Jv9GysAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=r0Errm5grHoZ7a+GZjlkoliB85rDwXGFHNRI1loDIh0=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9wXSy8pwFM3PZa26yt8IFcFBmjmMdjaDTnkbn
 guQmmL1KmGJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPcF0gAKCRBDHOzuKBm/
 dXIPD/4qRbXGgh4mvBpZgyILTd7Rmjy46zpdR2Tf1BBLQMMoT+4+64cTqakg0INFnQbfc/ufQRa
 xFH0dySZIJFqeK8GBg1P0VC/10GzbczISHhDhKMi6MDmSgyltyu9ov4eCO58Mex4/SWp9/OLh8r
 PE3PLXBCFbmalEBOb0LJyyiAALBxShBMJ+mDlA+4AIfW0CrKMBPOFxfXWuO4TH9KN7pzBneSwZk
 XNncoBlNjZ3x6M2Ei5mqMJWoW2i4tgN3XGR8eBWcac1ZCAFsvYVSDGm39uOxM6flfC8XZ/FA0ry
 GJUVSKvpDhOg7o4giJ0HHNDO9gU1jJsGTtJpvWyd7F2BOP0IsCa7wf/TjoFAEaDK/XdqNiOg31/
 HKokJ5FDuScVq7STarfKFV3Gm3vkNZ30mgUvoM+eNwNQvVnMvInNZCfocO6lBj8QkBZwr7WthV5
 hvIBpu3t0T/UiqLPK3f3sbe3OpbxtN1Hj5fh6RN25wSdpKkUrv0nAsi4HFoJhhbe9mWOSGao9BN
 KQjn57srZMywrgPv2tfHCPyfTRwe9LX0EzQYuNeU8lYFpSaueTrFu2HXLZ0jiTekrQbLPT0CjYh
 isn27URMq2l+FSCVqNCd6kpO/kdY2IOzn08lCNv8hvm6sCS188SefSA3qYQIW2+HAXdUxXka8Uu
 5YRFNew5U1bm0nw==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sc7180 has an ADSP remoteproc that can be used to control the sound
hardware. This remoteproc has to be used on those devices that use
Qualcomm firmware and thus are locked out of driving the lpass directly.

Introducing the ADSP would allow multiple WoA laptops such as Aspire 1
to provide sound. It's also useful for the sm7125 devices that are to be
included to the kernel [1]

This series adds the ADSP and the sound services needed to make use of
it later.

[1] https://lore.kernel.org/all/20230824091737.75813-1-davidwronek@gmail.com/

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v2:
- Refactor the pas binding to fit adsp better
- Fixup remoteproc subnode names and property order
- Link to v1: https://lore.kernel.org/r/20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru

---
Nikita Travkin (4):
      dt-bindings: remoteproc: qcom: sc7180-pas: Add ADSP compatible
      remoteproc: qcom: pas: Add sc7180 adsp
      arm64: dts: qcom: sc7180: Add tertiary mi2s pinctrl
      arm64: dts: qcom: sc7180: Add ADSP

 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |  81 +++++++++----
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 127 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 |   1 +
 3 files changed, 184 insertions(+), 25 deletions(-)
---
base-commit: c50216cfa084d5eb67dc10e646a3283da1595bb6
change-id: 20230905-sc7180-adsp-rproc-a745b88af298

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

