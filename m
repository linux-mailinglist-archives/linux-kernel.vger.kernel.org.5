Return-Path: <linux-kernel+bounces-52362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388EC849720
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32A228DF40
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63C12E45;
	Mon,  5 Feb 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="V3ZWxHbj"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2912E63;
	Mon,  5 Feb 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127116; cv=none; b=SDgKUB/kqes0ZS77mU27yozx349OEhdaPRvlZEu4wjWJpvbxhcETJ6+xz+nIu6ipkPqg5mFxxZ4y2osCoIRnhAUsgtaAgv/paHpRkyc02DTM3lCtHdW8XOWFHC12syA0prG8ODLTizOH+CAenxLpdbqhLESTVhY9/TyLN2Zz4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127116; c=relaxed/simple;
	bh=q/8FmVDMmKInvK9MPO1XkvumiAG5Zx2X+HgxZuCqccE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7mhHnxrAg7DVDtFn23X4r8UEB8+knbBLFQnB6EYptM3QBGE5D2ztzdiCPlJB6/G2L37k+EPX0tJF8iHwwhhwceX6x49inHb6ZRoi7RWK5DVxgvoHpZoz0/IhWgGHmtg+85sVrcufXHCibmnNbg+9ynZQ2799W2RdfmxvA0eiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=V3ZWxHbj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707127107; x=1707731907; i=deller@gmx.de;
	bh=q/8FmVDMmKInvK9MPO1XkvumiAG5Zx2X+HgxZuCqccE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=V3ZWxHbjBwlNKn5Wp51yeiz6501QxPbcYpFxk+BLOBDqpsc9mQmOOzpupMPuC3km
	 KqqHhsI7QIf9ASM0dVtyjkPfPyWUMiuH4+OsXRlXGM46FU9+EfH0N3zu9I5VTrILf
	 ywptAtwbUpvJ7kZGeXnnuc1BN5R8aPPZ05BNgsc+6L1HnhV1/QFZsZvdLb/58acpe
	 Ri45I65sWQI9Fcv3UZknR8Wi6BNcNzYVwo6L++36jG6cRj2NLghzpjmFdhPxfFPRz
	 GIs3PQBQU7sjnxoDE38V/nf+aK5hyclpDUH/hdQvURq27qJbm98vqyCwWY4oRiUf/
	 052myrohz3lUQKSG4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.145.139]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1rHKXF3cJj-00Jdil; Mon, 05
 Feb 2024 10:58:26 +0100
