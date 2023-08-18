Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6719F781539
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbjHRWA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbjHRWAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:00:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008203C31
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:00:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bccc9ec02so180369366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692396033; x=1693000833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV15IMnKh+DcB05r7g4z9M9VBYTIic9ANjBGLdi5r5Q=;
        b=OlYQYHj2Jk8sLqHfxCgAXnzGNUohKU1TrA4G6naHyEFabxv7DTkvQY3xhfqY2o6Qdv
         RuOcP6eWhHkLmbzDxZaOegQ0nrYrZ0VJ92yTL+eCEiJ8AzFCWwrSDWx7+sfm0vsvmaUh
         ADibU9J07YKqxU5CtbYdqXfq2FmZNfF1g9CXTwrxzdBndudoaGmnn/e8oQpoEN+vw80W
         IBSgEnkWVgSeepCIVuTnMufqEzbqnnNpIGcNC5OSfq1Yclg0lCxICauqwkWn8FZgvdwS
         3G+iD5+0s6cTKeJQCP9k/XJLgaqf6x4VvDVD183WmplUh2/t31BBHW6snCnYG+E5/MfX
         3kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692396033; x=1693000833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV15IMnKh+DcB05r7g4z9M9VBYTIic9ANjBGLdi5r5Q=;
        b=WWp14CL1qJkV2RCN4pLXAwLMoNSf/vLHmlO9400aJlzv9uuGtPt7OTOH5GvKK/Tyz0
         lQLzgxM3Qy46fyWmD+oQ7iTKed+WiddB068dlb4aVxlMphgqRUYgIK+GENE0TpouF6od
         sT7cl8w8KNY16fz/FLtPLJd+4SzNl2A0NGw/rWEtGR+AI/97G73X3TmTFQgb+8gbVzCa
         nqOdxm4oVxXTRv82cddZFxkJ4rX5pSCc2XcEZfIkcFhkDhvnfHoBALL2sYPcnHF5Q2LF
         CV45+50lg2Ti7qTTDY9leFM4QRf5q83B6JuSclUghGpYntctx1C/RvF3Zk7OHy+R94Cz
         ZlYA==
X-Gm-Message-State: AOJu0Yz5DAhMXB1oKqJoi3jQdxP/cNgy9Sm3zcMFniSPUfhc2yc+TgEx
        hvE9xGAEIGJ6IC2gSF+RklOia3HPUhI1RXD/Ni688w==
X-Google-Smtp-Source: AGHT+IEhwSxjg6Bw/Lb5ooIorg4674rp14RUtKuw80CbiNpRDbPWTLi+nf6Boy0zgXwGPbXrXuvbL36MaxfzLUtAUfc=
X-Received: by 2002:a17:906:cc4c:b0:99b:65fa:fc2b with SMTP id
 mm12-20020a170906cc4c00b0099b65fafc2bmr292975ejb.35.1692396033253; Fri, 18
 Aug 2023 15:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org> <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org> <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
 <20230818183538.GA142974@cmpxchg.org> <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
 <20230818213502.nsur4qbs7t7nxg54@google.com> <CAOUHufb7q9ty7tSGXkkTef0-k-2Ty245a+r8=tuemZs8bqsYxw@mail.gmail.com>
In-Reply-To: <CAOUHufb7q9ty7tSGXkkTef0-k-2Ty245a+r8=tuemZs8bqsYxw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 18 Aug 2023 14:59:56 -0700
Message-ID: <CAJD7tkZsmHLAbmZXFHJA2BqPHYeyHMVYxsMKFZywTHdiNFiTdw@mail.gmail.com>
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
To:     Yu Zhao <yuzhao@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 2:52=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Aug 18, 2023 at 3:35=E2=80=AFPM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Fri, Aug 18, 2023 at 11:44:45AM -0700, Yosry Ahmed wrote:
> > > On Fri, Aug 18, 2023 at 11:35=E2=80=AFAM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > >
> > > > On Fri, Aug 18, 2023 at 10:45:56AM -0700, Yosry Ahmed wrote:
> > > > > On Fri, Aug 18, 2023 at 10:35=E2=80=AFAM Johannes Weiner <hannes@=
cmpxchg.org> wrote:
> > > > > > On Fri, Aug 18, 2023 at 07:56:37AM -0700, Yosry Ahmed wrote:
> > > > > > > If this happens it seems possible for this to happen:
> > > > > > >
> > > > > > > cpu #1                                  cpu#2
> > > > > > >                                              css_put()
> > > > > > >                                              /* css_free_rwor=
k_fn is queued */
> > > > > > > rcu_read_lock()
> > > > > > > mem_cgroup_from_id()
> > > > > > >                                              mem_cgroup_id_re=
move()
> > > > > > > /* access memcg */
> > > > > >
> > > > > > I don't quite see how that'd possible. IDR uses rcu_assign_poin=
ter()
> > > > > > during deletion, which inserts the necessary barriering. My
> > > > > > understanding is that this should always be safe:
> > > > > >
> > > > > >   rcu_read_lock()                 (writer serialization, in thi=
s case ref count =3D=3D 0)
> > > > > >   foo =3D idr_find(x)               idr_remove(x)
> > > > > >   if (foo)                        kfree_rcu(foo)
> > > > > >     LOAD(foo->bar)
> > > > > >   rcu_read_unlock()
> > > > >
> > > > > How does a barrier inside IDR removal protect against the memcg b=
eing
> > > > > freed here though?
> > > > >
> > > > > If css_put() is executed out-of-order before mem_cgroup_id_remove=
(),
> > > > > the memcg can be freed even before mem_cgroup_id_remove() is call=
ed,
> > > > > right?
> > > >
> > > > css_put() can start earlier, but it's not allowed to reorder the rc=
u
> > > > callback that frees past the rcu_assign_pointer() in idr_remove().
> > > >
> > > > This is what RCU and its access primitives guarantees. It ensures t=
hat
> > > > after "unpublishing" the pointer, all concurrent RCU-protected
> > > > accesses to the object have finished, and the memory can be freed.
> > >
> > > I am not sure I understand, this is the scenario I mean:
> > >
> > > cpu#1                      cpu#2                             cpu#3
> > > css_put()
> > > /* schedule free */
> > >                                 rcu_read_lock()
> > > idr_remove()
> > >                                mem_cgroup_from_id()
> > >
> > > /* free memcg */
> > >                                /* use memcg */
> > >
> > > If I understand correctly you are saying that the scheduled free
> > > callback cannot run before idr_remove() due to the barrier in there,
> > > but it can run after the rcu_read_lock() in cpu #2 because it was
> > > scheduled before that RCU critical section started, right?
> >
> > Isn't there a simpler explanation. The memcg whose id is stored in the
> > shadow entry has been freed and there is an ongoing new memcg allocatio=
n
> > which by chance has acquired the same id and has not yet initialized
> > completely. More specifically the new memcg creation is between
> > css_alloc() and init_and_link_css() and there is a refault for the
> > shadow entry holding that id.

That's actually very plausible.

>
> I think so, and this fix would just crash at tryget() instead when
> hitting the problem.

It seems like mem_cgroup_from_id() completely disregards
memcg->id.ref. In the case that Shakeel mentioned, memcg->id.ref
should have a count of 0. Perhaps we should update it to respect the
id refcount? Maybe try to acquire a ref first before looking up the
idr?
