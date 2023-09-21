Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CAA7A9B58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjIUS6Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 14:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjIUS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:58:07 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFDCD255C;
        Thu, 21 Sep 2023 11:51:53 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7926a450a0aso52351139f.3;
        Thu, 21 Sep 2023 11:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322312; x=1695927112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rchX4DRYXaRpeH35NMA7XmzyCNvbFmAvUCyV3Dy7kro=;
        b=EAgSLHMY7ebbySOPs8wzAA61oBqb5X4bmrWyHpzVmUmmVn5AG+tKYlgv+mpXc8wJGO
         BdhWpjoK40OgljnZgJcVelVy2LXidJ07h8gJtDChTEkP/0XGX41lUD1AOfWpswR6jNb4
         y8eqHdTxijY5rnSIqoLyfbzFSevF5Jg35Z8rNZnYyWe83jYZmZsrreUv407gq3AyVCQC
         z9xMbDornIUS3bZLWj86x543ZI1QJlIhmJEtdGUNuj/ZtsZHgLQcw69IzTzPOZrXZuvV
         xWsGLx2yFXVR6ayt3qJ0ppsqqjqYfZnpqVndtwNRNfjfNHbJ2Fxm5/LBwidSzfrjRRyK
         w+iQ==
X-Gm-Message-State: AOJu0YxEvQfVBKdvGrgzMHUiCXYMw5md/SAyaR1HHC5uaki92eoVnfeE
        4OoWCTaw24QiKh9SfPWZ8Qw3kX1Rkf4Fqse/08I=
X-Google-Smtp-Source: AGHT+IGi2TUCiRCAaXRQw0xByOB3K1/tKIxEqPzBI1Y8i69hqsRmky+0j8LAafFwfOTSt3roH60z+9v0nyqUTtI0FnY=
X-Received: by 2002:a6b:f404:0:b0:792:881d:c6ab with SMTP id
 i4-20020a6bf404000000b00792881dc6abmr7125847iog.18.1695322311775; Thu, 21 Sep
 2023 11:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230919080929.3807123-1-xu.yang_2@nxp.com> <CAP-5=fX46xYdE2bheU+LhW2Joce+De42=d-XqBuFS9F-CPsQsg@mail.gmail.com>
 <DB7PR04MB450509DB2DBE1FAEF5F06CCD8CF9A@DB7PR04MB4505.eurprd04.prod.outlook.com>
 <CAM9d7chjjYqLrsE7+_GYJ7B5aSJtESi_0dSmahHKOGjwMYPN+w@mail.gmail.com>
In-Reply-To: <CAM9d7chjjYqLrsE7+_GYJ7B5aSJtESi_0dSmahHKOGjwMYPN+w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 21 Sep 2023 11:51:40 -0700
Message-ID: <CAM9d7cheaFnAX_iA2je1f+P-JKwGHmbkYZ9rH_k_icCawQZgqA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] perf jevents: fix no member named 'entries' issue
To:     Xu Yang <xu.yang_2@nxp.com>
Cc:     Ian Rogers <irogers@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Sep 19, 2023 at 9:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Tue, Sep 19, 2023 at 7:07 PM Xu Yang <xu.yang_2@nxp.com> wrote:
> >
> > Hi Lan,
> >
> > > On Tue, Sep 19, 2023 at 1:04 AM Xu Yang <xu.yang_2@nxp.com> wrote:
> > > >
> > > > The struct "pmu_events_table" has been changed after commit
> > > > 2e255b4f9f41 (perf jevents: Group events by PMU, 2023-08-23).
> > > > So there doesn't exist 'entries' in pmu_events_table anymore.
> > > > This will align the members with that commit. Othewise, below
> > > > errors will be printed when run jevent.py:
> > > >
> > > > pmu-events/pmu-events.c:5485:26: error: ‘struct pmu_metrics_table’ has no member named ‘entries’
> > > >  5485 |                         .entries = pmu_metrics__freescale_imx8dxl_sys,
> > > >
> > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Thanks Xu! I wasn't able to repeat the failure but the fix looks good
> > > to me. Is the failure caused by adding new imx8dxl metrics? I'd like
> >
> > Yes.
> >
> > > to make sure we have testing coverage so this doesn't happen again.
> > > I'm trying:
> > > $ make -C tools/perf O=/tmp/perf JEVENTS_ARCH=all
> > > Could you confirm that this make command was broken without your fix
> > > plus the metric changes you've done?
> >
> > Below steps will repeat the failure.
> >
> > $ cd tools/
> > $ rm perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
> > $ make clean
> > $ make JEVENTS_ARCH=all perf
> >
> > pmu-events/pmu-events.c:76586:26: error: ‘struct pmu_metrics_table’ has no member named ‘entries’
> > 76586 |                         .entries = pmu_metrics__freescale_imx8mm_sys,
> >       |                          ^~~~~~~
> > pmu-events/pmu-events.c:76587:26: error: ‘struct pmu_metrics_table’ has no member named ‘length’
> > 76587 |                         .length = ARRAY_SIZE(pmu_metrics__freescale_imx8mm_sys)
> >       |                          ^~~~~~
> >
> > If only metric table exists, then this error may occur.
>
> I can reproduce the error and confirm it fixed.
>
> Tested-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
