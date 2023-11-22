Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FD27F3CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjKVEVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343580AbjKVEVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:21:42 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E84810C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:21:38 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da37522a363so5934368276.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700626897; x=1701231697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVXWPvtRBhDeG90a/ZedgAdRgWMSJ7Pm+mRwu5c61Bk=;
        b=LIp4UK5+wVWLF5T3o8WstaWzh2Ll++NeLK7bnLZNdYp+0vXVuCuREuol78DN1E8QdW
         dj+/MK6X3XBU3ixJmPbuDDAbupTH7uGHAhedPDx+rEa19evEqaiJt872jqqnoWO0dwBz
         ofolIf2OZcKoDhSATk6z6eiZjn+VgmKApPmqtznsqF7BA1LGAww6T0oS1iDuIm9gyiZF
         98CHYzROdwE95bTHnHFdS6KMVFvUfC1l5SwZDUcq3OuCYfy4KjnoQa02oRRBnn0LuM1X
         9nov61RfuKqnjQbfE0aI1m6rhz4Q3E2j+cMW5D4LakHgqEVyu93d+wvSMd4Z6cHLYQ7D
         GHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700626897; x=1701231697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVXWPvtRBhDeG90a/ZedgAdRgWMSJ7Pm+mRwu5c61Bk=;
        b=v8Imr9zqf45KwHCueZxYYn+NnhbupI1VkaKdhHYSD7XOkNBbnwnhlSgwMJVt2p6ZWd
         aBX5XcUj1tPVZ1zv3ip9wQ2u1/aNd0W+2peif4YCLSl7t7iF/PFYW6zh0nHPCeYdiKYj
         0XzTqSTjB4RXoZ6VbHaPod9r/SEgmEaSiQhXaK67bk+S0EmKvAFImbWP29TyGtWN6mWv
         YejuMy1lcwMg+EdXgD0i04Pp88agcvXbX2ms6B855FLTMfxqJ8g9VOLOzGyjHFtmi+X3
         jMIskgilZTR0g/ezx2mTVz6brVrFVUxVx+4w1w4du2/OXlZT9UK2zH4cVp0skZHTsXrh
         OtLQ==
X-Gm-Message-State: AOJu0YzfPbGe2NI+AyQNwxukB9erqoS6LrK/Sye3hKbgB9fLtrK0LpIH
        Gwn6/DcWEktl4zI7cB5rMcEWs/ylxzRP0vFgPCKW
X-Google-Smtp-Source: AGHT+IE8nMjmv+MMpdCveL8Z01wo2xacBMBUWnBQYMDDwZPg7dC5Q9T1luKYJbPJkntVIqlYW/2qIZJDkEN2u1qQXGk=
X-Received: by 2002:a25:9184:0:b0:d9a:401d:f5da with SMTP id
 w4-20020a259184000000b00d9a401df5damr896533ybl.51.1700626897254; Tue, 21 Nov
 2023 20:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20231114022503.6310-1-kelvie@kelvie.ca> <a66a805c-3e1f-4b9a-a38e-aca84b8678a6@infradead.org>
 <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com> <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com>
In-Reply-To: <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Nov 2023 23:21:26 -0500
Message-ID: <CAHC9VhQeQcEKFKWi2pvGE-DhkaccqBn9Yf_+r7JbZ2UPN+z3-g@mail.gmail.com>
Subject: Re: [PATCH RFC] Add a lockdown_hibernate parameter
To:     Kelvie Wong <kelvie@kelvie.ca>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:07=E2=80=AFPM Kelvie Wong <kelvie@kelvie.ca> wro=
te:
> On Mon, 20 Nov 2023 at 13:12, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Nov 13, 2023 at 11:01=E2=80=AFPM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> > >
> > > [add security & dhowells]
> > >
> > > On 11/13/23 18:23, Kelvie Wong wrote:
> > > > This allows the user to tell the kernel that they know better (name=
ly,
> > > > they secured their swap properly), and that it can enable hibernati=
on.
> > > >
> > > > I've been using this for about a year now, as it doesn't seem like
> > > > proper secure hibernation was going to be implemented back then, an=
d
> > > > it's now been a year since I've been building my own kernels with t=
his
> > > > patch, so getting this upstreamed would save some CO2 from me build=
ing
> > > > my own kernels every upgrade.
> > > >
> > > > Some other not-me users have also tested the patch:
> > > >
> > > > https://community.frame.work/t/guide-fedora-36-hibernation-with-ena=
bled-secure-boot-and-full-disk-encryption-fde-decrypting-over-tpm2/25474/17
> > > >
> > > > Signed-off-by: Kelvie Wong <kelvie@kelvie.ca>
> >
> > I would feel a lot better about this if there was a way to verify that
> > the swap was protected as opposed to leaving that as a note in a doc
> > that the majority of users will never see, read, or understand.
>
> I'd argue that this wouldn't even be necessary if we detect the swap was
> protected -- hibernation should just be enabled in that case without sett=
ing
> any parameters.
>
> My understanding is that it was disabled waiting for this
> functionality, and it's been
> at least a couple of years now [1], so it looks like it's not such an
> easy problem.

I've got to warn you that I have an allergic reaction to arguments
that start with "the right solution is really hard, so let's pick the
easier, worse solution." ;)

> Anyway, my argument is that the majority of users will never use this ker=
nel
> parameter anyway, so I think it's a fair assumption that the power users =
that
> *do* use this will educate themselves on why this parameter even exists.

I guess I'm still not sold on this idea, I'm sorry.

--=20
paul-moore.com
