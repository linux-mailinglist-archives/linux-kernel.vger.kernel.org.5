Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE6F78FFE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245012AbjIAPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbjIAPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:22:32 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7091732
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:21:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so34569351fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693581714; x=1694186514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7A6PoNg2bWKzcv8thpGHMroeJ8aq0Z0HWATQwNtHOIw=;
        b=CgYZk89j1Ur4PyhO4ftzot7FA7yybUMQ8jg6wkI4xPWTmhPqzTSVLSMVmWwL0bNJYT
         l3y8o/8pecAvbDsZ7Rpopvorj5mswp94siYZKp21vy4yTFAs6FjUf/WblmYnnG1DJPQm
         rkY1CP9pKKgLqgw8HhjQeWd+w3oggFyxgm2VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693581714; x=1694186514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7A6PoNg2bWKzcv8thpGHMroeJ8aq0Z0HWATQwNtHOIw=;
        b=MD0gKq3abBqSS6o64AdnM7CC5gAog9AddbNIcCv45PPZyEzkzD8jUc8DLSTHbFrdCl
         sSs1m+UJ5yR8vxnZ6gLCDraYzHRI7sUGlDMGsiLJ0EnGROHmidXus4XLe227Sag/kkCL
         CWGVXbkSXn8TuBi9EhnURRyFpULKOwcC2rJal50E+KITLcKfWSqSPB/Iwk0jVPCd5F5s
         wpOqgx15Uln8hny291j8v7UyqlN4M6kWF4x71N8kpr3cFj//sKZ6PaXezb7nMQvuuJ05
         PJvR8gH/8Obs8JMT99NR7GQscYOhmOrrTnlUITyuRqc/zyL5Pr7uwEWt+/4M4qQ0wPC6
         uTlg==
X-Gm-Message-State: AOJu0Yxu0RbM8hdsJ0RgXhpTosixMszGporm11Mi4rPNTNiu8IeRax1z
        //p3UhRmrHrq8rZBlwEy/M80u6sEIfwT2NpszPbAI6Yl
X-Google-Smtp-Source: AGHT+IFqb7tjUbHtvNom6wslFVMtCI9XWR30otJ2CsdQfD4q5JqovOEBP57elyVof2+dgrnAJVmHZQ==
X-Received: by 2002:a2e:9c06:0:b0:2bc:b0be:e76 with SMTP id s6-20020a2e9c06000000b002bcb0be0e76mr1996236lji.37.1693581714286;
        Fri, 01 Sep 2023 08:21:54 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id l21-20020a2e9095000000b002b9af8422a8sm794471ljg.130.2023.09.01.08.21.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:21:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso34954091fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:21:53 -0700 (PDT)
X-Received: by 2002:a2e:a162:0:b0:2bc:be3c:9080 with SMTP id
 u2-20020a2ea162000000b002bcbe3c9080mr2078264ljl.27.1693581713434; Fri, 01 Sep
 2023 08:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-d12081f2-1ff7-4f68-b320-f3aa5c458365@palmer-ri-x1c9>
In-Reply-To: <mhng-d12081f2-1ff7-4f68-b320-f3aa5c458365@palmer-ri-x1c9>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Sep 2023 08:21:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3iBTT5mcYvaUH+fX7Y+z=JUbx6O5nvNMkpe2k8Hcokw@mail.gmail.com>
Message-ID: <CAHk-=wj3iBTT5mcYvaUH+fX7Y+z=JUbx6O5nvNMkpe2k8Hcokw@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sept 2023 at 07:41, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> for the other the result I ended up with was
>
> extern pgd_t early_pg_dir[PTRS_PER_PGD];
> static pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> static p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
> static pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;

That's wrong, you should have removed the 'early_pg_dir' declaration
that is now in <asm/pgtable.h>, as done by commit d2402048bc8a
("riscv: mm: fix 2 instances of -Wmissing-variable-declarations").

> though that's not showing up in the git diff, so I may have something odd going
> on here.

So what's going on is that you resolved the merge conflict by taking
everything from one side (not correct, as above), and then git no
longer considers it a conflict after-the-fact.

Side n ote in case you care about the actual git logic:

The git rules for merge conflicts are different when doing the merge
and when showing the result after doing a merge.

When doing the merge, git will do the expensive history calculations
to figure out the merge base and do a 3-way merge of the base and the
two sides.

So at merge time, git looks back in the history from the two merge
heads, and does the three-way diff based on the history leading up to
the two points.

But after the merge, "git show" will basically do the reverse: it
won't look back in the history, but look at the *result* of the merge.
You are, after all, asking it to show the merge itself.

So then it will again do a three-way diff, but not of the merge base,
but of the merge _result_ and the two sides.

And if the merge result is the same as one of the sides, there's no
conflict remaining, and so no three-way diff.

So that's how conflicts sometimes "disappear" after the merge.

                       Linus
