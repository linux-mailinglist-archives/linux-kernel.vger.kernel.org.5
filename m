Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40A7A0666
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbjINNtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbjINNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:49:37 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F41AE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:49:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d7b91422da8so1002212276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694699372; x=1695304172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkZqjZNgB3Y1SyzOUIg94VhrWAWI+a6+Hf5lJqrRRNg=;
        b=Y6ZYo/SwMSCo+eD47c61jpkcM+x8sL+EdM7HOZiS33hyuLXZZWWsArQNkjV0U10iMR
         u8hTFCuAiLzFMIY3HKBsWCQ5e9rr/RjFe/i+aUBltZEqfoa0g6HWY65b1qQvuBheFMEw
         JJVXaEL19o1+j5FYrAfLPBIf2tuyL7PRzv93o8mpANGSExBouhUz8Da31Zd8ejPxzFlE
         izVyiac0O5yAGEgOkBg/39/CkhSYD4yxtgqBv/lLJ11OgT/Q19hw4k4XILbgAk53WMLQ
         wdOcp7uvGgkW3ZBNwBTN3udmly3B43aDsuYhz0EZm/ZKBe6/7Ck6fj+TMfqH5RYLmNr1
         bD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699372; x=1695304172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkZqjZNgB3Y1SyzOUIg94VhrWAWI+a6+Hf5lJqrRRNg=;
        b=GSo+GRqSGNjry6mYU1ZSSmbBukOvFFha3RuUrWjSnAYeweRk5JfRroTXyklavpaYga
         IVWvJZvH1vvnLnlKeRhoMsPI8k4GJNgIIyoIsCEDUmiP34uh1+MyuOvKsieFord9WRJE
         DcEu8IJO88+2SwAfeX7g1Nspfg8gQq35nG+CBOmBin5Pb8YHqhVC+T3C+JoRaNUPfgW1
         Kl+mWxxhA2BrISb1i4PhlH7Yy90cBNrGh0X9HQvJOs1hF3ME9OrcnRBAi0usyudF9QIN
         ylnnf71adVzkPxQwtG7G8wvmamJlPGEyrOrO3aScQFjLzkx6s/XtO9ETTVdkoKr05e9E
         /HBQ==
X-Gm-Message-State: AOJu0YySDocgON4mTbt96wzI1FP60ZhTZvGc85rMecAulQ0i712EoXc1
        z8YXjRl1ZBrdLDh7P90GbgWJDqpmj+FY4vUFea7nMA==
X-Google-Smtp-Source: AGHT+IEPbpu+f+x7Mxg2JcryCNwUiv/H2T0EP2OKWQkM+1Az2v0erf8Suz+I1yRTsUHgS+cLuGC8uIDdKyjo9397fDA=
X-Received: by 2002:a5b:1c3:0:b0:d78:ae6:e75a with SMTP id f3-20020a5b01c3000000b00d780ae6e75amr4738510ybp.60.1694699372664;
 Thu, 14 Sep 2023 06:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230828100421.19758-1-balamanikandan.gunasundar@microchip.com>
 <CACRpkdZKALgcN58Es_hKL1MyEKYaTezuRGyaMkkBYyfXhRpdKg@mail.gmail.com> <CAPDyKFrX1JNBio1tm4TbOwO4KSGP5ZHsLbJEXVv8qn-2Cq_KJg@mail.gmail.com>
In-Reply-To: <CAPDyKFrX1JNBio1tm4TbOwO4KSGP5ZHsLbJEXVv8qn-2Cq_KJg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 15:49:21 +0200
Message-ID: <CACRpkdaAqG86XwO0FcKdgNggthW7=v2L=GfhUbr-dhc99tXxyw@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Remove preprocessor directive
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 2:16=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> On Tue, 29 Aug 2023 at 09:18, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> >
> > On Mon, Aug 28, 2023 at 12:04=E2=80=AFPM Balamanikandan Gunasundar
> > <balamanikandan.gunasundar@microchip.com> wrote:
> >
> > > Remove the preprocessor directive IS_ENABLED(CONFIG_MMC_ATMELMCI) whi=
le
> > > checking if the device is compatible with atmel,hsmci. Instead handle=
 it in
> > > the if() condition. The compiler optimizes out the entire if() clause=
 if
> > > the first expression in the if() clause is constant false.
> > >
> > > Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@m=
icrochip.com>
> > > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Thanks for tidying this up Balamanikandan!
>
> Linus, we didn't manage to get this into v6.6. So, it's probably
> better if you pick up this via your tree for v6.7.

Oh it's actually Bartosz managing the GPIO tree these days.
(Which I am very happy about!)

The best is to resend the patch to the GPIO maintainers and
linux-gpio@vger.

Yours,
Linus Walleij
