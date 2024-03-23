Return-Path: <linux-kernel+bounces-112346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADA38878AC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8A0B217A3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEEE20B02;
	Sat, 23 Mar 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NLoMF8en"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BACA6F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711197594; cv=none; b=SS2Abh4ZHIiO7sUmaeeXSXlAhRriHu/NF+8E//N2ba4BoDaB6tTorDCtwNtgsteAPbHMcz91toDti7rm08RLdTite41WznteY7Ym5xcOBsxQt8c2hRqKEhtSL7A5rF1A7cHmb6r+XefGc01OEabr/GX/0OyGOkfQrlcCz/Ow17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711197594; c=relaxed/simple;
	bh=B/jAiF8VY/uocK1kJECN3SXXqitfg+zAL5Z6/SRJl6M=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=ey1Urwex0oHdvS4dUn/FC+G0JwN5IR2f83RlrJVVX/PCyq2X/FjyzxZ/BhTsH3Qu3jhTyf/SLMErayV2a4hV118kZW+r/lhQLR0F9NiEcY9TIWcmV0U5F+LeCpU4O3f0A9LA7Bhfc3h1B7Q8kiSrSmdjS1jCxcC0LqWk0XBkvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NLoMF8en; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711197574; bh=4QAwHmLtmam4GpY5M1geCT/OMSnNUTDPePbkUBJaklk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=NLoMF8enAFqjf01d9SzHNv95eYOAeFqS1KQdyQtg0GMBraKHXb+njaAlQpRiUbpfD
	 vfmJIu7A3Qj+w79CGPfuA3keWQu0qVcmZtEhYgyQur1OKG72PT71kKwye35BDK87ok
	 dUauFiYGI9BslO/mZsVK0rxOiw1VfMuzVl1tyPXw=
Received: from smtpclient.apple ([240e:467:1bf4:3ea0:e479:c9a1:95aa:d444])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 9DF97C22; Sat, 23 Mar 2024 20:39:31 +0800
X-QQ-mid: xmsmtpt1711197571txj3ebjsu
Message-ID: <tencent_BE1AABF8C6052FB4FD1DD9713962E0425609@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeYsRDFAmm8SNn+E/R6zSHEkIhqlCo7BV7aYryBV9V/zL/PjuuAn
	 bMxFX/trQWhKgEj09W+dtZ1fd18tQ+GxX3HIelQ0JcpLprrp+9Uc0Lzhl8IjRAd7XkqybMlZsNQ6
	 dt9narQlT+bv/0SNmYPB7Z/fYdkhfFduFYNNFK4q2QfNUHsBqwOOudP/dv5q88CBB+pYNYRyE85L
	 EKwVgBb7eVs7hKcINbKjBT+tuo1VwqVfqagn/TQPnfsftrFbDS26RvXTPHKSHQ7VucwBRxxOTVwE
	 0en2jWtCJpC/mdqpB7GrDchr3+ciE+mePG4X0gnucNkdsg7sTYZjTt3W9QwASA6xbxWM+0Wnkvsm
	 zDLnrEHOxzuE07UxhzgZHneNLkVBupp5UGIPJVwaSbE7UOtSvbd8qM5BnmtTsWEC0NwC2jsPbL5k
	 NmOnLTyRRS/UzCKUGZh7z78Nps2Vx3mv2RJ4IOlahiR6kOHgWeExyJV8Y7mizHTfbi3LHVgaGDn2
	 mPFWY6XNvEEsAyMO5wtG9NioCEBUGzqksDob78qlcGwALJt2dKZRniTfCCrI6M2Qpw5Re/oeUbu8
	 0xMe1Nzva56/UDyZuO+Relk76LRrUd5j9xIalJfTN2VAh1NalaJHwV8G8s5cIjQ/v+LHYIWZOEHC
	 fiVPsdzEBdqKd5NuW7+W7HFsKRL3sL3ys9AHph4eoFY7XNYqPssqrg0mRhsK91ZLkVNUz1cQOyqo
	 EU6oEXNLpyAGIo77ZM5i4RT8Chzg8CAvAZYLTOY9J0ugSGiEYyd26gevbBSxBqOqw9kdNI8VKqRA
	 CzBENb1ujJ+ek020HeycQ1x/5I3MCju+p7xTopK4l9xPE4gQQib2FK4hfFmBKgIISqvFI4fLx/n/
	 Djko4NBNLy4KpGBGku7nvJLA6gtmVMTsuwRVXuvKkLrdSBiUmMUIzRukNiqx6jSCV3YNZasO9eIt
	 oPUcvySbILJJ9xkZ1G3Jc6YN7ApAnr2+zd7FQ8+rE05Gy9fj035Mii+UOB+54YvenmFjIKfX2jNX
	 ovOrm2Ug==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] RISC-V: only flush icache when it has VM_EXEC set
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <CAHVXubiosOMnUghsaG_zDyX4wPQ3QGY_UhsUO+PGWQ8v2tDbFw@mail.gmail.com>
Date: Sat, 23 Mar 2024 20:39:21 +0800
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>,
 jszhang@kernel.org,
 Andrew Waterman <andrew@sifive.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <29CFE66B-53EA-4AB7-94C5-840583BC9002@cyyself.name>
