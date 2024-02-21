Return-Path: <linux-kernel+bounces-74850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB0C85DD72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BC91F2240A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126D7EEFC;
	Wed, 21 Feb 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hMPZjQiP"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02E762C1;
	Wed, 21 Feb 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524276; cv=none; b=KAPNZzhebzNjH/Oiy7Pr2Rc1QyvuAaJqlhn0dmpEggjTjeZU7qANse9mBOm3gOkQPfGIe6LUilEH1w/cuTd9Cn5oxSlZlhZ6pvqJjZXsLgVKa9XCweExRZrSiifk/DKHJ4IOjZUedATYCDsVvcyHMYlEBEoFZXAR1kjr1VSHBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524276; c=relaxed/simple;
	bh=kNEIz7DluXXh2TDoFbuW54XyZrWn7/EUT/Q4+LwUoBs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=InIwWDxiq9F9+p+vKvyXSNGYldti2ro7PUPDG7ulCs15rI2vfmKS4RxGFVnZypGHGyofMUML+rOmWgRMpa89h/OEJ5XEENtB4itzAFLuNLhE+j81pIBHXuR4U9F10BqdrO9MrtIXSWLYY2cb9G9H/ipkXaDQGZCjxT/87eT78VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hMPZjQiP; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41LE2W5O4032626
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 21 Feb 2024 06:02:33 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41LE2W5O4032626
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1708524157;
	bh=F8smVVCqOcx2eQeGpp+uPqQ1cqFR564JCusQLeNYovA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hMPZjQiPo0IXyXhQ+XmIdKygX3w7dHdoubyXEZ6mQt2adBYxofhlGC6MzfmfGSVxc
	 hB4TIDljjzrBYPeqbuhtXMlHBW+BnSrems13Pi1i9sMY+JGT6ulxcYN1tO5jmRjiPL
	 mbUWt9qW0N1U8DRdh78jm3Ir6mEkld740nOjUMsZ8f667NsbDRgXgexyl4hIb3jKDq
	 ZAVOoQ9AfYmPKKntUpJi2U8471nHwC+jbNdQj8hWKa8SlzPTh5dlsE8BLjOKfRMF+9
	 tRTQn7Dc9t5psqS1H1Tdcw1cvm60NJ53KzjkeS6eqX15hjSkSHVS6G/AnnEEdylaY/
	 mhnU3LEJAB9Sw==
Date: Wed, 21 Feb 2024 06:02:30 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Matthew Wilcox <willy@infradead.org>,
        Petr Tesarik <petrtesarik@huaweicloud.com>
CC: Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?Q?Petr_Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Joerg Roedel <jroedel@suse.de>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC 6/8] KEYS: PGP data parser
User-Agent: K-9 Mail for Android
In-Reply-To: <773dd9fb-e668-4652-8b24-712553bb7ab1@huawei-partners.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com> <20240216152435.1575-1-petrtesarik@huaweicloud.com> <20240216152435.1575-7-petrtesarik@huaweicloud.com> <Zc-Q5pVHjngq9lpX@casper.infradead.org> <5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com> <EC53BCED-0D4C-4561-9041-584378326DD5@zytor.com> <773dd9fb-e668-4652-8b24-712553bb7ab1@huawei-partners.com>
Message-ID: <70F9F1E7-4803-46C8-AB6E-AC1CF345F03E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 20, 2024 2:55:12 AM PST, Petr Tesarik <petr=2Etesarik1@huawei-p=
artners=2Ecom> wrote:
>On 2/16/2024 6:08 PM, H=2E Peter Anvin wrote:
>> On February 16, 2024 8:53:01 AM PST, Roberto Sassu <roberto=2Esassu@hua=
weicloud=2Ecom> wrote:
>>> On Fri, 2024-02-16 at 16:44 +0000, Matthew Wilcox wrote:
>>>> On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:
>>>>> From: David Howells <dhowells@redhat=2Ecom>
>>>>>
>>>>> Implement a PGP data parser for the crypto key type to use when
>>>>> instantiating a key=2E
>>>>>
>>>>> This parser attempts to parse the instantiation data as a PGP packet
>>>>> sequence (RFC 4880) and if it parses okay, attempts to extract a pub=
lic-key
>>>>> algorithm key or subkey from it=2E
>>>>
>>>> I don't understand why we want to do this in-kernel instead of in
>>>> userspace and then pass in the actual key=2E
>>>
>>> Sigh, this is a long discussion=2E
>>>
>>> PGP keys would be used as a system-wide trust anchor to verify RPM
>>> package headers, which already contain file digests that can be used a=
s
>>> reference values for kernel-enforced integrity appraisal=2E
>>>
>>> With the assumptions that:
>>>
>>> - In a locked-down system the kernel has more privileges than root
>>> - The kernel cannot offload this task to an user space process due to
>>>  insufficient isolation
>>>
>>> the only available option is to do it in the kernel (that is what I go=
t
>>> as suggestion)=2E
>>>
>>> Roberto
>>>
>>>
>>=20
>> Ok, at least one of those assumptions is false, and *definitely* this a=
pproach seems to be a solution in search of a problem=2E
>
>As a matter of fact, there is some truth to this observation=2E
>
>The frustrating story of Roberto's PGP parser sparked the idea, but it
>would clearly be overkill to add all this code just for this one parser=
=2E
>I started looking around if there are other potential uses of a sandbox
>mode, which might justify the effort=2E I quickly found out that it is
>difficult to find a self-contained part of the kernel=2E
>
>Now I believe that these dependencies among different parts of the
>kernel present an issue, both to kernel security and to maintainability
>of the source code=2E Even if sandbox mode as such is rejected (hopefully
>with an explanation of the reasons), I believe that it is good to split
>the kernel into smaller parts and reduce their interdependencies=2E In
>this sense, sandbox mode is a way to express and enforce the remaining
>dependencies=2E
>
>Petr T

Congratulations=2E You just reinvented the microkernel=2E

