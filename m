Return-Path: <linux-kernel+bounces-30782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16934832451
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9274E1F2293F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A224A11;
	Fri, 19 Jan 2024 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odXMvX6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E943C35
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643032; cv=none; b=TKPR3+w8Mo3xy1VYgOov1hudAZyEJ11wrtaJzgIL41dAogeedGFQSks+RS+oaL/Mmp/CEmTYH4fyBHhpiHvXI+v8AkSOl6DIvNSHBeOtArUG8Px8FyD4GLDbnKElLjRE6tWQbVuvU3dLUkhqUmwZGeuZLFO/Hj2xjMh/+B02u4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643032; c=relaxed/simple;
	bh=dF/UBBPC6CKheSkANeKfd36eVsULSzpHsfBlOvbrzjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KERFJzys/f7QyqBPoAujXOZdQfsw3rW3snlCuwda5ctsJswx6WgjCQaTGCBB4XfBdRxd7wFl6wkmhtAlKgwHMMePqS1eJkjc2DutQJ16IAbukRQ3KfIWjkYHBHmbXQUfVFeGzTAakchRKFQyLhsmgYZA5/C2vMpuA72dtTV2Wjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odXMvX6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BE8C43141
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705643031;
	bh=dF/UBBPC6CKheSkANeKfd36eVsULSzpHsfBlOvbrzjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=odXMvX6w1T/92K37nvRY6QuX7ljVA4Uc5cddTFzxyUva5TsDxwHDxozSwz1nwdwVM
	 09AeqhEwLIg8D4DFqRWx8ouiQMfegqHdCE97FWKNI7FdEiv93XvFwxusmdssfmBKq7
	 6i7rBzH5B4652Cmj8OBa2sJ+27t6z8i/zJz5hq0a7O+yx6YYRtgmrAwcCKVwf3NU5P
	 nWnA2nq5eAVHDfAe6Ha91FKaVYsTF7dT1/h625tfzOuOSuviTtkVBaNdS4T/H9/6Sy
	 G/80uo0B6zjN8GQnrBh+fQ/Wp8AHGm7b8yB/bwKkSrdUD65hcTw3Syiejh8u8Od9hP
	 LmnYCwRFquk0A==
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso218332a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:43:51 -0800 (PST)
X-Gm-Message-State: AOJu0YyO7MZsMZ9z2wgC33Wiz4Tf/q5NszC3yj49DyAWY3T1hHW4UrM/
	6CBREduofc+ArTGwO8FNvs5ksB576gJD4taBDOBBdEx6f7CQs9hpZX9ZnC+4v0RsUlixZ3Gv51Y
	7oOvdXxDHSS2DpeeXavjXs9UG8FA7beJ2cChk
X-Google-Smtp-Source: AGHT+IE0f5aXeUkUrkPUKRQL0dlK//zmcRdutVfIYgYmI9ZABAcDjpp68Y3KSElT9U/8HY2rLfvDIKKvt1EgwIEO+94=
X-Received: by 2002:a17:90a:eb01:b0:28f:f2b5:3f23 with SMTP id
 j1-20020a17090aeb0100b0028ff2b53f23mr1742916pjz.35.1705643031256; Thu, 18 Jan
 2024 21:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org> <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
