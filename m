Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A21792C16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353737AbjIERGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjIEP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:59:03 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2CCD2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:58:42 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-64b3ae681d1so12943536d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 08:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693929522; x=1694534322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8PsOUdlYxNm6DRIQuojE/DnPuosQCXfxt+6iE22b50=;
        b=MGA/r38IsqKT0As46X5NECxj23E/EcOE82GmAQgQekQ+lTlv+naD6SWUuNNdGqmwTo
         Vpz50ek76Z8NFmKrvJie+kT+HXhWsk0b6Q5nu6DogtvuLbfNZiKlt/gUNOHdi0jIo/iQ
         4s/11hvV9ijJlLU5zvsuR5N6Lx6g0syI/Qw0GB9dffPYdRru1cvAcath+kTHVbG6QyjT
         Q3Un1RpZBzIWRZ4x7F8Nun2mGnZTt+sNZCKsy7pNpgETLXljspb2YXVwvDDM8KFe6ujX
         +4AvxahIOLt69EZ9XOd7uDHA22PlpLRqBfnna+CWQ1MZ2qJfpHbcS6rSypP3s26WhkzM
         x10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693929522; x=1694534322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8PsOUdlYxNm6DRIQuojE/DnPuosQCXfxt+6iE22b50=;
        b=Do8kUIceAWgROToLAp147tLgMbQ/xlKDl9vNNpcSeEBKyCAVc9UIXN/vUGbOO4NOAd
         t2cLiS0wVYDb64E9+jeewKA0JfHtJZsinuWLLOLiC1gt9F/pqJmtlJnqW5tdg1ZkZoXP
         tmst9R9ligVxR3dkEzbzHp2qWS4Ciq0uXCuxuREmOz6OxqaqQKJ/kYszZqB4XJi7amCf
         Tb4Qz+spB/u5fRFlE9iF6g4fcU0WXViWb7FSqJVT1BMSPm4IDWnjMNC1e+YuPTFJoPzP
         Ww4d2fTl1byMmPjlO1IhAqSb72nxYNAztjJusNWxmM4BOm35YCwY8tbcVoi80uLc9q3n
         klJw==
X-Gm-Message-State: AOJu0YxCSszLzlmIjQ0EBHo7O1A0BoGmrLbYliGg10ROedYOCW8Y4pPI
        G/yBlg/Z/yA25HcV4AoLLhhrA5ET4dFr42EBXNnd/JHlGCtI3xjJor0=
X-Google-Smtp-Source: AGHT+IH944pHkAw9VZ43TlFt4vDYO+U/xgVcpDbk7Uk7nqpkI1sHOyU1e3MQrvHBpKUd+yKPV3EdWCfKvx4JwEp8Mlo=
X-Received: by 2002:a0c:e503:0:b0:64a:2b04:c10a with SMTP id
 l3-20020a0ce503000000b0064a2b04c10amr12801883qvm.29.1693929521690; Tue, 05
 Sep 2023 08:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZPcuvEg5Mf5MoM2L@rli9-mobl>
In-Reply-To: <ZPcuvEg5Mf5MoM2L@rli9-mobl>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Sep 2023 08:58:30 -0700
Message-ID: <CAKwvOdm281duZtm7t6MHnKpkJr8DU7=wRs_ud7uAWzKXmF7mBQ@mail.gmail.com>
Subject: Re: arch/x86/kernel/fpu/xstate.c:1691: warning: Excess function
 parameter 'tsk' description in 'fpu_xstate_prctl'
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        kernel test robot <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 6:36=E2=80=AFAM kernel test robot <philip.li@intel.c=
om> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   3f86ed6ec0b390c033eae7f9c487a3fea268e027
> commit: f5c0b4f30416c670408a77be94703d04d22b57df x86/prctl: Remove pointl=
ess task argument
> date:   1 year, 4 months ago
> :::::: branch date: 14 hours ago
> :::::: commit date: 1 year, 4 months ago
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/2023090=
5/202309052029.TNyqXyIT-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git =
ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230905/202309052029.TNyqXyIT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202309052029.TNyqXyIT-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> arch/x86/kernel/fpu/xstate.c:1691: warning: Excess function parameter =
'tsk' description in 'fpu_xstate_prctl'

FWIW, this is `make htmldocs` complaining about the comment above the funct=
ion.