Message-ID: <12d876ba-a325-4442-9526-3ea9e2117c0b@gmx.de>
Date: Mon, 5 Feb 2024 10:58:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Helge Deller <deller@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <ZbqfMR_mVLaSCj4Q@carbonx1> <ZbrJq3X63hIMkbl2@slm.duckdns.org>
 <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>
 <ZbvM1V8CYNeds14r@slm.duckdns.org>
 <e6916a78-7872-442d-922d-31ea3920da4f@gmx.de>
 <ZbxHuS6vOc0MB7-R@slm.duckdns.org>
 <983189ec-e8fc-41ef-bad7-cfebad20ac83@gmx.de>
 <f75e7606-0904-4e97-b337-e8f74843e87d@gmx.de>
 <Zb0mbHlIud_bqftx@slm.duckdns.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <Zb0mbHlIud_bqftx@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T5G9Y9gcIjgfbaasqDlD6pvRcKdohdF+0yy2341XNkk6OU6+rVs
 fpYustZNbg+cRePD6FTEklCWG7JICihUjxMLprCuj/n1vu3gYfUieMlsJ+WYTNe9YNRUkUU
 h+MINnAC4d2624zgZPHwrVDZZUgw1zkESvztkBOTeHIRwL0xYhuN7DvHykApFAq06OWvwz8
 27hPK0scgQutOZXvFfMwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QaquBmfnSVU=;5IkA2BQ5QlLHlzkOmdTJ9pA0E8m
 IVySZ2OL9npn/Z7mLRPCTD/P214bIgd8J/2qjSMxe3EetTUp2X0TPbPxwGi9OkvkJr4odWC7z
 P0ie6dEu5Yhso6adfEzzf7f4erreut6HkXJlWsgI5+cjT+9y9/4lUCHajCoDnliniK2LYCxTT
 mkdUZEiVQl8WTC7a48UqepS4lpnlDepfxagKXlPcu5c+zfZQwzv0VunOLfI04uWGXBGlF0s13
 ZVIluRaQImL7fGYDhuspv4nVloFYGW+sr/uZ83wVdA0FjkBGid6+f5mTyMt3Y4jw86zcPqhzC
 u0xLLduZst2SO+4V+eFULEXalLPpB7Lq4ux8OOdb5g8Tf28stqy7YLpsJbFMuuAhjyUmOwTJG
 zmeyLMWnMAgjX9gKNBtrQaAtuyMvKaZ74ayRKLY0yja+64niJX7fnXJZsI5smuV0jBiEGYNyE
 um0Xw/BlVWLNuMWDhVX54KHeK2zv0CZ05v6DH1a7bKQUUpORJaHmuSZ3gQ+HZc+ZmyVPMIbV8
 522HRgJGr4fMA7LP6zNIxmG0q0KCiT6++ZQY/zorYm82UHWswKxoYOOkOD91Ci0ggV8lMBD1Q
 lB5+unewcHrMwWa9QiPys2u/h88SJLDwrAajG0Mt8s61OQgVh3BIgUBRFomR5BgSpArchmvKO
 YRUshaNvNdtNbDCi8FrbYnRgcecuiU1flFuQFBoGIRXP8wlWrZ1e9QggYLKq//GTZvRK/LdWf
 kOh8KOlg6TGHHB+ahMpjDOtKV1aGHV81LYulL3aGpuzRUA+PPFE/nsIido+6/iYprR3QgE5hf
 qizlzt5O5hBlPqKu90PDTosLkFnC6JsKNNtOUuVQbhOiE=

Hi Tejun,

On 2/2/24 18:29, Tejun Heo wrote:
> Hello, Helge.
>
> On Fri, Feb 02, 2024 at 09:41:38AM +0100, Helge Deller wrote:
>> In a second step I extended your patch to print the present
>> and online CPUs too. Below is the relevant dmesg part.
>>
>> Note, that on parisc the second CPU will be activated later in the
>> boot process, after the kernel has the inventory.
>> This I think differs vs x86, where all CPUs are available earlier
>> in the boot process.
>> ...
>> [    0.000000] XXX workqueue_init_early: possible_cpus=3Dffff  present=
=3D0001  online=3D0001
> ...
>> [    0.228080] XXX workqueue_init: possible_cpus=3Dffff  present=3D0001=
  online=3D0001
> ...
>> [    0.263466] XXX workqueue_init_topology: possible_cpus=3Dffff  prese=
nt=3D0001  online=3D0001
>
> So, what's bothersome is that when the wq_dump.py script printing each c=
pu's
> pwq, it's only printing for CPU 0 and 1. The for_each_possible_cpu() drg=
n
> helper reads cpu_possible_mask from the kernel and iterates that, so tha=
t
> most likely indicates at some point the cpu_possible_mask becomes 0x3
> instead of the one used during boot - 0xffff, which is problematic.
>
> Can you please sprinkle more printks to find out whether and when the
> cpu_possible_mask changes during boot?

It seems the commit 0921244f6f4f ("parisc: Only list existing CPUs in cpu_=
possible_mask")
is the culprit. Reverting that patch makes cpu hot-unplug work again.
Furthermore this commit breaks the cpumask Kunit test as reported by Guent=
er:
https://lkml.org/lkml/2024/2/4/146

So, I've added the revert to the parisc git tree and if my further tests
go well I'll push it upstream.

Thanks for your help!!
Helge

