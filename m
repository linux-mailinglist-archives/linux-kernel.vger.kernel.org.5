Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2375A3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGTAvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGTAvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:51:10 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4682103
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:51:06 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4036bd4fff1so144621cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689814266; x=1690419066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kdQ2CwwG9UjpnaQCd8BdaEAGWs9rZsSy7Glrcwdhwk=;
        b=xFeMX19HpDkoRigR98WG2haHY3z5bbIEzqKOM2yJXNVMbRa4ODdpqVuBPVP67JvnRU
         qV74fH9n5I9UMhK6gBEghXrg+RpC51vxjml1xnmyKwDk46VLkzJFWPbF3ajUjmPShJiz
         SkmwlaRdGP6ikXvOBjCNEMleZXsdtA7OPk4J8uQPy8kPjTcWuuf+ikbdllwURzDSVnip
         JmSaWomq39qFh0l/mYmMNXDmPIZg1ptRuC4F3uaZDggeVQqBhggkwCxOifUxc8KL+z6l
         CrqqTlB5FhhzgFX4Wn9VA/pDc1m0omxgDnxwZD9tj5abyWmzXRT2tqeOGxwToXMC6p0/
         3QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689814266; x=1690419066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kdQ2CwwG9UjpnaQCd8BdaEAGWs9rZsSy7Glrcwdhwk=;
        b=RNE3BQlEwJj45sHFUds+Jj/OEccWe8z4LFKXPhfMBUIn3js8UfA26kzcnEh4WWBhsD
         dQKRJsRoTsCCYcwe5ZN8MwVt/OlZa/pV5B+gf18t5MH+bgpz4pcbWaC9sdNLpbfNTNPQ
         5lLaELwUWoPeFjpiHRZhKKum43GtUU5w/Xv4zF4BacU7mKnK/bwZnP49xtLv/rRVEmuX
         VKCnO7vk/s8Gg1aCPh8FpV/QV94pTkHDcIjQN0dLa2LJhvq9Dh18mnVWd9dqGqvvSjoM
         LLRjsIt4BCcfCvWCPDE1E+zQy3jrsbYIAVjPkeeLhFDDK0yXWpmSptnNPvBRhDiYttUd
         ixJw==
X-Gm-Message-State: ABy/qLZatoKqxEaV3CgmM/JIBTEiR5E+MN4MJDokFhWB722FnbdnhXT9
        gsxrRcn+IUFeccd8rh33pX/iWUJ8jsa5CLSU1oDIOodW6mhEIXf2D5BVkQ==
X-Google-Smtp-Source: APBJJlEvOB5bNjVvvhWpTSflzrE9FfY4DePH6+LlQmP55VhhOWiri2AvfecL8FBHdaL3dJpNphIyWhnsPTljriX9XkM=
X-Received: by 2002:a05:622a:1a93:b0:404:132d:1127 with SMTP id
 s19-20020a05622a1a9300b00404132d1127mr61896qtc.19.1689814265808; Wed, 19 Jul
 2023 17:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
 <20230718004942.113174-3-mike.kravetz@oracle.com> <CADrL8HVfBCmNYL5pM_LyHQNWyvihK=_GFnbtWB0tpTuLgiDybw@mail.gmail.com>
 <20230718164646.GA10413@monkey> <CADrL8HU9QbtU=Rs7jCVgOw-ykv1DTQukBiZwqVi16dVdcadG0A@mail.gmail.com>
 <20230720001833.GE3240@monkey>
