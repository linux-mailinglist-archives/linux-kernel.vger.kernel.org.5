Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13DA7AC291
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjIWOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjIWOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:05:29 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF11A8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 07:05:22 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57ad95c555eso2092828eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695477922; x=1696082722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j7juc4DVm+O/omSDnFgSvCJ2jKt1/TY4VRI13yi4vU=;
        b=NISG+Ca0j+vNCr3iIF1lh7WISqyIEh+3ZAWwcVIK4ZtTjaXU4gsGv8FK1dbVtQBvXP
         6k/ngeHxEG5Ft1E3gyXLhVDCATopJQdixzfsZlg+fXtAIiCgvVuOYpvHBYtuMiz32nCy
         THbIsOc4ESFdcGOgGFkNLkBYBpQ+iPkAgw/K4HWhBgEC54pqhVVHzoFvayukBg6xloRT
         u258FlI2OAl3ykp2/efB32ZbUqUjVIhQ7Q95m/TY+DU4dAqlF2zQG4wUfWwppcgC/Ym/
         TutokFH2OEifxsWuxE6lF4Su4Es8veIRbHdYaBghUnltEgIcbaw7kvN2FIyFC8qYv3U0
         8Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695477922; x=1696082722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j7juc4DVm+O/omSDnFgSvCJ2jKt1/TY4VRI13yi4vU=;
        b=kmB4HIfHUDXko/bfl5FI/QkSlUetGfVIPnny+1/gz66x2qVYEdIz8+u8d/K2Fdsvzp
         al4NkeD0gtHa6wN8iWsHaKQfqoWsEGHmlcuqyT/mivHYLD8fzznX+EwU4vd5KHj2lUqA
         XB2wUzBQDuuSCPCv7ylgZ/DsI4PC2Sik5MEqhTjjzEVih89L72to3EuMqjG6iWacQpFM
         Sa5J5p5nbRrhLShKxNWyVb7h0OqazQf2nU4XbPuind3u1zkaljxggyhHyKPkhsFFRaa+
         CjpSr0Z89KsmRVvilWo+TKhKwUFvvP6JMWgNWozniBPbqAII2tJtUnTYHn9POloqTiLD
         4VoQ==
X-Gm-Message-State: AOJu0YyJ6xuqaMK52aY4/RzfMra4UDs4cQ6Yg85rp5HizS8J6XLZdY/B
        OFiW0xFnHKeFzrNTmOBFfD3UWI9yXXRRwCbp0r8=
X-Google-Smtp-Source: AGHT+IELW7nKbkj0tE8mKgN+jdQ1jRS+BCBSFdJE7V820hqaCIDPkwbunIG3Ypz8JjgWX2x09twSAJva7PKBQSWVf2M=
X-Received: by 2002:a05:6870:f60a:b0:1d5:21f9:7272 with SMTP id
 ek10-20020a056870f60a00b001d521f97272mr2315995oab.23.1695477921949; Sat, 23
 Sep 2023 07:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com> <202309231130.ZI5MdlDc-lkp@intel.com>
In-Reply-To: <202309231130.ZI5MdlDc-lkp@intel.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Sat, 23 Sep 2023 09:05:10 -0500
Message-ID: <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To:     kernel test robot <lkp@intel.com>
Cc:     x86@kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        tglx@linutronix.de, mingo@redhat.com,
        torvalds@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, David.Laight@aculab.com, hpa@zytor.com
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

On Fri, Sep 22, 2023 at 10:25=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Noah,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on tip/x86/core]
> [also build test WARNING on tip/master tip/auto-latest linus/master v6.6-=
rc2 next-20230921]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Noah-Goldstein/x86=
-csum-Remove-unnecessary-odd-handling/20230921-032450
> base:   tip/x86/core
> patch link:    https://lore.kernel.org/r/20230920192300.3772199-1-goldste=
in.w.n%40gmail.com
> patch subject: x86/csum: Remove unnecessary odd handling
> config: x86_64-randconfig-121-20230921 (https://download.01.org/0day-ci/a=
rchive/20230923/202309231130.ZI5MdlDc-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230923/202309231130.ZI5MdlDc-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309231130.ZI5MdlDc-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> arch/x86/lib/csum-partial_64.c:16:45: sparse: sparse: incorrect type i=
n return expression (different base types) @@     expected restricted __wsu=
m @@     got unsigned long long @@
>    arch/x86/lib/csum-partial_64.c:16:45: sparse:     expected restricted =
__wsum
>    arch/x86/lib/csum-partial_64.c:16:45: sparse:     got unsigned long lo=
ng
> >> arch/x86/lib/csum-partial_64.c:16:45: sparse: sparse: incorrect type i=
n return expression (different base types) @@     expected restricted __wsu=
m @@     got unsigned long long @@
>    arch/x86/lib/csum-partial_64.c:16:45: sparse:     expected restricted =
__wsum
>    arch/x86/lib/csum-partial_64.c:16:45: sparse:     got unsigned long lo=
ng
>
> vim +16 arch/x86/lib/csum-partial_64.c
>
>     13
>     14  static inline __wsum csum_finalize_sum(u64 temp64)
>     15  {
>   > 16          return (temp64 + ror64(temp64, 32)) >> 32;
>     17  }
>     18

Just needs a `(__wsum)` cast. Should I post a new patch?
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
