Return-Path: <linux-kernel+bounces-51330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F808489DF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45911B24443
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC617FB;
	Sun,  4 Feb 2024 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="gE+5TW3D"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8538C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707006160; cv=none; b=Zd7KnkKntCC4sLoyxk8Df3JLkl6UOR3ipVxTiPafLjBDVydrTzTW2PLCahDMnhl/bp5BSyIsD+gMKJXv+zK895nGl9qmngmDhSC5CetEmj19pstYZs/SjgENf4830TJOnqkoZqePMfv01WG1KUKDOk2bl2xxg0TQiedA4NG7dy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707006160; c=relaxed/simple;
	bh=czkfpW61lAXFdsguakOz0Yvzzd1nD9b8p8YAJzKHBq0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YIKn+gopHpQBZ8NgxZGbiqlekkU2077upplhgwQZzSCQJWn+RCmplRE1cv4xHSg4JS/5NQjAi0/c1qS1qIjQvff2Ci3kToHbYWbluCHAIshw0cGKDV0KFUniZ1/HW8p3DZxKxRkOKT3orZ3MtqW6e1LcQ8JnzWqCU1OHyvrin/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=gE+5TW3D; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb804e330so29813695e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 16:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1707006156; x=1707610956; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfmI2ewltHRJMYO5mo5fFwZc+1SV7LuHqUomT5kdRyc=;
        b=gE+5TW3DktoPPS5gBD8eylS2CiliBultrDat5wN+17ZfOz9deSbSHR8JKx/kVrLUu/
         mY50uYc09LIH6SQJmMmjQhJemB9qfi9e4KeMQz/aWswRIdBSSbiojFlAkPvNFLlzPFNB
         oNlGh9Vmg2Jt+LiU8cBniDwWRx6fUMigZR2QizPmO2MHm0lOktGaShUqc2lNq3De5f7/
         KAdPRBLbiWHat7HUzZqq92+VX5qm7zrW1zVRcw+94JcmCVVML0TjK9AirelQMrmovKfh
         rszptZqyKiWVlLDIhb/VmbSz8njW+jtArbGLkCURDyUxFw6ozdb+gXWM9OVXEoBiLHNz
         a86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707006156; x=1707610956;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfmI2ewltHRJMYO5mo5fFwZc+1SV7LuHqUomT5kdRyc=;
        b=aBiMgQDVoCOki9gDAsApvwZRMN3dxfoad+ayOw3/QrbgS97PXuorV1UUwK9AroiKlq
         e94OP3hRB1WtfzmEDTFh2dbsiA0VvUzxfISG3Jifr080sSJH9KJ1vglv3fQMr5cxskOO
         TY52YGxac2J1S5NH9Z0lB6HjWhOLNjobahRj0WiUhSgoz869tX60eR12FkN7+LQRfjmC
         lL3+csRhx9caQ6s8hHhCzc7k3BKtRtS6kloCIf1J43gL1+kAisK7NyKuWjuP4umBcuSr
         1bIjHXZH24iRybv2Xf/OlA625O44HGNqDd78FqHYWHIiBninfRDJKtjIBFbtHntgaFpf
         UrEA==
X-Gm-Message-State: AOJu0YxYvbigCnHWFe9BYfsTRYn4H6GB3DZ4kEBSfAYmaGcn7cJcZETo
	es7idCGXEdSx2wkEqHS/yjUbHSCHQpa9qeoksFh9HLwtzXA2TpX4hMKqA+W8ouM=
X-Google-Smtp-Source: AGHT+IHTi3m2btatPb8/FQEFneiCu7KlySBWkA0Ujl2vPiUvGEgjbz/Z9LiAEEo14cV/np8nHj9OcA==
X-Received: by 2002:a05:600c:458a:b0:40f:d3bd:b222 with SMTP id r10-20020a05600c458a00b0040fd3bdb222mr1413414wmo.38.1707006156368;
        Sat, 03 Feb 2024 16:22:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWJTmKxGNH/ofKVvL73KTRZlg0mpziW2SONM+lih4pUDUXze0Pudw4a1sccT9ryZqBsoL7pFDIP7gcQG0h5kprVUqwPZsmtyd5/4WCR9wwSbK3d96ikGt21oE2QcjHfIkB8j1I++xn65wWXI3HgsSzY2E7+unG4QFRBDvUWgdkoEgn18caH8K5iO++HQ+Gve8TcUqqvvFKIYSyldA7JaAaM0erFh+AEoihv47VtdWvnsNsqKesxAmoZrybLyOF0+DjlLFl3N3IZKOcMXRl92deUuotAozXDEx9j2NCMTGo9hbImGql1w8U6m59XC9rt+l3xwfdg6BvgSXED10Qmcw2RvtKjfeYQ
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b0040fb7c87c73sm4250081wmq.45.2024.02.03.16.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Feb 2024 16:22:35 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] riscv: hwprobe: export VA_BITS
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <5657c211-531b-4890-8c52-182b7b4eae7c@app.fastmail.com>
Date: Sun, 4 Feb 2024 00:22:25 +0000
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 linux-doc@vger.kernel.org,
 linux-riscv <linux-riscv@lists.infradead.org>,
 linux-kernel@vger.kernel.org,
 Robin Ehn <rehn@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A2420B9-6039-445B-B2C3-77F13EDD77BA@jrtc27.com>
References: <20240201140319.360088-1-cleger@rivosinc.com>
 <ZbxUUsKdKIPI8Fb/@ghost> <701d3350-93d3-4235-aaf7-04c6492420a7@rivosinc.com>
 <5657c211-531b-4890-8c52-182b7b4eae7c@app.fastmail.com>
