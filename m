Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43F7F5159
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjKVUOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVUOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:14:42 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5C618E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:14:38 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c41e95efcbso16219466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700684075; x=1701288875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr1DL5tfS7yVcqLu3K8sHUIKgak2PAZwUVJOppxZncw=;
        b=AzBufSyFnMw9kRzIamQRdt9Q9+qORRHFV+wX4ZHvgtqDOeX0tyRL3qySDR4/2Tm5Uf
         BVLCuMH0kpmtDp0o5szBioWDIAn4pRg3RJN33puRPqU4g3NL5vUf68qyOj0v5vqCxSvO
         ojYPbSBQ8gCBruCMt8TKz/Yorli395uvWW65LFLgYf7unrNT3nUs20hRD7xHuskUR2yp
         ADlY53m+83ScehQm5jH0v2zRbhTgUEE+Ycat8clq47HSFhmDxIq0gcRd02y3aT4Z0FIi
         5LG5PIm5j411DGnBBReT0ltnCr8Gpt56L1LSc4s60AlUHbWmRzvlPMuHopASLsxWUPfs
         dfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684075; x=1701288875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr1DL5tfS7yVcqLu3K8sHUIKgak2PAZwUVJOppxZncw=;
        b=AzcAj9a+4ZAd8zOJHeIoeNo9HT6unZktU2/TeKe8KHH6WFrNTaqGUVa9lD9mYLxalu
         ZQ+NvBL8cfx/PBEnOmu1oeFi7H/XUc/NvRIzo767mmdiYDOW89KREDjHn2dYb/KCEooe
         B4qU+gVC99uiJLkjAryArsY6E3fLy/VM//Dmnvngsu4a6YpWP9b7oizi4zLPYyrdTaie
         WFNRnVh9djTMIYAGfMwcpc9MJnBrfz9A8iYgIx3dvKGgq0XTHZwpSKbG7lHMLemitwFD
         0e/d3+8iOh/nAAAyczPxoXHiEmP4dXYrEetDYeCbOL9OpJgwOTMUmWQ+4jb8grq6QiSg
         0SgA==
X-Gm-Message-State: AOJu0YwMuYqtdLPot2+XKW50bh3y/VNLQoPxqlhomgQqI/l7ZaH17MuY
        wm3tQgxwsWiu7upuv9/zi8ODH0SNXvlQ6oHXsQWhew==
X-Google-Smtp-Source: AGHT+IHbBy1vuIP1D9N/BZThCao3URRhWQAoOskMKsAuPWcwfw10Wsu0XS7bo7PRD0BcT2+AKxZUzvlww04D4RfRVBI=
X-Received: by 2002:a17:906:4c:b0:a02:ac3d:9e97 with SMTP id
 12-20020a170906004c00b00a02ac3d9e97mr2423326ejg.9.1700684074674; Wed, 22 Nov
 2023 12:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <ZVyp5eETLTT0PCYj@tiehlicka> <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
 <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
 <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka> <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka>
In-Reply-To: <ZV3_6UH28KMt0ZDb@tiehlicka>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 22 Nov 2023 12:13:54 -0800
Message-ID: <CAJD7tkZfxaSBW8K4kWPBCYuVQYsSj_fk054nGPqCD1Y2QODtZg@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     Michal Hocko <mhocko@suse.com>
Cc:     Liu Shixin <liushixin2@huawei.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 5:19=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 22-11-23 02:39:15, Yosry Ahmed wrote:
> > On Wed, Nov 22, 2023 at 2:09=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Wed 22-11-23 09:52:42, Michal Hocko wrote:
> > > > On Tue 21-11-23 22:44:32, Yosry Ahmed wrote:
> > > > > On Tue, Nov 21, 2023 at 10:41=E2=80=AFPM Liu Shixin <liushixin2@h=
uawei.com> wrote:
> > > > > >
> > > > > >
> > > > > > On 2023/11/21 21:00, Michal Hocko wrote:
> > > > > > > On Tue 21-11-23 17:06:24, Liu Shixin wrote:
> > > > > > >
> > > > > > > However, in swapcache_only mode, the scan count still increas=
ed when scan
> > > > > > > non-swapcache pages because there are large number of non-swa=
pcache pages
> > > > > > > and rare swapcache pages in swapcache_only mode, and if the n=
on-swapcache
> > > > > > > is skipped and do not count, the scan of pages in isolate_lru=
_folios() can
> > > > > > > eventually lead to hung task, just as Sachin reported [2].
> > > > > > > I find this paragraph really confusing! I guess what you mean=
t to say is
> > > > > > > that a real swapcache_only is problematic because it can end =
up not
> > > > > > > making any progress, correct?
> > > > > > This paragraph is going to explain why checking swapcache_only =
after scan +=3D nr_pages;
> > > > > > >
> > > > > > > AFAIU you have addressed that problem by making swapcache_onl=
y anon LRU
> > > > > > > specific, right? That would be certainly more robust as you c=
an still
> > > > > > > reclaim from file LRUs. I cannot say I like that because swap=
cache_only
> > > > > > > is a bit confusing and I do not think we want to grow more sp=
ecial
> > > > > > > purpose reclaim types. Would it be possible/reasonable to ins=
tead put
> > > > > > > swapcache pages on the file LRU instead?
> > > > > > It looks like a good idea, but I'm not sure if it's possible. I=
 can try it, is there anything to
