Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144BD7BC33F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjJGAQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJGAQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:16:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF30BE;
        Fri,  6 Oct 2023 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Tx7VhSKfhB/BAKmLe8z7FqjkSdVa9zklLy9NfKVnpaM=; b=f+UL4dr15vOTP1w1SwnfoGiCm5
        lGei2sZ6q3tI6BzAN9WHqXoXFO3Sjxct/6j8DWHJYVEkOFNvhz5G/oAlnBU+Nq7qNUqEApmf2aeKq
        oY0tW/IbcnopSskKtYrApnqMjP7DaFPeynQyIwI4Ta1I4xWl0wgLZ+2lPMs6k/+krCH7YmYC+B7rS
        qCkbJqGvKHynKP6o82pF4jHHcxPezFUEz6G7Lo/5PVe0r51TECtDTjLpigDW5iPqSOL9XUmH4uxds
        +4Dsx8DquOkl7pQDzo7BVKYqjSuL0xra7nlHr+NbMjlh9Fb4vr1FkkQjKSjHRA37MmEpBGqIHxsor
        OVoonlHA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qouzE-006hCS-21;
        Sat, 07 Oct 2023 00:16:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vaibhav Hiremath <hvaibhav@ti.com>,
        Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>,
        Xunlei Pang <pang.xunlei@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: OMAP: timer32K: fix all kernel-doc warnings
Date:   Fri,  6 Oct 2023 17:16:03 -0700
Message-ID: <20231007001603.24972-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings reported by the kernel test robot:

timer32k.c:186: warning: cannot understand function prototype: 'struct timespec64 persistent_ts; '
timer32k.c:191: warning: Function parameter or member 'ts' not described in 'omap_read_persistent_clock64'
timer32k.c:216: warning: Function parameter or member 'vbase' not described in 'omap_init_clocksource_32k'
timer32k.c:216: warning: Excess function parameter 'pbase' description in 'omap_init_clocksource_32k'
timer32k.c:216: warning: Excess function parameter 'size' description in 'omap_init_clocksource_32k'
timer32k.c:216: warning: No description found for return value of 'omap_init_clocksource_32k'

Fixes: a451570c008b ("ARM: OMAP: 32k counter: Provide y2038-safe omap_read_persistent_clock() replacement")
Fixes: 1fe97c8f6a1d ("ARM: OMAP: Make OMAP clocksource source selection using kernel param")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202310070106.8QSyJOm3-lkp@intel.com/
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Xunlei Pang <pang.xunlei@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-omap1/timer32k.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff -- a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -176,17 +176,18 @@ static u64 notrace omap_32k_read_sched_c
 	return sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
 }
 
+static struct timespec64 persistent_ts;
+static cycles_t cycles;
+static unsigned int persistent_mult, persistent_shift;
+
 /**
  * omap_read_persistent_clock64 -  Return time from a persistent clock.
+ * @ts: &struct timespec64 for the returned time
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
  * nsecs and adds to a monotonically increasing timespec64.
  */
-static struct timespec64 persistent_ts;
-static cycles_t cycles;
-static unsigned int persistent_mult, persistent_shift;
-
 static void omap_read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned long long nsecs;
@@ -206,10 +207,9 @@ static void omap_read_persistent_clock64
 /**
  * omap_init_clocksource_32k - setup and register counter 32k as a
  * kernel clocksource
- * @pbase: base addr of counter_32k module
- * @size: size of counter_32k to map
+ * @vbase: base addr of counter_32k module
  *
- * Returns 0 upon success or negative error code upon failure.
+ * Returns: %0 upon success or negative error code upon failure.
  *
  */
 static int __init omap_init_clocksource_32k(void __iomem *vbase)
