Return-Path: <linux-kernel+bounces-46111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB54843A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9F528800C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD96997B;
	Wed, 31 Jan 2024 09:10:55 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0169965
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692255; cv=none; b=iSZ442yQj9w1epGMOfnbKoamvNZ+elZiKz2ff8uvmnTE3WRUO5UkjZGC3268M3LC3huRAGJQ5i8Tus8URYvb2DmPzXqdTXn0ohBoFxNdvJ505oKqrQsp6U5i3Xlj2ucSjTO4orOo9KaPQB0E8gpQbwBKuo8qYtdjUqvsCkQXRMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692255; c=relaxed/simple;
	bh=tZ2Kkk4OTFSJm493uk6H8hT3BpCU0VrAwNM5XClLaCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jhs1pGxIOrf2ESjBeyvFV3Eh+GG9StGPnK6gQe02SJafTcHqnjgM4LLo/5V1hc5Ba+4ymj7DyfgIy/PViMdAdlGWYhQ7PA28mgw5SO9ECnSjNL6VMqnn8C0BtlhywgWUh74mG5jNSW1zZq54K6Nhs/UEXP85wk/gKoAW397J26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1706691568-086e230f2933e90001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id CpJE2AnaHniHCIlk (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 31 Jan 2024 16:59:28 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 31 Jan
 2024 16:59:28 +0800
Received: from [10.32.57.248] (10.32.57.248) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 31 Jan
 2024 16:59:25 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <4ef18ceb-68ae-4e09-a04a-b268c7442c52@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.57.248
Date: Wed, 31 Jan 2024 16:59:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86/cpufeatures: Add CPU feature flags for Zhaoxin
 Hash Engine
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v2 2/3] x86/cpufeatures: Add CPU feature flags for Zhaoxin
 Hash Engine
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <seanjc@google.com>, <kim.phillips@amd.com>,
	<kirill.shutemov@linux.intel.com>, <jmattson@google.com>,
	<babu.moger@amd.com>, <kai.huang@intel.com>, <acme@redhat.com>,
	<aik@amd.com>, <namhyung@kernel.org>, <CobeChen@zhaoxin.com>,
	<TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>, <GeorgeXue@zhaoxin.com>
References: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
 <20240123022852.2475-3-TonyWWang-oc@zhaoxin.com>
 <20240123094427.GAZa-Ke5d2Kwyk2nSU@fat_crate.local>
 <AADBA4D3-3D36-4AB6-B0D1-510DD5347430@zytor.com>
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <AADBA4D3-3D36-4AB6-B0D1-510DD5347430@zytor.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1706691568
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3419
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.120182
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------


On 2024/1/23 23:42, H. Peter Anvin wrote:
>
> [这封邮件来自外部发件人 谨防风险]
>
> On January 23, 2024 1:44:27 AM PST, Borislav Petkov <bp@alien8.de> wrote:
>> On Tue, Jan 23, 2024 at 10:28:51AM +0800, Tony W Wang-oc wrote:
>>> Zhaoxin CPUs have implemented the SHA(Secure Hash Algorithm) as its
>>> instrucions.
>>> Add two CPU feature flags indicated by CPUID.(EAX=C0000001,ECX=0):EDX
>>> bit 25/26 which will be used by Zhaoxin SHA driver.
>>>
>>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>>> ---
>>>   arch/x86/include/asm/cpufeatures.h       | 4 +++-
>>>   tools/arch/x86/include/asm/cpufeatures.h | 4 +++-
>>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>>> index 29cb275a219d..28b0e62dbdf5 100644
>>> --- a/arch/x86/include/asm/cpufeatures.h
>>> +++ b/arch/x86/include/asm/cpufeatures.h
>>> @@ -145,7 +145,7 @@
>>>   #define X86_FEATURE_RDRAND          ( 4*32+30) /* RDRAND instruction */
>>>   #define X86_FEATURE_HYPERVISOR              ( 4*32+31) /* Running on a hypervisor */
>>>
>>> -/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
>>> +/* VIA/Cyrix/Centaur/Zhaoxin-defined CPU features, CPUID level 0xC0000001, word 5 */
>> Does that mean that all those companies agree on the contents of this
>> CPUID leaf?
>>
>>>   #define X86_FEATURE_XSTORE          ( 5*32+ 2) /* "rng" RNG present (xstore) */
>>>   #define X86_FEATURE_XSTORE_EN               ( 5*32+ 3) /* "rng_en" RNG enabled */
>>>   #define X86_FEATURE_XCRYPT          ( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
>>> @@ -156,6 +156,8 @@
>>>   #define X86_FEATURE_PHE_EN          ( 5*32+11) /* PHE enabled */
>>>   #define X86_FEATURE_PMM                     ( 5*32+12) /* PadLock Montgomery Multiplier */
>>>   #define X86_FEATURE_PMM_EN          ( 5*32+13) /* PMM enabled */
>>> +#define X86_FEATURE_PHE2            ( 5*32+25) /* "phe2" Zhaoxin Hash Engine */
>>> +#define X86_FEATURE_PHE2_EN         ( 5*32+26) /* "phe2_en" PHE2 enabled */
>>                                                      ^^^^^^^^^
>>
>> From: Documentation/arch/x86/cpuinfo.rst
>>
>> "a: Feature flags can be derived from the contents of CPUID leaves.
>> ------------------------------------------------------------------
>> These feature definitions are organized mirroring the layout of CPUID
>> leaves and grouped in words with offsets as mapped in enum cpuid_leafs
>> in cpufeatures.h (see arch/x86/include/asm/cpufeatures.h for details).
>> If a feature is defined with a X86_FEATURE_<name> definition in
>> cpufeatures.h, and if it is detected at run time, the flags will be
>> displayed accordingly in /proc/cpuinfo. For example, the flag "avx2"
>> comes from X86_FEATURE_AVX2 in cpufeatures.h."
>>
>> Is your grep broken?
>>
> Well, Centaur bought Cyrix, and then VIA bought Centaur. I think Zhaoxin is a joint venture between VIA and the City of Shanghai, or something like that?

Yes, Zhaoxin is a joint venture including VIA and Shanghai Alliance 
Investment Ltd.

VIA has not designed new CPU products for a long time, nor maintained 
the previous products.

Zhaoxin is currently designing and releasing new CPU products, and VIA 
understands and agrees that Zhaoxin uses the contents of this CPUID leaf.

Sorry for late!



