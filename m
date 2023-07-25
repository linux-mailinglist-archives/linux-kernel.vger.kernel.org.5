Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7754760DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjGYIyS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 04:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjGYIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:53:00 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602241BE1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:52:06 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-565e4741723so633635eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275125; x=1690879925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SGPa4CFbfVRal8xLsbFh3tPOyaC9uwhKONoYiwSg/U=;
        b=aoYsAY/4wpQ2/z3ETUW1MFvJkwI48+vhYTuyHmDGZN0AvIuIsrdcwu8oGVGXTKCony
         z5zZ3L8+DwoRmRp58Vyq3UWZDpXz5KYJQTc1heHibpXSHzLSC/L2m991oFRpBXK7sShU
         uvjnTIzyrVSzT2QczeLGH3YeVZ2oQ25LmzOBragxJxHjDdcihsa3r3Xf/iHCUwdFTcfi
         RDwOF02xbmZ2qwrxMqh73toocC9RqPA+N8NMBXAMHYWb0yekVVpc0ePtdWJJGEc672Nv
         sGihQTfhY2LwIToC2CSm90KXae0G5csyk9MHvs2wbdKhBogrPrkzjXA4sSQZlxkyYSy2
         pk7g==
X-Gm-Message-State: ABy/qLbHssElN6XlSrmNww31l0NwwK5WdApJ2NMmpK8Fh4yuFmGzCC+L
        9KpyeR8oa0bSNYVs14o8ZLK+YBDawetLPjRCfDM=
X-Google-Smtp-Source: APBJJlGLbwy7vYhmSsUNvWxNaMsZwqRZLCnVbdKICjnOXTSxVsJi9EgvSnbUk6/ko348nn3RtCj/vxDTYdDFhlXQTck=
X-Received: by 2002:a4a:e7c8:0:b0:566:6984:c44 with SMTP id
 y8-20020a4ae7c8000000b0056669840c44mr7210812oov.1.1690275125402; Tue, 25 Jul
 2023 01:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <202307241942.Rff2Nri5-lkp@intel.com> <ZL6IpoGPu5hgFidK@sunil-laptop>
 <CAJZ5v0gyGeier-Oz=o59TY1XzuPfZ02K=D6F-bMfJbXJ_5OnBA@mail.gmail.com> <ZL9Ys8DKf7RKg20G@sunil-laptop>
In-Reply-To: <ZL9Ys8DKf7RKg20G@sunil-laptop>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jul 2023 10:51:54 +0200
Message-ID: <CAJZ5v0hvZfi8jnPbZSETFRnbcesECB_XHOEfsA8SN=GrH2axOg@mail.gmail.com>
Subject: Re: drivers/pnp/pnpacpi/core.c:253:17: warning: 'strncpy' specified
 bound 50 equals destination size
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 7:08 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> On Mon, Jul 24, 2023 at 07:15:22PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 24, 2023 at 4:20 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >
> > > +Rafael.
> > >
> > > On Mon, Jul 24, 2023 at 07:32:36PM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
> > > > commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
> > > > date:   8 weeks ago
> > > > config: riscv-randconfig-r032-20230724 (https://download.01.org/0day-ci/archive/20230724/202307241942.Rff2Nri5-lkp@intel.com/config)
> > > > compiler: riscv64-linux-gcc (GCC) 12.3.0
> > > > reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241942.Rff2Nri5-lkp@intel.com/reproduce)
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202307241942.Rff2Nri5-lkp@intel.com/
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > >    drivers/pnp/pnpacpi/core.c: In function 'pnpacpi_add_device.isra':
> > > > >> drivers/pnp/pnpacpi/core.c:253:17: warning: 'strncpy' specified bound 50 equals destination size [-Wstringop-truncation]
> > > >      253 |                 strncpy(dev->name, acpi_device_name(device), sizeof(dev->name));
> > > >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > I need some help here to understand what needs to be done. This is a
> > > common code across architectures. Apart from the fact that ACPI is
> > > enabled for the first time for RISC-V, I am unable to understand why
> > > this warning is seen now. Is this because only RISC-V gcc enables this
> > > warning by default? I don't see this with clang tool chain. If this is
> > > expected warning, is there a way to suppress?
> >
> > I think that this is relevant information:
> >
> > https://stackoverflow.com/questions/50198319/gcc-8-wstringop-truncation-what-is-the-good-practice
> >
> Thank you very much! Rafael. Let me send a patch to append a NUL
> explicitly to fix this issue. However, I still wonder why this code
> added in 2005 getting this warning only now. Why is this not being seen
> with other architecture builds?

I don't know.
