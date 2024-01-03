Return-Path: <linux-kernel+bounces-14998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F08225F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152D7B227B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555CC812;
	Wed,  3 Jan 2024 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZk2/sZf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE762A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6d9c7de0620so4819720b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704241811; x=1704846611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDHMClrrYcWpmzuNGOOsVgi0AHu5ZiLUhnNFQeXTWPg=;
        b=lZk2/sZf4KRXjxiAbnUItfawfp9DfgjfQ3OAnp0JRR8LztaIF0wdC7ttSexv/oZ1LW
         qHA+nuu+Wl7Q4CyvQ6pLt3piiDAxBPnSGPo3e0nHPhCBb5yvFZ0kGb7MTvRn2LECDi3M
         xSjJn17bmNbsL7g1163sLS3ub33bghO3s/WI0J2ElLBmyMCk2WmSDhJactnk6C+YB151
         qUt8r4cRYW31H6N18XkFiuIgZSGI0VTa6g1JcTOmEBa9TzBOm3ud9UN1Lu0uSNJPPZgV
         +Llo26ZSE7Sq2z7eRSzhZCxi+hQNFbaCF6lOsB/u2mxMar3577WZCaFqaYHPIWKlDnCF
         vCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704241811; x=1704846611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDHMClrrYcWpmzuNGOOsVgi0AHu5ZiLUhnNFQeXTWPg=;
        b=YK3/Qpl/cOXpiQEyC8qpD+v+zDo7E9DsgWsC6ep78sNx69/1I9BBB5OAZ7M0NhhocA
         L0o/+W0QEBaMpyQQrQ5EjxrotB3ZWLL1QZAYeb3LEtaK2ewJO+mRJjFj9rAOUPA2K7AV
         od0MyZmjpR5EzcXHGFFzDXBZaSS22X7AKmblkaE802zinsjbP0R0mhVAcewsuGblpFs4
         AIcAGZn1FK1XBjeJ49iEtofy6gu5eN5ne4iJG8kv3p/AIgjevgFparT7hj/8mbCVqWcK
         aWgkXED+JcQNrBXDSec2yA1szvI0T0ZCCeBCMBs/yn4u6OSrgEKISnDXz3628ipK7Jle
         d3xg==
X-Gm-Message-State: AOJu0Yw1COpvuBFj/RzdpIOZ63GijksX3kNP/iyxR+bSQuej/tuIQeWl
	6I7qmxDCPcHgW7h0oNmqKgWewKbwSER7sy5xKA==
X-Google-Smtp-Source: AGHT+IFNrhvfNpEZWbUBRvHPmZg3lwRXupu1adc7E3n9IpEip0cPg1xuPurkZ1lMjOAr5qzmwnsM4j877ko=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9297:b0:6d9:bcaf:5f16 with SMTP id
 jw23-20020a056a00929700b006d9bcaf5f16mr40479pfb.3.1704241811632; Tue, 02 Jan
 2024 16:30:11 -0800 (PST)
Date: Tue, 2 Jan 2024 16:30:10 -0800
In-Reply-To: <20240102232136.38778-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240102232136.38778-1-Ashish.Kalra@amd.com>
Message-ID: <ZZSqkm5WNEUuuA_h@google.com>
Subject: Re: [PATCH] x86/sev: Add support for allowing zero SEV ASIDs.
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	thomas.lendacky@amd.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joro@8bytes.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 02, 2024, Ashish Kalra wrote:
> @@ -2172,8 +2176,10 @@ void sev_vm_destroy(struct kvm *kvm)
>  
>  void __init sev_set_cpu_caps(void)
>  {
> -	if (!sev_enabled)
> +	if (!sev_guests_enabled) {

Ugh, what a mess.  The module param will show sev_enabled=false, but the caps
and CPUID will show SEV=true.

And this is doubly silly because "sev_enabled" is never actually checked, e.g.
if misc cgroup support is disabled, KVM_SEV_INIT will try to reclaim ASIDs and
eventually fail with -EBUSY, which is super confusing to users.

The other weirdness is that KVM can cause sev_enabled=false && sev_es_enabled=true,
but if *userspace* sets sev_enabled=false then sev_es_enabled is also forced off.

In other words, the least awful option seems to be to keep sev_enabled true :-(

>  		kvm_cpu_cap_clear(X86_FEATURE_SEV);
> +		return;

This is blatantly wrong, as it can result in KVM advertising SEV-ES if SEV is
disabled by the user.

> +	}
>  	if (!sev_es_enabled)
>  		kvm_cpu_cap_clear(X86_FEATURE_SEV_ES);
>  }
> @@ -2229,9 +2235,11 @@ void __init sev_hardware_setup(void)
>  		goto out;
>  	}
>  
> -	sev_asid_count = max_sev_asid - min_sev_asid + 1;
> -	WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count));
> -	sev_supported = true;
> +	if (min_sev_asid <= max_sev_asid) {
> +		sev_asid_count = max_sev_asid - min_sev_asid + 1;
> +		WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count));
> +		sev_supported = true;
> +	}
>  
>  	/* SEV-ES support requested? */
>  	if (!sev_es_enabled)
> @@ -2262,7 +2270,8 @@ void __init sev_hardware_setup(void)
>  	if (boot_cpu_has(X86_FEATURE_SEV))
>  		pr_info("SEV %s (ASIDs %u - %u)\n",
>  			sev_supported ? "enabled" : "disabled",
> -			min_sev_asid, max_sev_asid);
> +			sev_supported ? min_sev_asid : 0,
> +			sev_supported ? max_sev_asid : 0);

