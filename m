Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3AD791D71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjIDS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjIDS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:56:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A3109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:56:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401b5516104so17348475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693853782; x=1694458582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4qsjVHBpGU5sO+OGh4AT0ORwR6myZD1vH3gXnj6fKc=;
        b=TYPjLWV8pZflDv7yRqMrUuHUegg31N3+ehYxccKZcI+UgZNbLBg2QVzAUhZvdWOL3s
         JnID2zAshxz4DGlxD8Tsj19HA3P451vcBSsT2kpLz3Uh9GshC0MlAkM5bwht/q0SdHF1
         FYyFNFmIf2MIjxglbjoaQe66d07kBrD9xcpRDq1AdN64JBVZ4G1srqZ5YgQCjpAX0NPy
         2W7FhLUjykguPAyqpS9erMaVQSsUBHMQZKYqDq77wwgjS73tfh1gSDXOvmh1pioCc9Ps
         Df+auGrQxB0FrLkWG45fd1JKjNB9pnIE//NS+PP1jpvSK1BvjY5UlCMpH62N5lLOgQuh
         bMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853782; x=1694458582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4qsjVHBpGU5sO+OGh4AT0ORwR6myZD1vH3gXnj6fKc=;
        b=VzHsh4Ct1fMsNec2msdMtVKnmYiD1eQyvuxNBGoD9n68lSDMK++7+AmxuU2O6y94Aa
         mJ9Wzey97j5CKxYe+xD41NZXzGVBSuz2m3nqJhWw/gyplxt7AvqYmeHF50HVgmrE6kk7
         5jthwfAGmBDrE1Ap+CtrRJK3JJqTBpMbjW6l+P65b3GWZLHozUH8FO0Vb1lzPIMEF6Vq
         6OY/ydMstJTmfCXw4tfb+mP2rTP3xT5ip16qdcfwQYpDwhvWDTUuj+1Z2HIhcZKHgVbu
         DHtvJxJV/nathsnBPOyLw2Wzl1K+067NlgpIOLLXmiEGiBuFRJZ6L/LzhYdWs0Gm+4o5
         3/vg==
X-Gm-Message-State: AOJu0Yz8Yz9/jYmzS2Dw93EczC6VD+4/awiFU//+ImXwfC187xeym7WR
        fVsu2ptyPAiqMXyfVIvf3fa7BnTBFO8W646SVzeu/w==
X-Google-Smtp-Source: AGHT+IGEkM6yU1BmhM0IjjtrWKLwQVKxsWSFXCXmknm61mhhl3SRDwE1ksYYd+kDr42Q9QRCG3TiB9s/QTueIeFgH0s=
X-Received: by 2002:a05:600c:2218:b0:401:b53e:6c3b with SMTP id
 z24-20020a05600c221800b00401b53e6c3bmr7443728wml.6.1693853781573; Mon, 04 Sep
 2023 11:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
 <ZO8MxUqcL1dnykcl@elver.google.com> <CA+fCnZe2ZRQe+xt9A7suXrYW8Sb7WGD+oJJVWz6Co-KGYghZLw@mail.gmail.com>
In-Reply-To: <CA+fCnZe2ZRQe+xt9A7suXrYW8Sb7WGD+oJJVWz6Co-KGYghZLw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Sep 2023 20:55:42 +0200
Message-ID: <CANpmjNPYNTTfBAay4J96hm=3tb4kUBH2OwpaCfJxL7rP=aibJA@mail.gmail.com>
Subject: Re: [PATCH 12/15] stackdepot: add refcount for records
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, 4 Sept 2023 at 20:46, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Wed, Aug 30, 2023 at 11:33=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> >
> > If someone doesn't use stack_depot_evict(), and the refcount eventually
> > overflows, it'll do a WARN (per refcount_warn_saturate()).
> >
> > I think the interface needs to be different:
> >
> >         stack_depot_get(): increments refcount (could be inline if just
> >         wrapper around refcount_inc())
> >
> >         stack_depot_put(): what stack_depot_evict() currently does
> >
> > Then it's clear that if someone uses either stack_depot_get() or _put()
> > that these need to be balanced. Not using either will result in the old
> > behaviour of never evicting an entry.
>
> So you mean the exported interface needs to be different? And the
> users will need to call both stack_depot_save+stack_depot_get for
> saving? Hm, this seems odd.
>
> WDYT about adding a new flavor of stack_depot_save called
> stack_depot_save_get that would increment the refcount? And renaming
> stack_depot_evict to stack_depot_put.

If there are no other uses of stack_depot_get(), which seems likely,
just stack_depot_save_get() seems ok.

> I'm not sure though if the overflow is actually an issue. Hitting that
> would require calling stack_depot_save INT_MAX times.

With a long-running kernel it's possible.
