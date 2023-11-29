Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9859C7FDF36
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjK2SUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjK2SUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:20:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FBEB6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701282039; x=1732818039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sTyMsbuQ29XuFRsmsh7TyABKr/lHGBDM3cuS7bGFH/w=;
  b=RCcDDE4dbYVlvKgENGc+qaNCTqkL8HySCpZIX9veo7XHJ8XgH9Eqn+6x
   LKsV+GJBcDb2xA0zi0kyCgoLsF2HsUssxjbOACDJamneWVeelY2Bpr7SP
   dLRNft+QV6hRcsw3ZAZdgV5UrjEBldUUXLoJMJ4OBuiruLdYJLN/wSW60
   G2R3WUSKNYuazQkj5qF14JQ+Jv8RFgnI2xBfUxOtsvP9uwHbQihb/YriZ
   1d7SXNTPaeLdkFVgkN5Jqa9ok1qvOfpknCZzaO9ZoKATw6ggfWfGOE5XD
   i+lmD3O1AMy9kaMzJXwmFmlIOFmrTJO5YpVbAdm3NHNt9pj3pEcfyw06c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="189978"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="189978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772769076"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="772769076"
Received: from npandey-mobl.amr.corp.intel.com (HELO [10.212.143.94]) ([10.212.143.94])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:20:31 -0800
Message-ID: <4afd33ba-6b7c-415f-b9ef-964a2fc840d8@intel.com>
Date:   Wed, 29 Nov 2023 10:20:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/x86: Document what /proc/cpuinfo is for
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231129101700.28482-1-bp@alien8.de>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20231129101700.28482-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 02:17, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> This has been long overdue. Write down what x86's version of
> /proc/cpuinfo is and should be used for.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  Documentation/arch/x86/cpuinfo.rst | 79 ++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
> index 08246e8ac835..cede6aad27c0 100644
> --- a/Documentation/arch/x86/cpuinfo.rst
> +++ b/Documentation/arch/x86/cpuinfo.rst
> @@ -7,27 +7,64 @@ x86 Feature Flags
>  Introduction
>  ============
>  
> -On x86, flags appearing in /proc/cpuinfo have an X86_FEATURE definition
> -in arch/x86/include/asm/cpufeatures.h. If the kernel cares about a feature
> -or KVM want to expose the feature to a KVM guest, it can and should have
> -an X86_FEATURE_* defined. These flags represent hardware features as
> -well as software features.
> -
> -If users want to know if a feature is available on a given system, they
> -try to find the flag in /proc/cpuinfo. If a given flag is present, it
> -means that the kernel supports it and is currently making it available.
> -If such flag represents a hardware feature, it also means that the
> -hardware supports it.
> -
> -If the expected flag does not appear in /proc/cpuinfo, things are murkier.
> -Users need to find out the reason why the flag is missing and find the way
> -how to enable it, which is not always easy. There are several factors that
> -can explain missing flags: the expected feature failed to enable, the feature
> -is missing in hardware, platform firmware did not enable it, the feature is
> -disabled at build or run time, an old kernel is in use, or the kernel does
> -not support the feature and thus has not enabled it. In general, /proc/cpuinfo
> -shows features which the kernel supports. For a full list of CPUID flags
> -which the CPU supports, use tools/arch/x86/kcpuid.
> +The list of feature flags in /proc/cpuinfo is not complete and
> +represents an ill-fated attempt from long time ago to put feature flags
> +in an easy to find place for userspace.
> +
> +However, the amount of feature flags is growing by the CPU generation,
> +leading to unparseable and unwieldy /proc/cpuinfo.
> +
> +What is more, those feature flags do not even need to be in that file
> +because userspace doesn't care about them - glibc et al already use
> +CPUID to find out what the target machine supports and what not.
> +
> +And even if it doesn't show a particular feature flag - although the CPU
> +still does have support for the respective hardware functionality and
> +said CPU supports CPUID faulting - userspace can simply probe for the
> +feature and figure out if it is supported or not, regardless of whether
> +it is being advertized somewhere.

		^ advertised

> +Furthermore, those flag strings become an ABI the moment they appear
> +there and maintaining them forever when nothing even uses them is a lot
> +of wasted effort.
> +
> +So, the current use of /proc/cpuinfo is to show features which the
> +kernel has *enabled* and supports. As in: the CPUID feature flag is
> +there, there's an additional setup which the kernel has done while
> +booting and the functionality is there and ready to use. A perfect
> +example for that is "user_shstk" where additional code enablement is
> +present in the kernel to support shadow stack for user programs.
> +
> +So, if users want to know if a feature is available on a given system,
> +they try to find the flag in /proc/cpuinfo. If a given flag is present,
> +it means

Just rephrasing the meanings, I think I'd say that it means:

all of the following:

 * The kernel knows about the feature enough to have an X86_FEATURE_ bit
 * The kernel supports it and is currently making it available either to
   userspace or some other part of the kernel
 * If the flag represents a hardware feature the hardware supports it

> +If the expected flag does not appear in /proc/cpuinfo, things are
> +murkier.  Users need to find out the reason why the flag is missing and
> +find the way how to enable it, which is not always easy.
> +
> +There are several factors that can explain missing flags: the expected
> +feature failed to enable, the feature is missing in hardware, platform
> +firmware did not enable it, the feature is disabled at build or run
> +time, an old kernel is in use, or the kernel does not support the
> +feature and thus has not enabled it. In general, /proc/cpuinfo shows
> +features which the kernel supports. For a full list of CPUID flags which
> +the CPU supports, use tools/arch/x86/kcpuid.

Could we trim this down a bit?  Maybe concentrate on one example and
then just jump to the takeaway:

The absence of a flag in /proc/cpuinfo by itself means almost nothing to
an end user.  A feature like "vaes" might be fully available to user
applications on an kernel that has not defined X86_FEATURE_VAES and thus
there is no "vaes" in /proc/cpuinfo.

On the other hand, a new kernel running on non-VAES hardware would also
have no "vaes" in /proc/cpuinfo.  There's no way for an application or
user to tell the difference.

The end result is that the flags field in /proc/cpuinfo is marginally
useful for kernel debugging, but not really for anything else.
Applications should instead use things like the glibc facilities for
querying CPU support.  Users should rely on tools like
tools/arch/x86/kcpuid and cpuid(1).
