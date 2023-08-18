Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4604E78156B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbjHRW0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbjHRW0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:26:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFF435B8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:26:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf1f632b8so184245166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692397601; x=1693002401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGG2YTEbV1sS/xdnpOKbesAlwjX46+7FJ2zNOOjpqUM=;
        b=uHeLi/hW9WyEjgHsuAsFaMG+fs1T6pxWFAs8ivxHPYXaKihZmoJItXIkQbmzHWFMAT
         ciBTV/rjKmjPXl3S8ZDaaNy+IoYzYyU0Ofh3zgBd5QfxaoaBDLphbTFKqWSvN5frFj1z
         2Z5O/jZHU2wImK6A/EdD2+LI4h2jZmnBykwyOiSp4BvCJUFR2+imyamroV5IC1acJFDY
         KZKarI45j000VcQdXoU95NvxrCEwjZ4eFIn10dd6B/yYLUUZDR+L9N8liLj+T9W6qAPv
         P5Lqw/mwR0siOlAcybKiYLm6vdZvjpg+aATYvkwMWXNuzdh4nAlePlkxT4p+giRUdVT8
         D6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692397601; x=1693002401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGG2YTEbV1sS/xdnpOKbesAlwjX46+7FJ2zNOOjpqUM=;
        b=lkBpFTa5F6Jm9fxiwHFK7CQrgdWxc3oi9ZppDirquvgemdSJrRRNPiUNCUEFkfxAg0
         rZG44X6YdAAx6AHL12O87lMRMvWuJ07dKEacNfTpBZdQ5Tpsbcdh5Ilp1IHUSRxdbX22
         1LfUKwSjleXlUKSFnoCtXVw9Th7Yb3hXakqnmkthusFdqwvTOIl4ABY8Br0Eh88mZWOj
         yZpkmiqP4+zKP0Vko5VNs4ivLHCZjlMyFg9V/yOdXYrNPgFPzLibqc/NIlXDCWzvIE4T
         WHIeXFgaRsuWnrfdN8Jr9DRRYinojAGGcOfmaL8klRnDB04HRvDRxuu+VG5GZXUwsfkb
         jlyg==
X-Gm-Message-State: AOJu0YyXx710s7gqzRmCC8trXDfQvG6U/5y33zTIcKsVzMykh2RwrAiX
        DBdl99HRjqYcjtHwtmUc0SJzvwvf0JySD5TscffdWg==
X-Google-Smtp-Source: AGHT+IFzee4khZqjKncgnJQtEE6TR6TELVpbhgbz22fzVOgHMWG/YGc9nISJ46q9FbU+nurB1+Pz85C483HGoDuNb+s=
X-Received: by 2002:a17:907:7891:b0:99b:5445:10d5 with SMTP id
 ku17-20020a170907789100b0099b544510d5mr342524ejc.51.1692397600920; Fri, 18
 Aug 2023 15:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org> <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org> <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
 <20230818183538.GA142974@cmpxchg.org> <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
 <20230818221913.GA144640@cmpxchg.org>
In-Reply-To: <20230818221913.GA144640@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 18 Aug 2023 15:26:04 -0700
Message-ID: <CAJD7tkZFWMx5GggPPMzcHJ4NiDPC0pbUgwUSQJVXgAYFozFY+Q@mail.gmail.com>
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yu Zhao <yuzhao@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 3:19=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
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
>
> idr_remove() cannot be re-ordered after scheduling the free. Think
> about it, this is the common rcu-freeing pattern:
>
>         rcu_assign_pointer(p, NULL);
>         call_rcu(rh, free_pointee);
>
> on the write side, and:
>
>         rcu_read_lock();
>         pointee =3D rcu_dereference(p);
>         if (pointee)
>                 do_stuff(pointee);
>         rcu_read_unlock();
>
> on the read side.
>
> In our case, the rcu_assign_pointer() is in idr_remove(). And the
> rcu_dereference() is in mem_cgroup_from_id() -> idr_find() ->
> radix_tree_lookup() -> radix_tree_descend().
>
> So if we find the memcg in the idr under rcu lock, the cgroup rcu work
> is guaranteed to not run until the lock is dropped. If we don't find
> it, it may or may not have already run.

Yeah I missed the implicit barrier there, thanks for bearing with me.
I think Shakeel might have found the actual problem here (see his
response).
