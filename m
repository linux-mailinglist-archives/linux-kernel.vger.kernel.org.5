Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6E7D95D0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjJ0K7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0K7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:59:34 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 03:59:30 PDT
Received: from mail-sh.amlogic.com (unknown [58.32.228.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BBF9C;
        Fri, 27 Oct 2023 03:59:30 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 27 Oct 2023
 18:44:25 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>
CC:     <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH V3 0/3] Add watchdog support for Amlogic C3 and S4 SoCs
Date:   Fri, 27 Oct 2023 18:43:55 +0800
Message-ID: <20231027104358.342861-1-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_FAIL,SPF_HELO_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic C3 and S4 has the same watchdog controller as Amlogic T7.

Changes since V2 [2]:
- Modified yaml document to ensure that dtbs_check passes.
- Added a patch for watchdog support for S4.

Changes since V1 [1]:
- Added C3 compatibles, with T7 compatibles list as fallback.

[1]: https://lore.kernel.org/all/20230925090641.1185942-1-huqiang.qin@amlogic.com/
[2]: https://lore.kernel.org/all/20230926055512.2355390-1-huqiang.qin@amlogic.com/

Huqiang Qin (3):
  dt-bindings: watchdog: Add support for Amlogic C3 and S4 SoCs
  arm64: dts: Add watchdog node for Amlogic C3 SoCs
  arm64: dts: Add watchdog node for Amlogic S4 SoCs

 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml    | 12 +++++++++---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi          |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi            |  6 ++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.42.0

