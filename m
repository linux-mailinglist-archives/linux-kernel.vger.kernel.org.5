Return-Path: <linux-kernel+bounces-77347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07186042C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE1D1C256D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678373F19;
	Thu, 22 Feb 2024 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="j90nl2wi"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958C6E5E3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635485; cv=none; b=kKj5W1na96dOgOQaLKRPVJbaKfb+slbc891Sv1IOc1lOJdVyHpt2cNlzDnQkLpKzUTcy6zre5rkw6Hm88Zotrmn1J/LZr1A984mvVh4cxf2Ffx3ByEctky1wtfLR5L9OilrFqPCqKC0msGXzJ0a25THiD+Bzxq4Iuux13vBHUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635485; c=relaxed/simple;
	bh=oo8hXXOsRZpFdbwH1oQe9YLEy7wMWlFsaDKNC37/KpE=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=akqXDWnaRxIxmyth2SzZozlGsFDgWXfWb6Js5zJtEU5wmkbfvtABTr3t0FeDrhME8IbbCrQPknZDI6WtkJD9PF12xl/LMlzXp4WkbeC+3aKBDMlU1wG/ndTJudHy9vCou0x+kXR1CrK402gmbXxNNjozIqFvEbwXH5EwYHxnKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=j90nl2wi; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-206689895bfso128542fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1708635481; x=1709240281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/JstmNsXGrATrdQJrqYAdriIsItVvYWhgpEZTS+OEc=;
        b=j90nl2wi4lQdjX4IXjpvaESIlQ/+0vWIpWSrUkoJ/hyAfQKAzrbykU/v3k689RKMis
         He4eA6wRRBl9zDt0TMQJVQ5MVjOOese1VVFBnLGBWIvzSgyl6t0e9aT7WnQvx39xR1ug
         BVv96pwRtNtANoPIjE4G+07uIeLj8X16wMLEKs7B/c1Dtsp3Jm0A6ceNn3ppCD/dM/d2
         96FJpsxDwyC1wi3nurX0E6n1O6bLRsEJeuo7vIWQ8OtKHXAob58EUIAPi13HYbGOW+fM
         IstEgw32rXRhQywiBQu7JrVHiuGYEqAZ0OfafFAxfW5h+128SeC9DiCtJAE2klgKPl0q
         pnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635481; x=1709240281;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/JstmNsXGrATrdQJrqYAdriIsItVvYWhgpEZTS+OEc=;
        b=qNXAHCh0tAenpsgvB85sg92rfqMmh0ZUITL9gCdIK2oinyxJBdeWS7GzOxyqinZ5PC
         s0BP2sKD7Kc3tlKys+27ktPZ+TEAh1a0+/uN+QoyM+Gq+THUDsE4rmP1cmUfGHMqtfVL
         hm+Bh/6u/lLRGZqQFcJuB79jRUwqk4DBqhiivop+Ap11GrGjuASFHSUgX622PJeB+gVF
         mN2iALOVCU/Y5rHYmoOtkW2WamrrZeJnsm9MgJOXfyPAwAA9uXBtmmO1Im7s0vZxv4v+
         NbJWEUPAnhEJzuu2+lgISVD0q0CgovbdeF1sOJfms8O87jkKJQY3Na/0gytOc9Eq/1V1
         irSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQHIdU8BTgPlXEz7ni5fodXF9oEqwu+ml5RTurTqe9tACby5qeeXVVLlPXie0askzoQj/1acLRL1PTnOzTG3LaLmBGMBLGA318H19b
X-Gm-Message-State: AOJu0YwS8ujz6bEVEHd6QLIbPTZ/QV00VTG8YfArljnz/bGWDwuOajII
	bEVWcqSj8inHaJNQga2KeKakhyJrQ0XF5dxG7NsIy2/nzXLJ9NxSniVLNNEEglDG95n7SJMZarP
	J2yY=
X-Google-Smtp-Source: AGHT+IFzHbOMj9bR4XwoTV78+XQQDpkce4tWRSTpsF1S4rvhPsRaNJYaAkOqP1nVzW664TOOaBFWYA==
X-Received: by 2002:a05:6870:3306:b0:219:48a9:2d08 with SMTP id x6-20020a056870330600b0021948a92d08mr84346oae.12.1708635481161;
        Thu, 22 Feb 2024 12:58:01 -0800 (PST)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id u2-20020a656702000000b005dc26144d96sm9549017pgf.75.2024.02.22.12.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:58:00 -0800 (PST)
Date: Thu, 22 Feb 2024 12:58:00 -0800 (PST)
X-Google-Original-Date: Thu, 22 Feb 2024 12:57:58 PST (-0800)
Subject:     Re: [RFC PATCH 0/1] riscv: dts: Allow BUILTIN_DTB for all socs
In-Reply-To: <ac11967c-3ab4-42be-86ca-0d40c35eee04@ghiti.fr>
CC: cyy@cyyself.name, linux-riscv@lists.infradead.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>,
  linux-kernel@vger.kernel.org, masahiroy@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-a0b00545-1522-4045-a4fe-97c3fbb8b082@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 12:46:57 PST (-0800), alex@ghiti.fr wrote:
> Hi Yangyu,
>
> On 20/02/2024 20:01, Yangyu Chen wrote:
>> The BUILTIN_DTB kernel feature on RISC-V only works on K210 SoC only. This
>> patch moved this configuration to entire riscv.
>>
>> Although BUILTIN_DTB is not a good choice for most platforms, it is likely
>> to be a debug feature when some bootloader will always override something
>> like the memory node in the device tree to adjust the memory size from SPD
>> or configuration resistor, which makes it hard to do some debugging. As an
>> example, some platforms with numa like sg2042 only support sv39 will fail
>> to boot when there is no ZONE_HIGHMEM patch with 128G memory. If we want

I guess that's a surprising one, but there's always some Kconfig entries 
that are necessary to set in order to get platforms to boot -- at a bare 
minimum errata and drivers, for example.

> Orthogonal to this patch, but if needs be, we can fix this issue with
> 128G on sv39 by changing the sv39 address space layout, we still have
> room to gain the 4G you miss, at that time I was pretty sure that amount
> of memory would come with sv48 :)

That seems like a reasonable way to go, as long as it's not overly 
complex.

>
> Thanks,
>
> Alex
>
>
>> a kernel without this patch to boot, we need to write the memory nodes
>> in the DT manually.
>>
>> Also, changing DT on some platforms is not easy. For Milk-V Pioneer, the
>> boot procedure is ZSBL -> OpenSBI -> LinuxBoot -> Linux. If DT gets
>> changed, OpenSBI or LinuxBoot may refuse to boot. And there is some bug on
>> LinuxBoot now which does not consume --dtb argument on kexec and always
>> uses DT from memory. So I would like to do debugging on DT using

I'd argue those are bootloader/firmware bugs.

>> BUILTIN_DTB, which makes it very simple, I can even install the kernel in
>> the distro's way and provide a kernel package for other users to test.
>>
>> Yangyu Chen (1):
>>    riscv: dts: Allow BUILTIN_DTB for all socs
>>
>>   arch/riscv/Kconfig                  | 16 ++++++++++++++-
>>   arch/riscv/Kconfig.socs             | 32 -----------------------------
>>   arch/riscv/boot/dts/Makefile        |  2 +-
>>   arch/riscv/boot/dts/canaan/Makefile |  2 --
>>   4 files changed, 16 insertions(+), 36 deletions(-)
>>

