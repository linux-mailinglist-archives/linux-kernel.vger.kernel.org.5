Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63EA79C175
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjILBMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjILBMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:12:30 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781AB1BBB84
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:07:58 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-57386ed9591so4491573eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694480783; x=1695085583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=970Kku1qrn40V4eSbXmIGisrwVrsufYlhNF3TpQZHgw=;
        b=0e3TA+GKd09JBTGRan9gVhMoCscjxhAD5nqM5c+bTD16/i2Ebwysr/C4lrMflSb58A
         dkeQrw3wCTm4qy+/OMjQbe2fSCZPOAKJfvHU2l2NyG8SPngz92HBIBcyTA+RmfQ8Gc5F
         4+KgYYrwVO/C5MKqQ/GnuFehU/oAYDagZl7pcRZ6BwR2BjO8iU34IZqxBgitw25Rbv+O
         O4D/Vp3GRGiHcyuqbn/PqdNjs5RHlUZd8rD5xssjC3N6jc4HWu3p40l8KRMXxYzFo1sA
         LGmnAOUAQQltvYj7r40YE8RB2oMbJIOiB6KBZyE0ZZl3ltc3AS+/mzz+ETLyX7Xxu0bl
         l9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694480783; x=1695085583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=970Kku1qrn40V4eSbXmIGisrwVrsufYlhNF3TpQZHgw=;
        b=KZhcBtju+tCN3l4m/8FqlBvSZZoNWEqOx8tZX+JulpfZ9mkL1mSapJD03EAXQD20sX
         Jx5tM9P/Q6AsRzUp2pXiqAqfm955jRGRfI4NaRowYwO1fNEoNWPjgzfXy36viuC+NVJy
         EKvUm0XKOW4YhCX7HMVmLluIBPZV+PXlyZdoimdRp9weBjOIh8UEBz4kL8v7S5hwp+Mz
         UAkqYApeUqVroXx5N+ovm5pOV9QRtQyZGGaCtbcEWJRkw4ICSkD016E52tt1c+xn0yGE
         nvKqYnYbJ6iTXoZb46ZNlwWOWGmE0A+Kczlxlio5DYnGYlaPykve/dPWjXqjSwkK0Pen
         T66Q==
X-Gm-Message-State: AOJu0Yy2yWLurm1vPsY/yG8dE9HhpYvdGvB50wB4lB6kIY3aFzFtMrUj
        Q8RAgF7QAiiSnfTeUUHf9aUkXoZkUXTIamqOvHvNEI8TrFUGc6zEhFXl6v4VO8T+6vKuW/gC7i8
        9i+WIaBVUl3YQ7RT/brTlVXgaTul/A/bz/MCEHcYeAY9bEOFgKcR2jgYHeQc2etFbnp/idpQZnD
        0=
X-Google-Smtp-Source: AGHT+IEr0R08qR8kalzBxDgPPVM2noCXXmz7bdyUG4nmBOjnaN2Ch4elJYHwNYuQzDOaTQT/W4YsMzvQunWueg==
X-Received: from anticipation.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4517])
 (user=acdunlap job=sendgmr) by 2002:a17:902:eb8e:b0:1bd:c6e9:e257 with SMTP
 id q14-20020a170902eb8e00b001bdc6e9e257mr265952plg.1.1694478434443; Mon, 11
 Sep 2023 17:27:14 -0700 (PDT)
Date:   Mon, 11 Sep 2023 17:27:03 -0700
In-Reply-To: <20230912002703.3924521-1-acdunlap@google.com>
Mime-Version: 1.0
References: <20230912002703.3924521-1-acdunlap@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912002703.3924521-3-acdunlap@google.com>
Subject: [PATCH v2 2/2] x86/sev-es: Only set x86_virt_bits to correct value
From:   Adam Dunlap <acdunlap@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Adam Dunlap <acdunlap@google.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>,
        David Rientjes <rientjes@google.com>,
        Khalid ElMously <khalid.elmously@canonical.com>,
        Jacob Xu <jacobhxu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of setting x86_virt_bits to a possibly-correct value and then
correcting it later, do all the necessary checks before setting it.

At this point, the #VC handler references boot_cpu_data.x86_virt_bits,
and in the previous version, it would be triggered by the cpuids between
the point at which it is set to 48 and when it is set to the correct
value.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Adam Dunlap <acdunlap@google.com>
---
 arch/x86/kernel/cpu/common.c | 37 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 52683fddafaf..23888d3da16f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1099,17 +1099,32 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
+	bool vp_bits_from_cpuid = true;
 
-	if (c->extended_cpuid_level >= 0x80000008) {
+	if (!cpu_has(c, X86_FEATURE_CPUID) ||
+	    (c->extended_cpuid_level < 0x80000008))
+		vp_bits_from_cpuid = false;
+
+	if (vp_bits_from_cpuid) {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
 
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
+	} else {
+		if (IS_ENABLED(CONFIG_X86_64)) {
+			c->x86_clflush_size = 64;
+			c->x86_phys_bits = 36;
+			c->x86_virt_bits = 48;
+		} else {
+			c->x86_clflush_size = 32;
+			c->x86_virt_bits = 32;
+			c->x86_phys_bits = 32;
+
+			if (cpu_has(c, X86_FEATURE_PAE) ||
+			    cpu_has(c, X86_FEATURE_PSE36))
+				c->x86_phys_bits = 36;
+		}
 	}
-#ifdef CONFIG_X86_32
-	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
-		c->x86_phys_bits = 36;
-#endif
 	c->x86_cache_bits = c->x86_phys_bits;
 }
 
@@ -1539,15 +1554,6 @@ static void __init cpu_parse_early_param(void)
  */
 static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_64
-	c->x86_clflush_size = 64;
-	c->x86_phys_bits = 36;
-	c->x86_virt_bits = 48;
-#else
-	c->x86_clflush_size = 32;
-	c->x86_phys_bits = 32;
-	c->x86_virt_bits = 32;
-#endif
 	c->x86_cache_alignment = c->x86_clflush_size;
 
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
@@ -1561,7 +1567,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
-		get_cpu_address_sizes(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 		cpu_parse_early_param();
 
@@ -1577,6 +1582,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
 	}
 
+	get_cpu_address_sizes(c);
+
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
 	cpu_set_bug_bits(c);
-- 
2.42.0.283.g2d96d420d3-goog

