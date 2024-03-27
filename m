Return-Path: <linux-kernel+bounces-120746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5CF88DC72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D471F2DEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E785D911;
	Wed, 27 Mar 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPxwnanq"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557504F1FB;
	Wed, 27 Mar 2024 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538549; cv=none; b=unxk1hhtHrRaqLwkWCJ35k4LuFSVlT265tr4/esl08rfJ+fDukmbfXlpnxy3RlSG12Lth3QTq84spPx26SOA0yqa2K/8Axk3KW47y0IsgUqu57irWRzvqPcYwX8WZbXjWH2c/OUuxxG/y3VxicjAQUT1GnlbGIBjPLFLIleZKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538549; c=relaxed/simple;
	bh=sOrNC2KDCM3eQhOJ7BN4LkqPKLRWd2oyY0dcj5arwBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+CLqBKWGJvJqTPTVypblPLahx4/EYL1Is9mXn2szSslZrm9zzwFWxAb7lhfhXNV1rQGXEA9QZQ0yH0kHnx7JJZ+up8pwOrrEVWTLgXo3cnvOqwZlV+wxTaPvyIcaLtZaT8Dk1mWg5sEUrn0xW2ncg3u+31+0oFm79WjbdRc34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPxwnanq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaceso4512251fa.3;
        Wed, 27 Mar 2024 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711538545; x=1712143345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/Y7hSI+tcwrgfaDj2fGdIPxrRjbS5PORsYVoJocVrg=;
        b=gPxwnanq8sEU1cNpuRbw08b81Qg1HesVq5pgFwVh5uGcobnfYc2bplJtkwhM7ATP+A
         ZMf2GvghtlWTC1cAF3Rt3lbhbvzke3FaeyzIedyOfmgiPFv1fcdhDNt1T6VHTuskV9/0
         Rm0SbgG+QTI5BkdXhDKb3GCvToicZ/BzOF2rrXn7rYucG/TlyH05D/N8p5WBfK2eY1wT
         oDtGcw+LcQFoNeJJijRPpp/j0G4PblNI3iVZ8QNDrdtl4VfbCDp31talEcVX1Skdji7x
         d12KTadwp8PlPBfZSZ3NMStKvz/9gxCHkFeBHtrsY9VQYjnkTv/3Fh0laWZ/vkcacteG
         MX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711538545; x=1712143345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/Y7hSI+tcwrgfaDj2fGdIPxrRjbS5PORsYVoJocVrg=;
        b=v589TaSdOvmJsILhE4Zk8ja2omB49Dzf5Ahx07ySpK2lLg30yCtK3I0pIfqbqvsNe3
         SHKingCsM7yndG3at4QkbD9780IXVB121+ruNCLDVr5Slv7YBRpbtbp8tB4s6P3j0kmH
         nyHai6dWiTL/Sjbs2gjwEpGA/mipBFPnJ+IdxOVw4HByz7B6iLv5wECQlaClCaZGc3r7
         dUgZh2Hv2tZ3BAJMqrqBZaF/ROLzfi1Mm93Iof1lE2cJAoAFBmOJHgZ74iFtnIz4FBY/
         XtA8ZmB+x3h/YvGDBsW4DsbKyXKNW/nAbbA9LzPbaeqIEVlO7WUOFYj3rD3ATADdRiBt
         +aAw==
X-Forwarded-Encrypted: i=1; AJvYcCX3RfU/UHuCYlxkE4Y+86fAvlPEnyHFUvW4kNWGoFGr8pMD0POfJN8ajZqPPd02IlmmNTnkEEz0eVz/V4DgRGwvYkHpdCY5NsTU8g4E7v/wQp0j1xBmoA4mdSV/nkR11ultkLMWZ/G2Tm4jyj35gYXFjc2rxpjQvKSvl5oOAwODtuA7Z4ikBXGnKRmkZkc/fKSdTtIpBL9vl3qnwZ8kV3k+Bcz6WaqBYA==
X-Gm-Message-State: AOJu0Yye3AgVFJNigCG1jt7hFAj3QO8NS7z+xu2dUAnmElYHcVlRxBaR
	/LJ/NQl2YaCieUSWWiLq0CQdMsmV6crQBlOED8PMabdfTwRDA/ZXwdYKM2Jx2ci+9mVfbqznh2k
	2GIfxENPIOdbVg/eNkPAb3S5DEgHo+MJx7/c=
