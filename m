Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C568790176
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbjIAR33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIAR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:29:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E2E5A;
        Fri,  1 Sep 2023 10:29:16 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-56b2e689968so1583080a12.0;
        Fri, 01 Sep 2023 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693589356; x=1694194156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NouKehUZ1/ja07DRWOckLtQmRtHkQt8ow3jpBfelpLc=;
        b=OJrIDQC6gBUgvaAH+HtWcDGzwSU1+rpWvHACd9qkZc4vwfm7/BvAnJwSX/4C2qZnLi
         7idV2tyeKGulbdTLl4u2+xUrgp9EHz8Hd79yaNi/w0xQdkot46JCK8DztcZuwR0khbFi
         bEH2x2ur+zz1smHREqillGCZjxssGk6uA6kOI1Z6puJ/gd5w7eQv4CiPXQJf/sc9vkaF
         566CjkY2I6JrCLG2ubvo7XnOnYbmCAoEnaur7qqRqR72xi3i0qtLkZMjTJRlMfahGPmR
         YDb8DOqDTgvIOVq768f2d3iVADZSfuohwqxH0r1rjJPjsPMrHTJINpKoiGu3OE48lQ57
         QemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693589356; x=1694194156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NouKehUZ1/ja07DRWOckLtQmRtHkQt8ow3jpBfelpLc=;
        b=hxhNtfquzuQhRNGtnpcBBS+YaCZDHQe7NSN5d5BSm12ebom+Sc16KtIWPYABFaW4Eo
         NZOmlA6tiaHyYsGMH7DvUuypHdArCywyHqc4OaCjzdb5D8XPHUaDUDoLs0r77rD4l/U4
         vNxEGAfeeSlPW8pjQFf3lnrlBLfsJZWqi4IULjWoFkQf/NnA1iUoLnW4Pzc4e3+hLgUQ
         nRHTikFAr5T7wvKii7y/mxaUQWmhU6pVXlu5Tok2g266RttbEnPy32a67CS/cPzOfBdo
         wJILXBu39QLQUXu4Jkmj4NdKbKlaIJ7aZiz+MFhnLe9bdaAxPrBa8V30yquL1i54VtmX
         paDw==
X-Gm-Message-State: AOJu0YzPafgrEFJ7u6njsEWR0MBTHEiQ8KAtFiwnsBboPKKpwroMG66A
        YfhXh98R8TXVPB2cC6AzABbUdLNf5FzSA6wN9syiPnxj
X-Google-Smtp-Source: AGHT+IHCD/btXitk61S80sfG4nrcWxOI8Bma2QDgeMeK2+90bnvuVn1s+/5lUQf8Q+C6mRfhybCuIzBe05vJ5jmnlds=
X-Received: by 2002:a17:90a:e015:b0:26d:1f85:556 with SMTP id
 u21-20020a17090ae01500b0026d1f850556mr2997550pjy.45.1693589356045; Fri, 01
 Sep 2023 10:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230817035155.84230-1-liusong@linux.alibaba.com>
 <CAHbLzkrUQ2i0jtgiDf25t_VD4W8hm3jZvd=N=dTyCqvFXc8Q1g@mail.gmail.com> <e0088370-1ff9-a8df-65a6-bc4ae393b4dc@linux.alibaba.com>
In-Reply-To: <e0088370-1ff9-a8df-65a6-bc4ae393b4dc@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 1 Sep 2023 10:29:04 -0700
Message-ID: <CAHbLzkrBg9AE7tQFQj-TeUOEr=8FoLg+CH9MCfcJDkEaZ72-bA@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: increase transparent_hugepage_recommend_disable
 parameter to disable active modification of min_free_kbytes
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, rostedt@goodmis.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 7:30=E2=80=AFAM Liu Song <liusong@linux.alibaba.com=
> wrote:
>
> =E5=9C=A8 2023/8/30 04:04, Yang Shi =E5=86=99=E9=81=93:
>
> > On Wed, Aug 16, 2023 at 8:52=E2=80=AFPM Liu Song <liusong@linux.alibaba=
.com> wrote:
> >> In the arm64 environment, when PAGESIZE is 4K, the "pageblock_nr_pages=
"
> >> value is 512, and the recommended min_free_kbytes in
> >> "set_recommended_min_free_kbytes" usually does not exceed 44MB.
> >>
> >> However, when PAGESIZE is 64K, the "pageblock_nr_pages" value is 8192,
> >> and the recommended min_free_kbytes in "set_recommended_min_free_kbyte=
s"
> >> is 8192 * 2 * (2 + 9) * 64K, which directly increases to 11GB.
> >>
> >> According to this calculation method, due to the modification of min_f=
ree_kbytes,
> >> the reserved memory in my 128GB memory environment reaches 10GB, and M=
emAvailable
> >> is correspondingly reduced by 10GB.
> >>
> >> In the case of PAGESIZE 64K, transparent hugepages are 512MB, and we o=
nly
> >> need them to be used on demand. If transparent hugepages cannot be all=
ocated,
> >> falling back to regular 64K pages is completely acceptable.
> >>
> >> Therefore, we added the transparent_hugepage_recommend_disable paramet=
er
> >> to disable active modification of min_free_kbytes, thereby meeting our
> >> requirements for transparent hugepages in the 64K scenario, and it wil=
l
> >> not excessively reduce the available memory.
> > Thanks for debugging this. I agree 11GB for min_free_kbytes is too
> > much. But a kernel parameter sounds overkilling to me either. IMHO we
> > just need to have a better scaling for bigger base page size. For
> > example, we just keep one or two pageblock for min_free_kbytes when
> > the base page size is bigger than 4K.
> >
> Thank you very much for your advice, but how do we determine the number
> of pageblocks?

