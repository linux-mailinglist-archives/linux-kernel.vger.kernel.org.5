Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD76E75FCFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGXRPo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 13:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGXRPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:15:40 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B51702
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:15:35 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99b49e51f62so133027766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690218934; x=1690823734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmzPsAYzy8NSDpn9uqZi6xNv0tfNhDnok5avWIDLP/w=;
        b=d721DPP5nLZbL3fF8qoayIwwKI0tFGd433uEx/4bSrWSYMlrmy28PKQ1LrLrolIBg8
         UiSWv67VSlL540ujLWJAdHaw3kpXYUMRvfcY5pMEXatYY4a4yfN/VzCPw0VvlGtUxVLT
         yySYlv0BwgIvUetZo3vv8opPeyjqRpNNwftP+bCO8vaj5EqEQffswmfES8fmZPiH/u4a
         Otl9S9fYGXgTO7zRsp8Es4tK8sqswUI5iDWYf0q2W/aonA/YelvmmsAie/x5gMUiSO3/
         Q0ZCPkSYB0JYH69L71SqQRKIHZLr7eED5l5wwD14KO7uMBPTF5I5h8Dtzo/4iC2cj4C5
         zUOQ==
X-Gm-Message-State: ABy/qLYMuxu46GxSydm8+NMJ/P2TgT26OSf4LY/N76jFqWvET6vOurw6
        Icaa1hERZ5J6JRtTzddtkOTwBXkid8hyMtcZXzg=
X-Google-Smtp-Source: APBJJlGoct3mHpZZnM6Ol+uQnfypSnCptgwMWEkfwlB/H4mVcZnq79dRut/tnQu1J8D0Sf04VcsiQ6tlcbJvnvZybGI=
X-Received: by 2002:a17:906:20d0:b0:997:e8ea:178e with SMTP id
 c16-20020a17090620d000b00997e8ea178emr8541422ejc.7.1690218933967; Mon, 24 Jul
 2023 10:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <202307241942.Rff2Nri5-lkp@intel.com> <ZL6IpoGPu5hgFidK@sunil-laptop>
In-Reply-To: <ZL6IpoGPu5hgFidK@sunil-laptop>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Jul 2023 19:15:22 +0200
Message-ID: <CAJZ5v0gyGeier-Oz=o59TY1XzuPfZ02K=D6F-bMfJbXJ_5OnBA@mail.gmail.com>
Subject: Re: drivers/pnp/pnpacpi/core.c:253:17: warning: 'strncpy' specified
 bound 50 equals destination size
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 4:20 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
>
> +Rafael.
>
> On Mon, Jul 24, 2023 at 07:32:36PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
> > commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
> > date:   8 weeks ago
> > config: riscv-randconfig-r032-20230724 (https://download.01.org/0day-ci/archive/20230724/202307241942.Rff2Nri5-lkp@intel.com/config)
> > compiler: riscv64-linux-gcc (GCC) 12.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241942.Rff2Nri5-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202307241942.Rff2Nri5-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/pnp/pnpacpi/core.c: In function 'pnpacpi_add_device.isra':
> > >> drivers/pnp/pnpacpi/core.c:253:17: warning: 'strncpy' specified bound 50 equals destination size [-Wstringop-truncation]
> >      253 |                 strncpy(dev->name, acpi_device_name(device), sizeof(dev->name));
> >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> I need some help here to understand what needs to be done. This is a
> common code across architectures. Apart from the fact that ACPI is
> enabled for the first time for RISC-V, I am unable to understand why
> this warning is seen now. Is this because only RISC-V gcc enables this
> warning by default? I don't see this with clang tool chain. If this is
> expected warning, is there a way to suppress?

I think that this is relevant information:

https://stackoverflow.com/questions/50198319/gcc-8-wstringop-truncation-what-is-the-good-practice

Thanks!
