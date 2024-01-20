Return-Path: <linux-kernel+bounces-31780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E278333E0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E783C1F21ED2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBD7DDD5;
	Sat, 20 Jan 2024 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhecMsjC"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F8ED304;
	Sat, 20 Jan 2024 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749944; cv=none; b=DiYR4NoGCZkfSzXCu5LvRafXrDSVDEbqTfnviWadf0Kku9IimsbqEWKMhBF2OqDGothpcl2WB+EWw4gOhOpOu7d5mIubaf/wUZE4SJ3M8mZaXUuOd93mdeuofRTiFH8o27d5C42U1FNyHDtXUQB9G3Dar4Iq+rr9/h9rJvrDWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749944; c=relaxed/simple;
	bh=AY0FI0AJyUQnSQk8vNEkT6dsRCLqZvg9Tx/l4TqFhTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBrMBA4RGh5pqhJheEfYN1l0ByeAOaU+2iI83MFwR3XLxaqhlsx4yGKW5CgIhHhgXTF/mGBZ364R1wzgIevHE/htNM7S7kCGNMJcOvky+7atrMuE/DYCW9rwLdazSiGtC5jNve15ZHWyFgdBqmDPTQdLGLmS3PD8HFqg4nEP70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhecMsjC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so1708531b3a.1;
        Sat, 20 Jan 2024 03:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705749942; x=1706354742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgsgmfAUCsUK7bv60DL+YeJq8JarB9xRbUnaqW3K3n4=;
        b=DhecMsjCOvDeQmTiLjnKztBI8KGwq9BrWvcAz8cSMO0wijiSWy25Mc4NUvbF1oCwP9
         XRD6TG5aXsCT25LJFcKSOTfUv7GqkPZ4gZD5eeofjIalO8rjiO5b5ZPkQs+ddl2PxLNs
         qhjUJOuODGYWBkH/FR7j5cvX3ByOLC+39h66Wd8DcxsyiJgOe+ivMBB/ZR1NmVSWMVtI
         MMtbDR9DQChVGRtNaniXSsMIRw9bjHhnmEo9xvxmA1Udu1r0IKk9mS5c6v0VbYyqL+0g
         fabv4r2MynDJE58VcSp7veldmcXqpN5ung7/r7cHJVij8ikBz0mWWjcQ6yiuIhNLuCQV
         4svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705749942; x=1706354742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgsgmfAUCsUK7bv60DL+YeJq8JarB9xRbUnaqW3K3n4=;
        b=MiFCS3k/8pic7G+CYbFdc/rxwjOSNjAqes+v/gwTFbrUX4YN0aMMTetoinSjpz5jlc
         WXpT+YNl2cLYmWVz0pYkJOCLYJahQalxeMrPq1oQxGXbgR2FQ7Gl/9q/CE+RkyCmjZpH
         Ge0KysTKExmWc+B761d/sAm4Eettvgh0jOj1OU0O8vVhu5+OgNWg2SRh3IItLb+eJwdA
         uQOK6FM80TC0zmdJ3/MUrOg4GJhDdbPWNq07WbBAAYUNDrKQsdwdAahT+ZQMXoGqQL1B
         mLjzQBnV936/wv+ZuH8PLV9grwfTlcloU2Xt8exX5UmV6hgog9gl3fnk/afLLL2D1RLG
         5J+w==
X-Gm-Message-State: AOJu0Yy+viNqIcv3Ajuq96H6Mdc/ymYzcQzDtC+X9lZ5SS/b4xrgjTAE
	pJw2l1P6OVTyUTKTaaLwifHOOfVxCKne8tVoHJZIOLrkNdQBT7JV
X-Google-Smtp-Source: AGHT+IGczytrLQQdYDK7kvLhiVSmKYX9mhpfTIBfzwvIUl99cMSETuw33MUFEt9naz8OE72mObfRxQ==
X-Received: by 2002:a05:6a21:32a8:b0:199:fe49:6bb3 with SMTP id yt40-20020a056a2132a800b00199fe496bb3mr1684368pzb.5.1705749941592;
        Sat, 20 Jan 2024 03:25:41 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id kr8-20020a056a004b4800b006da73b90fe4sm6790103pfb.14.2024.01.20.03.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 03:25:40 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 121831846DB12; Sat, 20 Jan 2024 18:25:36 +0700 (WIB)
Date: Sat, 20 Jan 2024 18:25:36 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Sui Jingfeng <suijingfeng@loongson.cn>, linux-parisc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Prathu Baronia <prathubaronia2011@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [BUG][BISECTED] Freeze at loading init ramdisk
Message-ID: <ZautsJ6a7_YjW5aQ@archie.me>
References: <8a6aa228-f2da-4dcd-93c1-e34614cd6471@alu.unizg.hr>
 <cc813525-5484-443e-a40a-cb98f2ed4e1f@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vv+fIX42qDF80RtH"
