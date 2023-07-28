Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84A5767354
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjG1R3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG1R3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:30 -0400
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 10:29:29 PDT
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DBE35B6;
        Fri, 28 Jul 2023 10:29:29 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 5380B423EA;
        Fri, 28 Jul 2023 22:20:18 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690564821; bh=sly5Ld9FbVW+KuV3/jOurF1zGgRbbBgyAKHydvLe2F0=;
        h=From:Subject:Date:To:Cc:From;
        b=h5gga1uij9+G4EIydWxMgCA48eZC9USCAN1YH54pngMO/L6mFSYOzIMNwI9I6jBEw
         y/EqYH1iEF0oUxEgAtmgdPWeRB3WCpKdn5hBR8iBOaNc7dmurs9IFg95ZYqypikrmZ
         WwpaTZ0Jl6jujRAG47xNKF7cdv7OSfgu2ZEjrO1Qn65zGMaM5gcy1t9bagBADpBW2u
         +lHPyeUNctZAgy6T4aw1o8Eiv3ydZRM1wLcxugfxXHDU//RYCAcDhZvL9s+vAdHHwY
         UHUjWD9IL2ff+P++4ij7drI0RcLihLpCsEX4w6ZyNUBIOKG46RSm06xNcUY3d0ffgS
         ++VHUlAv+uksg==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/4] Add pm8916 VM-BMS and LBC
Date:   Fri, 28 Jul 2023 22:19:29 +0500
Message-Id: <20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKH4w2QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyNz3YJcC0tDM92k3GLdnKRkXeM0CwNjA1NjI7NEIyWgpoKi1LTMCrC
 B0bG1tQBtO/ypYAAAAA==
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=sly5Ld9FbVW+KuV3/jOurF1zGgRbbBgyAKHydvLe2F0=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkw/jPIoA39vFC6JD42KtyRW/tttLijfv8Un9SN
 7zXwiIecpuJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMP4zwAKCRBDHOzuKBm/
 dU1hD/46X6YBSIWGiN+/XspUNixstd2qBtUZiBw0pcQCSghLg5zrbtoBA79jF1tCOmAdmHhAWVD
 h6DZwoUPVfNCfxk+bHfsh2R59cXczV/En2I3SVttRyVTGE91Ic11Otvn8HTtB4sBHJmZwCoWTJN
 Q9bIVu/qTZ1S+9GrfyZaqbK6InHQIBy6F/5g4IuHzPuz5c5MAl3/mk+jJ02owMgiFluAj9/bAkY
 +VVgfSFKLiNLGU9GYyX4XjlfJhTnpTNTqO/xen6BJkrSdBjIoxhSDhg6SbDLh7UZ+Ipe4+Szv5g
 K/8derIyMV5CwB77LFYY69reXcIgPInjpSXoTy3ydscOcZKB4CxSTCc7fwiGWKAvvLmg2tel/vq
 Cy2/zptNTageOri0xmFya5XcsMrPTmcJCKbOQxzPjcK8AW9KjNss6gF3oVG9ufz/kpIf+AGl9C6
 m9Mo5Vf9xWECoPsL5rd88+UiBRgAO6lZdffD+56qaacYhHUCEKa5h0XHMN6+2JOKH2L44kE+X0X
 nsW8kFj/xyEdAEILMpyhEZsL3EwQAttmKZ//IjwLrn2I/iY21+Vq2ba8JlKMXEYDw5uXLkubs6X
 yFdTE30k0XJ9l03LiXAmoe3RIK1jUCQK0UfZFvcf5+qZSCASHnaRvULKKlrjPE+G4qlWaRxXpdI
 OekT+Yp5hMI1ywQ==
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

This series adds charger and "fuel-gauge" found in Qualcomm pm8916 PMIC.

The LBC - Linear Battery Charger is a simple CC/CV charger, that works
autonomously after the current and voltage limits are set.

The VM-BMS - Voltage Mode BMS is a simple hardware block that provides
average voltage on the battery terminals.

These two hardware blocks are used as the battery charging and
management solution in some old Qualcomm devices.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Nikita Travkin (4):
      dt-bindings: power: supply: Add pm8916 VM-BMS
      dt-bindings: power: supply: Add pm8916 LBC
      power: supply: Add pm8916 VM-BMS support
      power: supply: Add driver for pm8916 lbc

 .../bindings/power/supply/qcom,pm8916-bms-vm.yaml  |  64 ++++
 .../bindings/power/supply/qcom,pm8916-lbc.yaml     |  93 +++++
 drivers/power/supply/Kconfig                       |  22 ++
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/pm8916_bms_vm.c               | 296 ++++++++++++++++
 drivers/power/supply/pm8916_lbc.c                  | 385 +++++++++++++++++++++
 6 files changed, 862 insertions(+)
---
base-commit: d7b3af5a77e8d8da28f435f313e069aea5bcf172
change-id: 20230727-pm8916-bms-lbc-3f80305326a2

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

