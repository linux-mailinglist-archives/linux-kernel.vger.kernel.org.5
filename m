Return-Path: <linux-kernel+bounces-97348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB4887693C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DE21C22CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0D2209A;
	Fri,  8 Mar 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/6SU6Fp"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899A2030D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917383; cv=none; b=sBUTjUJC5RNklwTHcNTM4rnl05D6Thyu2SfQaH3PKcWLPUgcpcc8L3HSoq8l7kLE7vMLFp+Q4TEaGGLKs3ZGSkfyXC3B9TMy098FOpeNJ+UozcoPoNQpP/0qYK3IVgIY7EuH4YYdiujYexLF66QhD7CvPbcjip/KO4dfv64gMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917383; c=relaxed/simple;
	bh=mWDY08kM8RrPafxZPhvIIbegbdAiSv9arWVCTohYhdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNisZ2o/fqzckg5DgX9VkLUxmqMAcN0D/3wDKtYPerb1JJQ7cRpHtpOQo4RClQzCSvttnfjVTsIki/HVDljvanptNj1G17UUr2ZsrN3TML+Jmpcg+JZMVhVtTLs7VZb+sqs06r6oEz7zhffAgNyzdzmlL3wAGJw9xdNDWw+XLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/6SU6Fp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44628725e3so277087066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709917380; x=1710522180; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1uSvuHKJD452yG7BWM9EA6MuZ+ksYhZIOnRGhbdLcEc=;
        b=U/6SU6Fp7AN4MEbx4fOtIVcX+e8ULMfJACu86XukcQ6dsd1ElRhc+RuW9NX5EYjiXm
         Y4W4KzCOT+lGGHPoNcNnXJq5UVJ5cbFJikex3S/HrA2qemsnq5QRfRMC9kn+oxl6hu4V
         ZQ4ovz2d7RTOUaFtPGFgJWN3YzKA/Dlb4jFdmWCabgshtjon6D2MLWHUL0JQEXBIwqX8
         PFB/Keg4FgtKSfdXgw1YtPG3RYmz6fgIUcm1TUNsgE3UAvz1HQF4Hu256ddUpOEN6wyG
         ZAv1PVBr0MfwB8VciPPqxD6k1ij6JNyYc22VMtID3efhkaR+vagSkrRbnGX5W/MIN3N4
         7qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709917380; x=1710522180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uSvuHKJD452yG7BWM9EA6MuZ+ksYhZIOnRGhbdLcEc=;
        b=RGI9j6mGGzEb5vbHawotOHDGxBbgFNsvuAiKgVxxlLJ6uLVhdmOcTDfYMvOFN00BRC
         rrxv0Myks1kUEyyR4PYo6pyzW3ofYV5nMc+FgnGmoCuEpL1kscGIExYS5/sSboNDMHT6
         HCabyRmQSyOULnQdJdM1d9uc3lI0I6E5MTlUAmBHf9m9iZdKnhsxGzPQMenL/9OOH/gU
         1nJFqhskZndJtZK8tksU9b4hbMo+fJpK7woouioIsntsCOLQihGQFBs60Ru+GZN8wWAj
         VhG8Rzvu9vQNOVv0W7LKr8UPS59a9AhYDlTIQrGoD0U1uSUbQWtvE6+VpzMi6j3owo4Z
         Wqpg==
X-Forwarded-Encrypted: i=1; AJvYcCUCq4QZ6P5Vv08skc6kq/QffnDV5VxOuG5wKnPS0we4fkZfrp11i11hRbkoYb5HIC5U6njLLCJ1ldb3MRIZzvhiqF0uBPfTJm17iUTr
X-Gm-Message-State: AOJu0YwBj+NuUfRXbY6IICugyitQ7usZ1xg4iNb6/UTkG2TmyXDY2lLe
	g+YktUS0nw/xrlgofveqy2nM+Fz6ANAG7V68jegOrQxO/XJf3Cs=
X-Google-Smtp-Source: AGHT+IFABjq3gqWUFFkH6T1jWgLp7uXLRwkQSzZgeE5XDBF+LIpZOPU0NxreW3y93ND02oi1mG6D/A==
X-Received: by 2002:a17:906:b850:b0:a45:ad29:72e7 with SMTP id ga16-20020a170906b85000b00a45ad2972e7mr7228400ejb.36.1709917380353;
        Fri, 08 Mar 2024 09:03:00 -0800 (PST)
Received: from p183 ([46.53.250.75])
        by smtp.gmail.com with ESMTPSA id wr8-20020a170907700800b00a4553c6d52csm5623448ejb.35.2024.03.08.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:02:59 -0800 (PST)
