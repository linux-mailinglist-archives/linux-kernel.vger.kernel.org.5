Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C11F7D316D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjJWLJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjJWLJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:09:03 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05C4C5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:09:00 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66cfd874520so20335216d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698059340; x=1698664140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOK8b3gr6rCBDxroHMvto9djvnyPet40btVJFkOvoUY=;
        b=DyTiNnY4EMwPqnNuhrOheFtCtUrmy02DBWnfWnBqDQ3W7BaT74LXC6ZHQyY3ebj8Pj
         Vajd0goGP8VUpEyL8zvOijjnbXAIeFZyUmRfhtMmZ+AubDqEGA9d5zNDjxIkbqPwvVYP
         GrgjJU5CUQLDG6Dnz3Mz34jwve82jDCyGTC8Lxl+KI4kkVfNXD20j956afnAHLOSXk37
         2XqUw+PUgRrQMbjsw5PcD6sBWfYTKye3eRAGSnC1OL4tklQEkuEo6TC++I2BFZ8kd6E5
         OirZKVT9/dozMlxXrt+Il2uAmjp7uHugDQGvPESrQR7Q12LolBFMf7yUzN+Z2+YwD1IH
         HT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698059340; x=1698664140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOK8b3gr6rCBDxroHMvto9djvnyPet40btVJFkOvoUY=;
        b=DWO5pwMst4Gjn4A7je7pmeYqYV8od4haYcpfMPjTQZgoncD3yTZUFZXEAWutJO5Cu1
         1oNRYvGVbXgtLFTmZU2e0OuOXlxtNfpfdJiZYDDfvs/7m/QermH4m6VGvwhEZFKlUSUI
         bOhJVRvgYDQd6+fTkakmBIGyw+Y4OAiL4HWA8I7wlBc6O33EhaO+WdpCdvRAyPLKewFA
         3vZ2Qi+sL0mZ3DaHzJuIHNUDcYGueUORo+Enlfbwidkoyt9TDLt+XNjhuhrmckIsyDYT
         oSib636Sb2nWOIMaBgMEWW5FS3IOBZ7sqte76r5Fv8DDBpHXAqDJkxnXuBEdtYV1FegS
         mXEQ==
X-Gm-Message-State: AOJu0Yx2UJ2537n4frkO1fohEFO7ZLev3akMteYSL6F7WIsYX+GVwI5K
        +x0KAt0bknVpeETp7KOYsAugCL8tCq4pum9pqKk=
X-Google-Smtp-Source: AGHT+IFDc0XXw2VKn1t4ZQW8Yjb7PRCs7ZqlXu3GnEZICEcVd5ckFIldu8Es8x8PswIYmAzV/p6gmxO0HMXNK2sUqRc=
X-Received: by 2002:a05:6214:27cf:b0:66d:6405:15f7 with SMTP id
 ge15-20020a05621427cf00b0066d640515f7mr12452005qvb.2.1698059339973; Mon, 23
 Oct 2023 04:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
 <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org> <ZSq3iuuGy7zSl4sz@casper.infradead.org>
 <721f24eb6532290c6c4ab4e6d5a50bf8637fcd94.camel@HansenPartnership.com>
 <CAJHePoZVMMCcUNKbg5f9VrYo-x5E_rU1piQGHi67ZuY4Pyj4bg@mail.gmail.com> <5cd5b88ec8f4500a716aa8b96d27d44e96ed65bf.camel@HansenPartnership.com>
In-Reply-To: <5cd5b88ec8f4500a716aa8b96d27d44e96ed65bf.camel@HansenPartnership.com>
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Date:   Mon, 23 Oct 2023 16:08:49 +0500
Message-ID: <CAJHePoayC+RUk4gCCYACRXguuXfeWFvg5cyiCwNi-YxC3-UOLw@mail.gmail.com>
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone approve this patch?

On Mon, Oct 16, 2023 at 7:27=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sun, 2023-10-15 at 10:45 +0500, Muhammad Muzammil wrote:
> > should I create the v2 or this patch is fine?
>
> Personally, I don't think anyone cares about misspellings unless it
> obscures the meaning of the sentence, so, given the interactions in
> this thread, I'd argue the only one really worth fixing is relay ->
> relies.
>
> James
>
>
> >
> > On Sat, Oct 14, 2023 at 9:27=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Sat, 2023-10-14 at 16:45 +0100, Matthew Wilcox wrote:
> > > > On Sat, Oct 14, 2023 at 08:31:35AM -0700, Randy Dunlap wrote:
> > > > > >         /*
> > > > > > -        * The caller from rmap relay on disabled preemption
> > > > > > becase they never
> > > > > > +        * The caller from rmap relay on disabled preemption
> > > > > > because they never
> > > > > >          * update their counter from in-interrupt context.
> > > > > > For
> > > > > > these two
> > > > >
> > > > > I don't know what that (partial) sentence is trying to say...
> > > > > Maybe someone else does.
> > > >
> > > > s/relay/rely/
> > >
> > > relies, surely, being the correct third person singular form of the
> > > verb to match the nominative noun "the caller".
> > >
> > > James
> > >
> >
>
