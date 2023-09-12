Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA1779C15E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjILA5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjILA5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:57:34 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43310CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:42:12 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 6a1803df08f44-655ce9dfae8so29863616d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694479243; x=1695084043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCGSGNbrdqSE84CGd9wFzsbbP6gSE2HdtTlTm4rVY0U=;
        b=o/vOntVQ5dP3h7QmvqIfc37RRLbCMeN/3ttnj3p6lxpphcC4aCudlgFSpR/RNKq352
         7rX1RFhx5YDrxvZOBzWCNBWaxaTV0VMccgIFB7W/JFnyAkHPp1QO3pjEmybF+MeEApLj
         l51+Wqlt/VyqfyYSYi7O5wSOoAyGRPegh+sx8fJZ3heW6CXzn1GtPONe5I8Vo5oq+T4S
         2XC3xUhpbzmEcnr1Nx4vKdw6K7Q8oluqb1yweY8zg8uQjKtouUmGAtUxcSdCIJtzBA8d
         Eqhu+yA6DJ4mhNgTv0Jw1TpJEuqeA3BB40ByY8ZDfloigWqeNY4lgpm+tv5YIs+a5Yn6
         88iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694479243; x=1695084043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCGSGNbrdqSE84CGd9wFzsbbP6gSE2HdtTlTm4rVY0U=;
        b=r15qAtYB3D94TI88D+5WivuVtQtAMX6iiSLYpr/o8U56kKyGBW2lh4mcm+qpSnLMDJ
         wKyU/5JZO44INmb6kaN9ZCvmMib2k4U0oP+BT7HtaQd1TucRcnHDqdZgfVlUpBiptXi9
         XvWuApnf56GrlaY4KzdgZRyKD/xVk3tgprIEapaqNEmNs1jrclz4dsa6aPKhONtLlZhy
         TdMoChCunxJn+ggxi0KJd3vujisfV/ziqfiqeKXXSeWheLDRwzIJ27135yptsh2318js
         Xv+M+pisH5aE2knMClMX54UAfZv2HZ2WCLcrKLX4eRPSHEtS5N+UNZUPLdTa2+Kd6SjQ
         AFCQ==
X-Gm-Message-State: AOJu0YxVu5Lq5X9tZZjNdYOj1EQpG0J9H5b/iKkvjoKl7SSzhNVmbuTm
        27Qnt7837ndiavItLLEyo89xBWHIiFBkrffsfcie6DtYA3t7G17fWjPtuO+RP1SZZI6p9C5HPrV
        G8qBewA2Vswo1xASNZ/WvuJrBjBY4O6TTLBFRoCc6IosrNRg5STaX3V2j0M2b6whKkIOrU9LXUB
        4=
X-Google-Smtp-Source: AGHT+IFYKbe4ZG8QfYS8MJV41+9/oOqY4X/pV+pQy3JrXFYSHCgyqNh7IkTzKbnAJdaTt8hDfAk7bJ2LjLy5jA==
X-Received: from anticipation.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4517])
 (user=acdunlap job=sendgmr) by 2002:a81:7647:0:b0:57a:e0b:f66 with SMTP id
 j7-20020a817647000000b0057a0e0b0f66mr283018ywk.7.1694478432944; Mon, 11 Sep
 2023 17:27:12 -0700 (PDT)
Date:   Mon, 11 Sep 2023 17:27:02 -0700
In-Reply-To: <20230912002703.3924521-1-acdunlap@google.com>
Mime-Version: 1.0
References: <20230912002703.3924521-1-acdunlap@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912002703.3924521-2-acdunlap@google.com>
Subject: [PATCH v2 1/2] x86/sev-es: Allow copy_from_kernel_nofault in earlier boot
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

Previously, if copy_from_kernel_nofault was called before
boot_cpu_data.x86_virt_bits was set up, then it would trigger undefined
behavior due to a shift by 64. This ended up causing boot failures in
the latest version of ubuntu2204 in the gcp project when using SEV-SNP.
Specifically, this function is called during an early #VC handler which
is triggered by a cpuid to check if nx is implemented.

Fixes: 1aa9aa8ee517 ("x86/sev-es: Setup GHCB-based boot #VC handler")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Adam Dunlap <acdunlap@google.com>
---
 arch/x86/mm/maccess.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 5a53c2cc169c..6993f026adec 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -9,12 +9,21 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	unsigned long vaddr = (unsigned long)unsafe_src;
 
 	/*
-	 * Range covering the highest possible canonical userspace address
-	 * as well as non-canonical address range. For the canonical range
-	 * we also need to include the userspace guard page.
+	 * Do not allow userspace addresses.  This disallows
+	 * normal userspace and the userspace guard page:
 	 */
-	return vaddr >= TASK_SIZE_MAX + PAGE_SIZE &&
-	       __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
+	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
+		return false;
+
+	/*
+	 * Allow everything during early boot before 'x86_virt_bits'
+	 * is initialized.  Needed for instruction decoding in early
+	 * exception handlers.
+	 */
+	if (!boot_cpu_data.x86_virt_bits)
+		return true;
+
+	return __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
 }
 #else
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
-- 
2.42.0.283.g2d96d420d3-goog

