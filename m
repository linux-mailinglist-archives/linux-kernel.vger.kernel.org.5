Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3A7718D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjHGDlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHGDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:41:17 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2DE8AD;
        Sun,  6 Aug 2023 20:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/v5lH
        CD4095ylXk3bIxsvLNqIL1BFCOYqFMwytNhM6k=; b=NaG1GOsHPYcKybDV3dMho
        ZzbxEKI8Vs7B7eKbdGdx20AmAXYQo8Hko23IOACnr+zg60WEMgjwWgV0uTeifAcM
        NWDK//Dy4Qwt2uq8RDlbJtI925419N2RW9DQn4GTImJdKbH1OqUHCC/hFP8YqTgl
        bknm6Mpp6aDSeM/q3c/5pk=
Received: from localhost.localdomain (unknown [39.144.137.13])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3EpCyZ9BkgCbcCQ--.7851S2;
        Mon, 07 Aug 2023 11:40:35 +0800 (CST)
From:   xingtong_wu@163.com
To:     ilpo.jarvinen@linux.intel.com
Cc:     hdegoede@redhat.com, markgross@kernel.org, xingtong.wu@siemens.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        lkp@intel.com
Subject: [PATCH v2 2/2] platform/x86/siemens: simatic-ipc-batt: fix logic error for BX-59A
Date:   Sat,  1 Aug 2043 01:34:17 +0800
Message-Id: <20430731173417.2692-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d41d3ae3-9c1b-661-4664-51d62ad1d786@linux.intel.com>
References: <d41d3ae3-9c1b-661-4664-51d62ad1d786@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3EpCyZ9BkgCbcCQ--.7851S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWrtFW7CFyrur1rKFWkCrg_yoW8GFWUpF
        4rXa10kFW3Gw15tw4DGay7Zr45Za15KrW7GFyqyw13Z3sFv3ZxKr13Aa13ZFsIyr45Way5
        J3Z3trZrCa1DZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jReHDUUUUU=
X-Originating-IP: [39.144.137.13]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbBEBbE0GNfugX+sgAAsd
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_DATE_IN_FUTURE_Q_PLUS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

The variable "priv.devmode" is missing from if statement that leads
to a logical error. Add the missing variable to the if condition.

Fixes: c56beff20375 ("platform/x86/siemens: simatic-ipc-batt: add support for module BX-59A")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308010001.BGYCSQrl-lkp@intel.com/

Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
---
 drivers/platform/x86/siemens/simatic-ipc-batt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
index d66b9969234b..e6c12c52843c 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
@@ -194,7 +194,8 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
 
 	if (table->table[2].key) {
 		flags = GPIOD_OUT_HIGH;
-		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A || SIMATIC_IPC_DEVICE_BX_59A)
+		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A ||
+		    priv.devmode == SIMATIC_IPC_DEVICE_BX_59A)
 			flags = GPIOD_OUT_LOW;
 		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, flags);
 		if (IS_ERR(priv.gpios[2])) {
-- 
2.25.1

