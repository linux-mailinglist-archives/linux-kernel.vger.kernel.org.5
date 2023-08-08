Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E343774227
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjHHRf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjHHRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434DF97D59
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AB4362588
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AAEC433CB;
        Tue,  8 Aug 2023 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691502569;
        bh=ac2ZNrrHe60sCkPhD7Xvy6kB+S6vicCsf9m3C0f3i5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uq/k/HxlJhFk9rxHMvLrdjTL3oY9wYMi83xdKq7dTCt+Xea0dnPjVC/jVNJuEQQvR
         YBlnvR3irdWkmPnkOvQgkZb4l6weMXMjKZL2rYWoKl3S0MZEvUfCvWAgwm0TFKZOV8
         dljLLr1PqoFHAQdmAUjNo7KxyKpLrPv5O9I2GfGjNHTbCABS3g0hqPlh9QvH2gQ7K+
         u6zEio9b7wLhIWYJiBiUg72pLA7NF7DcZsOoO5zOp8QYAOlvEunZa3b1+KCUnDJVZx
         4/K7G7zdcQYQEFgyzusaEYpHMOue4sQVP/mgZ43Br0Sm6i/YODY4H7G8PdlVLV2KXM
         oCwqY4irKgL9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C9D73404DF; Tue,  8 Aug 2023 10:49:26 -0300 (-03)
Date:   Tue, 8 Aug 2023 10:49:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     Artem Savkov <asavkov@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Revert "perf report: Append inlines to non-DWARF
 callchains"
Message-ID: <ZNJH5pKWvEKu8ovm@kernel.org>
References: <ZMl8VyhdwhClTM5g@kernel.org>
 <20230802074335.GA622710@alecto.usersys.redhat.com>
 <20230807110008.GA886657@alecto.usersys.redhat.com>
 <ZNDy9EBLsUlERql6@kernel.org>
 <20230807140343.GA910089@alecto.usersys.redhat.com>
 <d52110ea-fd5a-535f-2ad1-5cfb63db88bf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52110ea-fd5a-535f-2ad1-5cfb63db88bf@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 08, 2023 at 03:38:37PM +0200, Jesper Dangaard Brouer escreveu:
