Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5987A2807
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjIOUYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbjIOUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:24:37 -0400
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com [IPv6:2001:41d0:203:375::de])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625BAC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:24:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694809469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HhO0fARHYTVnnnWrkFJbqtYB56vbPZIYfQYFzRPNwsA=;
        b=BYn1DT4bPQES8mACOme2J4eyoHo90mHrEAaaYCzc13OttcUO/PAP5w0ifQe6CEhbR5ARhd
        YzSatPoUpaEcbjwIiEVdVPEIpvImOoUxLtMwp4xLHbGyk8YwTRO3j2IShQ7gyiiNfr5fB6
        xsdi5+O1R33BWq8eSEWwB9vluXK2Yvo=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Raghavendra Rao Ananta <rananta@google.com>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH] MAINTAINERS: Use wildcard pattern for ARM PMU headers
Date:   Fri, 15 Sep 2023 20:24:21 +0000
Message-ID: <20230915202421.2706446-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like arm_pmuv3.h isn't caught by the ARM PMU maintainers entry.
Fix it with a wildcard.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..5b1a9f9d98b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1662,7 +1662,7 @@ F:	arch/arm*/include/asm/perf_event.h
 F:	arch/arm*/kernel/hw_breakpoint.c
 F:	arch/arm*/kernel/perf_*
 F:	drivers/perf/
-F:	include/linux/perf/arm_pmu.h
+F:	include/linux/perf/arm_pmu*.h
 
 ARM PORT
 M:	Russell King <linux@armlinux.org.uk>
-- 
2.42.0.459.ge4e396fd5e-goog

