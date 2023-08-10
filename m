Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270EC7770C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjHJGxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjHJGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:53:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7198510F5;
        Wed,  9 Aug 2023 23:53:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-5230f92b303so145813a12.0;
        Wed, 09 Aug 2023 23:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691650428; x=1692255228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Eyp278XORcAGAuxYJWGOibB23Q0XmCIa8bqZiRg08=;
        b=qTLmlJ+amRCsqU9zlCMguKSZ5f+J7MdVYus12ZdpqU399zdVj/W8ZU3QEptmnn03k7
         ueS0g7TlfPnG0JyjW88aH8PcwdzPrqpgpiMsssw1L0ZrEAjso3Ez2CcwWutxoixQ1G2z
         xJ95qutvizwhxbQKNAB46YEgH4qgxnI1/xPnX6VK0u+ZwM5uZMjrd65RxVfvbC/vnCTY
         GO6cQ0inrU684U4h0oYETMZ6SvLqQOUfylYy1wspoRyRCPmHF0hhvgsfk96SDV0XbGPq
         XCcXoi3MujgzWfjS25/Vc3jCWB+6pFPiDso4Xmn0C7RU8ws5svZMSQq5tUtg+a7xDVDY
         BPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691650428; x=1692255228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6Eyp278XORcAGAuxYJWGOibB23Q0XmCIa8bqZiRg08=;
        b=ZIGZRKid++Rggv69rghPyjBgPQMYGBei/T2XsNChQUFBOaQG9737PtjJXaKFbxC0IH
         Ioe971kbRWulJiMONbn9r5x6emGfXu9MaRleXafMRTWgbUMNse6Iu/ZUxJx5ZTXZuKI1
         xXE7aHI+8yrL7jxtO22Nk8mbe1ArfCGcP0bB+oTYo+byHfG0mFHqjPqJZ6L/8nfP3N/i
         ywM97jgbdVUAw4E553W51azcRxabCEqWH5HO/Y76ZHwELliAR1qKHNQlCrzX5L2o2dlI
         it9a1VlBOU+ffhDaooBCwOWjanTrqj7oWqqxOCCtuSTBXdA55Mk9XLzgzmgAVo9yef9O
         7Xsw==
X-Gm-Message-State: AOJu0YxAZ6AfiZftaPdSsnIyT+1PqktdkHHD94slaDrMJjdm6lJ+3waQ
        v+qOn26+Kkd3bRucePrRYxXXSRTBxjxSH7Hg845W/NIqKaO2Fw==
X-Google-Smtp-Source: AGHT+IExOC57m6R4Jj4Yl66pRTNR+Koh9bq/N2CoiFvwMGG0JzTFmK2MaylH+/bQqy4UjnGht/1OgAYCjyKYaGFILTs=
X-Received: by 2002:a17:906:2cc:b0:99c:ae07:2836 with SMTP id
 12-20020a17090602cc00b0099cae072836mr998734ejk.3.1691650427767; Wed, 09 Aug
 2023 23:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033130.2226-1-Wenhua.Lin@unisoc.com> <CAAfSe-t45FeFzXKUCjOU5qoPF-rq4dzMKo-eRciw6MbLq+rNgA@mail.gmail.com>
In-Reply-To: <CAAfSe-t45FeFzXKUCjOU5qoPF-rq4dzMKo-eRciw6MbLq+rNgA@mail.gmail.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 14:53:35 +0800
Message-ID: <CAB9BWhdH0o7ASPJE48BvT7UuQCGr4WdnPXC_G3q3UNAEx+=3wg@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: sprd: In the sleep state, the eic dbnc clk must
 be forced open
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 5:36=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.com>=
 wrote:
>
> On Tue, 8 Aug 2023 at 11:32, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > In the sleep state, Eic dbnc has no clock and the clk enable
>
> Does "dbnc" mean "debounce"? I suggest not using abbreviation here.

Hi chunyan:
    dbnc is debounce, We will make changes in patch v2.

Thanks

>
> > of dbnc needs to be forced open, so that eic can wake up normally.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/gpio/gpio-eic-sprd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index 0d85d9e80848..c506cfd6df8e 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -23,6 +23,7 @@
> >  #define SPRD_EIC_DBNC_IC               0x24
> >  #define SPRD_EIC_DBNC_TRIG             0x28
> >  #define SPRD_EIC_DBNC_CTRL0            0x40
> > +#define SPRD_EIC_DBNC_FORCE_CLK                0x8000
> >
> >  #define SPRD_EIC_LATCH_INTEN           0x0
> >  #define SPRD_EIC_LATCH_INTRAW          0x4
> > @@ -213,6 +214,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *=
chip, unsigned int offset,
> >         u32 value =3D readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
> >
> >         value |=3D (debounce / 1000) & SPRD_EIC_DBNC_MASK;
> > +       value |=3D SPRD_EIC_DBNC_FORCE_CLK;
> >         writel_relaxed(value, base + reg);
> >
> >         return 0;
> > --
> > 2.17.1
> >
