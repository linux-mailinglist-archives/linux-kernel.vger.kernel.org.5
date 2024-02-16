Return-Path: <linux-kernel+bounces-68056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838885756C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC3BB22918
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F295C134CC;
	Fri, 16 Feb 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="FNro7KLo"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B73B134A0;
	Fri, 16 Feb 2024 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708059456; cv=none; b=a30S/MgxnjypyQS3gGPUlRQ30ekZAGVYyIVt3ZSxlPssioGuOcaF73fo73nuUY626RfyslPnm747nxvKAS9RwPh9qzEZxdQqo51kfg4ix4txRsw/QWcg8Nu/TYUVNbcwNTCsIhvm0sSZQae6tHwveSde2rC8O+BCS7tryEpLcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708059456; c=relaxed/simple;
	bh=3Y4HMSaLBEWeWUuNQmzxVN/phbzyKq/55gEBAgAU9XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSf6NF5VPaQC+VfxlYUZPzf2dC6qdq1olBsufRygPn710lYj9Rv9IIX5HZ43lXLBV11l1NxPHchfDpIqohvxqWftrlwp1WM9Fa5Qg79z08tzNMpbxsUm9xshBSF9wiMf0gf6toPOSNueeXO2slFnVtcd19S3jfBaRlFVyR2NcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=FNro7KLo; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708059432; x=1708664232; i=deller@gmx.de;
	bh=3Y4HMSaLBEWeWUuNQmzxVN/phbzyKq/55gEBAgAU9XY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FNro7KLoAnnifC6gGptxg4FjadLJ5o84c7aij5va+ivWMZ1j1+ymN4YQxb/fHbEG
	 D0VNpSD4kFRCK+LhJ5ad34lOHpAky09yCmUpbVWbo36eO7mqzfN3WvRUYkgtOgZIM
	 hHHNqA+NEEigc4iPcFt784vwCGK9BWbpGVJEFPCFKiOuqpm9dEUTGEJe/JvPkc2SX
	 X5pOBMg+OrF7VY20IKpHC/bazkVZd8AS2f7E6a/cOxESvSr6+4JtG86vkjTqihQdQ
	 TPzXCKuD3syTqB91UwKiLXHknyvwEVJghf3fUthQuezXwgpkY0CkI1ETye34SbTxV
	 WLacsXg2ugvcqop1UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.158.42]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1rWMBc32Ia-00Uoff; Fri, 16
 Feb 2024 05:57:12 +0100
Message-ID: <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
Date: Fri, 16 Feb 2024 06:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:becarR+ef4dzegsvkMywz78csqT++Tf06H+URxCa80SXC0se2DA
 69OKNWH4d4j0ZlrqTSZ6d0szjEP/XoVceimRnGQ6mOHmqGk2dXAOLkluBMy2pd44lPx4xym
 3hIUEYJFowGMYXUHu5l2w8EgsuGKc/TY+KO/ssoxZV3zpTgTjO/NoQZvijq8CUiyRhHq0x/
 cCUlAnUYjCMPfDQTBFA0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F9qjsjB5Dxk=;jDqY0E6LxS4oP/gBh+GIhPxe9wK
 45di+uCMIaRg71h+2iVBBhZ12S1tFIHeSYFgs0DK4dDJ0oY6s1oWeCEYGurTlWifvqARQSZL/
 +6AxF7OHtDleuohxOY/ODhha0UtMwpzMgR4go9HDGpqA+h5pv34rk1y8CWeXJrPX/gy4IFoIS
 P2aEegPC1K54okOY56VePIMVjgQCQ5bobYt0xNqj+5a6e9fNh578YckpBwxpnsCEpgud3B+Xu
 qMKulRR/b0Is9Q2Rlr7FE89E38wI9eqOML+YmoWTCwMvfxcl3Na7bGjZQKNO20GmZurlaDD3G
 TTJQ58beLHyVgsPo1LGJKM8M5u7+LgzevuvtGKkJrkb/hYGo0XNxLc8uBOfKdWejOzUMV9Ga0
 1NSx5xiRRj9sBoH6kvcQFysjVE+ozfp9KmH8dYB0qagS7QRsRRc470/7c6pDeIJ/sHL7d6y5X
 p+Zrxr65lKcWv2EMBC+EkeSvG2JnJ+L5g+MX3hs7eCShcLwjdBJsG84FlBu5EYL277UhVBO2r
 0WD6zVspf1su+Te/WXGTMcTWYEMUR9rIa/7unTtN8Iv6bGE8uvvUg3k1bO1ABD0qEYZLDdcQX
 QORH5N+TTOZaf8+avYLIGJaoT8HqVOWYxe8IvSODKAJ6jrWcc+8QUFXd/qHLsyN7KhsrBZ2J9
 KbH3no/NVksEI70vR2P7NMRR3GUFDV6z0RGxYGokGskUEXb+WJdTVD7rNzbu50rkS4q/WNSFF
 /muXA2jkMKis69KjpPCMoHmFGHEsAs/DgY6n2fNv+i26+wgxg+QUzTsL+5NleVNeeQn6YAfBS
 qwofV39ojtDXSSh9a4BrNmClr7zUeUWgdkiAGvJ+mtncA=

