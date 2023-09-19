Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DAF7A6616
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjISODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjISODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:03:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F183
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:03:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf55a81eeaso42335135ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695132188; x=1695736988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYn4vYjqybxZ2CzfvZ1C7yMXEKjRphlK8G76dbCmVAc=;
        b=Wle8JRgHm8ZzLdUxX35upMNSuVvIVm+3PWK0oVfkL8FQjV9ckdfC4gZLDBvwDV2wxl
         Mwko+/4xRrqhkc9CQWJjBCXJXuFi93gq4MfYLk0a5ePjPd1kVzMTDIa37BmOOS9OWYGV
         ffB7LH82xjpvvGgyWhP6677We5FixdQNjMF9c8B+UW5fFV7wZ0wGlhu7KKpVt0QW6atD
         /i5cTF8sTz0T4+4VZZp1iSpUoRCsS9Ps1cJRKZY1pPmTW26phjHFv6B+6TASBRjbhGU+
         v5fNWnYz6IFyC/GiMo3444shHl5+NxPJ+pLHXC5ZXAciTSJ1C80ljo0UDCZT6ftMBt7p
         jE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132188; x=1695736988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYn4vYjqybxZ2CzfvZ1C7yMXEKjRphlK8G76dbCmVAc=;
        b=OgXNglCQVqO7ap2JD31+C/Ibgx1Oyu9RsLkJ76vnVVkOr+ekSwS3LPm6VN5RP4/UvI
         pToLozmQjqbLXl4aFFs2piCr1YeEFbpO0Bm2/vj6S2KgMgcMh3/eMmcn8yqAIgX4RkNE
         M/43ww4dm/ZDwFLqf83Fado3CYQiWe/uppDnxBKnWahiKuOvI+fqcwTZS9ECzvb6oe2M
         j5KT8zZ99elti8UjNhnod9obbWPialsdnPEMVEFMapNY0/42MhtbwYjG1xyWJgfw2Mg3
         EFblcGwGm+h/Q8kfUTJ5eG6lIIURMLiycfaYXD05yQTLAmMbiMSzl6JV0fCxfwFh4Uut
         66Iw==
X-Gm-Message-State: AOJu0YwufhzFetGCDzS8i8pIVE3Ar/37uoWYCFw/OVhDt/d2JGJSxb8g
        fZbdbT4imqhBkzAc37xYpa8=
X-Google-Smtp-Source: AGHT+IGwwKUALeHqOp8CRjZ7BjDjcFcSYhkLiMtNnowNteilCqrInFdFlEZiMXIIUrM2Bcc35bHHPg==
X-Received: by 2002:a17:902:e5c4:b0:1c5:82bb:223e with SMTP id u4-20020a170902e5c400b001c582bb223emr3883918plf.67.1695132188320;
        Tue, 19 Sep 2023 07:03:08 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b001beef2c9bffsm10062609plg.85.2023.09.19.07.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:03:07 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CCEAD81A82C8; Tue, 19 Sep 2023 21:03:03 +0700 (WIB)
Date:   Tue, 19 Sep 2023 21:03:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org,
        David Airlie <airlied@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Linux Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Intel-gfx] [REGRESSION] [BISECTED] Panic in
 gen8_ggtt_insert_entries() with v6.5
Message-ID: <ZQmqF7oyrZ32Qdhb@debian.me>
References: <4857570.31r3eYUQgx@natalenko.name>
 <6287208.lOV4Wx5bFT@natalenko.name>
 <2612319.ElGaqSPkdT@natalenko.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qr0otETeDhzUuptw"
Content-Disposition: inline
In-Reply-To: <2612319.ElGaqSPkdT@natalenko.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qr0otETeDhzUuptw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 03:23:28PM +0200, Oleksandr Natalenko wrote:
> /cc Bagas as well (see below).
>=20
> On =C3=BAter=C3=BD 19. z=C3=A1=C5=99=C3=AD 2023 10:26:42 CEST Oleksandr N=
atalenko wrote:
> > /cc Matthew Wilcox and Andrew Morton because of folios (please see belo=
w).
> >=20
> > On sobota 2. z=C3=A1=C5=99=C3=AD 2023 18:14:12 CEST Oleksandr Natalenko=
 wrote:
