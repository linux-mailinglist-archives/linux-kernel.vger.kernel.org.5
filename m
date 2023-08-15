Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8432B77C9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjHOIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbjHOIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:52:43 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30018199E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:52:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-407db3e9669so159581cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692089555; x=1692694355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9VjqH/35gx4SW1CcQE2O+0pUOC2whkW3P2dy/Z+roE=;
        b=pv2BFJwrIBWY12nTH+udKOJJOq9RgmJfmRocleBgJzQENzVM5MveB6rdgoXiv/zhD5
         QhiPXrYnrEU3GHb0jCimfBS+/T4PBPI+0hQIWCdsyfQe9qBxYQ2CdQmVX+oGGBgeZ/w+
         y3yiQmALuLFLxvyqWbx1vQew4PH26Jo8qqViSskh8uiwCbaIM12JjiWxaPkuZO1N6Kl7
         uKC1g1/teeX7eyUBaGmQmXCJVWmhpe19M4g9gftJKDLCk4srRyV6zP8vnfm2lO4fi0iz
         NIQGdIpHzu+Hz8KHOWOxAZXcObS04HJCOOFwfcXDmKIrF8WHIya5nto/+HB3ZFn+eIy/
         0v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692089555; x=1692694355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9VjqH/35gx4SW1CcQE2O+0pUOC2whkW3P2dy/Z+roE=;
        b=iBYGXuDZENi5tH8iJjVVBrkTjz6K/g2H2UPhwNt+a3eVANV+sdbnszHUB6j5dg8RER
         P3zzOdEWJHMn8OYN5pgnUw5N+/Y09twWsbaMbIUYtJ4aDuWigRMSsIimOFluqsCqQOak
         HmgH3mQyhOMa6Lb5BRHkI9Fs8jRCxL95SAfzUPv6FyeiT7e6LCfkz5ckCi5cCskHCAdN
         Rmj7t3fmXPVYV5bxbwJYyuoGzdAAA6aLEct4W/bgejikLCIPYXfPzex5HBJX1MjyTsw5
         Sj1ItAmcIcY08paE1Z5dmbEiBfekt/lO1kqBPxINdK3wBFaCOupK5FYyrDsJVd0H2S5z
         5rcg==
X-Gm-Message-State: AOJu0YwRyGUsHbTox2vfSwvw5mePKupKVZPMMKJ8qwPJ2AAUfDYbBxgg
        lDZyREJ4R/y+WkJdubOXYgLfaBPwsLy98V6ALYLssw==
X-Google-Smtp-Source: AGHT+IEThtJMOYNGiQ5vHPC4N6EJyedGztOz+uhL9gmbmIxuHCx5repjszxeqnhjBgQfxk8Cx4AFSLlLTZa4rZ9cx+E=
X-Received: by 2002:a05:622a:1043:b0:3ef:302c:319e with SMTP id
 f3-20020a05622a104300b003ef302c319emr885247qte.8.1692089555285; Tue, 15 Aug
 2023 01:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <ZNOS0vo58DnVLpD8@yoga> <CAP-5=fUeOw1RKHoYL3eXbq=H-bTTNviRO2t_-11DN9KP1uEZFQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUeOw1RKHoYL3eXbq=H-bTTNviRO2t_-11DN9KP1uEZFQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Aug 2023 01:52:24 -0700
Message-ID: <CAP-5=fUdhin4AvnikpUdUDiZQU_waSgzC_1GwW5kLF1GhWhdCg@mail.gmail.com>
Subject: Re: [RESEND PATCH] perf scripts python: launch the profiler UI on the
 default browser with the appropriate URL
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 1:48=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Aug 9, 2023 at 6:21=E2=80=AFAM Anup Sharma <anupnewsmail@gmail.co=
m> wrote:
> >
> > All required libraries have been imported and make sure that
> > none of them are external dependencies. To achieve this, created
> > a virt env and verified.
> >
> > Modified usage information and added combined command.
> >
> > Modified the main() function to read the --save-only command-line
> > option and set the output_file variable accordingly.
> >
> > Modified the trace_end() function to check for the output_file variable=
.
> > If it is set, the profiler data is saved to a local file in Gecko
> > Profile format, or the profiler.firefox.com is opened on the default br=
owser.
> >
> > Included trace_begin() to initialize the Firefox Profiler and launch
> > the default browser to display the profiler.firefox.com.
> >
> > Added a new function launchFirefox() to start a local server and launch=
 the
