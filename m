Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB67A7C9837
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjJOHDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOHDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 03:03:31 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB9DA
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 00:03:29 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1e19cb7829bso2178915fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697353408; x=1697958208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLRkNFaYEa5fEuPGQ15E5Ms4Xg1BiQ5FIQ0TqbAruB8=;
        b=Lw1l74ANC8ncUMq7ieasjhGxXlBKPeFoy9dtEcj/fjtCNetwd5YsFDIeafyieDl7Xo
         Omsjl2E0hQLjMLzjWChKXJn/ZUCs7gzAA0Jk7srJFaAg60lrqRF7eZ9UVvHu9CfRMHwM
         A+cPrRrZN6XqgiuHcDeR6R/YfZHLdgJZC1Po//bNpwZ5El/ocSo9LW5rZh7VFdBkAS2R
         WMsR1cXNGMyAp9YtK1p8xEVDEGPs6kXnrQZ7mU+Wn5c8vHWXnh88+/leF9vcX+bs76jd
         FPhxfSa202MYbRzQSgUkMsJHiwvsqPl52smthG/ph2g8toNKc1VWVRY0a+FBisWmO8z7
         GYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697353408; x=1697958208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLRkNFaYEa5fEuPGQ15E5Ms4Xg1BiQ5FIQ0TqbAruB8=;
        b=oKZ8xHntXHtC41jpvZQIbIxJEWIleEUef0krvK/c7uH3VpSv9w9LIBAlYkodo6CK9h
         kKhacWJMtWl0Vw++/TJfwqd3x/vwJ583Tc0LisZ7Twg2gAwRe2QSkou0zb3+68TGe1Pl
         fhp3Hj5rrkWRTMvtFeZIRNiqrzHQWVG8gOqI1bInYx2gZcT32l5yBsy2cUclDnn5119D
         BFr3RLc/vkfudhLitiYIxjS9rqak6iCfFiZb2C8eBmlwuYSLmsCq/fZqNbZNUfjEmNS0
         Aah3uiA6z1bTyh4diKKShaQ5N1Q9BIHrO87NNjSkSbcbq6hzqH4UqCvKUIcoqRkIgwrD
         6+Rw==
X-Gm-Message-State: AOJu0YwhkFvz1VO696wEhn6eCOuxajGy0yRTpwG1yn/ka7UEv3OrnoJ7
        RQtxxMcxgFmGiUtiKfb0nkdtmbcvvhUZNu0zd3CJFyBgw+s=
X-Google-Smtp-Source: AGHT+IEvThvWI8FV/CqU2kJPc3U7/UyuJuKk10SW9jIKJzEha6TCiZLVqvS9n7R0UgdVq8Zh3tTIjQenawV67dQkuhY=
X-Received: by 2002:a05:6870:13d0:b0:1e9:cd89:433b with SMTP id
 16-20020a05687013d000b001e9cd89433bmr8844660oat.45.1697353408400; Sun, 15 Oct
 2023 00:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <202310150352.KyKovpbT-lkp@intel.com>
In-Reply-To: <202310150352.KyKovpbT-lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 15 Oct 2023 09:03:18 +0200
Message-ID: <CAMhs-H-KG_7evTk7o+KEce7EQyfeSNh7f=N52-6x1M_y0rgrPA@mail.gmail.com>
Subject: Re: drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 14, 2023 at 9:25=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   70f8c6f8f8800d970b10676cceae42bba51a4899
> commit: 6f3b15586eef736831abe6a14f2a6906bc0dc074 clk: ralink: add clock a=
nd reset driver for MTMIPS SoCs
> date:   4 months ago
> config: hexagon-randconfig-r016-20230817 (https://download.01.org/0day-ci=
/archive/20231015/202310150352.KyKovpbT-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git =
ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231015/202310150352.KyKovpbT-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310150352.KyKovpbT-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/clk/ralink/clk-mtmips.c:11:
>    In file included from include/linux/regmap.h:20:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __raw_readb(PCI_IOBASE + addr);
>                              ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE +=
 addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from drivers/clk/ralink/clk-mtmips.c:11:
>    In file included from include/linux/regmap.h:20:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE +=
 addr));
>                                                            ~~~~~~~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from drivers/clk/ralink/clk-mtmips.c:11:
>    In file included from include/linux/regmap.h:20:
>    In file included from include/linux/iopoll.h:14:
>    In file included from include/linux/io.h:13:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writeb(value, PCI_IOBASE + addr);
>                                ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + add=
r);
>                                                          ~~~~~~~~~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + add=
r);
>                                                          ~~~~~~~~~~ ^
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
> >> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmi=
ps_of_match' [-Wunused-const-variable]
>    static const struct of_device_id mtmips_of_match[] =3D {
>                                     ^
>    9 warnings generated.

I already sent this patch some time ago and still waiting for its review:

https://lore.kernel.org/lkml/20230827023932.501102-1-sergio.paracuellos@gma=
il.com/t/

[snip]

Thanks,
    Sergio Paracuellos
