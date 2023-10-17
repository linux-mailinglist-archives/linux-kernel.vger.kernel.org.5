Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFCF7CCBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjJQTGF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbjJQTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:05:54 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EE1FC;
        Tue, 17 Oct 2023 12:05:52 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-564b6276941so4502306a12.3;
        Tue, 17 Oct 2023 12:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569552; x=1698174352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuvHgJEYPvvaf1w7rboxP5KoSmgvNQj+LHx++KlT/8g=;
        b=tHCDlh+/jxJij7rfKu5tBZ6vqYMmPa6z4rHS4byKW5JuvbmQ9EAP90awCrrtTRdAXH
         kbj4ybz0Ra5ELctuAtvuevaRFCSSqOFH1wf7wOTiOxKdugck0EXclc7RnPv8o9+xEQRB
         FN8VED3mhOV4saN9YRm5rMSqn63WyfK+uh1iDK573BHjQtyzS9R+f2LELVdJ2bYqWRDo
         5IA1BnNYSEY338rbP5Y9+fYUkaqzfx8lZcf2VZgZF81wvG+ev+CCDdy0DdXZz/I2NZTJ
         KJ47JoWy24Su0LeejHuApTvS5skxZRzBeKBcY2qlvSdKPOnnTeQRPCq3tgYsVMlqXHwS
         ck/A==
X-Gm-Message-State: AOJu0Yx+UqlPwGOCzAiT7GgskQnSeiP+00XG6m/gaskCSd8He+plFq0j
        v/qh6+5rvx1ykNDZXR1fzX2M2hEAJ4TOXilTSOsZ+0VX
X-Google-Smtp-Source: AGHT+IHG4jXT3a5/Z67JfjBtawbXRS6kej3T7Ck1b85DtR8ldjrqYiN9vM9FJqg17weeNwcHg+SpqIklbh7+EAuMpSw=
X-Received: by 2002:a17:90a:474e:b0:27d:20f5:3629 with SMTP id
 y14-20020a17090a474e00b0027d20f53629mr2982050pjg.46.1697569551784; Tue, 17
 Oct 2023 12:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231016044225.1125674-1-namhyung@kernel.org> <ZS0D53ckVx356k4o@gmail.com>
 <ZS1Y5PhXhp384ynY@kernel.org> <ZS1ajf/9HmgUyyCl@kernel.org>
 <ZS1cGMgyEDJQbwq9@kernel.org> <ZS1c9RCh9MkzPbFG@kernel.org>
 <ZS2ecyCVpK8B2cQq@kernel.org> <ZS5yl3RzVGKBkCvY@gmail.com>
 <ZS592qxF3YxmCoG1@kernel.org> <ZS6BgfOUeWQnI1mS@gmail.com> <ZS7TAr1bpOfkeNuv@kernel.org>
In-Reply-To: <ZS7TAr1bpOfkeNuv@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 Oct 2023 12:05:40 -0700
Message-ID: <CAM9d7cjLxtDPXXVWMG7SkPpsUrgh848texqH150XP+6+9ZqZxw@mail.gmail.com>
Subject: Re: [perf stat] Extend --cpu to non-system-wide runs too? was Re:
 [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:31 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Oct 17, 2023 at 02:43:45PM +0200, Ingo Molnar escreveu:
> > * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Tue, Oct 17, 2023 at 01:40:07PM +0200, Ingo Molnar escreveu:
> > > > Side note: it might make sense to add a sane cpumask/affinity setting
> > > > option to perf stat itself:
>
> > > >   perf stat --cpumask
>
> > > > ... or so?
>
> > > > We do have -C:
>
> > > >     -C, --cpu <cpu>       list of cpus to monitor in system-wide
>
> > > > ... but that's limited to --all-cpus, right?
>
> > > > Perhaps we could extend --cpu to non-system-wide runs too?
>
> > > Maybe I misunderstood your question, but its a list of cpus to limit the
> > > counting:
>
> > Ok.
>
> > So I thought that "--cpumask mask/list/etc" should simply do what 'taskset'
> > is doing: using the sched_setaffinity() syscall to make the current
> > workload and all its children.
>
> > There's impact on perf stat itself: it could just call sched_setaffinity()
> > early on, and not bother about it?
>
> > Having it built-in into perf would simply make it easier to not forget
> > running 'taskset'. :-)
>
> Would that be the only advantage?
>
> I think using taskset isn't that much of a burden and keeps with the
> Unix tradition, no? :-\

Agreed.  Maybe there's a usecase that wants to profile a specific
cpu while the target processes are running all available cpus.

Thanks,
Namhyung