References: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com>
 <mhng-3e79924e-d965-4156-836d-19cc8fb8cafe@palmer-ri-x1c9a>
 <CAHVXubiosOMnUghsaG_zDyX4wPQ3QGY_UhsUO+PGWQ8v2tDbFw@mail.gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Mar 22, 2024, at 23:50, Alexandre Ghiti <alexghiti@rivosinc.com> =
wrote:
>=20
> On Wed, Mar 20, 2024 at 1:48=E2=80=AFAM Palmer Dabbelt =
<palmer@dabbelt.com> wrote:
>>=20
>> On Tue, 09 Jan 2024 10:48:59 PST (-0800), cyy@cyyself.name wrote:
>>> As I-Cache flush on current RISC-V needs to send IPIs to every CPU =
cores
>>> in the system is very costly, limiting flush_icache_mm to be called =
only
>>> when vma->vm_flags has VM_EXEC can help minimize the frequency of =
these
>>> operations. It improves performance and reduces disturbances when
>>> copy_from_user_page is needed such as profiling with perf.
>>>=20
>>> For I-D coherence concerns, it will not fail if such a page adds =
VM_EXEC
>>> flags in the future since we have checked it in the __set_pte_at =
function.
>>>=20
>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>> ---
>>> arch/riscv/include/asm/cacheflush.h | 7 +++++--
>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/arch/riscv/include/asm/cacheflush.h =
b/arch/riscv/include/asm/cacheflush.h
>>> index 3cb53c4df27c..915f532dc336 100644
>>> --- a/arch/riscv/include/asm/cacheflush.h
>>> +++ b/arch/riscv/include/asm/cacheflush.h
>>> @@ -33,8 +33,11 @@ static inline void flush_dcache_page(struct page =
*page)
>>>  * so instead we just flush the whole thing.
>>>  */
>>> #define flush_icache_range(start, end) flush_icache_all()
>>> -#define flush_icache_user_page(vma, pg, addr, len) \
>>> -     flush_icache_mm(vma->vm_mm, 0)
>>> +#define flush_icache_user_page(vma, pg, addr, len)   \
>>> +do {                                                 \
>>> +     if (vma->vm_flags & VM_EXEC)                    \
>>> +             flush_icache_mm(vma->vm_mm, 0);         \
>>> +} while (0)
>>>=20
>>> #ifdef CONFIG_64BIT
>>> #define flush_cache_vmap(start, end) flush_tlb_kernel_range(start, =
end)
>>=20
>> I'm not super worried about the benchmarks, I think we can just
>> open-loop assume this is faster by avoiding the flushes.  I do think =
we
>> need a hook into at least tlb_update_vma_flags(), though, to insert =
the
>> fence.i when upgrading a mapping to include VM_EXEC.
>=20
> I'd say Yangyu is right when he mentions in the commit log: "For I-D
> coherence concerns, it will not fail if such a page adds VM_EXEC flags
> in the future since we have checked it in the __set_pte_at function.".
> If a region indeed becomes executable, the page table will be modified
> to reflect that and then will pass in __set_pte_at() which, as Yangyu
> mentions, does the right thing. Or am I missing something?
>=20

I think so. Unless we have any other way to update PTE rather than
using __set_pte_at, I think it=E2=80=99s safe. I=E2=80=99m too busy =
these days to
provide a micro enough benchmark.

Thanks,
Yangyu Chen