Date: Fri, 8 Mar 2024 20:02:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: stfrench@microsoft.com,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: regression/bisected/6.8 commit
 5d390df3bdd13d178eb2e02e60e9a480f7103f7b prevents the system going into
 suspend mode
Message-ID: <65081fe0-cd4a-4168-90b3-7559357d3b55@p183>
References: <CABXGCsNnE=tz6dfQO4fU58jAYNT2A=9g0CjtdMOQ05AVM6yDRA@mail.gmail.com>
 <c10916cd-670f-41c9-a3a7-7599b0a9a946@p183>
 <CABXGCsOPPuDSSLsOpzvzv+t8yL9z-gzoMTBY0wAL-s1Cd+bDyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsOPPuDSSLsOpzvzv+t8yL9z-gzoMTBY0wAL-s1Cd+bDyg@mail.gmail.com>

On Fri, Mar 08, 2024 at 05:48:04PM +0500, Mikhail Gavrilov wrote:
> On Fri, Mar 8, 2024 at 11:15 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > What? Deleting unused defines breaks suspend?
> >
> > Collect fs/smb/client/smbencrypt.o with and without patch and
> > see them being identical.
> >
> > Enum in stddef.h are
> >
> >         enum {
> >                 false = 0,
> >                 true = 1,
> >         };
> >
> > so if defines were used somehow they would expand to same values of
> > same type.
> >
> > Something else is going on.
> 
> I understand your confusion.
> But I didn't come up with it. And moreover, I saw what the revert does.
 
> Why did this really help is a question to which I would like to find an answer.

OK, lets exclude newbie mistakes.

Exclude CIFS:

* start with clean compile into out-of-tree directory

	mkdir ../obj-001
	cp .config ../obj-001/.config
	make -k -j$(nproc) O=../obj-001		# buggy kernel
	sudo rm -rf /lib/modules/$(uname -r)	# no mixed module copies
	sudo make O=../obj-001 modules_install
	sudo make O=../obj-001 install

	[patch]

	mkdir ../obj-002
		...

This is what I use in Production(tm):

	#!/bin/sh -x
	sudo rm -rf /lib/modules/$(uname -r)            &&\
	sudo make modules_install                       &&\
	sudo make install                               &&\
	sudo emerge @module-rebuild                     &&\
	sudo grub-mkconfig -o /boot/grub/grub.cfg       &&\
	sync                                            &&\
	sudo nvme flush /dev/nvme*n1

* After rebooting double check that build number in /proc/version
  matches .version in the ../obj directory:

	$ cat /proc/version
Linux version 6.7.4-100.fc38.x86_64 (mockbuild@68dbdffd8a2b4619991006cfcbec2871) (gcc (GCC) 13.2.1 20231011 (Red Hat 13.2.1-4), GNU ld version 2.39-16.fc38) [[[[[ ===> #1 <===  ]]]]] SMP PREEMPT_DYNAMIC Mon Feb  5 22:19:06 UTC 2024

	$ cat ../obj/.version
	1

This verifies that you've rebooted into correct kernel.

* keep both full kernel trees in two separate directories

	if both vmlinux are identical, you may try to find which modules
	are different

* disassemble fs/smb/client/smbencrypt.o or (cifs.ko) for both kernels

	objdump -M intel -dr $(find ../obj-001 -type f -name cifs.ko) >000.s
	objdump -M intel -dr $(find ../obj-002 -type f -name cifs.ko) >001.s
	diff -u0 000.s 001.s

For your experiment, number should be 1 (first clean recompile from
scratch) and then 2 (after applying 1 patch).

If the bug is not 100% reproducible, then bisecting gets more
entertaining because you can't be really sure each step is in the right
direction.

> The most interesting thing is that I have two identical systems:
> Identical:
> - M/B - MSI MPG B650I EDGE WIFI
> - CPU - AMD Ryzen 7950x
> - GPU - AMD Radeon 7900XTX
> - SSD1 for system - Intel Optane 905P SSDPE21D480GAM3
> - SSD2 for data - Intel D5 P5316 Series SSDPF2NV307TZN1
> - PSU - Asus ROG LOKI SFX-L 1000W Platinum
> - Mouse - Logitech MX Master 3s
> - Keyboard - MX Keys Mini
> - Linux distro (identical version of all software) - Fedora Rawhide
> On one system this bug is present, on the other it is not.
> 
> Affected system: https://linux-hardware.org/?probe=9a5a8c0338
> Not affected system: https://linux-hardware.org/?probe=37c62300bb

