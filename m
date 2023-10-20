Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3327D17E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJTVPX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 17:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:15:21 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0FA112
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:15:14 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-27d17f5457fso1874562a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836514; x=1698441314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZfilkoQw2CupMsJXyUJJH9aRuDysIcWfAL2PXV6lks=;
        b=tqhD3+4BamavoxjgABw3CMn4n3Nj7+LGW0rVC7vnoQeT6MTJRLhIXyeyg5jXgU3hR/
         6aaVU/+G5j744713RRi6sg6EPgzGGpDOZyCWbqEFL3RVg2d3lv04j728kkiRBBZH5LCX
         pnZSytpkWQwVP9vpea4W998l9Tphnk5wJrewrE75XOrg6t4IMC3sRojA/26tXNKKqNMM
         BzgD4Vjeon/Tq14wX6dnA85/BMlPHxj6+3wTx34BX2fCHmsNEChysEwbFMwvG95luKXQ
         XSTR98VXobUum6Ha7S8iZcT1rlftwVFux2O/P+XP/2kCZ4jYBG0Uk8OfVc4UM1zekS67
         QXdg==
X-Gm-Message-State: AOJu0Yyx/CdhLUmDDnOX2AOXZAw+2+wghCyzfOOYlqXGW3rSgg3LDPnE
        ckDaiw9qW2Lan/Mj1smvHk1dRAn7ai59cTpYuiU=
X-Google-Smtp-Source: AGHT+IFv4dz9NCt78f+xBET2+rCGQhcql7WkFWZlji8osUN9EeG9GzIL508MOCpdzjWChBec4be826G1YobxsfZOJEE=
X-Received: by 2002:a17:90a:c20d:b0:277:61d7:78be with SMTP id
 e13-20020a17090ac20d00b0027761d778bemr8688168pjt.14.1697836514280; Fri, 20
 Oct 2023 14:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <ZS7PIHUZfHcrfvi4@kernel.org> <CAM9d7cjkFQU+dd8m8pq6-u6JruY9tFi_86ZyiQrXGL9js_vuuA@mail.gmail.com>
 <ZTLkWVempj1xV6CV@kernel.org>
In-Reply-To: <ZTLkWVempj1xV6CV@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 Oct 2023 14:15:03 -0700
Message-ID: <CAM9d7cgW7PmgSj3kAowFOVLG56L=QHVCU=PfM+p7sVfQyJrt6Q@mail.gmail.com>
Subject: Re: [PATCH] perf build: Remove stray '\' before that is warned about
 since grep 3.8
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 1:34 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Oct 17, 2023 at 12:02:20PM -0700, Namhyung Kim escreveu:
> > Hi Arnaldo,
> >
> > On Tue, Oct 17, 2023 at 11:15 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > To address this grep 3.8 warning:
> > >
> > >   grep: warning: stray \ before #
> > >
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/Makefile.perf | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 456872ac410df4c0..25d5ccaec22a44fe 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -361,7 +361,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
> > >  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> > >    PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
> >
> > Do we need to change it here too?  Otherwise looks good
>
> I think I did tests and simply removing the \ in this case will comment
> out the rest of the line after the #, IIRC we would have to enclose it
> in '', like
>
>   PYTHON_EXT_SRCS := $(shell grep -v '^\#' util/python-ext-sources)
>
> But then if it works as-is, why pollute the patch? :-)
>
> In general the less lines you touch in a patch, the better, don't fix
> what isn't broken, helps reviewing, etc. :-)

Agreed, thanks!
Namhyung
