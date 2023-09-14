Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68F7A014C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbjINKK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbjINKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:10:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFA01BE7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:10:52 -0700 (PDT)
X-QQ-mid: bizesmtp80t1694686235tv24onfr
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 18:10:33 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: D2GZf6M6C/jEf5dgdkfxbCYflqBn47liM3u22OICM3qFIgIPe30JgWG0WdUMP
        nzAwwCET4MeQPZtn7NJpNiRKgSuxBj9mFB8uAOuE8SbteXuCMyBqMmEaJELI4A66py1/EfO
        XJuPE8DnDTzcVtNCOReTcSor/gmRd3Q6QIKmLzaWAtuxzo79qaXuHDefWG2U1DSvl9oLglN
        cXRwYQBmbazi8IJRg73ZewaEXX9oJRrozUPmZOXSOAn6yh3dqgZmq59VrTt9fSafFbHBHDO
        Z4+7neDlTrK0toV//xbK7bL/wG6zNdVmnsvhp5YB+NaBgwo3lQHTnb38Yf5iJcw6NfWIfTa
        DIQCuW6fh4C/TvuIOf4WwKYGs2oz+912Rc+osCQe9UVrIojgAUe5Rmip+6f7g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4024459364246311610
From:   Yuan Tan <tanyuan@tinylab.org>
To:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, w@1wt.eu, linux@weissschuh.net,
        tanyuan@tinylab.org
Subject: [PATCH v3 2/3] Kconfig: Add dependencies of POWER_RESET for pmac32
Date:   Thu, 14 Sep 2023 18:10:31 +0800
Message-Id: <0cca5d5afb6c4a1b78648e98339b4b7c9def46d5.1694685860.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694685860.git.tanyuan@tinylab.org>
References: <cover.1694685860.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmac32's power off depends on ADB_CUDA to work. Enable it when
POWER_RESET is set for convenience.

Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/powerpc/platforms/powermac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 130707ec9f99..8bdae0caf21e 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -2,6 +2,7 @@
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
 	depends on PPC_BOOK3S && CPU_BIG_ENDIAN
+	select ADB_CUDA if POWER_RESET && PPC32
 	select MPIC
 	select FORCE_PCI
 	select PPC_INDIRECT_PCI if PPC32
-- 
2.34.1


