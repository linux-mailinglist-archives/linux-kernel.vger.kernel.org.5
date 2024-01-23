Return-Path: <linux-kernel+bounces-35029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C347838ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1398F28C09C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F345D733;
	Tue, 23 Jan 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hxwNynJb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A45D727;
	Tue, 23 Jan 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003106; cv=none; b=incVdL6SyVOzaCgJDUCx5Mg6aJnqaC1XBMu+0EWE60U3LlBQxEjwnHNwMs7QBaMA2iBg8v45OXYDbbzjKBWuzA3S8KIU6QlrNujL144uDvwCdxM11K5GgerXAbqHPbisx3ge6FwcPgS2FrCddODTXC313DNLHEqu5n74H5yjwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003106; c=relaxed/simple;
	bh=pymzY/3H3JwV2zvE9dnuZ+MtpGTlYgDuqgn9PZfrCkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg4G4c9N5tK3OFPbC2lkG6qa3Uj+4xatdWe26gD65xek1Bo8BhkfeCZkrZwhz/k1rP4aEp/PKI/4PHTnOBgt9sDwACNfLbzv14+xSofARn9FROI7PkPzTNA0MVnuWIXsYwoutCY1S753kff10xTtyPnYa5rPa5z6EdakKzIlI5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hxwNynJb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D7C040E01BB;
	Tue, 23 Jan 2024 09:45:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 50w5MlWy-wd7; Tue, 23 Jan 2024 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706003097; bh=GkrBxaeL2aLlMplkTSKVP94a03nzHfhpk7LQpBp9/7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxwNynJbGDduwLhbt4g4J7ymAcJHM+Xol23ZxPF4xrH/6X9JLuOLJMWEeOYiFtDmk
	 uxiINz75Rp2vkRqFEvxLv71BucXmNgjdRQ4nhGo2rH6oDuLQ2B1NPaS1YB0cg/3cO6
	 eT39INMB7cu1Y5Q3OR1PkmYuGTH/TglaeJpx2PdatETiQzzFCbLjzQ9YSia5WQMzVL
	 6UDWcS5RBHDSe6hGicTCTCK8qEujnJiTa9vkMbq4m+DLaIPk5F772MNYDI30z0h4GB
	 LhiPvUvZS6+YO7IexEpzHOqgt1L/CaSlJ7b8pTqEJkQZW+bgkT6dJND/OLK38s12Ro
	 wDuwq7do0I4/Pow2LuhJjMApbhdd8MaTNMOIVibAqkZvGgL11tgnd5krf/HpIWFWdU
	 0kAt6721pkSLBL6WMNnPTNPTVuxaYghjQcevor1j6C2sCIY7L647yZCBhI/BvtF/lB
	 h8kyUYGcHIPzpCVv67IulAwR3RI6FjNaznAgzBZUDL54RG/QdGofPc/joibedooUEk
	 Y7DT1umvJkwwt4gIpX2QVwWxbY3NpmcCIJelzttQ1IFlfLkPbuVAK2XtFB47XzSOZ6
	 LLC4ki2bI6pVe+I687BjIQGek2p15B6sR0cnvT/YpfQrawQfSIOW2Ix63Uug1kt11k
	 wfVynrHAvlPN8MXOqht7prNo=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2949D40E01B4;
	Tue, 23 Jan 2024 09:44:34 +0000 (UTC)
Date: Tue, 23 Jan 2024 10:44:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, seanjc@google.com,
	kim.phillips@amd.com, kirill.shutemov@linux.intel.com,
	jmattson@google.com, babu.moger@amd.com, kai.huang@intel.com,
	acme@redhat.com, aik@amd.com, namhyung@kernel.org,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
	GeorgeXue@zhaoxin.com
Subject: Re: [PATCH v2 2/3] x86/cpufeatures: Add CPU feature flags for
 Zhaoxin Hash Engine
Message-ID: <20240123094427.GAZa-Ke5d2Kwyk2nSU@fat_crate.local>
References: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
 <20240123022852.2475-3-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240123022852.2475-3-TonyWWang-oc@zhaoxin.com>

On Tue, Jan 23, 2024 at 10:28:51AM +0800, Tony W Wang-oc wrote:
> Zhaoxin CPUs have implemented the SHA(Secure Hash Algorithm) as its
> instrucions.
> Add two CPU feature flags indicated by CPUID.(EAX=C0000001,ECX=0):EDX
> bit 25/26 which will be used by Zhaoxin SHA driver.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/include/asm/cpufeatures.h       | 4 +++-
>  tools/arch/x86/include/asm/cpufeatures.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 29cb275a219d..28b0e62dbdf5 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -145,7 +145,7 @@
>  #define X86_FEATURE_RDRAND		( 4*32+30) /* RDRAND instruction */
>  #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
>  
> -/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
> +/* VIA/Cyrix/Centaur/Zhaoxin-defined CPU features, CPUID level 0xC0000001, word 5 */

Does that mean that all those companies agree on the contents of this
CPUID leaf?

>  #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
>  #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
>  #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
> @@ -156,6 +156,8 @@
>  #define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
>  #define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier */
>  #define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
> +#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" Zhaoxin Hash Engine */
> +#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
						      ^^^^^^^^^

From: Documentation/arch/x86/cpuinfo.rst

"a: Feature flags can be derived from the contents of CPUID leaves.
------------------------------------------------------------------
These feature definitions are organized mirroring the layout of CPUID
leaves and grouped in words with offsets as mapped in enum cpuid_leafs
in cpufeatures.h (see arch/x86/include/asm/cpufeatures.h for details).
If a feature is defined with a X86_FEATURE_<name> definition in
cpufeatures.h, and if it is detected at run time, the flags will be
displayed accordingly in /proc/cpuinfo. For example, the flag "avx2"
comes from X86_FEATURE_AVX2 in cpufeatures.h."

Is your grep broken?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

