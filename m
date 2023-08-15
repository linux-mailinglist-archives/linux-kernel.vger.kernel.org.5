Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67A977C4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjHOAxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjHOAxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:53:06 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E9B1710
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:52:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so72709001fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692060683; x=1692665483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DF8cCN5c46hMXv7mfXAxrDIYQabUgmS1Hsrig0V+jQ=;
        b=OqEkid6LHJUv/dnnZQeNSbgPrTga2p1Rg7hC4lce9ysXWPFOb965ybIH11k9KozkYE
         ++Q/tf1K5gcbbTOpBJwvPUu+khrw9WL0zXKRU4T1sQYBO+GIfKqNstu2m4fOKzHPFVgh
         RslMiu059PrSxFkvqcBGE1uAJDrfm0+aWeoRRFjPern7kCkCL+ND9+b1+vbUuFEDgSoc
         POSYw0EN/F5RdTEAizBNUBDtNI5MRiAM2MT58N9sYEAsV/LE7ATMssVAb1qDBfos1d0l
         5wm9zSdVQFwAZ7hw1vwuzDQA8dyBkeIA9spid8dBeJp17yeTcCVoEN5n9StLcr3vFIOa
         /cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692060683; x=1692665483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DF8cCN5c46hMXv7mfXAxrDIYQabUgmS1Hsrig0V+jQ=;
        b=gGq/emWbmOICPdV86gMj3/5v5zcoz6HidPJFdUgg90gekwRxbe2OG5XURQaE7dNk6V
         sCs3LKW7A775R039Nryr9fe5nOiiaNrWgvRaB6Mr5KjljWIMdA7HhvIN6OjiQZ5k7vjk
         NNFdvF28TJbBzBJuQzqYVXsuplU+WNsPSg7Ogl1OBpUK19KF+LSpTqybWWwYTLjzTz33
         uXk3FpjHoA271UQ+7zoTLymWHKX8KxpcomhzWIrPiJpkWTvRjf7D4mpYhoQGfMcEVCoh
         9ksDa+wvRJc/7w5A9BaKEXoEK9yXm98mt+2sZdZHzGsNMu/WwLS2UFJIHX52B2PHgJiM
         +Heg==
X-Gm-Message-State: AOJu0YyOXCXhORSVLWd69EOzvu5GWMJbZjlacYDwGdey+TOuWFzCFQlV
        dMOunoRofoZa+wOyvSJKysmgwBdjN7HWkT6SxVs34g==
X-Google-Smtp-Source: AGHT+IGI+0rMXyiTqDclgVU+5Q/VHvFjTyR5DfGND292wILhrXmllouPmLK8Q8BpDZkXhsxD2W1Jm3Ugsyg6SZXSoNY=
X-Received: by 2002:a2e:a287:0:b0:2b9:da28:c508 with SMTP id
 k7-20020a2ea287000000b002b9da28c508mr7509811lja.31.1692060683200; Mon, 14 Aug
 2023 17:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz> <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org> <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org> <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
 <ZNrLO5PAEZw4yjI9@slm.duckdns.org>
In-Reply-To: <ZNrLO5PAEZw4yjI9@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 14 Aug 2023 17:50:46 -0700
Message-ID: <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 14, 2023 at 5:48=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Aug 14, 2023 at 05:39:15PM -0700, Yosry Ahmed wrote:
> > I believe dropping unified flushing, if possible of course, may fix
> > both problems.
>
> Yeah, flushing the whole tree for every stat read will push up the big O
> complexity of the operation. It shouldn't be too bad because only what's
> updated since the last read will need flushing but if you have a really b=
ig
> machine with a lot of constantly active cgroups, you're still gonna feel =
it.
> So, yeah, drop that and switch the global lock to mutex and we should all=
 be
> good?

I hope so, but I am not sure.

The unified flushing was added initially to mitigate a thundering herd
problem from concurrent in-kernel flushers (e.g. concurrent reclaims),
but back then flushing was atomic so we had to keep the spinlock held
for a long time. I think it should be better now, but I am hoping
Shakeel will chime in since he added the unified flushing originally.

We also need to agree on what to do about stats_flushing_threshold and
flush_next_time since they're both global now (since all flushing is
global).

>
> Thanks.
>
> --
> tejun