> > profiler UI on the default browser with the appropriate URL.
> >
> > Created the "CORSRequestHandler" class to enable Cross-Origin Resource =
Sharing.
> >
> > Summary:
> > This integration now includes a exiting feature to conveniently host th=
e
> > Gecko Profile data on a local server and open it directly in the defaul=
t
> > web browser. This means that users can now effortlessly visualize and
> > analyze the profiler results with just a single click. The addition of =
the
> > --save-only command-line option allows users to save the profiler outpu=
t
> > to a local file in Gecko Profile format, but the real highlight lies
> > in the capability to seamlessly launch a local server, making the data
> > accessible to Firefox Profiler via a web browser. In addition, it's
> > important to highlight that all data are hosted locally, eliminating
> > any concerns about data privacy rules and regulations.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
>
> Hi Anup,
>
> I'm not able to replicate the behavior of a running server. What I get is=
:
> ```
> $ sudo bash -c "export PERF_EXEC_PATH=3D`pwd`/tools/perf/ && perf script
> gecko -F 99 -a sleep 1"
> Staring Firefox Profiler on your default browser...
> Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
> [ perf gecko: Captured and wrote into gecko_profile.json ]
> $
> ```
> ie the process immediately terminates. The same is true for
> record/report. Could you take a look?

Ah, running as a user it is okay.

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> > ---
> >  tools/perf/scripts/python/gecko.py | 70 +++++++++++++++++++++++++++---
> >  1 file changed, 63 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/scripts/python/gecko.py b/tools/perf/scripts/py=
thon/gecko.py
> > index 278c3aed282a..bc5a72f94bfa 100644
> > --- a/tools/perf/scripts/python/gecko.py
> > +++ b/tools/perf/scripts/python/gecko.py
> > @@ -1,4 +1,4 @@
> > -# firefox-gecko-converter.py - Convert perf record output to Firefox's=
 gecko profile format
