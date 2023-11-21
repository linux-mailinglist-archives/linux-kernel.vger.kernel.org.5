Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E647F3487
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjKURJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjKURJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:09:51 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1C12C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:09:45 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso8010405a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586584; x=1701191384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK/o7l9NMuaWGloqnE/Ke+uB0ZlAw9+itU85K74C1+I=;
        b=oYivRNF0IiBUD2Px5cY/ptppFvZxDwlKEjAEh4L3gsh7qNmCuAek9N7gZVcbEoOW1B
         VEto5kmc+60hD+ye77iPk+1LitNkYGf9xy21kvNt+fz5kQah+Q+RNhnQg5nK1TL0z4d/
         lOUgpXd3mp1MlXd2Ef6KZgjQSQ/NXDPkyxaTQqqBd13P2qWpWs5unXu4fi0qmgUjT8dv
         ft7fEh3Tp4/zvgQdA+XAiHCERUPxY7+WSmiiL8iZ/pd+P2Z9LzX/Xrj/Y46RongSxJoP
         +LPkiGZtz+mji4xyyeUzbcvOyUYsuhjvaXpH+d0RjLmekA7uWPkPmlLDfmR4IVfPim/T
         7gdw==
X-Gm-Message-State: AOJu0YyBhoUJAFAZyppQfQ811okd7il4v/2OtllASSaIXgp8mdXpI4Ak
        ej/4H3IWUnKbVLBEDRFe3aA=
X-Google-Smtp-Source: AGHT+IHfUqDMhZjYjsP3S36wQks3a7hvOdjX+piFwkoGElw9gsInbrVOGa/DrrVcd0bCA9W89plzRA==
X-Received: by 2002:a17:906:210:b0:9f7:b852:f807 with SMTP id 16-20020a170906021000b009f7b852f807mr8622733ejd.9.1700586583498;
        Tue, 21 Nov 2023 09:09:43 -0800 (PST)
Received: from localhost (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709063a8b00b009fbdacf9363sm3657533ejd.21.2023.11.21.09.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:09:43 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/13] x86/bugs: Rename GDS_FORCE_MITIGATION to MITIGATION_GDS_FORCE
Date:   Tue, 21 Nov 2023 08:07:28 -0800
Message-Id: <20231121160740.1249350-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU mitigations config entries are inconsistent, and names are hard to
related[1]. There are concrete benefits for both users and developers of
having all the mitigation config options living in the same config
namespace.

The mitigation options should have consistency and start with
MITIGATION.

Rename the Kconfig entry from GDS_FORCE_MITIGATION to
MITIGATION_GDS_FORCE.

[1] Link: https://lore.kernel.org/lkml/20231011044252.42bplzjsam3qsasz@treble/
Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 2 +-
 arch/x86/kernel/cpu/bugs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..ddf0d8bc6db9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2590,7 +2590,7 @@ config SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
-config GDS_FORCE_MITIGATION
+config MITIGATION_GDS_FORCE
 	bool "Force GDS Mitigation"
 	depends on CPU_SUP_INTEL
 	default n
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b91..3c7e27b58f0e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -671,7 +671,7 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-#if IS_ENABLED(CONFIG_GDS_FORCE_MITIGATION)
+#if IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE)
 static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FORCE;
 #else
 static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
-- 
2.34.1

