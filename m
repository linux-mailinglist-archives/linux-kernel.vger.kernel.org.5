Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9757F9BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjK0IXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjK0IXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:23:04 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDEED2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:23:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cd8c3a9edaso574251b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701073391; x=1701678191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULlkC8JeamsZgVSVjUJ5qxYE4uUQ1UkdpEJhpvbLANc=;
        b=NriFqP3/gENU8LISWFAW3K8UTl5+c0ccEC6CHuavWHJb5l8k0yJtTbXXajuZs/jJx9
         0C4/jKP60T7B8C0BubHFbcVEeRh0bxeqkOrQOQLsTuFhZPB5Qstnss2FC3lpnrrJp4yn
         DdGVJe/sdp76g9N1I0sdYIoBex4auBvoRZKwjYKkloRsGw9Ar8aNAp5Nrs6h9dR7ryFV
         JUul9mhml/dwRKqRoASpPE6z6HULTd2SLpmjVboynsSENQm+u09vNmEOHm1szCEcMlYp
         aU70V7DJ73tnHCQZMd+W4PRtgWeIQK5jlnNdlSuf13vNMZNDP4MWmkjnbGrMdSbQ1dcv
         LDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073391; x=1701678191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULlkC8JeamsZgVSVjUJ5qxYE4uUQ1UkdpEJhpvbLANc=;
        b=A+lrIHo/NPYspThMFPY25Emff+E8V+1Ptky4pMHthGP0l81RNwuGXhEMr/qKwWmskn
         pvHYxdNDKRzNk8KQrSzsLzYkg8DPdjJAReWs3qM7xjqAZoq76ODo5hl2T12cKUBOwXAI
         rvhP+cUC/ss7OcVNf9dAdefVO6K/PMYqOdKdkTWtC5AgnRLKWc1vPJugzkkDEc1h5mB5
         AzKvPWTz8TydMHrr52aPK1ScHMw3j4JQQB0x/A1ekDfXm+vH4eofIuS2joWgCKSOe4UI
         p/bLWv6iqwnA5Rg3zv7Y60uCslanmFRmQNpwyYMPlWmozwk4A9lBvgpCkOsBovQw0To7
         hZwA==
X-Gm-Message-State: AOJu0YwynLJtx8u/aPX+Qr0lUvkPLx6PYofzzc6JEe7cn/HpcCvngchj
        wHAKQbOXTzJ3pPthzSagX6yLF9I55D2zhpGA/bKZag==
X-Google-Smtp-Source: AGHT+IF9MFHVFZI6yPj+j7dmHYEfs1Pq2gwHX935HK8wVmKGF44F2bvPSIae1YEPsc09bOt/TgIa/vve+Itf6gwpywU=
X-Received: by 2002:a05:6a20:144b:b0:18c:382e:48fe with SMTP id
 a11-20020a056a20144b00b0018c382e48femr7511796pzi.15.1701073390581; Mon, 27
 Nov 2023 00:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <ZVyp5eETLTT0PCYj@tiehlicka> <32fe518a-e962-14ae-badc-719390386db9@huawei.com>
 <CAJD7tkbC=Z6qAE+b6Ch5eVxNY7k0p98i_=RY0m4_3yg5C_zv+A@mail.gmail.com>
 <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka> <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka> <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka> <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com> <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Chris Li <chriscli@google.com>
Date:   Mon, 27 Nov 2023 00:22:59 -0800
Message-ID: <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
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

On Mon, Nov 27, 2023 at 12:14=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >  I agree with Ying that anonymous pages typically have different page
> > access patterns than file pages, so we might want to treat them
> > differently to reclaim them effectively.
> > One random idea:
> > How about we put the anonymous page in a swap cache in a different LRU
> > than the rest of the anonymous pages. Then shrinking against those
> > pages in the swap cache would be more effective.Instead of having
> > [anon, file] LRU, now we have [anon not in swap cache, anon in swap
> > cache, file] LRU
>
> I don't think that it is necessary.  The patch is only for a special use
> case.  Where the swap device is used up while some pages are in swap
> cache.  The patch will kill performance, but it is used to avoid OOM
> only, not to improve performance.  Per my understanding, we will not use
> up swap device space in most cases.  This may be true for ZRAM, but will
> we keep pages in swap cache for long when we use ZRAM?

I ask the question regarding how many pages can be freed by this patch
in this email thread as well, but haven't got the answer from the
author yet. That is one important aspect to evaluate how valuable is
that patch.
Regarding running out of swap space. That is a good point, in server
workload we don't typically run out of swap device space anyway.

Android uses ZRAM, the story might be different. Adding Minchan here.

Chris
