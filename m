Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A23792667
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbjIEQVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354560AbjIEMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:40:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C6F18D;
        Tue,  5 Sep 2023 05:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59731B811EA;
        Tue,  5 Sep 2023 12:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC99C433C7;
        Tue,  5 Sep 2023 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693917606;
        bh=ZUN15+7Vyk5IoUudEUqouA7xZLURmNHDNxbTpmZ1Jj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FK80e1jI90yRK9VG2Wng+aZqrLbvt80jBUqkksvYVN/xcWCXrZTuf1mbaeXQdfH4P
         5bE/D3E9J0ow5PYvTy+ABeCaeMlMsYwVtPcP5gC3rgfBDzkpCs213oiK6e8yYDdHfC
         YOuhhNSd9yvEvsfjRvhxYqIs7khKR1OQhsAvXv6Mis9nVvO46R2KToA6IVqvCRGrpG
         j9qSGwo0lcgw5NheBEFVNJuuMPkzskFP7VM3lWmlgVB36TqYtCrpbzN2XaoucNBoLd
         MrWyQpu5XxePXEQMqVMbnf0BhRwru/VylosH8aGNUw67118fYpK03RKmh80SiXezDy
         HnEW1YLfrJvuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBA3840722; Tue,  5 Sep 2023 09:40:02 -0300 (-03)
Date:   Tue, 5 Sep 2023 09:40:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH v1] perf parse-events: Fix driver config term
Message-ID: <ZPchophIpGM+gT4f@kernel.org>
References: <20230905033805.3094293-1-irogers@google.com>
 <CAP-5=fVWNnV792eVDiiMMF0gs88Ao7o1=VLeGBZOWm6MjO3kng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVWNnV792eVDiiMMF0gs88Ao7o1=VLeGBZOWm6MjO3kng@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 04, 2023 at 08:51:37PM -0700, Ian Rogers escreveu:
> On Mon, Sep 4, 2023 at 8:38 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Inadvertently deleted in commit 30f4ade33d64 ("perf tools: Revert
> > enable indices setting syntax for BPF map").
> >
> 
> Sorry, should also have:
> Fixes: 30f4ade33d64 ("perf tools: Revert enable indices setting syntax
> for BPF map")

I added it, thanks.
 
> Thanks,
> Ian
> 
> > Reported-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.y | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 4a305df61f74..21bfe7e0d944 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -839,6 +839,23 @@ PE_TERM
> >
> >         $$ = term;
> >  }
> > +|
> > +PE_DRV_CFG_TERM
> > +{
> > +       struct parse_events_term *term;
> > +       char *config = strdup($1);
> > +       int err;
> > +
> > +       if (!config)
> > +               YYNOMEM;
> > +       err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG, config, $1, &@1, NULL);
> > +       if (err) {
> > +               free($1);
> > +               free(config);
> > +               PE_ABORT(err);
> > +       }
> > +       $$ = term;
> > +}
> >
> >  sep_dc: ':' |
> >
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >

-- 

- Arnaldo
