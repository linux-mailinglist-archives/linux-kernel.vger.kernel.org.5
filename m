Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8D7A8D34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjITT4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:56:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC93A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:56:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso159662b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695239780; x=1695844580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bdO0xz/gxnMyoNh9ci7U8VYkxhPXGCIftSFtRqg4ck=;
        b=gejUGgnIl4v3xldk568Jdfq+ONf2WRKK9FElvIU10EpKjuDyb7P4t/2Jp27t1Z+5xp
         mOSCpmZ/k13Hy/oZcajIqTXJakm934KfxCwLVwgNCEP5a32M5Xj152BRzDepdpVTPEpP
         9pVNPpfeWBThhUq9e6JYuzUPACz88ICM0u5po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239780; x=1695844580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bdO0xz/gxnMyoNh9ci7U8VYkxhPXGCIftSFtRqg4ck=;
        b=IrmhNQYL4JglMCU3FNnUyuP3orwyM27UswggxWQyU16dJGo4DDls02OnAf9tCqgE7y
         jyL/1jEHiLeseVxlUp1zqagYYJjhd7ZtTZGCs8G7MJba7Zz3z5no1B6MK878/aO0z6W5
         gL++Pb508BxvuaoEo0z0revYoxXRcB3UkgIwONN1dkcAhD63vkgv8FkHA10magWJN5YL
         cVSbJloGzvFY88SUXfOhhD1HV+RNP7ethKSoso/yKS93ng1HYBCNoIFJwuArdHHw3ftX
         Yf/ydm/ynWwOpREnEYqTMo3ShtPhv+W68FEGI5kbG7S7PSDc893gkdisH1Ru+QEjAvAk
         SlBQ==
X-Gm-Message-State: AOJu0YxFjFDXJeOuAG6aYdEwqLjvQmHjqj7kxKwwzOO6LF6JVHBI4XJ5
        dEGKcD+I30VAlgT/2d8jlZQ0ItRgeQnhNMjhXZ7vkdMrV5QDx+hh
X-Google-Smtp-Source: AGHT+IG97grYrf1f+1/GPnB+nLQJi0Xuo6U+yKZnrtMxq1kiVmE5PIYdDxz1aL+J+cXXEsuiMZxu4Ya9H8MjXCSPtKg=
X-Received: by 2002:a05:6a20:5608:b0:159:ee33:12f with SMTP id
 ir8-20020a056a20560800b00159ee33012fmr3167396pzc.56.1695239779810; Wed, 20
 Sep 2023 12:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230828150858.393570-1-revest@chromium.org>
In-Reply-To: <20230828150858.393570-1-revest@chromium.org>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 20 Sep 2023 21:56:08 +0200
Message-ID: <CABRcYm+u1AHMrXbYrfkxW-2vrjdq-1cx13FsX_DFo=wwWB8rbA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] MDWE without inheritance
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        ayush.jain3@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like this series got quite a few Reviewed-by now. What should
be the next steps to have it merged ?

On Mon, Aug 28, 2023 at 5:09=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> Joey recently introduced a Memory-Deny-Write-Executable (MDWE) prctl whic=
h tags
> current with a flag that prevents pages that were previously not executab=
le from
> becoming executable.
> This tag always gets inherited by children tasks. (it's in MMF_INIT_MASK)
>
> At Google, we've been using a somewhat similar downstream patch for a few=
 years
> now. To make the adoption of this feature easier, we've had it support a =
mode in
> which the W^X flag does not propagate to children. For example, this is h=
andy if
> a C process which wants W^X protection suspects it could start children
> processes that would use a JIT.
>
> I'd like to align our features with the upstream prctl. This series propo=
ses a
> new NO_INHERIT flag to the MDWE prctl to make this kind of adoption easie=
r. It
> sets a different flag in current that is not in MMF_INIT_MASK and which d=
oes not
> propagate.
>
> As part of looking into MDWE, I also fixed a couple of things in the MDWE=
 test.
>
> This series applies on the mm-everything-2023-08-25-20-06 tag of the mm t=
ree:
>   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/
>
> Diff since v3:
> - Added a bunch of Reviewed-by, Acked-by and Tested-by. Thanks everyone!
> - Reworded patch 2's description for clarity
> - Removed an unnecessary int cast
> - Added test coverage for errnos of invalid prctls (EPERM/EINVAL)
> - Added test coverage for can_keep_no_flags and can_keep_both_flags
>
> Diff since v2:
> - Turned the MMF_INIT_FLAGS macro into a mmf_init_flags function as sugge=
sted by
>   David Hildenbrand
> - Removed the ability to transition from to PR_MDWE_REFUSE_EXEC_GAIN from
>   (PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT) which also significantl=
y
>   simplifies the prctl_set_mdwe logic
> - Cc-ed -stable on patch 3 as suggested by Alexey Izbyshev
> - Added a handful of Reviewed-by/Acked-by trailers
>
> Diff since v1:
> - MMF_HAS_MDWE_NO_INHERIT clears MMF_HAS_MDWE in the fork path as part of=
 a
>   MMF_INIT_FLAGS macro (suggested by Catalin)
> - PR_MDWE_* are defined as unsigned long rather than int (suggested by An=
drey)
>
> Florent Revest (6):
>   kselftest: vm: Fix tabs/spaces inconsistency in the mdwe test
>   kselftest: vm: Fix mdwe's mmap_FIXED test case
>   kselftest: vm: Check errnos in mdwe_test
>   mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
>   mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
>   kselftest: vm: Add tests for no-inherit memory-deny-write-execute
>
>  include/linux/sched/coredump.h         |  10 ++
>  include/uapi/linux/prctl.h             |   3 +-
>  kernel/fork.c                          |   2 +-
>  kernel/sys.c                           |  32 ++++--
>  tools/include/uapi/linux/prctl.h       |   3 +-
>  tools/testing/selftests/mm/mdwe_test.c | 137 ++++++++++++++++++++++---
>  6 files changed, 163 insertions(+), 24 deletions(-)
>
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>
