Return-Path: <linux-kernel+bounces-72862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BFC85B9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2181C23DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55BA657DC;
	Tue, 20 Feb 2024 10:55:29 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25473629FD;
	Tue, 20 Feb 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426529; cv=none; b=YoJRoYqynCUIqKJHvBeCSGeVEZSDQ+fY6nXb2P8Ki4AgRPsx8G47unhb+H3zqlwuKvX7VMyqqm1xVgS1APsm/w793SM1SvTDZrImIEqiWR4LVnWnzOkq2hBffNGbL3VT3S3OrOpjwQH0pvrpZ7O8F3y86DfDMLPN8b2dU8ov7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426529; c=relaxed/simple;
	bh=IprKEQacloDy2lr5l5ZpfQJvMm+MHJ9C7f5VwlbR96Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JUUcxu1tLvVojJU7BZ8LcwW+yK8+7AjIA26Hn/dlh+HRmoMvKw5FR0++ajRS0i5gwc1L6mtBacuT3Fl3s1PKMJxYB9qh/ipSa8icQAkXzOKinaT34e9gjgV24Kecx2whdPlYas/eBri56HvaCWQbu1l8HLp/PJ8cU4BoJ30XySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TfGRT5fyCz6K5v8;
	Tue, 20 Feb 2024 18:51:17 +0800 (CST)
Received: from frapeml500002.china.huawei.com (unknown [7.182.85.205])
	by mail.maildlp.com (Postfix) with ESMTPS id 27EEE140B30;
	Tue, 20 Feb 2024 18:55:17 +0800 (CST)
Received: from [10.81.214.45] (10.81.214.45) by frapeml500002.china.huawei.com
 (7.182.85.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:55:16 +0100
Message-ID: <773dd9fb-e668-4652-8b24-712553bb7ab1@huawei-partners.com>
Date: Tue, 20 Feb 2024 11:55:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/8] KEYS: PGP data parser
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu
	<roberto.sassu@huaweicloud.com>, Matthew Wilcox <willy@infradead.org>, Petr
 Tesarik <petrtesarik@huaweicloud.com>
CC: Dave Hansen <dave.hansen@intel.com>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
	<petr@tesarici.cz>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Arnd Bergmann
	<arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Kees Cook <keescook@chromium.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>, "Kirill
 A. Shutemov" <kirill.shutemov@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>, Brian Gerst
	<brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel
	<jroedel@suse.de>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Tina Zhang
	<tina.zhang@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
 <20240216152435.1575-7-petrtesarik@huaweicloud.com>
 <Zc-Q5pVHjngq9lpX@casper.infradead.org>
 <5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com>
 <EC53BCED-0D4C-4561-9041-584378326DD5@zytor.com>
From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
In-Reply-To: <EC53BCED-0D4C-4561-9041-584378326DD5@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: frapeml100006.china.huawei.com (7.182.85.201) To
 frapeml500002.china.huawei.com (7.182.85.205)

On 2/16/2024 6:08 PM, H. Peter Anvin wrote:
> On February 16, 2024 8:53:01 AM PST, Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>> On Fri, 2024-02-16 at 16:44 +0000, Matthew Wilcox wrote:
>>> On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:
>>>> From: David Howells <dhowells@redhat.com>
>>>>
>>>> Implement a PGP data parser for the crypto key type to use when
>>>> instantiating a key.
>>>>
>>>> This parser attempts to parse the instantiation data as a PGP packet
>>>> sequence (RFC 4880) and if it parses okay, attempts to extract a public-key
>>>> algorithm key or subkey from it.
>>>
>>> I don't understand why we want to do this in-kernel instead of in
>>> userspace and then pass in the actual key.
>>
>> Sigh, this is a long discussion.
>>
>> PGP keys would be used as a system-wide trust anchor to verify RPM
>> package headers, which already contain file digests that can be used as
>> reference values for kernel-enforced integrity appraisal.
>>
>> With the assumptions that:
>>
>> - In a locked-down system the kernel has more privileges than root
>> - The kernel cannot offload this task to an user space process due to
>>  insufficient isolation
>>
>> the only available option is to do it in the kernel (that is what I got
>> as suggestion).
>>
>> Roberto
>>
>>
> 
> Ok, at least one of those assumptions is false, and *definitely* this approach seems to be a solution in search of a problem.

As a matter of fact, there is some truth to this observation.

The frustrating story of Roberto's PGP parser sparked the idea, but it
would clearly be overkill to add all this code just for this one parser.
I started looking around if there are other potential uses of a sandbox
mode, which might justify the effort. I quickly found out that it is
difficult to find a self-contained part of the kernel.

Now I believe that these dependencies among different parts of the
kernel present an issue, both to kernel security and to maintainability
of the source code. Even if sandbox mode as such is rejected (hopefully
with an explanation of the reasons), I believe that it is good to split
the kernel into smaller parts and reduce their interdependencies. In
this sense, sandbox mode is a way to express and enforce the remaining
dependencies.

Petr T

