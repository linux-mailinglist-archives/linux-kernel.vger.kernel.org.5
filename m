Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EE175395D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjGNLRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjGNLRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:17:48 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CA30C4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:17:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78372625badso64781639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689333465; x=1691925465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xOGLgvepwIIu3hU4DJ3qxcuZdlX6rb02ZAWPyCmFTc=;
        b=16JMKa7PoT8+7JFaTJUGf7htuXLBJ0QyBdI2NzZ4uIK/e/k4x8IhHlwhsJyWY0CRf6
         t663xfg1k7MFxxsc7Hb3VfHIcoIKCg6+48UoZcKjzGTSPdB8QH1z1hMd0YPMEo80aebR
         VMaZSL7k70dC2vp00nmcSTyFnRHe/SPADPtr8w/hjB4xs9aF6eJCXSbBC5KqybwvYIEf
         9dCfb9YNHS14Koevl2M5SwWIFyT+M9voRkxD08DZcTDRqZnUWmlOUeFzEXDkO6UZOb8a
         JgZ2+PDxrJJbQTjQcB9Wdp9OpZJTKbaUIHFYVEjfdgFJYTpATbJTUg2xUNwNloBnyJrU
         1r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689333465; x=1691925465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xOGLgvepwIIu3hU4DJ3qxcuZdlX6rb02ZAWPyCmFTc=;
        b=a4Vk9j7kggBcmaPiVOOg5yx3hLdqScpHQu+9LKdUs9dx44QmwK1OVgkVUL7FuSW+Cf
         6oLY4F9+bbKLBB6H48XHLj/uXrxaP+gdtK39WV1i8Km//bHDlvVvp2sxzUmuRAkyC2LD
         n3F6nND7gKuDdEk/uEzI9LTcwEgouxx/S6g+dOe36eaKW9ZW4zdCO+Sx5ovILpAnQqIQ
         wK6M2QQbMMMFjQal3I6YrfOKDls5wHOgcrEDXQ+uopmsnoQnlUeZjOcIRL+55XGwgmOU
         1oNBqcFtLpGggsL2yRdlhTo6Sln4Woto5Lo0gdNaN757kL5H4BhaAeFZlGY6BSvsclmi
         Wunw==
X-Gm-Message-State: ABy/qLYPHWcpgn8JFNki37ZOgMUy/BejPEgXagXBT6HiijCGs/QrXGA7
        7VosF1mYEvnQkcHjP3kPCxcYJEdOy7ooDOj3Obe2MA==
X-Google-Smtp-Source: APBJJlFB8U6F877haMGpkQI3+siPw1rX6M39W9aOGMNclIMWdvMeodVZvUFJUYhLENnOXkgycuiX6Vhx8DuQ77k7awU=
X-Received: by 2002:a6b:e505:0:b0:785:cb8d:f1c5 with SMTP id
 y5-20020a6be505000000b00785cb8df1c5mr5073608ioc.12.1689333465348; Fri, 14 Jul
 2023 04:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com> <20230713125706.2884502-4-glider@google.com>
 <ZLAzG+Ue3JqDM/F3@smile.fi.intel.com> <CAG_fn=W4Uv2YaO=Udwo80_f74y8o0+WWVVqTNK3iW5VDs5B8+w@mail.gmail.com>
 <ZLEnublo8C5yX3si@smile.fi.intel.com>
In-Reply-To: <ZLEnublo8C5yX3si@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 14 Jul 2023 13:17:08 +0200
Message-ID: <CAG_fn=V3k0PLHh=NbKyPjK7RNXwpzBRb_JALM_xCNoc2D+yE8g@mail.gmail.com>
Subject: Re: [v2 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 14, 2023 at 11:25:41AM +0200, Alexander Potapenko wrote:
>
> ...
>
> > > Not sure why fls() / BIT() can't be used directly instead of these fu=
nctions,
> > > but okay, they are not too ugly.
> >
> > They can't be used directly because 128 maps to 0, but I can sure
> > simplify them a bit.
>
> Right, that's why I'm okay with the current implementation. But
> if you want to rewrite, up to you.
>
> ...
>
> > > > +                     if (pos % 2 =3D=3D 0)
> > >
> > > Would be better to keep this aligned with above?
> > >
> > >                         if (pos % 2)
> > >                                 ...
> > >                         else
> > >                                 ...
> >
> > It would, but i % 2 above didn't survive the rewrite, so I assume it
> > is fine to keep pos % 2 =3D=3D 0 as is.
>
> Not big deal, but less characters improve the brain process, so
>
>         if (pos % 2)
>
> kinda quicker to read and understand in my opinion.

Ok, will do.

> ...
>
> > > > +EXPORT_SYMBOL(ea0_storage_size);
> > >
> > > Btw, can we go to the namespaced export from day 1?
> >
> > Am I getting it right that I just need to change EXPORT_SYMBOL to
> > EXPORT_SYMBOL_NS and import the namespace in
> > arch/arm64/mm/test_mtecomp.c?
> > I.e. MODULE_IMPORT_NS is not needed in mteswap_comp.c, because it is
> > linked into the kernel?
>
> I think you always need to include MODULE_IMPORT_NS for the sake of
> robustness of the code.

Thanks! The docs aren't very specific on this.



> ...
>
> > > > +
> > >
> > > Unneeded blank line.
> >
> > I think there's no agreement on this in the kernel code, but my
> > version is more popular:
> >
> > $ git grep -B2 '^module_init(' | grep '\-}' -A2 | grep module_init | wc
> >    2688    2707  164023
> > $ git grep -B2 '^module_init(' | grep '\-}' -A1 | grep module_init | wc
> >     505     523   30989
>
> Even though, there is no need for this blank line. And note, for better
> argument, compare this for the new code added let's say for the past 2
> years. I believe numbers will tend to my variant.
>
> I.o.w. you need to count on trends and not only on frequencies.

Fair enough, will fix.
