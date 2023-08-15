Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2C77D16A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbjHORzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbjHORzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D361FE1;
        Tue, 15 Aug 2023 10:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46CA76294E;
        Tue, 15 Aug 2023 17:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826F4C433C8;
        Tue, 15 Aug 2023 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692122079;
        bh=v29yDhYqu508UQ8smlIqAL9ArZexf9sYdXW1jtQ2aSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5PBC9NgvXb+hUlkV3FwE13f6/nLqmwy1aNbcly67fXbELbyzRsbRD1agQfAJAtIv
         PD7peKiprOF8VMP06evXjhxI3jcfv0OEfnuR1TXIH/AxlLcBjTxGqYX6qS3ECSoAq8
         SLDMiEUShvpiSkTVQ1q4Lblg8Col124/G1uDkJzNSWYYLDTEk+TyJ5V7JlIK9uiotB
         AvIY8zQIMGrHignUS/FrmapQkxPFfYq6agAW4uPiYL18EgQw+6ygoUZYX1PaP9QTdE
         jvJADhrcvEuB7Iy1YXyxqfm9jBMwGX136JREc+FvQtdfdHR+Gd7kRoKNYoYWavVZcq
         cloy8uf4O5Qiw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BAE8F404DF; Tue, 15 Aug 2023 14:54:36 -0300 (-03)
Date:   Tue, 15 Aug 2023 14:54:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf dlfilter: Add a test for resolve_address()
Message-ID: <ZNu73JK+rmmTMGBN@kernel.org>
References: <20230731091857.10681-1-adrian.hunter@intel.com>
 <ZMwTYsh8KIwphOR5@kernel.org>
 <CAP-5=fW+Y+4dk_TL2RuOJWwnqd3cvhVARoRVSdmhiiVaNwEnfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW+Y+4dk_TL2RuOJWwnqd3cvhVARoRVSdmhiiVaNwEnfw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 14, 2023 at 10:28:29AM -0700, Ian Rogers escreveu:
> On Thu, Aug 3, 2023 at 1:51 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Mon, Jul 31, 2023 at 12:18:55PM +0300, Adrian Hunter escreveu:
> > > Extend the "dlfilter C API" test to test
> > > perf_dlfilter_fns.resolve_address(). The test currently fails, but passes
> > > after a subsequent patch.
> >
> > Ian,
> >
> >         I think this is ok now, can you please take a look and perhaps
> > provide an Acked-by or Reviewed-by?
> 
> Sorry, found this in my backlog. I'm a little confused over which
> patch series is current but they all lgtm.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > ---
> > >  tools/perf/dlfilters/dlfilter-test-api-v0.c | 26 ++++++++++++++++++++-
> > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
> > > index b1f51efd67d6..72f263d49121 100644
> > > --- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
> > > +++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
> > > @@ -254,6 +254,30 @@ static int check_addr_al(void *ctx)
> > >       return 0;
> > >  }
> > >
> > > +static int check_address_al(void *ctx, const struct perf_dlfilter_sample *sample)
> > > +{
> > > +     struct perf_dlfilter_al address_al;
> > > +     const struct perf_dlfilter_al *al;
> > > +
> > > +     al = perf_dlfilter_fns.resolve_ip(ctx);
> > > +     if (!al)
> > > +             return test_fail("resolve_ip() failed");
> > > +
> > > +     address_al.size = sizeof(address_al);
> > > +     if (perf_dlfilter_fns.resolve_address(ctx, sample->ip, &address_al))
> > > +             return test_fail("resolve_address() failed");
> > > +
> > > +     CHECK(address_al.sym && al->sym);
> > > +     CHECK(!strcmp(address_al.sym, al->sym));
> > > +     CHECK(address_al.addr == al->addr);
> > > +     CHECK(address_al.sym_start == al->sym_start);
> > > +     CHECK(address_al.sym_end == al->sym_end);
> > > +     CHECK(address_al.dso && al->dso);
> > > +     CHECK(!strcmp(address_al.dso, al->dso));
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  static int check_attr(void *ctx)
> > >  {
> > >       struct perf_event_attr *attr = perf_dlfilter_fns.attr(ctx);
> > > @@ -290,7 +314,7 @@ static int do_checks(void *data, const struct perf_dlfilter_sample *sample, void
> > >       if (early && !d->do_early)
> > >               return 0;
> > >
> > > -     if (check_al(ctx) || check_addr_al(ctx))
> > > +     if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, sample))
> > >               return -1;
> > >
> > >       if (early)
> > > --
> > > 2.34.1
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
