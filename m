Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B267A6C01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjISUGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISUGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:06:13 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1996BAB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:06:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-65643a83758so20802036d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695153967; x=1695758767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQnPY0z4taKHApL77Ffx1d50jLqp8wyhR11FZPBq+qk=;
        b=Q2QGNXeDEo1JGCIR/XTkVXSMJ5zrG2y68S9uvc3X+n3kKa+z1VXuoOzTf1Dyu0q2dF
         BNtAAenk9HOoWMQsjmdxLUCxOMuhez6g24dR0FOX1IV81y7geKrOIO35S/rjlPueLowh
         yQtjt9EPcxV4WNCDql+uhzquXSZ3O/n+kCbJbLBtValLfsuIWhN0udN+1vTLilklMOFl
         aO2L0Jm48h0ae2dl+cQoIY/1klB5fqn5WqpkYIJV8k9nde9pEqIpLDlsdr/l3F5uaIuy
         GDCFVzGpFA42R61GodXpl+NhdGrjIOaFBrm6oGwoR/+Iqz+N4IqooKUyyDJDcPHmpm7C
         UoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695153967; x=1695758767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQnPY0z4taKHApL77Ffx1d50jLqp8wyhR11FZPBq+qk=;
        b=fJ1EON4yIIeB6ECdBA3ApJ9VM3P+m4T96ldRe3ZacPWgC5jJoZXQuFnrtYGKvV07PB
         24H3n9HHA3XMtPLpnfn/jDBx4OD2o4JSJbE0wCAKdWpubasbKL4il0KTaVOZiYonGVWF
         Q48pIE6h9SPfBSGsefAAGqJGTv3YqU5d4Jozcdo0ZeRlj+YaRzLovxA2Udf5eoC0zN8p
         rERBDtLAyaV/PIvzcB5dp8EPJ4v7CUFPUbdNmfwwojCnyL/MsVz4QZnvnKcGzc9Eo7zM
         0RTJo/X/UWslXcQgqS8bc4LuJddNXV7z1izoizUhB78rcyh36vi9auI/4fZ2nrXp3G0p
         CH4Q==
X-Gm-Message-State: AOJu0Yy4cDJfjHGwOCvUZJw+rghbQbP3BwkoiJhCdGMXr88S8xFrh65m
        f0OQKzduKwQec4ilkt586hZbGvjoCMmMs0PlUIAWgg==
X-Google-Smtp-Source: AGHT+IGwcqVkGXd3Zf3N82ll6JyqL1rHSLbA5bxgmmbMggRlybY8gxv4W57FTpofp4S8SxPCW/NJEqRwqbRLF7XD53I=
X-Received: by 2002:a0c:e304:0:b0:658:4cae:b43a with SMTP id
 s4-20020a0ce304000000b006584caeb43amr217436qvl.4.1695153967060; Tue, 19 Sep
 2023 13:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <202309192257.IAbw1lnx-lkp@intel.com> <ZQm2W9r2a+cgeaEM@rli9-mobl>
In-Reply-To: <ZQm2W9r2a+cgeaEM@rli9-mobl>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Sep 2023 13:05:52 -0700
Message-ID: <CAKwvOdmUmLRMP0OUOJkPSKucn3NJTxz7uJGWfn83LX=gbZ-5Zw@mail.gmail.com>
Subject: Re: warning: unknown warning option '-Wrestrict'
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 7:56=E2=80=AFAM Philip Li <philip.li@intel.com> wro=
te:
>
> On Tue, Sep 19, 2023 at 10:40:57PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   2cf0f715623872823a72e451243bbf555d10d032
> > commit: feb843a469fb0ab00d2d23cfb9bcc379791011bb kbuild: add $(CLANG_FL=
AGS) to KBUILD_CPPFLAGS
> > date:   4 months ago
> > config: um-allnoconfig (https://download.01.org/0day-ci/archive/2023091=
9/202309192257.IAbw1lnx-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.gi=
t 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20230919/202309192257.IAbw1lnx-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309192257.IAbw1lnx-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
>
> Sorry for the false report. Kindly ignore this.

No worries, I just checked `make LLVM=3D1 arch=3Dum -j128 allnoconfig all`
and had no issue.

>
> >
> > >> warning: unknown warning option '-Wrestrict' [-Wunknown-warning-opti=
on]
> > >> warning: unknown warning option '-Wformat-overflow'; did you mean '-=
Wshift-overflow'? [-Wunknown-warning-option]
> > >> warning: unknown warning option '-Wformat-truncation' [-Wunknown-war=
ning-option]
> > >> warning: unknown warning option '-Wstringop-overflow'; did you mean =
'-Wshift-overflow'? [-Wunknown-warning-option]
> >    arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for =
function 'foo' [-Wmissing-prototypes]
> >       17 | void foo(void)
> >          |      ^
> >    arch/x86/um/user-offsets.c:17:1: note: declare 'static' if the funct=
ion is not intended to be used outside of this translation unit
> >       17 | void foo(void)
> >          | ^
> >          | static
> >    5 warnings generated.
> >    error: unknown warning option '-Wrestrict' [-Werror,-Wunknown-warnin=
g-option]
> >    error: unknown warning option '-Wformat-overflow'; did you mean '-Ws=
hift-overflow'? [-Werror,-Wunknown-warning-option]
> >    error: unknown warning option '-Wformat-truncation' [-Werror,-Wunkno=
wn-warning-option]
> >    error: unknown warning option '-Wstringop-overflow'; did you mean '-=
Wshift-overflow'? [-Werror,-Wunknown-warning-option]
> >    make[2]: *** [scripts/Makefile.build:252: scripts/mod/empty.o] Error=
 1
> >    error: unknown warning option '-Wrestrict' [-Werror,-Wunknown-warnin=
g-option]
> >    error: unknown warning option '-Wformat-overflow'; did you mean '-Ws=
hift-overflow'? [-Werror,-Wunknown-warning-option]
> >    error: unknown warning option '-Wformat-truncation' [-Werror,-Wunkno=
wn-warning-option]
> >    error: unknown warning option '-Wstringop-overflow'; did you mean '-=
Wshift-overflow'? [-Werror,-Wunknown-warning-option]
> >    make[2]: *** [scripts/Makefile.build:114: scripts/mod/devicetable-of=
fsets.s] Error 1
> >    make[2]: Target 'scripts/mod/' not remade because of errors.
> >    make[1]: *** [Makefile:1286: prepare0] Error 2
> >    make[1]: Target 'prepare' not remade because of errors.
> >    make: *** [Makefile:226: __sub-make] Error 2
> >    make: Target 'prepare' not remade because of errors.
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
>


--=20
Thanks,
~Nick Desaulniers
