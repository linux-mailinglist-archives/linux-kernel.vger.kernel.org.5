Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61C7D171C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjJTUej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjJTUei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:34:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A2C0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:34:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C429C433C8;
        Fri, 20 Oct 2023 20:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697834076;
        bh=LIk4pD6r0C8MAceeSc7n/uK/kd++PAcf0hHLW1YT2YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pL0hSIJ6yct7jTkjgsaDXZ68Vz8wLV4hTyUfcUpRdHgrVw53VgMjGvnw3ADHn3sot
         Y0eAdL5wLp2f5w2fxvjIuIorOE9Ey0nBeAc43L14evtQSCqqJ06GeKxq+6gwn74JiR
         cGpc50EoSIFS0xgQfJmLDVmWXlIXTtKfFv6x/8wzNHWT4c8EMAAwYsqyi+BuUV+III
         JlBIwXHs36YREKzsBEe7AkQXEZZZwC/+Y33o1ZmbxuWOS7S3NEjKkx0KIi+fYOc/AW
         7hL5edQ88wZMcuS6wHDbnmwccKjtj/lWvoNMn8R46l6vzKcNTlxR6TNHdpQYpzIYVD
         mUMZtNwAG8/XQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB5154035D; Fri, 20 Oct 2023 17:34:33 -0300 (-03)
Date:   Fri, 20 Oct 2023 17:34:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf build: Remove stray '\' before that is warned about
 since grep 3.8
Message-ID: <ZTLkWVempj1xV6CV@kernel.org>
References: <ZS7PIHUZfHcrfvi4@kernel.org>
 <CAM9d7cjkFQU+dd8m8pq6-u6JruY9tFi_86ZyiQrXGL9js_vuuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjkFQU+dd8m8pq6-u6JruY9tFi_86ZyiQrXGL9js_vuuA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 17, 2023 at 12:02:20PM -0700, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Tue, Oct 17, 2023 at 11:15 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > To address this grep 3.8 warning:
> >
> >   grep: warning: stray \ before #
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/Makefile.perf | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 456872ac410df4c0..25d5ccaec22a44fe 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -361,7 +361,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
> >  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> >    PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
> 
> Do we need to change it here too?  Otherwise looks good

I think I did tests and simply removing the \ in this case will comment
out the rest of the line after the #, IIRC we would have to enclose it
in '', like

  PYTHON_EXT_SRCS := $(shell grep -v '^\#' util/python-ext-sources)

But then if it works as-is, why pollute the patch? :-)

In general the less lines you touch in a patch, the better, don't fix
what isn't broken, helps reviewing, etc. :-)

- Arnaldo
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 
> 
> >  else
> > -  PYTHON_EXT_SRCS := $(shell grep -v '^\#\|util/trace-event.c' util/python-ext-sources)
> > +  PYTHON_EXT_SRCS := $(shell grep -v '^#\|util/trace-event.c' util/python-ext-sources)
> >  endif
> >
> >  PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
> > --
> > 2.41.0
> >

-- 

- Arnaldo