To: Stefan O'Rear <sorear@fastmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

On 3 Feb 2024, at 10:40, Stefan O'Rear <sorear@fastmail.com> wrote:
>=20
> On Fri, Feb 2, 2024, at 3:22 AM, Cl=C3=A9ment L=C3=A9ger wrote:
>> On 02/02/2024 03:32, Charlie Jenkins wrote:
>>> On Thu, Feb 01, 2024 at 03:02:45PM +0100, Cl=C3=A9ment L=C3=A9ger =
wrote:
>>>> Some userspace applications (OpenJDK for instance) uses the free =
bits
>>>> in pointers to insert additional information for their own logic.
>>>> Currently they rely on parsing /proc/cpuinfo to obtain the current =
value
>>>> of virtual address used bits [1]. Exporting VA_BITS through hwprobe =
will
>>>> allow for a more stable interface to be used.
>>>=20
>>> mmap already supports this without a need for applications to know =
the
>>> underlying hardware. If a hint address is passed into mmap, it will =
never
>>> return an address that uses more bits than the hint address. I =
designed
>>> it that way so that something like this wasn't necessary.
>>=20
>> Ok even though probing this kind of thing is probably not what mmap =
is
>> meant to do. IMHO, probing this through the regular hwprobe interface =
is
>> probably more coherent but maybe Robin (which needs this information)
>> can rely on that.
>=20
> Both of these are useful, separately and in conjunction.
>=20
> hwprobe allows applications which can adapt to different VA sizes to =
learn
> which is in use prior to allocating memory.
>=20
> mmap hints allow applications which require a fixed limit on the VA =
size to
> express that limit at the point of requirement, the hint can be set =
based on
> the hwprobe result to explicitly indicate its use.

Neither is an architecture-specific concept though. If you want to
expose a notion of VA bits to userspace then it should probably be done
in a more generic manner than the RISC-V-specific hwprobe syscall,
probably as two numbers, low and high bits (ia64=E2=80=99s regions may =
be gone,
but sparc64 still has both halves of the address space presented to
userspace, with the stack in high/negative memory).

Jess

> -s
>=20
>> Cl=C3=A9ment
>>=20
>>>=20
>>> - Charlie
>>>=20
>>>>=20
>>>> Link: =
https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux_riscv/=
vm_version_linux_riscv.cpp#L171 [1]
>>>> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
>>>>=20
>>>> ---
>>>> Documentation/arch/riscv/hwprobe.rst  | 3 +++
>>>> arch/riscv/include/asm/hwprobe.h      | 2 +-
>>>> arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>>>> arch/riscv/kernel/sys_hwprobe.c       | 3 +++
>>>> 4 files changed, 8 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/Documentation/arch/riscv/hwprobe.rst =
b/Documentation/arch/riscv/hwprobe.rst
>>>> index b2bcc9eed9aa..6f198c6ed4f0 100644
>>>> --- a/Documentation/arch/riscv/hwprobe.rst
>>>> +++ b/Documentation/arch/riscv/hwprobe.rst
>>>> @@ -210,3 +210,6 @@ The following keys are defined:
>>>>=20
>>>> * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int =
which
>>>>   represents the size of the Zicboz block in bytes.
>>>> +
>>>> +* :c:macro:`RISCV_HWPROBE_KEY_VA_BITS`: An unsigned long which
>>>> +  represent the number of bits used to store virtual addresses.
>>>> diff --git a/arch/riscv/include/asm/hwprobe.h =
b/arch/riscv/include/asm/hwprobe.h
>>>> index 630507dff5ea..150a9877b0af 100644
>>>> --- a/arch/riscv/include/asm/hwprobe.h
>>>> +++ b/arch/riscv/include/asm/hwprobe.h
>>>> @@ -8,7 +8,7 @@
>>>>=20
>>>> #include <uapi/asm/hwprobe.h>
>>>>=20
>>>> -#define RISCV_HWPROBE_MAX_KEY 6
>>>> +#define RISCV_HWPROBE_MAX_KEY 7
>>>>=20
>>>> static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>>> {
>>>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h =
b/arch/riscv/include/uapi/asm/hwprobe.h
>>>> index 9f2a8e3ff204..2a5006cddb7b 100644
>>>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>>>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>>>> @@ -67,6 +67,7 @@ struct riscv_hwprobe {
>>>> #define RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
>>>> #define RISCV_HWPROBE_MISALIGNED_MASK (7 << 0)
>>>> #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
>>>> +#define RISCV_HWPROBE_KEY_VA_BITS 7
>>>> /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>>>=20
>>>> /* Flags */
>>>> diff --git a/arch/riscv/kernel/sys_hwprobe.c =
b/arch/riscv/kernel/sys_hwprobe.c
>>>> index a7c56b41efd2..328435836e36 100644
>>>> --- a/arch/riscv/kernel/sys_hwprobe.c
>>>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>>>> @@ -202,6 +202,9 @@ static void hwprobe_one_pair(struct =
riscv_hwprobe *pair,
>>>> if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>>>> pair->value =3D riscv_cboz_block_size;
>>>> break;
>>>> + case RISCV_HWPROBE_KEY_VA_BITS:
>>>> + pair->value =3D VA_BITS;
>>>> + break;
>>>>=20
>>>> /*
>>>>  * For forward compatibility, unknown keys don't fail the whole
>>>> --=20
>>>> 2.43.0
>>>>=20
>>>>=20
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>=20
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



