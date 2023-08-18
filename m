Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0097814EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbjHRVws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbjHRVwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:52:39 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52EF3C2D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:52:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so41421cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692395557; x=1693000357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyzJJLZzQ2GwmUew6/FboLveXIFYOb4sFr1ZSeLKQkQ=;
        b=Ippw4orWVxJ6oq05XFl369NpUPkzESl7NJ4+NScfAvvK41CesrX/bYjOqmj/AAC45a
         AiExoazwRnHXoka2Yl3DVbSsPnGL9VoN2ze/POBx0ZuAaCDACusXYHwRy3sfFyfX8hFd
         kEXkBL7nAJJiuC/lBcp3as7zKTmVAAWnRQlZmOxE0OuSsx0tXonmhTo+KPlIT48wJG5y
         9SOQa9Ck+/nq+XKzEEcB25cSoAAFgOyVULgH2HkhUAbo1N4nwxCfz4Eow3KwtDCZtui0
         UqVfXXnf+Ok1efxEPewuPDmyipLwuvfapxJGHzjuIvFccpIZRmlYvuTmsiQWjFz8/kBM
         HVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692395557; x=1693000357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyzJJLZzQ2GwmUew6/FboLveXIFYOb4sFr1ZSeLKQkQ=;
        b=cZDpGsttbaWsYd186v5rCJLW08gfhXcg7KuJJIcD5JQwxaWFArpVd+fwSKze7BH4ER
         iUdJc/OmJ26KrFGeQ5/w/jIadrqeFrTf+EurQoBlwvJktnVhOISYhDzHvYRuk4dfaWjx
         +NE2XHhzFvL7e2UbFF1r4Nz7RsGeGCT9ryjgubzMIK9O95k6B6cv3eDzmltcInTGnXRO
         hFzcRy5D/jcuEKNI+y9ih9RWp9i9oP1KYtm+/K/ee8nGA5Q3VABFNymPr+cTkIrIhjlL
         kleYR8FEW8wOSdUHzgozfZaZBkYbsJ+aX3XWkNgBWkSJb3JlaIryvaSVn25j+VqzspRu
         OOGg==
X-Gm-Message-State: AOJu0Yw0mHyl0R2X2obpsanqqNaG//GSP01F4kSRcccxvcryAwP4PibP
        Y11rg4DzO7i7DadYcCWHiQqqKkv3W04UwzgbJBcmzw==
X-Google-Smtp-Source: AGHT+IHYFtSoqpc8IxxYx5eaXcFiGCwQ1vUYhBlUo8Z0wDwrXOqlYDGpawv5zxzm5wyZPKyyvHgDfn7ahOisIyQoJYA=
X-Received: by 2002:a05:622a:1041:b0:3f6:97b4:1a4d with SMTP id
 f1-20020a05622a104100b003f697b41a4dmr276674qte.23.1692395556823; Fri, 18 Aug
 2023 14:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org> <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org> <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
 <20230818183538.GA142974@cmpxchg.org> <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
 <20230818213502.nsur4qbs7t7nxg54@google.com>
In-Reply-To: <20230818213502.nsur4qbs7t7nxg54@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 18 Aug 2023 15:51:59 -0600
Message-ID: <CAOUHufb7q9ty7tSGXkkTef0-k-2Ty245a+r8=tuemZs8bqsYxw@mail.gmail.com>
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 3:35=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Fri, Aug 18, 2023 at 11:44:45AM -0700, Yosry Ahmed wrote:
> > On Fri, Aug 18, 2023 at 11:35=E2=80=AFAM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Fri, Aug 18, 2023 at 10:45:56AM -0700, Yosry Ahmed wrote:
> > > > On Fri, Aug 18, 2023 at 10:35=E2=80=AFAM Johannes Weiner <hannes@cm=
pxchg.org> wrote:
> > > > > On Fri, Aug 18, 2023 at 07:56:37AM -0700, Yosry Ahmed wrote:
> > > > > > If this happens it seems possible for this to happen:
> > > > > >
> > > > > > cpu #1                                  cpu#2
> > > > > >                                              css_put()
> > > > > >                                              /* css_free_rwork_=
fn is queued */
> > > > > > rcu_read_lock()
> > > > > > mem_cgroup_from_id()
> > > > > >                                              mem_cgroup_id_remo=
ve()
> > > > > > /* access memcg */
> > > > >
> > > > > I don't quite see how that'd possible. IDR uses rcu_assign_pointe=
r()
> > > > > during deletion, which inserts the necessary barriering. My
> > > > > understanding is that this should always be safe:
> > > > >
> > > > >   rcu_read_lock()                 (writer serialization, in this =
case ref count =3D=3D 0)
> > > > >   foo =3D idr_find(x)               idr_remove(x)
> > > > >   if (foo)                        kfree_rcu(foo)
> > > > >     LOAD(foo->bar)
> > > > >   rcu_read_unlock()
> > > >
> > > > How does a barrier inside IDR removal protect against the memcg bei=
ng
> > > > freed here though?
> > > >
> > > > If css_put() is executed out-of-order before mem_cgroup_id_remove()=
,
> > > > the memcg can be freed even before mem_cgroup_id_remove() is called=
,
> > > > right?
> > >
> > > css_put() can start earlier, but it's not allowed to reorder the rcu
> > > callback that frees past the rcu_assign_pointer() in idr_remove().
> > >
> > > This is what RCU and its access primitives guarantees. It ensures tha=
t
> > > after "unpublishing" the pointer, all concurrent RCU-protected
> > > accesses to the object have finished, and the memory can be freed.
> >
> > I am not sure I understand, this is the scenario I mean:
> >
> > cpu#1                      cpu#2                             cpu#3
> > css_put()
> > /* schedule free */
> >                                 rcu_read_lock()
> > idr_remove()
> >                                mem_cgroup_from_id()
> >
> > /* free memcg */
> >                                /* use memcg */
> >
> > If I understand correctly you are saying that the scheduled free
> > callback cannot run before idr_remove() due to the barrier in there,
> > but it can run after the rcu_read_lock() in cpu #2 because it was
> > scheduled before that RCU critical section started, right?
>
> Isn't there a simpler explanation. The memcg whose id is stored in the
> shadow entry has been freed and there is an ongoing new memcg allocation
> which by chance has acquired the same id and has not yet initialized
> completely. More specifically the new memcg creation is between
> css_alloc() and init_and_link_css() and there is a refault for the
> shadow entry holding that id.

I think so, and this fix would just crash at tryget() instead when
hitting the problem.
