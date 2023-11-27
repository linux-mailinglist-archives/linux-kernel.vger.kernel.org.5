Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913FB7FAD88
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjK0Wel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjK0Wei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:34:38 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE11B5;
        Mon, 27 Nov 2023 14:34:43 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-359c22c44d6so19939275ab.2;
        Mon, 27 Nov 2023 14:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701124483; x=1701729283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sR2GQKO7WIcjcfwKsrJ+kK8ez+pv+/L5wHkm6C51ig=;
        b=RUAKxFFdo84xhTsKTuzd0jfqQtjEUXv6d8Gz6D6rEEe2RMp6vZ+0m10R+A//XVJlXp
         lQEzGDDHzBpo+5vWuLrL9qjIgkLdIKZpxIbyk7BzVVB7Iwtu40bQcPUXMewqu28xvI8i
         v63lc4maqMGlRh+YzdD6N6Pj1iI8hexgTC2Vt/LYywOL0riBtMUo6onXZWL99QRxo0m2
         P0PgHPhdRrSS+Byqy6FTsR9PiZvysH+Mi6tCopm5CuVYXpK7UJh9kEmrrLMhPNfOizrv
         +hsiwYphRsbZDFtWRvNvpW0CPn8inqC7Q/QTylqKjuwe4ZJurt6lYpzYs5CmODa0Fpre
         TbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701124483; x=1701729283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sR2GQKO7WIcjcfwKsrJ+kK8ez+pv+/L5wHkm6C51ig=;
        b=qG0NG7isI1iwE2Z2DEtimq+HSVOw0EiIB8Ko1pOvNIIxi4+Ms2pqDRbbJ2V3hVz9g4
         hZ2Sgfi4e3S5VLA/qu40/DAlkAeYHIVWkTyJmnIiXcc8cqRF9BjntjOELru5LjBFneGa
         dzT/0vDam1X33J2A7mICF8VmtzUs7tNxWQbHr+iJVLDRU/LXzdda8U1gAN77sc4TG029
         pdYeqrITdIRwBYsD8WH9A7jN0HZWLVD+/B53iiPfSan1ulENn/vjI6JgY85vddJ9QYGB
         HJgwMaujTPS/xM+zMkT1n+EnBxR/a27xq1fWDJXqRZP5Jqym+VcWgX0F3PeLF9art8Bf
         JwVg==
X-Gm-Message-State: AOJu0YyNxGhv4KMh8diurQ/HE8XSQMgtejGKkZL+yk7NrUp9c9C0yPgp
        ndcpaI8nfXiHO0kJa4jLTffmRj0OZbOFuRIKKgo=
X-Google-Smtp-Source: AGHT+IHZaiS3nynE7U3pzq8Y3JAe1FrACVX2WxXS1uB6jc3zbZm44/mpWVEj353G0gGg2tNcCHwcjdBzk6AZg/8IwnA=
X-Received: by 2002:a05:6e02:dd3:b0:35c:9dca:dfb1 with SMTP id
 l19-20020a056e020dd300b0035c9dcadfb1mr8631738ilj.28.1701124483084; Mon, 27
 Nov 2023 14:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20231127193703.1980089-1-nphamcs@gmail.com> <20231127193703.1980089-3-nphamcs@gmail.com>
 <20231127134259.67b69ab47f4f88c9751e5222@linux-foundation.org>
In-Reply-To: <20231127134259.67b69ab47f4f88c9751e5222@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 27 Nov 2023 14:34:31 -0800
Message-ID: <CAKEwX=O3N8Tr3qwX6XzvKsXnJ5O86s3WQeZhGKes+=zcVDe_-w@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] memcontrol: allows mem_cgroup_iter() to check for onlineness
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Mon, Nov 27, 2023 at 1:43=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 27 Nov 2023 11:36:59 -0800 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > The new zswap writeback scheme requires an online-only memcg hierarchy
> > traversal. Add a new parameter to mem_cgroup_iter() to check for
> > onlineness before returning.
>
> I get a few build errors, perhaps because of patch timing issues...

Ah I thought I got all of them. Must have somehow missed it.

>
> mm/shrinker_debug.c: In function 'shrinker_debugfs_count_show':
> mm/shrinker_debug.c:64:17: error: too few arguments to function 'mem_cgro=
up_iter'
>    64 |         memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
>       |                 ^~~~~~~~~~~~~~~
> In file included from mm/shrinker_debug.c:7:
> ./include/linux/memcontrol.h:833:20: note: declared here
>   833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
>       |                    ^~~~~~~~~~~~~~~
> mm/shrinker_debug.c:89:27: error: too few arguments to function 'mem_cgro=
up_iter'
>    89 |         } while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)) !=
=3D NULL);
>       |                           ^~~~~~~~~~~~~~~
> ./include/linux/memcontrol.h:833:20: note: declared here
>   833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
>       |                    ^~~~~~~~~~~~~~~
> mm/damon/sysfs-schemes.c: In function 'damon_sysfs_memcg_path_to_id':
> mm/damon/sysfs-schemes.c:1594:22: error: too few arguments to function 'm=
em_cgroup_iter'
>  1594 |         for (memcg =3D mem_cgroup_iter(NULL, NULL, NULL); memcg;
>       |                      ^~~~~~~~~~~~~~~
> In file included from ./include/linux/damon.h:11,
>                  from mm/damon/sysfs-common.h:8,
>                  from mm/damon/sysfs-schemes.c:10:
> ./include/linux/memcontrol.h:833:20: note: declared here
>   833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
>       |                    ^~~~~~~~~~~~~~~
> mm/damon/sysfs-schemes.c:1595:33: error: too few arguments to function 'm=
em_cgroup_iter'
>  1595 |                         memcg =3D mem_cgroup_iter(NULL, memcg, NU=
LL)) {
>       |                                 ^~~~~~~~~~~~~~~
> ./include/linux/memcontrol.h:833:20: note: declared here
>   833 | struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
>       |                    ^~~~~~~~~~~~~~~
>
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -832,7 +832,7 @@ static inline void mem_cgroup_put(struct mem_cgroup=
 *memcg)
> >
> >  struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
> >                                  struct mem_cgroup *,
> > -                                struct mem_cgroup_reclaim_cookie *);
> > +                                struct mem_cgroup_reclaim_cookie *, bo=
ol online);
>
> How many callsites do we expect to utilize the new `online' argument?
> Few, I suspect.
>
> How about we fix the above and simplify the patch by adding a new
> mem_cgroup_iter_online() and make mem_cgroup_iter() a one-line wrapper
> which calls that and adds the online=3Dfalse argument?

But yes, this is a much smarter idea. Should have thought about it initiall=
y :)

>
> I also saw this, didn't investigate.
>
> drivers/android/binder_alloc.c: In function 'binder_update_page_range':
> drivers/android/binder_alloc.c:237:34: error: too few arguments to functi=
on 'list_lru_del'
>   237 |                         on_lru =3D list_lru_del(&binder_alloc_lru=
, &page->lru);

Oh yeah I missed this too - it's due to the API change introduced to
the previous bug. The old "list_lru_del" is now "list_lru_del_obj".

Let me double check everything again and send out the fixes. My apologies.

>
