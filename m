Return-Path: <linux-kernel+bounces-17328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF993824BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444AA286740
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E02D607;
	Thu,  4 Jan 2024 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcSZ9N1M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335642D604
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc64318b29so580501a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704410893; x=1705015693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U981NIFXNUGmsC8yAC8KtsHhlf5F7h+l8fIfCAsURA=;
        b=gcSZ9N1Mcx3i+3auJkKHRAg27Xn0uB3LyyhNKVmbdiSw7bVyRBLxXvlpT41DfAmVEX
         n3r8PWSau9U6onLW76P2V69Yy6THUBz2Ygr3679SSt/jxEFijWKvJWM5l5CBK0LoDus7
         1tYZR2UQ50ai8ulxZSnwHcbZd9tIJLJ75USdd7e5rDx2whwcxIPSdM7bsqmxdIFfl1ek
         zTU1p5jhHbbH0F8jndFaOrihtbuYuu/Ev6HHOYE4+n4KWZRjzMa+EN02UduswVYsG06a
         jDjwfkEEmHd7xFwYmQDac6ITxHOd7xbK3lZmyxFENaZTeobd0nfoPoNeBhgxWhvtSPjG
         V6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704410893; x=1705015693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/U981NIFXNUGmsC8yAC8KtsHhlf5F7h+l8fIfCAsURA=;
        b=p3lwpTvzIg75LRXaTe9O41s4u1aQWNotLQ3t0awn3cfPYDPA5MqbBvRngk1SmYfdho
         9hLurmYhLqKSOXyYlGQlTUELjBw22nDg92cvH5ecUNup6AOVkAheGbq5UF5BKi4WV9L0
         bNVMG94Y5Ytjvy/JilrSyrW4KfA9/Ia+dAgsItNvywS/3IIDdFzNEdTOiaGOv5CkhNuD
         FeW0/CPZS4jc9GYQm+AQmJxFhV69c1lExfSVZFJLIdeGqGynLAsDydz77w3lbRKq8yA2
         qMSejXCUeIa8e7MNLMBxjzuq5HxlaHFQ4DsMhDUD21HT1YFzqClIqroxzsUWPzAS15ty
         z4xg==
X-Gm-Message-State: AOJu0Yy4Ju5S4oNSJvMIldw0gPrEKm/pQl4NXs0yMwuoU4sSYrIr7RhT
	gMh4T4t8qipbj+/MuR5eOkU2jYLRDE0RJgxrJgI=
X-Google-Smtp-Source: AGHT+IHDVSB4IkG6A17h8hErnIROWqrwwbl8z8mMt88JkyUZLUsRYcptTPGNSruFsrsdu5wWRIHjYE1lU4tVrb5g6So=
X-Received: by 2002:a05:6870:cd0f:b0:205:d4b1:ee83 with SMTP id
 qk15-20020a056870cd0f00b00205d4b1ee83mr403685oab.21.1704410893349; Thu, 04
 Jan 2024 15:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com> <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
In-Reply-To: <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Thu, 4 Jan 2024 15:28:01 -0800
Message-ID: <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
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

On Sat, Dec 23, 2023 at 2:18=E2=80=AFPM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
> On Sun, Sep 24, 2023 at 7:35=E2=80=AFAM Noah Goldstein <goldstein.w.n@gma=
il.com> wrote:
> >
> > On Sat, Sep 23, 2023 at 4:13=E2=80=AFPM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > From: Noah Goldstein
> > > > Sent: 23 September 2023 15:05
> > > >
> > > > On Fri, Sep 22, 2023 at 10:25=E2=80=AFPM kernel test robot <lkp@int=
el.com> wrote:
> > > > >
> > > > > Hi Noah,
> > > > >
> > > > > kernel test robot noticed the following build warnings:
> > > > >
> > > > > [auto build test WARNING on tip/x86/core]
> > > > > [also build test WARNING on tip/master tip/auto-latest linus/mast=
er v6.6-rc2 next-20230921]
> > > > > [If your patch is applied to the wrong git tree, kindly drop us a=
 note.
> > > > > And when submitting patch, we suggest to use '--base' as document=
ed in
> > > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > > >
> > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Noah-Golds=
tein/x86-csum-Remove-unnecessary-
> > > > odd-handling/20230921-032450
> > > > > base:   tip/x86/core
> > > > > patch link:    https://lore.kernel.org/r/20230920192300.3772199-1=
-goldstein.w.n%40gmail.com
> > > > > patch subject: x86/csum: Remove unnecessary odd handling
> > > > > config: x86_64-randconfig-121-20230921 (https://download.01.org/0=
day-
> > > > ci/archive/20230923/202309231130.ZI5MdlDc-lkp@intel.com/config)
> > > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-
> > > > ci/archive/20230923/202309231130.ZI5MdlDc-lkp@intel.com/reproduce)
> > > > >
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a =
new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202309231130.ZI5M=
dlDc-lkp@intel.com/
> > > > >
> > > > > sparse warnings: (new ones prefixed by >>)
> > > > > >> arch/x86/lib/csum-partial_64.c:16:45: sparse: sparse: incorrec=
t type in return expression
> > > > (different base types) @@     expected restricted __wsum @@     got=
 unsigned long long @@
> > > > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     expected res=
tricted __wsum
> > > > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     got unsigned=
 long long
> > > > > >> arch/x86/lib/csum-partial_64.c:16:45: sparse: sparse: incorrec=
t type in return expression
> > > > (different base types) @@     expected restricted __wsum @@     got=
 unsigned long long @@
> > > > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     expected res=
tricted __wsum
> > > > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     got unsigned=
 long long
> > > > >
> > > > > vim +16 arch/x86/lib/csum-partial_64.c
> > > > >
> > > > >     13
> > > > >     14  static inline __wsum csum_finalize_sum(u64 temp64)
> > > > >     15  {
> > > > >   > 16          return (temp64 + ror64(temp64, 32)) >> 32;
> > > > >     17  }
> > > > >     18
> > > >
> > > > Just needs a `(__wsum)` cast. Should I post a new patch?
> > >
> > > It'll need to be a (__force __wsum) cast.
> > >
> > > I think new patches are expected...
> > >
> > Thank you, posted V4 that should fix the warning.
> > >         David
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,=
 MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
>
> ping.
ping

