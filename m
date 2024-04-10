Return-Path: <linux-kernel+bounces-139008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E722489FD5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B585283775
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73417B506;
	Wed, 10 Apr 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IYwTlzuq"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD053361
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767483; cv=none; b=S+3qQj/8z0GjYofYAP+Yv41kIefwhYTjXSxexdV7zJ95zXboMETjnXdvHXZ0H6nM9l3+hr1E0j4+QacyjrzORbp8Ui65IOGT1APoBmdFkPOj29qfQifimVXfbi+T9nFu0t5wk61qQ7vK+jvilxmsPNelMKDzEYn3ObkWt9gbj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767483; c=relaxed/simple;
	bh=KYqxPLjGchAVH6LOyWzpzPmrZc8Z3MDyX8I+W5aD6iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eU0pNeF2Fs4mU1nODALCuCqDnHBje5h4YWq+qldA9tacvoiSDLoV6L3RERTEOiD54neqTKEsthzVvx918Ni5eYSk51SS8YQ8dX8NjkHBpypN/dFpgKILAqG6qvee7gRziYUR8RwTUsbp2UxLWBYh+X5yy3rcrDdhsVR7yTZqNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IYwTlzuq; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43AGi8px093222
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 10 Apr 2024 09:44:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43AGi8px093222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1712767449;
	bh=Q4i5zF3JlPOe0pe5gL//wwtov+DnMAVQ3hl4Mq5jlV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IYwTlzuq0roOPqoLMKkd+OomhmU/KTk9r6Zj3n32btRqfBPDteH5yoz8lYGmJ9dBY
	 ULAKGNpG/GBUZnPWuNbZO7rRBTtVd9JZTwzHKMMn1AmOwYt9xozUauouiSINvBnRMT
	 G9yqDio2/pPBEx4kSmJGrpvyYtuoNd/oZaCsC0EX6rXwlIP8Npu/PqPDFn2K10ineC
	 5oBsRpFTvSybWGnP0AsmD5FTYxZP8AzB5DnhHoUXihsO8aANgkp3sFoQHQL08Fg7Ul
	 wHHBQKdQfIRVdXgIaqsKn3Qh1SflVWZzl9A4Y9tuVN744aGrpTmW63GqAZbeJtyW1I
	 imc/18fumqGOQ==
Message-ID: <ad5bd7f5-3290-4ddc-83bd-41a18fa1beee@zytor.com>
Date: Wed, 10 Apr 2024 09:44:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/entry/64: Skip SYSRET validation tests when
 FRED is enabled
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, brgerst@gmail.com
References: <20240403062404.2956240-1-xin@zytor.com>
 <56cbf1f0-0867-44c2-a9fd-712bf3549cbb@zytor.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <56cbf1f0-0867-44c2-a9fd-712bf3549cbb@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/9/2024 4:35 PM, H. Peter Anvin wrote:
> Now, for a FRED system the return value is ignored anyway, so the only 
> benefit of this is skipping the test, correct?

Yes, and as syscalls are hot paths, we should save some cycles.

> 
> I do observe than what is left of do_fast_syscall_32 is a single 
> assignment followed by __do_fast_syscall_32(), which could be turned 
> into a tailcall.

Ah, I didn't realize this is a better way, will change.

> 
> Another thing that has been added lately is a bunch of tests on the int 
> $0x80 path. This is a slow path *on legacy hardware*, but on FRED 
> systems it is the *fast* path for IA32 emulation. These tests are also 
> totally unnecessary *AND IN FACT, WRONG* on a FRED system, as FRED 
> distinguishes external interrupts from software interrupts.
> 
> Furthermore, under FRED interrupt 0x80 is available as a hardware 
> interrupt (since there is no reason to block it out.) Therefore, going 
> and poking the APIC as in int80_is_external() is INCORRECT and possibly 
> fatal.
> 
> Again, the easiest way to fix that is to follow what XenPV does in 
> int80_is_external(), but there is more unnecessary stuff: 
> !user_mode(regs) cannot happen on FRED, and the stuff in the 
> int80_emulation assembly function should, if it is needed at all on any 
> FRED-compatible hardware (I don't believe so) should be done in the FRED 
> user mode assembly entry stub.
> 
> Thus, it might be better to strip down do_int80_emulation() to a lean 
> fred_int80_emulation().

Yeah, FRED is fundamentally better with its nature.  Will do!

Thanks!
     Xin

> 
>      -hpa
> 
> On 4/2/24 23:24, Xin Li (Intel) wrote:
>> Don't do SYSRET validation tests when FRED is enabled, since ERETU is
>> the only legit instruction to return to user level.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>   arch/x86/entry/common.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)



