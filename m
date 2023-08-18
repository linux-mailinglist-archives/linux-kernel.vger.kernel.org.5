Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF67814D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbjHRVf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbjHRVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:35:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87F30F6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:35:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d66d85403f5so1749632276.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692394504; x=1692999304;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HT9OLva7ctZ9FmGSdmGTI+CfACfdC5dLxUuYrv72fo=;
        b=PcbXJ+KA6o6iyAYZS94E3t07VykUVfWBMqlusbYDvXpKF1eMJBQAgX7tjdywYzTzLN
         3wd3ZmfFufeeDeg+KXnzyivmdM4pns78ZgBOhxVenYLgafbFsduWPPFCqG7fFCKeYbiv
         ULoqRMHPVtz7P+xtZ3E9r0qPEFRdCjYjh3prT81wePw9MrQXTckdVmnwUjtAhDwUDfjV
         MhfRp9T+iqf1EW+uxXJZtzHW5uM2gEFxNbI87MduUd+x0LTynG3frBIxmLWCAmZBYZn6
         kFAMrrMzT1k6JuWnwYEj3U5kyg972RajXgYUiM1mUZaR55eRzUbnhrZud7DSgaTARcVB
         KqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692394504; x=1692999304;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8HT9OLva7ctZ9FmGSdmGTI+CfACfdC5dLxUuYrv72fo=;
        b=JfoYMqJPPv/UbBT/46DvwB4mGWLqUpIOEIkJsIDhUm6S5pR/+HnEMLpv/2H3RJp/CK
         pJkDEG8JYDbnQC1AvPvw+F5ysXsXdM5J2u5/ssbmmr3XhFySdoc2VNoYBWd1rV9+pnkl
         o/z4k+GdT3+d9Roq8GfOj2V8EkMM/Hlqb9+c3wGfyrJo6shNnZlwCiWLLjhQIJYSZxiW
         SRLPJA3AyugPWKO3GUVInHnJdnkZtUgFLi8GMfgxo7gBWLwJK13qEpIASCtOjQ3OQErB
         RHIheaNsi97UzJ8ChEQA47ODgD6gngJgIme6JpZN5cDQ4dY9PepQnG3LD9LZwqgz5AoT
         0/4g==
X-Gm-Message-State: AOJu0Yz0TfD0N59vAM2WB62R4gYj4/dzjIuw5iMCeZausuq4Yy6w/3TF
        mV3vAut8slR5rOmF3YAT7XSBCbfJSnCQEg==
X-Google-Smtp-Source: AGHT+IHVyZ5oiTbNHGh85EvdQ0kcqe/9Bf4lGDyZmyjW96W2SvbEviUVuJkxA43SqNcR5J8YCK9xiE7VA2+NDg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:1606:b0:d06:3c3c:17eb with SMTP
 id bw6-20020a056902160600b00d063c3c17ebmr4674ybb.5.1692394504605; Fri, 18 Aug
 2023 14:35:04 -0700 (PDT)
Date:   Fri, 18 Aug 2023 21:35:02 +0000
In-Reply-To: <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
Mime-Version: 1.0
References: <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org> <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org> <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
 <20230818183538.GA142974@cmpxchg.org> <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
Message-ID: <20230818213502.nsur4qbs7t7nxg54@google.com>
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Yu Zhao <yuzhao@google.com>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:44:45AM -0700, Yosry Ahmed wrote:
> On Fri, Aug 18, 2023 at 11:35=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.=
org> wrote:
> >
> > On Fri, Aug 18, 2023 at 10:45:56AM -0700, Yosry Ahmed wrote:
> > > On Fri, Aug 18, 2023 at 10:35=E2=80=AFAM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > > On Fri, Aug 18, 2023 at 07:56:37AM -0700, Yosry Ahmed wrote:
> > > > > If this happens it seems possible for this to happen:
> > > > >
> > > > > cpu #1                                  cpu#2
> > > > >                                              css_put()
> > > > >                                              /* css_free_rwork_fn=
 is queued */
> > > > > rcu_read_lock()
> > > > > mem_cgroup_from_id()
> > > > >                                              mem_cgroup_id_remove=
()
> > > > > /* access memcg */
> > > >
> > > > I don't quite see how that'd possible. IDR uses rcu_assign_pointer(=
)
> > > > during deletion, which inserts the necessary barriering. My
> > > > understanding is that this should always be safe:
> > > >
> > > >   rcu_read_lock()                 (writer serialization, in this ca=
se ref count =3D=3D 0)
> > > >   foo =3D idr_find(x)               idr_remove(x)
> > > >   if (foo)                        kfree_rcu(foo)
> > > >     LOAD(foo->bar)
> > > >   rcu_read_unlock()
> > >
> > > How does a barrier inside IDR removal protect against the memcg being
> > > freed here though?
> > >
> > > If css_put() is executed out-of-order before mem_cgroup_id_remove(),
> > > the memcg can be freed even before mem_cgroup_id_remove() is called,
> > > right?
> >
> > css_put() can start earlier, but it's not allowed to reorder the rcu
> > callback that frees past the rcu_assign_pointer() in idr_remove().
> >
> > This is what RCU and its access primitives guarantees. It ensures that
> > after "unpublishing" the pointer, all concurrent RCU-protected
> > accesses to the object have finished, and the memory can be freed.
>=20
> I am not sure I understand, this is the scenario I mean:
>=20
> cpu#1                      cpu#2                             cpu#3
> css_put()
> /* schedule free */
>                                 rcu_read_lock()
> idr_remove()
>                                mem_cgroup_from_id()
>=20
> /* free memcg */
>                                /* use memcg */
>=20
> If I understand correctly you are saying that the scheduled free
> callback cannot run before idr_remove() due to the barrier in there,
> but it can run after the rcu_read_lock() in cpu #2 because it was
> scheduled before that RCU critical section started, right?

Isn't there a simpler explanation. The memcg whose id is stored in the
shadow entry has been freed and there is an ongoing new memcg allocation
which by chance has acquired the same id and has not yet initialized
completely. More specifically the new memcg creation is between
css_alloc() and init_and_link_css() and there is a refault for the
shadow entry holding that id.
