Return-Path: <linux-kernel+bounces-8028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2706581B0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79C92857E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D78208DE;
	Thu, 21 Dec 2023 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="NDMfaLUk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F520310
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d2376db79so4152995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1703148969; x=1703753769; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NEvSJjqER4dwgNc/kNYaxgpYNiAgTRW68D75l9amAIo=;
        b=NDMfaLUkyhpXoqEV/t0PgPzhk5tk0HRHeTtDcI1R71X6U13Ipb55S9WkDMh/NFPAq9
         ZaljAfhx6bqRiinITey+xustLqMFuOuV3F6nZn1S8KA5zPmAMWhuS5Wtgoh43FfqO3ny
         RHaa5McxKAX/auJAMDuN046mtclPjLdj5/bWUkIrLhg7q5Dcs8Fo9r+o0dNuZl4GKXBk
         zxsOjdyiNZdeGIJM2LA2iFt5NIc7b+QQg17etv3LsscILKjb8Sss1fFnUT21ou8cQyop
         ohMlDxhhDUOsfDSOE2osZTUz+d4P++bgCu0kErmwx5mv0wCxhtZJpnARx3lWrAmilvLy
         NUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703148969; x=1703753769;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEvSJjqER4dwgNc/kNYaxgpYNiAgTRW68D75l9amAIo=;
        b=LCyUG/Ru63l9XQg3j4D+Dzer/Paa+3HBy3pgVRmTDFAnXAT77Gl/+Y+kpB6h+ewv2j
         b1CPQc96EOgIcNakW2jhsuNNkB+4MQ3RrY8Tl9lVx1lcA9I9rooQR3ZU9ZpFJRQ6fBF1
         HL+p9wZQzinMdEugbpeXm+WgwVSNZJ4rUnPEiThQvTbCJr1ZMUgDYTIBGaSDBxtZiNny
         iiZ5pBX1Kho2QqvcotWpk0cd8M7cEqD74HmwKTxwldjHHsJlv+M/k8zD1S2r2qOq1liR
         SVVloUPD53rz7uDTpe7jPL2OgY0NBKRqcSJUU2erPi9mj6zJLIp5M5o+KmCsXqFoIvt+
         XLWA==
X-Gm-Message-State: AOJu0YzZvi4CCKEvCWXBbXyM6Ck5dFdt2pTIRRDm+PUbnfyFYkPc24O9
	XmX0JDTFGVG8gZnrg/KaY/VWJA==
X-Google-Smtp-Source: AGHT+IHU/9GNoG9CPlJyJF9wM151c4hjR0wjSeY1C/IGdwvvUOslq6CPfOOZuGw4+k0LWBSfy21dKA==
X-Received: by 2002:a05:600c:4fd4:b0:40b:5e22:958 with SMTP id o20-20020a05600c4fd400b0040b5e220958mr646831wmq.71.1703148968824;
        Thu, 21 Dec 2023 00:56:08 -0800 (PST)
Received: from 2001-4dd0-53c2-1-e989-a920-d643-58fc.ipv6dyn.netcologne.de (2001-4dd0-53c2-1-e989-a920-d643-58fc.ipv6dyn.netcologne.de. [2001:4dd0:53c2:1:e989:a920:d643:58fc])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d560b000000b0033680f7be5fsm1502267wrv.87.2023.12.21.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 00:56:08 -0800 (PST)
Message-ID: <491250ba57be2ab983048ffcf5ffd2aec2bedb9e.camel@mwa.re>
Subject: Re: element sizes in input_event struct on riscv32
From: Antonios Salios <antonios@mwa.re>
To: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,  Deepa Dinamani <deepa.kernel@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Henrik Weinstock <jan@mwa.re>, Lukas
	=?ISO-8859-1?Q?J=FCnger?=
	 <lukas@mwa.re>
Date: Thu, 21 Dec 2023 09:56:06 +0100
In-Reply-To: <9e97eb50-f9a6-4655-9422-fa1106fff97a@app.fastmail.com>
References: <c812ea74dd02d1baf85dc6fb32701e103984d25d.camel@mwa.re>
	 <ZYEFCHBC75rjCE0n@google.com>
	 <9e97eb50-f9a6-4655-9422-fa1106fff97a@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 13:53 +0000, Arnd Bergmann wrote:
> On Tue, Dec 19, 2023, at 02:50, Dmitry Torokhov wrote:
> > Hi Antonious,
> >=20
> > On Thu, Dec 14, 2023 at 11:11:18AM +0100, Antonios Salios wrote:
> > > Hi all.
> > >=20
> > > I'm having trouble getting evdev to run in a simulated Buildroot
> > > environment on riscv32. Evtest (and the x11 driver) seems to be
> > > receiving garbage data from input devices.
> > >=20
> > > Analyzing the input_event struct shows that the kernel uses 32-
> > > bit (aka
> > > __kernel_ulong_t) values for __sec & __usec.
> > > Evtest on the other hand interprets these variables as 64-bit
> > > time_t
> > > values in a timeval struct, resulting in a mismatch between the
> > > kernel
> > > and userspace.
> > >=20
> > > What would be the correct size for these values on a 32-bit
> > > architecture that uses 64-bit time_t values?
> >=20
> > I think there is misunderstanding - we do not have *2* 64-bit
> > values on
> > 32-but architectures. Here is what was done:
> >=20
> > =C2=A0=C2=A0=C2=A0 Input: extend usable life of event timestamps to 210=
6 on 32 bit
> > systems
>=20
> Thanks for forwarding this to me. You are definitely right that
> the user-space structure is intended to use a pair of
> __kernel_ulong_t
> for the timestamp. Usually if an application gets this wrong, it is
> the
> result of having copied old kernel headers the source directory that
> need to be updated.
>=20
> For evtest in particular, I don't see how that is possible, the
> source
> code at [1] shows that it just includes the global linux/input.h,
> which on riscv32 would have to be at least from linux-5.6 anyway
> because older versions are too old to build a time64 glibc.
>=20
> Antonios, can you check which header was used to build your copy
> of evtest, and in case this came from /usr/include/linux, which
> version it corresponds to?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Arnd
>=20
> [1]
> https://gitlab.freedesktop.org/libevdev/evtest/-/blob/master/evtest.c?ref=
_type=3Dheads

The header is included from the sysroot of the toolchain, using version
6.5.6.
I'm using glibc 2.37 with a toolchain built from Buildroot.

The problem seems to be, that __USE_TIME_BITS64 is not defined even
though riscv32 uses 64-bit time.
__BITS_PER_LONG is set to 32 & __KERNEL__ is (of course) undefined in
userspace.
The userspace therefore uses 64-bit values as opposed to the kernel,
which uses 32-bit values.

__USE_TIME_BITS64 is only set when __TIMESIZE is set to 32. [1]
Under riscv32, the default value of 64 is used. [2]


[1]
https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv/li=
nux/features-time64.h;h=3Daf9d84daa7dfe4174e9f977b2c76c5c0df1ce47b;hb=3Dref=
s/tags/glibc-2.37
[2]
https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob_plain;f=3Dbits/timesize.=
h;hb=3Drefs/tags/glibc-2.37

--=20
Antonios Salios
Software Engineer

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock

