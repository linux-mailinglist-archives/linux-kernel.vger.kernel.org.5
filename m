Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614487718DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjHGDwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHGDwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:52:35 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89D8C1711;
        Sun,  6 Aug 2023 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=g4CA7
        m71VMHDqI95j4L+UvW9grU0Bka60ctKudFnJRM=; b=jQSF3tYkPu1IELOWopTwp
        S6r557ebZwJSdiRXK7TSw9yNmdwpjIY/mq6sdC1bNmaW5lr5w8qzOlHGErT5RFVd
        xHSFJcEkOMIhOkHiITiYQLfM5ht/OiG8tUc9E6Lzh8szhXsRE0TLlCta4YTwJwn4
        kLM97WGhVjoVsNIC6dt8i0=
Received: from localhost.localdomain (unknown [39.144.137.13])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAnC8nLZtBkztfiCQ--.36380S3;
        Mon, 07 Aug 2023 11:36:47 +0800 (CST)
From:   xingtong_wu@163.com
To:     ilpo.jarvinen@linux.intel.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, xingtong.wu@siemens.com,
        lee@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, gerd.haeussler.ext@siemens.com,
        tobias.schaffner@siemens.com, lkp@intel.com
Subject: [PATCH v2 1/2] platform/x86/siemens: simatic-ipc: fix logic error in BX-59A
Date:   Sat,  1 Aug 2043 01:30:26 +0800
Message-Id: <20430731173026.2631-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20430731173026.2631-1-xingtong_wu@163.com>
References: <7196d4b9-34fe-4a18-863b-65d07c4a348c@linux.intel.com>
 <20430731173026.2631-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnC8nLZtBkztfiCQ--.36380S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy7tw15ur1fJF1rCw48Zwb_yoW8GFW5pF
        4rG3WIkrW5W34Utw1kGay7uFs8Z3Z0krW7G3WUAwnrZwnF9F1jgr17Aa1fXFZrtw45Wa43
        Wa9xtrsrGan8Zr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bnYFAUUUUU=
X-Originating-IP: [39.144.137.13]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/xtbCfgPE0GDcPDRxuAAAsU
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_DATE_IN_FUTURE_Q_PLUS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

The variable "ledmode" is missing from if statement that leads to
a logical error. Add the missing variable to the if condition.

Fixes: b8af77951941 ("platform/x86/siemens: simatic-ipc: add new models BX-56A/BX-59A")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307312322.Aa8upHWK-lkp@intel.com/

Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
---
 drivers/platform/x86/siemens/simatic-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 02c540cf4070..8ca6e277fa03 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -129,7 +129,7 @@ static int register_platform_devices(u32 station_id)
 		pdevname = KBUILD_MODNAME "_leds";
 		if (ledmode == SIMATIC_IPC_DEVICE_127E)
 			pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
-		if (ledmode == SIMATIC_IPC_DEVICE_227G || SIMATIC_IPC_DEVICE_BX_59A)
+		if (ledmode == SIMATIC_IPC_DEVICE_227G || ledmode == SIMATIC_IPC_DEVICE_BX_59A)
 			pdevname = KBUILD_MODNAME "_leds_gpio_f7188x";
 		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
 			pdevname = KBUILD_MODNAME "_leds_gpio_elkhartlake";
-- 
2.25.1

