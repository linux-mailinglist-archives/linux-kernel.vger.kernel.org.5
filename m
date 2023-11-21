Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631947F3398
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjKUQYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUQYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:24:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C5191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:24:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3951AC433CC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700583857;
        bh=/I7hdPnfHnMfYCNOoYvG8pRWQonvhKWX9yzRvlppJ2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FEju9dXSDUGkH+zoX6I5GxSP1mfPl69XBDFLQrnpoY1ljKpc6p0+g61qW4QEX4/EQ
         PJO3zHoaubCN6U1G5uXFv02qCJUH6DgkPWL0BcGY6nqtlZFwlbCstQ7ht+L2jeOSNk
         Xi4m9w/vXh2JbJOIzNYfAcKn40/vFssGPF9eaTc+8KUadGmF/uZC9sK8drtaPQtBJX
         n80/fF+WZ/kncM8Ms59eunjzPp4sqTeeV5ba+FEY7mS3zeacKKtV5cSbyWm9KzlmTs
         63C6pt5X+2simnCV8CJ8fKe6pGsdpjVI+Nq4pVCp9a51GTib5v41dJyIeqH9kN61O8
         Si0fCz+EOwxYw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so70983031fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:24:17 -0800 (PST)
X-Gm-Message-State: AOJu0YylotZAfeR0mCA+2p7XeOttYs/VDNl6VmgixJZx2We4vIBY1wdJ
        6drfqAdshDRvefH5Mx7biOMf7e6EXL7DLSe3nnA=
X-Google-Smtp-Source: AGHT+IFBDdgihWcZR9p2SHhqLZgqFW7T7SpsDUFQNZOxfxW3PzE/eRs7VV4Io8FwHftdYJMDTFbEsWEzZz6CJYa8Pm8=
X-Received: by 2002:a2e:890e:0:b0:2c4:feef:852 with SMTP id
 d14-20020a2e890e000000b002c4feef0852mr7753049lji.32.1700583855466; Tue, 21
 Nov 2023 08:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20231116133638.1636277-1-hca@linux.ibm.com>
In-Reply-To: <20231116133638.1636277-1-hca@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Nov 2023 11:24:04 -0500
X-Gmail-Original-Message-ID: <CAMj1kXFP5SqMGA0wBzz_APKts9hQEWoXxn6PDz2byGsss2smKw@mail.gmail.com>
Message-ID: <CAMj1kXFP5SqMGA0wBzz_APKts9hQEWoXxn6PDz2byGsss2smKw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Remove unused code after IA-64 removal
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 08:37, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> While looking into something different I noticed that there are a couple of
> Kconfig options which were only selected by IA-64 and which are now unused.
>
> So remove them and simplify the code a bit.
>
> Heiko Carstens (3):
>   arch: remove ARCH_THREAD_STACK_ALLOCATOR
>   arch: remove ARCH_TASK_STRUCT_ALLOCATOR
>   arch: remove ARCH_TASK_STRUCT_ON_STACK
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/Kconfig                 | 13 -------------
>  arch/powerpc/kexec/core_64.c |  3 +--
>  include/linux/init_task.h    |  7 -------
>  include/linux/sched.h        |  2 --
>  init/init_task.c             | 10 ++--------
>  kernel/fork.c                | 26 --------------------------
>  6 files changed, 3 insertions(+), 58 deletions(-)
>
> --
> 2.39.2
>
