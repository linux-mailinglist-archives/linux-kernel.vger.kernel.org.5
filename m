Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CCD77BD29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjHNPf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjHNPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:35:15 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2615E130
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:35:15 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4478ea3ac05so1728097137.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692027314; x=1692632114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwZynochhhORLpCB6DjxeAh/RlJ/3P4bMuPp8yyJkYU=;
        b=s3U1x+uHEnmCITDqc5tFkzyv81a4pTKNhmXBWqyyQCBwJ9lDyueXPs+QJvFwfQrFv1
         94mhMEJao3y8DJwc5oT8+dt+Wr5UYBw8TJO4d2VdkCf0E89LWqvbledG56xkQRlB+lJv
         HuJ9jTT72Kq/5bgapQkAxcYjD8j6PlyUeVgX8I7P87QjXz0oQox69zOZ9u7aPBTSXRgD
         QFb8wVl+85tBx+gVSaWaHvoU+8kaW9jaFBmNV8FlNahqC7H5yxnqxDIvvUeHXpJXa503
         C0FHZxfT/PQTJT7IQ7K01NejMXA2qQ8a+AK3N2+qI1t9D+ODBO6qm+92WTFZ7JLaRuoq
         LyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027314; x=1692632114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwZynochhhORLpCB6DjxeAh/RlJ/3P4bMuPp8yyJkYU=;
        b=gRAWmmnIzXuB1chkp92II+yRfzcSYd8Om66mi3A0Z2eVPnsaHyYHL3oBupmQEIlKdI
         kTFugB7Jfeq+4Qo//w/6y2sz8AzvJPv26ezkmJsmaAwHB4uOwAax14RHjxEVmGfXc5yS
         fH7dSxBei02cXFyt7dXEp/NFNvERcKT4oxfcsLepUAWA6BoAywxRw3b1D6fKW/SL4t8O
         A/QseignC5NvapQLzYF7iGr+VveO5kXKi5Xtbb+w0vIDtv4uqnD7GSm+LM8tCCYbphVt
         C7OFRvqf4NNex7pbM7TYWiW6L7B0vBopIXz0HOrPSALrpB3m3/6NkIhPFjxJZFmTMVd5
         +Qlg==
X-Gm-Message-State: AOJu0Yw+LAcZQxOzhMxBf50WLQodGsK4fzH9p+/a0cTy5kn0scTZGL1k
        RcUp3yy2jB3hrjkc2Y0AEdmD9q11DbIHeoxNhnwQ5Q==
X-Google-Smtp-Source: AGHT+IEc/ansqEvhUK8upK41DzZmZXeg9i65FyaNq/0zMjuxetY5EwlfjUBrV9vueWGSzkKHu9AeI3Av2jUqmfgPyhA=
X-Received: by 2002:a67:ee07:0:b0:445:91b:385d with SMTP id
 f7-20020a67ee07000000b00445091b385dmr9781787vsp.12.1692027314070; Mon, 14 Aug
 2023 08:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230811233556.97161-8-samitolvanen@google.com>
 <202308122238.XLMMmeL0-lkp@intel.com> <CAJF2gTQmezqnJo68CuV8e+=RwCAioKbk0UqTS_fq5--HjUTLDw@mail.gmail.com>
In-Reply-To: <CAJF2gTQmezqnJo68CuV8e+=RwCAioKbk0UqTS_fq5--HjUTLDw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 14 Aug 2023 08:34:37 -0700
Message-ID: <CABCJKueRPOEiRdGoT5A+c3s7zbH3YqvFUcQowwXMUT4CmFyBEw@mail.gmail.com>
Subject: Re: [PATCH 1/5] riscv: VMAP_STACK overflow detection thread-safe
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
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

On Sat, Aug 12, 2023 at 6:25=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Aug 12, 2023 at 10:36=E2=80=AFPM kernel test robot <lkp@intel.com=
> wrote:
> >
> > Hi Sami,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on 52a93d39b17dc7eb98b6aa3edb93943248e03b2f]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/ri=
scv-VMAP_STACK-overflow-detection-thread-safe/20230812-073751
> > base:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> > patch link:    https://lore.kernel.org/r/20230811233556.97161-8-samitol=
vanen%40google.com
> > patch subject: [PATCH 1/5] riscv: VMAP_STACK overflow detection thread-=
safe
> > config: riscv-randconfig-r042-20230812 (https://download.01.org/0day-ci=
/archive/20230812/202308122238.XLMMmeL0-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.gi=
t 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230812/2023081222=
38.XLMMmeL0-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202308122238.XLMMmeL0-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> ld.lld: error: undefined symbol: __per_cpu_offset
> >    >>> referenced by arch/riscv/kernel/entry.o:(handle_kernel_stack_ove=
rflow) in archive vmlinux.a
> !CONFIG_SMP missed

Indeed. I'll fix this in v2.

Sami
