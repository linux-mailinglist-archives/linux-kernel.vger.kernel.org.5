Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9680BF45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjLKCht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjLKChq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:37:46 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E3C106;
        Sun, 10 Dec 2023 18:37:51 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so3846094276.0;
        Sun, 10 Dec 2023 18:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702262270; x=1702867070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG4sHl1+Rg4Z/xgVyvuBLnRm0lugzakZ3vwchsyrEQc=;
        b=Fwc8nMCNVsTokkj9WvE4jzKr8MGrYqc/fiUlx5BNpxjYBV/jw5nJwkMcYGroVS7THL
         z4MM/luHfId1fzNuu9E1cmjms9+NY9OP+moKi/wDWf5lk2i4FE8Q7zcCjEiOZ7hPW0jN
         68Y2TadfXn15bJnaOwU5CSvP2vDibsJuzvvFAuu7aZDyVDRoMpJlpXVOl4IU40a2Ynke
         IsOOZBK+MyythyQMf+Gum1GwWOus3QeO4qwOckvFnmkE3g/Mm+DhbuL/J/ihJ8gVYGqH
         PquQYiWoHQ6tCyWPC3VxgkYzE9CFmynl1OXdWee5uuuRXe4s6vASm5vdt9FLlFDtNXm8
         vJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702262270; x=1702867070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG4sHl1+Rg4Z/xgVyvuBLnRm0lugzakZ3vwchsyrEQc=;
        b=sw14j2c3BYFMVQhAXgflLdPmhu/7u3wVC7zR//FF+Eqea56P2hzelZhmRoN5hSAGhR
         8lzWsKb27a7Wd/Vktnpfw/57PQ2lC6CKe0oUS1UfGAoJj5tD6FFL7BMAg/2RxYvWYwAW
         VGV8FPt/BsmHrXC+KVS5KW/+MhrkNji4VjKHcXbtZRZYiQRK2EDiV7uLGXTT7VWMuPsV
         DAtlUW/tVXYUI79YNGA+Ni6njpsY8FntvMCxyHWCby9fFYSNVUxYR/jVaq6iZGYt+2Wn
         4gYYJnQp8yH91Ud5Ayf/OEWNK9ZZe5hb7HliPb2uFG6TifTehc1ykAxT0RRr4gjwTh+2
         0MEg==
X-Gm-Message-State: AOJu0Yybu6UjG1YTGdibRfUyLmutD5EbI1RACVhPdT17XvQvK5/2Gs0R
        V6RkQ6v9YJiQ/epU3/LUXnaf4k7IDWsgU2xPdMBLf2qq5h/Xwg==
X-Google-Smtp-Source: AGHT+IF5P/iRJXIlAzvwBf7PlGge0Qd7ZNb+KBmDfz5v6QcSS3pTlCPdnzoEou5vtd60K+6uQEkZ2WmQPidVPiSRUjA=
X-Received: by 2002:a25:5f02:0:b0:dbc:6a10:5186 with SMTP id
 t2-20020a255f02000000b00dbc6a105186mr1240189ybb.41.1702262270533; Sun, 10 Dec
 2023 18:37:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700449792.git.zhoubinbin@loongson.cn> <fc9b3afaf8826fd437ba91397eb7fa231db2c05c.1700449792.git.zhoubinbin@loongson.cn>
 <87lea4srmx.ffs@tglx>
In-Reply-To: <87lea4srmx.ffs@tglx>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Mon, 11 Dec 2023 08:37:39 +0600
Message-ID: <CAMpQs4+dLk5KG3L0vF4ZBGqbCLKWtCCkQz4wER3yKfsii5GeEA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] irqchip/loongson-liointc: Fix 'loongson,parent_int_map'
 parse
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 10:20=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Mon, Nov 20 2023 at 17:06, Binbin Zhou wrote:
>
> $Subject: s/parse/parsing/
>
> > In keeping with naming standards, 'loongson,parent_int_map' is renamed
> > to 'loongson,parent-int-map'. But for the driver, we need to make sure
> > that both forms can be parsed.
>
> Please keep changelogs in neutral or imperative tone:
>
>   For backwards compatibility it is required to parse the original
>   string too.
>
> Makes it entirely clear what this is about without 'we'. See also:
>
>   https://www.kernel.org/doc/html/latest/process/submitting-patches.rst
>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-liointc.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/i=
rq-loongson-liointc.c
> > index e4b33aed1c97..add2e0a955b8 100644
> > --- a/drivers/irqchip/irq-loongson-liointc.c
> > +++ b/drivers/irqchip/irq-loongson-liointc.c
> > @@ -330,6 +330,7 @@ static int __init liointc_of_init(struct device_nod=
e *node,
> >       bool have_parent =3D FALSE;
> >       int sz, i, index, revision, err =3D 0;
> >       struct resource res;
> > +     const char *prop_name =3D "loongson,parent-int-map";
>
> Please don't glue variables randomly into the declaration section:
>
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#vari=
able-declarations
>
> >       if (!of_device_is_compatible(node, "loongson,liointc-2.0")) {
> >               index =3D 0;
> > @@ -350,8 +351,12 @@ static int __init liointc_of_init(struct device_no=
de *node,
> >       if (!have_parent)
> >               return -ENODEV;
> >
> > +     if (!of_find_property(node, prop_name, &i))
> > +             /* Fallback to 'loongson,parent_int_map'. */
> > +             prop_name =3D "loongson,parent_int_map";
>
> This lacks curly brackets:
>
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#brac=
ket-rules

Hi Thomas:

Thanks for the detailed review.

Rob suggested in the V5 patchset to remove the
'loongson,parent-int-map' renaming operation as an ABI breakage[1]. I
had tried to explain that the driver would be compatible with the
parsing of both naming styles[2], but unfortunately did not get a
response from Rob.
As a result, I removed the renaming-related patches in the V6
patchset, including this one[3].

However, how the 'loongson,parent-int-map' renaming operation is
finally going to be handled needs to be decided together, and if it
remains needed, I will fix the above issue and submit it as part of
the V7 patchset.

[1]: https://lore.kernel.org/all/20231127182836.GA2150516-robh@kernel.org/
[2]: https://lore.kernel.org/all/CAMpQs4LSTV6PgZSuyQx2Nq+87OHxSa=3D-Wz5nbhF=
VsmmvHubQFQ@mail.gmail.com/
[3]: https://lore.kernel.org/all/cover.1701933946.git.zhoubinbin@loongson.c=
n/

Thanks.
Binbin
>
> >       sz =3D of_property_read_variable_u32_array(node,
> > -                                             "loongson,parent_int_map"=
,
> > +                                             prop_name,
> >                                               &parent_int_map[0],
> >                                               LIOINTC_NUM_PARENT,
> >                                               LIOINTC_NUM_PARENT);
>
> Thanks,
>
>         tglx
