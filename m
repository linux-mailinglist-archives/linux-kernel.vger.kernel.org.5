Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D97A7F74A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjKXNOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:14:12 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6410DC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:14:18 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so1786099276.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1700831658; x=1701436458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZaK+IRCHYZVeuIwCCx8MjbxD5RCfoi/UxbkuHPIU0k=;
        b=egIk8dXPn1JdKVAUJczXqe9/To1FBZs5270x7dh1gBioyeuwe02XtXxHy8laSs56/9
         fMY8gKdduuS+H1gnaE1ihQkAe7qKiwCQdI6kJooGDgRZFnKhu30OSJIGMOjz5ytBiILQ
         ozPtyZqKcjNs6z95eJMVV7ddVTxVU/T/6ODCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831658; x=1701436458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZaK+IRCHYZVeuIwCCx8MjbxD5RCfoi/UxbkuHPIU0k=;
        b=sc5Y693tfu33FaccepuJt/IeC53GPWy4Pd7cV+QZOhzunZ3bhyvP+cpZ8v+qCFLVD6
         Hhi8eRoBad905YlkQxSZEdg8q56xf0BoqCcBbQoMUBJ8n6F23Zk3V9t/Y3Yd7s8QEmXh
         6Nrou6UDNVghSnMrldwZPhTICj62a+c1MTsYnG7zrZDSJe36mBY7upgvc+Fkamc6noTx
         zFyNMasoM36QQHUZPZpxqdhgG9r0WZfjdgx59r3hazbG2ppn7XEKZUzsNVPX61Dz84iu
         Y7mD99IT1dLmqOOzMsojyr0/0Its38dRqkSlgGbsENFUUSTUffvS9ZYJ21JBhQ1tRtp/
         wt0w==
X-Gm-Message-State: AOJu0YwCh6cny71qOKayBd0E3QiKnK5Nsrvrv+Ynhj791UBl6wX7oBlg
        0rYuU0QWbt+wof42u+/vMqAQUzxNRi+5f1uAIpPXpQ==
X-Google-Smtp-Source: AGHT+IFB4TAblmvPDwOeBKvW2nDTani0cluwcTTsPtTZG2Z1ImHjDc09Mjf/2Abn7pO8Ej5yfYgO3NeRgrgLTzTIFQs=
X-Received: by 2002:a25:a306:0:b0:d99:d1b8:672f with SMTP id
 d6-20020a25a306000000b00d99d1b8672fmr2117371ybi.33.1700831657808; Fri, 24 Nov
 2023 05:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20231124100241.660374-1-dario.binacchi@amarulasolutions.com> <4ce802db-b6d0-4eec-9ae2-5383a6f01843@csgroup.eu>
In-Reply-To: <4ce802db-b6d0-4eec-9ae2-5383a6f01843@csgroup.eu>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Fri, 24 Nov 2023 14:14:06 +0100
Message-ID: <CABGWkvrvaanicdZi2zaSrWHCrcfFt6Zf2RK6X1oRX=kA28ZfBQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx: Fix typo in code comment
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>, Scott Wood <oss@buserror.net>,
        Timur Tabi <timur@freescale.com>,
        Zhicheng Fan <b32736@freescale.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 2:08=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 24/11/2023 =C3=A0 11:02, Dario Binacchi a =C3=A9crit :
> > s/singals/signals/
>
> Is that really worth it to spend time on such a change ?
>
> By sending such a patch, you require people to spend time reviewing your
> patch, then maintainer has to spend time handling your patch.
> Furthermore, as you added a Fixes: tag, LTS maintainers will have to
> spend time handling that too.
>
> Do you really think that this typo is worth a patch ?
>
> This kind of tiny error should be fixed through a more significant patch
> adressing this file. But it is not worth a patch on its own.

It's not the first time I've submitted patches of this kind, and no one has
ever complained before. However, if it has become an issue, I won't do
it anymore.

Thanks and regards,
Dario
>
> Christophe
>
>
> >
> > Fixes: 04e358d896a7 ("powerpc/85xx: Add Quicc Engine support for p1025r=
db")
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >   arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/p=
latforms/85xx/mpc85xx_rdb.c
> > index ec9f60fbebc7..e0cec670d8db 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > @@ -76,7 +76,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
> >                       /* P1025 has pins muxed for QE and other function=
s. To
> >                       * enable QE UEC mode, we need to set bit QE0 for =
UCC1
> >                       * in Eth mode, QE0 and QE3 for UCC5 in Eth mode, =
QE9
> > -                     * and QE12 for QE MII management singals in PMUXC=
R
> > +                     * and QE12 for QE MII management signals in PMUXC=
R
> >                       * register.
> >                       */
> >                               setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_Q=
E(0) |



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
