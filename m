Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E859B7BE455
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376932AbjJIPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377024AbjJIPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:14:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3101B4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:14:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53636f98538so8080056a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696864465; x=1697469265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMTmr6sptoCQlqK3x/0ZICFaKI2zNpbKV1fPXU/Ez2g=;
        b=MQodk1T2pEIFYZ7tUCC4D1G3Zvmt2MnLVWPBnvafFXXxtPy8mjQed7dSOj3n2iIPXK
         c5fSG0+TBgbDW+oC44KEoDkWn7ee9wBuCU3z0tUp8QoUOdFMPe2ETbr3JbH/hj6GSLui
         nGdlcFBjEOczWqdzpNCrOzAHXfhN/ESBui1EU4fD3gmHFwO4IOd7z+tBetiq3IWZwQjT
         w1TQNkdulgbolgUHGuiXwI7PDeSNhGehZzrOMvCSwWvMboCh4dU1fZ/mLObmLd0EbyIE
         K5mL03ttkq/cHrnujUMksv5OLuuRXMsMVg/3J16KX5p3xpNuWvs6VFJ60VLOmSLRA5VM
         1SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864465; x=1697469265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMTmr6sptoCQlqK3x/0ZICFaKI2zNpbKV1fPXU/Ez2g=;
        b=wXTBiFjkdq6FjCay1tm3y1eiHrAXv7YoNKpjW7WlO8tm5S6GMc2TesQ7ifJWsOO0Gq
         Zc/Hd3t1UOQrsPU5mmrCcAIyF8PuGITei93gf6OVTCePE8SDGXwENN3t1cPq5pwAbus1
         4bB+PNecIH5zjaBdoPSpq5oAZ5omqOb8pyzYKeIIMpyJBBbuIXHHbu4TfzFIsljWETjK
         n1zFWTF6z2RreY1+dMjXhCJ8mB4r4UbHxnUrTyIapZvC7AwiicCUlRLIEZToniGd+CZy
         vs8VRUDIMIueL8VLvpmAVLYimwbkolcIIxNkzAJ2Y0gAr/XvuR1KYBpf+Uk0xV2Lw2PS
         M6jw==
X-Gm-Message-State: AOJu0Yzl8rGDBfZwCV/8dJp/s6z1ogLPl3HDTkOF/sbQOCkWOpGmDL7M
        516Qnsx1qRj2Ysne0180Hes=
X-Google-Smtp-Source: AGHT+IEHh2B8gerGrntmQ/LkrkrTLBJXTi6ay2BvABSRxW3ek7SLAAK24wdU0LO2/Ez42Fxfgjc4jw==
X-Received: by 2002:a05:6402:2031:b0:52b:d169:b37a with SMTP id ay17-20020a056402203100b0052bd169b37amr14462978edb.28.1696864464692;
        Mon, 09 Oct 2023 08:14:24 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7d652000000b00533dad8a9c5sm6224009edr.38.2023.10.09.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:14:24 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH tip] x86/percpu: Disable named address spaces for KASAN
Date:   Mon,  9 Oct 2023 17:13:48 +0200
Message-ID: <20231009151409.53656-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-fsanitize=kernel-address (KASAN) is at the moment incompatible
with named address spaces - see GCC PR sanitizer/111736.

GCC is doing a KASAN check on a percpu address which it shouldn't do,
and didn't used to do because we did the access using inline asm.

But now that GCC does the accesses as normal (albeit special address
space) memory accesses, the KASAN code triggers on them too, and it
all goes to hell in a handbasket very quickly.

Those percpu accessor functions need to disable any KASAN
checking or other sanitizer checking. Not on the percpu address,
because that's not a "real" address, it's obviously just the offset
from the segment register.

And GCC should probably not have generated such code in the first
place, so arguably this is a bug with -fsanitize=kernel-address.

The patch also removes a stale dependency on CONFIG_SMP.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310071301.a5113890-oliver.sang@intel.com
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ecb256954351..54e79d3061f9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2393,7 +2393,12 @@ config CC_HAS_NAMED_AS
 
 config USE_X86_SEG_SUPPORT
 	def_bool y
-	depends on CC_HAS_NAMED_AS && SMP
+	depends on CC_HAS_NAMED_AS
+	#
+	# -fsanitize=kernel-address (KASAN) is at the moment incompatible
+	# with named address spaces - see GCC PR sanitizer/111736.
+	#
+	depends on !KASAN
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
-- 
2.41.0

