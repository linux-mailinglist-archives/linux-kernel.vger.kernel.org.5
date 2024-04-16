Return-Path: <linux-kernel+bounces-147271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2058A71CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A614F283870
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDA112F387;
	Tue, 16 Apr 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ENzBJ5yx"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541237719
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286781; cv=none; b=Jt43gGMoHU2DEKV+1HVF/2eJSAbL+Ffs4U9S1l+X4BECLKNwy66y3j5ks1M7e5EJu1ipIBEkUtOngd2vW/khRouq8dcD7bXGl8ic7EpolF9M2aUxpJ5PAYrSxXBSLx/uHUtCPbmAjhpIvROlRHXOmzKsPtGcyX//uwo75lQtoV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286781; c=relaxed/simple;
	bh=OqwfRgfuRz/ivsxvdcUz3wpO0OSe7tdZKPZ6/JVHlZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkzzrxzKlXZyj5YwAfh0p6Aq+ggHBSD4wGJ96ygbMNYHNEXkO3A22ybETsepSfFNUANnVaFUzzsNKe6E5T9a5GjJiQHw24os2npTv3M4LCgDBvz5RXpDS8S8LuA6yn7cIUirh6aoQIkmZoCqBgqmvp5IMBmmePJFm/wWHyrkGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ENzBJ5yx; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.187] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43GGwlAN3295309
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 16 Apr 2024 09:58:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43GGwlAN3295309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713286728;
	bh=TfJil0ZDbGlav4krTpp9dcUVQzx75ISIZzMZstAGT6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ENzBJ5yxGnQURnAwcjuAXE1UBTEskLookeB5f6Tgc+7D/raTOPxJRpt0p8BWYzBfG
	 4/Lr2fbCxsUtFelRRx5nbISu5vcnk+z5KUzBAJBbPNHSuyBSxdeQcRPZNdm/krQbNt
	 +OPHnAa0hrnV0xkqU7+pOhgGsDz7Tz1YqXp3EVA1YNmBPsuMEM37HDH2CW8TnsP1wh
	 v8Wd6Ylj4b9wtIah1xfIslFN5VfyPJ5jinY/yP2eewa4aiOpQB9S+TRPkRpGSEvs7f
	 GwvwOQMB7m4cp67I1Vklxr/pkkFOeLupEeKtNZyzmG8CMxHeAYEhhN7zAzgYFN8oLg
	 9X2c5nJ3Fg/aw==
Message-ID: <a329ecf1-5ed9-46c1-86d2-9e8d9ce69195@zytor.com>
Date: Tue, 16 Apr 2024 09:58:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
References: <20240412234058.1106744-1-xin@zytor.com>
 <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
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
In-Reply-To: <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/2024 3:11 AM, Borislav Petkov wrote:
> On Fri, Apr 12, 2024 at 04:40:58PM -0700, Xin Li (Intel) wrote:
>> Commit 55617fb991df
> 
> Use the full commit abbreviation when mentioning commits:
> 
> "Commit
> 
>    55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")
> 
> .."

oh, I should have done it!

> 
>> added a bunch of tests to the int $0x80 path,
> 
> Added a bunch of tests?
> 

'checks' might be a better term to use?

> What does that even mean?
> 
>> however they are unnecessary and event wrong in fact under FRED.
> 
> Are the bunch of tests wrong or is do_int80_emulation() simply the wrong
> handler to use on a FRED?

I think the explanations are below, and you saw it a bit later.

BTW, comments are added around the code changes.

> 
>> First FRED distinguishes external interrupts from software interrupts,
>> thus int80_emulation() should NEVER be called for handling an external
>> interrupt, and then int80_is_external() should be skipped under FRED.
>>
>> Second, the FRED kernel entry handler NEVER dispatches INTx, which is
>> of event type EVENT_TYPE_SWINT, so the user mode checking in
>> do_int80_emulation() is redundant, and should be skipped.
>>
>> It might be even better to strip down do_int80_emulation() to a lean
>> fred_int80_emulation(), not to mention int80_emulation() does a
>> CLEAR_BRANCH_HISTORY.
> 
> Yah, how about you do a FRED-specific INT80 handler instead of
> sprinkling moar tests around? fred_intx() looks like the right place to
> stuff it in...
> 

I will add fred_int80_emulation(), which duplicates a big part of
do_int80_emulation(), however this seems more readable.

Thanks!
     Xin

