Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB401784BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjHVVTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHVVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:19:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97523CF1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:19:28 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so23541911fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692739167; x=1693343967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+POAfsybIPLiBgKZtn0Nj8S1fkvlWy6/FL0w0TknP8=;
        b=XYUj9hDT18p54NiVX6dY6Q/kb9npv9lr7YQyNUXVkOSmJP0uDBmLgP50m0fZC31/nG
         //QGb6plAVSeyVru4kYATLT0UfRmE9Eq0MfxsO1opbe8RYPlgQy40R1MgMoUSnNQe3Oy
         gCQ9xQkiL2JYIavjPx/JmylnrdLmNmDYMglxYZBKzB7jxSH27/alSGcnF5iJ5mNaUuLP
         kWh2voZ/6jhJ8or8S8xSnqlFiHM7NUa1FMwSXvDsYeJRwLMpm8npB4KHWcCRCo8Fli0L
         GsfGaV6ui/AOnl99P58MbCR4JOuMj4dwWUwu7hwjAPLUP6SoX8oDRuC31IAa+9fDPwsJ
         JVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692739167; x=1693343967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+POAfsybIPLiBgKZtn0Nj8S1fkvlWy6/FL0w0TknP8=;
        b=hBFcNS2J0YCBk/o7tbV+yPJkAcAadl/sFaYBQaFwQuJ/LGLMhHQo1Zd2priGmawZ9s
         FukEp2Qg5BFqoCBZzf/p4+nJ/YGApt+4h2wDi8TvAu8yR0Td4b4g4JGBfT+IYdJBiwMa
         R3LbF7rR3UhXMitdPD1aQSvFkztyDh43KHyLLVAo+3UDoRSlE1c5XX+oR41VrWOJKnnX
         MOlJMcP/TqLnBbme+4aj38iQdZ/dHK3v+19jktINIVSjpQbgwMCGG1Iigtu9uHx1YimF
         PKdiI0/kPU29mUSwnPvDJrsAiWkqU/cajQuzxxaLbcor0xbYNKd3UTlRfGrOSEYdwz14
         4tLQ==
X-Gm-Message-State: AOJu0YwpyiLKbjHK9f1xMkmVTdHhkiJAxpduoL3uRdfT4N5VOXJkdSMM
        I2vA1WnxxqKFbEHauWAH3rdajILx9RanoApD6WI=
X-Google-Smtp-Source: AGHT+IGuuXsfBiKhX0YrrEA6ZHzNGqpj5f3hU51bESjED5b/pmZUSywadug8X+MmPO0dsHYB4kL3S8gEwr54IdX0xSM=
X-Received: by 2002:a2e:9ec3:0:b0:2b6:fa3f:9230 with SMTP id
 h3-20020a2e9ec3000000b002b6fa3f9230mr7051208ljk.46.1692739166546; Tue, 22 Aug
 2023 14:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net> <6a18b295-92ac-1633-0b79-6aaf18a8496d@huaweicloud.com>
 <CAF8kJuNq2Y5AAAQn66bTEfjkQ8kfPokmGgBLDPwEWUC=MO9NcQ@mail.gmail.com>
In-Reply-To: <CAF8kJuNq2Y5AAAQn66bTEfjkQ8kfPokmGgBLDPwEWUC=MO9NcQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 22 Aug 2023 14:19:15 -0700
Message-ID: <CAADnVQJNQ+9D+3y-jLh3KVczcSo_Piz2O9-V9Grh3c1NQZujsA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Chris Li <chrisl@kernel.org>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Sperbeck <jsperbeck@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 2:15=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Kemeng,
>
> On Mon, Aug 21, 2023 at 6:27=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud=
.com> wrote:
> > >
> > Agreed. We assume pcp->count is protected by pcp->lock. Instead of make=
 code
> > work in case pcp->count could be changed without lock held, it's more r=
easonble
> > to modify pcp->count with pcp->lock held in BPF program.
>
> The lock is holded when pcp->count is modified. It is going through
> the kernel page
> allocation API. The issue is nest memory allocation inside spin_lock()
> introduced by BPF.
>
> The execution sequence is like this:
>
>        count =3D min(pcp->count, count);
>
>         /* Ensure requested pindex is drained first. */
>         pindex =3D pindex - 1;
>         bpf_injected_spin_lock_irqsave {
>                  alloc_page();
>                  original spin_lock_irqsave(&zone->lock, flags) ;
>         }

bpf doesn't call into alloc_page() or slab alloc or pcpu alloc from
tracing progs.
All memory is preallocated.
Can you reproduce the issue on the latest upstream kernel?