Content-Disposition: inline
In-Reply-To: <cc813525-5484-443e-a40a-cb98f2ed4e1f@alu.unizg.hr>


--Vv+fIX42qDF80RtH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 07:47:49PM +0100, Mirsad Todorovac wrote:
> On 1/16/24 01:32, Mirsad Todorovac wrote:
> > Hi,
> >=20
> > On the Ubuntu 22.04 LTS Jammy platform, on a mainline vanilla torvalds =
tree kernel, the boot
> > freezes upon first two lines and before any systemd messages.
> >=20
> > (Please find the config attached.)
> >=20
> > Bisecting the bug led to this result:
> >=20
> > marvin@defiant:~/linux/kernel/linux_torvalds$ git bisect good
> > d97a78423c33f68ca6543de510a409167baed6f5 is the first bad commit
> > commit d97a78423c33f68ca6543de510a409167baed6f5
> > Merge: 61da593f4458 689237ab37c5
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:=C2=A0=C2=A0 Fri Jan 12 14:38:08 2024 -0800
> >=20
> >  =C2=A0=C2=A0=C2=A0 Merge tag 'fbdev-for-6.8-rc1' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/deller/linux-fbdev
> >  =C2=A0=C2=A0=C2=A0 Pull fbdev updates from Helge Deller:
> >  =C2=A0=C2=A0=C2=A0=C2=A0 "Three fbdev drivers (~8500 lines of code) re=
moved. The Carillo Ranch
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev driver is for an Intel product wh=
ich was never shipped, and for
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the intelfb and the amba-clcd drivers t=
he drm drivers can be used
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 instead.
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The other code changes are minor: some =
fb_deferred_io flushing fixes,
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imxfb margin fixes and stifb cleanups.
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Summary:
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Remove intelfb fbdev driver (Th=
omas Zimmermann)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Remove amba-clcd fbdev driver (=
Linus Walleij)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Remove vmlfb Carillo Ranch fbde=
v driver (Matthew Wilcox)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fb_deferred_io flushing fixes (=
Nam Cao)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - imxfb code fixes and cleanups (=
Dario Binacchi)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - stifb primary screen detection =
cleanups (Thomas Zimmermann)"
> >  =C2=A0=C2=A0=C2=A0 * tag 'fbdev-for-6.8-rc1' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/deller/linux-fbdev: (28 commits)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev/intelfb: Remove driver
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev/hyperv_fb: Do not clear global sc=
reen_info
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware/sysfb: Clear screen_info state=
 after consuming it
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev/hyperv_fb: Remove firmware frameb=
uffers with aperture helpers
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/hyperv: Remove firmware framebuffer=
s with aperture helper
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev/sis: Remove dependency on screen_=
info
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video/logo: use %u format specifier for=
 unsigned int values
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video/sticore: Remove info field from S=
TI struct
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/parisc: Detect primary video devic=
e from device instance
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev/stifb: Allocate fb_info instance =
with framebuffer_alloc()
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video/sticore: Store ROM device in STI =
struct
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: flush deferred IO before closing
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: flush deferred work in fb_deferr=
ed_io_fsync()
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: amba-clcd: Delete the old CLCD d=
river
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: Remove support for Carillo Ranch=
 driver
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: hgafb: fix kernel-doc comments
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: mmp: Fix typo and wording in cod=
e comment
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: fsl-diu-fb: Fix sparse warning d=
ue to virt_to_phys() prototype change
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: imxfb: add '*/' on a separate li=
ne in block comment
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev: imxfb: use __func__ for function=
 name
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> >=20
> >  =C2=A0Documentation/fb/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 -
> >  =C2=A0Documentation/fb/intelfb.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 155 --
> >  =C2=A0Documentation/userspace-api/ioctl/ioctl-number.rst |=C2=A0=C2=A0=
=C2=A0 1 -
> >  =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 12 -
> >  =C2=A0arch/parisc/video/fbdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 +-
> >  =C2=A0drivers/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +-
> >  =C2=A0drivers/firmware/sysfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 14 +-
> >  =C2=A0drivers/gpu/drm/hyperv/hyperv_drm_drv.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 8 +-
> >  =C2=A0drivers/video/backlight/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 7 -
> >  =C2=A0drivers/video/backlight/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 1 -
> >  =C2=A0drivers/video/backlight/cr_bllcd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
264 ---
> >  =C2=A0drivers/video/fbdev/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 72 -
> >  =C2=A0drivers/video/fbdev/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 2 -
> >  =C2=A0drivers/video/fbdev/amba-clcd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 986 ---------
> >  =C2=A0drivers/video/fbdev/core/fb_defio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0 8 +-
> >  =C2=A0drivers/video/fbdev/fsl-diu-fb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 2 +-
> >  =C2=A0drivers/video/fbdev/hgafb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 13 +-
> >  =C2=A0drivers/video/fbdev/hyperv_fb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 20 +-
> >  =C2=A0drivers/video/fbdev/imxfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 179 +-
> >  =C2=A0drivers/video/fbdev/intelfb/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 8 -
> >  =C2=A0drivers/video/fbdev/intelfb/intelfb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 382 ----
> >  =C2=A0drivers/video/fbdev/intelfb/intelfb_i2c.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 209 --
> >  =C2=A0drivers/video/fbdev/intelfb/intelfbdrv.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1680 ----------------
> >  =C2=A0drivers/video/fbdev/intelfb/intelfbhw.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2115 --------------------
> >  =C2=A0drivers/video/fbdev/intelfb/intelfbhw.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 609 ------
> >  =C2=A0drivers/video/fbdev/mmp/hw/mmp_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 2 +-
> >  =C2=A0drivers/video/fbdev/sis/sis_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 37 -
> >  =C2=A0drivers/video/fbdev/stifb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 109 +-
> >  =C2=A0drivers/video/fbdev/vermilion/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 -
> >  =C2=A0drivers/video/fbdev/vermilion/cr_pll.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 195 --
> >  =C2=A0drivers/video/fbdev/vermilion/vermilion.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1175 -----------
> >  =C2=A0drivers/video/fbdev/vermilion/vermilion.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 245 ---
> >  =C2=A0drivers/video/logo/pnmtologo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +-
> >  =C2=A0drivers/video/sticore.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
> >  =C2=A0include/linux/amba/clcd-regs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 87 -
> >  =C2=A0include/linux/amba/clcd.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 290 ---
> >  =C2=A0include/video/sticore.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +-
> >  =C2=A037 files changed, 208 insertions(+), 8708 deletions(-)
> >  =C2=A0delete mode 100644 Documentation/fb/intelfb.rst
> >  =C2=A0delete mode 100644 drivers/video/backlight/cr_bllcd.c
> >  =C2=A0delete mode 100644 drivers/video/fbdev/amba-clcd.c
> >  =C2=A0delete mode 100644 drivers/video/fbdev/intelfb/Makefile
> >  =C2=A0delete mode 100644 drivers/video/fbdev/intelfb/intelfb.h
> >  =C2=A0delete mode 100644 drivers/video/fbdev/intelfb/intelfb_i2c.c
> >  =C2=A0delete mode 100644 drivers/video/fbdev/intelfb/intelfbdrv.c
> >  =C2=A0delete mode 100644 drivers/video/fbdev/intelfb/intelfbhw.c
> >  =C2=A0delete mode 100644 drivers/video/fbdev/intelfb/intelfbhw.h
> >  =C2=A0delete mode 100644 drivers/video/fbdev/vermilion/Makefile
> >  =C2=A0delete mode 100644 drivers/video/fbdev/vermilion/cr_pll.c
> >  =C2=A0delete mode 100644 drivers/video/fbdev/vermilion/vermilion.c
> >  =C2=A0delete mode 100644 drivers/video/fbdev/vermilion/vermilion.h
> >  =C2=A0delete mode 100644 include/linux/amba/clcd-regs.h
> >  =C2=A0delete mode 100644 include/linux/amba/clcd.h
> > marvin@defiant:~/linux/kernel/linux_torvalds$
> >=20
> > Hope this helps.
>=20
> P.S.
>=20
> As I see that this is a larger merge commit, with 5K+ lines changed, I do=
n't think I can
> bisect further to determine the culprit.
>=20
> But I thought later that it would be interesting to see why my hardware t=
riggered the freeze
> and probably others did not, or someone would complain already.
>=20
> Both of the boxes were AMD Ryzen: Ryzen 7 5700G and Ryzen 9 7950X.
>=20
> FWIW, I am attaching both hardware listings and the config used, so anyon=
e knowledgeable with
> fbdev could possibly narrow down the search.
>=20

Hi Mirsad,

There is another report from Jens with similar symptom [1]. Can you check if
reverting df67699c9cb0ce ("firmware/sysfb: Clear screen_info state after
consuming it") fixes your regression?

Thanks.

[1]: https://lore.kernel.org/regressions/93ffd2ee-fa83-4469-96fb-fb263c26bb=
3c@kernel.dk/T/#t


--=20
An old man doll... just what I always wanted! - Clara

--Vv+fIX42qDF80RtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZautrAAKCRD2uYlJVVFO
o29YAP4qDU6M19ID/p65u1gtfVijgmVI7LdZfaouoZtKiSp6qQD+PnHhjXp+whKs
mfJNPqyLT46rJgrGbCanMlqNG7BeuAA=
=iFmQ
-----END PGP SIGNATURE-----

--Vv+fIX42qDF80RtH--