> > > > > > pay attention to?
> > > > >
> > > > > I think this might be more intrusive than we think. Every time a =
page
> > > > > is added to or removed from the swap cache, we will need to move =
it
> > > > > between LRUs. All pages on the anon LRU will need to go through t=
he
> > > > > file LRU before being reclaimed. I think this might be too big of=
 a
> > > > > change to achieve this patch's goal.
> > > >
> > > > TBH I am not really sure how complex that might turn out to be.
> > > > Swapcache tends to be full of subtle issues. So you might be right =
but
> > > > it would be better to know _why_ this is not possible before we end=
 up
> > > > phising for couple of swapcache pages on potentially huge anon LRU =
to
> > > > isolate them. Think of TB sized machines in this context.
> > >
> > > Forgot to mention that it is not really far fetched from comparing th=
is
> > > to MADV_FREE pages. Those are anonymous but we do not want to keep th=
em
> > > on anon LRU because we want to age them indepdendent on the swap
> > > availability as they are just dropped during reclaim. Not too much
> > > different from swapcache pages. There are more constrains on those bu=
t
> > > fundamentally this is the same problem, no?
> >
> > I agree it's not a first, but swap cache pages are more complicated
> > because they can go back and forth, unlike MADV_FREE pages which
> > usually go on a one way ticket AFAICT.
>
> Yes swapcache pages are indeed more complicated but most of the time
> they just go away as well, no? MADV_FREE can be reinitiated if they are
> written as well. So fundamentally they are not that different.
>
> > Also pages going into the swap
> > cache can be much more common that MADV_FREE pages for a lot of
> > workloads. I am not sure how different reclaim heuristics will react
> > to such mobility between the LRUs, and the fact that all pages will
> > now only get evicted through the file LRU. The anon LRU will
> > essentially become an LRU that feeds the file LRU. Also, the more
> > pages we move between LRUs, the more ordering violations we introduce,
> > as we may put colder pages in front of hotter pages or vice versa.
>
> Well, traditionally the file LRU has been maintaining page cache or
> easily disposable pages like MADV_FREE (which can be considered a cache
> as well). Swapcache is a form of a page cache as well.

If I understand correctly, when we move the MADV_FREE pages to the
file LRU, we don't have correct information about their relative
ordering compared to the pages that are already in the inactive file
LRU. IOW, we mess up the ordering of the inactive file LRU a little.
If we add more cases of moving pages to the file LRU (for the swap
cache), we may make it worse. I am also not sure how this works with
MGLRU generations.

Keep in mind that when a page is affected with MADV_FREE, it's always
called. On the other hand, when a page is added to the swap cache, it
could be because it's under reclaim (cold), or it was just swapped in
(hot). I am not sure this practically matters, just something to think
about.

It also seems like all evictions will now be done from the file LRU,
so some heuristics (like workingset) may need to be updated
accordingly.

>
> > All in all, I am not saying it's a bad idea or not possible, I am just
> > saying it's probably more complicated than MADV_FREE, and adding more
> > cases where pages move between LRUs could introduce problems (or make
> > existing problems more visible).
>
> Do we want to start adding filtered anon scan for a certain type of
> pages? Because this is the question here AFAICS. This might seem an
> easier solution but I would argue that it is less predictable one.
> It is not unusual that a huge anon LRU would contain only very few LRU
> pages.

I agree that it may be a problem in some situations.

>
> That being said, I might be missing some obvious or less obvious reasons
> why this is completely bad idea. Swapcache is indeed subtle.
> --
> Michal Hocko
> SUSE Labs