X-Google-Smtp-Source: AGHT+IE0HKqOslNp4gsyx+J9o0+Anzjc/on6/jpjqdB2/rQJZMMKvLaXo80f6hony5Tyi7t7n5olj4sbRvIjVVOzI0w=
X-Received: by 2002:a2e:9901:0:b0:2d3:5020:17e5 with SMTP id
 v1-20020a2e9901000000b002d3502017e5mr1980077lji.36.1711538545277; Wed, 27 Mar
 2024 04:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-2-hpa@redhat.com>
 <CAHp75Ve5201KNdjvDZYq_unHTKp9wZXPWZXDgStP8y+XjtnWWg@mail.gmail.com>
 <CAEth8oG7_qFuUrL+kX3ezNatWqKPqT-qiaO5NGY-N3F3ufQL9w@mail.gmail.com>
 <CAHp75VdQtmT0G1dFhdY7TrcBj2W6GhOaVv90_T1e3MdEtiduQQ@mail.gmail.com> <58014ecc-4353-494d-acfb-767e9c977abe@redhat.com>
In-Reply-To: <58014ecc-4353-494d-acfb-767e9c977abe@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 Mar 2024 13:21:48 +0200
Message-ID: <CAHp75VfFLu4Nhd0hWVY_q=BgOLCFCxWQqMzdv61WkroQUJR0Ww@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 1/6] platform: x86-android-tablets: other: Add
 swnode for Xiaomi pad2 indicator LED
To: Hans de Goede <hdegoede@redhat.com>
Cc: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
> On 3/27/24 12:05 PM, Andy Shevchenko wrote:
> > On Wed, Mar 27, 2024 at 9:58=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wro=
te:
> >> On Mon, Mar 25, 2024 at 3:30=E2=80=AFAM Andy Shevchenko
> >> <andy.shevchenko@gmail.com> wrote:
> >>> On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> w=
rote:

..

> >>>> +static int __init xiaomi_mipad2_init(void)
> >>>> +{
> >>>> +       return software_node_register_node_group(ktd2026_node_group)=
;
> >>>> +}
> >>>> +
> >>>> +static void xiaomi_mipad2_exit(void)
> >>>
> >>> __exit ?
> >> No need.
> >> x86-andriod-tablet is based on platform_driver and platform_device so
> >> it doesn't need __exit.
> >>
> >> I put __exit and the compiler complained about the warning.
> >> =3D=3D=3D
> >> WARNING: modpost:
> >> drivers/platform/x86/x86-android-tablets/x86-android-tablets: section
> >> mismatch in reference: xiaomi_mipad2_info+0x50 (section: .init.rodata)
> >> -> xiaomi_mipad2_exit (section: .exit.text)
> >> =3D=3D=3D
> >
> > This is interesting. Why then do we call them symmetrically?
> >
> > Hans, do we need to have anything here been amended?
>
> No this is all as expected.
>
> The platform driver's probe() function can be __init because
> the platform device is registered with the special:
> platform_create_bundle() function which takes a probe() function
> and the actual "struct platform_driver" does not have .probe
> set at all.
>
> Since we need to do manual cleanup on remove() however we need
> a remove() callback and that does sit in the struct platform_driver
> and since remove() can normally also be called on manual unbind
> of the driver through sysfs it cannot be in the __exit section.
>
> I say normally because IIRC platform_create_bundle() disables
> manual unbinding but the section checking code does not know this,
> all it sees is that the "struct platform_driver" is not __exit
> and that it references the remove() callback and therefor the
> remove() callback itself cannot be __exit.

Thank you for the detailed explanation!

--=20
With Best Regards,
Andy Shevchenko

