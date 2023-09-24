Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33C7ACA0B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjIXOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIXOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:36:13 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842CE111
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:36:06 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1dce0f9e222so1423624fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695566164; x=1696170964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ/00UTDB27GXD5poXkBVO7NXs6vYfukJqINZetFUFY=;
        b=F+P08TLM5rI8Cflz/Tk/udwwKOfTllJnByuzNOO/IJZZkObpkpUzolP0yjtzCraEx5
         CnW9Ql3UWxgCT/Vw4pFDdsRJl7QH2LUWnAxS57xTJdTCjt/sfymbGJeMe+wRiXCmgZJg
         9L2Sxldb1tAfsBq+3+nVOpTCxU1Yj+sPuuv0pi6uYW34nvdqC3PoPLACEC1qUGmoIzty
         GwzZEySsuPNFoh8tKoTUxQQigF8v3TKle8xdJsaaEnf8MGqKkGs4cIgGqRCp5MhjsuIw
         UQYPSbrwPx2zSDCKbTudI9FSgviT6uuHSMe+66YcidXqHCAiWeP695rOjN24iCfkaJ91
         30ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695566164; x=1696170964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ/00UTDB27GXD5poXkBVO7NXs6vYfukJqINZetFUFY=;
        b=McGj/cAe0HKrHdh2T0NsDsdRpl5ZX4Eeuaf4MC+/O/ff7VeuoCmIJ7z3zS1vlo3L7y
         QZWIchfKC53yztilELqYIkjoNsO+9ZQOq+PvMdNpQL1ApvS3eb90ho+Cq0FFt0PXa9Z7
         Nt8nVWaRWo7dVvohJwabrdJ+Qapy1bPLliKaIqlNlB76UF35wINtndkfpeoe4OjDct4n
         Q9/kYynGl9sPWZ+4fmJegKjKJbDJPyTu/wd59VH+0Z5nhSNqFUhX2lSz+zQhacFrw6g+
         X9zufyJqf+RnBeR673egGmyJ2/ok9juZaEjFV3jbL7m2VlPiAYrvwBj6V5LjI5vy5KLw
         SJBw==
X-Gm-Message-State: AOJu0YybjXzIvDZTMTMzM/qxq7+/LRFZzuHbFRnNtXFtORN5N9/AbCeR
        bGCPajf2j4wftHTYQsXRI83Vm/Vhj0vGgJa2Ado=
X-Google-Smtp-Source: AGHT+IEFyPM7kaXP5xYMce0IylX4IjXWF3Ts4oSgQZ3Ru/iEBU5tMPbD42Lw4PuWt0p0VZnTIPBVP8nD04wI9sOwTvs=
X-Received: by 2002:a05:6870:c596:b0:1b0:4fc5:2e4b with SMTP id
 ba22-20020a056870c59600b001b04fc52e4bmr4997697oab.9.1695566164110; Sun, 24
 Sep 2023 07:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com> <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com>
In-Reply-To: <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Sun, 24 Sep 2023 09:35:51 -0500
Message-ID: <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To:     David Laight <David.Laight@aculab.com>
Cc:     kernel test robot <lkp@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 4:13=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Noah Goldstein
> > Sent: 23 September 2023 15:05
> >
> > On Fri, Sep 22, 2023 at 10:25=E2=80=AFPM kernel test robot <lkp@intel.c=
om> wrote:
> > >
> > > Hi Noah,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > [auto build test WARNING on tip/x86/core]
> > > [also build test WARNING on tip/master tip/auto-latest linus/master v=
6.6-rc2 next-20230921]
> > > [If your patch is applied to the wrong git tree, kindly drop us a not=
e.
> > > And when submitting patch, we suggest to use '--base' as documented i=
n
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Noah-Goldstein=
/x86-csum-Remove-unnecessary-
> > odd-handling/20230921-032450
> > > base:   tip/x86/core
> > > patch link:    https://lore.kernel.org/r/20230920192300.3772199-1-gol=
dstein.w.n%40gmail.com
> > > patch subject: x86/csum: Remove unnecessary odd handling
> > > config: x86_64-randconfig-121-20230921 (https://download.01.org/0day-
> > ci/archive/20230923/202309231130.ZI5MdlDc-lkp@intel.com/config)
> > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-
> > ci/archive/20230923/202309231130.ZI5MdlDc-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202309231130.ZI5MdlDc=
-lkp@intel.com/
> > >
> > > sparse warnings: (new ones prefixed by >>)
> > > >> arch/x86/lib/csum-partial_64.c:16:45: sparse: sparse: incorrect ty=
pe in return expression
> > (different base types) @@     expected restricted __wsum @@     got uns=
igned long long @@
> > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     expected restric=
ted __wsum
> > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     got unsigned lon=
g long
> > > >> arch/x86/lib/csum-partial_64.c:16:45: sparse: sparse: incorrect ty=
pe in return expression
> > (different base types) @@     expected restricted __wsum @@     got uns=
igned long long @@
> > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     expected restric=
ted __wsum
> > >    arch/x86/lib/csum-partial_64.c:16:45: sparse:     got unsigned lon=
g long
> > >
> > > vim +16 arch/x86/lib/csum-partial_64.c
> > >
> > >     13
> > >     14  static inline __wsum csum_finalize_sum(u64 temp64)
> > >     15  {
> > >   > 16          return (temp64 + ror64(temp64, 32)) >> 32;
> > >     17  }
> > >     18
> >
> > Just needs a `(__wsum)` cast. Should I post a new patch?
>
> It'll need to be a (__force __wsum) cast.
>
> I think new patches are expected...
>
Thank you, posted V4 that should fix the warning.
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
