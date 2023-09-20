Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D017A8957
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjITQUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjITQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10DAC2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6048EC433CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695226823;
        bh=KcR2/qS3SyhnxYdT6WldJOounUSlQTkI4WgTOPbYWSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vO3E17pGXsNuUh2QKbJYn57dIww7emTD55aoFS8gdJ0ji09a6pZtWL+V7hHWF0itV
         eYcGaQnFCTs46D+KBTAg4tdrcLgbJc1gzVdQnHPkSHCPPuCU66DPdeTetds7c5PDh9
         dPDEtNIKsUuV05NS31V29xltdBaqcSEBCdBJk0JfHv5UQodaSWuIkLxZNg+xdow6Cp
         DjEWB315GObPWCFeGVKm3kSTf8srnImwm9QYgd/MuI2z1f3oNEhd0JhHJ/gex/rAvF
         SKzEVWNz/MENHsk9trFLI+q7nZh3k9+xSfXSxpv2VWFZD+1ryMylsEun4Fn6vemW37
         VAx3gnnISW30A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so44900e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:20:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxgdrn9om5JpahBqT4HvqHURSw5LYtSeu6L8oKQxQomNqKWfmBd
        XjnyKr4P2VTvtnkvhNVWjnLMnuCAy3cCF/UHjA==
X-Google-Smtp-Source: AGHT+IGYK1YDQqxwPAqEtWJEYiTmWTEIUZFZjEHumaUI6MiGKPBi1DFNVXLufyy5dNB5HhSYkNNj51P846+qqrU5IXg=
X-Received: by 2002:a19:654b:0:b0:4ff:7e1e:b4b4 with SMTP id
 c11-20020a19654b000000b004ff7e1eb4b4mr2590776lfj.39.1695226821304; Wed, 20
 Sep 2023 09:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <202309192013.vI4DKHmw-lkp@intel.com> <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
 <a57afd40-71a2-aa68-84cb-44d2a88a1e2b@roeck-us.net> <CAL_JsqJYPJVTxH=d5nYK78+ZWhZAfh4VhEyBLqzyg4MzMhrX0g@mail.gmail.com>
 <194e2d22-9eff-ec6c-9bc9-13b62bda870a@roeck-us.net>
In-Reply-To: <194e2d22-9eff-ec6c-9bc9-13b62bda870a@roeck-us.net>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Sep 2023 11:20:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKcD4AttSVUEi5zuF8S1E4xNdqdZVKiHmk0r79SRW5Cqw@mail.gmail.com>
Message-ID: <CAL_JsqKcD4AttSVUEi5zuF8S1E4xNdqdZVKiHmk0r79SRW5Cqw@mail.gmail.com>
Subject: Re: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0
 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'}
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
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

