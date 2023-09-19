Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E87A6AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjISShl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjISShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:37:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CAF9D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:37:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59C2C433CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695148654;
        bh=SZCi30lXAL9PMLnakDIVwpPGl0ou1Y/fgS+6JaO3cRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fHtjSs1N/wQoAHhv+DDZMDDIbF4Ui+GrHXGv3C1uITpBsqjUzZi0/U3niDJB4feOt
         JiTsu2XbQVEkd0zshzTXbbq/3JC2ucKvEXZYtO7hlzJ7aLVLHJorW6JIsxkUGfBW3s
         qSthUBTpepDcxgtCqApVH9jRaTYGM9+0lR/yrvE5Cs4lDQ4y8/5rxOksO/PM8uoes2
         IrlnpwsBOsGZeTowJ0ccPiUg0O0F2MREamLuOECFPcCeefYQ3l6soSjYea2VaxEqsL
         dswpWYGOEu4SFQdUDf8lcacKlNSa/faRHRzgwDIJugwPbl0YMKq8WAMGqNfYfqT3J0
         Gd3b8zznoFU/g==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so100191321fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:37:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YyVzay4752FuoXJWkXN/Fcj88CtHjccXqcq2/lAt/1iOpAbQQZl
        thEkE5VtL3BvUYvIg1+j9y35A3nxIOWuC4iwuQ==
X-Google-Smtp-Source: AGHT+IHh9rud6D/2NK2Oyt7X5iqW0MyRB7qXn8hbmlU0moQeXDHnJl0giXjPyZw3/gbBPsCJBY5EjQAWErARHZgCoBI=
X-Received: by 2002:a2e:7405:0:b0:2c0:34f9:5a6a with SMTP id
 p5-20020a2e7405000000b002c034f95a6amr210916ljc.34.1695148652805; Tue, 19 Sep
 2023 11:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <202309192013.vI4DKHmw-lkp@intel.com>
In-Reply-To: <202309192013.vI4DKHmw-lkp@intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Sep 2023 13:37:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
Message-ID: <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
Subject: Re: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0
 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'}
To:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 7:09=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   2cf0f715623872823a72e451243bbf555d10d032
> commit: f1a43aadb5a690e141a3b6700e2a40c1d4dbe088 watchdog: Enable COMPILE=
_TEST for more drivers
> date:   5 weeks ago
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/202309=
19/202309192013.vI4DKHmw-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230919/202309192013.vI4DKHmw-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309192013.vI4DKHmw-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from arch/m68k/include/asm/io_mm.h:25,
>                     from arch/m68k/include/asm/io.h:8,
>                     from include/linux/io.h:13,
>                     from drivers/watchdog/machzwd.c:39:
>    In function 'zf_set_timer',
>        inlined from 'zf_timer_on' at drivers/watchdog/machzwd.c:218:2:
> >> arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0 is ou=
tside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]=
'} [-Warray-bounds=3D]
>       91 |         __w =3D ((*(__force volatile u16 *) ((_addr & 0xFFFF00=
00UL) + ((__v >> 8)<<1)))); \
>          |         ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/m68k/include/asm/io_mm.h:228:20: note: in expansion of macro 'rom=
_out_le16'
>      228 |                  : rom_out_le16(isa_itw(port), (val)))
>          |                    ^~~~~~~~~~~~
>    arch/m68k/include/asm/io_mm.h:356:42: note: in expansion of macro 'isa=
_rom_outw'
>      356 | #define outw(val, port) ((port) < 1024 ? isa_rom_outw((val), (=
port)) : out_le16((port), (val)))
>          |                                          ^~~~~~~~~~~~
>    drivers/watchdog/machzwd.c:74:53: note: in expansion of macro 'outw'
>       74 | #define zf_writew(port, data)  { outb(port, INDEX); outw(data,=
 DATA_W); }
>          |                                                     ^~~~
>    drivers/watchdog/machzwd.c:173:17: note: in expansion of macro 'zf_wri=
tew'
>      173 |                 zf_writew(COUNTER_1, new);
>          |                 ^~~~~~~~~
>    In function 'zf_timer_on':
>    cc1: note: source object is likely at address zero

This seems to be some newish check in gcc which looks for fixed
pointers below 4KB[1]. The linked issue says more was planned for
gcc-13, but I haven't found what that is. AFAICT, that shouldn't
happen with this config because isa_itw() should be variable and the
compiler shouldn't be able to determine the value of _addr. However, a
config with CONFIG_Q40=3Dn, CONFIG_AMIGA_PCMCIA=3Dn, and
CONFIG_ATARI_ROM_ISA=3Dn would have a fixed NULL value and could trigger
the warning. This should also have warnings everywhere outw() (and
others) are used with a constant port value.

Rob

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99578
