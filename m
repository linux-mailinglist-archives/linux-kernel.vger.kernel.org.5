Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD40377517A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHIDmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHIDmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:42:11 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 799BF172C;
        Tue,  8 Aug 2023 20:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=U4aESHDWnOOY4B1K7coviuwawbJUk9M0t/Gl5undU/s=;
        b=HYt0QAYddg5N0rr2oiovLdUTuSU04+DdWmcjw4mgnjheEbwXPQB0DjG7KzOcO0
        adSXdoW6+6Qn2EGIumq7X9fyRI+CyK8FwHMFazRKpRocNWbUEoYJ60M566zJpiBT
        JXjXdRf/ZSaGfms33ptBfOMSxk/S1XfGYNCNypp5ref+I=
Received: from localhost.localdomain (unknown [39.144.137.205])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wAHzaXvCtNkLjZuCg--.12136S3;
        Wed, 09 Aug 2023 11:41:38 +0800 (CST)
From:   xingtong_wu@163.com
To:     andriy.shevchenko@linux.intel.com
Cc:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, xingtong.wu@siemens.com, lee@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        lkp@intel.com
Subject: [PATCH v3 1/2] platform/x86/siemens: simatic-ipc: fix logical error for BX-59A
Date:   Mon,  3 Aug 2043 01:35:15 +0800
Message-Id: <20430802173515.2363-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20430802173515.2363-1-xingtong_wu@163.com>
References: <ZNEUHo0fR280O4mN@smile.fi.intel.com>
 <20430802173515.2363-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHzaXvCtNkLjZuCg--.12136S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy7tw15ur1kXF15WryfJFb_yoW8XryDpF
        4rG3WIkrW5WryUtw1DGayxZFs8Z3Z0kry7G3WUAwnrZwnruF1jgr12kF4fXa9rtw45Wa43
        Wa9xtr47Gan8Zr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bnYFAUUUUU=
X-Originating-IP: [39.144.137.205]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiTBbG0GI0aYaeCAAAsj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_DATE_IN_FUTURE_Q_PLUS autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

