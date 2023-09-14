Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30387A0EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjINUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjINUBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:01:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98526BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:00:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c0f3f24c27so740716a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694721658; x=1695326458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb/CMKCE21GbjlUYU65iP3ZBpMrzy3WpMR7I9tPJHKc=;
        b=MNwKRmsSi9lB5NEzZZC7y/QDjBwaJQoy2DpFOpZJGYZIhcSJ5HrAlRZB+EB0SqlCHQ
         h0cj4VAr1e+YIka+1IoEIbpZJf622sYtC5xuwcIXtA+hcgt0KUhizrsqB90bqz/vixfL
         nT00FKIinpDXxmzifaiYE999OL9d/v0W5sSZ+cYLdSKVQFUJecFtn+F6tIZz3cK4vdRb
         g740Mfehu62hkZaH83a76AkJjcmaGfaTiomlf5zp9yktkxkBttdyLj266AftxQVyU+7q
         Ynf3BI3FfDvf45xMOajTb2B7nE2jxNjrCV6e53RsrvwbQ/kLbHLgGytDZ7lS7MjHQful
         mkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694721658; x=1695326458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lb/CMKCE21GbjlUYU65iP3ZBpMrzy3WpMR7I9tPJHKc=;
        b=biLmlbyeD3nUQM1NEwsNa8fwTnYNMcUNlEy28TEEPYc1v9IYwkE38lLHusHrr8n6s9
         sRRva/6JZQTBX3CYXY3QSMoyyCXCi6ZTNJzJsIg8I89y0oKde0jQr1ue+pv+gAfX/eL6
         Gefds3HxAVa8l4IDtUpecyj/YAc81JmIsUd5G4vlWUvIzhg6neeQWPhykW5kcdx9kBDz
         62pYbzc/LxS2o6a8YJkD3lVUSb2JRkBWgFBSYgTg/DnD/6vKlG4iePtGiumvLyFGCgUB
         SysJV39tJtkNE/tixwvOT7dwvoeE4NHwR/a6vTjK+Q2pZRVYvWVxM0W8P9nUUECxpV1u
         pXog==
X-Gm-Message-State: AOJu0Yx1B19js7P2F/4Tz2WTVXQFnkawuDBlHr2sKy4MX9zxr1UX/ANp
        3xjPv3Fmkt6D62ke9RzjWaYpoKBFFWqol+G/iGeYMg==
X-Google-Smtp-Source: AGHT+IHvfdYyltmAKPaJ3EMcnOv2Vgsan85cKtIyJ3zr2EyhbA9TT5S7py2VsiSTfs0auAsW5sUHMOUITwApT2T6FAo=
X-Received: by 2002:a05:6830:195:b0:6b9:bf1e:c141 with SMTP id
 q21-20020a056830019500b006b9bf1ec141mr6884165ota.23.1694721658164; Thu, 14
 Sep 2023 13:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f392a60604a65085@google.com> <ZP/3hgDCXeceE9uU@casper.infradead.org>
 <ZQB76G/6NxVgoE9u@casper.infradead.org> <CAJuCfpGEa504z1pgqR9KtCWQPESTcRcu8xoyxcNOv=6t4R+ong@mail.gmail.com>
 <CAJuCfpHYNbH0WmfDnpX6eqL3f3Z632iQrcw6oqPXtB0_QjaiiQ@mail.gmail.com>
 <CAJuCfpF4j6fKpk853tXu155jbfk1z_PbWXjf4bypYwDRf78-iw@mail.gmail.com>
 <CAJuCfpETZr56WD5j7aQY-dY84ciur=QTZYxuShmjEG+fZFhDsw@mail.gmail.com>
 <CAJuCfpECwpQ8wHnwhkLztvvxZmP9rH+aW3A39BSzkZ9t2JK6dQ@mail.gmail.com> <ZQNaT/3xPxATKJVR@casper.infradead.org>
In-Reply-To: <ZQNaT/3xPxATKJVR@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 20:00:45 +0000
Message-ID: <CAJuCfpEAZbtUrwrfqd+PWJv9efVy1HRbqrLUYAP4rYRvk0vWug@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 7:09=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Sep 14, 2023 at 06:20:56PM +0000, Suren Baghdasaryan wrote:
> > I think I found the problem and the explanation is much simpler. While
> > walking the page range, queue_folios_pte_range() encounters an
> > unmovable page and queue_folios_pte_range() returns 1. That causes a
> > break from the loop inside walk_page_range() and no more VMAs get
> > locked. After that the loop calling mbind_range() walks over all VMAs,
> > even the ones which were skipped by queue_folios_pte_range() and that
> > causes this BUG assertion.
> >
> > Thinking what's the right way to handle this situation (what's the
> > expected behavior here)...
> > I think the safest way would be to modify walk_page_range() and make
> > it continue calling process_vma_walk_lock() for all VMAs in the range
> > even when __walk_page_range() returns a positive err. Any objection or
> > alternative suggestions?
>
> So we only return 1 here if MPOL_MF_MOVE* & MPOL_MF_STRICT were
> specified.  That means we're going to return an error, no matter what,
> and there's no point in calling mbind_range().  Right?
>
> +++ b/mm/mempolicy.c
> @@ -1334,6 +1334,8 @@ static long do_mbind(unsigned long start, unsigned =
long len,
>         ret =3D queue_pages_range(mm, start, end, nmask,
>                           flags | MPOL_MF_INVERT, &pagelist, true);
>
> +       if (ret =3D=3D 1)
> +               ret =3D -EIO;
>         if (ret < 0) {
>                 err =3D ret;
>                 goto up_out;
>
> (I don't really understand this code, so it can't be this simple, can
> it?  Why don't we just return -EIO from queue_folios_pte_range() if
> this is the right answer?)

Yeah, I'm trying to understand the expected behavior of this function
to make sure we are not missing anything. I tried a simple fix that I
suggested in my previous email and it works but I want to understand a
bit more about this function's logic before posting the fix.
