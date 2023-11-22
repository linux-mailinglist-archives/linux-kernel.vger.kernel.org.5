Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE87F440A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjKVKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKVKkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:40:01 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095EFD8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:39:57 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507b9408c61so9107620e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700649595; x=1701254395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPWkkH55xPxAxHPspMATKuWOXWgWjEUaF8xxquOIBi0=;
        b=uZ5Kt/GT1aCwQOvCELoJXDGZGgLL3XJ1JpfySc8IvjOecKEDv5bywYQxJ3Kekgy9kf
         YTePDb4ykYUie5W7/Lke3YldZA2wAvlWkf7wCjZ12Th+cIXmNAcXBH5iqcHOL+sICcDk
         hoQAtqeXteoGBMaR+yhJ6yK6bQo2Ps1s/mYJo7rBxbVYWwm2BvJCYxaq8COrU4fMfsHL
         LWSPXQero2xz+xaME6+41uKXTGDH1Hzrij1lS61qpa2uWde8rqe3G3Oz+tF3QOFwKjYx
         xvh3OGEUkJlvA+HtgH+rCuINZ0Y15E86ui7s784ueFitlbVTSkDOPy6MWxkdYXfe1NG8
         E3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700649595; x=1701254395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPWkkH55xPxAxHPspMATKuWOXWgWjEUaF8xxquOIBi0=;
        b=jcBmbHdtjVew7gzvDZ59hi7/fmq9cnVPzRsHI5CycpxLhcLfVhxvwjoOdHgmKAZgwo
         fq/4HmNodPauM7ClvMqEYXPSfRIqLzyb7VOm0tMu+v+s/UbWOJVXa5FtQ3kb3uTgbwCL
         6aQPF4Zaky/6zvXvX/re5nfiEqw2H5QNQtE4umbYrNnC03KAu5gH5KEYE3tzkE9GPHCK
         /Zsd9UHySmR9IAyRTNYMu1PCWqjFS8J73n7SnF/emwaOEP4Y3dlizI5WJigd0Yp+LGCK
         cFW6WjwQpnYb6xu1b0xG/+qZSwQUPOAi5UYYMqpKlvz9WQoCsMxirFjynRpR5GymkRFV
         1TiA==
X-Gm-Message-State: AOJu0Yw0Yxo2257xQXTjc43U0iMI/e9FMrVyn0DheHI7jIwg/yYVxzYd
        jZ7ft9LkmWAosecD8nrgY/qzexgaxgutvlWDfAkWGw==
X-Google-Smtp-Source: AGHT+IFvsXtAu9iJG+Ar78KDXMZvoDM+bciud3KjTO/bgSnXAWHgkMkDtMh8KcHGANQVftizzJF1igDKNaNwMXt6X9I=
X-Received: by 2002:ac2:5334:0:b0:509:448a:d with SMTP id f20-20020ac25334000000b00509448a000dmr1163961lfh.31.1700649594924;
 Wed, 22 Nov 2023 02:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <ZVyp5eETLTT0PCYj@tiehlicka> <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
 <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
 <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
In-Reply-To: <ZV3TQCElHpcp0h0V@tiehlicka>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 22 Nov 2023 02:39:15 -0800
Message-ID: <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
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

On Wed, Nov 22, 2023 at 2:09=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 22-11-23 09:52:42, Michal Hocko wrote:
> > On Tue 21-11-23 22:44:32, Yosry Ahmed wrote:
> > > On Tue, Nov 21, 2023 at 10:41=E2=80=AFPM Liu Shixin <liushixin2@huawe=
i.com> wrote:
> > > >
> > > >
> > > > On 2023/11/21 21:00, Michal Hocko wrote:
> > > > > On Tue 21-11-23 17:06:24, Liu Shixin wrote:
> > > > >
> > > > > However, in swapcache_only mode, the scan count still increased w=
hen scan
> > > > > non-swapcache pages because there are large number of non-swapcac=
he pages
> > > > > and rare swapcache pages in swapcache_only mode, and if the non-s=
wapcache
> > > > > is skipped and do not count, the scan of pages in isolate_lru_fol=
ios() can
> > > > > eventually lead to hung task, just as Sachin reported [2].
> > > > > I find this paragraph really confusing! I guess what you meant to=
 say is
> > > > > that a real swapcache_only is problematic because it can end up n=
ot
> > > > > making any progress, correct?
> > > > This paragraph is going to explain why checking swapcache_only afte=
r scan +=3D nr_pages;
> > > > >
> > > > > AFAIU you have addressed that problem by making swapcache_only an=
on LRU
> > > > > specific, right? That would be certainly more robust as you can s=
till
> > > > > reclaim from file LRUs. I cannot say I like that because swapcach=
e_only
> > > > > is a bit confusing and I do not think we want to grow more specia=
l
> > > > > purpose reclaim types. Would it be possible/reasonable to instead=
 put
> > > > > swapcache pages on the file LRU instead?
> > > > It looks like a good idea, but I'm not sure if it's possible. I can=
 try it, is there anything to
> > > > pay attention to?
> > >
> > > I think this might be more intrusive than we think. Every time a page
> > > is added to or removed from the swap cache, we will need to move it
> > > between LRUs. All pages on the anon LRU will need to go through the
> > > file LRU before being reclaimed. I think this might be too big of a
> > > change to achieve this patch's goal.
> >
> > TBH I am not really sure how complex that might turn out to be.
> > Swapcache tends to be full of subtle issues. So you might be right but
> > it would be better to know _why_ this is not possible before we end up
> > phising for couple of swapcache pages on potentially huge anon LRU to
> > isolate them. Think of TB sized machines in this context.
>
> Forgot to mention that it is not really far fetched from comparing this
> to MADV_FREE pages. Those are anonymous but we do not want to keep them
> on anon LRU because we want to age them indepdendent on the swap
> availability as they are just dropped during reclaim. Not too much
> different from swapcache pages. There are more constrains on those but
> fundamentally this is the same problem, no?

I agree it's not a first, but swap cache pages are more complicated
because they can go back and forth, unlike MADV_FREE pages which
usually go on a one way ticket AFAICT. Also pages going into the swap
cache can be much more common that MADV_FREE pages for a lot of
workloads. I am not sure how different reclaim heuristics will react
to such mobility between the LRUs, and the fact that all pages will
now only get evicted through the file LRU. The anon LRU will
essentially become an LRU that feeds the file LRU. Also, the more
pages we move between LRUs, the more ordering violations we introduce,
as we may put colder pages in front of hotter pages or vice versa.

All in all, I am not saying it's a bad idea or not possible, I am just
saying it's probably more complicated than MADV_FREE, and adding more
cases where pages move between LRUs could introduce problems (or make
existing problems more visible).

> --
> Michal Hocko
> SUSE Labs