> > > Hello.
> > >=20
> > > Since v6.5 kernel the following HW:
> > >=20
> > > * Lenovo T460s laptop with Skylake GT2 [HD Graphics 520] (rev 07)
> > > * Lenovo T490s laptop with WhiskeyLake-U GT2 [UHD Graphics 620] (rev =
02)
> > >=20
> > > is affected by the following crash once KDE on either X11 or Wayland =
is started:
> > >=20
> > > i915 0000:00:02.0: enabling device (0006 -> 0007)
> > > i915 0000:00:02.0: vgaarb: deactivate vga console
> > > i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=3Dio+mem,d=
ecodes=3Dio+mem:owns=3Dmem
> > > i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/skl_dmc_v=
er1_27.bin (v1.27)
> > > [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 1
> > > fbcon: i915drmfb (fb0) is primary device
> > > i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> > > =E2=80=A6
> > > memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3D674 'kwin_=
wayland'
> > > BUG: unable to handle page fault for address: ffffb422c2800000
> > > #PF: supervisor write access in kernel mode
> > > #PF: error_code(0x0002) - not-present page
> > > PGD 100000067 P4D 100000067 PUD 1001df067 PMD 10d1cf067 PTE 0
> > > Oops: 0002 [#1] PREEMPT SMP PTI
> > > CPU: 1 PID: 674 Comm: kwin_wayland Not tainted 6.5.0-pf1 #1 a6c58ff41=
a7b8bb16a19f5af9e0e9bce20f9f38d
> > > Hardware name: LENOVO 20FAS2BM0F/20FAS2BM0F, BIOS N1CET90W (1.58 ) 11=
/15/2022
> > > RIP: 0010:gen8_ggtt_insert_entries+0xc2/0x140 [i915]
> > > =E2=80=A6
> > > Call Trace:
> > >  <TASK>
> > >  intel_ggtt_bind_vma+0x3e/0x60 [i915 a83fdc6539431252dba13053979a8b68=
0af86836]
> > >  i915_vma_bind+0x216/0x4b0 [i915 a83fdc6539431252dba13053979a8b680af8=
6836]
> > >  i915_vma_pin_ww+0x405/0xa80 [i915 a83fdc6539431252dba13053979a8b680a=
f86836]
> > >  __i915_ggtt_pin+0x5a/0x130 [i915 a83fdc6539431252dba13053979a8b680af=
86836]
> > >  i915_ggtt_pin+0x78/0x1f0 [i915 a83fdc6539431252dba13053979a8b680af86=
836]
> > >  __intel_context_do_pin_ww+0x312/0x700 [i915 a83fdc6539431252dba13053=
979a8b680af86836]
> > >  i915_gem_do_execbuffer+0xfc6/0x2720 [i915 a83fdc6539431252dba1305397=
9a8b680af86836]
> > >  i915_gem_execbuffer2_ioctl+0x111/0x260 [i915 a83fdc6539431252dba1305=
3979a8b680af86836]
> > >  drm_ioctl_kernel+0xca/0x170
> > >  drm_ioctl+0x30f/0x580
> > >  __x64_sys_ioctl+0x94/0xd0
> > >  do_syscall_64+0x5d/0x90
> > >  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > > =E2=80=A6
> > > note: kwin_wayland[674] exited with irqs disabled
> > >=20
> > > RIP seems to translate into this:
> > >=20
> > > $ scripts/faddr2line drivers/gpu/drm/i915/gt/intel_ggtt.o gen8_ggtt_i=
nsert_entries+0xc2
> > > gen8_ggtt_insert_entries+0xc2/0x150:
> > > writeq at /home/pf/work/devel/own/pf-kernel/linux/./arch/x86/include/=
asm/io.h:99
> > > (inlined by) gen8_set_pte at /home/pf/work/devel/own/pf-kernel/linux/=
drivers/gpu/drm/i915/gt/intel_ggtt.c:257
> > > (inlined by) gen8_ggtt_insert_entries at /home/pf/work/devel/own/pf-k=
ernel/linux/drivers/gpu/drm/i915/gt/intel_ggtt.c:300
> > >=20
> > > Probably, recent PTE-related changes are relevant:
> > >=20
> > > $ git log --oneline --no-merges v6.4..v6.5 -- drivers/gpu/drm/i915/gt=
/intel_ggtt.c
> > > 3532e75dfadcf drm/i915/uc: perma-pin firmwares
> > > 4722e2ebe6f21 drm/i915/gt: Fix second parameter type of pre-gen8 pte_=
encode callbacks
> > > 9275277d53248 drm/i915: use pat_index instead of cache_level
> > > 5e352e32aec23 drm/i915: preparation for using PAT index
> > > 341ad0e8e2542 drm/i915/mtl: Add PTE encode function
> > >=20
> > > Also note Lenovo T14s laptop with TigerLake-LP GT2 [Iris Xe Graphics]=
 (rev 01) is not affected by this issue.
> > >=20
> > > Full dmesg with DRM debug enabled is available in the bugreport I've =
reported earlier [1]. I'm sending this email to make the issue more visible.
> > >=20
> > > Please help.
> > >=20
> > > Thanks.
> > >=20
> > > [1] https://gitlab.freedesktop.org/drm/intel/-/issues/9256
> >=20
> > Matthew,
> >=20
> > Andrzej asked me to try to revert commits 0b62af28f249, e0b72c14d8dc an=
d 1e0877d58b1e, and reverting those fixed the i915 crash for me. The e0b72c=
14d8dc and 1e0877d58b1e commits look like just prerequisites, so I assume 0=
b62af28f249 ("i915: convert shmem_sg_free_table() to use a folio_batch") is=
 the culprit here.
> >=20
> > Could you please check this?
> >=20
> > Our conversation with Andrzej is available at drm-intel GitLab [1].
> >=20
> > Thanks.
> >=20
> > [1] https://gitlab.freedesktop.org/drm/intel/-/issues/9256
>=20
> Bagas,
>=20
> would you mind adding this to the regression tracker please?
>=20

Will add shortly, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--qr0otETeDhzUuptw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQmqAgAKCRD2uYlJVVFO
ow2JAP0edcVoa2ibxwmEKL50V95Q+tuCyFU5b9EKHD4pXbLNgQD+PIaHonsixovR
szsV8iCL4IaV/XCjda0iGXeUtnR3XgM=
=rxM3
-----END PGP SIGNATURE-----

--qr0otETeDhzUuptw--
