Return-Path: <linux-kernel+bounces-10599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE0981D6C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201591C217EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09F718054;
	Sat, 23 Dec 2023 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqbT509H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9056171A8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59052ab970eso1647599eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703369942; x=1703974742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuX0pyeta/efwKHKSu3U/wEG3JMK1+kJ2PCoBewIuNE=;
        b=JqbT509HZJWprFhOncOYIVs3tkcwWbyPXT8o+B/nZdVXw+pM34/WOSLLnn8BoE1Ud9
         qWzmf4UOLj2meUpG2N9dbR+TfCmndXHiJETaiOuvGvigW/COu/+9Sfw1ESaJj5/+H+aj
         GdIulm3chyJMgUvAo/gMFvA7LoZPWNuAFMzIAOxfXy0eQT0jUrZj1Q9RHy8WYNmm+3/N
         LJ3q/tCvcC1xae0Ku1yVH12xuMmxnS/sd6WJvO4OFK4zkVfEV2lpy5dpHNoMuqkmMJkw
         ZIiob1/WO1FPwKbdgT0N/8KsmMEOeq7lxe6BjeS4lqYgkdJE5sTjrprQWS1qIQqMykse
         nOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703369942; x=1703974742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuX0pyeta/efwKHKSu3U/wEG3JMK1+kJ2PCoBewIuNE=;
        b=AOGwpX6BlQCOWjadHsUFT4rkKHV8ee8bl40puM2ez1/RZ18CkIdYDSTLKasmCK7S4X
         oGVxItS2hxjohAMXtHilcvsWdalrWDWGO1f8M85jejJ4hLBktnihPgk9MKfU6uqTs6gw
         YvRArf01xfUfG1qe9/f16pKFq9lAHeMhbXVaQYL2H77rDuZzz8dSECbZ6MPP02lS0xLL
         9sMvKWAe5E2W6PwVtbTP67rYQ3WXfZwM+wb1/M7Yf/hAg787E4SFH7ufQTUTqAVdfIoV
         OQf+6PKo5/6cqbfxRKkzILhD2tCHXRhY2TwXxiMVX1LHm5o60wrJnlSHjT/AHO7hBx+F
         7SgQ==
X-Gm-Message-State: AOJu0YxHlMBfIGp44Fec2J98bx2vEn46BfP2m8bBMWJppLwGZc1lxtTt
	EIRBhxzPcCt5Kbw1QMXxYZSMNNu2AyROZ2SnUk8=
X-Google-Smtp-Source: AGHT+IHNKMmPzMXot38poTF8Vvr8C4pDJtSJBgCwzLFKX3f4l+vgGfZXC3wpAzQhKpK8WbxiISxTfAuvoLALy4cK6s8=
X-Received: by 2002:a05:6871:8a97:b0:203:824f:a343 with SMTP id
 tm23-20020a0568718a9700b00203824fa343mr1453320oab.0.1703369942512; Sat, 23
 Dec 2023 14:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com> <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
In-Reply-To: <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Sat, 23 Dec 2023 14:18:50 -0800
Message-ID: <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To: David Laight <David.Laight@aculab.com>
Cc: kernel test robot <lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 7:35=E2=80=AFAM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
> On Sat, Sep 23, 2023 at 4:13=E2=80=AFPM David Laight <David.Laight@aculab=
.com> wrote:
> >
> > From: Noah Goldstein
> > > Sent: 23 September 2023 15:05
> > >
> > > On Fri, Sep 22, 2023 at 10:25=E2=80=AFPM kernel test robot <lkp@intel=
.com> wrote:
> > > >
> > > > Hi Noah,
> > > >
> > > > kernel test robot noticed the following build warnings:
> > > >
> > > > [auto build test WARNING on tip/x86/core]
> > > > [also build test WARNING on tip/master tip/auto-latest linus/master=
 v6.6-rc2 next-20230921]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a n=
ote.
> > > > And when submitting patch, we suggest to use '--base' as documented=
 in
> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > >
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Noah-Goldste=
in/x86-csum-Remove-unnecessary-
> > > odd-handling/20230921-032450
> > > > base:   tip/x86/core
> > > > patch link:    https://lore.kernel.org/r/20230920192300.3772199-1-g=
oldstein.w.n%40gmail.com
> > > > patch subject: x86/csum: Remove unnecessary odd handling
> > > > config: x86_64-randconfig-121-20230921 (https://download.01.org/0da=
y-
> > > ci/archive/20230923/202309231130.ZI5MdlDc-lkp@intel.com/config)
> > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-
> > > ci/archive/20230923/202309231130.ZI5MdlDc-lkp@intel.com/reproduce)
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202309231130.ZI5Mdl=
Dc-lkp@intel.com/
> > > >
> > > > sparse warnings: (new ones prefixed by >>)
> > > > >> arch/x86/lib/csum-partial_64.c:16:45: sparse: sparse: incorrect =
type in return expression
> > > (different base types) @@     expected restricted __wsum @@     got u=
nsigned long long @@
> > > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     expected restr=
icted __wsum
> > > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     got unsigned l=
ong long
> > > > >> arch/x86/lib/csum-partial_64.c:16:45: sparse: sparse: incorrect =
type in return expression
> > > (different base types) @@     expected restricted __wsum @@     got u=
nsigned long long @@
> > > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     expected restr=
icted __wsum
> > > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     got unsigned l=
ong long
> > > >
> > > > vim +16 arch/x86/lib/csum-partial_64.c
> > > >
> > > >     13
> > > >     14  static inline __wsum csum_finalize_sum(u64 temp64)
> > > >     15  {
> > > >   > 16          return (temp64 + ror64(temp64, 32)) >> 32;
> > > >     17  }
> > > >     18
> > >
> > > Just needs a `(__wsum)` cast. Should I post a new patch?
> >
> > It'll need to be a (__force __wsum) cast.
> >
> > I think new patches are expected...
> >
> Thank you, posted V4 that should fix the warning.
> >         David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)

ping.

