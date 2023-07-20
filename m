Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2975A309
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGTADP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGTADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:03:13 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB502101
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:03:05 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4036bd4fff1so133381cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689811384; x=1690416184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AIdRrjXrsWcvUmbKux+wDH4PpMCO/1EThAv+qoaH/I=;
        b=lt14aI2qGCqGr/TnNm8djd6ephL8HCBQbXQYmuI8+6oDCVJ+zkWhw5fljzm7GQ+vIZ
         rQG9Y1YVwH6J13YZ/odaWPVemp4+MNLKSfuplt64XqQgMbTWsf4lokKBVHy+gmRg9php
         ga4s8NiHFYWokg8+gPL9plRZYfbriDOj21s9GqHiio+Bim72N66G4YKi30i5Hcv6dh/Y
         X2hKCqRfdHPUizPy+S5ZwiTjDC0SqyeP3z5HTfvgocV9yRkVGXSav8HFtAJXbZtmyLTl
         bE/8f1BlqbmblAQnlGX2IBS5FSzx8ULwLSmzU+onJoq3jpwOwYizdPdAsh83+6pMT3Qw
         Cksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689811384; x=1690416184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AIdRrjXrsWcvUmbKux+wDH4PpMCO/1EThAv+qoaH/I=;
        b=LJb+H+VeeIMdcQz9vVTymE7ZHsNtFAuxncADEyUSICXqy7j5qc0NBFv3CByIVg52lS
         iFy2ZBchic4LZRfTNd9o3DU98Cd7asMmiUSSz5qYgPhLg7yeuw0I16oSeb3Qh5tR7BhN
         x6erUNUiQ5DCRo/XUNVdwKnDKaZ4qsaCMom4jFghDt7hRgXQ+W5ndbTL3X7mT6u0Xoo2
         DxpLD0GyAJRRTow/y5SR58/+1Mkf+7WTPsCluxyDxBsZ4extZOMe3tDwTCDLS7dQXbbZ
         Dh5Rsnone/2i3uRWCznCNy3yqXFq1A1OtpNGIP6dgWnfi9TmEpjniia6OHaVYmCW5EuB
         xAgQ==
X-Gm-Message-State: ABy/qLaC7rd0onsRx8OQ676AJ12ZxmcSammG9qZRTnrUrmOuKYHvXogj
        2XNLvPhjuY37YB7X1jC3hOBkNctd9GSAca1T1iW4OA==
X-Google-Smtp-Source: APBJJlEG3jZz9gqjPlQZ08HPYNLMUX5FmZrlaAtJV6SjjVGQ2ekjzuGennDxJOZV/STQZpE3vYABW4WMEcE8hiKZlTU=
X-Received: by 2002:a05:622a:1344:b0:3f8:8c06:c53b with SMTP id
 w4-20020a05622a134400b003f88c06c53bmr118687qtk.0.1689811384194; Wed, 19 Jul
 2023 17:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
 <20230718004942.113174-3-mike.kravetz@oracle.com> <CADrL8HVfBCmNYL5pM_LyHQNWyvihK=_GFnbtWB0tpTuLgiDybw@mail.gmail.com>
 <20230718164646.GA10413@monkey>
In-Reply-To: <20230718164646.GA10413@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 19 Jul 2023 17:02:26 -0700
Message-ID: <CADrL8HU9QbtU=Rs7jCVgOw-ykv1DTQukBiZwqVi16dVdcadG0A@mail.gmail.com>
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

On Tue, Jul 18, 2023 at 9:47=E2=80=AFAM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 07/18/23 09:31, James Houghton wrote:
> > On Mon, Jul 17, 2023 at 5:50=E2=80=AFPM Mike Kravetz <mike.kravetz@orac=
le.com> wrote:
> > > +        * destructor of all pages on list.
> > > +        */
> > > +       if (clear_dtor) {
> > > +               spin_lock_irq(&hugetlb_lock);
> > > +               list_for_each_entry(page, list, lru)
> > > +                       __clear_hugetlb_destructor(h, page_folio(page=
));
> > > +               spin_unlock_irq(&hugetlb_lock);
> > >         }
> >
> > I'm not too familiar with this code, but the above block seems weird
> > to me. If we successfully allocated the vmemmap for *any* folio, we
> > clear the hugetlb destructor for all the folios? I feel like we should
> > only be clearing the hugetlb destructor for all folios if the vmemmap
> > allocation succeeded for *all* folios. If the code is functionally
> > correct as is, I'm a little bit confused why we need `clear_dtor`; it
> > seems like this function doesn't really need it. (I could have some
> > huge misunderstanding here.)
> >
>
> Yes, it is a bit strange.
>
> I was thinking this has to also handle the case where hugetlb vmemmap
> optimization is off system wide.  In that case, clear_dtor would never
> be set and there is no sense in ever walking the list and calling
> __clear_hugetlb_destructor() would would be a NOOP in this case.  Think
> of the case where there are TBs of hugetlb pages.
>
> That is one of the reasons I made __clear_hugetlb_destructor() check
> for the need to modify the destructor.  The other reason is in the
> dissolve_free_huge_page() code path where we allocate vmemmap.  I
> suppose, there could be an explicit call to __clear_hugetlb_destructor()
> in dissolve_free_huge_page.  But, I thought it might be better if
> we just handled both cases here.
>
> My thinking is that the clear_dtor boolean would tell us if vmemmap was
> restored for ANY hugetlb page.  I am aware that just because vmemmap was
> allocated for one page, does not mean that it was allocated for others.
> However, in the common case where hugetlb vmemmap optimization is on
> system wide, we would have allocated vmemmap for all pages on the list
> and would need to clear the destructor for them all.
>
> So, clear_dtor is really just an optimization for the
> hugetlb_free_vmemmap=3Doff case.  Perhaps that is just over thinking and
> not a useful miro-optimization.

Ok I think I understand; I think the micro-optimization is fine to
add. But I think there's still a bug here:

If we have two vmemmap-optimized hugetlb pages and restoring the page
structs for one of them fails, that page will end up with the
incorrect dtor (add_hugetlb_folio will set it properly, but then we
clear it afterwards because clear_dtor was set).

What do you think?
