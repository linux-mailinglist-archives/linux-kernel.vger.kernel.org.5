Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239907B631A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjJCIEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJCIEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:04:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F7A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:04:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9936b3d0286so100949266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696320273; x=1696925073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMsF5DJh2guzU9Ha3ynv7ZZbV5goApHMc/5lrWxMlbE=;
        b=q7x1iK1hLx/t0W9PW4b35vi46jw6LKf/wHkuceuRGHJAJa+YN0Ulmv9hbq07dN4kZ8
         Qy7Jh7IBBY2XpBDZ7NV2RDmxEPzGHpShtn3n4LokVr05L0n1H1S2ppZdlnozcHK2mT6G
         U+H/T9SxTinP1KIf0b80LaX7F28UEH8ZsKAGQ1Vra/cXlpjYYX/gPG91SrchhitRd88B
         jwvmTqkOqn48fZlaEtMPEZhxI9h5aAqH2DUgdWYlQdNfeQo0i+l9ZNSLlkx+SpCfnUVG
         rEnttUCiTM+WKpnNSOgTLJUP8XARK76xB4WWe10ZqWHMXbJPsvaDIVnmCe9J/L5OLsZA
         0TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696320273; x=1696925073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMsF5DJh2guzU9Ha3ynv7ZZbV5goApHMc/5lrWxMlbE=;
        b=d824q4Y3g9NswfCeWehz5uDpw7BmCkIHRj/XyXIQpOoTH3hSbN/oSp5CUXcjikUf6f
         CLkJ7TJOAb3I8pMYqsJF38Lfr2J85YVDRoA44iwzQTkfkQg4lqLlXqkGRXGdtqF4+rR3
         04jek+nx0VjyuDLSM7oDOtaGQbEhh7JBa1uwrxM+NEZKxMhgftDu70Wex5R8YcIKudsv
         qBxTEQGMukF1Hg7XTjtCmABmvqf+dFNQmGadU7DJwR7FMGSuOl6NEoj1DonbDvsgTSYv
         sj3slFM68rlJvIha0PqW5MbduWTDl4RGaypGIYDtmrX4e8e4mbyBBVFceHfVudi4+zD3
         ojEg==
X-Gm-Message-State: AOJu0YyJdqPbIR7J59G0K+MmGOTl8Hi+wWqUtUv4lnGOvUjbqLabsoFg
        HUE44vw/8+cBNPMLCgns+4Q+si5dQKdGoIMrfu1BGQ==
X-Google-Smtp-Source: AGHT+IG2uo37ARAdywaEtmkYOWQSz05+CYQvGoVZhU8Pbx7tJgpOURX/cqhR+9o9gcmWrJVEWr8MEY3rQcWHLHjPsNk=
X-Received: by 2002:a17:906:20dd:b0:9ae:729c:f647 with SMTP id
 c29-20020a17090620dd00b009ae729cf647mr10694745ejc.77.1696320273081; Tue, 03
 Oct 2023 01:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
 <ZRGQIhWF02SRzN4D@dhcp22.suse.cz> <CAJD7tkbWz7mx6mUrvFQHP10ncqL-iVwD4ymHTm=oXW5qGgrZtA@mail.gmail.com>
 <ZRvJa1Hza1RS28+G@dhcp22.suse.cz>
In-Reply-To: <ZRvJa1Hza1RS28+G@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 3 Oct 2023 01:03:53 -0700
Message-ID: <CAJD7tkaOfsKC=F1inymxz8C0UT5=Sjo830bYLsoPd6WOOShyDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mm: memcg: fix tracking of pending stats updates values
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 3, 2023 at 12:57=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 25-09-23 10:11:05, Yosry Ahmed wrote:
> > On Mon, Sep 25, 2023 at 6:50=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Fri 22-09-23 17:57:38, Yosry Ahmed wrote:
> > > > While working on adjacent code [1], I realized that the values pass=
ed
> > > > into memcg_rstat_updated() to keep track of the magnitude of pendin=
g
> > > > updates is consistent. It is mostly in pages, but sometimes it can =
be in
> > > > bytes or KBs. Fix that.
> > >
> > > What kind of practical difference does this change make? Is it worth
> > > additional code?
> >
> > As explained in patch 2's commit message, the value passed into
> > memcg_rstat_updated() is used for the "flush only if not worth it"
> > heuristic. As we have discussed in different threads in the past few
> > weeks, unnecessary flushes can cause increased global lock contention
> > and/or latency.
> >
> > Byte-sized paths (percpu, slab, zswap, ..) feed bytes into the
> > heuristic, but those are interpreted as pages, which means we will
> > flush earlier than we should. This was noticed by code inspection. How
> > much does this matter in practice? I would say it depends on the
> > workload: how many percpu/slab allocations are being made vs. how many
> > flushes are requested.
> >
> > On a system with 100 cpus, 25M of stat updates are needed for a flush
> > usually, but ~6K of slab/percpu updates will also (mistakenly) cause a
> > flush.
>
> This surely depends on workload and that is understandable. But it would
> be really nice to provide some numbers for typical workloads which
> exercise slab heavily.

If you have a workload in mind I can run it and see how many flushes
we get with/without this patch. The first thing that pops into my head
is creating a bunch of empty files but I don't know if that's the best
thing to get numbers from.

> --
> Michal Hocko
> SUSE Labs
