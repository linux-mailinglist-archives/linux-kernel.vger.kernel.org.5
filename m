Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1A8131E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572915AbjLNNmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjLNNmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:42:53 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0353D11B;
        Thu, 14 Dec 2023 05:43:00 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-425b9acaf80so41626121cf.1;
        Thu, 14 Dec 2023 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702561379; x=1703166179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F5f95LcvN3I9tb1o2cf6Anqpz0ggkd9L4sVElAB9xQ=;
        b=KrCEpFTirDHHeMuBW/hvVYpL3MegdF7916PQVQwFiYWlNFBiE9yzKXmI20eSpV+JQ8
         YLuKQ3tkM7lf9NWUrtgH07XGx5EnP5dqXgXTXuVIn30dmV6xazGkyYY5NVrBEmyqe5OL
         FavGdZJ3qayhpgnW/sfHRA7JWYfGSrPtHT/9dHAra6B/v0j5elLVjmda0s2bCjkfKwuJ
         AT1rR3h8POC/YsIHFyMbZAsi9TalhZYiJU43UcHU9XD+GIjO7MJWPjotgC20XypC9mpg
         8zb7V3wHrerrhQjsSL7Wpn2j1PEq25zlKfFhdLCZZQiKnQuVXSF9elfgq0nJ2LMfny6V
         DTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561379; x=1703166179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F5f95LcvN3I9tb1o2cf6Anqpz0ggkd9L4sVElAB9xQ=;
        b=RIZSGe8E1T9FkREROrS+xB/FILQrIDzR7ubRtq3iBAahtORsgL9Z1/EjmVLtFO7kvG
         iqMI5rCNJtT2p5nWbpZjjYmaoyGz0dIa6+gChvFPvERFuzrdQyic9+7QEoXKbgCwKxlZ
         FqtYXYYtDVR5rl3IJ3nwMUb4V7tHVpQmfmE+iOQjYjOlzen876dLrsS6UF1xHuGNyWVc
         Ng9qwD1sOfX9Ngb49y74dWELY30G69EZYBFct+9L8fN0GxmDTm6EUw1pblZAGp1MzAHD
         UkxjI2Xu9HtXY+RDBmKou8sg/xGZAQsisBNKewmr8VMQqRIekEr5ah+uTZeDCpShRPEP
         nMBA==
X-Gm-Message-State: AOJu0YwMHJUWJtjeeWtV17faZlCAQbVzosCclxrbuuMgzj5aLaoqjiIJ
        LzATg6CnwN6yhEu1wvcWDVt73G6aUoJ3E2nyb0XlnWguedg=
X-Google-Smtp-Source: AGHT+IG00DW8WGswWCLm8yY3QQCwaCYiYaSFZPez3AXd/Nc0ny4e8JjzlOJQZ461VPjmiEA7j5c6AF2J23iRG5qr0YA=
X-Received: by 2002:a05:622a:148f:b0:425:4043:1897 with SMTP id
 t15-20020a05622a148f00b0042540431897mr13407370qtx.74.1702561378940; Thu, 14
 Dec 2023 05:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
 <20231213223020.2713164-4-gnstark@salutedevices.com> <80881d5d-3ae9-4580-84c1-f25b421cc518@csgroup.eu>
 <99882775-af52-49ea-b17d-f3d1f23f8bbe@salutedevices.com> <717727a1-6a99-43ff-b032-b7a20542cca8@csgroup.eu>
In-Reply-To: <717727a1-6a99-43ff-b032-b7a20542cca8@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Dec 2023 15:42:22 +0200
Message-ID: <CAHp75VdLT9cOuKn-d14Dp5Ve2NBXAdHQZWeXTLLjYxCQZZQtEw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] devm-helpers: introduce devm_mutex_init
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     George Stark <gnstark@salutedevices.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "vadimp@nvidia.com" <vadimp@nvidia.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "nikitos.tr@gmail.com" <nikitos.tr@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kernel@salutedevices.com" <kernel@salutedevices.com>
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

On Thu, Dec 14, 2023 at 3:00=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 14/12/2023 =C3=A0 13:48, George Stark a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de gnstark@salutedevices.com.
> > D=C3=A9couvrez pourquoi ceci est important =C3=A0
> > https://aka.ms/LearnAboutSenderIdentification ]
> > On 12/14/23 13:06, Christophe Leroy wrote:

...

> >> So you abandonned the idea of using mutex.h ?
> >
> > I'm not the one who make a choice here. The patch [1] you're talking
> > about was seen by everyone but it seems like no one had shown interest.
> > For me personally approach with #define mutex_destroy is not very usual
> > but if even slight mixing device with mutex.h is unacceptable what else
> > can we do? Avoiding the need to allocate devm slot for empty
> > mutex_destroy is more important.
> >
>
> Why would a forward declaration of struct device in mutex.h be
> unacceptable when it is done in so many headers ?
>
> $ git grep "struct device;" include/ | wc -l
> 164

I believe the main misunderstanding here is where to put the
implementation. AFAIU Christophe wants the implementation to be in the
very same _C_-file where mutex_destroy() is defined. mutex.h in this
case indeed requires the only forward declaration and hence doesn't
need to include device.h.

--=20
With Best Regards,
Andy Shevchenko
