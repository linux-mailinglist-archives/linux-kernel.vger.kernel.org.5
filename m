Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF2577C9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjHOIss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjHOIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:48:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284019B1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:48:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-407db3e9669so158791cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692089303; x=1692694103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szxz5Etsg2s1lA7rVQCB/9CBmF6jWbo2r/p3Z3TbM+s=;
        b=ER4ew9hSog1KZ3kXveFpglawPAU9W1nRDOet62DzfAnkrmf49wDAR7f0AnqU5d002T
         FnKsgAjANpIzMW2cG6Fk+iNq82BaLbr+fOPFyzEuCHzCkhj5/vY4qRQbunaiCC9k39OF
         Zh0c8a5sdnYrcSfD3uByktsAbHW5KwaYTydEtwt/idqWd3CBUNS2ctwAueaoTTGUuoES
         4kOjiRb0CckIxAWxw6xUzNlBj8AO+fGYJw3hKFlNTcgOP8pktLwboc2OvZcypXUcg+lR
         +z/QJydduzCnN90mN5s0/HySI19YDSco/gvCGuEWglUxvs0VjnRyTSs5NnDyHMEewFjE
         Anbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692089303; x=1692694103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szxz5Etsg2s1lA7rVQCB/9CBmF6jWbo2r/p3Z3TbM+s=;
        b=IT68uvhong1ReWOQr8Wb15p12GF1z4xwcMKBpAkQDuJwiLkbkoUwHeclQWwd23xAFA
         UQ4ipWrCaQJfXnLxZZXQh1T0NfoWx1NtRFU+y6ZIk2UC1gqVVqgNcPjntzt0B8o/hjGI
         cnaA6gZ56FI5HIzIhelfyunIDZjgSjO7szaqAR1g7KRBXaCVQLCNAo0SEQ9fZRLbO8lk
         4HVRqQbbWBi9Ou/T1qI6/sKjd3eQBUHpD8QDeEAXHwvmDx7LVosIvsiHSU8oFH5M1Igo
         XEBXIWmNhrzDMTX2XffX1nvwAJ0vZuD5WTCn2o45qWygIp9YjeToZixN+Wuj3AZTy+Ni
         kjrg==
X-Gm-Message-State: AOJu0Yy6gVu9D4nEibBIsiROZRdVRaY/dnXzF3v4TMmPMxGvR0fASYXw
        Npx6ZWhEGXd1EDaR0o/sJqvNcvpl+WLT7qqC4XZxsQ==
X-Google-Smtp-Source: AGHT+IHkkWejXP9e4S0PKZDxHwfMsk4EsI0XW56tDoalkBIxf27AVdrnF92Zfc3masrm3/UFnD+XggGFfpe8hB4rPH0=
X-Received: by 2002:a05:622a:1104:b0:3e0:c2dd:fd29 with SMTP id
 e4-20020a05622a110400b003e0c2ddfd29mr897448qty.4.1692089303083; Tue, 15 Aug
 2023 01:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <ZNOS0vo58DnVLpD8@yoga>
In-Reply-To: <ZNOS0vo58DnVLpD8@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Aug 2023 01:48:11 -0700
Message-ID: <CAP-5=fUeOw1RKHoYL3eXbq=H-bTTNviRO2t_-11DN9KP1uEZFQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 6:21=E2=80=AFAM Anup Sharma <anupnewsmail@gmail.com>=
 wrote:
