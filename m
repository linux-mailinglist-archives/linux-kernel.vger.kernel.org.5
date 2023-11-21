Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC687F247A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjKUDHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUDHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:07:22 -0500
Received: from mail-108-mta197.mxroute.com (mail-108-mta197.mxroute.com [136.175.108.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C4BD2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:07:17 -0800 (PST)
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta197.mxroute.com (ZoneMTA) with ESMTPSA id 18befd89f01000190b.002
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 21 Nov 2023 03:07:13 +0000
X-Zone-Loop: 2fb9a435ca6667e22c665c078c2ec673d79e28685d6a
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kelvie.ca;
        s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:
        From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yv3ur+VJgPZw5HSVfRVyxfBSzyF5tf8z7FkRU5st0L8=; b=oDbnF1ZC4la1YdwywqU+G9G6Qe
        88QaVloZ0eYUc3Q8326JwRDRR9L7KpUQDUeJHaBpl6vvrw9TPp9mLGogorfxAA8ocY3E2oYaW9fPM
        nqi6zTnljzLw/5sdUQRGM4YlPHb3sfFtlco5NTPNlx5uaXx5K+//rWwp2R2EXRRvdJey09ucj6AHv
        w7AJbKxjX+iQIzgqN2rqYHrSYku+Iuq/ONlfFCv1aQnZUqsfUM+KOlsNCQFN3X+OpRF8tbPgj6O9q
        n/1zy96mP0v3cVtBYBw62qqaRj2s9V7iOUz4fEjBLC66aeRJ2CoiS+hN3CAC8/yrxY+phHLYLTT81
        zhqqziwg==;
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2851b271e51so1416788a91.1;
        Mon, 20 Nov 2023 19:07:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7tyGV0qyJbexqXA/sKLzQoyKaLi1uOh8nh69fys8AIvAxm1vc
        wIXG1Wj5hPZEIYwEm189QkFjwT3Lf9BYZuF36qQ=
X-Google-Smtp-Source: AGHT+IHon8FUuNWN6OAvDXiT56AU977GCXjbZnY29yNHWhPtGrU+rTKXg7n8CadQaTmdi00890/QXuJBCYzK0xTkkfk=
X-Received: by 2002:a17:90a:6881:b0:280:a4a1:5d03 with SMTP id
 a1-20020a17090a688100b00280a4a15d03mr2108500pjd.4.1700536030830; Mon, 20 Nov
 2023 19:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20231114022503.6310-1-kelvie@kelvie.ca> <a66a805c-3e1f-4b9a-a38e-aca84b8678a6@infradead.org>
 <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com>
In-Reply-To: <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com>
From:   Kelvie Wong <kelvie@kelvie.ca>
Date:   Mon, 20 Nov 2023 19:06:59 -0800
X-Gmail-Original-Message-ID: <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com>
Message-ID: <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com>
Subject: Re: [PATCH RFC] Add a lockdown_hibernate parameter
To:     Paul Moore <paul@paul-moore.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: kelvie@kelvie.ca
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 at 13:12, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Nov 13, 2023 at 11:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> >
> > [add security & dhowells]
> >
> > On 11/13/23 18:23, Kelvie Wong wrote:
> > > This allows the user to tell the kernel that they know better (namely=
,
> > > they secured their swap properly), and that it can enable hibernation=
.
> > >
> > > I've been using this for about a year now, as it doesn't seem like
> > > proper secure hibernation was going to be implemented back then, and
> > > it's now been a year since I've been building my own kernels with thi=
s
> > > patch, so getting this upstreamed would save some CO2 from me buildin=
g
> > > my own kernels every upgrade.
> > >
> > > Some other not-me users have also tested the patch:
> > >
> > > https://community.frame.work/t/guide-fedora-36-hibernation-with-enabl=
ed-secure-boot-and-full-disk-encryption-fde-decrypting-over-tpm2/25474/17
> > >
> > > Signed-off-by: Kelvie Wong <kelvie@kelvie.ca>
>
> I would feel a lot better about this if there was a way to verify that
> the swap was protected as opposed to leaving that as a note in a doc
> that the majority of users will never see, read, or understand.

I'd argue that this wouldn't even be necessary if we detect the swap was
protected -- hibernation should just be enabled in that case without settin=
g
any parameters.

My understanding is that it was disabled waiting for this
functionality, and it's been
at least a couple of years now [1], so it looks like it's not such an
easy problem.

Anyway, my argument is that the majority of users will never use this kerne=
l
parameter anyway, so I think it's a fair assumption that the power users th=
at
*do* use this will educate themselves on why this parameter even exists.

[1] https://lwn.net/Articles/847042/

--=20
Kelvie
