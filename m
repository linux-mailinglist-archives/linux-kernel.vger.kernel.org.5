Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7DA77E6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjHPQsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344982AbjHPQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:48:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B68E2D77;
        Wed, 16 Aug 2023 09:47:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc7e65ea44so251855ad.1;
        Wed, 16 Aug 2023 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692204479; x=1692809279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nDe/l/Ozfv3j3x21lWXv71AW29b38gVITnv5F9XrJYs=;
        b=F0OaPPagZ9kHgVebJ3/b8nnqwx2NV926ijl/yKwPVEo7IvTG/NTYCKGloyyVDg/Jnb
         rElwDjZ/keXDpRowz+2oO+YvKv0kNR4au/goW3NLwBeUaPZFfYxco62TPK3CS0frv260
         NHRqE93P6MIZvgbeuPiMLwbI7jb75cEoMimAB9VqcXNWlNbFm5Tr0oUPMP3o0xXzoJQH
         NaPqx6uspH7KtMhRyk4hV/DimGorbqOHxJUih3hJUOsha/WzW9W9z+WOUnRcOuqdycsu
         J6FzCElHAgaqAc2pbAUNMUQw/rlIaQ51aaLvaJTQOwXqUyPUQssh2jmSHWoRdqWQmm7H
         teTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204479; x=1692809279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDe/l/Ozfv3j3x21lWXv71AW29b38gVITnv5F9XrJYs=;
        b=hp4QIbrYU3oPXX8ZFlL9X0JZqtX9n4892QCZ1uVE1l7C/nK1rvHnSaJN7bPiC2sEr3
         /GOdbIy+ks9CJEP3DhHaVmayXzJZOQNELLT2irJWlTg9ngx83eVa9HWXsuQ0hmSJYILA
         FlmVRr72zER89PknRywGJBWANSB1mL0+/CyquogZYvJXWjWOW5rV35kSJMvwsKcqC/eu
         yLFn2kNlrXOaMSl2Gx/kaz3Z6PV8Hql+CY/j6XbeedmpsiFzRr0SRbHna8utoxH1KPd1
         fwpyfd8wWICKwjEaNbRxivWauG1wnmgJ0f3VGwAhHGUO2xgdZ2W2INDUTdIkox0tMhSG
         tdHA==
X-Gm-Message-State: AOJu0YxRRFAiem49Waf2DRt3vhpIKaMq6BVCoHU5bCw7Rh1QHaBu+HdZ
        PHKsJ2XsuZ1mumTGT8G/DNs=
X-Google-Smtp-Source: AGHT+IE2OU/RUM+rTvjq2wy0pIKDxI56U1jEOIfhGJ3H+GrJm2K4AoQRSnf+YASZM0rsoKM2FGzMZw==
X-Received: by 2002:a17:902:da89:b0:1bc:4f04:17f4 with SMTP id j9-20020a170902da8900b001bc4f0417f4mr131151plx.30.1692204478473;
        Wed, 16 Aug 2023 09:47:58 -0700 (PDT)
Received: from yoga ([2400:1f00:13:54f4:15af:3399:987d:c0db])
        by smtp.gmail.com with ESMTPSA id u17-20020a63b551000000b00564be149a15sm12231355pgo.65.2023.08.16.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:47:57 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Wed, 16 Aug 2023 22:17:50 +0530
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
Subject: Re: [PATCH V2] perf test: Add support for testing gecko script
Message-ID: <ZNz9tqR4voB/cEB8@yoga>
References: <ZNcxsN4Pvn5YPWsI@yoga>
 <ZNf9zM1mYAqCYqnf@yoga>
 <CAP-5=fWGb=h0NuU5tTTUVsgn-ScqZKqdTLHi5XuoL1jnPyyxpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWGb=h0NuU5tTTUVsgn-ScqZKqdTLHi5XuoL1jnPyyxpg@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:05:02AM -0700, Ian Rogers wrote:
> On Sat, Aug 12, 2023 at 2:47 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > On Sat, Aug 12, 2023 at 12:46:00PM +0530, Anup Sharma wrote:
> > > This commit add support for testing gecko script. The test checks
> > > for the presence of required sections such as "meta," "threads,"
> > > "samples," "frameTable," "stackTable," "stringTable," and
> > > "pausedRanges" which are few essential parameter to be present
> > > in output file. Also it verifies the validity of the JSON format
> > > using Python's JSON library if available.
> > >
> > > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > >
> > > ---
> > > Patch needed for testing:
> > >     https://lore.kernel.org/linux-perf-users/ZNOS0vo58DnVLpD8@yoga/T/#u
> >
> > To run this script:
> > ./test_gecko.sh
> > or
> > bash test_gecko.sh
> >
> > Expected output:
> >
> > Testing Gecko Command
> > Staring Firefox Profiler on your default browser...
> > Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
> > 127.0.0.1 - - [13/Aug/2023 03:07:35] "GET /gecko_profile.json HTTP/1.1" 200 -
> > [ perf gecko: Captured and wrote into gecko_profile.json ]
> > PASS: "Gecko Command"
> > PASS: "The file contains valid JSON format"
> > PASS: "test_meta"
> > PASS: "test_threads"
> > PASS: "test_samples"
> > PASS: "test_frametable"
> > PASS: "test_stacktable"
> > PASS: "test_stringtable"
> > PASS: "test_pauseranges"
> 
> Hi Anup,
> 
> this works for me but when I run as root (using sudo) I need to set
> PERF_EXEC_PATH. Running as a user it launches firefox profiler which I
> don't think it should.