>
> All required libraries have been imported and make sure that
> none of them are external dependencies. To achieve this, created
> a virt env and verified.
>
> Modified usage information and added combined command.
>
> Modified the main() function to read the --save-only command-line
> option and set the output_file variable accordingly.
>
> Modified the trace_end() function to check for the output_file variable.
> If it is set, the profiler data is saved to a local file in Gecko
> Profile format, or the profiler.firefox.com is opened on the default brow=
ser.
>
> Included trace_begin() to initialize the Firefox Profiler and launch
> the default browser to display the profiler.firefox.com.
>
> Added a new function launchFirefox() to start a local server and launch t=
he
> profiler UI on the default browser with the appropriate URL.
>
> Created the "CORSRequestHandler" class to enable Cross-Origin Resource Sh=
aring.
>
> Summary:
> This integration now includes a exiting feature to conveniently host the
> Gecko Profile data on a local server and open it directly in the default
> web browser. This means that users can now effortlessly visualize and
> analyze the profiler results with just a single click. The addition of th=
e
> --save-only command-line option allows users to save the profiler output
> to a local file in Gecko Profile format, but the real highlight lies
> in the capability to seamlessly launch a local server, making the data
> accessible to Firefox Profiler via a web browser. In addition, it's
> important to highlight that all data are hosted locally, eliminating
> any concerns about data privacy rules and regulations.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Hi Anup,

I'm not able to replicate the behavior of a running server. What I get is:
```
$ sudo bash -c "export PERF_EXEC_PATH=3D`pwd`/tools/perf/ && perf script
gecko -F 99 -a sleep 1"
Staring Firefox Profiler on your default browser...
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
[ perf gecko: Captured and wrote into gecko_profile.json ]
$
```
ie the process immediately terminates. The same is true for
record/report. Could you take a look?

Thanks,
Ian

> ---
>  tools/perf/scripts/python/gecko.py | 70 +++++++++++++++++++++++++++---
>  1 file changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/scripts/python/gecko.py b/tools/perf/scripts/pyth=
on/gecko.py
> index 278c3aed282a..bc5a72f94bfa 100644
> --- a/tools/perf/scripts/python/gecko.py
> +++ b/tools/perf/scripts/python/gecko.py
> @@ -1,4 +1,4 @@
> -# firefox-gecko-converter.py - Convert perf record output to Firefox's g=
ecko profile format
> +# gecko.py - Convert perf record output to Firefox's gecko profile forma=
t
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # The script converts perf.data to Gecko Profile Format,
> @@ -7,14 +7,26 @@
>  # Usage:
>  #
>  #     perf record -a -g -F 99 sleep 60
> -#     perf script report gecko > output.json
> +#     perf script report gecko
> +#
> +# Combined:
> +#
> +#     perf script gecko -F 99 -a sleep 60
>
>  import os
>  import sys
> +import time
>  import json
> +import string
> +import random
>  import argparse
> +import threading
> +import webbrowser
> +import urllib.parse
> +from os import system
>  from functools import reduce
>  from dataclasses import dataclass, field
> +from http.server import HTTPServer, SimpleHTTPRequestHandler, test
>  from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
>
>  # Add the Perf-Trace-Util library to the Python path
> @@ -40,9 +52,15 @@ CATEGORIES =3D None
>  # The product name is used by the profiler UI to show the Operating syst=
em and Processor.
>  PRODUCT =3D os.popen('uname -op').read().strip()
>
> +# store the output file
> +output_file =3D None
> +
>  # Here key =3D tid, value =3D Thread
>  tid_to_thread =3D dict()
>
> +# The HTTP server is used to serve the profile to the profiler UI.
> +http_server_thread =3D None
> +
>  # The category index is used by the profiler UI to show the color of the=
 flame graph.