> 
> 
> On 07/08/2023 16.03, Artem Savkov wrote:
> > On Mon, Aug 07, 2023 at 10:34:44AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Aug 07, 2023 at 01:00:08PM +0200, Artem Savkov escreveu:
> > > > On Wed, Aug 02, 2023 at 09:43:40AM +0200, Artem Savkov wrote:
> > > > > Hi Arnaldo,
> > > > > 
> > > > > On Tue, Aug 01, 2023 at 06:42:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > Hi Artem,
> > > > > > 
> > > > > > 	Can you please double check this? I reproduced with:
> > > > > > 
> > > > > > git checkout 46d21ec067490ab9cdcc89b9de5aae28786a8b8e
> > > > > > build it
> > > > > > perf record -a -g sleep 5s
> > > > > > perf report
> > > > > > 
> > > > > > 	Do you get the same slowness and then reverting it, i.e. just
> > > > > > going to HEAD~ and rebuilding getting a fast 'perf report' startup, i.e.
> > > > > > without the inlines in the callchains?
> > > > > 
> > > > > With a simple test like this I definitely get a slowdown, but not sure
> > > > > if it can be called excessive.
> > > > > 
> > > > > Below are the times I got by running 'time perf report' and hitting 'q'
> > > > > during load so that it quits as soon as it is loads up. Tested on a
> > > > > freshly updated fedora 38.
> > > > 
> 
> I reported this problem to ACME. It is also possible to reproduce
> without hitting 'q' via using this cmdline with --stdio like this:
> 
>  time perf report -v --stdio > /dev/null 2> debug01.stderr
> 
> The file 'debug01.stderr' contained a lot of addr2line output, that
> might help debug the issue further.
> 
> 
> 
> > > > My bad, I had wrong debuginfo installed for the kernel I tested. I can
> > > > reproduce it with the correct one. Looks like vmlinux is just too much
> > > > for addr2line. Maybe we can skip it but leave other inlines in, like so:
> > > 
> > > That is a possibilit, and probably we could make it cheaper by looking
> > > at the cpumode, avoiding calling addr2line when we didn't makage to
> > > resolve the symbol, etc.
> > > 
> > > We also may want to have this as an option that has to be explicitely
> > > enabled, like --resolve-inlines, as this will add overhead no matter if
> > > we stop calling addr2line and do it more efficiently, etc.
> > 
> > Sounds good, I'll look into it.
> > 
> > > Fact is, we're late in the 6.5 schedule, so the best thing now is to
> > > just revert the patch and then try again later, ok?
> > 
> > Yes, sure.
> > 
> > > - Arnaldo
> > > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > > index 11de3ca8d4fa7..fef309cd401f7 100644
> > > > --- a/tools/perf/util/machine.c
> > > > +++ b/tools/perf/util/machine.c
> > > > @@ -2388,7 +2388,9 @@ static int add_callchain_ip(struct thread *thread,
> > > >   	ms.map = map__get(al.map);
> > > >   	ms.sym = al.sym;
> > > > -	if (!branch && append_inlines(cursor, &ms, ip) == 0)
> > > > +	if (!branch && ms.map && ms.map->dso &&
> > > > +	    strcmp(ms.map->dso->short_name, "[kernel.vmlinux]") &&
> > > > +	    append_inlines(cursor, &ms, ip) == 0)
> > > >   		goto out;
> > > >   	srcline = callchain_srcline(&ms, al.addr);
> > > > 
> > > > > > - Arnaldo
> > > > > > 
> > > > > > ----
> > > > > > 
> > > > > > This reverts commit 46d21ec067490ab9cdcc89b9de5aae28786a8b8e.
> > > > > > 
> > > > > > The tests were made with a specific workload, further tests on a
> > > > > > recently updated fedora 38 system with a system wide perf.data file
> > > > > > shows 'perf report' taking excessive time, so lets revert this until a
> > > > > > full investigation and improvement on the addr2line support code is
> > > > > > made.
> > > > > > 
> 
> Reported-by: Jesper Dangaard Brouer <hawk@kernel.org>

Thanks, I did add that locally, will keep it and add your Tested-by,
thanks a lot!

- Arnaldo
 
> > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > Cc: Artem Savkov <asavkov@redhat.com>
> > > > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > > > > Cc: Ian Rogers <irogers@google.com>
> > > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > > Cc: Milian Wolff <milian.wolff@kdab.com>
> > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > > ---
> > > > > >   tools/perf/util/machine.c | 5 -----
> > > > > >   1 file changed, 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > > > > index 4e62843d51b7dbf9..f4cb41ee23cdbcfc 100644
> > > > > > --- a/tools/perf/util/machine.c
> > > > > > +++ b/tools/perf/util/machine.c
> > > > > > @@ -45,7 +45,6 @@
> > > > > >   static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
> > > > > >   				     struct thread *th, bool lock);
> > > > > > -static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
> > > > > >   static struct dso *machine__kernel_dso(struct machine *machine)
> > > > > >   {
> > > > > > @@ -2385,10 +2384,6 @@ static int add_callchain_ip(struct thread *thread,
> > > > > >   	ms.maps = maps__get(al.maps);
> > > > > >   	ms.map = map__get(al.map);
> > > > > >   	ms.sym = al.sym;
> > > > > > -
> > > > > > -	if (!branch && append_inlines(cursor, &ms, ip) == 0)
> > > > > > -		goto out;
> > > > > > -
> > > > > >   	srcline = callchain_srcline(&ms, al.addr);
> > > > > >   	err = callchain_cursor_append(cursor, ip, &ms,
> > > > > >   				      branch, flags, nr_loop_iter,
> 
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> --Jesper

-- 

- Arnaldo
