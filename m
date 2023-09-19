Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00DD7A6B28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjISTEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:04:42 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD2EE1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:04:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-773bd514996so231269685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1695150275; x=1695755075; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SuRBdENIw7V9twXocQxarZXJFwOqUVR2w1pbySakEfo=;
        b=mT1EhY0FGQVVMDxi4nBdmUSKCWvH2RpIQh1NSA5kn4JAC3v/zhfz+YJhoMeMRJaqVW
         IoJrq/1lYjJZ3wLIe5iM26dx8jVeDvxm5nHwTB8sz1NcIVgs1QH6ONWIsb221HOKxomp
         Artr/yENpTEgRUORZjA0Ws5HZGBlnUpir4clNqfRzGPDsxbAOsBwW/SNoET+bK0RUEAp
         IhABlsPfkowFD7qGaaW+riEvQV1Fwdbn9bpFzxYl0q/1zT7qUqzlqe5u++LMjaq8hWiR
         gF/07eUZIws9/dI6BGgCoJL89eZuAm4RAqQhElPYK3gtwRT3OunVhZofZjiksGRzfM6Z
         PBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150275; x=1695755075;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuRBdENIw7V9twXocQxarZXJFwOqUVR2w1pbySakEfo=;
        b=r2WsxvfdAI0WdbfgDCjHEoFFRmzvrzSaF1hOGL/WAiCHZUF6h4KZ+GjFJLNYqlmlW0
         Js2/tzdlXx8aPHE7fQC6e3bQpSH3+oOsky9A+Om/4qIBSmseMe5Xo3W6CHBKT1d9vm06
         evdNA2CjyHBBVia60ubNTIs2ksNiMB952jkzcVn68wCI8b9GCrbqB79XFt7CQT+0rH/W
         xq3+TlPpST6P3aN5AHcDzPAj/s3U9LXFnzBVkX0r+7XwW/9BV/qaENnZNQ2GpxF9Boz1
         puD5LeM++JEDohGmP1wZontvXDRP9yRk+pUdlWJpgjEX3JjaSPsVSuXu7zUpyiVXhCNs
         OfWw==
X-Gm-Message-State: AOJu0Ywu5nx4s/8Hh7BPItD7L0BGlDOyILhGazVtUXuz0Q6vXTqmn//6
        mH1qA28gnLdhBs/fh4+KCvkPDw==
X-Google-Smtp-Source: AGHT+IFpzS+R18C2PIqZZdUsvjxaUNur77Qpz5Dgu0rMfOHyIuqx6jVj6XU3qmkPHOq2fuA812kYkg==
X-Received: by 2002:a05:620a:2224:b0:76d:acd1:447b with SMTP id n4-20020a05620a222400b0076dacd1447bmr529703qkh.41.1695150275619;
        Tue, 19 Sep 2023 12:04:35 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id oo18-20020a05620a531200b00765ab6d3e81sm4192894qkn.122.2023.09.19.12.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:04:35 -0700 (PDT)
Message-ID: <61caa860d8b5c35514da48a2548a1f6718458ec5.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hui Fang <hui.fang@nxp.com>, kernel test robot <lkp@intel.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Cc:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anle Pan <anle.pan@nxp.com>, Xuegang Liu <xuegang.liu@nxp.com>
Date:   Tue, 19 Sep 2023 15:04:34 -0400
In-Reply-To: <DB9PR04MB9284F8565C0A5A3F1E70603D87FAA@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230914145812.12851-1-hui.fang@nxp.com>
         <202309190740.sIUYQTIq-lkp@intel.com>
         <DB9PR04MB9284F8565C0A5A3F1E70603D87FAA@DB9PR04MB9284.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 19 septembre 2023 =C3=A0 06:43 +0000, Hui Fang a =C3=A9crit=C2=A0:
