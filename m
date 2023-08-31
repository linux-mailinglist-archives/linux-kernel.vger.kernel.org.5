Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2F78F1B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbjHaRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjHaRPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:15:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F003A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:15:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26f4bc74131so689083a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693502122; x=1694106922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMHknYwipePMPg9mivxBhPSOU5ukXfE3oVZOzdjAQnE=;
        b=WJCAutwO3Kzc+qgnZCFdk2UWt65EffCd6XVvxaGJQyu4Cq07V2UgN6MRJtIObpFDIL
         U7Z3B64pnqR9sb3PRzOKAujPhvN+LusjcH8qG+RpR6y4PplATdpqJmhnsG0tqccwfC+S
         YlzFm9j4cwVurGYc5lwkErvgtjKOPYj4U+G8eZ6tj6kzCQqhvsrzHoTf0ErZ1+ncFytH
         2xLyhHbPaynAMdvXElFGA4LVORitIVAU8fpuKZhE1coze/5Lu6axsE6U71/8ItSP4H9s
         n5FCQQXSaMdqAGDS712nfl0bWXy2T7vEiURMK1ZTM9lTDlYCGrBaMzjrTmjw/A3WZ4AS
         JnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502122; x=1694106922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMHknYwipePMPg9mivxBhPSOU5ukXfE3oVZOzdjAQnE=;
        b=T6GcdM1+emMebR6dcR/eVELv/ZaNjQUomucIGB00lvZCE9X6jDrogbNP+b5UMAnV1B
         GBUhbZSYFi+wdMk8cZ533Rcy1qfdbURhyuQWoMr+Mh0AvWsHFKaRMP4qG2wLW5E1V27D
         Q2EBzupP0bLN7Xe7xUQ2By5PNdOYhd6Fd6nJZ228yPowtMJ6izPnEjWpS2bFehhDpl/I
         wtd4PXVlwPvCI+vItpFYNqjV2Jejrh7Aae2I7bdfvsjUAn6l49y0qntglqUd4+ZONzUV
         85pyHYgEDcFM67G6tMyf0opfzLTg298zkeUevbmMAqx5pKwbTO9ew/iVV6YKDiJlxrSS
         6V1w==
X-Gm-Message-State: AOJu0YwX2JmSsuNX0Mlh04MczgL1/QxT+0sXRsq160jHPceJf0oMyAta
        TnuYYCmqm3cD+iRaYmgCxrRP4sb/CaABQVtHayk=
X-Google-Smtp-Source: AGHT+IFDueNVL2EiBWVbrKnpkQVZ9sOGKNLHQVO+89nKgFeUdmB9fGAt4vbz2gNM/f9OXd6KaQHBll2YRmaVEPSmZCA=
X-Received: by 2002:a17:90a:ff05:b0:26f:6f2a:a11 with SMTP id
 ce5-20020a17090aff0500b0026f6f2a0a11mr208538pjb.12.1693502121713; Thu, 31 Aug
 2023 10:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com> <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com> <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
In-Reply-To: <4e14730b-4e4c-de30-04bb-9f3ec4a93754@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 31 Aug 2023 10:15:09 -0700
Message-ID: <CAHbLzkog9B_NWhvYmb7=n3Fnb0oER-sXhE3=Nyx_8Kc3-dggcQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
To:     David Hildenbrand <david@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Zi Yan <ziy@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Thu, Aug 31, 2023 at 12:57=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 31.08.23 03:40, Huang, Ying wrote:
> > Ryan Roberts <ryan.roberts@arm.com> writes:
> >
> >> On 15/08/2023 22:32, Huang, Ying wrote:
> >>> Hi, Ryan,
> >>>
> >>> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>>
> >>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to=
 be
