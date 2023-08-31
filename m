Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23A678E571
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbjHaEdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjHaEdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:33:12 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0EBC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:33:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5701dbebed5so472462a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693456390; x=1694061190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vDjoTZyY4/cwYnOR6W0LReBlaYCgYLkSvY8zrNZw0tA=;
        b=C5dUUYiR1DiwB/nRTnyuuJnUwEeS5WXrXTEco2C3/P32UPv5SJXKkPsSIyQLrAiuOB
         FgJ4WprQPG+XoZOnY+mTZy6xfa8dG3Gmh9LfgNWDAcKzZGXlghXIrlG7LNVZQoeLwHsf
         N/m2esoc9u7W11amk5lJRQS2uqILgUEXu0lZWATNH5KSCz8l16H/XzT/m3Key7IXNAc9
         VoMBmzyarriTPt3ccZl5yCQR0HGBqJRtq6yF5oEk49RhG7z97C+iqp9qjdCCjAttZTtF
         Mf5oi89rmgYOim4mLG6Xfl24NrcS6Rw98/USm68HJR3k5RdzbiVUPeWPQuQFKSuiUV/Y
         zZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693456390; x=1694061190;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDjoTZyY4/cwYnOR6W0LReBlaYCgYLkSvY8zrNZw0tA=;
        b=XwHtKObM0FhUvhlehzhvdAoWJu9vinAz19XMTShZD/OeGOVYQirEwBF6MF8+v7/lQE
         GMeFdbzjV+gAb7HeqUVgsUGWj3lPwRoNlQnpXhY6J7z0zGGQhtNsI5YsP4YJEdZogoit
         cqazW/u+mZeOZ0HxMsRZmjOl2wj8t1Bvlxi+ScPBJrESIhfhpiWtHtY42ivX8iue/NKz
         PvQod9B8VW0tQ5cTfmCVDNxIppQhq8tsZmmXpP26415+jJBB/2fxLPBEm2us/E6ORlrC
         zV4MJXQL9wEXsMXd/yWbMf9lC+mktuOyWWa/d8OBk9dRhvKLkzltQkidMsp7uQYjS2nk
         986g==
X-Gm-Message-State: AOJu0YydhpV4IBC5QBzOVdIRyLTNjxtEhlRbfrbYhB5zg/cnjbr9kQrH
        nfh8EyIvLOxoAahH8yOGXSQ0MQDIkLgNpJPlKQmkaJsxjORtgww5D0c5rjqtnjbd/sCXIJ3Scgk
        MLcVZZqn84TohyrJrC0p23zjUIIz2cRk123Wl42A/kwT296R0a6unYBH4M7i9XgNoQtNclTfaS6
        w=
X-Google-Smtp-Source: AGHT+IEqQb/kdr4onzMv0+PcFxlisvf7PFahBn7vNXwQFF3OsWVpIrNo/Q7op92kH3zY8xHUuuQcYiKpGwqx9A==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a63:701a:0:b0:569:350a:a690 with SMTP id
 l26-20020a63701a000000b00569350aa690mr527446pgc.1.1693456389580; Wed, 30 Aug
 2023 21:33:09 -0700 (PDT)
Date:   Wed, 30 Aug 2023 21:32:21 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831043228.1194256-1-jmattson@google.com>
Subject: [PATCH] x86/fpu/xstate: Fix PKRU covert channel
From:   Jim Mattson <jmattson@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Tavis Ormandy <taviso@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When XCR0[9] is set, PKRU can be read and written from userspace with
XSAVE and XRSTOR, even when CR4.PKE is clear.

Clear XCR0[9] when protection keys are disabled.

Reported-by: Tavis Ormandy <taviso@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1afbc4866b10..a27b4f7b9365 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -71,7 +71,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_ZMM_Hi256]			= X86_FEATURE_AVX512F,
 	[XFEATURE_Hi16_ZMM]			= X86_FEATURE_AVX512F,
 	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
-	[XFEATURE_PKRU]				= X86_FEATURE_PKU,
+	[XFEATURE_PKRU]				= X86_FEATURE_OSPKE,
 	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
 	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
-- 
2.42.0.283.g2d96d420d3-goog

