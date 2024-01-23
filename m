Return-Path: <linux-kernel+bounces-35582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF81F8393A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6952C294F30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFA663417;
	Tue, 23 Jan 2024 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SXcZchmN"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5EC63409;
	Tue, 23 Jan 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024571; cv=none; b=WbnlW/Y5payC4rycEykWDCGuZZUF+jgrEHpfLxyGIXliGF+zWKuRdMO+pEOcCc2IDORe89Ff+jXeAFnO5228G2OfEDcIeQBs0BGqRt0GMqNVg9kn1uNGXdiR8ICAEHSGxtL7yvCpN3Yz4rk0hw9qOAnOz2MKytFi0I4ajQkjmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024571; c=relaxed/simple;
	bh=8JD68csNl8Tb1siGMnm1l/EwSi4Lo8eyYQU7w9FZPho=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AWpXTQQI8uPGhOt4G9h+Wv2bPbOXx8OAVDigOER5NmcXzhAGVfU7vL3yQqnY2P0ivNxEr1GdpZT+fo8BGDAITV6+25N/VIkXafNdmYISRxQN90bxrzP0pi1hRZcCPGddjP5VrOV8x9DoB5Q/cVNvuGixlMuQ2rh164/H8IHQ7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SXcZchmN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40NFg2FF3157103
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 23 Jan 2024 07:42:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40NFg2FF3157103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706024527;
	bh=T/4H9mi6BG7HwRXIFLHvGD5C/Xts5jU0ou5CYzc/EcQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SXcZchmNHbVfHs9BLoI3l3CM+batgETuTpKUiOTl+uwFhDrLvTC2tKq2XkBu2SLSA
	 6P+JasaFRWEji1jOY4REZ4TAdKt/vGsCuCjjo43j7hTnuCvicsPiHSfJCHEYv2n1oR
	 wEkEf5JMaXMNgX02f3OKJq6qAf44nc8smZi+DyqFPVflBdNGKaLcL4mAIUWZsR0Kx/
	 7Ul+uOskJRZT0QMlURpf1jcMkIdMSz3vVVXCIG6TKJnj8b/QG/FVqDSuWNGSG/qNC2
	 q+bzMgxxBeA7Bdg+Z5tVznsHg+Lk/+2GvyVlPiQQZ3gd4/aZppwE+Uj6b7mmDlIssc
	 s+Xpmbe9WguEg==
Date: Tue, 23 Jan 2024 07:42:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
CC: herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, seanjc@google.com, kim.phillips@amd.com,
        kirill.shutemov@linux.intel.com, jmattson@google.com,
        babu.moger@amd.com, kai.huang@intel.com, acme@redhat.com, aik@amd.com,
        namhyung@kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
        LeoLiu-oc@zhaoxin.com, GeorgeXue@zhaoxin.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/3=5D_x86/cpufeatures=3A_Add_?= =?US-ASCII?Q?CPU_feature_flags_for_Zhaoxin_Hash_Engine?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240123094427.GAZa-Ke5d2Kwyk2nSU@fat_crate.local>
References: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com> <20240123022852.2475-3-TonyWWang-oc@zhaoxin.com> <20240123094427.GAZa-Ke5d2Kwyk2nSU@fat_crate.local>
Message-ID: <AADBA4D3-3D36-4AB6-B0D1-510DD5347430@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 23, 2024 1:44:27 AM PST, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Tue, Jan 23, 2024 at 10:28:51AM +0800, Tony W Wang-oc wrote:
>> Zhaoxin CPUs have implemented the SHA(Secure Hash Algorithm) as its
>> instrucions=2E
>> Add two CPU feature flags indicated by CPUID=2E(EAX=3DC0000001,ECX=3D0)=
:EDX
>> bit 25/26 which will be used by Zhaoxin SHA driver=2E
>>=20
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin=2Ecom>
>> ---
>>  arch/x86/include/asm/cpufeatures=2Eh       | 4 +++-
>>  tools/arch/x86/include/asm/cpufeatures=2Eh | 4 +++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/cpufeatures=2Eh b/arch/x86/include/as=
m/cpufeatures=2Eh
>> index 29cb275a219d=2E=2E28b0e62dbdf5 100644
>> --- a/arch/x86/include/asm/cpufeatures=2Eh
>> +++ b/arch/x86/include/asm/cpufeatures=2Eh
>> @@ -145,7 +145,7 @@
>>  #define X86_FEATURE_RDRAND		( 4*32+30) /* RDRAND instruction */
>>  #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor =
*/
>> =20
>> -/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, wor=
d 5 */
>> +/* VIA/Cyrix/Centaur/Zhaoxin-defined CPU features, CPUID level 0xC0000=
001, word 5 */
>
>Does that mean that all those companies agree on the contents of this
>CPUID leaf?
>
>>  #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) *=
/
>>  #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
>>  #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt)=
 */
>> @@ -156,6 +156,8 @@
>>  #define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
>>  #define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier =
*/
>>  #define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
>> +#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" Zhaoxin Hash Engine */
>> +#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
>						      ^^^^^^^^^
>
>From: Documentation/arch/x86/cpuinfo=2Erst
>
>"a: Feature flags can be derived from the contents of CPUID leaves=2E
>------------------------------------------------------------------
>These feature definitions are organized mirroring the layout of CPUID
>leaves and grouped in words with offsets as mapped in enum cpuid_leafs
>in cpufeatures=2Eh (see arch/x86/include/asm/cpufeatures=2Eh for details)=
=2E
>If a feature is defined with a X86_FEATURE_<name> definition in
>cpufeatures=2Eh, and if it is detected at run time, the flags will be
>displayed accordingly in /proc/cpuinfo=2E For example, the flag "avx2"
>comes from X86_FEATURE_AVX2 in cpufeatures=2Eh=2E"
>
>Is your grep broken?
>

Well, Centaur bought Cyrix, and then VIA bought Centaur=2E I think Zhaoxin=
 is a joint venture between VIA and the City of Shanghai, or something like=
 that?

