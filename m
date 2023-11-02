Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1F37DEA2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbjKBBhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjKBBhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:37:45 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAEDB9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 18:37:41 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35742cbb670so2284185ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 18:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698889061; x=1699493861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGpHBJ4COUsCkIGagSk/teYK9310nOjVL5KS9bqt5JE=;
        b=Rp8wi2i6ik1RoUu8kPHK2McBh60FIAzfvjJV4GERt2/5CrSA2xeB3sDjQhitw4JUnH
         ni2N26WwzLqrChBy50T7ijQGSsIxkkVPhJr+snQigb9/iKDlBzeq6ulhHnuvO7puxJXl
         BxmmE05x5qcDUsXi3bTufmeHJD5CBJpb4y8Fpc7CwvboWqc4Ewclyo0MZGVlM5gcCIFT
         fkNwHW63uENrLmH8/LNAEo5TI9isgf1+ye3FluneNh37mQzLRx+u4XYVTPrYS8j0yMrc
         kq9JueTgd10HEmuLqCFUk7VU2s/Xy8JPfP45chH/CPSMCAXJvztvyYFq859y2loNFHrj
         TELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698889061; x=1699493861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGpHBJ4COUsCkIGagSk/teYK9310nOjVL5KS9bqt5JE=;
        b=OiSg5KzckWweRrJJj91OMHAia4OuLngshsq1CI2KCLkxv6/1fQ9UbVQut07mHBleuT
         mrh5qO3+9uKz4qrDn/XoovOkn81vtmdmFbA6cBL6ZrnQWDfr5D5s0DCuCjZNmdGdKO23
         1ix6IE5+dbhLEPr6vfBYqlo/wiFs/RzM8KyBmCGIr2ev9GR8W2yH47laIEf2q9sznxzR
         J7MsqlM7Fx7Xf/ELfa+qE14DF4YBk0Ceazqvg3CBakoZN64KNGUn4vESPF0be+HMdFsq
         mwcb+moQolzRI22NKlmXFS5agE+8RNPs49sRiEmc8AWN+Oqko9RYbiImgSM8N17LQ5cs
         z6IQ==
X-Gm-Message-State: AOJu0YwuE6JCTbi0Y9HZnE+q30sap+8aImLUPzw3X5gQz4i9qrAqcxXR
        QsP90kWtPZQ1oiWxO5NBA8LTcq2EcWPZ2PvcPTY=
X-Google-Smtp-Source: AGHT+IGb+sDTHDniV6tYb6l+J04cUw7/0hjzetz+f6+2iX8yAjg9bTfG1BkXEoMp2gvWVxxhG6iYsTs9gfnIF84f5o8=
X-Received: by 2002:a05:6e02:308d:b0:359:3ee6:a909 with SMTP id
 bf13-20020a056e02308d00b003593ee6a909mr5632412ilb.13.1698889060813; Wed, 01
 Nov 2023 18:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231019110543.3284654-1-ryan.roberts@arm.com>
 <CAKEwX=PfAMZ2qJtwKwJsVx3TZWxV5z2ZaU1Epk1UD=DBdMsjFA@mail.gmail.com> <983c10ae-cb9a-4ae1-91ab-4112b836efb5@arm.com>
In-Reply-To: <983c10ae-cb9a-4ae1-91ab-4112b836efb5@arm.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 1 Nov 2023 18:37:29 -0700
Message-ID: <CAKEwX=NN7fxgM-_LDNNjxzncmyXieJS=sjRcMkXEUsz7H7KdmQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] mm: zswap: Store large folios without splitting
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 4:57=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi Nhat - thanks for the review!
>
>
> On 27/10/2023 19:49, Nhat Pham wrote:
> > On Thu, Oct 19, 2023 at 4:06=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Previously zswap would refuse to store any folio bigger than order-0,
> >> and therefore all of those folios would be sent directly to the swap
> >> file. This is a minor inconvenience since swap can currently only
> >> support order-0 and PMD-sized THP, but with the pending introduction o=
f
> >> "small-sized THP", and corresponding changes to swapfile to support an=
y
> >> order of folio, these large folios will become more prevalent and
> >> without this zswap change, zswap will become unusable. Independently o=
f
> >> the "small-sized THP" feature, this change makes it possible to store
> >> existing PMD-sized THPs in zswap.
> >>
> >> Modify zswap_store() to allow storing large folios. The function is
> >> split into 2 parts; zswap_store() does all the per-folio operations
> >> (i.e. checking there is enough space, etc). Then it calls a new helper=
,
> >> zswap_store_page(), for each page in the folio, which are stored as
> >> their own entries in the zswap pool. (These entries continue to be
> >> loaded back individually as single pages). If a store fails for any
> >> single page, then all previously successfully stored folio pages are
> >> invalidated.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >> I've tested this on arm64 (m2) with zswap enabled, and running
> >> vm-scalability's `usemem` across multiple cores from within a
> >> memory-constrained memcg to force high volumes of swap. I've also run =
mm
> >> selftests and observe no regressions (although there is nothing [z]swa=
p
> >> specific there) - does zswap have any specific tests I should run?
> >
> > There is a zswap kselftest in the cgroup suite:
> > https://lore.kernel.org/all/20230621153548.428093-1-cerasuolodomenico@g=
mail.com/
>
> ahh great - I'll run that against future versions.
>
> >
> > Regardless, I feel like this kind of change is probably better to be te=
sted
> > via stress tests anyway - allocating a bunch of anon memory with a cert=
ain
> > pattern, making sure they're not corrupted after being zswapped out etc=
.
>
> Yes - that's exactly what the `usemem` test I described above is doing (a=
nd its
> not reporting any corruption).

