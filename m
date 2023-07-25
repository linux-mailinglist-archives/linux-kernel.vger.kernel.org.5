Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE51A760C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGYIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjGYIEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:04:09 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A78120
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:04:08 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a1fa977667so4012973fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690272248; x=1690877048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ04m2mgXyxdxnuWbV0zRomtSyCFjCa11c8E/6QMRLA=;
        b=Glp75s3Qru9qtU/75zTwGijITmJdiNviTxxVSuUeFpc+43Ng4UxWFGSy+ib2h22X6R
         9ELZ7yZnJR8lShxo3JGhqoies4mVNRrQfi4qht8WlTA6PJldwk4ahJ7oZf+jap3TjGYt
         eIpFDab5F/8AYrQmU7XJdneJoyzXWx0OmDAdcPrM+pxsEXIJzyRrmgE83wMo3PhysTsy
         YdACaJ2+5rSdI0D4lFgdFFrd148At9k9Yr6RjbwOFzkh04CCdo6lhTqr6QVr0egHJcBF
         wr6HpQuA2oxxCJzc2k/S2KiBIqAW7aJtR0TeEksG3ftg7GlI2cWp1ECJ2CqpL61nObPI
         uG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690272248; x=1690877048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQ04m2mgXyxdxnuWbV0zRomtSyCFjCa11c8E/6QMRLA=;
        b=clUxZmRYAy7TbxOCr2xMlLFWbTsBTJfNfuJDiJ9OpR0BsmEk90akzfM5ghjKWZxsKd
         tD7mSBpqmqPzz+FnMv8yoZrszRUG6Mk2Arq9nvIwoEspiEu30srJBQcoC1E+uZpocoeV
         ZUmKqiRaV3ua08L3pRrHgaVdH3xfe++9NMKjN4u06YNLHgw8aWzjVpCDg9rywlIibgjo
         QlfTk7BTtbl7FWeE/HPki+Qb3f8DKtW54PO/Bk6Uyoidk7RaPHr7utt4vBLwN9e3uYCN
         qpGUMmDlglb60kkiqfruN/UwWbMDDl6hyoBemHlfUYbzQD/IV3lxmPpPAlbUB127Ye4L
         hJgQ==
X-Gm-Message-State: ABy/qLa5WDinI5+zxpjT3wHQJch1Jnc8GHPiHGS4a9B8k0MRxZo3ioyo
        nNgGUn70gP2rocy9sfYTy9wT/WjeUZhzmMXQlmI=
X-Google-Smtp-Source: APBJJlEE32iRJIl1HaETRlOMGBsoQJRQDz1yuBtZ3gl0fAODhR06dO0WeJzLKEkgbjEXwu0nkMJ66KlhtNzz4iQ/flY=
X-Received: by 2002:a05:6870:9a05:b0:1ba:1998:1d23 with SMTP id
 fo5-20020a0568709a0500b001ba19981d23mr13834004oab.35.1690272247963; Tue, 25
 Jul 2023 01:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <202307242310.CdOnd2py-lkp@intel.com>
In-Reply-To: <202307242310.CdOnd2py-lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 25 Jul 2023 10:03:56 +0200
Message-ID: <CAMhs-H8Zz_8w7Lcq5f=mEiucjwx+TAfBbVZ12PE1a47ioxTu2A@mail.gmail.com>
Subject: Re: drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Jul 24, 2023 at 5:21=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
> commit: 6f3b15586eef736831abe6a14f2a6906bc0dc074 clk: ralink: add clock a=
nd reset driver for MTMIPS SoCs
> date:   5 weeks ago
> config: x86_64-buildonly-randconfig-r003-20230723 (https://download.01.or=
g/0day-ci/archive/20230724/202307242310.CdOnd2py-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git =
8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce: (https://download.01.org/0day-ci/archive/20230724/202307242310=
.CdOnd2py-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    drivers/clk/ralink/clk-mtmips.c:309:9: warning: variable 'ret' is unin=
itialized when used here [-Wuninitialized]
>            return ret;
>                   ^~~
>    drivers/clk/ralink/clk-mtmips.c:285:9: note: initialize the variable '=
ret' to silence this warning
>            int ret, i;
>                   ^
>                    =3D 0
>    drivers/clk/ralink/clk-mtmips.c:359:9: warning: variable 'ret' is unin=
itialized when used here [-Wuninitialized]
>            return ret;
>                   ^~~
>    drivers/clk/ralink/clk-mtmips.c:335:9: note: initialize the variable '=
ret' to silence this warning
>            int ret, i;
>                   ^
>                    =3D 0

This two errors were already fixed in:

6e68dae946e3: ("clk: ralink: mtmips: Fix uninitialized use of ret in
mtmips_register_{fixed,factor}_clocks()")

> >> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmi=
ps_of_match' [-Wunused-const-variable]
>    static const struct of_device_id mtmips_of_match[] =3D {
>                                     ^
>    3 warnings generated.

This one is because CONFIG_OF is disabled so 'of_match_node()' turns
into a dummy macro. What would be the correct approach here?
Add select OF in Kconfig for this driver or silence the warning
declaring 'mtmips_of_match' with __maybe_unused?

Thanks in advance for clarification.

Best regards,
    Sergio Paracuellos

>
>
> vim +/mtmips_of_match +821 drivers/clk/ralink/clk-mtmips.c
>
>    820
>  > 821  static const struct of_device_id mtmips_of_match[] =3D {
>    822          {
>    823                  .compatible =3D "ralink,rt2880-sysc",
>    824                  .data =3D &rt2880_clk_data,
>    825          },
>    826          {
>    827                  .compatible =3D "ralink,rt3050-sysc",
>    828                  .data =3D &rt305x_clk_data,
>    829          },
>    830          {
>    831                  .compatible =3D "ralink,rt3052-sysc",
>    832                  .data =3D &rt305x_clk_data,
>    833          },
>    834          {
>    835                  .compatible =3D "ralink,rt3352-sysc",
>    836                  .data =3D &rt3352_clk_data,
>    837          },
>    838          {
>    839                  .compatible =3D "ralink,rt3883-sysc",
>    840                  .data =3D &rt3883_clk_data,
>    841          },
>    842          {
>    843                  .compatible =3D "ralink,rt5350-sysc",
>    844                  .data =3D &rt5350_clk_data,
>    845          },
>    846          {
>    847                  .compatible =3D "ralink,mt7620-sysc",
>    848                  .data =3D &mt7620_clk_data,
>    849          },
>    850          {
>    851                  .compatible =3D "ralink,mt7628-sysc",
>    852                  .data =3D &mt76x8_clk_data,
>    853          },
>    854          {
>    855                  .compatible =3D "ralink,mt7688-sysc",
>    856                  .data =3D &mt76x8_clk_data,
>    857          },
>    858          {}
>    859  };
>    860
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
