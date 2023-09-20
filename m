Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7A7A718F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjITEfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjITEfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:35:41 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1EB0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:35:35 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-493639d6173so2767595e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695184534; x=1695789334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azuj7xcq6eQ3UpWdDpWKUV4XGXp2CNoolDstHELC1/c=;
        b=V4iSnqZ/6sr3irpoMhzhpW9ZiujomcHIDQqwy3fDEWIpnMSkJ+QcRLMqNJj9Cq/djB
         OiQH70l2928/XvbzQUGDasnLNI37lp140dNz/iYKkMYDMAq8U+PrZr5ppvQtOZ4VDp3y
         TtSoEugkDmGBIxggXQDmAUDaazFJq6wwBu+YgoQrIrxESsfhWbD1SNF3on/gEMwKCW0l
         3AfhG7TN7EMn3O0z7cKJnmvJBtvnIZwhlA2eJHdHQ2wZDS330FQtFxXKsHAYOTw3O1Un
         X44WjmKD30ArzWbd+jpvMOA1RBRVrB9czJeQDH/pDjNPep4SZN1hXFbDmxiV47biAaC2
         kZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695184534; x=1695789334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azuj7xcq6eQ3UpWdDpWKUV4XGXp2CNoolDstHELC1/c=;
        b=WFSS9tjM7LuTnm225xYdJw60W5KfvF0vrgB3B8BnxXmogOvVCn977mBHr6z5KOGYbJ
         zSNpBfG4X3gLGlMRQ5tPhPrjUTpVzmDO66df5AUsr/ESW5HaCxDcUsJ4quRfy/5U/vIT
         eu5nGz3Wn/Lyu7N3bFXzxuK96MtTY7H53MxOdvTmoVJRzCBlVsLNnWn9FW9uaM8YUOIG
         oZmaPyuVnbqiRdEChQJyKlIdcQ1o0ezl0LkNrvNGSs+W5C9LVGPscN/YcoFlUk3POZFQ
         78zg5z6Umw5ULk4RjUxi+jCM3oz3x4YXItXC90XqwwPqGQIBnbwSsFNSM6ou/7OB59LA
         H8oA==
X-Gm-Message-State: AOJu0Yw0B4OONVUj3FlSrT8rvgW3ZqyM8Hm8FJb5eq1pptGnjelFirBy
        JjEsne+5i7N8IJ0xa0IsCQhaAF2H9+lDa+xCTtzaeBQLdzg=
X-Google-Smtp-Source: AGHT+IExHNh2WhAbEaA4SQ/mudAUGhUPe8vGstLIvuW9HiXr+96pF1eFwDgZY7qv8ThkhnTMX6WlmFj3D1AE863ju7k=
X-Received: by 2002:a1f:e6c3:0:b0:47e:8a9:478c with SMTP id
 d186-20020a1fe6c3000000b0047e08a9478cmr1678764vkh.16.1695184534162; Tue, 19
 Sep 2023 21:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <202309191848.cMwd2D4d-lkp@intel.com>
In-Reply-To: <202309191848.cMwd2D4d-lkp@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 20 Sep 2023 07:35:23 +0300
Message-ID: <CAOQ4uxjTv+5cB4z8TZQ02c5F3rags1HARoEQG9834A0+_+_twA@mail.gmail.com>
Subject: Re: arch/alpha/include/asm/rwonce.h:25:35: warning: array subscript 0
 is outside array bounds of 'struct inode[11885788707287082]'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
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

On Tue, Sep 19, 2023 at 1:43=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   2cf0f715623872823a72e451243bbf555d10d032
> commit: 0af950f57fefabab628f1963af881e6b9bfe7f38 ovl: move ovl_entry into=
 ovl_inode

Are you sure that this is the regressing commit?
I don't see anything that has changed wrt the ovl_dentry_upper()
call chain.

> date:   3 months ago
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230=
919/202309191848.cMwd2D4d-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230919/202309191848.cMwd2D4d-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309191848.cMwd2D4d-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/compiler.h:246,
>                     from include/linux/build_bug.h:5,
>                     from include/linux/container_of.h:5,
>                     from include/linux/list.h:5,
>                     from include/linux/wait.h:7,
>                     from include/linux/wait_bit.h:8,
>                     from include/linux/fs.h:6,
>                     from fs/overlayfs/util.c:7:
>    In function 'ovl_upperdentry_dereference',
>        inlined from 'ovl_dentry_upper' at fs/overlayfs/util.c:266:9,
>        inlined from 'ovl_path_type' at fs/overlayfs/util.c:184:6:
> >> arch/alpha/include/asm/rwonce.h:25:35: warning: array subscript 0 is o=
utside array bounds of 'struct inode[11885788707287082]' [-Warray-bounds=3D=
]
>       25 |         __unqual_scalar_typeof(x) __x =3D                     =
            \
>          |                                   ^~~
>    include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ=
_ONCE'
>       50 |         __READ_ONCE(x);                                       =
          \
>          |         ^~~~~~~~~~~
>    fs/overlayfs/ovl_entry.h:163:16: note: in expansion of macro 'READ_ONC=
E'
>      163 |         return READ_ONCE(oi->__upperdentry);
>          |                ^~~~~~~~~
>

Why would the type of oi->__upperdentry be considered to be
'struct inode[11885788707287082]'?
I don't understand this report.

Miklos, any clue?

Thanks,
Amir.

>
> vim +25 arch/alpha/include/asm/rwonce.h
>
> d6462858851549 Will Deacon 2019-10-30  11
> d6462858851549 Will Deacon 2019-10-30  12  /*
> d6462858851549 Will Deacon 2019-10-30  13   * Alpha is apparently daft en=
ough to reorder address-dependent loads
> d6462858851549 Will Deacon 2019-10-30  14   * on some CPU implementations=
. Knock some common sense into it with
> d6462858851549 Will Deacon 2019-10-30  15   * a memory barrier in READ_ON=
CE().
> d6462858851549 Will Deacon 2019-10-30  16   *
> d6462858851549 Will Deacon 2019-10-30  17   * For the curious, more infor=
mation about this unusual reordering is
> d6462858851549 Will Deacon 2019-10-30  18   * available in chapter 15 of =
the "perfbook":
> d6462858851549 Will Deacon 2019-10-30  19   *
> d6462858851549 Will Deacon 2019-10-30  20   *  https://kernel.org/pub/lin=
ux/kernel/people/paulmck/perfbook/perfbook.html
> d6462858851549 Will Deacon 2019-10-30  21   *
> d6462858851549 Will Deacon 2019-10-30  22   */
> d6462858851549 Will Deacon 2019-10-30  23  #define __READ_ONCE(x)        =
                                               \
> d6462858851549 Will Deacon 2019-10-30  24  ({                            =
                                       \
> d6462858851549 Will Deacon 2019-10-30 @25       __unqual_scalar_typeof(x)=
 __x =3D                                 \
> d6462858851549 Will Deacon 2019-10-30  26               (*(volatile typeo=
f(__x) *)(&(x)));                      \
> d6462858851549 Will Deacon 2019-10-30  27       mb();                    =
                                       \
> d6462858851549 Will Deacon 2019-10-30  28       (typeof(x))__x;          =
                                       \
> d6462858851549 Will Deacon 2019-10-30  29  })
> d6462858851549 Will Deacon 2019-10-30  30
>
> :::::: The code at line 25 was first introduced by commit
> :::::: d6462858851549c62d73eaa14b31132b0f32d6b6 alpha: Override READ_ONCE=
() with barriered implementation
>
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
