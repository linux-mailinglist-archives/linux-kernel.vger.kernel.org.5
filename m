Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D915C7D5E42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbjJXWd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344571AbjJXWdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:33:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0498199B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:33:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so1937a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186793; x=1698791593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iRTEiIAHqdOTFjTizDZPjyhzdJk6A4pywAK9Lo2CAs=;
        b=u9Vow3dPZ4aOOqWvjW2BQYVWZ+wrAmPCRBS8oVS/DIWMHQ8ECo0sBbHComztxC2ZHI
         KHmSBPdgx57825ZE0fbvZ7jxw3AzjfQznc1/CPjQzjcDi6j+1imoR3HR/SSUFJCaNgsU
         UREYonF50vCsp9ZgX0hjpTJwYfKb+1IhNTIxevlyQwttBc4K2X7b7ezoDj4SsyYvTZ2l
         Ddz+1XFpGbCLSLxZNq7KjH9t/BT9POXeznI81evmY6yD7EUTvpUJX0RX2PXCrsriL09v
         1GFomSKMr9iCB4siA2OFWFGbH8nMWLvl71cj/U/X6gzIehDypcBgnyExiKB2bWTyqAH4
         smZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186793; x=1698791593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iRTEiIAHqdOTFjTizDZPjyhzdJk6A4pywAK9Lo2CAs=;
        b=O7/8IudWl2w9mM31ujBZs+GJPQqkyfW05NsxB6URvhEWNHGTppXN4Tj5mai/2SQfZs
         msR6tNWqfrShkmTmgxAwR5z2JZ8EqBjv7ibc1DRuSJ0GZAR0HhVdB+9ttv8XtjvT5DYf
         NShOSp3pAZuCEjMQ6dnsW6Ss8SgDJOgzJ5p0iIJikX14ybzPl5LfqQaCmv4Az/yPXN0o
         ijT2hqe/UOkpb4Cew/x8FVnf38HMm+xN9az0YuaAJNlOBtbQUHtcBNrUQVTlqam2XcVx
         zny4dM/S0jFwUgRDvv+U7B8yMHUaQppUzdsCogagdvaxLzrn+SdRZIAuscbJk50FJgmZ
         ljug==
X-Gm-Message-State: AOJu0YzMbX6Pl6TuOiNhRFPVO9TEN0H9jQtXiCYGCGTuZU4bhosNID2i
        E3YAl21V319DgnMLL1wHsmNOvQVjc4QKfVbmY+160A==
X-Google-Smtp-Source: AGHT+IEhKi2VOruYNNnNI/sR21aEEQlZTcHU2b10DJUQA6jXPDIAQq/Xqz+xSDCPlcNssBRl7QiDjS9G4VV5ayQdXYs=
X-Received: by 2002:aa7:df94:0:b0:540:e4c3:430 with SMTP id
 b20-20020aa7df94000000b00540e4c30430mr311edy.6.1698186789616; Tue, 24 Oct
 2023 15:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 24 Oct 2023 16:32:30 -0600
Message-ID: <CAOUHufZwXUfvfHDAQZ-RftHut9ghxc4kNffjQFrwz1s0Nz-L0A@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 6:56=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Now ptep_clear_flush_young() is only called by folio_referenced() to
> check if the folio was referenced, and now it will call a tlb flush on
> ARM64 architecture. However the tlb flush can be expensive on ARM64
> servers, especially for the systems with a large CPU numbers.
>
> Similar to the x86 architecture, below comments also apply equally to
> ARM64 architecture. So we can drop the tlb flush operation in
> ptep_clear_flush_young() on ARM64 architecture to improve the performance=
.
> "
> /* Clearing the accessed bit without a TLB flush
>  * doesn't cause data corruption. [ It could cause incorrect
>  * page aging and the (mistaken) reclaim of hot pages, but the
>  * chance of that should be relatively low. ]
>  *
>  * So as a performance optimization don't flush the TLB when
>  * clearing the accessed bit, it will eventually be flushed by
>  * a context switch or a VM operation anyway. [ In the rare
>  * event of it not getting flushed for a long time the delay
>  * shouldn't really matter because there's no real memory
>  * pressure for swapout to react to. ]
>  */
> "
> Running the thpscale to show some obvious improvements for compaction
> latency with this patch:
>                              base                   patched
> Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%*
> Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%*
> Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%*
> Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%*
> Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%*
> Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%*
> Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%*
> Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%*
> Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%*
>                        base       patched
> Duration User         167.78      161.03
> Duration System      1836.66     1673.01
> Duration Elapsed     2074.58     2059.75
>
> Barry Song submitted a similar patch [1] before, that replaces the
> ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
> folio_referenced_one(). However, I'm not sure if removing the tlb flush
> operation is applicable to every architecture in kernel, so dropping
> the tlb flush for ARM64 seems a sensible change.
>
> Note: I am okay for both approach, if someone can help to ensure that
> all architectures do not need the tlb flush when clearing the accessed
> bit, then I also think Barry's patch is better (hope Barry can resend
> his patch).
>
> [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gmail.co=
m/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

+Minchan Kim

Minchan and I discussed this (again) yesterday -- I'm in favor and he
can voice his different opinion on this.
