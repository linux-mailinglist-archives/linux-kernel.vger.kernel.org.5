Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB40376F42C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjHCUrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjHCUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:47:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1D44AB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:47:02 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-407db3e9669so22571cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691095621; x=1691700421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBG66oV9M3i8nb1aREffuxZFPEb9Uhyo/aCShL7gQx8=;
        b=zCDXZdoqGLts5JkBxWgjTn7HX0P9lrbxt1E+j6GydaPp/EqpJODluHyNYUe+FFwAeJ
         EzHCj4QPdEePGFf0KC6ZwzKK45YkvBQwUjuowCS+t1wH4+nKlbknKjShxaOESs0/qRHr
         phQu4PvmRFinykx0kJKX6MspQvg9qUGliHnJ38O60m9W//ThV8B7b9T/sjZ5IxpgBCwj
         s66gczDYtX2fpEII7KiXVSOJnlpTwoMa2V4rtyMHvBtuahihXbiyZfObEETh1FEXTVYK
         VFeWH7movu/EY/2clu5iPSNQGCj0BVq/CUGb03ou4isJIbohFbsjGy90F8Q1Te3MDlRd
         ADeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691095621; x=1691700421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBG66oV9M3i8nb1aREffuxZFPEb9Uhyo/aCShL7gQx8=;
        b=IcRiShi9qbYYoPPsb0iJwuZ36uRVHtCVFkQ1I3T8rHyIZW6zPtfC/VVVYI9qDj32UD
         Q5qTQAZUE9RgcMAqkqKiu7GmAalCKUXOjLdsdz4b0amcEm4gEl50LFaZfvM0Uq6Zdfp6
         X9jATLUv7VI0WRs3IOdIVCYKdyoGGdJW8IGgpTsaWDHCF8+bzZ0KCJhA3qviQCpkZg0j
         eN/AIrPYa3WdV7IBzZW5i6HNniSf+THkp5uw3dqnXJ1LsEvb6yQrAu8aSBkXyQoVO2We
         oom5GgUg6f4E9aQo0SNXafz/5UYGoiU1b7kmbKO30MWq7BisInF6nehFuNjL6e6JxlcK
         7IrA==
X-Gm-Message-State: AOJu0Yxx/2/P/x4IOMjzxLr73NvOkEnGojUDOOHs9jx9h2TkmXXsvib9
        TjzNVhFU/ykU1wy+5XvQdOMGMpEEEW2tzvJnxqWM4A==
X-Google-Smtp-Source: AGHT+IEdgeMssYgkzrO6SBZ/o4UiOXS8RvE2r0xaLvZhKBjn7l5c7r2RpdmOKCQ427vYXukxwFiWZXjUggeonWTDg7I=
X-Received: by 2002:a05:622a:55:b0:3f2:1441:3c11 with SMTP id
 y21-20020a05622a005500b003f214413c11mr46781qtw.2.1691095621340; Thu, 03 Aug
 2023 13:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
 <3bbfde16-ced1-dca8-6a3f-da893e045bc5@arm.com> <56c8f4f9-b54b-b0bb-250c-ec8643accfc7@intel.com>
 <3541d2de-5cf8-2f84-8153-277e2bfc0101@arm.com> <5f98748a-97ca-6426-1e24-a5675da75381@intel.com>
 <a590da86-0c42-7d46-d320-c661a59a46c1@arm.com> <837ba176-c97f-f81b-c044-eb6aa3d88bb7@intel.com>
In-Reply-To: <837ba176-c97f-f81b-c044-eb6aa3d88bb7@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Aug 2023 14:46:23 -0600
Message-ID: <CAOUHufY9EQ70Pn-n2zVa9=Gm3-WHxxphp7VHia4qv9x2domdbg@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 6:56=E2=80=AFAM Yin, Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 8/2/2023 8:49 PM, Ryan Roberts wrote:
> > On 02/08/2023 13:42, Yin, Fengwei wrote:
> >>
> >>
> >> On 8/2/2023 8:40 PM, Ryan Roberts wrote:
> >>> On 02/08/2023 13:35, Yin, Fengwei wrote:
> >>>>
> >>>>
> >>>> On 8/2/2023 6:27 PM, Ryan Roberts wrote:
> >>>>> On 28/07/2023 17:13, Yin Fengwei wrote:
> >>>>>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(=
),
> >>>>>> folio_mapcount() is used to check whether the folio is shared. But=
 it's
> >>>>>> not correct as folio_mapcount() returns total mapcount of large fo=
lio.
> >>>>>>
> >>>>>> Use folio_estimated_sharers() here as the estimated number is enou=
gh.
> >>>>>>
> >>>>>> Yin Fengwei (2):
> >>>>>>   madvise: don't use mapcount() against large folio for sharing ch=
eck
> >>>>>>   madvise: don't use mapcount() against large folio for sharing ch=
eck
> >>>>>>
> >>>>>>  mm/huge_memory.c | 2 +-
> >>>>>>  mm/madvise.c     | 6 +++---
> >>>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>
> >>>>> As a set of fixes, I agree this is definitely an improvement, so:
> >>>>>
> >>>>> Reviewed-By: Ryan Roberts
> >>>> Thanks.
> >>>>
> >>>>>
> >>>>>
> >>>>> But I have a couple of comments around further improvements;
> >>>>>
> >>>>> Once we have the scheme that David is working on to be able to prov=
ide precise
> >>>>> exclusive vs shared info, we will probably want to move to that. Al=
though that
> >>>>> scheme will need access to the mm_struct of a process known to be m=
apping the
> >>>>> folio. We have that info, but its not passed to folio_estimated_sha=
rers() so we
> >>>>> can't just reimplement folio_estimated_sharers() - we will need to =
rework these
> >>>>> call sites again.
> >>>> Yes. This could be extra work. Maybe should delay till David's work =
is done.
> >>>
> >>> What you have is definitely an improvement over what was there before=
. And is
> >>> probably the best we can do without David's scheme. So I wouldn't del=
ay this.
> >>> Just pointing out that we will be able to make it even better later o=
n (if
> >>> David's stuff goes in).
> >> Yes. I agree that we should wait for David's work ready and do fix bas=
ed on that.
> >
> > I was suggesting the opposite - not waiting. Then we can do separate im=
provement
> > later.
> Let's wait for David's work ready.

Waiting is fine as long as we don't miss the next merge window -- we
don't want these two bugs to get into another release. Also I think we
should cc stable, since as David mentioned, they have been causing
selftest failures.
