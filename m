Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B208805BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbjLERRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLERQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:16:58 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F2FD42
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:17:04 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3491703276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701796623; x=1702401423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+j0Ow1vOCeL95TLnZYt84KH1KzVbnclXd3P1tOJjQK4=;
        b=voLsq+fFM0MB3HHIIgFRcVbvhzwgrJcXUWcDadr8FVseJxCtPQseEB2OBBTo1KPTfz
         w5y4Zp1+5XH88Lb2c5N4IiTTPVhuNBA5VeHFFIG9hGcgiUGutAM4CWSeDn7CmF967ke5
         2TPWGKmmUbD7Gj9lE3Uu/LfkV0tyzEOjuFfOj+xJTcuchfXe8wXaGmywRQxorxThHpGZ
         UGpUo/ZqloQYSsquH8hm5/Pm5YDBAozRQ9FChNTL18ZapEjtVK5MLcBOIoqMqu6QQBDx
         U35/F/7KqC3axVQHgAOxLiik9yHZr25lEWfcpJjn5pyVc6dmFN7CLD1Nxo3CdezMIXZk
         2bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796623; x=1702401423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+j0Ow1vOCeL95TLnZYt84KH1KzVbnclXd3P1tOJjQK4=;
        b=u8uw6o5ZTP4dbzY0yQ2PoPm1p9fUmDdnwPpcmvJVCpQClqIgKvQSTfqUKDR70gl2EJ
         UBS8Xb8PTSsmDIib/SBA5wpt6lPr660G7xyf1hgE11nbf49m9jeV5NzBLu3opbRnw4vQ
         2ADgb4m46jb9mQ0MmhP/B3SV6lNjSWhnltFCy3VNaG1XqN7TPLvufuur5IFjYr0gdcvy
         WpWNn5Y8TGBArSrrV3RFTjRJCrJ4/oa3Gp+YkZJ+yM+dVa6VokhjBS3JeAZ8Ou1Nf81K
         bxeCfnJTm+f4vConjdjDaT9zommZtg4f5FpJnEk12twgyPqe/keUcrGIYHuQBH0Cvosz
         ud2A==
X-Gm-Message-State: AOJu0YzJAQE/Iv5j1CDZivYWWdSlieOJwrJ4FqyPqcLjiQxvAeJOUKut
        8M/U69ossAlGGqC+kVDB5fDsIw==
X-Google-Smtp-Source: AGHT+IHCOFtbuh+2xx33YQUO2m6y7idmJ/+9D8OhxohxpRR24h/b3yAyf/3HI6xxnibo2qd6edmAOg==
X-Received: by 2002:a81:52d2:0:b0:5d9:987d:36e1 with SMTP id g201-20020a8152d2000000b005d9987d36e1mr1208999ywb.76.1701796623181;
        Tue, 05 Dec 2023 09:17:03 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id o4-20020a0ccb04000000b0067a24c354bdsm2691901qvk.20.2023.12.05.09.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:17:02 -0800 (PST)
Date:   Tue, 5 Dec 2023 12:17:02 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v8 1/6] list_lru: allows explicit memcg and NUMA node
 selection
Message-ID: <20231205171702.GB99931@cmpxchg.org>
References: <20231130194023.4102148-1-nphamcs@gmail.com>
 <20231130194023.4102148-2-nphamcs@gmail.com>
 <ZWjpNr3ZzvU4TDC8@casper.infradead.org>
 <CAKEwX=MV-F50i_=sZ0unfbgjrdxSTio00c4xTM19113BAN3-wA@mail.gmail.com>
 <20231130203522.GC543908@cmpxchg.org>
 <CAF8kJuOvi6jrSPPKNeS1LFzEAPZwO77vEi5KQwW0c3eU13rcqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuOvi6jrSPPKNeS1LFzEAPZwO77vEi5KQwW0c3eU13rcqQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 04:30:44PM -0800, Chris Li wrote:
> On Thu, Nov 30, 2023 at 12:35 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Nov 30, 2023 at 12:07:41PM -0800, Nhat Pham wrote:
> > > On Thu, Nov 30, 2023 at 11:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Thu, Nov 30, 2023 at 11:40:18AM -0800, Nhat Pham wrote:
> > > > > This patch changes list_lru interface so that the caller must explicitly
> > > > > specify numa node and memcg when adding and removing objects. The old
> > > > > list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() and
> > > > > list_lru_del_obj(), respectively.
> > > >
> > > > Wouldn't it be better to add list_lru_add_memcg() and
> > > > list_lru_del_memcg() and have:
> 
> That is my first thought as well. If we are having two different
> flavors of LRU add, one has memcg and one without. The list_lru_add()
> vs list_lru_add_memcg() is the common way to do it.
> > > >
> > > > +bool list_lru_del(struct list_lru *lru, struct list_head *item)
> > > > +{
> > > > +       int nid = page_to_nid(virt_to_page(item));
> > > > +       struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
> > > > +               mem_cgroup_from_slab_obj(item) : NULL;
> > > > +
> > > > +       return list_lru_del_memcg(lru, item, nid, memcg);
> > > > +}
> > > >
> > > > Seems like _most_ callers will want the original versions and only
> > > > a few will want the explicit memcg/nid versions.  No?
> > > >
> > >
> > > I actually did something along that line in earlier iterations of this
> > > patch series (albeit with poorer naming - __list_lru_add() instead of
> > > list_lru_add_memcg()). The consensus after some back and forth was
> > > that the original list_lru_add() was not a very good design (the
> > > better one was this new version that allows for explicit numa/memcg
> > > selection). So I agreed to fix it everywhere as a prep patch.
> > >
> > > I don't have strong opinions here to be completely honest, but I do
> > > think this new API makes more sense (at the cost of quite a bit of
> > > elbow grease to fix every callsites and extra reviewing).
> >
> > Maybe I can shed some light since I was pushing for doing it this way.
> >
> > The quiet assumption that 'struct list_head *item' is (embedded in) a
> > slab object that is also charged to a cgroup is a bit much, given that
> > nothing in the name or documentation of the function points to that.
> 
> We can add it to the document if that is desirable.

It would help, but it still violates the "easy to use, hard to misuse"
principle. And I think it does the API layering backwards.

list_lru_add() is the "default" API function. It makes sense to keep
that simple and robust, then add add convenience wrappers for
additional, specialized functionality like memcg lookups for charged
slab objects - even if that's a common usecase.

It's better for a new user to be paused by the require memcg argument
in the default function and then go and find list_lru_add_obj(), than
it is for somebody to quietly pass an invalid object to list_lru_add()
and have subtle runtime problems and crashes (which has happened twice
now already).
