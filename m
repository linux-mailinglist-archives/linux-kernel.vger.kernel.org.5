Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021D57F9D02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjK0KAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjK0KAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:00:04 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECAE13A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:00:10 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4abf86c5ae1so948743e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701079209; x=1701684009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6tK140abEWkHitKUAk7mI5hF8YD1QH02qgtvosYmP0=;
        b=NpBL6sMGvSkB2sBe6PpSrAg4rCCD/XYtp7aIfsQ/GX3BwuE9uLEFt/bX01NYrDQD3a
         dLlM/cLmeg16C3BqinlcKD9XMQQ8b8z0e0BnQX+9iS7Jc/vnwuyMGTUFHh0CiEPIVELv
         Yaw5szKN3rXA6xX4kucFnm05PWiofqZyF6a3nGXn8G8GgxNip23oKEzuVr7Ai2pnY9jh
         5/rFcQC9kC4Ow2vclj96kdRsny/ZOzQxTU2Efi6FHz1Hi2etcVNW28IeIWwltGFc+EBy
         ZKBBIQ720NDg6QIQf8rHIUlciBrLytCRhulmQc5wwFUgNL+0PUXA+AdGa/s28ECQoMVB
         LmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701079209; x=1701684009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6tK140abEWkHitKUAk7mI5hF8YD1QH02qgtvosYmP0=;
        b=A81rGgKaItmYaehlA2EdU1SnmKwsOWOe0NtmzN3xY+hWofn/Q/UPN+r+G3L2LQR9IQ
         uAN4qJsapHOJQmZH05ArX1NN0WCUTDII4zPEI0/WXkiQn3AGS0WQKR18yMATK7T/tGHV
         eYnKpRpiGoHZEqRFiEoStGxwd4IF0BRJ1RKp8KY6wszYNaWJfvb4E7VkpCqm6DKz1W6P
         8V5kscbipmSl9NYtc+am9nVzTzk5aHwDMC7Av2Bcvp/QFVNQlnwHU8Ks5OukM/87LfjE
         K/sW57CJn4mM93qpt3KY2gtT9Fiu6vSYEB8G7ehsBn9bHjxoGpCaudrDGp2jfBqQLS1L
         L6uQ==
X-Gm-Message-State: AOJu0YwKvc1KKFzQHH/C6TuirA1P61/cfOjyshGPgNWASIJiQzfOv6QS
        27X3QK52uOfWQnGYlqQoKQf5AhZCrvRje8ZxOWM=
X-Google-Smtp-Source: AGHT+IF1PdxjbshAZwpn/vM6CjAb0hjPNBNo+ktSuZ2lE0Wf9/gedMAWGiQ5D48xnMbr56I2JseWkmBq2ITcS7jgd9w=
X-Received: by 2002:a05:6122:4592:b0:4a4:680:bfad with SMTP id
 de18-20020a056122459200b004a40680bfadmr11294574vkb.7.1701079208944; Mon, 27
 Nov 2023 02:00:08 -0800 (PST)
MIME-Version: 1.0
References: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
 <20231127084217.13110-1-v-songbaohua@oppo.com> <bfebd80b-b60d-48e2-b350-7c0ac0299cda@arm.com>
