Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164DA7E6145
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjKIAIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKIAID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:08:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C1D2685
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:08:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso358967a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 16:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699488479; x=1700093279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz7mhIwDEHwZ7Y0YNWv+J5BlWu5bz+Y6wtW1QfLOmcM=;
        b=QFPjbg98K9iJNkwws75Xd43/wi/aJsYf9ktODskfTDJ755amtKvZez6cT4thQ64Xh3
         xq2YVfCCMNp53d/Aky2xEKekumHNfFStJHn3D/+u7igmy4kFncHlaK2RQmvgpdJ+VTtP
         0NYLCL0clcLjPhmVDWmoBM3C4P279owHj4NwcR0yseb9yw0irD0VGoxM3a9xb9/oJRsW
         rSJx0M9ElViX+8rXtbL4i83Au2cibC2YjT2I35J/OA2wje7h/mvm2EUp1xp1CW5BrKuC
         1zSp0eM2Sprn3oi4zY1zteks/R9Do6E3B7YeCBY8MkCDuazwtwJ8H1eTC30arx1nsbHh
         9dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699488479; x=1700093279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz7mhIwDEHwZ7Y0YNWv+J5BlWu5bz+Y6wtW1QfLOmcM=;
        b=auj7985g1oqoxRt2nVHAASexggyW7w9+VS86hYHOsY13217ZbskVtjzo1CrLafvLW0
         Ye9omZ/2XkFAonzw0RTGQ8LcGkZJreYeDWk42D+gvPGqldy/tZ+Sc7zTD9x+O5P2oQuQ
         xYnwyzNvAZ2lPEdnMHPgalUO2n0lW0Tjwlo5Io/CUl+NDMrjCf4LVa59m7zg5UCE9dVz
         Dh690OPCj9Pr5vUl0qcLtBApTgQDRKt0FLORH/s2MF2fVPKhmuTDFvgzFyorIQyMgOYj
         YlhXKqX+miRP32X2R8GOu/UzcA4Gj4saSkYg9O85TT5sebikB61a4rxBzeqTJpjRWfzo
         pDfw==
X-Gm-Message-State: AOJu0Yz4zcNNxVy7dYbcKDS162L1xYAxJ0ID+G9FsKTlRG9AiZzsBYdw
        XN0PUAArwqjkSjxOOJ/e0vMYRry+RLRSE1E9ggbphA==
X-Google-Smtp-Source: AGHT+IGpO7H+kRRWyzMj4BetZ3oYPaIbaBlz2jRUUfN3V+9mya/7be4ceQJGfNOaDOryDYKZgvJQi3sXhasVWJqBjBI=
X-Received: by 2002:a17:907:7f1e:b0:9d5:ecf9:e6a0 with SMTP id
 qf30-20020a1709077f1e00b009d5ecf9e6a0mr1348753ejc.0.1699488479067; Wed, 08
 Nov 2023 16:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20231108164920.3401565-1-jackmanb@google.com> <CALvZod4Uj9rR3OL7CYfq5t8gsRLAa7b2wa3m26nyDhfvQaWQ+g@mail.gmail.com>
In-Reply-To: <CALvZod4Uj9rR3OL7CYfq5t8gsRLAa7b2wa3m26nyDhfvQaWQ+g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Nov 2023 16:07:21 -0800
Message-ID: <CAJD7tkYJJOq5cZCaymbTT_PdGrQOb6iGUvrtaPK9FAFXYFduUg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/page_alloc: Dedupe some memcg uncharging logic
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Brendan Jackman <jackmanb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 3:52=E2=80=AFPM Shakeel Butt <shakeelb@google.com> w=
rote:
>
> On Wed, Nov 8, 2023 at 8:49=E2=80=AFAM Brendan Jackman <jackmanb@google.c=
om> wrote:
> >
> > The duplication makes it seem like some work is required before
> > uncharging in the !PageHWPoison case. But it isn't, so we can simplify
> > the code a little.
> >
> > Note the PageMemcgKmem check is redundant, but I've left it in as it
> > avoids an unnecessary function call.
> >
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> Thanks for the patch. Actually the PageMemcgKmem/folio_memcg_kmem
> check should be in memcg_kmem_uncharge_page() and not in
> __memcg_kmem_uncharge_page(). Anyways, that is orthogonal to this
> patch.

Agreed. If we move the check into memcg_kmem_uncharge_page(), perhaps
we should call it directly here instead of doing the checks, since
there won't be an extra function call as it is inline, right? We can
also make __memcg_kmem_uncharge_page static to mm/memcontrol.c

I suspect the same can be done for __memcg_kmem_charge_page() as well.