>  USER_CATEGORY_INDEX =3D 0
>  KERNEL_CATEGORY_INDEX =3D 1
> @@ -278,9 +296,19 @@ def process_event(param_dict: Dict) -> None:
>                 tid_to_thread[tid] =3D thread
>         thread._add_sample(comm=3Dcomm, stack=3Dstack, time_ms=3Dtime_sta=
mp)
>
> +def trace_begin() -> None:
> +       global output_file
> +       if (output_file is None):
> +               print("Staring Firefox Profiler on your default browser..=
.")
> +               global http_server_thread
> +               http_server_thread =3D threading.Thread(target=3Dtest, ar=
gs=3D(CORSRequestHandler, HTTPServer,))
> +               http_server_thread.daemon =3D True
> +               http_server_thread.start()
> +
>  # Trace_end runs at the end and will be used to aggregate
>  # the data into the final json object and print it out to stdout.
>  def trace_end() -> None:
> +       global output_file
>         threads =3D [thread._to_json_dict() for thread in tid_to_thread.v=
alues()]
>
>         # Schema: https://github.com/firefox-devtools/profiler/blob/53970=
305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
> @@ -305,22 +333,50 @@ def trace_end() -> None:
>                 "processes": [],
>                 "pausedRanges": [],
>         }
> -       json.dump(gecko_profile_with_meta, sys.stdout, indent=3D2)
> +       # launch the profiler on local host if not specified --save-only =
args, otherwise print to file
> +       if (output_file is None):
> +               output_file =3D 'gecko_profile.json'
> +               with open(output_file, 'w') as f:
> +                       json.dump(gecko_profile_with_meta, f, indent=3D2)
> +               launchFirefox(output_file)
> +               time.sleep(1)
> +               print(f'[ perf gecko: Captured and wrote into {output_fil=
e} ]')
> +       else:
> +               print(f'[ perf gecko: Captured and wrote into {output_fil=
e} ]')
> +               with open(output_file, 'w') as f:
> +                       json.dump(gecko_profile_with_meta, f, indent=3D2)
> +
> +# Used to enable Cross-Origin Resource Sharing (CORS) for requests comin=
g from 'https://profiler.firefox.com', allowing it to access resources from=
 this server.
> +class CORSRequestHandler(SimpleHTTPRequestHandler):
> +       def end_headers (self):
> +               self.send_header('Access-Control-Allow-Origin', 'https://=
profiler.firefox.com')
> +               SimpleHTTPRequestHandler.end_headers(self)
> +
> +# start a local server to serve the gecko_profile.json file to the profi=
ler.firefox.com
> +def launchFirefox(file):
> +       safe_string =3D urllib.parse.quote_plus(f'http://localhost:8000/{=
file}')
> +       url =3D 'https://profiler.firefox.com/from-url/' + safe_string
> +       webbrowser.open(f'{url}')
>
>  def main() -> None:
> +       global output_file
>         global CATEGORIES
> -       parser =3D argparse.ArgumentParser(description=3D"Convert perf.da=
ta to Firefox\'s Gecko Profile format")
> +       parser =3D argparse.ArgumentParser(description=3D"Convert perf.da=
ta to Firefox\'s Gecko Profile format which can be uploaded to profiler.fir=
efox.com for visualization")
>
>         # Add the command-line options
>         # Colors must be defined according to this:
>         # https://github.com/firefox-devtools/profiler/blob/50124adbfa488=
adba6e2674a8f2618cf34b59cd2/res/css/categories.css
> -       parser.add_argument('--user-color', default=3D'yellow', help=3D'C=
olor for the User category')
> -       parser.add_argument('--kernel-color', default=3D'orange', help=3D=
'Color for the Kernel category')
> +       parser.add_argument('--user-color', default=3D'yellow', help=3D'C=
olor for the User category', choices=3D['yellow', 'blue', 'purple', 'green'=
, 'orange', 'red', 'grey', 'magenta'])
> +       parser.add_argument('--kernel-color', default=3D'orange', help=3D=
'Color for the Kernel category', choices=3D['yellow', 'blue', 'purple', 'gr=
een', 'orange', 'red', 'grey', 'magenta'])
> +       # If --save-only is specified, the output will be saved to a file=
 instead of opening Firefox's profiler directly.
> +       parser.add_argument('--save-only', help=3D'Save the output to a f=
ile instead of opening Firefox\'s profiler')
> +
>         # Parse the command-line arguments
>         args =3D parser.parse_args()
>         # Access the values provided by the user
>         user_color =3D args.user_color
>         kernel_color =3D args.kernel_color
> +       output_file =3D args.save_only
>
>         CATEGORIES =3D [
>                 {
> @@ -336,4 +392,4 @@ def main() -> None:
>         ]
>
>  if __name__ =3D=3D '__main__':
> -    main()
> +       main()
> --
> 2.34.1
>
