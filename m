Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E707C75DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441878AbjJLSai convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 14:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjJLSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:30:36 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272DB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:30:35 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a7af20c488so15658067b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697135434; x=1697740234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEHqR4UxkTsP1urr02CWt8lk407VM070mNRCkBflvD4=;
        b=W/FZFlo/pHfm/3yfIyhTxlgD+mMMB+0FSnYbUyDC8WXncjIf/dLIjqDrpPXjst3V6V
         Czf3meswpS5R+1S1LZS+OoYq/zSvdWimdea7qo6WcG/P+fxNclX9bas42Wmv5BuHFgUW
         H39wsA0mXsvEHrHjOmNBc85ZzsIzwLUMY+QQM5EsqkKxVC+rwS23A5bN6OkWQDwvtMfP
         vzfWu3vL86P0gnlI4nN/GpBOIeVaZKwCbnR/wtSwX1fnp9RkBhXTZQAHZcNB6UYhHXot
         KrcoogD3AtDABJy83/7ghCD6jXQGWj7f/1lmc1mvB4KWFcjt9QB1sVHDrIL7n5floTvT
         ijOQ==
X-Gm-Message-State: AOJu0YwHTxwQGouWcY/60Manb7eLVeLzcIm5wWxEGghbiI//54XRKdyJ
        nwlhRaN9PZFueAD2P59mPtNluXnuQMqBrg==
X-Google-Smtp-Source: AGHT+IGGB+KEU9r5xt3o6doU2ylOUH0hk6l7/38xoLkTMO21dhLuSoA8kXZ5jkRIm33lnLsbS+Qh+Q==
X-Received: by 2002:a0d:d40c:0:b0:5a7:dda6:cbaf with SMTP id w12-20020a0dd40c000000b005a7dda6cbafmr6159295ywd.19.1697135434083;
        Thu, 12 Oct 2023 11:30:34 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id g5-20020a81fd05000000b0059ae483b89dsm136457ywn.50.2023.10.12.11.30.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 11:30:33 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9a50ac5eabso1454983276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:30:33 -0700 (PDT)
X-Received: by 2002:a25:9386:0:b0:d9a:d90d:7b42 with SMTP id
 a6-20020a259386000000b00d9ad90d7b42mr1549312ybm.1.1697135433470; Thu, 12 Oct
 2023 11:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <202309222350.hCUFrIQ1-lkp@intel.com> <CAMuHMdUn1n47=nV_WMe9Yx1aTzYgsDKoj_AuZUPoAH7gJpCuGw@mail.gmail.com>
 <ZSgbAoJ9Cd5f8hjm@yujie-X299>
In-Reply-To: <ZSgbAoJ9Cd5f8hjm@yujie-X299>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 20:30:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3=X7ZRxyDNA3bvTcDXwkhh7K9dVo5YRrv9P4CNt1Vow@mail.gmail.com>
Message-ID: <CAMuHMdV3=X7ZRxyDNA3bvTcDXwkhh7K9dVo5YRrv9P4CNt1Vow@mail.gmail.com>
Subject: Re: {standard input}:1198: Error: value of ffffff6c too large for
 field of 1 byte at 00000533
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yujie,

On Thu, Oct 12, 2023 at 6:18 PM Yujie Liu <yujie.liu@intel.com> wrote:
> On Mon, Sep 25, 2023 at 02:07:07PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Sep 22, 2023 at 5:23 PM kernel test robot <lkp@intel.com> wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
> > > commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
> > > date:   9 weeks ago
> > > config: m68k-randconfig-r025-20230123 (https://download.01.org/0day-ci/archive/20230922/202309222350.hCUFrIQ1-lkp@intel.com/config)
> > > compiler: m68k-linux-gcc (GCC) 13.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309222350.hCUFrIQ1-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202309222350.hCUFrIQ1-lkp@intel.com/
> >
> > Thanks for your report!
> >
> > > All errors (new ones prefixed by >>):
> > >
> > >    {standard input}: Assembler messages:
> > >    {standard input}:1198: Error: value -148 out of range
> > > >> {standard input}:1198: Error: value of ffffff6c too large for field of 1 byte at 00000533
> >
> > Do you have more context (e.g. which source file is being compiled)?
> > Thanks!
>
> Sorry for our late reply. It is sound/soc/codecs/tas2781-fmwlib.o that
> is being compiled.
>
> {standard input}: Assembler messages:
> {standard input}:1198: Error: value -148 out of range
> {standard input}:1198: Error: value of ffffff6c too large for field of 1 byte at 00000533
> make[6]: *** [scripts/Makefile.build:243: sound/soc/codecs/tas2781-fmwlib.o] Error 1
>
> We rechecked the bisection process and found that this was a false
> positive report. The error also happens on the parent of this commit.
>
> {standard input}: Assembler messages:
> {standard input}:992: Error: value -148 out of range
> {standard input}:992: Error: value of ffffff6c too large for field of 1 byte at 0000045f
> make[6]: *** [scripts/Makefile.build:243: sound/soc/codecs/tas2781-fmwlib.o] Error 1
>
> The error message has some minor changes that our bot didn't recognize
> that it is the same error on both commits. We will fix this soon. Sorry
> for making the noise.

Thanks for the information!

In the mean time, I found out which file was the culprit when someone
posted a patch.

The real issue seems to be a compile bug, though, cfr.
https://lore.kernel.org/all/CAMuHMdXRGxnGpVHiB+Zvxq+G4K-BL8JsJGbG+7CNtJiqGwHOsQ@mail.gmail.com
https://lore.kernel.org/all/87v8bn3cae.fsf@igel.home

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
