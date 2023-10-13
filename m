Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772AA7C8193
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJMJKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJMJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:10:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D60D54;
        Fri, 13 Oct 2023 02:09:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so2797652a12.0;
        Fri, 13 Oct 2023 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697188192; x=1697792992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJzZvH8fBl6ADPsi6DUS9ksyUncHYpaqW3DpQr1VE2E=;
        b=B7e3NZO8ryyuyijh0TahGkmqE48K7IqNPiQsBTJMEoQ0idChHpMvG5+rpzw0yBz2jf
         ibd/rXQI4g7Pa2psj1H4/5tKfJrH73vfUWDINv/NwtOXuCT7L/JDLrR3Tr3XBYzAwctQ
         x07eni3AfGpDI/W+Je9rt1dWa1lIkOtydBCTMLx+kl1uFic1Cd28fhhATPrl9Aa74VHC
         PIEf78sNj6UvrvPn3+z1SIEobxu/rkZY7S0B60HTTOtaAHQ89hAyGcTdjjpFWpkGKPtg
         l7HN/EdAMDnMRZu91hhVsGFcuQ0Xjp3WcKYwK9VPK87iS76tCQTcV91UDMLzibfFyzqN
         hN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697188192; x=1697792992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJzZvH8fBl6ADPsi6DUS9ksyUncHYpaqW3DpQr1VE2E=;
        b=GRA981RsZ77E9qYiZmujt7m4UCBMEGAAomg1FpszRH9pGgordEZCNVOQ6ZRBeh70Jx
         j5eBOMc23yB4EXaidjLwwZmBjhKHndu2gnVziHOTVJOz0hAe6e2jkwzsjXCNdQbq6rrP
         aLBUrNtVw6GeFDPsToy2w8oGkr7oksiBxNTe1eNqW7xsmQgSM37lD7Ehsx1VbYGpqYp6
         E52gi6raNgitMimOurzcYX60k+A825dQA7fojgXrwGkxxp/RyQeqQmV+bFwpcvE/9X0i
         ixuB7g5guWyeE72/Xwq/D6RhEEvvuXXCoNdib1r6Zt4HkIbSC4GrOYNkm2gfNAhcTIgT
         pKCQ==
X-Gm-Message-State: AOJu0YybFIHkYO13NvdWFQgks1MRM65cmSI8GuN5ylF7QktNNktvJwYJ
        1QZGJYe/kbCnKjy7Ax4C2LWmUIZiwSA0IdqhqT0=
X-Google-Smtp-Source: AGHT+IHFTCW7zjIdWbJ7zJJDNC9TMhAztBlpLvu213GykOM5zhVVEq8OGtCQFQv9Cd/wi4lA8iUAsCvCiq8XxXye8uM=
X-Received: by 2002:a05:6402:350b:b0:529:d147:e9f3 with SMTP id
 b11-20020a056402350b00b00529d147e9f3mr21470925edd.5.1697188192093; Fri, 13
 Oct 2023 02:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <ZSjyJuqk3z0RyKP2@gmail.com> <0c973a20-e10c-4989-b7d9-86cb0f522718@kadam.mountain>
 <ZSkInflBriOL9V3M@gmail.com>
In-Reply-To: <ZSkInflBriOL9V3M@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 13 Oct 2023 11:09:40 +0200
Message-ID: <CAFULd4b7F=MNMduRn99FFcAc7Of7RsL+vyXVzsiBZZ9hz0+HnA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 11:06=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> > On Fri, Oct 13, 2023 at 09:30:46AM +0200, Ingo Molnar wrote:
> >
> > > Ugh, why on Earth didn't GCC warn about this? The bad pattern is pret=
ty
> > > simple & obvious once pointed out ... compilers should have no troubl=
e
> > > realizing that 'ret' is returned uninitialized in some of these contr=
ol
> > > paths. Yet not a peep from the compiler ...
> >
> > We disabled that warning years ago (5?) because GCC had too many false
> > positives.
>
> GCC had some pretty bogus notions about 'possible' uninitialized use that
> encouraged some bad code patterns, but in this case there's readily
> provable uninitialized use, that a compiler should warn about.
>
> Is it possible to disable just the unreliable, probabilistic part of GCC'=
s
> uninitialized variables warnings?

-Wno-maybe-uninitialized?

Uros.