In-Reply-To: <20230720001833.GE3240@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 19 Jul 2023 17:50:28 -0700
Message-ID: <CADrL8HXt84JGo_dTYfY_zuM8-Cxdh1rcqLUUswTabd=67JM4TQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hugetlb: optimize update_and_free_pages_bulk to
 avoid lock cycles
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Jul 19, 2023 at 5:19=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 07/19/23 17:02, James Houghton wrote:
> > On Tue, Jul 18, 2023 at 9:47=E2=80=AFAM Mike Kravetz <mike.kravetz@orac=
le.com> wrote:
> > >
> > > On 07/18/23 09:31, James Houghton wrote:
> > > > On Mon, Jul 17, 2023 at 5:50=E2=80=AFPM Mike Kravetz <mike.kravetz@=
oracle.com> wrote:
> > > > > +        * destructor of all pages on list.
> > > > > +        */
> > > > > +       if (clear_dtor) {
> > > > > +               spin_lock_irq(&hugetlb_lock);
> > > > > +               list_for_each_entry(page, list, lru)
> > > > > +                       __clear_hugetlb_destructor(h, page_folio(=
page));
> > > > > +               spin_unlock_irq(&hugetlb_lock);
> > > > >         }
> > > >
> > > > I'm not too familiar with this code, but the above block seems weir=
d
> > > > to me. If we successfully allocated the vmemmap for *any* folio, we
> > > > clear the hugetlb destructor for all the folios? I feel like we sho=
uld
> > > > only be clearing the hugetlb destructor for all folios if the vmemm=
ap
> > > > allocation succeeded for *all* folios. If the code is functionally
> > > > correct as is, I'm a little bit confused why we need `clear_dtor`; =
it
> > > > seems like this function doesn't really need it. (I could have some
> > > > huge misunderstanding here.)
> > > >
> > >
> > > Yes, it is a bit strange.
> > >
> > > I was thinking this has to also handle the case where hugetlb vmemmap
> > > optimization is off system wide.  In that case, clear_dtor would neve=
r
> > > be set and there is no sense in ever walking the list and calling
> > > __clear_hugetlb_destructor() would would be a NOOP in this case.  Thi=
nk
> > > of the case where there are TBs of hugetlb pages.
> > >
> > > That is one of the reasons I made __clear_hugetlb_destructor() check
> > > for the need to modify the destructor.  The other reason is in the
> > > dissolve_free_huge_page() code path where we allocate vmemmap.  I
> > > suppose, there could be an explicit call to __clear_hugetlb_destructo=
r()
> > > in dissolve_free_huge_page.  But, I thought it might be better if
> > > we just handled both cases here.
> > >
> > > My thinking is that the clear_dtor boolean would tell us if vmemmap w=
as
> > > restored for ANY hugetlb page.  I am aware that just because vmemmap =
was
> > > allocated for one page, does not mean that it was allocated for other=
s.
> > > However, in the common case where hugetlb vmemmap optimization is on
> > > system wide, we would have allocated vmemmap for all pages on the lis=
t
> > > and would need to clear the destructor for them all.
> > >
> > > So, clear_dtor is really just an optimization for the
> > > hugetlb_free_vmemmap=3Doff case.  Perhaps that is just over thinking =
and
> > > not a useful miro-optimization.
> >
> > Ok I think I understand; I think the micro-optimization is fine to
> > add. But I think there's still a bug here:
> >
> > If we have two vmemmap-optimized hugetlb pages and restoring the page
> > structs for one of them fails, that page will end up with the
> > incorrect dtor (add_hugetlb_folio will set it properly, but then we
> > clear it afterwards because clear_dtor was set).
> >
> > What do you think?
>
> add_hugetlb_folio() will call enqueue_hugetlb_folio() which will move
> the  folio from the existing list we are processing to the hugetlb free
> list.  Therefore, the page for which we could not restore vmemmap is not
> on the list for that 'if (clear_dtor)' block of code.

Oh, I see. Thanks! Unless you think it's pretty obvious, perhaps a
comment would be good to add here, to explain that folios are removed
from 'list' if their vmemmap isn't restored.

Unrelated nit: I think you mean to use
folio_test_hugetlb_vmemmap_optimized instead of HPageVmemmapOptimized
in this patch.

Feel free to add:

Acked-by: James Houghton <jthoughton@google.com>


>
> --
> Mike Kravetz
