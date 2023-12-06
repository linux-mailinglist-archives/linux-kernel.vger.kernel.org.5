Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690BE806999
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377172AbjLFI1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377123AbjLFI1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:27:48 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CE18D;
        Wed,  6 Dec 2023 00:27:54 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58d439e3e15so304386eaf.1;
        Wed, 06 Dec 2023 00:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701851274; x=1702456074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1sLit740GBBRQL8zggDwdmRF3hDduJsMAShvja4R2M=;
        b=fgM84towgSAi4Fo8IC2l55RoGKfhOPgaq5A9V/GSqEgljzmIPug70h7LrenPPl6PTd
         PDAqfC++BmmUtYWTtc4cTPJ4UZdvcycBtjJZxoVJm2qUPREaywSBBNNA11XHq1O8nhww
         JtVo2SxAsxQCbkiFPsfze4rv6SMEDVPnAE//Fl9rvb9DZQS7HmEyXsecybMVR8PHqGrW
         W0SzpSOBf7lQnQ2ognddU+5lCBH2XhXMAw1Tasr92jajZQTHBYOlxWti2wvsVImJ5rCr
         nIc5g44ZpbweIwao94kizIGQatGazsNpgdMXv844AUjmigrJuRDeyOFrGH0W5NjtH8RC
         JsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851274; x=1702456074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1sLit740GBBRQL8zggDwdmRF3hDduJsMAShvja4R2M=;
        b=xAG3i80GWN6Y3oe2L4gRIncz7tILyU5RUp6bA3Do7ztiGeFwghGC/vMZHioG95Ifqx
         YIJtEQmXMZVufR4wrOb6gFJbjPBrFR/Js4BqmqVuUZUEbjF6A8R7Sn9b4+mO/Aj+BxmI
         D5Mo/Ry+x7CiZxSA3kJqL2XrJZCi4EjA7laEyeIQ+HdOhtytcNOfUeUG6sg7LAie2HYK
         B5g9nRj9BKMRLTKIPfbVwM8jjSwlaJ0qKnD4aVEcnDqrKCQX3upOqWheZmIcwpCrvCre
         MBi77rVGwtlhlBoaxu2VLeGW7lOmlLr5qW9PqruPqkfqgG3gI9WzR9WXHCTuGBM+dha8
         TJRA==
X-Gm-Message-State: AOJu0YzWj8bGxOS9jLVm53Aerw2XXzpGcw3A4JzsyYiin5LLo1yYpYH0
        DkaH8ItoHs6mS7EUO4d1lMVQUHISgj6vVeeNNBQ=
X-Google-Smtp-Source: AGHT+IFbwC82objqk/yZRySWvh7dDm4eJDRrlhHPkv0gM+1Twv7yvk3J0MOW2D1+Gz5b3T9qzMg8k64/Wrw9NGx+Xd0=
X-Received: by 2002:a05:6870:8194:b0:1fa:ef9d:3f45 with SMTP id
 k20-20020a056870819400b001faef9d3f45mr302490oae.18.1701851273991; Wed, 06 Dec
 2023 00:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20231022090633.792831-1-sergio.paracuellos@gmail.com>
 <513bc341-25b8-5a57-d760-861a3e88a4a1@linaro.org> <CAMhs-H8A0p=nFSnU9pRn=rTC_=CH6jXFQdYgZdimFNq9+dVqSw@mail.gmail.com>
 <ZVxlRE0tcAv1iaoA@alpha.franken.de> <CAMhs-H8bs89SFWPVOEJFT6B+zYh2Anf=DqCJXNaq=Tjiq5X5Ow@mail.gmail.com>
 <CAMhs-H_ojHprCxsRwfXo_xavSYv9YH0eppg9ZobscvQamcDNxg@mail.gmail.com> <ZW+LwrhW9m/vrmnN@alpha.franken.de>
In-Reply-To: <ZW+LwrhW9m/vrmnN@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 6 Dec 2023 09:27:42 +0100
Message-ID: <CAMhs-H_uK+0n-1GwyMegU2x5zNuP7yyAZRzkW4p+OkXiKmK=mw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink architecture
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        linux-mips@vger.kernel.org, john@phrozen.org,
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

On Tue, Dec 5, 2023 at 11:29=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Tue, Dec 05, 2023 at 08:58:29PM +0100, Sergio Paracuellos wrote:
> > On Tue, Nov 21, 2023 at 1:43=E2=80=AFPM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > >
> > > On Tue, Nov 21, 2023 at 10:02=E2=80=AFAM Thomas Bogendoerfer
> > > <tsbogend@alpha.franken.de> wrote:
> > > >
> > > > On Mon, Nov 20, 2023 at 08:59:25PM +0100, Sergio Paracuellos wrote:
> > > > > On Wed, Oct 25, 2023 at 2:58=E2=80=AFPM Philippe Mathieu-Daud=C3=
=A9
> > > > > <philmd@linaro.org> wrote:
> > > > > >
> > > > > > On 22/10/23 11:06, Sergio Paracuellos wrote:
> > > > > > > Its been a while since I am making contributions to this arch=
itecture.
> > > > > > > Hence add myself as maintainer.
> > > > > > >
> > > > > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.c=
om>
> > > > > > > ---
> > > > > > > Hi John, if you are not ok with this please let me know. In o=
ther case
> > > > > > > please ack this patch. I can add myself as Reviewer if you pr=
efer to
> > > > > > > maintain alone this.
> > > > > > >
> > > > > > > Thanks in advance for your time!
> > > > > > >
> > > > > > > Best regards,
> > > > > > >      Sergio Paracuellos
> > > > > > >
> > > > > > >   MAINTAINERS | 1 +
> > > > > > >   1 file changed, 1 insertion(+)
> > > > > >
> > > > > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > > > >
> > > > >
> > > > > Thomas, can you take this patch through the mips tree?
> > > >
> > > > sure
> > >
> > > Thanks!
> >
> > Gentle ping for this patch :)
>
> I've not forgotten it

Thanks for letting me know. I thought it might be lost since I saw
activity in mips-next branch.

Best regards,
    Sergio Paracuellos

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]
