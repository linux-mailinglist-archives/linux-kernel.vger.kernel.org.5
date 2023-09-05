Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C019792B22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbjIEQsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352431AbjIEFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:48:19 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA2712E;
        Mon,  4 Sep 2023 22:48:12 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id DFB88408E8;
        Tue,  5 Sep 2023 10:48:03 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693892884; bh=6NzDrYOGUI/eztRBxodJ7A7nQVvfQ/vxNF6cyl99jnI=;
        h=From:Subject:Date:To:Cc:From;
        b=qrj6JUL8oHQl+rsibyMi6LJ/sbBKgakLOZYIzUbMXlKUUWLRfBAuWQqCQi8ZDQ0+v
         UogFkyuBRhNfGRyxykgw3HIeiZoX7AZwHZPVWja19hqwnhyNl6iXOE9tElvypk8Dcp
         vH94w3fYxI60cjhF0KXcoSPlJE3qMgrUkC5byKpQEE9GBgKbhHbTzz0tqZzEDHn2Fx
         pO7vDJo64+PRs0P7yzQgjGfzkO2h7yji/qWzWM/PvX4QF1DEWGuSPqanYmbnSplqHS
         1K11XEdLzdLgaOw9tOatqHXlxPBZyuj8YjJfkhypXH7GIgeWyiWSGP4ANEwEEcmNuj
         z2fuRDXJTRx/w==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/4] sc7180: Add ADSP
Date:   Tue, 05 Sep 2023 10:47:19 +0500
Message-Id: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfA9mQC/x3MMQqAMAxA0atIZgO1Kq1eRRxqTTWLlgREEO9uc
 XzD/w8oCZPCWD0gdLHyeRQ0dQVxD8dGyGsxWGNbM5geNbrGGwyrZpQsZ8Tgun7xPiQ7eChdFkp
 8/89pft8PnwYx9mMAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=6NzDrYOGUI/eztRBxodJ7A7nQVvfQ/vxNF6cyl99jnI=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9sES+wqZKbIUGbtvj7cTi3dr7MkmPaV9w4glL
 OacWiZsZ8SJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPbBEgAKCRBDHOzuKBm/
 dVjQD/9DU0y3Sfg7b4TRIuj5naCvCyNpYfcItUCL7fspA12rURwFVxe0+1V19czWuV/wdf8IKdK
 NXcQB6fmO9U4A8CS/MSj7Y2dnQbabIGHpORZP/MlTIZBy/FdpJgvARTDTZVadxMGj06MTbkNcBU
 Cm2HPPDAN68cyUPJYdv9KYCmyO/jz+zjTNJu8XcaWsvBrxS/4Yb/OgXZDLBND6bYh9LuPHOKJtS
 ckCUk4wfJbR1dh/9AK/k1YHnKwORHwhF+sFwM41p0tZJmGOIe+q9nqaJguyr8MoPmxl9BmWmYQH
 Ki/I8YVmFP1mWvQvnnP8y0ACZT4udu6+/ZRHTwAIw7yBzIbC5HwLJaEMk+UCqxIEPOXJLghV/6S
 ogUB8pJ7bBWykzAiLWO+nf/z938tpbwtzSmTGB/6jrGGOE9T7nHho7k+tFt9qYBX+1PDU4nnjpJ
 U7eRufLYDSl7qLG/biZRwxM8d/ObEbtl1EHa7IfRQqvQF0/emqzCZ9wxo0JqQC1xwYkcjXyNUB+
 sYtXyf7owIyPPjK4ivdRP4lABJRMrlv0WFIDqQeMjQhl6GoRRbXSHjTsqSmtGdLmTkSD+X0p3ba
 du4sGCQFhsZHQCpc4iPkk3n23ZfGUsZ8Qcvfy0jGh/ldZkVxbBUE85pQps0KIqjqd/NzU+WKeLG
 wLoY8r7LahQoaRA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Nikita Travkin (4):
      dt-bindings: remoteproc: qcom: sc7180-pas: Add ADSP compatible
      remoteproc: qcom: pas: Add sc7180 adsp
      arm64: dts: qcom: sc7180: Add tertiary mi2s pinctrl
      arm64: dts: qcom: sc7180: Add ADSP

 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |  12 ++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 127 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 |   1 +
 3 files changed, 140 insertions(+)
---
base-commit: c50216cfa084d5eb67dc10e646a3283da1595bb6
change-id: 20230905-sc7180-adsp-rproc-a745b88af298

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

