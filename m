Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830F6792AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjIEQmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354920AbjIEPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:55:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B92912A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:55:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a5e37a39ecso377483166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693929323; x=1694534123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfVVipA0o6H6ewNJe4xhsC2K0XPQ+3N1YnkSldVjkDY=;
        b=Hz853w87jY9/nR9lnAL2MD006JQ677WdRtB8Vhnlob6er4Cxab+/VZLaD+LcrG9h0C
         bg6gdMYpppIsHgrr4yUB4DdHLE7hcPJUlobsChkPMscryE7yMWJygest7mAP65y8iHYq
         XIW0763Z+nzmcnty+UhYS1ealuX2q6lMFh1I3XyaI5c5kB4kNkq/rae6DKklNmjbJqJw
         HDjfQLaplFlqHNBxvvCJF1epQWMpOgpJiM4Wn0JppYv8Kqixmvr8pz7Em0+1faYN/cWf
         UUoydLmr2t9n+a0eK0Z6fGWMWlp9HvQkQbZ326U8FYj4LhG4plynRSQi+dFSUJYi2129
         wmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693929323; x=1694534123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfVVipA0o6H6ewNJe4xhsC2K0XPQ+3N1YnkSldVjkDY=;
        b=CNG5MDVwP6fA8jaOnNOzDjupaGWqo5eVIKNnOQbj72EsRgTnvAlK2zyeIARoBIN3SB
         SqSNk0GiAr9vpSw4QRzAEsU0IcCzbjqsQRa0jEmgUgLE8WUFeT/TpxhyfUmXfB2CCkq1
         +f6N1cOWq3Z5qVq6XCjeOi/huOcruScNrWMzVhWMMkIEWo/rr+rXkJ8xbIvtuaf/q1BC
         PPOB9ppeBftIVrdxZ7INi3zq1evk0fx1w1dfEntn41HEH0hxO4VCZNrPP6mjEhreskqK
         mtaqomFAv4YDTzPbcBsQzR2nRNTNmr4exXvKdadbuWQt7M332qrG061qmVurxs1tlrz7
         EYFA==
X-Gm-Message-State: AOJu0YxhogndsiJ0SPiKwcvIpKjBZEPgN6Mhb4Zx0VvSV/QdwUkLreSy
        N/NhDZT8ikciGMa4SC4j1B3CHVWmZqORskQi1cUGlQ==
X-Google-Smtp-Source: AGHT+IHBYVFFzy3HhlEK57FsPeAPJfaIdcatC02JBosyz+97/FG9t3Bxbx1UhO1wT8hxqmFoAJwEcmpeUAvBxwczKFo=
X-Received: by 2002:a17:906:9bed:b0:9a5:b95a:1179 with SMTP id
 de45-20020a1709069bed00b009a5b95a1179mr169757ejc.77.1693929322556; Tue, 05
 Sep 2023 08:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-4-yosryahmed@google.com> <ZPXupwjewuLgksAI@dhcp22.suse.cz>
 <6tne52ip62ucev7nmnim3m7fhcydnwcytyxynrlxxgaf4cbqea@r4hec425izap>
 <ZPX6luPGqypp68+L@dhcp22.suse.cz> <hrpw2bjsrs3pzxympb7cz4nohyeztnxkmdtzbzlfdba6ugkken@dhcdbbbrv4fn>
In-Reply-To: <hrpw2bjsrs3pzxympb7cz4nohyeztnxkmdtzbzlfdba6ugkken@dhcdbbbrv4fn>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Sep 2023 08:54:46 -0700
Message-ID: <CAJD7tkaHVtMiMYFocNiABuyhPcqt77gei0UeaDq4J7V-=tMFYA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mm: memcg: let non-unified root stats flushes help
 unified flushes
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 5, 2023 at 7:10=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Mon, Sep 04, 2023 at 05:41:10PM +0200, Michal Hocko <mhocko@suse.com> =
wrote:
> > So it also creates an undocumented but userspace visible behavior.
> > Something that userspace might start depending on, right?
>
> Yes but -
> - depending on undocumented behavior is a mistake,
> - breaking the dependency would manifest (in the case I imagine) as a
>   performance regression (and if there are some users, the future can
>   allow them configuring periodic kernel flush to compensate for that).

I think I am missing something. This change basically makes userspace
readers (for the root memcg) help out unified flushers, which are
in-kernel readers (e.g. reclaim) -- not the other way around.

How would that create a userspace visible behavior that a dependency
can be formed on? Users expecting reclaim to be faster right after
reading root stats? I would guess that would be too flaky to cause a
behavior that people can depend on tbh.