I honestly think we should print the "garbage" values.  The whole point of
printing the min/max SEV ASIDs was to help users understand why SEV is disabled,
i.e. printing zeroes is counterproductive.

>  	if (boot_cpu_has(X86_FEATURE_SEV_ES))
>  		pr_info("SEV-ES %s (ASIDs %u - %u)\n",
>  			sev_es_supported ? "enabled" : "disabled",

It's all a bit gross, but I think we want something like this (I'm definitely
open to suggestions though):

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d0c580607f00..bfac6d17462a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -143,8 +143,20 @@ static void sev_misc_cg_uncharge(struct kvm_sev_info *sev)
 
 static int sev_asid_new(struct kvm_sev_info *sev)
 {
-       int asid, min_asid, max_asid, ret;
+       /*
+        * SEV-enabled guests must use asid from min_sev_asid to max_sev_asid.
+        * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.  Note, the
+        * min ASID can end up larger than the max if basic SEV support is
+        * effectively disabled by disallowing use of ASIDs for SEV guests.
+        */
+       unsigned int min_asid = sev->es_active ? 1 : min_sev_asid;
+       unsigned int max_asid = sev->es_active ? min_sev_asid - 1 : max_sev_asid;
+       unsigned int asid;
        bool retry = true;
+       int ret;
+
+       if (min_asid > max_asid)
+               return -ENOTTY;
 
        WARN_ON(sev->misc_cg);
        sev->misc_cg = get_current_misc_cg();
@@ -157,12 +169,6 @@ static int sev_asid_new(struct kvm_sev_info *sev)
 
        mutex_lock(&sev_bitmap_lock);
 
-       /*
-        * SEV-enabled guests must use asid from min_sev_asid to max_sev_asid.
-        * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.
-        */
-       min_asid = sev->es_active ? 1 : min_sev_asid;
-       max_asid = sev->es_active ? min_sev_asid - 1 : max_sev_asid;
 again:
        asid = find_next_zero_bit(sev_asid_bitmap, max_asid + 1, min_asid);
        if (asid > max_asid) {
@@ -2232,8 +2238,10 @@ void __init sev_hardware_setup(void)
                goto out;
        }
 
-       sev_asid_count = max_sev_asid - min_sev_asid + 1;
-       WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count));
+       if (min_sev_asid <= max_sev_asid) {
+               sev_asid_count = max_sev_asid - min_sev_asid + 1;
+               WARN_ON_ONCE(misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count));
+       }
        sev_supported = true;
 
        /* SEV-ES support requested? */
@@ -2264,8 +2272,9 @@ void __init sev_hardware_setup(void)
 out:
        if (boot_cpu_has(X86_FEATURE_SEV))
                pr_info("SEV %s (ASIDs %u - %u)\n",
-                       sev_supported ? "enabled" : "disabled",
-                       min_sev_asid, max_sev_asid);
+                       sev_supported ? (min_sev_asid <= max_sev_asid ? "enabled" : "unusable") : "disabled",
+                       sev_supported ? min_sev_asid : 0,
+                       sev_supported ? max_sev_asid : 0);
        if (boot_cpu_has(X86_FEATURE_SEV_ES))
                pr_info("SEV-ES %s (ASIDs %u - %u)\n",
                        sev_es_supported ? "enabled" : "disabled",