> > +# gecko.py - Convert perf record output to Firefox's gecko profile for=
mat
> >  # SPDX-License-Identifier: GPL-2.0
> >  #
> >  # The script converts perf.data to Gecko Profile Format,
> > @@ -7,14 +7,26 @@
> >  # Usage:
> >  #
> >  #     perf record -a -g -F 99 sleep 60
> > -#     perf script report gecko > output.json
> > +#     perf script report gecko
> > +#
> > +# Combined:
> > +#
> > +#     perf script gecko -F 99 -a sleep 60
> >
> >  import os
> >  import sys
> > +import time
> >  import json
> > +import string
> > +import random
> >  import argparse
> > +import threading
> > +import webbrowser
> > +import urllib.parse
> > +from os import system
> >  from functools import reduce
> >  from dataclasses import dataclass, field
> > +from http.server import HTTPServer, SimpleHTTPRequestHandler, test
> >  from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
> >
> >  # Add the Perf-Trace-Util library to the Python path
> > @@ -40,9 +52,15 @@ CATEGORIES =3D None
> >  # The product name is used by the profiler UI to show the Operating sy=
stem and Processor.
> >  PRODUCT =3D os.popen('uname -op').read().strip()
> >
> > +# store the output file
> > +output_file =3D None
> > +
> >  # Here key =3D tid, value =3D Thread
> >  tid_to_thread =3D dict()
> >
> > +# The HTTP server is used to serve the profile to the profiler UI.
> > +http_server_thread =3D None
> > +
> >  # The category index is used by the profiler UI to show the color of t=
he flame graph.
> >  USER_CATEGORY_INDEX =3D 0
> >  KERNEL_CATEGORY_INDEX =3D 1
> > @@ -278,9 +296,19 @@ def process_event(param_dict: Dict) -> None:
> >                 tid_to_thread[tid] =3D thread
> >         thread._add_sample(comm=3Dcomm, stack=3Dstack, time_ms=3Dtime_s=
tamp)
> >
> > +def trace_begin() -> None:
> > +       global output_file
> > +       if (output_file is None):
> > +               print("Staring Firefox Profiler on your default browser=
...")
> > +               global http_server_thread
> > +               http_server_thread =3D threading.Thread(target=3Dtest, =
args=3D(CORSRequestHandler, HTTPServer,))
> > +               http_server_thread.daemon =3D True
> > +               http_server_thread.start()
> > +
> >  # Trace_end runs at the end and will be used to aggregate
> >  # the data into the final json object and print it out to stdout.
> >  def trace_end() -> None:
> > +       global output_file
> >         threads =3D [thread._to_json_dict() for thread in tid_to_thread=
.values()]
> >
> >         # Schema: https://github.com/firefox-devtools/profiler/blob/539=
70305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
> > @@ -305,22 +333,50 @@ def trace_end() -> None:
> >                 "processes": [],
> >                 "pausedRanges": [],
> >         }
> > -       json.dump(gecko_profile_with_meta, sys.stdout, indent=3D2)
> > +       # launch the profiler on local host if not specified --save-onl=
y args, otherwise print to file
> > +       if (output_file is None):
> > +               output_file =3D 'gecko_profile.json'
> > +               with open(output_file, 'w') as f:
> > +                       json.dump(gecko_profile_with_meta, f, indent=3D=
2)
> > +               launchFirefox(output_file)
> > +               time.sleep(1)
> > +               print(f'[ perf gecko: Captured and wrote into {output_f=
ile} ]')
> > +       else:
> > +               print(f'[ perf gecko: Captured and wrote into {output_f=
ile} ]')
> > +               with open(output_file, 'w') as f:
> > +                       json.dump(gecko_profile_with_meta, f, indent=3D=
2)
> > +
> > +# Used to enable Cross-Origin Resource Sharing (CORS) for requests com=
ing from 'https://profiler.firefox.com', allowing it to access resources fr=
om this server.
> > +class CORSRequestHandler(SimpleHTTPRequestHandler):
> > +       def end_headers (self):
> > +               self.send_header('Access-Control-Allow-Origin', 'https:=
//profiler.firefox.com')
> > +               SimpleHTTPRequestHandler.end_headers(self)
> > +
> > +# start a local server to serve the gecko_profile.json file to the pro=
filer.firefox.com
> > +def launchFirefox(file):
> > +       safe_string =3D urllib.parse.quote_plus(f'http://localhost:8000=
/{file}')
> > +       url =3D 'https://profiler.firefox.com/from-url/' + safe_string
> > +       webbrowser.open(f'{url}')
> >
> >  def main() -> None:
> > +       global output_file
> >         global CATEGORIES
> > -       parser =3D argparse.ArgumentParser(description=3D"Convert perf.=
data to Firefox\'s Gecko Profile format")
> > +       parser =3D argparse.ArgumentParser(description=3D"Convert perf.=
data to Firefox\'s Gecko Profile format which can be uploaded to profiler.f=
irefox.com for visualization")
> >
> >         # Add the command-line options
> >         # Colors must be defined according to this:
> >         # https://github.com/firefox-devtools/profiler/blob/50124adbfa4=
88adba6e2674a8f2618cf34b59cd2/res/css/categories.css
> > -       parser.add_argument('--user-color', default=3D'yellow', help=3D=
'Color for the User category')
> > -       parser.add_argument('--kernel-color', default=3D'orange', help=
=3D'Color for the Kernel category')
> > +       parser.add_argument('--user-color', default=3D'yellow', help=3D=
'Color for the User category', choices=3D['yellow', 'blue', 'purple', 'gree=
n', 'orange', 'red', 'grey', 'magenta'])
> > +       parser.add_argument('--kernel-color', default=3D'orange', help=
=3D'Color for the Kernel category', choices=3D['yellow', 'blue', 'purple', =
'green', 'orange', 'red', 'grey', 'magenta'])
> > +       # If --save-only is specified, the output will be saved to a fi=
le instead of opening Firefox's profiler directly.
> > +       parser.add_argument('--save-only', help=3D'Save the output to a=
 file instead of opening Firefox\'s profiler')
> > +
> >         # Parse the command-line arguments
> >         args =3D parser.parse_args()
> >         # Access the values provided by the user
> >         user_color =3D args.user_color
> >         kernel_color =3D args.kernel_color
> > +       output_file =3D args.save_only
> >
> >         CATEGORIES =3D [
> >                 {
> > @@ -336,4 +392,4 @@ def main() -> None:
> >         ]
> >
> >  if __name__ =3D=3D '__main__':
> > -    main()
> > +       main()
> > --
> > 2.34.1
> >
