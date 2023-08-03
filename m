Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915CF76F630
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjHCXit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjHCXiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:38:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179CC3A8C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:38:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so5508a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691105920; x=1691710720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF9Fv1UjGToa7ovm9kjlJdHk4E7DdWLIDqHPV63VLII=;
        b=tU2QLiE1TKfSuhJ9emNqRap40N0ZD9zGGhFakPKtTMigp0fVMGq6TIVV+XHU+4djDq
         aL/BcjwOYuYBMpSqV2qrU4AgPoSrJY0ae+dRHbhkoqVeEZkrUjVivhleeIh9kNClMdnC
         EfWZjjvyLzTSFDVGN52sAUJE7WDB9k6q6js5crFFvSp1Xfw30ze5WC84iAEV6e5M/Xbp
         aqN8QDDrZN3Q7BFb3ZxNJfIiCn23fXdz4qE4UIdekAUSIdFwbILidpdPVsHzAuRzHtfb
         IU0BiN6nJOsLbYlVF763PFsBeZxuxJKLoadikBY8ozt7C8uAdKC4S6GSFvH4wiK/JJeR
         FP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691105920; x=1691710720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HF9Fv1UjGToa7ovm9kjlJdHk4E7DdWLIDqHPV63VLII=;
        b=dZ3dBtn9Cx4n0Ve5FILtW/j3QDLOSkvODU47eGznRNASaWAPIWhWuJvJIeKBNM/q0y
         qto9/R9RUI+krnT+MOBKpdtWSmJOxA15TyZtSMHUNv3AdByK8RtqaW9cePjcNw0OmjbI
         pFfquEQZwWI7MPCx87lVGl2JOrVT8Vo6GHL9mZNH8n2yNoSdSD5tXMsUSCBnZLM8Xln2
         jWLjdq2yFzjPujQFaSuSFX7bMF/bpNnOjIyrE5/AGPG0f5fH+viwfBuc/BDz4/HSlmgz
         tQlDfr7mKvgTIcoqDf1y5FaP4qExb/nlAOBZe9XgTo1Cub7R+5Fda/X0z2AzzSL2tIxc
         U3cA==
X-Gm-Message-State: AOJu0YyMOcgMBi5/Zd/OHZLqCbst5KkcShWbW/zVbOtItOglOtEj2Dac
        8Ppoeku9mkWUnwS7cneZbZF8jGMAPIdMRx0rqinOKRTgj4CsT5k/ZasWRNyZ
X-Google-Smtp-Source: AGHT+IE8BzcvliGOfpZKZFRaXciucYbDm1vicS2CnPG5JaIqDBHOujD2OJYpt2YbaYt+JeZDnJ0h3dp/UPet8hikz7s=
X-Received: by 2002:a50:bb41:0:b0:522:28a1:2095 with SMTP id
 y59-20020a50bb41000000b0052228a12095mr7144ede.3.1691105920421; Thu, 03 Aug
 2023 16:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com> <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com> <5f98748a-97ca-6426-1e24-a5675da75381@intel.com>
 <a590da86-0c42-7d46-d320-c661a59a46c1@arm.com> <837ba176-c97f-f81b-c044-eb6aa3d88bb7@intel.com>
 <CAOUHufY9EQ70Pn-n2zVa9=Gm3-WHxxphp7VHia4qv9x2domdbg@mail.gmail.com> <40d49276-fae9-e538-61cf-64bb79233bc3@intel.com>
In-Reply-To: <40d49276-fae9-e538-61cf-64bb79233bc3@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Aug 2023 17:38:00 -0600
Message-ID: <CAOUHufbcAJWUoVuCYtaDZKdcw+JPWVV0EiB=JcDvz1Jt_Au2Tw@mail.gmail.com>
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        minchan@kernel.org, david@redhat.com, shy828301@gmail.com
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

On Thu, Aug 3, 2023 at 5:27=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 8/4/2023 4:46 AM, Yu Zhao wrote:
> > On Wed, Aug 2, 2023 at 6:56=E2=80=AFAM Yin, Fengwei <fengwei.yin@intel.=
com> wrote:
> >>
> >>"
> >>
> >> On 8/2/2023 8:49 PM, Ryan Roberts wrote:
> >>> On 02/08/2023 13:42, Yin, Fengwei wrote:
> >>>>
> >>>>
> >>>> On 8/2/2023 8:40 PM, Ryan Roberts wrote:
> >>>>> On 02/08/2023 13:35, Yin, Fengwei wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
> >>>>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
> >>>>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_rang=
e(),
> >>>>>>>> folio_mapcount() is used to check whether the folio is shared. B=
ut it's
> >>>>>>>> not correct as folio_mapcount() returns total mapcount of large =
folio.
> >>>>>>>>
> >>>>>>>> Use folio_estimated_sharers() here as the estimated number is en=
ough.
> >>>>>>>>
> >>>>>>>> Yin Fengwei (2):
> >>>>>>>>   madvise: don't use mapcount() against large folio for sharing =
check
> >>>>>>>>   madvise: don't use mapcount() against large folio for sharing =
check
> >>>>>>>>
> >>>>>>>>  mm/huge_memory.c | 2 +-
> >>>>>>>>  mm/madvise.c     | 6 +++---
> >>>>>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>>> As a set of fixes, I agree this is definitely an improvement, so:
> >>>>>>>
> >>>>>>> Reviewed-By: Ryan Roberts
> >>>>>> Thanks.
> >>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> But I have a couple of comments around further improvements;
> >>>>>>>
> >>>>>>> Once we have the scheme that David is working on to be able to pr=
ovide precise
> >>>>>>> exclusive vs shared info, we will probably want to move to that. =
Although that
> >>>>>>> scheme will need access to the mm_struct of a process known to be=
 mapping the
> >>>>>>> folio. We have that info, but its not passed to folio_estimated_s=
harers() so we
> >>>>>>> can't just reimplement folio_estimated_sharers() - we will need t=
o rework these
> >>>>>>> call sites again.
> >>>>>> Yes. This could be extra work. Maybe should delay till David's wor=
k is done.
> >>>>>
> >>>>> What you have is definitely an improvement over what was there befo=
re. And is
> >>>>> probably the best we can do without David's scheme. So I wouldn't d=
elay this.
> >>>>> Just pointing out that we will be able to make it even better later=
 on (if
> >>>>> David's stuff goes in).
> >>>> Yes. I agree that we should wait for David's work ready and do fix b=
ased on that.
> >>>
> >>> I was suggesting the opposite - not waiting. Then we can do separate =
improvement
> >>> later.
> >> Let's wait for David's work ready.
> >
> > Waiting is fine as long as we don't miss the next merge window -- we
> > don't want these two bugs to get into another release. Also I think we
> > should cc stable, since as David mentioned, they have been causing
> > selftest failures.
>
> Stable was CCed.

Need to add the "Cc: stable@vger.kernel.org" tag:
Documentation/process/stable-kernel-rules.rst