In-Reply-To: <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 18 Jan 2024 21:43:39 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMwF=s-28OPFbCfJf-f3jsfYmyiP6pSBjj8ZgkGmbT9ZA@mail.gmail.com>
Message-ID: <CAF8kJuMwF=s-28OPFbCfJf-f3jsfYmyiP6pSBjj8ZgkGmbT9ZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap.c: remove RB tree
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Wed, Jan 17, 2024 at 10:35=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> > @@ -493,45 +471,47 @@ static struct zswap_entry *zswap_search(struct zs=
wap_tree *tree, pgoff_t offset)
> >  static int zswap_insert(struct zswap_tree *tree, struct zswap_entry *e=
ntry,
> >                         struct zswap_entry **dupentry)
> >  {
> > -       struct rb_root *root =3D &tree->rbroot;
> > -       struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
> > -       struct zswap_entry *myentry, *old;
> > -       pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->swpe=
ntry);
> > -
> > -
> > -       while (*link) {
> > -               parent =3D *link;
> > -               myentry =3D rb_entry(parent, struct zswap_entry, rbnode=
);
> > -               myentry_offset =3D swp_offset(myentry->swpentry);
> > -               if (myentry_offset > entry_offset)
> > -                       link =3D &(*link)->rb_left;
> > -               else if (myentry_offset < entry_offset)
> > -                       link =3D &(*link)->rb_right;
> > -               else {
> > -                       old =3D xa_load(&tree->xarray, entry_offset);
> > -                       BUG_ON(old !=3D myentry);
> > -                       *dupentry =3D myentry;
> > +       struct zswap_entry *e;
> > +       pgoff_t offset =3D swp_offset(entry->swpentry);
> > +       XA_STATE(xas, &tree->xarray, offset);
> > +
> > +       do {
> > +               xas_lock_irq(&xas);
> > +               do {
> > +                       e =3D xas_load(&xas);
> > +                       if (xa_is_zero(e))
> > +                               e =3D NULL;
> > +               } while (xas_retry(&xas, e));
> > +               if (xas_valid(&xas) && e) {
> > +                       xas_unlock_irq(&xas);
> > +                       *dupentry =3D e;
> >                         return -EEXIST;
> >                 }
> > -       }
> > -       rb_link_node(&entry->rbnode, parent, link);
> > -       rb_insert_color(&entry->rbnode, root);
> > -       old =3D xa_store(&tree->xarray, entry_offset, entry, GFP_KERNEL=
);
> > -       return 0;
> > +               xas_store(&xas, entry);
> > +               xas_unlock_irq(&xas);
> > +       } while (xas_nomem(&xas, GFP_KERNEL));
> > +       return xas_error(&xas);
>
> I think using the xas_* APIs can be avoided here. The only reason we
> need it is that we want to check if there's an existing entry first,
> and return -EEXIST. However, in that case, the caller will replace it
> anyway (and do some operations on the dupentry):

We might be able to for the insert case if we don't mind changing the
code behavior a bit. My original intent is to keep close to the
original zswap code and not stir the pot too much for the xarray
replacement. We can always make more adjustment once the RB tree is
gone.

> while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -EEXIST) {
>         WARN_ON(1);
>         zswap_duplicate_entry++;
>         zswap_invalidate_entry(tree, dupentry);
> }
>
> So I think we can do something like this in zswap_insert() instead:
>
> dupentry =3D xa_store(..);
> if (WARN_ON(dupentry)) {
>         zswap_duplicate_entry++;
>         zswap_invalidate_entry(tree, dupentry);
> }
>
> WDYT?
>
> >  }
> >
> >  static bool zswap_erase(struct zswap_tree *tree, struct zswap_entry *e=
ntry)
> >  {
> > +       struct zswap_entry *e;
> >         pgoff_t offset =3D swp_offset(entry->swpentry);
> > -       if (!RB_EMPTY_NODE(&entry->rbnode)) {
> > -               struct zswap_entry *old;
> > -               old =3D xa_erase(&tree->xarray, offset);
> > -               BUG_ON(old !=3D entry);
> > -               rb_erase(&entry->rbnode, &tree->rbroot);
> > -               RB_CLEAR_NODE(&entry->rbnode);
> > -               return true;
> > -       }
> > -       return false;
> > +       XA_STATE(xas, &tree->xarray, offset);
> > +
> > +       do {
> > +               xas_lock_irq(&xas);
> > +               do {
> > +                       e =3D xas_load(&xas);
> > +               } while (xas_retry(&xas, e));
> > +               if (xas_valid(&xas) && e !=3D entry) {
> > +                       xas_unlock_irq(&xas);
> > +                       return false;
> > +               }
> > +               xas_store(&xas, NULL);
> > +               xas_unlock_irq(&xas);
> > +       } while (xas_nomem(&xas, GFP_KERNEL));
> > +       return !xas_error(&xas);
> >  }
>
> Same here, I think we just want:
>
> return !!xa_erase(..);

For the erase case it is tricky.
The current zswap code does not erase an entry if the tree entry at
the same offset has been changed. It should be fine if the new entry
is NULL. Basically some race to remove the entry already. However, if
the entry is not NULL, then force resetting it to NULL will change
behavior compared to the current.

From reading the zswap code, I am not sure this is in theory
impossible to happen: Some one races to remove the zswap entry then
reclaim converts that page back to the zswap, with a new entry. By the
time the zswap_erase() tries to erase the current entry, the entry has
changed to a new entry. It seems the right thing to do in this
unlikely case is that we should skip the force erase and drop the
current entry, assuming someone else has already invalidated it. Don't
touch the entry in the tree, we assume it is a newer generation.

If we can reason the above is impossible to happen, then the force
erase and reset the entry to NULL should be fine(Famous last word).
Noted that this is a behavior change, I would like to seperate it out
from the drop in replacement patch(keep the original behavior)

Chris




>
> >
> >  static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
> > @@ -583,7 +563,6 @@ static void zswap_entry_put(struct zswap_tree *tree=
,
> >
> >         WARN_ON_ONCE(refcount < 0);
> >         if (refcount =3D=3D 0) {
> > -               WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
> >                 zswap_free_entry(entry);
> >         }
>
> nit: the braces are no longer needed here
>