In-Reply-To: <bfebd80b-b60d-48e2-b350-7c0ac0299cda@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 27 Nov 2023 22:59:57 +1300
Message-ID: <CAGsJ_4zMwxNw76bweq-23x5ibpWnERCCwg_kz3zn1pjzeY0qXw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:35=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 27/11/2023 08:42, Barry Song wrote:
> >>> +           for (i =3D 0; i < nr; i++, page++) {
> >>> +                   if (anon) {
> >>> +                           /*
> >>> +                            * If this page may have been pinned by t=
he
> >>> +                            * parent process, copy the page immediat=
ely for
> >>> +                            * the child so that we'll always guarant=
ee the
> >>> +                            * pinned page won't be randomly replaced=
 in the
> >>> +                            * future.
> >>> +                            */
> >>> +                           if (unlikely(page_try_dup_anon_rmap(
> >>> +                                           page, false, src_vma))) {
> >>> +                                   if (i !=3D 0)
> >>> +                                           break;
> >>> +                                   /* Page may be pinned, we have to=
 copy. */
> >>> +                                   return copy_present_page(
> >>> +                                           dst_vma, src_vma, dst_pte=
,
> >>> +                                           src_pte, addr, rss, preal=
loc,
> >>> +                                           page);
> >>> +                           }
> >>> +                           rss[MM_ANONPAGES]++;
> >>> +                           VM_BUG_ON(PageAnonExclusive(page));
> >>> +                   } else {
> >>> +                           page_dup_file_rmap(page, false);
> >>> +                           rss[mm_counter_file(page)]++;
> >>> +                   }
> >>>             }
> >>> -           rss[MM_ANONPAGES]++;
> >>> -   } else if (page) {
> >>> -           folio_get(folio);
> >>> -           page_dup_file_rmap(page, false);
> >>> -           rss[mm_counter_file(page)]++;
> >>> +
> >>> +           nr =3D i;
> >>> +           folio_ref_add(folio, nr);
> >>
> >> You're changing the order of mapcount vs. refcount increment. Don't.
> >> Make sure your refcount >=3D mapcount.
> >>
> >> You can do that easily by doing the folio_ref_add(folio, nr) first and
> >> then decrementing in case of error accordingly. Errors due to pinned
> >> pages are the corner case.
> >>
> >> I'll note that it will make a lot of sense to have batch variants of
> >> page_try_dup_anon_rmap() and page_dup_file_rmap().
> >>
> >
> > i still don't understand why it is not a entire map+1, but an increment
> > in each basepage.
>
> Because we are PTE-mapping the folio, we have to account each individual =
page.
> If we accounted the entire folio, where would we unaccount it? Each page =
can be
> unmapped individually (e.g. munmap() part of the folio) so need to accoun=
t each
> page. When PMD mapping, the whole thing is either mapped or unmapped, and=
 its
> atomic, so we can account the entire thing.

Hi Ryan,

There is no problem. for example, a large folio is entirely mapped in
process A with CONPTE,
and only page2 is mapped in process B.
then we will have

entire_map =3D 0
page0.map =3D -1
page1.map =3D -1
page2.map =3D 0
page3.map =3D -1
....

>
> >
> > as long as it is a CONTPTE large folio, there is no much difference wit=
h
> > PMD-mapped large folio. it has all the chance to be DoubleMap and need
> > split.
> >
> > When A and B share a CONTPTE large folio, we do madvise(DONTNEED) or an=
y
> > similar things on a part of the large folio in process A,
> >
> > this large folio will have partially mapped subpage in A (all CONTPE bi=
ts
> > in all subpages need to be removed though we only unmap a part of the
> > large folioas HW requires consistent CONTPTEs); and it has entire map i=
n
> > process B(all PTEs are still CONPTES in process B).
> >
> > isn't it more sensible for this large folios to have entire_map =3D 0(f=
or
> > process B), and subpages which are still mapped in process A has map_co=
unt
> > =3D0? (start from -1).
> >
> >> Especially, the batch variant of page_try_dup_anon_rmap() would only
> >> check once if the folio maybe pinned, and in that case, you can simply
> >> drop all references again. So you either have all or no ptes to proces=
s,
> >> which makes that code easier.
>
> I'm afraid this doesn't make sense to me. Perhaps I've misunderstood. But
> fundamentally you can only use entire_mapcount if its only possible to ma=
p and
> unmap the whole folio atomically.



My point is that CONTPEs should either all-set in all 16 PTEs or all are dr=
opped
in 16 PTEs. if all PTEs have CONT, it is entirely mapped; otherwise,
it is partially
mapped. if a large folio is mapped in one processes with all CONTPTEs
and meanwhile in another process with partial mapping(w/o CONTPTE), it is
DoubleMapped.

Since we always hold ptl to set or drop CONTPTE bits, set/drop is
still atomic in a
spinlock area.

>
> >>
> >> But that can be added on top, and I'll happily do that.
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >

Thanks
Barry