> On Thu, Sep 19, 2023 at 07:44=E2=80=AFAM kernel test robot <lkp@intel.com=
> wrote:
> > Hi Fang,
> >=20
> > kernel test robot noticed the following build errors:
> >=20
> > [auto build test ERROR on media-tree/master] [also build test ERROR on
> > linus/master v6.6-rc2 next-20230918] [If your patch is applied to the w=
rong git
> > tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.c/
> > om%2Fdocs%2Fgit-format-patch%23_base_tree_information&data=3D05%7C01%
> > 7Chui.fang%40nxp.com%7C3c6f14962ebc4483235308dbb8a12782%7C686ea1d
> > 3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638306774533762887%7CUnknow
> > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> > wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D4Xf2y8dA7JGZF4hlEMdnLIIK
> > b%2FIH2NS612ZNFvblqqo%3D&reserved=3D0]
> >=20
> > url:
> > https://github.co/
> > m%2Fintel-lab-lkp%2Flinux%2Fcommits%2FFang-Hui%2FMA-21654-Use-dma_all
> > oc_pages-in-vb2_dma_sg_alloc_compacted%2F20230914-154333&data=3D05%7
> > C01%7Chui.fang%40nxp.com%7C3c6f14962ebc4483235308dbb8a12782%7C68
> > 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638306774533762887%7CU
> > nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> > 1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DuPPbnMqqO1X55H7tC
> > bOlsfuO46dcErvJLxNSG5BslrU%3D&reserved=3D0
> > base:   git://linuxtv.org/media_tree.git master
> > patch link:
> > https://lore.kern/
> > el.org%2Fr%2F20230914145812.12851-1-hui.fang%2540nxp.com&data=3D05%7C
> > 01%7Chui.fang%40nxp.com%7C3c6f14962ebc4483235308dbb8a12782%7C686
> > ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638306774533762887%7CUn
> > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1
> > haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D6dYF2kk5ba0TE0B2jZM
> > hNWPRTkdn2zhWgQZ7LHTE1cE%3D&reserved=3D0
> > patch subject: [PATCH] MA-21654 Use dma_alloc_pages in
> > vb2_dma_sg_alloc_compacted
> > config: sh-randconfig-002-20230919
> > (https://downloa/
> > d.01.org%2F0day-ci%2Farchive%2F20230919%2F202309190740.sIUYQTIq-lkp%
> > 40intel.com%2Fconfig&data=3D05%7C01%7Chui.fang%40nxp.com%7C3c6f14962
> > ebc4483235308dbb8a12782%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> > C0%7C638306774533762887%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> > %7C&sdata=3DPMZX%2F9gMPOGxPnC5cVSABHqa4Xfd%2Fa6sgyjcghRqfoI%3D&r
> > eserved=3D0)
> > compiler: sh4-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build):
> > (https://downloa/
> > d.01.org%2F0day-ci%2Farchive%2F20230919%2F202309190740.sIUYQTIq-lkp%
> > 40intel.com%2Freproduce&data=3D05%7C01%7Chui.fang%40nxp.com%7C3c6f14
> > 962ebc4483235308dbb8a12782%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> > 0%7C0%7C638306774533762887%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> > 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> > C%7C%7C&sdata=3D6pzcKMI%2By2W1bpAjntJ7eizgiNmtcCG7ti4oEF3R01g%3D&r
> > eserved=3D0)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of the
> > same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore/
> > > .kernel.org%2Foe-kbuild-all%2F202309190740.sIUYQTIq-lkp%40intel.com%2=
F
> > >=20
> > &data=3D05%7C01%7Chui.fang%40nxp.com%7C3c6f14962ebc4483235308dbb8a
> > 12782%
> > >=20
> > 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638306774533762887
> > %7CUnkn
> > >=20
> > own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > Wwi
> > >=20
> > LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D45a%2FVY%2Fu8axIKigPCE3e
> > WEXinD1EG
> > > dQQu9TCnBZ%2BMI0%3D&reserved=3D0
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >    sh4-linux-ld: drivers/media/i2c/tc358746.o: in function `tc358746_pr=
obe':
> >    tc358746.c:(.text+0x1b8c): undefined reference to `devm_clk_hw_regis=
ter'
> >    sh4-linux-ld: tc358746.c:(.text+0x1b90): undefined reference to
> > `devm_of_clk_add_hw_provider'
> >    sh4-linux-ld: tc358746.c:(.text+0x1b94): undefined reference to
> > `of_clk_hw_simple_get'
> >    sh4-linux-ld: drivers/media/common/videobuf2/videobuf2-dma-sg.o: in
> > function `vb2_dma_sg_alloc_compacted':
> > > > videobuf2-dma-sg.c:(.text+0x57c): undefined reference to `dma_alloc=
_pages'
> >=20
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.co/
> > m%2Fintel%2Flkp-tests%2Fwiki&data=3D05%7C01%7Chui.fang%40nxp.com%7C3c
> > 6f14962ebc4483235308dbb8a12782%7C686ea1d3bc2b4c6fa92cd99c5c301635
> > %7C0%7C0%7C638306774533762887%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> > MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> > %7C%7C%7C&sdata=3DvA9h%2FGFfIel5hbcYVB0LgJGjHtDq1oF4SrfIvQcRm90%3D
> > &reserved=3D0
>=20
>=20
> I wonder if it's suitable to us the config (CONFIG_NO_DMA=3Dy) to build?
> Also, there are other undefined references no related to the patch.

May I suggest this ?


diff --git a/drivers/media/common/videobuf2/Kconfig
b/drivers/media/common/videobuf2/Kconfig
index d2223a12c95f..7cf869e48246 100644
--- a/drivers/media/common/videobuf2/Kconfig
+++ b/drivers/media/common/videobuf2/Kconfig
@@ -26,6 +26,7 @@ config VIDEOBUF2_DMA_SG
        tristate
        select VIDEOBUF2_CORE
        select VIDEOBUF2_MEMOPS
+       select DMA_SHARED_BUFFER
=20
 config VIDEOBUF2_DVB
        tristate


>=20
> BRs,
> Fang Hui