On Wed, Sep 20, 2023 at 9:30=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 9/20/23 05:44, Rob Herring wrote:
> > On Tue, Sep 19, 2023 at 6:14=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> On 9/19/23 11:37, Rob Herring wrote:
> >>> On Tue, Sep 19, 2023 at 7:09=E2=80=AFAM kernel test robot <lkp@intel.=
com> wrote:
> >>>>
> >>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git master
> >>>> head:   2cf0f715623872823a72e451243bbf555d10d032
> >>>> commit: f1a43aadb5a690e141a3b6700e2a40c1d4dbe088 watchdog: Enable CO=
MPILE_TEST for more drivers
> >>>> date:   5 weeks ago
> >>>> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/2=
0230919/202309192013.vI4DKHmw-lkp@intel.com/config)
> >>>> compiler: m68k-linux-gcc (GCC) 13.2.0
> >>>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/=
archive/20230919/202309192013.vI4DKHmw-lkp@intel.com/reproduce)
> >>>>
> >>>> If you fix the issue in a separate patch/commit (i.e. not just a new=
 version of
> >>>> the same patch/commit), kindly add following tags
> >>>> | Reported-by: kernel test robot <lkp@intel.com>
> >>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202309192013.vI4DKHm=
w-lkp@intel.com/
> >>>>
> >>>> All warnings (new ones prefixed by >>):
> >>>>
> >>>>      In file included from arch/m68k/include/asm/io_mm.h:25,
> >>>>                       from arch/m68k/include/asm/io.h:8,
> >>>>                       from include/linux/io.h:13,
> >>>>                       from drivers/watchdog/machzwd.c:39:
> >>>>      In function 'zf_set_timer',
> >>>>          inlined from 'zf_timer_on' at drivers/watchdog/machzwd.c:21=
8:2:
> >>>>>> arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0 i=
s outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned i=
nt[]'} [-Warray-bounds=3D]
> >>>>         91 |         __w =3D ((*(__force volatile u16 *) ((_addr & 0=
xFFFF0000UL) + ((__v >> 8)<<1)))); \
> >>>>            |         ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>      arch/m68k/include/asm/io_mm.h:228:20: note: in expansion of mac=
ro 'rom_out_le16'
> >>>>        228 |                  : rom_out_le16(isa_itw(port), (val)))
> >>>>            |                    ^~~~~~~~~~~~
> >>>>      arch/m68k/include/asm/io_mm.h:356:42: note: in expansion of mac=
ro 'isa_rom_outw'
> >>>>        356 | #define outw(val, port) ((port) < 1024 ? isa_rom_outw((=
val), (port)) : out_le16((port), (val)))
> >>>>            |                                          ^~~~~~~~~~~~
> >>>>      drivers/watchdog/machzwd.c:74:53: note: in expansion of macro '=
outw'
> >>>>         74 | #define zf_writew(port, data)  { outb(port, INDEX); out=
w(data, DATA_W); }
> >>>>            |                                                     ^~~=
~
> >>>>      drivers/watchdog/machzwd.c:173:17: note: in expansion of macro =
'zf_writew'
> >>>>        173 |                 zf_writew(COUNTER_1, new);
> >>>>            |                 ^~~~~~~~~
> >>>>      In function 'zf_timer_on':
> >>>>      cc1: note: source object is likely at address zero
> >>>
> >>> This seems to be some newish check in gcc which looks for fixed
> >>> pointers below 4KB[1]. The linked issue says more was planned for
> >>> gcc-13, but I haven't found what that is. AFAICT, that shouldn't
> >>> happen with this config because isa_itw() should be variable and the
> >>> compiler shouldn't be able to determine the value of _addr. However, =
a
> >>> config with CONFIG_Q40=3Dn, CONFIG_AMIGA_PCMCIA=3Dn, and
> >>> CONFIG_ATARI_ROM_ISA=3Dn would have a fixed NULL value and could trig=
ger
> >>> the warning. This should also have warnings everywhere outw() (and
> >>> others) are used with a constant port value.
> >>>
> >>> Rob
> >>>
> >>> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99578
> >>
> >> A long time ago, when someone submitted a "cleanup: patch for the mach=
zwd
> >> watchdog driver, I approved it but added this comment.
> >>
> >>   > If anyone is still using the HW supported by this driver, it would
> >>   > be a prime target for conversion to use the watchdog subsystem.
> >>   > This would reduce code size and improve driver stability.
> >>   > _That_ would be useful.
> >>
> >>   > The only reason for replacing 0 with NULL is to make a static chec=
ker
> >>   > happy. This kind of change adds zero value to the code. Instead, i=
t
> >>   > takes time from those who have to review the patches and apply the=
m.
> >>
> >>   > If we ignore such patches, we'll get them again and again, taking
> >>   > away even more time. If we don't ignore them, we encourage submitt=
ers
> >>   > and get even more useless patches. If we try to discourage them, w=
e
> >>   > risk being accused of being unfriendly. This is a perfect lose-los=
e
> >>   > situation for maintainers.
> >
> > Agreed. I keep getting one to fix "of of" in a comment. The fix is
> > always to drop an "of", but that's actually wrong because it's
> > supposed to be "OF". I keep pointing this out and *never* get the
> > right fix. I don't fix it myself because at this point, I find
> > continuing to get "fixes" entertaining.
> >
> >> I do wonder if enabling BUILD_TEST on such drivers is any better.
> >
> > I think that and trivial fixes on a specific driver are completely
> > different. If you want to test build one driver, that's not too hard.
> > Find its kconfig value, turn it on and build the right arch. For tree
> > wide stuff, it's a real pain to ensure you built everything. For
> > example, the only way to build many Cavium Octeon drivers is with the
> > Octeon defconfig which is just one of dozens configs for MIPS (which
> > is still a bigger mess than arm32 ever was).
> >
>
> Sure, but I still argue that this isn't worth it for drivers like this on=
e.
> Are you going to submit a fix ? Because otherwise I'll submit a patch
> to drop COMPILE_TEST from MACHZ_WDT.

I honestly don't know what the fix is. There's a compiler flag to
allow 0 address, but that seems like a big hammer. From what I read on
the fix for gcc-12, we shouldn't be getting this, but I haven't
confirmed. I was hoping for comment from Geert as the issue doesn't
appear to be the driver, but the arch code.

Furthermore, I just built the same HEAD and config as reported and
don't see this error. I'm using kernel.org nolibc gcc 13.2.0 which
should be the same version.

Rob
