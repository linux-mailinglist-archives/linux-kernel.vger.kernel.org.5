Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8005E78977E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHZOpp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Aug 2023 10:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHZOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:45:32 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA9FE4E;
        Sat, 26 Aug 2023 07:45:29 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d746d030a86so1856151276.1;
        Sat, 26 Aug 2023 07:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693061128; x=1693665928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5KOUY+kV96llNzphnz+NXqnkWdYpQAMYzH4mHsanEw=;
        b=NAbp/ZaXpMFsoB6V0cVyPBWndoNveRantcsbi6RUxFHBfbvRiHTM7MHfmjzjT19eNg
         +rXP9hwOEd1AilZnXS3S0uHe0QbvzSOLkX0pBDRyWe3MUUAsbtHoWN561cvIi6cSW7LD
         mmAaNnmA571bCyvv+ZuJK5P8ptiu074DFlZGQjF1qVs3pCylfg9gsTF01doTkABSTXoa
         3bO+HsdP3XxvTFnDtM+pnw0jaqfdEqvODkO+leDyIYTxWJ0SbcCBbS+OBTqOJ7HSxzEv
         ebrVOgNp3VzLU0ZSOcE1DMNy0OFNhypLvWH3DKqM7O+Q8FixAEOl1uSTGAOMrhsK4r5b
         PH8A==
X-Gm-Message-State: AOJu0YxHD0g3Js6vvb63Cy7XDnKmKzhJuzjd0CCorCQ+9UiDcAGl8skw
        PZpG6mnC14AZHNHdGdKpVizDB0xMyntXDusy0lU=
X-Google-Smtp-Source: AGHT+IFAYkptAcqGhimlYDrGfJ08wtS++iZW74Ht3FSwP4Y1Gj6ZCgux+GNkdtTdhHnd8+he3zj4z+q6L/jxHRBTueg=
X-Received: by 2002:a25:c552:0:b0:d78:441d:4d62 with SMTP id
 v79-20020a25c552000000b00d78441d4d62mr3728385ybe.22.1693061128112; Sat, 26
 Aug 2023 07:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230819093340.265817-1-leo.yan@linaro.org> <CAM9d7cj=ichFk4bVQSbyptqy9wo8GFm1Z1Q7QzfhMFLjewNF-Q@mail.gmail.com>
 <20230823023838.GF57731@leoy-huanghe.lan> <CAM9d7cgaMyH=vSjVEOBjLzBWbZOricm6aHcP9hfLsTJ_gUEh3g@mail.gmail.com>
 <20230826072957.GA75980@leoy-huanghe.lan>
In-Reply-To: <20230826072957.GA75980@leoy-huanghe.lan>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 26 Aug 2023 07:45:15 -0700
Message-ID: <CAM9d7cjkQAhponi_mO9yBHaBP3wB4cBcWc5B7yb_4nE2dQWpLw@mail.gmail.com>
Subject: Re: [PATCH v6] Documentation: userspace-api: Document perf ring
 buffer mechanism
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Sat, Aug 26, 2023 at 12:30 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Namhyung,
>
> On Tue, Aug 22, 2023 at 09:26:05PM -0700, Namhyung Kim wrote:
>
> [...]
>
> > > > > +Why ring buffers are mapped with above two different modes?  Here the
> > > > > +write direction matters.  The forward writing starts to save data from
> > > > > +the beginning of the ring buffer and wrap around when overflow, which is
> > > > > +used with the read-write mode in the normal ring buffer.  When the
> > > > > +consumer doesn't keep up with the producer, it would lose some data, the
> > > > > +kernel keeps how many records it lost and generates the
> > > > > +``PERF_RECORD_LOST`` records in the next time when it finds a space in the
> > > > > +ring buffer.
> > > >
> > > > Thanks for the update.  It's unclear to me if all 4 combination of
> > > > (rw, ro) x (fwd, bwd) are possible (yes!).  The rw mode and back-
> > > > ward is also possible but just not used for perf tool.
> > >
> > > I can add a matrix for the combinations:
> > >
> > >   The combination is supported in perf tool:
> > >
> > >   ---+------------+-----------
> > >      |  Forward   | Backward
> > >   ---+------------+-----------
> > >   rw |  Yes       |   No
> > >   ---+------------+-----------
> > >   ro |  X         |   Yes
> > >   ---+------------+-----------
> > >
> > >   Yes: is supported
> > >   No: is not supported
> > >   X: is not feasible
> >
> > I think they are all supported.  You can use rw mode with backward
> > direction but it's just not intuitive.  Also ro mode with forward direction
> > is working but there's a chance to miss the start position of the
> > previous event.
>
> I am a bit confused for the all four modes are supported.
>
> From the code [1], we can see there have only two combinations:
>
> - overwrite + read-only mode (PROT_READ);
> - no-overwrite + read-write mode (PROT_READ | PROT_WRITE);
>
> And I think perf tool must use the backward writing for "overwrite",
> and use the forward writing for "non-overwrite" mode.  I think the
> code [2] can help us to conclude this.

I mean the kernel supports all the combinations but perf tool uses
the selected two.  IIUC you are describing the kernel behavior, right?

Thanks,
Namhyung

>
> In the end, the perf tool doesn't support the combinations:
>
> - overwrite + read-write mode
> - no-overwrite + read-only mode
>
> I have sent a v6 patch, please let me know if you have any concerns or
> if I misunderstand anything.  Thanks!
>
> Leo
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/evlist.c#n474
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/mmap.c#n141
