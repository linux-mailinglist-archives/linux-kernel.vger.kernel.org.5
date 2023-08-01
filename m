Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEEF76A9C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHAHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHAHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:13:13 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A09B1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:13:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so215171cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690873991; x=1691478791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOzFHKg5nc9JsX6FYxxovkU86yNMNcWnN0ObAXQMNcE=;
        b=N2UDqWSQl8joRYkbeF6pR56CcOv3FsGsiZvI51s2qCJlznNRvwJ32mg11s4J/Y5m2F
         cNM33bfpO3fBtWqe0dOd4Acc+XqSm1Qz0CyREyC9BO6nF3be7VUdVd9Khg/5HDpoKZ4o
         AWdBiqY9vKgTBqmp2pqRNwiI1rRh5oQclKk9ssc2gpR0xc5on33vc4P7JyVjWxjjBPiw
         zBsdsOpt6xpeLB8oAyOuXJmPoYbv4CvZSiseVQcADBzTp+QYciau4o+oIBtdJVGWVgx9
         tXXqPBOCUnsHCFcEiuS4aZWEP0r1udq9MSnTKQojDhDacxOqvzBj7/yjITylDfATFrGw
         RlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690873991; x=1691478791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOzFHKg5nc9JsX6FYxxovkU86yNMNcWnN0ObAXQMNcE=;
        b=HXsq0n+CTNQZqRy+puPDhjsaIzSLm2A2OEjYklcUfDWFyT1sEuacRFbSFS77e/8ZyQ
         MKXpoY9S2zu2jXFCfzy/IxNzt5Ojvxji1QM/urYMqQZNNjFb9muQ4G7fOAAKGkNDIAOW
         ac6KisdSJgqGHfBwYRyg5LUtZewfsrjsD99yU9vD1c8yQx2afNbNy7PRUgCM5zSeEtJb
         KylS6wpdsDwI1055NSZBDoh2ml9BceZ3FADDAF/gIzqJd+dj8unFgBRDVmSIFINBytGw
         AesyzKNIzl+9tVkhJ7rRA0M+KdOEELG/wXSPqcwdiNi5rD3qFXSNW/t4/9auq3wGTWui
         jOjA==
X-Gm-Message-State: ABy/qLa9L+Zj9BfwXecmScrPhDrAMIm6/1BcrIXAYv+WCFoAwO90ihWq
        9DH75hQGhZ0IrwJPaxjEHGv8SgCKYVelGsxMV8Yr3w==
X-Google-Smtp-Source: APBJJlGi8avMgQgerOpBeHOmKVY98vF12xGS3li82sLXOz+7OZQGAAotBvs1GsKpqbxm9aX2eGppF1RbecQLLV4oMzA=
X-Received: by 2002:ac8:5913:0:b0:3ef:5f97:258f with SMTP id
 19-20020ac85913000000b003ef5f97258fmr709528qty.16.1690873990936; Tue, 01 Aug
 2023 00:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com> <CAOUHufYiEwYw0sFGK0kP0FFRfV51=hVJ==e5R_hXZXQo-OEcwQ@mail.gmail.com>
 <9b54e5af-af1a-6741-424b-6c667d0b405b@arm.com>
In-Reply-To: <9b54e5af-af1a-6741-424b-6c667d0b405b@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 1 Aug 2023 01:12:34 -0600
Message-ID: <CAOUHufbbHWLD1uobPD2L17+YD3y-dFvGy-8kr-c9CkYDHLiEPg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 3:16=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/07/2023 18:22, Yu Zhao wrote:
> > On Thu, Jul 27, 2023 at 8:18=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> This allows batching the rmap removal with folio_remove_rmap_range(),
> >> which means we avoid spuriously adding a partially unmapped folio to t=
he
> >> deferred split queue in the common case, which reduces split queue loc=
k
> >> contention.
> >>
> >> Previously each page was removed from the rmap individually with
> >> page_remove_rmap(). If the first page belonged to a large folio, this
> >> would cause page_remove_rmap() to conclude that the folio was now
> >> partially mapped and add the folio to the deferred split queue. But
> >> subsequent calls would cause the folio to become fully unmapped, meani=
ng
> >> there is no value to adding it to the split queue.
> >>
> >> A complicating factor is that for platforms where MMU_GATHER_NO_GATHER
> >> is enabled (e.g. s390), __tlb_remove_page() drops a reference to the
> >> page. This means that the folio reference count could drop to zero whi=
le
> >> still in use (i.e. before folio_remove_rmap_range() is called). This
> >> does not happen on other platforms because the actual page freeing is
> >> deferred.
> >>
> >> Solve this by appropriately getting/putting the folio to guarrantee it
> >> does not get freed early. Given the need to get/put the folio in the
> >> batch path, we stick to the non-batched path if the folio is not large=
.
> >> While the batched path is functionally correct for a folio with 1 page=
,
> >> it is unlikely to be as efficient as the existing non-batched path in
> >> this case.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >
> > This ad hoc patch looks unacceptable to me: we can't afford to keep
> > adding special cases.
> >
> > I vote for completely converting zap_pte_range() to use
> > folio_remove_rmap_range(), and that includes tlb_flush_rmap_batch()
> > and other types of large folios, not just anon.
>
> The intent of the change is to avoid the deferred split queue lock conten=
tion
> and this is only a problem for anon folios;

This reasoning seems wrong to me: if the goal was to fix the lock
contention, the fix should have been in deferred_split_folio().

> page cache folios are never split in
> this way.

The goal I see here is to enlighten zap_pte_range() with batch
operations on folios.

> My intention was to do the smallest change to solve the problem.

I understand the desire. But we can't do this at the cost of making
the codebase harder to maintain.

> I
> don't see the value in reworking a much bigger piece of the code, making =
it more
> complex, when its not going to give any clear perf benefits.

"Much bigger ... more complex": I'm not sure how you get this
impression. Have you tried to do it already or is it just a gut
feeling?

Supporting other types of large folios, not just anon, actually makes
it simpler!

> Otherwise I'll leave
> > it to Matthew and David.
>
> If there is concensus that this is _required_ in order to merge this seri=
es,
> then I guess I'll bite the bullet and do it. But my preference is to leav=
e it
> for if/when a reason is found that it is actually bringing benefit.

There is a clear reason here: this patch is *half-baked* because it
doesn't handle tlb_flush_rmap_batch().
