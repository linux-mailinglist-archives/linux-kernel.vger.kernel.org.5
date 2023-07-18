Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E37571A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGRCNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGRCNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:13:11 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 19:13:07 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2C610CC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:13:07 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202307180212037bc85e03ecb0acbf1f
        for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 04:12:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=eTtFH6HCeBJOa/yUObvyHtwj0PDScIS3TxthR2Qintg=;
 b=dAtQCIZcnxrOypHaqI18cxbZQzkVqDQuFI11h15LmCUVnr8tRoZe8SG0/1zvqeRYtjlf8M
 NIW3w1Rrh43uFtfBkLozgXgjT5K4F3d69IF4pq0eO0upXJ3RM/2bBGlIuzDbrl9gIeAzTsR+
 QPR3sBz+F2mOtr91Dbs1btnhAbVo0=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH v6 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Date:   Tue, 18 Jul 2023 10:10:04 +0800
Message-Id: <20230718021007.1338761-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Hua Qian <huaqian.li@siemens.com>

The watchdog hardware of TI AM65X platform does not support
WDIOF_CARDRESET feature, add a reserved memory to save the watchdog
reset cause, to know if the board reboot is due to a watchdog reset.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
Changes in v6:
- Integrate example with the existing binding.
- Link to v5:
  https://lore.kernel.org/linux-watchdog/20230717064124.1315746-1-huaqian.li@siemens.com

Changes in v5:
- Corret the `Reviewed-by` info.
- Link to v4:
  https://lore.kernel.org/linux-watchdog/20230717040723.1306374-1-huaqian.li@siemens.com

Changes in v4:
- Fix the coding style.
- Add usage note for the reserved memory.
- Link to v3:
  https://lore.kernel.org/linux-watchdog/20230713095127.1230109-1-huaqian.li@siemens.com

Changes in v3:
- Add memory-region back for the reserved memory, and remove reserved
  memory from the watchdog IO address space.
- Add changelog.
- Link to v2:
  https://lore.kernel.org/linux-watchdog/20230711091713.1113010-1-huaqian.li@siemens.com

Changes in v2:
- Remove memory-region and memory-size properties, and bind the reserved
  memory to watchdog IO address space.
- Remove the unnecessary rti_wdt_ioctl.
- Fix the mail list
- Link to v1:
  https://lore.kernel.org/all/3137d87e56ef75ba0b8a923d407b2fecace6ccbd.camel@siemens.com
  v1 had a wrong mail list at the beginning, and the mail thread was
  messed up.

Li Hua Qian (3):
  dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
  arm64: dts: ti: Add reserved memory for watchdog
  watchdog:rit_wdt: Add support for WDIOF_CARDRESET

 .../bindings/watchdog/ti,rti-wdt.yaml         | 28 ++++++++++-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 10 ++++
 drivers/watchdog/rti_wdt.c                    | 48 +++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)

-- 
2.34.1

