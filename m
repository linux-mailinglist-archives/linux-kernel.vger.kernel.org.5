Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35F07567B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjGQPWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjGQPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:21:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8E310E3;
        Mon, 17 Jul 2023 08:21:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666eec46206so4762969b3a.3;
        Mon, 17 Jul 2023 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689607239; x=1692199239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z+9axMsQJLeztv/jtIsPFrb695KemJk12Qdi8hyVSxc=;
        b=RwMr9J4Siy7s/bgP86jf2/tpp9hQdx27OCaFJ9SOfXk+/D6VD8u+5SV63dFZODsB/c
         COwDvnq21kxHGf88FO+d+iwNYaRs6IEWwB0ClA7T1Y67lrnOm6aIsIui1mr/iJ4GNC97
         XUUCjvaWqhUAMDqXa6ccYSAefWRiPsFTmFg2rkIrkeRbJk+HUE6VvwwpbPpaGDnX2XWb
         WPnknulItPnNOVRlo+lUmeURVE0I3PoWMEypy8UTnrT3m+IhqBWkuw+SZIrGnSESDjjk
         yz3/MrziZYrKGE1qT7fAAQppBtW7fmaUyADkZP5qKvvKg84RZfwDXLXJooSHi3f4Tpn7
         ovzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607239; x=1692199239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+9axMsQJLeztv/jtIsPFrb695KemJk12Qdi8hyVSxc=;
        b=SFIARHgPc8MozFBP45/9FXPm5JzqGRw2T3ggb6ilmUFU3dGWLHbGRDSoObAUkpNmvX
         AlkAQ6nNlDiAyub235WapbcUyUMY4XCrRGbN/rKfFefb7TbXsBvx8glfy1gktkJGkKTH
         vNEKnjNQ6yMLiVoCtO8Kio0JW517UfF0LVtd14iiAud/Rjk3HwmZgV5/G4jMJodNtgzM
         0Rw2yDPpJl0YsawSdr0cf7s7st/OgNHyQBY6dbRcgDSLYmZfioFmEihSrSkK0XFhvDXR
         Ig+3JrY1E+xNLz0ZjpyzlDMDk0uGMD77pwtxwmyD/Et59v17kfwiSQFEl4JSGKbtxkza
         b5Yw==
X-Gm-Message-State: ABy/qLaDL7lQmqx/DIrjUVK5DwsqOb+81ny5e8vTjvQwj9F8yZu5lJvX
        iIjllC1O1lCJK8n7Ga1FeU0=
X-Google-Smtp-Source: APBJJlHWWrE8x2IGxBP2h84nm6ucOqSL8AVtoXx1IBoCuBUQfij7rAxoa0dMAC6qrjoYHbIWnfKvng==
X-Received: by 2002:a17:902:c949:b0:1b8:b5f8:c485 with SMTP id i9-20020a170902c94900b001b8b5f8c485mr15761521pla.50.1689607238728;
        Mon, 17 Jul 2023 08:20:38 -0700 (PDT)
Received: from yoga ([2400:1f00:13:50e2:5893:783e:fde0:1bce])
        by smtp.gmail.com with ESMTPSA id im16-20020a170902bb1000b001b83e5ec666sm42785plb.6.2023.07.17.08.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:20:38 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Mon, 17 Jul 2023 20:50:31 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] scripts: python: Add initial script file with
 imports
Message-ID: <ZLVcP77aI7dGQCdI@yoga>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
 <5d3727bacffa331cd81a059fc3122cfb3f43dabd.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fVOTstw=V2dsyfqQV1NB24ePOkqxUtF1g==5TGk5i3Phg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVOTstw=V2dsyfqQV1NB24ePOkqxUtF1g==5TGk5i3Phg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 09:50:40AM -0700, Ian Rogers wrote:
> On Mon, Jul 10, 2023 at 4:09 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > Added the necessary modules, including the Perf-Trace-Util
> > library, and defines the required functions and variables.
> > It leverages the perf_trace_context and Core modules for
> > tracing and processing events. Also added usage information.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > new file mode 100644
> > index 000000000000..5b342641925c
> > --- /dev/null
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -0,0 +1,28 @@
> > +# firefox-gecko-converter.py - Convert perf record output to Firefox's gecko profile format
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# The script converts perf.data to Gecko Profile Format,
> > +# which can be read by https://profiler.firefox.com/.
> > +#
> > +# Usage:
> > +#
> > +#     perf record -a -g -F 99 sleep 60
> > +#     perf script firefox-gecko-converter.py > output.json
> > +
> > +import os
> > +import sys
> > +import json
> > +from functools import reduce
> > +
> 
> nit: technically some of these imports should be added when necessary
> in the code.

Noted.

> > +# Add the Perf-Trace-Util library to the Python path
> > +sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> > +       '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> > +
> > +from perf_trace_context import *
> > +from Core import *
> > +
> > +def trace_end():
> > +       pass
> > +
> > +def process_event(param_dict):
> 
> nit: (this is likely addressed in later patches) you can add return
> and parameter types here to aid understanding of the code. Function
> comments are also useful.

Noted.

> > +       pass
> > --
> > 2.34.1
> >