Nice, and I assume no regression (in runtime for e.g) in the usemem test
as well?

>
> >
> >
> >>
> >> This is based on mm-stable, since mm-unstable contains a zswap patch
> >> known to be buggy [1]. I thought it would be best to get comments on t=
he
> >> shape, then do the rebase after that patch has been fixed.
> >>
> >> For context, small-sized THP is being discussed here [2], and I'm
> >> working on changes to swapfile to support non-PMD-sized large folios
> >> here [3].
> >>
> >> [1] https://lore.kernel.org/linux-mm/21606fe5-fb9b-4d37-98ab-38c968198=
93b@arm.com/
> >> [2] https://lore.kernel.org/linux-mm/20230929114421.3761121-1-ryan.rob=
erts@arm.com/
> >> [3] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.rob=
erts@arm.com/
> >>
> >> Thanks,
> >> Ryan
> >>
> >>
> >>  mm/zswap.c | 155 +++++++++++++++++++++++++++++++++-------------------=
-
> >>  1 file changed, 98 insertions(+), 57 deletions(-)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 37d2b1cb2ecb..51cbfc4e1ef8 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -1188,18 +1188,17 @@ static void zswap_fill_page(void *ptr, unsigne=
d long value)
> >>         memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
> >>  }
> >>
> >> -bool zswap_store(struct folio *folio)
> >> +static bool zswap_store_page(struct folio *folio, long index,
> >> +                            struct obj_cgroup *objcg, struct zswap_po=
ol *pool)
> >>  {
> >>         swp_entry_t swp =3D folio->swap;
> >>         int type =3D swp_type(swp);
> >> -       pgoff_t offset =3D swp_offset(swp);
> >> -       struct page *page =3D &folio->page;
> >> +       pgoff_t offset =3D swp_offset(swp) + index;
> >> +       struct page *page =3D folio_page(folio, index);
> >>         struct zswap_tree *tree =3D zswap_trees[type];
> >>         struct zswap_entry *entry, *dupentry;
> >>         struct scatterlist input, output;
> >>         struct crypto_acomp_ctx *acomp_ctx;
> >> -       struct obj_cgroup *objcg =3D NULL;
> >> -       struct zswap_pool *pool;
> >>         struct zpool *zpool;
> >>         unsigned int dlen =3D PAGE_SIZE;
> >>         unsigned long handle, value;
> >> @@ -1208,51 +1207,11 @@ bool zswap_store(struct folio *folio)
> >>         gfp_t gfp;
> >>         int ret;
> >>
> >> -       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >> -       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> >> -
> >> -       /* Large folios aren't supported */
> >> -       if (folio_test_large(folio))
> >> -               return false;
> >> -
> >> -       if (!zswap_enabled || !tree)
> >> +       /* entry keeps the references if successfully stored. */
> >> +       if (!zswap_pool_get(pool))
> >>                 return false;
> >> -
> >> -       /*
> >> -        * If this is a duplicate, it must be removed before attemptin=
g to store
> >> -        * it, otherwise, if the store fails the old page won't be rem=
oved from
> >> -        * the tree, and it might be written back overriding the new d=
ata.
> >> -        */
> >> -       spin_lock(&tree->lock);
> >> -       dupentry =3D zswap_rb_search(&tree->rbroot, offset);
> >> -       if (dupentry) {
> >> -               zswap_duplicate_entry++;
> >> -               zswap_invalidate_entry(tree, dupentry);
> >> -       }
> >> -       spin_unlock(&tree->lock);
> >> -
> >> -       /*
> >> -        * XXX: zswap reclaim does not work with cgroups yet. Without =
a
> >> -        * cgroup-aware entry LRU, we will push out entries system-wid=
e based on
> >> -        * local cgroup limits.
> >> -        */
> >> -       objcg =3D get_obj_cgroup_from_folio(folio);
> >> -       if (objcg && !obj_cgroup_may_zswap(objcg))
> >> -               goto reject;
> >> -
> >> -       /* reclaim space if needed */
> >> -       if (zswap_is_full()) {
> >> -               zswap_pool_limit_hit++;
> >> -               zswap_pool_reached_full =3D true;
> >> -               goto shrink;
> >> -       }
> >> -
> >> -       if (zswap_pool_reached_full) {
> >> -              if (!zswap_can_accept())
> >> -                       goto shrink;
> >> -               else
> >> -                       zswap_pool_reached_full =3D false;
> >> -       }
> >> +       if (objcg)
> >> +               obj_cgroup_get(objcg);
> >>
> >>         /* allocate entry */
> >>         entry =3D zswap_entry_cache_alloc(GFP_KERNEL);
> >> @@ -1260,6 +1219,8 @@ bool zswap_store(struct folio *folio)
> >>                 zswap_reject_kmemcache_fail++;
> >>                 goto reject;
> >>         }
> >> +       entry->objcg =3D objcg;
> >> +       entry->pool =3D pool;
> >>
> >>         if (zswap_same_filled_pages_enabled) {
> >>                 src =3D kmap_atomic(page);
> >> @@ -1277,11 +1238,6 @@ bool zswap_store(struct folio *folio)
> >>         if (!zswap_non_same_filled_pages_enabled)
> >>                 goto freepage;
> >>
> >> -       /* if entry is successfully added, it keeps the reference */
> >> -       entry->pool =3D zswap_pool_current_get();
> >> -       if (!entry->pool)
> >> -               goto freepage;
> >> -
> >>         /* compress */
> >>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >>
> >> @@ -1337,7 +1293,6 @@ bool zswap_store(struct folio *folio)
> >>         entry->length =3D dlen;
> >>
> >>  insert_entry:
> >> -       entry->objcg =3D objcg;
> >>         if (objcg) {
> >>                 obj_cgroup_charge_zswap(objcg, entry->length);
> >>                 /* Account before objcg ref is moved to tree */
> >> @@ -1373,19 +1328,105 @@ bool zswap_store(struct folio *folio)
> >>
> >>  put_dstmem:
> >>         mutex_unlock(acomp_ctx->mutex);
> >> -       zswap_pool_put(entry->pool);
> >>  freepage:
> >>         zswap_entry_cache_free(entry);
> >>  reject:
> >>         if (objcg)
> >>                 obj_cgroup_put(objcg);
> >> +       zswap_pool_put(pool);
> >>         return false;
> >> +}
> >>
> >> +bool zswap_store(struct folio *folio)
> >> +{
> >> +       long nr_pages =3D folio_nr_pages(folio);
> >> +       swp_entry_t swp =3D folio->swap;
> >> +       int type =3D swp_type(swp);
> >> +       pgoff_t offset =3D swp_offset(swp);
> >> +       struct zswap_tree *tree =3D zswap_trees[type];
> >> +       struct zswap_entry *entry;
> >> +       struct obj_cgroup *objcg =3D NULL;
> >> +       struct zswap_pool *pool;
> >> +       bool ret =3D false;
> >> +       long i;
> >> +
> >> +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >> +       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> >> +
> >> +       if (!zswap_enabled || !tree)
> >> +               return false;
> >> +
> >> +       /*
> >> +        * If this is a duplicate, it must be removed before attemptin=
g to store
> >> +        * it, otherwise, if the store fails the old page won't be rem=
oved from
> >> +        * the tree, and it might be written back overriding the new d=
ata.
> >> +        */
> >> +       spin_lock(&tree->lock);
> >> +       for (i =3D 0; i < nr_pages; i++) {
> >> +               entry =3D zswap_rb_search(&tree->rbroot, offset + i);
> >> +               if (entry) {
> >> +                       zswap_duplicate_entry++;
> >> +                       zswap_invalidate_entry(tree, entry);
> >> +               }
> >> +       }
> >> +       spin_unlock(&tree->lock);
> >> +
> >> +       /*
> >> +        * XXX: zswap reclaim does not work with cgroups yet. Without =
a
> >> +        * cgroup-aware entry LRU, we will push out entries system-wid=
e based on
> >> +        * local cgroup limits.
> >> +        */
> >> +       objcg =3D get_obj_cgroup_from_folio(folio);
> >> +       if (objcg && !obj_cgroup_may_zswap(objcg))
> >> +               goto put_objcg;
> >
> > Hmm would this make more sense to check these limits
> > at a higher order page level or at a backing page (4 KB)
> > level?
> >
> > What if the cgroup still has some space before the new
> > folio comes in, but the new folio would drive the pool size
> > beyond the limit? Ditto for global zswap pool limit.
>
> I did consider this, but I thought I would keep it simple for the RFC and=
 accept
> that we may go over the limits by (HPAGE_PMD_NR - 1) pages. It sounds lik=
e you
> don't think that will be acceptable.

Not necessarily unacceptable - I just wanted to point out a potential
change in our assumption with zswap that might go unnoticed.

I think there should be at least some sort of documentation or
comments spelling this out.

>
> I see 2 options:
>
>   - move this checking logic to be per-page in zswap_store_page()
>   - pass a size (or nr_pages or order) to obj_cgroup_may_zswap(),
>     zswap_is_full() and zswap_can_accept() so they know how much we are
>     proposing to add and can make a correct decision.
>
> Personally I prefer the second option for efficiency.

Hmm if we go with the second option, how should this decision
be made? It's impossible to predict the post-compression size
of the huge page, even if we know its order.

I don't have a better suggestion than the first option, so if
anyone else has a better idea please chime in :)

Personally, I would not flat out NACK this patch because of this
limitation though, as long as it is at least spelled out somewhere.

>
> >
> > Previously, the object size is capped by the size of
> > a page (since we don't accept bigger size pages into
> > zswap). If zswap limit is exceded, it will not be exceeded
> > by more than 4 KB. No big deal. But I'm not sure
> > this will be OK as we move to bigger and bigger
> > sizes for the pages...
> >
> > If we do decide to check the cgroup's zswap limit for
> > each backing page, I'm not sure how the reclaim logic
> > (which will be introduced in the cgroup-aware zswap
> > LRU patch) will interact with this though.
>
> Ok so this points us in the direction of my option 2 above as well?
>
> >
> >> +
> >> +       /* reclaim space if needed */
> >> +       if (zswap_is_full()) {
> >> +               zswap_pool_limit_hit++;
> >> +               zswap_pool_reached_full =3D true;
> >> +               goto shrink;
> >> +       }
> >> +
> >> +       if (zswap_pool_reached_full) {
> >> +               if (!zswap_can_accept())
> >> +                       goto shrink;
> >> +               else
> >> +                       zswap_pool_reached_full =3D false;
> >> +       }
> >> +
> >> +       pool =3D zswap_pool_current_get();
> >> +       if (!pool)
> >> +               goto put_objcg;
> >> +
> >> +       /*
> >> +        * Store each page of the folio as a separate entry. If we fai=
l to store
> >> +        * a page, unwind by removing all the previous pages we stored=
.
> >> +        */
> >> +       for (i =3D 0; i < nr_pages; i++) {
> >> +               if (!zswap_store_page(folio, i, objcg, pool)) {
> >> +                       spin_lock(&tree->lock);
> >> +                       for (i--; i >=3D 0; i--) {
> >> +                               entry =3D zswap_rb_search(&tree->rbroo=
t, offset + i);
> >> +                               if (entry)
> >> +                                       zswap_invalidate_entry(tree, e=
ntry);
> >> +                       }
> >> +                       spin_unlock(&tree->lock);
> >> +                       goto put_pool;
> >> +               }
> >> +       }
> >> +
> >> +       ret =3D true;
> >> +put_pool:
> >> +       zswap_pool_put(pool);
> >> +put_objcg:
> >> +       if (objcg)
> >> +               obj_cgroup_put(objcg);
> >> +       return ret;
> >>  shrink:
> >>         pool =3D zswap_pool_last_get();
> >>         if (pool && !queue_work(shrink_wq, &pool->shrink_work))
> >>                 zswap_pool_put(pool);
> >> -       goto reject;
> >> +       goto put_objcg;
> >>  }
> >>
> >>  bool zswap_load(struct folio *folio)
> >>
> >> base-commit: 158978945f3173b8c1a88f8c5684a629736a57ac
> >> --
> >> 2.25.1
> >>
> >>
> >
> > I don't see anything else that is obviously wrong with this.
> > Seems straightforward to me.
> >
> > But I'm not too super familiar with THP swapping
> > logic either :) So maybe someone with exposure to both
> > should take a look too.
> >
> > And would it make sense to introduce a gate that guard
> > this so that users can opt-in/opt-out of this new feature,
> > at least as we experiment more with it to get more
> > data?
>
> There is already a gate at a higher level; CONFIG_THP_SWAP. If that is no=
t
> enabled, then all large folios will be split to single pages before a swa=
p entry
> is even allocated.

Hmm is there a runtime option as well, or does it not make sense to have
it? But yeah, in principle I'm not against having a single knob controlling
this behavior for both swap and zswap (as opposed to a zswap-specific
knob).

I'll defer any further objections to this aspect to other zswap contributor=
s
and maintainers :)
>
> I considered adding a separate gate for this, but given the above control=
, I
> didn't think the zswap-specific control was really neccessary. What do yo=
u think?
>
> Thanks,
> Ryan
>
>
