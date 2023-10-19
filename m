Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC47D0132
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbjJSSMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbjJSSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:12:24 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AA8121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:12:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so112740831fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739140; x=1698343940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irECxvruaE2IjUyg8ZiPj7VTaWFMYsTQ4MA7HTrIquI=;
        b=R9HDS6jaSLgCZbMbUh57zJSwJMqHY5AxVLHEwoRObE4F4PeR7DaSEGUngo2KqTwACT
         JPYQi9eqKn2/KXTg3Onf+g3eUZE53Ymjeit8wc2mwy4yAoJSgz6J/KOV+uliTIcly6Yd
         nYNC4gb8jOPYIdaiqzSGvyGDV1YRqkFQ67eHZ4Ds8plEBB7nXbeuO1e2ltHUrtecOIaH
         3Rgu7QuU7fKsdclc5EEBxm7UHQ3HVQ2cWM5FGxulKqfHntjwsceTFyBuvpjcHIywwli7
         ZWdvFxJDZLXVjJ9d3jILW+vXasWRYlOq3tZLaymxVo2WKg2ONCDch61M4j4EtTh7H94a
         jlVg==
X-Gm-Message-State: AOJu0YwKUjtM1r3kNiVMCSdxuWBcjLXP65MrjJbnkp1q4L9zxHbNGlXC
        p83xbFJqtwcymiE7GyDc92Q=
X-Google-Smtp-Source: AGHT+IF/Ckb/yDGN/dfY1mNTbBsSOmLdYqe57o+tC0cbF2/Qmct/cj/3nGLv1Hp1YkFF9rfbPv7YZw==
X-Received: by 2002:ac2:599d:0:b0:507:a671:3231 with SMTP id w29-20020ac2599d000000b00507a6713231mr2048308lfn.52.1697739139709;
        Thu, 19 Oct 2023 11:12:19 -0700 (PDT)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id b22-20020a170906709600b009c3828fec06sm3875301ejk.81.2023.10.19.11.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:12:19 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 01/12] x86/bugs: Rename GDS_FORCE_MITIGATION to MITIGATION_GDS_FORCE
Date:   Thu, 19 Oct 2023 11:11:47 -0700
Message-Id: <20231019181158.1982205-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019181158.1982205-1-leitao@debian.org>
References: <20231019181158.1982205-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
index d4a73d12780a..d0a9f5a5c8a4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2566,7 +2566,7 @@ config SLS
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