> >>>> allocated in large folios of a determined order. All pages of the la=
rge
> >>>> folio are pte-mapped during the same page fault, significantly reduc=
ing
> >>>> the number of page faults. The number of per-page operations (e.g. r=
ef
> >>>> counting, rmap management lru list management) are also significantl=
y
> >>>> reduced since those ops now become per-folio.
> >>>>
> >>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> >>>> which defaults to disabled for now; The long term aim is for this to
> >>>> defaut to enabled, but there are some risks around internal
> >>>> fragmentation that need to be better understood first.
> >>>>
> >>>> Large anonymous folio (LAF) allocation is integrated with the existi=
ng
> >>>> (PMD-order) THP and single (S) page allocation according to this pol=
icy,
> >>>> where fallback (>) is performed for various reasons, such as the
> >>>> proposed folio order not fitting within the bounds of the VMA, etc:
> >>>>
> >>>>                  | prctl=3Ddis | prctl=3Dena   | prctl=3Dena     | p=
rctl=3Dena
> >>>>                  | sysfs=3DX   | sysfs=3Dnever | sysfs=3Dmadvise | s=
ysfs=3Dalways
> >>>> ----------------|-----------|-------------|---------------|---------=
----
> >>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>=
S
> >>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>=
S
> >>>> MADV_NOHUGEPAGE | S         | S           | S             | S
> >>>
> >>> IMHO, we should use the following semantics as you have suggested
> >>> before.
> >>>
> >>>                  | prctl=3Ddis | prctl=3Dena   | prctl=3Dena     | pr=
ctl=3Dena
> >>>                  | sysfs=3DX   | sysfs=3Dnever | sysfs=3Dmadvise | sy=
sfs=3Dalways
> >>> ----------------|-----------|-------------|---------------|----------=
---
> >>> no hint         | S         | S           | LAF>S         | THP>LAF>S
> >>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
> >>> MADV_NOHUGEPAGE | S         | S           | S             | S
> >>>
> >>> Or even,
> >>>
> >>>                  | prctl=3Ddis | prctl=3Dena   | prctl=3Dena     | pr=
ctl=3Dena
> >>>                  | sysfs=3DX   | sysfs=3Dnever | sysfs=3Dmadvise | sy=
sfs=3Dalways
> >>> ----------------|-----------|-------------|---------------|----------=
---
> >>> no hint         | S         | S           | S             | THP>LAF>S
> >>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
> >>> MADV_NOHUGEPAGE | S         | S           | S             | S
> >>>
> >>>  From the implementation point of view, PTE mapped PMD-sized THP has
> >>> almost no difference with LAF (just some small sized THP).  It will b=
e
> >>> confusing to distinguish them from the interface point of view.
> >>>
> >>> So, IMHO, the real difference is the policy.  For example, prefer
> >>> PMD-sized THP, prefer small sized THP, or fully auto.  The sysfs
> >>> interface is used to specify system global policy.  In the long term,=
 it
> >>> can be something like below,
> >>>
> >>> never:      S               # disable all THP
> >>> madvise:                    # never by default, control via madvise()
> >>> always:     THP>LAF>S       # prefer PMD-sized THP in fact
> >>> small:      LAF>S           # prefer small sized THP
> >>> auto:                       # use in-kernel heuristics for THP size
> >>>
> >>> But it may be not ready to add new policies now.  So, before the new
> >>> policies are ready, we can add a debugfs interface to override the
> >>> original policy in /sys/kernel/mm/transparent_hugepage/enabled.  Afte=
r
> >>> we have tuned enough workloads, collected enough data, we can add new
> >>> policies to the sysfs interface.
> >>
> >> I think we can all imagine many policy options. But we don't really ha=
ve much
> >> evidence yet for what it best. The policy I'm currently using is inten=
ded to
> >> give some flexibility for testing (use LAF without THP by setting sysf=
s=3Dnever,
> >> use THP without LAF by compiling without LAF) without adding any new k=
nobs at
> >> all. Given that, surely we can defer these decisions until we have mor=
e data?
> >>
> >> In the absence of data, your proposed solution sounds very sensible to=
 me. But
> >> for the purposes of scaling up perf testing, I don't think its essenti=
al given
> >> the current policy will also produce the same options.
> >>
> >> If we were going to add a debugfs knob, I think the higher priority wo=
uld be a
> >> knob to specify the folio order. (but again, I would rather avoid if p=
ossible).
> >
> > I totally understand we need some way to control PMD-sized THP and LAF
> > to tune the workload, and nobody likes debugfs knob.
> >
> > My concern about interface is that we have no way to disable LAF
> > system-wise without rebuilding the kernel.  In the future, should we ad=
d
> > a new policy to /sys/kernel/mm/transparent_hugepage/enabled to be
> > stricter than "never"?  "really_never"?
>
> Let's talk about that in a bi-weekly MM session. (I proposed it as a
> topic for next week).
>
> As raised in another mail, we can then discuss
> * how we want to call this feature (transparent large pages? there is
>    the concern that "THP" might confuse users. Maybe we can consider
>    "large" the more generic version and "huge" only PMD-size, TBD)

I tend to agree. "Huge" means PMD-mappable (transparent or HugeTLB),
"Large" means any order but less than PMD-mappable order, "Gigantic"
means PUD mappable. This should incur the least confusion IMHO.

> * how to expose it in stats towards the user (e.g., /proc/meminfo)

I recalled I suggested new statistics for each order, but was NAK'ed.

> * which minimal toggles we want
>
> I think there *really* has to be a way to disable it for a running
> system, otherwise no distro will dare pulling it in, even after we
> figured out the other stuff.

TBH I really don't like to tie large folio to THP toggles. THP
(PMD-mappable) is just a special case of LAF. The large folio should
be tried whenever it is possible ideally. But I do agree we may not be
able to achieve the ideal case at the time being, and also understand
the concern about regression in early adoption, so a knob that can
disable large folio may be needed for now. But it should be just a
simple binary knob (on/off), and should not be a part of kernel ABI
(temporary and debugging only) IMHO.

One more thing we may discuss is whether huge page madvise APIs should
take effect for large folio or not.

>
> Note that for the pagecache, large folios can be disabled and
> distributions are actively making use of that.
>
> --
> Cheers,
>
> David / dhildenb
>
