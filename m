Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7175FCF9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGXRP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGXRP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:15:26 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410B291
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:15:23 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63d10da0f26so1353716d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690218922; x=1690823722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZbFk+J10UfrSL79sLzSpmwWLT2vd0Fn58aGqpzLT8o=;
        b=1YX+L3Xe0aw2sI4aL9zKBZpgaUsr2Ctra2kvfpc4vm/95W5cBbAqlRMy/pafQG3Xzl
         qZ0M46rf5pk8owvuPj2Dw9lavv0H6EUwUEzlaBeHzUSiAalhQ7xHxuBfxhc7Uv3UvSbt
         lWlCz5UixM8IChuz9leknxceOxLi8L+DYFM3/ev+Myw11xmMaZAi086GwgmHK2qMCn4W
         +8q6jWsQ+anYbABIjhNkOGC7s/Lm3+ACQKF54VA8b0bprRpUUF9HoLSmy09pucbBLtkZ
         eU6bIGOfY4C3rzFQOsuNU58ZEFv5NiEXEjP08H+L+QKnYVkmIkxC36hkO8yX6msWa3yV
         gc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690218922; x=1690823722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZbFk+J10UfrSL79sLzSpmwWLT2vd0Fn58aGqpzLT8o=;
        b=iRGkIOQ8HyPi7180tVrZM0WH9rqr9MPmhGO26BFbaQhZogGaIF3M5JfSJZHzi9hfQf
         busIWgz6/ZKBoCL4oWwQ3ue6NAsEnGZbF5ERh3labnbFZ9h/CQNQjCP3XHWxkpWttzfa
         RAIsVtYESRIYMquocxOoXAxeHEMOfhKX6a79eXXwqS69PCWQcbZFhhpepqUFZM6uOlyz
         lS2eSEvCbjk9YziQha07VI+CdjH4vvJ/cDizwLXTjp9M5xwlQY5hpsixltsW77DVCO+W
         vo6kAjwofOfCyhX5bqbcqq0ofr7gMmIw5Ggzz5xzql8WKK/IjM2IyrIEM4InXFJUIc5g
         6IeQ==
X-Gm-Message-State: ABy/qLbRmjZnxvROvMXuqA/A+4Qx+0Gm/qaRBOJK6ML/bIeRW4Kl14wz
        LlK6DMqsCLK1ewhZulbHH58E4cLKnnAzr6Q9D+kxFw==
X-Google-Smtp-Source: APBJJlGuQHP0+90mVT4qcBd9dPz8oFWvD/tzPplwF+p3o6wvZcQTX7zpY+HRYiSDThs0KxIrd2j2Bgyzc1UAIzMCNek=
X-Received: by 2002:a0c:8dc9:0:b0:63c:f8af:5aa9 with SMTP id
 u9-20020a0c8dc9000000b0063cf8af5aa9mr384655qvb.26.1690218922055; Mon, 24 Jul
 2023 10:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <202307211945.TSPcyOhh-lkp@intel.com> <ZLsXAdjFuKLpd3ig@google.com>
In-Reply-To: <ZLsXAdjFuKLpd3ig@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jul 2023 10:15:11 -0700
Message-ID: <CAKwvOdm3mg5kHTNYx6ROaY8G0wf6o_OXiPGwkYs9sU+5qqa=WQ@mail.gmail.com>
Subject: Re: arch/powerpc/kvm/e500mc.c:95:15: error: invalid instruction
To:     Sean Christopherson <seanjc@google.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 4:38=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jul 21, 2023, kernel test robot wrote:
> > Hi Sean,
> >
> > FYI, the error/warning was bisected to this commit, please ignore it if=
 it's irrelevant.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   f7e3a1bafdea735050dfde00523cf505dc7fd309
> > commit: e83ca8cfa286c9fc78b585b0e66df7f542bcbcf2 KVM: PPC: booke: Mark =
three local functions "static"
> > date:   4 months ago
> > config: powerpc-randconfig-r001-20230721 (https://download.01.org/0day-=
ci/archive/20230721/202307211945.TSPcyOhh-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.gi=
t 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230721/2023072119=
45.TSPcyOhh-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202307211945.TSPcyOhh-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> arch/powerpc/kvm/e500mc.c:95:15: error: invalid instruction
> >       95 |         asm volatile("tlbilxlpid");
>
> I assume this is a binutils bug?  I ran into a similar problem on PPC a w=
hile
> back where I couldn't cross-compile even relatively basic PPC code.
>

No, I think that LLVM is perhaps missing support for this instruction
Filed https://github.com/ClangBuiltLinux/linux/issues/1891 to track this.

--=20
Thanks,
~Nick Desaulniers
