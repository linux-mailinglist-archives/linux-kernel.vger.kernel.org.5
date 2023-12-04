Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D984D803F49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjLDU1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:27:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3FCCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:27:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A2FC433C8;
        Mon,  4 Dec 2023 20:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701721656;
        bh=3UM0vBZGSpHc/APPrPZ8DjPjv6AEs/OPlh26tPoK9O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFG91LHh+C4t7h5Fq9XGJmt0LMF/keh8bqC95G04byB1MAbjjZ3anlvBs+MWzaAlo
         OvHoYW30GSBecFq84cytmQ7NZ+KnKAxvfzGAlRT1gnyRkfVRklqaUbmCJB3sLw3VHW
         wn6zu08jHrL4AuSBaY4/C7TyUDMChpezO7HwtkA3X5BwdDjAG+JDUdnP4hxF2FdXxj
         IomaqrXfxetvJA/EsmBK7g81OYqXDZEe+rD3OeyLayYYOBcuIeByVp5T751hQ3zXq4
         XuC1AdVz8Fi2W2u01ckGHNLa0M1LddxWO92ANuLj/T6l6Lsjr7eq7h2Hn9mfXIWG8J
         v64ipQ4CRSo5g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2338E40094; Mon,  4 Dec 2023 17:27:34 -0300 (-03)
Date:   Mon, 4 Dec 2023 17:27:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf/benchmark: Fix spelling mistake
 "synchronious" -> "synchronous"
Message-ID: <ZW42NiB4VK7Dp7oP@kernel.org>
References: <20230630080029.15614-1-colin.i.king@gmail.com>
 <CAM9d7ch8GcZUXVEtPGh2QW8-_aiObq7ybU_7gY7LMcjRfOFvxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ch8GcZUXVEtPGh2QW8-_aiObq7ybU_7gY7LMcjRfOFvxw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 01, 2023 at 10:57:33AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Fri, Jun 30, 2023 at 1:00 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > There is a spelling mistake in an option description. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  tools/perf/bench/sched-seccomp-notify.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hmm.. strange.  I cannot see the bench/sched-seccomp-notify.c.
> Which tree are you based?

It went thru a different tree, but I got this while looking for
Acked-by patches and finally applied it.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> >
> > diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/sched-seccomp-notify.c
> > index eac4ef60090f..2e8205c61141 100644
> > --- a/tools/perf/bench/sched-seccomp-notify.c
> > +++ b/tools/perf/bench/sched-seccomp-notify.c
> > @@ -33,7 +33,7 @@ static bool sync_mode;
> >  static const struct option options[] = {
> >         OPT_U64('l', "loop",    &loops,         "Specify number of loops"),
> >         OPT_BOOLEAN('s', "sync-mode", &sync_mode,
> > -                   "Enable the synchronious mode for seccomp notifications"),
> > +                   "Enable the synchronous mode for seccomp notifications"),
> >         OPT_END()
> >  };
> >
> > --
> > 2.39.2
> >

-- 

- Arnaldo
