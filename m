Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D37B85FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbjJDQ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbjJDQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:59:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CC9AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:59:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso8017966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696438766; x=1697043566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSLEpMzuN33kxQzm5qH/gkILKAwB7b5zDmsWnwSQOLs=;
        b=OZ+j78O0gPwUe7JHH0M1B1PDBEFNvVGyrobC0TFxPlaErg6ZVq+Dd9K3OB7WXS/yL3
         /kt1xDOwW8df5Jx9y0aipX7imL3vFIjm2OlW4MCDu4GGqO7cHZrTnq+fuJ41Pb2rFltZ
         CKJbYQ9jEeLM7Srngueh9jGpgcjemOT4blDH7B9qYCqlK5mYf4+/iSOzOQr5c3dQw9Zo
         I8ItfSfMbmjqyzithbolRukVEUGQUjLjFtl8gMfGPbNkNFjaV56Lfoi0gaUv/q1z6zTo
         Wo45e/ayxAZR/c5h5quSz5rsn78Mv2gzFwKsskr9vLDcwnrHKMaBreYH5tIKKhbbJgLY
         HxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696438766; x=1697043566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSLEpMzuN33kxQzm5qH/gkILKAwB7b5zDmsWnwSQOLs=;
        b=gJ9Z1FMLBj1bjztUHMMKfy7kjfh4UP5jwzfsvN2ixlsnmun9VvwfitdvzO6jHlCZFQ
         Z1SHsc2fOqk6vHym8i0wrZvd8sfNoPTjK56xV8HRRJm+rsGIIj5rm4lwl3iT/XcQdkOB
         UG628RPQ1RwcMZ3acCgwCgrRgK20tvQ93rD5yFK/VfCVY7cRJFwRC/j9XHXq2IvWvZqd
         ASdyvZ5q4R1otObg6dbNt/vzZ9+d+dC3PtFWFoxSQ4oXMgiHfCmA/8anUmxQhpmuUvp0
         lD+d+gf7fZDSNTXu0i4VrorzqNbtT8qc9kXYKNOsyqIHELnEBSFc1sN5r8m7peXJh/oL
         oo8g==
X-Gm-Message-State: AOJu0YwlyJBNYIp6Uu/lmy0QlSpWNMKRjRm+1AYFEywGUsjmGcCIxhuR
        ZdjTK4TDxTVWyXtLuamr+9krMtJNqPMmHZSIRq/4xg==
X-Google-Smtp-Source: AGHT+IHvMn3cUi8cdEInkKSKT7oTyPnMvCooRlL/sjr6CtL9EsK9lo8KLtXDrbVnbMCsRglelu7I0bk+fUDog761gMw=
X-Received: by 2002:a17:906:7485:b0:9ae:5fe1:ef03 with SMTP id
 e5-20020a170906748500b009ae5fe1ef03mr2430403ejl.67.1696438765556; Wed, 04 Oct
 2023 09:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com> <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
 <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com> <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
In-Reply-To: <vet5qmfj5xwge4ebznzihknxvpmrmkg6rndhani3fk75oo2rdm@lk3krzcresap>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 4 Oct 2023 09:58:46 -0700
Message-ID: <CAJD7tkZZ8yFu82s7CYzzQc1_kkwHL0Y8qk8MTadHLvT0FDoz4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 4, 2023 at 2:02=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Tue, Oct 03, 2023 at 12:47:25PM -0700, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > Those constants are shared with code outside of memcg, namely enum
> > node_stat_item and enum vm_event_item, and IIUC they are used
> > differently outside of memcg. Did I miss something?
>
> The difference is not big, e.g.
>   mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type, delta);
> could be
>   __count_memcg_events(
>     container_of(lruvec, struct mem_cgroup_per_node, lruvec)->memcg,
>     WORKINGSET_ACTIVATE_BASE + type, delta
>   );
>
> Yes, it would mean transferring WORKINGSET_* items from enum
> node_stat_item to enum vm_event_item.
> IOW, I don't know what is the effective difference between
> mod_memcg_lruvec_state() and count_memcg_events().
> Is it per-memcg vs per-memcg-per-node resolution?
> (Is _that_ read by workingset mechanism?)

Even if it is not read, I think it is exposed in memory.numa_stat, right?

Outside of memcg code, if you look at vmstat_start(), you will see
that the items in enum vm_event_item are handled differently (see
all_vm_events()) when reading vmstat. I don't think we can just move
it, unfortunately.

>
> Thanks,
> Michal