>
>
> vim +1691 arch/x86/kernel/fpu/xstate.c
>
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1671
> db8268df0983ad Chang S. Bae    2021-10-21  1672  /**
> db8268df0983ad Chang S. Bae    2021-10-21  1673   * fpu_xstate_prctl - xs=
tate permission operations
> db8268df0983ad Chang S. Bae    2021-10-21  1674   * @tsk:       Redundant=
 pointer to current

^ this line should be deleted.

> db8268df0983ad Chang S. Bae    2021-10-21  1675   * @option:    A subfunc=
tion of arch_prctl()
> db8268df0983ad Chang S. Bae    2021-10-21  1676   * @arg2:      option ar=
gument
> db8268df0983ad Chang S. Bae    2021-10-21  1677   * Return:     0 if succ=
essful; otherwise, an error code
> db8268df0983ad Chang S. Bae    2021-10-21  1678   *
> db8268df0983ad Chang S. Bae    2021-10-21  1679   * Option arguments:
> db8268df0983ad Chang S. Bae    2021-10-21  1680   *
> db8268df0983ad Chang S. Bae    2021-10-21  1681   * ARCH_GET_XCOMP_SUPP: =
Pointer to user space u64 to store the info
> db8268df0983ad Chang S. Bae    2021-10-21  1682   * ARCH_GET_XCOMP_PERM: =
Pointer to user space u64 to store the info
> db8268df0983ad Chang S. Bae    2021-10-21  1683   * ARCH_REQ_XCOMP_PERM: =
Facility number requested
> db8268df0983ad Chang S. Bae    2021-10-21  1684   *
> db8268df0983ad Chang S. Bae    2021-10-21  1685   * For facilities which =
require more than one XSTATE component, the request
> db8268df0983ad Chang S. Bae    2021-10-21  1686   * must be the highest s=
tate component number related to that facility,
> db8268df0983ad Chang S. Bae    2021-10-21  1687   * e.g. for AMX which re=
quires XFEATURE_XTILE_CFG(17) and
> db8268df0983ad Chang S. Bae    2021-10-21  1688   * XFEATURE_XTILE_DATA(1=
8) this would be XFEATURE_XTILE_DATA(18).
> db8268df0983ad Chang S. Bae    2021-10-21  1689   */
> f5c0b4f30416c6 Thomas Gleixner 2022-05-12  1690  long fpu_xstate_prctl(in=
t option, unsigned long arg2)
> db8268df0983ad Chang S. Bae    2021-10-21 @1691  {
> db8268df0983ad Chang S. Bae    2021-10-21  1692         u64 __user *uptr =
=3D (u64 __user *)arg2;
> db8268df0983ad Chang S. Bae    2021-10-21  1693         u64 permitted, su=
pported;
> db8268df0983ad Chang S. Bae    2021-10-21  1694         unsigned long idx=
 =3D arg2;
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1695         bool guest =3D fa=
lse;
> db8268df0983ad Chang S. Bae    2021-10-21  1696
> db8268df0983ad Chang S. Bae    2021-10-21  1697         switch (option) {
> db8268df0983ad Chang S. Bae    2021-10-21  1698         case ARCH_GET_XCO=
MP_SUPP:
> db8268df0983ad Chang S. Bae    2021-10-21  1699                 supported=
 =3D fpu_user_cfg.max_features | fpu_user_cfg.legacy_features;
> db8268df0983ad Chang S. Bae    2021-10-21  1700                 return pu=
t_user(supported, uptr);
> db8268df0983ad Chang S. Bae    2021-10-21  1701
> db8268df0983ad Chang S. Bae    2021-10-21  1702         case ARCH_GET_XCO=
MP_PERM:
> db8268df0983ad Chang S. Bae    2021-10-21  1703                 /*
> db8268df0983ad Chang S. Bae    2021-10-21  1704                  * Lockle=
ss snapshot as it can also change right after the
> db8268df0983ad Chang S. Bae    2021-10-21  1705                  * droppi=
ng the lock.
> db8268df0983ad Chang S. Bae    2021-10-21  1706                  */
> db8268df0983ad Chang S. Bae    2021-10-21  1707                 permitted=
 =3D xstate_get_host_group_perm();
> db8268df0983ad Chang S. Bae    2021-10-21  1708                 permitted=
 &=3D XFEATURE_MASK_USER_SUPPORTED;
> db8268df0983ad Chang S. Bae    2021-10-21  1709                 return pu=
t_user(permitted, uptr);
> db8268df0983ad Chang S. Bae    2021-10-21  1710
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1711         case ARCH_GET_XCO=
MP_GUEST_PERM:
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1712                 permitted=
 =3D xstate_get_guest_group_perm();
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1713                 permitted=
 &=3D XFEATURE_MASK_USER_SUPPORTED;
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1714                 return pu=
t_user(permitted, uptr);
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1715
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1716         case ARCH_REQ_XCO=
MP_GUEST_PERM:
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1717                 guest =3D=
 true;
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1718                 fallthrou=
gh;
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1719
> db8268df0983ad Chang S. Bae    2021-10-21  1720         case ARCH_REQ_XCO=
MP_PERM:
> db8268df0983ad Chang S. Bae    2021-10-21  1721                 if (!IS_E=
NABLED(CONFIG_X86_64))
> db8268df0983ad Chang S. Bae    2021-10-21  1722                         r=
eturn -EOPNOTSUPP;
> db8268df0983ad Chang S. Bae    2021-10-21  1723
> 980fe2fddcff21 Thomas Gleixner 2022-01-05  1724                 return xs=
tate_request_perm(idx, guest);
> db8268df0983ad Chang S. Bae    2021-10-21  1725
> db8268df0983ad Chang S. Bae    2021-10-21  1726         default:
> db8268df0983ad Chang S. Bae    2021-10-21  1727                 return -E=
INVAL;
> db8268df0983ad Chang S. Bae    2021-10-21  1728         }
> db8268df0983ad Chang S. Bae    2021-10-21  1729  }
> db8268df0983ad Chang S. Bae    2021-10-21  1730
>
> :::::: The code at line 1691 was first introduced by commit
> :::::: db8268df0983adc2bb1fb48c9e5f7bfbb5f617f3 x86/arch_prctl: Add contr=
ols for dynamic XSTATE components
>
> :::::: TO: Chang S. Bae <chang.seok.bae@intel.com>
> :::::: CC: Borislav Petkov <bp@suse.de>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>


--=20
Thanks,
~Nick Desaulniers