Hi Ian, thanks for testing this patch. I checked it seems like
gecko.py Line 359: webbrowser.open(f'{url}') is not launching
firefox or any browser when run as root. Few discussion have
already taken place which I am looking right now:
https://forums.opensuse.org/t/python-webbrowser-with-root/92189
https://github.com/pyinstaller/pyinstaller/issues/6334
I will check if there is any way to launch browser as both root
and user.

Thanks,
Anup

> Thanks,
> Ian
> 
> > > changes in v2:
> > >     - Removed uncessary prepare_perf_data.
> > >     - provided patch which is required for testing this patch.
> > > ---
> > >  tools/perf/tests/shell/test_gecko.sh | 130 +++++++++++++++++++++++++++
> > >  1 file changed, 130 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/test_gecko.sh
> > >
> > > diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/shell/test_gecko.sh
> > > new file mode 100755
> > > index 000000000000..44160eff87fd
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/test_gecko.sh
> > > @@ -0,0 +1,130 @@
> > > +#!/bin/bash
> > > +# perf script gecko test
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +err=0
> > > +
> > > +cleanup() {
> > > +  rm -rf gecko_profile.json
> > > +  trap - exit term int
> > > +}
> > > +
> > > +trap_cleanup() {
> > > +  cleanup
> > > +  exit 1
> > > +}
> > > +trap trap_cleanup exit term int
> > > +
> > > +report() {
> > > +    if [ "$1" = 0 ]; then
> > > +        echo "PASS: \"$2\""
> > > +    else
> > > +        echo "FAIL: \"$2\" Error message: \"$3\""
> > > +        err=1
> > > +    fi
> > > +}
> > > +
> > > +find_str_or_fail() {
> > > +    grep -q "$1" <<< "$2"
> > > +    if [ "$?" != 0 ]; then
> > > +        report 1 "$3" "Failed to find required string:'${1}'."
> > > +    else
> > > +        report 0 "$3"
> > > +    fi
> > > +}
> > > +
> > > +# To validate the json format, check if python is installed
> > > +if [ "$PYTHON" = "" ] ; then
> > > +     if which python3 > /dev/null ; then
> > > +             PYTHON=python3
> > > +     elif which python > /dev/null ; then
> > > +             PYTHON=python
> > > +     else
> > > +             echo Skipping JSON format check, python not detected please set environment variable PYTHON.
> > > +             PYTHON_NOT_AVAILABLE=1
> > > +     fi
> > > +fi
> > > +
> > > +# Check execution of perf script gecko command
> > > +test_gecko_command() {
> > > +    echo "Testing Gecko Command"
> > > +    perf script gecko -a sleep 0.5
> > > +    # Store the content of the file in the 'out' variable
> > > +    out=$(< "gecko_profile.json")
> > > +    # Get the length of the gecko_profile.json output in 'out'
> > > +     length=${#out}
> > > +     if [ "$length" -gt 0 ]; then
> > > +        echo "PASS: \"Gecko Command\""
> > > +    else
> > > +        echo "FAIL: \"Gecko Command\""
> > > +        err=1
> > > +        exit
> > > +    fi
> > > +}
> > > +
> > > +# with the help of python json libary validate the json output
> > > +if [ "$PYTHON_NOT_AVAILABLE" != "0" ]; then
> > > +     validate_json_format()
> > > +     {
> > > +             if [ "$out" ] ; then
> > > +                     if [ "$PYTHON -c import json; json.load($out)" ]; then
> > > +                             echo "PASS: \"The file contains valid JSON format\""
> > > +                     else
> > > +                             echo "FAIL: \"The file does not contain valid JSON format\""
> > > +                             err=1
> > > +                             exit
> > > +                     fi
> > > +             else
> > > +                     echo "FAIL: \"File not found\""
> > > +                     err=2
> > > +                     exit
> > > +             fi
> > > +     }
> > > +fi
> > > +
> > > +# validate output for the presence of "meta".
> > > +test_meta() {
> > > +    find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
> > > +}
> > > +
> > > +# validate output for the presence of "threads".
> > > +test_threads() {
> > > +     find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
> > > +}
> > > +
> > > +# validate output for the presence of "samples".
> > > +test_samples() {
> > > +     find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
> > > +}
> > > +
> > > +# validate output for the presence of "frameTable".
> > > +test_frametable() {
> > > +     find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
> > > +}
> > > +
> > > +# validate output for the presence of "stackTable".
> > > +test_stacktable() {
> > > +     find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
> > > +}
> > > +
> > > +# validate output for the presence of "stringTable"
> > > +test_stringtable() {
> > > +     find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
> > > +}
> > > +
> > > +# validate output for the presence of "pausedRanges".
> > > +test_pauseranges(){
> > > +     find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
> > > +}
> > > +
> > > +test_gecko_command
> > > +validate_json_format
> > > +test_meta
> > > +test_threads
> > > +test_samples
> > > +test_frametable
> > > +test_stacktable
> > > +test_stringtable
> > > +test_pauseranges
> > > +cleanup
> > > +exit $err
> > > --
> > > 2.34.1
> > >
