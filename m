Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DEC76B9A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjHAQ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHAQ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:28:13 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0BE10CA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:28:12 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63cf96c37beso26717766d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690907291; x=1691512091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xPDjNj+bRgDC1j1IMv7oxTopb6gzOMFHFdUvlWj/9s=;
        b=f4ma9t02LSsWv/kUEm65ry524cdBk0OCujy2V6ngKk4tmZHYHODT7JEmNYUOxnYfDu
         muIMyhImBtuyXmNu2ejMfCWUdHv7fal2hgxOuKkeAhK1W4bPzEwH/ZfShdQj0u7KiUyZ
         M3hX08rSnUHaIsLlHuS5NzzTo1UrPt7mQmpHJZsW5AURYSiwwvqX+nFf79/yGeLCd70Z
         yw1lVatavNKQ6U4q57D1b2yViebZgCbbefvBsbqFI3zcU05viaXO0mnjmAHmKpMBqkEW
         YJwqeJL4Zx0jtPntC/v8FMD4IM/gxclZrxH/Y5kG0DjiZ0RY1tk22ZVUk44jv4sUBI0x
         u+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690907291; x=1691512091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xPDjNj+bRgDC1j1IMv7oxTopb6gzOMFHFdUvlWj/9s=;
        b=dLhWlv+IpezfEqie4NkXb7mBSTFarFcNmvtu4WIkjeSdBLDtqEFuAUcTUYkpwvfJfh
         64VGwbs+JXOsYfLaqCkIdA9We/4kVNMVHj+hE6djsg9VwRnHNfa3/opj9dS8qJkldSFj
         HOWEYWAbuArqbiNWzbkoVi/NLONjcinsA1Ndahz7QqulL0Ztp7ntcQs0vacE+OWtBZvO
         Hp6qENBbu01EUpreYdqKuoARfKQBbPPNbrWZjnCYC88z2QZvvh6irEdylbY9hYN8BzZH
         1ROjStoxW4BWGEKrIX9x9xFqI9/R1OSBhA6UnYbZX4T9DihHOEMN/QRQik5V+rgZFf1y
         lMVQ==
X-Gm-Message-State: ABy/qLYRosD6EPaM54BHKMjrJnt54pZirwwtcFQIG6vkxADHmJFT8zU/
        PAz5prVTtPNwBTR6Zz6lTwM/5BhaZVx6Wz+1CFPJ0Q==
X-Google-Smtp-Source: APBJJlFvv94MKeWwxRdCoN+H/svBm6lgolCtroBwJjXtgyCBuxzkx5c5JaPj/WuFJiE4Oxslyqg4ZEX/RRwi4fzQF4U=
X-Received: by 2002:ad4:55c8:0:b0:61b:65f4:2a15 with SMTP id
 bt8-20020ad455c8000000b0061b65f42a15mr14633412qvb.12.1690907290859; Tue, 01
 Aug 2023 09:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <202307242310.CdOnd2py-lkp@intel.com> <CAMhs-H8Zz_8w7Lcq5f=mEiucjwx+TAfBbVZ12PE1a47ioxTu2A@mail.gmail.com>
In-Reply-To: <CAMhs-H8Zz_8w7Lcq5f=mEiucjwx+TAfBbVZ12PE1a47ioxTu2A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Aug 2023 09:28:00 -0700
Message-ID: <CAKwvOd=NdeDEp_kv9TyZk8biO1u0bN2r67kDAWQK195hbBzHUw@mail.gmail.com>
Subject: Re: drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match'
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 1:04=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi!
>
> On Mon, Jul 24, 2023 at 5:21=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
> > commit: 6f3b15586eef736831abe6a14f2a6906bc0dc074 clk: ralink: add clock=
 and reset driver for MTMIPS SoCs
> > date:   5 weeks ago
> > config: x86_64-buildonly-randconfig-r003-20230723 (https://download.01.=
org/0day-ci/archive/20230724/202307242310.CdOnd2py-lkp@intel.com/config)
> > compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.gi=
t 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230724/2023072423=
10.CdOnd2py-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/clk/ralink/clk-mtmips.c:309:9: warning: variable 'ret' is un=
initialized when used here [-Wuninitialized]
> >            return ret;
> >                   ^~~
> >    drivers/clk/ralink/clk-mtmips.c:285:9: note: initialize the variable=
 'ret' to silence this warning
> >            int ret, i;
> >                   ^
> >                    =3D 0
> >    drivers/clk/ralink/clk-mtmips.c:359:9: warning: variable 'ret' is un=
initialized when used here [-Wuninitialized]
> >            return ret;
> >                   ^~~
> >    drivers/clk/ralink/clk-mtmips.c:335:9: note: initialize the variable=
 'ret' to silence this warning
> >            int ret, i;
> >                   ^
> >                    =3D 0
>
> This two errors were already fixed in:
>
> 6e68dae946e3: ("clk: ralink: mtmips: Fix uninitialized use of ret in
> mtmips_register_{fixed,factor}_clocks()")
>
> > >> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mt=
mips_of_match' [-Wunused-const-variable]
> >    static const struct of_device_id mtmips_of_match[] =3D {
> >                                     ^
> >    3 warnings generated.
>
> This one is because CONFIG_OF is disabled so 'of_match_node()' turns
> into a dummy macro. What would be the correct approach here?
> Add select OF in Kconfig for this driver or silence the warning
> declaring 'mtmips_of_match' with __maybe_unused?

That or perhaps wrapping the definition of `mtmips_of_match` in
`#ifdef CONFIG_OF`?

>
> Thanks in advance for clarification.
>
> Best regards,
>     Sergio Paracuellos
>
> >
> >
> > vim +/mtmips_of_match +821 drivers/clk/ralink/clk-mtmips.c
> >
> >    820
> >  > 821  static const struct of_device_id mtmips_of_match[] =3D {
> >    822          {
> >    823                  .compatible =3D "ralink,rt2880-sysc",
> >    824                  .data =3D &rt2880_clk_data,
> >    825          },
> >    826          {
> >    827                  .compatible =3D "ralink,rt3050-sysc",
> >    828                  .data =3D &rt305x_clk_data,
> >    829          },
> >    830          {
> >    831                  .compatible =3D "ralink,rt3052-sysc",
> >    832                  .data =3D &rt305x_clk_data,
> >    833          },
> >    834          {
> >    835                  .compatible =3D "ralink,rt3352-sysc",
> >    836                  .data =3D &rt3352_clk_data,
> >    837          },
> >    838          {
> >    839                  .compatible =3D "ralink,rt3883-sysc",
> >    840                  .data =3D &rt3883_clk_data,
> >    841          },
> >    842          {
> >    843                  .compatible =3D "ralink,rt5350-sysc",
> >    844                  .data =3D &rt5350_clk_data,
> >    845          },
> >    846          {
> >    847                  .compatible =3D "ralink,mt7620-sysc",
> >    848                  .data =3D &mt7620_clk_data,
> >    849          },
> >    850          {
> >    851                  .compatible =3D "ralink,mt7628-sysc",
> >    852                  .data =3D &mt76x8_clk_data,
> >    853          },
> >    854          {
> >    855                  .compatible =3D "ralink,mt7688-sysc",
> >    856                  .data =3D &mt76x8_clk_data,
> >    857          },
> >    858          {}
> >    859  };
> >    860
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
>


--=20
Thanks,
~Nick Desaulniers
