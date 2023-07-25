Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25989760927
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGYFW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGYFW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:22:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A03A6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:22:53 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so190321cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690262573; x=1690867373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY+1xbPxNkFP+3LBebcLpH4YNa6U3rIKa7VhFfz0qD0=;
        b=GOGBZJ4slEjppt1kv078jezT7qk0WPKcKJZ9mviuJxxuP4RwMUFRyxjNFCWVCSyM0e
         vQN2eGLro43tzAlpARzR9GfH/7mKHjjLJeyegz4lljSxm9o+yffK6XiMFynpYSqv0y0B
         fb2gAAEuP4dECvd9VpIv2EuwxVZBCgepKFmdtZdAGnx13Hz8sK5Lh97s8Gsnm2+/wbS9
         dDzmwjm89Gb1r8vrpTRs5V+aayo7IpDP7Fi419yJGzMZXsVZDT4j6zpeWkJ9nyz/Enoz
         R1boZ9sNKSMmqdrG9VKKojAg0/vsVaQdVFj0CwwXCnEh/zqe92cNVHw6ltoBzQilvI2I
         ZBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690262573; x=1690867373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY+1xbPxNkFP+3LBebcLpH4YNa6U3rIKa7VhFfz0qD0=;
        b=hZVYLgJ1ymOYZTmdtcmTItIhQt9jwocGSCaKxKxHycbG43Fn+K2NmN7kcQt0jekUPQ
         Txu0Rfzb/fcWOQvTj0ysqMaK7tehbc0xQiq9cHsX5wC6sNC26Hrqe3QBNx3Z+ctyrS0b
         aGcRR13MwDbaZud6wYIq1E6D7WUOnCI0ZZAAgzgCViAbGudH38B8pHDgZb+XRlLErNYN
         3ea0a+gEyP+ZmFfyRAj83pkM6MrBZWsAd5VmU0QBIFsf5s7K2TCaBS740jFJwGVnQvKV
         cReqo1FkZCyGAztJ6hUi8AzaNEWKql96EJPYe2qsBSx+Sj+sczLCtVwyojnd/gkAyE4H
         LeVg==
X-Gm-Message-State: ABy/qLYX9ZxFZD6kWkR2H4Ao3njqSqUDDB1yYnx7yawYzAFC17y1Br1e
        gG5rMsCw83NTM/NX5rDkFFrmYVmXUg7U8J/XrE6Mug==
X-Google-Smtp-Source: APBJJlGXl38AIBCxI+gAPDOq7kVP63ezo9ZpB9gUdDZ9ohmaYamCQePEpqUqe9YRHsaM5M+c3ldEpTtHiYY7pKmhkPg=
X-Received: by 2002:a05:622a:104d:b0:3ed:86f6:6eab with SMTP id
 f13-20020a05622a104d00b003ed86f66eabmr95579qte.14.1690262572894; Mon, 24 Jul
 2023 22:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
 <20230721094043.2506691-2-fengwei.yin@intel.com> <CAOUHufY0AX_wyBCZ3dNMfTg7C1ZBOZHpYSgG=uOwbeeemyFX6Q@mail.gmail.com>
 <cd64f4f5-e77b-d51d-637e-51cf8dba8277@intel.com>
In-Reply-To: <cd64f4f5-e77b-d51d-637e-51cf8dba8277@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 24 Jul 2023 23:22:16 -0600
Message-ID: <CAOUHufbnsPhjX2nD95dXQmRokHRSZ3hQAmhcVymO9qXUJ-2xpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] madvise: not use mapcount() against large
 folio for sharing check
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
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

On Sun, Jul 23, 2023 at 6:27=E2=80=AFAM Yin, Fengwei <fengwei.yin@intel.com=
> wrote:
>
>
>
> On 7/22/2023 2:57 AM, Yu Zhao wrote:
> > On Fri, Jul 21, 2023 at 3:41=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >> The commit
> >> 07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range() to
> >> use folios") replaced the page_mapcount() with folio_mapcount() to
> >> check whether the folio is shared by other mapping.
> >>
> >> But it's not correct for large folio. folio_mapcount() returns the
> >> total mapcount of large folio which is not suitable to detect whether
> >> the folio is shared.
> >>
> >> Use folio_estimated_sharers() which returns a estimated number of
> >> shares. That means it's not 100% correct. But it should be OK for
> >> madvise case here.
> >>
> >> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> >
> > Fixes:
> > Cc: stable
> OK
>
> >
> >> @@ -383,7 +383,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >>                 folio =3D pfn_folio(pmd_pfn(orig_pmd));
> >>
> >>                 /* Do not interfere with other mappings of this folio =
*/
> >> -               if (folio_mapcount(folio) !=3D 1)
> >> +               if (folio_estimated_sharers(folio) !=3D 1)
> >
> > Strictly speaking, this isn't a bug. But it may be ok to include it in
> > the same patch.
> OK. I will drop the change for pmd.
>
> >
> >>                         goto huge_unlock;
> >>
> >>                 if (pageout_anon_only_filter && !folio_test_anon(folio=
))
> >> @@ -459,7 +459,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >>                 if (folio_test_large(folio)) {
> >>                         int err;
> >>
> >> -                       if (folio_mapcount(folio) !=3D 1)
> >> +                       if (folio_estimated_sharers(folio) !=3D 1)
> >>                                 break;
> >>                         if (pageout_anon_only_filter && !folio_test_an=
on(folio))
> >>                                 break;
> >> @@ -682,7 +682,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsi=
gned long addr,
> >
> > What about madvise_free_huge_pmd()? Should it be changed as well so
> > that it's consistent with the first change? Either change both or neith=
er.
> >
> >>                 if (folio_test_large(folio)) {
> >>                         int err;
> >>
> >> -                       if (folio_mapcount(folio) !=3D 1)
> >> +                       if (folio_estimated_sharers(folio) !=3D 1)
> >
> > This is another bug fix and should be in a separate patch.
> OK. Will split to two patches.
>
> >
> >>                                 break;
> >>                         if (!folio_trylock(folio))
> >>                                 break;
> >
> > Please send two separate fixes, and then:
> >
> > Reviewed-by: Yu Zhao <yuzhao@google.com>
> Thanks a lot. I will drop the mapcount() change for pmd and sent to patch=
es
> for madvise_cold_or_pageout_pte_range() and madvise_free_pte_range().

I don't mind including the PMD changes. Either way works for me :)