TBH, I can't tell. I don't have a magic number...

> This is a difficult number to determine. When PAGESIZE is 64K, arm64
> supports hugepages
> of 2M, 512M, and 16G, which can meet the requirements of scenarios that
> require hugepages.
>
> However, transparent huge pages can only support 512M, and 512M is a
> very large number, so
> enabling transparent huge pages should be carefully considered, not to
> mention whether it makes
> sense to reserve such a large amount of memory.
>
> Therefore, I think that in the scenario of 64K PAGESIZE, it might also
> be a good choice to directly
> cancel set_recommended_min_free_kbytes?

It should be ok too. There shouldn't be too many real life workloads
running with this configuration other than some Java users may run
some workloads with 64K base page + THP AFAIK. But it should be not
very common.

>
> Thanks
>
>
> >> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> >> ---
> >>   .../admin-guide/kernel-parameters.txt         |  5 +++++
> >>   mm/khugepaged.c                               | 20 +++++++++++++++++=
+-
> >>   2 files changed, 24 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documen=
tation/admin-guide/kernel-parameters.txt
> >> index 654d0d921101..612bdf601cce 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -6553,6 +6553,11 @@
> >>                          See Documentation/admin-guide/mm/transhuge.rs=
t
> >>                          for more details.
> >>
> >> +       transparent_hugepage_recommend_disable
> >> +                       [KNL,THP]
> >> +                       Can be used to disable transparent hugepage to=
 actively modify
> >> +                       /proc/sys/vm/min_free_kbytes during enablement=
 process.
> >> +
> >>          trusted.source=3D [KEYS]
> >>                          Format: <string>
> >>                          This parameter identifies the trust source as=
 a backend
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index 78fc1a24a1cc..ac40c618f4f6 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -88,6 +88,9 @@ static unsigned int khugepaged_max_ptes_none __read_=
mostly;
> >>   static unsigned int khugepaged_max_ptes_swap __read_mostly;
> >>   static unsigned int khugepaged_max_ptes_shared __read_mostly;
> >>
> >> +/* default enable recommended */
> >> +static unsigned int transparent_hugepage_recommend __read_mostly =3D =
1;
> >> +
> >>   #define MM_SLOTS_HASH_BITS 10
> >>   static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BIT=
S);
> >>
> >> @@ -2561,6 +2564,11 @@ static void set_recommended_min_free_kbytes(voi=
d)
> >>                  goto update_wmarks;
> >>          }
> >>
> >> +       if (!transparent_hugepage_recommend) {
> >> +               pr_info("do not allow to recommend modify min_free_kby=
tes\n");
> >> +               return;
> >> +       }
> >> +
> >>          for_each_populated_zone(zone) {
> >>                  /*
> >>                   * We don't need to worry about fragmentation of
> >> @@ -2591,7 +2599,10 @@ static void set_recommended_min_free_kbytes(voi=
d)
> >>
> >>          if (recommended_min > min_free_kbytes) {
> >>                  if (user_min_free_kbytes >=3D 0)
> >> -                       pr_info("raising min_free_kbytes from %d to %l=
u to help transparent hugepage allocations\n",
> >> +                       pr_info("raising user specified min_free_kbyte=
s from %d to %lu to help transparent hugepage allocations\n",
> >> +                               min_free_kbytes, recommended_min);
> >> +               else
> >> +                       pr_info("raising default min_free_kbytes from =
%d to %lu to help transparent hugepage allocations\n",
> >>                                  min_free_kbytes, recommended_min);
> >>
> >>                  min_free_kbytes =3D recommended_min;
> >> @@ -2601,6 +2612,13 @@ static void set_recommended_min_free_kbytes(voi=
d)
> >>          setup_per_zone_wmarks();
> >>   }
> >>
> >> +static int __init setup_transparent_hugepage_recommend_disable(char *=
str)
> >> +{
> >> +       transparent_hugepage_recommend =3D 0;
> >> +       return 1;
> >> +}
> >> +__setup("transparent_hugepage_recommend_disable", setup_transparent_h=
ugepage_recommend_disable);
> >> +
> >>   int start_stop_khugepaged(void)
> >>   {
> >>          int err =3D 0;
> >> --
> >> 2.19.1.6.gb485710b
> >>
> >>
