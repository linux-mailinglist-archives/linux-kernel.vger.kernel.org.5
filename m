Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622DB808691
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378996AbjLGLVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378943AbjLGLVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:21:39 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16936D53;
        Thu,  7 Dec 2023 03:21:43 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 7E428424C3;
        Thu,  7 Dec 2023 16:21:29 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1701948091; bh=NWJtr7kzBoRvfVEhC5JLv6r30+F1NZiQl3K456rgTJ0=;
        h=From:Subject:Date:To:Cc:From;
        b=qy97RFNiUK+xBU0kc5rZbXZzxxU8gFN3WkA4k/q3Ibovkes3pbIyUoI9fed8IIKht
         a2QlxMlduromOxfuH37RYg+zaKeKc+Nmxer0UvC6HXkZo6g7O4fJfjXBS8PMNvnXtS
         TC3T5Pj5Z7CGEUZ2I+xVnCoWb178Lrwu+dLhLSyA3iLzfpQBImF5dpDL1SvGB6JorX
         0dEEQqjl+RAtf7Y1deddSwFyfB8UUwA46qSkaql4ThXBNi5ZOMTozab4dz2fO0Fj8a
         g+/xL+6Qjh7FVHksox0IK4NmR1GUEN+UbOPMLoZHGkuTEacHDQAC+KBHE9dy1KgFUI
         hERxo30JzL6WQ==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/3] power: supply: Acer Aspire 1 embedded controller
Date:   Thu, 07 Dec 2023 16:20:13 +0500
Message-Id: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG6qcWUC/x3MQQqAIBBA0avIrBN0BIOuEi0mnWo2JgoRiHdPW
 r7F/w0qF+EKi2pQ+JEqdxqwk4JwUTpZSxwGNOgsGq+pZilsNQftdxcxULA0I4wgFz7k/Wfr1vs
 Hx71oGVwAAAA=
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=NWJtr7kzBoRvfVEhC5JLv6r30+F1NZiQl3K456rgTJ0=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlcaq2nghH4p1eqZEvL3jh3DJvQO6g8ExZyIJrf
 LKhX6L7OBKJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZXGqtgAKCRBDHOzuKBm/
 dYGxD/48x9znuN8PzVFtbY0rZABh0hwZxrDbpGtOG5NBg1R1384jBiTESdVtGz4mY96ckUtXSFv
 IZA97baN1DSRL5+gOU07yZu3wxO6qokDAS8a0ufGxEK1JiZMuxynCxrVrEuB5/oT6/zID0SNC5I
 t+vTeDsia7TJ56L0Em0NiS5m0Z49+GLH8K3T66oOH23XC3w6D/idiV+gQgwg5ITljYOJACXa6m1
 uSeWCt/xnNbeM9pgEaHZtWG7lzfoTCKqbQbBtjhppYHa9S+HyDiK8YbbAutqaZKkTNvb0MyUzzB
 cL83r24lda5VsVsO5x7KOhE37DNi7dYkELljdrG7DCP3C/AQch3Tm/2JDfk7pOMAaKHY5Y6lNut
 2k5JSrJXxbMUcXHFkfTIo3fUkVutQ8ISarZRtCZ6AO9vwXQeyb8nOc+leZoc5uMXatmmrR8YC6F
 R6X+frURlHyVdV0DMW6stbVoNpxgYdmmn96hd9JJ8i/va5wBe9Ejw/49IEK4fEuw7P38ZInN4M8
 WZYWwtWjn5FaD0gXgE92nf9kNMXyl9Y46Uy1L91Wa/BJC08tUlJbg+MZJQT0bg6aI3OqxvBmlcs
 Hc8w23Eli3MxDx5Hiqe/jkMQsehSyotLcSoNlz/lHZ1W+mbkWPkn9KGC/KQUu6CNeHqYXBJEVNp
 c4nptiTCmLNOD2Q==
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

The laptop contains an embedded controller that provides a set of
features:

- Battery and charger monitoring
- USB Type-C DP alt mode HPD monitoring
- Lid status detection
- Small amount of keyboard configuration*

[*] The keyboard is handled by the same EC but it has a dedicated i2c
bus and is already enabled. This port only provides fn key behavior
configuration.

Unfortunately, while all this functionality is implemented in ACPI, it's
currently not possible to use ACPI to boot Linux on such Qualcomm
devices. Thus this series implements and enables a new driver that
provides support for the EC features.

The EC would be one of the last pieces to get almost full support for the
Acer Aspire 1 laptop in the upstream Linux kernel.

This series is similar to the EC driver for Lenovo Yoga C630, proposed
in [1] but seemingly never followed up...

[1] https://lore.kernel.org/all/20230205152809.2233436-1-dmitry.baryshkov@linaro.org/

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Nikita Travkin (3):
      dt-bindings: power: supply: Add Acer Aspire 1 EC
      power: supply: Add Acer Aspire 1 embedded controller driver
      arm64: dts: qcom: acer-aspire1: Add embedded controller

 .../bindings/power/supply/acer,aspire1-ec.yaml     |  73 ++++
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts   |  40 +-
 drivers/power/supply/Kconfig                       |  14 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/acer-aspire1-ec.c             | 432 +++++++++++++++++++++
 5 files changed, 559 insertions(+), 1 deletion(-)
---
base-commit: 8e00ce02066e8f6f1ad5eab49a2ede7bf7a5ef64
change-id: 20231206-aspire1-ec-6b3d2cac1a72

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

