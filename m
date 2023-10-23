Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007F27D3EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjJWSKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJWSKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:10:48 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF6B4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:10:44 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso3456424276.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698084644; x=1698689444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4pSWvEBkX0Lu9RMg2D09cgpXGEBNyWtfX6YA9F1f3c=;
        b=OVmmALdWYBN9o5lA/puFO+KG8yFTgqcYBBzprEBFR2eP6wbJ9LRH/VbFYenyXdoFTw
         6vgWgnqE0A1jgGHnMc9vLemmC+UT36L4G6HyMjbnoVixes8BoLl3PYQBFgw1TBGEQ/Nq
         oaymz+RFTNC+LFC6/fDT5BiD3l/Xzg3molTNLwsdix4PAmGZxSPaKfodUJA7qvGl5fdn
         EimsGBC3hqiFQO+1XkgTJucKu9dNyht6jvmceicHXBOBrcrKURcvQG+EgDVuWbyzjYog
         h0LuJsgKp35VdyD4cW8UvzY6GWTLQ5onjBsIVXZVi+M763A31Rfhw1lTpohELAcpoboQ
         zOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084644; x=1698689444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4pSWvEBkX0Lu9RMg2D09cgpXGEBNyWtfX6YA9F1f3c=;
        b=K5aUVK7pcU3rsrgIbmJsFuF2es7MGLG7qPGqa1cGXyfC0RBcXhzAKwVdOlLu3TOVpO
         7AzzGSIfd/G1JoPXVpk/UY5SsPBsUtVHub2dXgiFtdFB+9AV0VWSOpcHD40K0aXgcWV0
         VDzj9oZJnIGJ0JhYD04s3a+flxu744DP/Mg+QgCq1/xTD3XM5/wYejPyZXre6Shp+C87
         N7BwXxwvBF5J2L9+mLAW7OJlgIYhgNpQZybktwLtJqgAYp7F7bLu8PM1YDkZx0jY+ooP
         AQeKedY1BsaYwJIuh3xAtZCi2CB6XkOoZNwadcOq562hNVzya6DZWTYO5BrZumctigjz
         uydA==
X-Gm-Message-State: AOJu0YyjeW2SxOq9ASdL/A9EuJzqo9g9r2qSChcM+zDplfxjbTHgSjCg
        Z5T8WzLAe2q1wOosBsEMjmdJIDAnWQ4dSqOhqcI=
X-Google-Smtp-Source: AGHT+IFsRHY0zS38L02VKh/tEUVDmXeCZ3H+/yDfWD2j2oKtRCBYtB+IIijgiM1XHpz12xkowAhmpAK//ZInfVGDhA0=
X-Received: by 2002:a25:ef48:0:b0:d9a:c22a:6edc with SMTP id
 w8-20020a25ef48000000b00d9ac22a6edcmr9577336ybm.30.1698084643765; Mon, 23 Oct
 2023 11:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
 <74e34633-6060-f5e3-aee-7040d43f2e93@google.com> <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com>
 <CAFYChMvWFdHq-OJHBE3DycmGtGmczDOHVGfoSqdvY-BxM2hWyg@mail.gmail.com> <20231023105331.311373ed33a0dfe78ddaa9e5@linux-foundation.org>
In-Reply-To: <20231023105331.311373ed33a0dfe78ddaa9e5@linux-foundation.org>
From:   domenico cerasuolo <mimmocerasuolo@gmail.com>
Date:   Mon, 23 Oct 2023 20:10:32 +0200
Message-ID: <CAFYChMu9DO7OeXqQmKbfMY-iGKykHB21V8nqjy=tQa+StfDAUQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] mempolicy: alloc_pages_mpol() for NUMA policy
 without vma
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.co>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno lun 23 ott 2023 alle ore 19:53 Andrew Morton
<akpm@linux-foundation.org> ha scritto:
>
> On Mon, 23 Oct 2023 18:53:26 +0200 domenico cerasuolo <mimmocerasuolo@gmail.com> wrote:
>
> > > Rebased to mm.git's current mm-stable, to resolve with removal of
> > > vma_policy() from include/linux/mempolicy.h, and temporary omission
> > > of Nhat's ZSWAP mods from mm/swap_state.c: no other changes.
> >
> > Hi Hugh,
> >
> > not sure if it's the rebase, but I don't see an update to
> > __read_swap_cache_async invocation in zswap.c at line 1078. Shouldn't we pass a
> > mempolicy there too?
>
> No change needed.  zswap_writeback_entry() was passing a NULL for arg
> `vma' and it's now passing a NULL for arg `mpol'.

Problem is that alloc_pages_mpol is dereferencing mpol, when I test the zswap
writeback at 397148729f21edcf700ecb2a01749dbce955d09e it crashes, not sure if
I'm missing something.

>