On 2/15/24 02:58, Guenter Roeck wrote:
> Hi Charlie,
>
> On 2/14/24 17:30, Charlie Jenkins wrote:
>> On Wed, Feb 14, 2024 at 03:03:07PM -0800, Guenter Roeck wrote:
>>> On 2/14/24 13:41, Charlie Jenkins wrote:
>>>> The test cases for ip_fast_csum and csum_ipv6_magic were failing on a
>>>> variety of architectures that are big endian or do not support
>>>> misalgined accesses. Both of these test cases are changed to support =
big
>>>> and little endian architectures.
>>>>
>>>> The test for ip_fast_csum is changed to align the data along (14 +
>>>> NET_IP_ALIGN) bytes which is the alignment of an IP header. The test =
for
>>>> csum_ipv6_magic aligns the data using a struct. An extra padding fiel=
d
>>>> is added to the struct to ensure that the size of the struct is the s=
ame
>>>> on all architectures (44 bytes).
>>>>
>>>> The test for csum_ipv6_magic somewhat arbitrarily aligned saddr and
>>>> daddr. This would fail on parisc64 due to the following code snippet =
in
>>>> arch/parisc/include/asm/checksum.h:
>>>>
>>>> add=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %4, %0, %0\n"
>>>> ldd,ma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8(%1), %6\n"
>>>> ldd,ma=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8(%2), %7\n"
>>>> add,dc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %5, %0, %0\n"
>>>>
>>>> The second add is expecting carry flags from the first add. Normally,
>>>> a double word load (ldd) does not modify the carry flags. However,
>>>> because saddr and daddr may be misaligned, ldd triggers a misalignmen=
t
>>>> trap that gets handled in arch/parisc/kernel/unaligned.c. This causes
>>>> many additional instructions to be executed between the two adds. Thi=
s
>>>> can be easily solved by adding the carry into %0 before executing the
>>>> ldd.
>>>>
>>>
>>> I really think this is a bug either in the trap handler or in the hppa=
64
>>> qemu emulation. Only unaligned ldd instructions affect (actually,
>>> unconditionally set) the carry flag. That doesn't happen with unaligne=
d
>>> ldw instructions. It would be worthwhile tracking this down since ther=
e are
>>> lots of unaligned data accesses (8-byte accesses on 4-byte aligned add=
resses)
>>> when running the kernel in 64-bit mode. On the other side, I guess thi=
s
>>> is a different problem. Not sure though if that should even be mention=
ed
>>> here since that makes it sound as if it would be expected that such
>>> accesses impact the carry flag.
>>
>> I wasn't confident it was a bug somewhere so that's why I sent this pat=
ch.
>>
>> However, I have just found the section of the processor manual [1] I wa=
s
>> looking for (Section Privileged Software-Accessible Registers subsectio=
n
>> Processor Status Word (PSW)):
>>
>> "Processor state is encoded in a 64-bit register called the Processor
>> Status Word (PSW). When an interruption occurs, the current value of th=
e
>> PSW is saved in the Interruption Processor Status Word (IPSW) and
>> usually all defined PSW bits are set to 0.
>>
>> "The PSW is set to the contents of the IPSW by the RETURN FROM
>> INTERRUPTION instruction. The interruption handler may restore the
>> original PSW, modify selected bits, or may change the PSW to an entirel=
y
>> new value."
>>
>> Stored in the PSW register are the "Carry/borrow bits". This confirms
>> that the carry/borrow bits should be restored. The save is supposed to
>> automatically happen upon an interrupt and restored by the RETURN FROM
>> INTERRUPTION, thus this is a QEMU bug and not a Linux bug (please
>> correct me if I am wrong).
>>
>
> I know that much (I looked into the manual as well), I just really don't
> know if this is a Linux bug or a QEMU bug, and I have not been able to
> nail it down. I think someone with access to hardware will need to confi=
rm.
>
> Specifically: Yes, the carry/borrow bits should be restored. Question is
> if the Linux kernel's interrupt handler doesn't restore the carry bits
> or if the problem is on the qemu side.
>
>> This v8 was not needed after-all it seems. It would be best to stick
>> with the v7.
>>
> I tend to agree; after all, v7 exposes the problem, making it easier to
> determine if the problem can be reproduced on real hardware.
>
> FWIW,I wrote some test code which exposes the problem.

Can you please give a pointer to this test code?
I'm happy to try it on real hardware.

> It is quite easy to show that carry is always set after executing ldd
> on an unaligned address. That is also why I know for sure that the
> problem is not seen with ldw on unaligned addresses.
Interesting.
In general I think it's quite important to differentiate between
running on qemu or running on physical hardware.
Qemu just recently got 64-bit support, and it's not yet behaving
like real hardware. One thing I noticed is, that read hardware
does not seem to jump into the exception handler twice, while
qemu does. So, if you run into an exception (e.g. unaligned ldd)
then if a second exception happens in the fault handler (e.g. second
unaligned ldd to resolve wrongly-coded code lookup), you will
get different behaviour between hardware and emulation.
This is also the reason why qemu still fails to emulate newer
64-bit Linux kernels which uses kernel modules.

Helge

