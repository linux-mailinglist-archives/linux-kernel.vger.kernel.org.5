Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C027769E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjHIUYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjHIUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:24:01 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D472107
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691612640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cVuXNyNnWGxRua66OAyu/4nmoIo5olkZ3i2J9ieXVKM=;
  b=LLR3De9vQxrobYbt67FN1HF7d2jS6xGAcJWH4f9+nX+Yb2BxTLWiCmK7
   ROlUnkwfmrO7tHxvQj1NDviRIr4OaVjwXWz3i/XKFy+WJTCivzFZdEN5W
   ydMVEqvVVIc7ET+w9ANZz9npXYiS7O6Ca4qqF8htnvZWq6GNdIH78Ga9/
   g=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 119472773
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:hkLlba4VsOaWgSCRxq3L4wxRtLbHchMFZxGqfqrLsTDasY5as4F+v
 mNJUGnUO6mIZGv8fowlO4u2oEkC7cWBndNnTgU6+3g8Hi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9lU35ZwehBtC5gZlPaAT7QeF/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m7
 McCJB5Wbze5t+Pm/JuKZ+B2ms97BZy+VG8fkikIITDxCP8nRdbIQrnQ5M8e1zA17ixMNa+AP
 YxDM2MpNUmeJUQVYT/7C7pn9AusrlD5fydVtxS+oq0v7nKI5AdwzKLsIJzefdniqcB9xx/J+
 j2coDuiav0cHMfDlgG30lj9v+rKxwPUY4ksPZufpsc/1TV/wURMUUZLBDNXu8KRjk+4RsIaK
 EEO/CcqhbY9+VbtTdTnWRC85nmesXY0UcJ4Guk75QfdjKbZiy6FAXIaRzpNc/QitckrVXkk0
 UKPk9r1BDtp9rqPRhq16riQvRu2OC4IMXUFYy4UCwcIi/HmoYc8iTrVQ9pjGbLzhdrwcRn8y
 i6H6ig3ga4ei+YP1qOm7RbGhS6hot7CSQtdzgXPV0q3/x9+fsiuYInAwUiLs95DIZyfQ13Hu
 2IL8/Vy98hXU8vLznbUBrxQQvfwva3t3CDgbUBHBqI7+xr2+lmZTYEA3BhPCU5zLs1cUGq8C
 KPMgj956JhWNXqsSKZ4ZYOtFsgnpZTd+cTZuuP8NYQXPMUoHOOT1GQ3PBPLgTix+KQ5uftnU
 ap3Z/pAGprz5U5P6DOtD9kQ3rYwrszV7TOCHMurp/hLPFf3WZJ0dVvnGAHVBgzaxPneyOkwz
 zq5H5HSo/m4eLOWX8Uv2dRPRW3m1FBibXwMl+RZd/SYPi1tE3w7BvnazNsJItI0xvoNy7eXr
 iztCye0LWYTY1WdeW1mjVg5MtvSsWtX9ypnbUTAw373s5TcXWpfxPhGLMZmFVXW3Odi0eR1X
 5E4lzaoW5xypsD8021FN/HV9dUyHClHcCrSZ0JJlhBjJc8/L+EIk/e4FjbSGN4mVHrq65Zm/
 ePIO8GyacNrejmOxf3+MJqHp25dd1BH8A6udyMk+uVuRXg=
IronPort-HdrOrdr: A9a23:v83t2qACPyNTAmzlHelc55DYdb4zR+YMi2TDt3oddfWaSKylfq
 GV7ZAmPHrP4gr5N0tOpTntAse9qBDnhPtICOsqTNSftWDd0QPFEGgL1+DfKlbbak/DH4BmtJ
 uICJIOb+EZDTJB/LrHCAvTKade/DFQmprY+9s3zB1WPHBXg7kL1XYeNu4CeHcGPjWvA/ACZe
 Ohz/sCnRWMU1INYP+2A3EUNtKz2uEixPrdEGY77wdM0nj0sQ+V
X-Talos-CUID: 9a23:+7rWa2OR0YwzGu5DQRJ9+GBPG+cfQnyN8F7hDkaiFW0xYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AoWtUgwyibxzvOK+EA5aIzWjrvCWaqL/yV3s/sb9?=
 =?us-ascii?q?XgsyBbwxfADyjpRKQErZyfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.01,160,1684814400"; 
   d="scan'208";a="119472773"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>
Subject: [PATCH] x86/AMD: Fix ASM constraints in amd_clear_divider()
Date:   Wed, 9 Aug 2023 21:23:56 +0100
Message-ID: <20230809202356.357339-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIV writes its results into %eax and %edx, meaning that they need to be output
constraints too.  It happens to be benign in this case as the registers don't
change value, but the compiler should still know.

Fixes: 77245f1c3c64 ("x86/CPU/AMD: Do not leak quotient data after a division by 0")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Borislav Petkov <bp@alien8.de>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/cpu/amd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b55d8f82b621..8585a4be1912 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1325,6 +1325,8 @@ bool cpu_has_ibpb_brtype_microcode(void)
  */
 void noinstr amd_clear_divider(void)
 {
+	unsigned int a = 0, d = 0;
+
 	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
-		     :: "a" (0), "d" (0), "r" (1));
+		     : "+a" (a), "+d" (d) : "r" (1));
 }

base-commit: cacc6e22932f373a91d7be55a9b992dc77f4c59b
-- 
2.30.2

