Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DC8112AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379194AbjLMNUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379207AbjLMNUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:20:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F6D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:20:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3363eba94ebso382410f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702473642; x=1703078442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hnDLGznNjf0HtUhZB6DiqmuEaPkDCvG/kcvfPciErs=;
        b=HuT/CweCmS/3ati45b7FdqfhZun3kaMzOJZo9XaUk46zQzTeY4OoCIP9NQP+Y4CzSd
         wZHyzrq+0QQkzOFrSngEiofveXjH7qV+uHnh+E+dP89imiqIsrUYadd8QfbyvHT1s/cO
         TIfAZqnKK59HgEOUUPQbaGAUo6RZps5k+PqYUHP60PrxI/L/MwFH4ANnW2qaoiipRtIo
         WuYz+C0Ei55/ITQXpoJETdMWFhTc3ianc9dyIkJFRkKPKci+ghGEbUixh5S7atB/DLre
         KEK6LdqigUu3wOEtVeeiOJK7ubjcoPnzsXVOngbcBMIsAhih4t0qh/qav/6KAoT5AHeY
         iNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473642; x=1703078442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hnDLGznNjf0HtUhZB6DiqmuEaPkDCvG/kcvfPciErs=;
        b=JxnFyBqsx8usdB89ltp6a9deoHtlB/kzv1m129923N7VJ/nh3hzKJPIJgEDkY6q5k5
         uKuXDVmjlQ3bcd0jFhoC3GAF2FTUwxp3Z1ubT4/L7z5Gq80A6Tm6qggfIy9406ALXzU3
         NSP67HaGdVwB71o4c+jQF+QFPj69wAUf7pjxL+Ow6BGx0kb7hTDjsrkQAQoGprk8Fpzx
         aKqteRikDMuo76k3i9SHPnzp6b3NgRIj7oIF71cXCB0+7RH3Rc8YBoEL1IFt6D1FPY5w
         VtlHxP0ulpV+KoGY4CEhmR3c2F29meLb3Zq/LeYXfldBje9uQoFpQVZXa8vtbK74sKOt
         5y2A==
X-Gm-Message-State: AOJu0YwwpULqP0aWtZggzMdnldA/50cTSEtWUIwKpCND08DXFPiZmdrh
        ewhXeQ015M1qza2j3W9nLSmyQTpjoLTO7iEInqkws3wuEkk=
X-Google-Smtp-Source: AGHT+IEi2FRebzf2c0UKw/ArqXVED0eN66fs7jAd0iEKyqrp0rg/xx0b0wlajsv8dow/5rUyQm6h1ihahHufDcDYLM8=
X-Received: by 2002:adf:f94c:0:b0:334:bca8:4e64 with SMTP id
 q12-20020adff94c000000b00334bca84e64mr1484593wrr.143.1702473642020; Wed, 13
 Dec 2023 05:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20231211052850.3513230-1-debug.penguin32@gmail.com> <CAKEwX=MzkBt1F2WZaacuCQ+E6eWt1AKvbGZ6JFHy5tkoYigqQg@mail.gmail.com>
In-Reply-To: <CAKEwX=MzkBt1F2WZaacuCQ+E6eWt1AKvbGZ6JFHy5tkoYigqQg@mail.gmail.com>
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Wed, 13 Dec 2023 23:20:04 +1000
Message-ID: <CALk6Uxog_LLF2dec2J54baMfee8jCOEabjWLG6-L=FEyZ-FFBQ@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     sjenning@redhat.com, akpm@linux-foundation.org,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,
Thanks for checking.
On Tue, Dec 12, 2023 at 12:16=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Sun, Dec 10, 2023 at 9:31=E2=80=AFPM Ronald Monthero
> <debug.penguin32@gmail.com> wrote:
> >
> > Use alloc_workqueue() to create and set finer
> > work item attributes instead of create_workqueue()
> > which is to be deprecated.
> >
> > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > ---
> >  mm/zswap.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 74411dfdad92..64dbe3e944a2 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
> >                 zswap_enabled =3D false;
> >         }
> >
> > -       shrink_wq =3D create_workqueue("zswap-shrink");
> > +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> > +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 0);
>
> Hmmm this changes the current behavior a bit right? create_workqueue()
> is currently defined as:
>
> alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))

create_workqueue is deprecated and it's observed that most of the
subsystems have changed to using alloc_workqueue. So it's a small
minority of few remnant instances in the kernel and some drivers still
using create_workqueue. With the create_workqueue defined as is , it
hardcodes the workqueue  flags to be per cpu and unbound in nature and
not giving the flexibility of using any other wait queue
flags/attributes. ( WQ_CPU_INTENSIVE, WQ_HIGHPRI, WQ_RESCUER,
WQ_FREEZEABLE, WQ_UNBOUND) . Hence most of the subsystems and drivers
use the alloc_workqueue( ) api.
#define create_workqueue(name) \
alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))

> I think this should be noted in the changelog, at the very least, even
> if it is fine. We should be as explicit as possible about behavior
> changes.
>
imo, it's sort of known and consistently changed for quite some time alread=
y.
https://lists.openwall.net/linux-kernel/2016/06/07/1086
https://lists.openwall.net/linux-kernel/2011/01/03/124
https://lwn.net/Articles/403891/   =3D> quoted: "The long-term plan, it
seems, is to convert all create_workqueue() users over to an
appropriate alloc_workqueue() call; eventually create_workqueue() will
be removed"

glad to take some suggestions , thoughts ?

BR,
ronald
