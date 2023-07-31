Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D176A4A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGaXQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGaXQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:16:52 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433F90
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:16:51 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d18566dc0c1so5367339276.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690845410; x=1691450210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQFniUYZNNw7oRQ7SimDpQFNUgcsZE10qOJEeVmLuDc=;
        b=eCekKtdIZ6bkj8JkDhy28jNnQeVz0m7wGcv1NnCkj/APuVyVRXA1Au3I3+M+3AowlV
         UufQRErPO8W7inee0R4brj+DVeCO++/fweOzTPVUpIpd2B+Ye5vUt9sZuQXQeiNUp+0O
         qeYPHRkNe8OcULAnpfbK5MAcsQ/4g8kansEFdVBSv0YUYglCFE0H1dNsOanEt13UBzMK
         mJRpmKmB3S/NZMlD6mjzjCO8vbAkHynQ8LLMxUBnjspJgLbeYYb9mbwR0I1h2kCCSi8e
         neij3HTmKWZdFcbRJkqA42X/rNAJM0PsY82Z/DlXrlumejJA2nIG6TWIRJAyY+2nUAzq
         4RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690845410; x=1691450210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQFniUYZNNw7oRQ7SimDpQFNUgcsZE10qOJEeVmLuDc=;
        b=b/bMyWI+ZKhSirPjrlzJg8kYTj3zoLTayKFgRPzyIGjhpivNmMEITJMVJewUDER839
         JbgXKlt1wIrsXmxym4islF9HFD9Ok3/HPxTaAgTPhO9AlG/kdwgqwbU3uaxxtvruIcHO
         9DDr+evlABXA0t2TGSbuYu4amnjrFnODoTyRQE58eqLy3gZiIq8FPNPoe69o7B336rrD
         /b7TQ7FbJLiu6JawH+oVpL1z8gO25WtGy4QGVjIqRxVSrcYOGQbIjw8LKewXyA5n25nV
         L9gxxLFtB1pTHZk+grCrXKa3TlQCF5YUQQnc75nIEuYKLWXRdDp4sRd6X7UI7Fsihqkx
         Lx1Q==
X-Gm-Message-State: ABy/qLbjQiHt7OKfoMWdULLeadflqyd/vfhvOAerg1of+8znhNkuMo5p
        923NkF5tAEVUNgKxZ7hfiPBveW2NMCzDHgDVemZ9AgymhvwzZwnMzdw=
X-Google-Smtp-Source: APBJJlETZUZ3f3bPrdJDlvMj8Gzj8H7aeBIApG4VrutCo9EgnKySwz2DctOidzvXxG+76ewdKSs9HdFB2UZwsgLh9+8=
X-Received: by 2002:a25:da4b:0:b0:d05:3d5b:b63 with SMTP id
 n72-20020a25da4b000000b00d053d5b0b63mr13083806ybf.25.1690845410214; Mon, 31
 Jul 2023 16:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230731030740.12411-1-rdunlap@infradead.org> <CAJuCfpGQzpWptS0WBBzw8XesPFb5MeG5UVLFDce72wfXNA1joQ@mail.gmail.com>
 <CAJuCfpGQbyD7qPHSTE1o7srTv=sP8ZZTA0F9U1owNO7OEP_M1g@mail.gmail.com> <fd7ef41e-097a-9b76-585a-18d14edff9e8@infradead.org>
In-Reply-To: <fd7ef41e-097a-9b76-585a-18d14edff9e8@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jul 2023 16:16:39 -0700
Message-ID: <CAJuCfpELFyY6GAU1aS2T=Z3KxLGnZWRjf32vyRb4dNVF9E7DjA@mail.gmail.com>
Subject: Re: [PATCH] PSI: select KERNFS as needed
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 4:13=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 7/31/23 11:17, Suren Baghdasaryan wrote:
> > On Mon, Jul 31, 2023 at 11:14=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> >>
> >> On Sun, Jul 30, 2023 at 8:07=E2=80=AFPM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> >>>
> >>> Users of KERNFS should select it to enforce its being built, so
> >>> do this to prevent a build error.
> >>>
> >>> In file included from ../kernel/sched/build_utility.c:97:
> >>> ../kernel/sched/psi.c: In function 'psi_trigger_poll':
> >>> ../kernel/sched/psi.c:1479:17: error: implicit declaration of functio=
n 'kernfs_generic_poll' [-Werror=3Dimplicit-function-declaration]
> >>>  1479 |                 kernfs_generic_poll(t->of, wait);
> >>>
> >>> Fixes: aff037078eca ("sched/psi: use kernfs polling functions for PSI=
 trigger polling")
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >
> > shouldn't this include:
> > Closes: https://lore.kernel.org/oe-kbuild-all/202307310732.r65EQFY0-lkp=
@intel.com/
> > ?
> >
>
> That's the same URL as the Link: below.
> The difference(s) in Closes: and Link: are not clear to me,
> other than Closes: is newer.

Either way, LGTM. Thanks!

>
> >>> Link: lore.kernel.org/r/202307310732.r65EQFY0-lkp@intel.com
> >>> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >>> Cc: Suren Baghdasaryan <surenb@google.com>
> >>> Cc: Ingo Molnar <mingo@redhat.com>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Juri Lelli <juri.lelli@redhat.com>
> >>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >>
> >> Acked-by: Suren Baghdasaryan <surenb@google.com>
> >>
> >> Thanks!
> >>
> >>
> >>> ---
> >>>  init/Kconfig |    1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff -- a/init/Kconfig b/init/Kconfig
> >>> --- a/init/Kconfig
> >>> +++ b/init/Kconfig
> >>> @@ -629,6 +629,7 @@ config TASK_IO_ACCOUNTING
> >>>
> >>>  config PSI
> >>>         bool "Pressure stall information tracking"
> >>> +       select KERNFS
> >>>         help
> >>>           Collect metrics that indicate how overcommitted the CPU, me=
mory,
> >>>           and IO capacity are in the system.
>
> --
> ~Randy
