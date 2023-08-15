Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE92677C9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjHOJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjHOJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:05:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC2D115
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:05:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4036bd4fff1so169031cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692090314; x=1692695114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8pKN5MCV3d+31+9G9lYvjgDTbv0WuS6GUtl295mKqA=;
        b=w0q9sxLSRiddNARvPMMu1PUEMagBcaxLz7j5upP6Xoyyc4ArLjboXenakWye3w5t2w
         DKAWnhJpST0WFoTyHop+738h6QZ17ZRXAm0bB4isyCfx0t6jxHL3mtojSbrPe4UxLNMD
         FiayEwuotWzyegI7G0kaFZWylliSmqJ2bmmrS9A89pSnalyf+jX03XrLevE0Lreob+Np
         3MVGctJ+2BwDU0P6/+ZB96D+AYilBfrqPHb0XD+wyN5vwom4P+5tuxTRp7uev6BaVH2z
         tMPyrj9JX2Xk7EQpu0OCK9sRCKP1Pecvpjz/wmJItrp13ieikHgU1XyEx+QeKgLlDNWL
         jPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090314; x=1692695114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8pKN5MCV3d+31+9G9lYvjgDTbv0WuS6GUtl295mKqA=;
        b=hFDiKj87PqPlzRvw2/Q7LavnfPKvKun/VHRiOus+m7weXZxNlnowenV49HHxG0pqbc
         l8JHCPsZY/upeL4AznnN7Fan8GuM4NKnAA3sqMEUmmnjeJbO2wYBlufLpTeYeV8og0Rc
         4v7uDLY+/r5N52VJpA9Wboqd/OJHw60V6CQlBrGqlxMBxZKSutg9jacE3+6jprU4YqzH
         5mNnNwlwKmRZFAZ9aXVl8T3jRMxO+NMw1Cc9c8zVr7s1vdK9k70ukJauhrCoDIxB4KPO
         7c0yV//ytH1CwV/MhnW3p6oJ4xp4O6wkIqehhExT5aqHgR/uxMRRJEFOMV4mkMpyUuR7
         YzQg==
X-Gm-Message-State: AOJu0YyFyIFGC+kMATXK3ik240OTt8AVX3q7iWw2qfivnD40QyfXk80y
        JlvFIiVp5MSuIi/CCco2lWArOY/vlJ8MmmASCbwRI+tJ/EA2mvFXllPJtYccPXI=
X-Google-Smtp-Source: AGHT+IGJXAavhV8NOxz99me9XEA/iOMf+K+FC99ii+nIiZqgyufnvjl6qfGoIYVhU9NVxX+zYRyqYXDzjB8qQhoRXMA=
X-Received: by 2002:a05:622a:245:b0:403:b1e5:bcae with SMTP id
 c5-20020a05622a024500b00403b1e5bcaemr791122qtx.10.1692090313639; Tue, 15 Aug
 2023 02:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZNcxsN4Pvn5YPWsI@yoga> <ZNf9zM1mYAqCYqnf@yoga>
In-Reply-To: <ZNf9zM1mYAqCYqnf@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Aug 2023 02:05:02 -0700
Message-ID: <CAP-5=fWGb=h0NuU5tTTUVsgn-ScqZKqdTLHi5XuoL1jnPyyxpg@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Add support for testing gecko script
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL,WEIRD_PORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 2:47=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> On Sat, Aug 12, 2023 at 12:46:00PM +0530, Anup Sharma wrote:
> > This commit add support for testing gecko script. The test checks
> > for the presence of required sections such as "meta," "threads,"
> > "samples," "frameTable," "stackTable," "stringTable," and
> > "pausedRanges" which are few essential parameter to be present
> > in output file. Also it verifies the validity of the JSON format
> > using Python's JSON library if available.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> >
> > ---
> > Patch needed for testing:
> >     https://lore.kernel.org/linux-perf-users/ZNOS0vo58DnVLpD8@yoga/T/#u
>
> To run this script:
> ./test_gecko.sh
> or
> bash test_gecko.sh
>
> Expected output:
>
> Testing Gecko Command
> Staring Firefox Profiler on your default browser...
> Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
> 127.0.0.1 - - [13/Aug/2023 03:07:35] "GET /gecko_profile.json HTTP/1.1" 2=
00 -
> [ perf gecko: Captured and wrote into gecko_profile.json ]
> PASS: "Gecko Command"
> PASS: "The file contains valid JSON format"
> PASS: "test_meta"
> PASS: "test_threads"
> PASS: "test_samples"
> PASS: "test_frametable"
> PASS: "test_stacktable"
> PASS: "test_stringtable"
> PASS: "test_pauseranges"

Hi Anup,

this works for me but when I run as root (using sudo) I need to set
PERF_EXEC_PATH. Running as a user it launches firefox profiler which I
don't think it should.

Thanks,
Ian

> > changes in v2:
> >     - Removed uncessary prepare_perf_data.
> >     - provided patch which is required for testing this patch.
> > ---
> >  tools/perf/tests/shell/test_gecko.sh | 130 +++++++++++++++++++++++++++
> >  1 file changed, 130 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/test_gecko.sh
> >
> > diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/sh=
ell/test_gecko.sh
> > new file mode 100755
> > index 000000000000..44160eff87fd
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/test_gecko.sh
> > @@ -0,0 +1,130 @@
> > +#!/bin/bash
> > +# perf script gecko test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=3D0
> > +
> > +cleanup() {
> > +  rm -rf gecko_profile.json
> > +  trap - exit term int
> > +}
> > +
> > +trap_cleanup() {
> > +  cleanup
> > +  exit 1
> > +}
> > +trap trap_cleanup exit term int
> > +
> > +report() {
> > +    if [ "$1" =3D 0 ]; then
> > +        echo "PASS: \"$2\""
> > +    else
> > +        echo "FAIL: \"$2\" Error message: \"$3\""
> > +        err=3D1
> > +    fi
> > +}
> > +
> > +find_str_or_fail() {
> > +    grep -q "$1" <<< "$2"
> > +    if [ "$?" !=3D 0 ]; then
> > +        report 1 "$3" "Failed to find required string:'${1}'."
> > +    else
> > +        report 0 "$3"
> > +    fi
> > +}
> > +
> > +# To validate the json format, check if python is installed
> > +if [ "$PYTHON" =3D "" ] ; then
> > +     if which python3 > /dev/null ; then
> > +             PYTHON=3Dpython3
> > +     elif which python > /dev/null ; then
> > +             PYTHON=3Dpython
> > +     else
> > +             echo Skipping JSON format check, python not detected plea=
se set environment variable PYTHON.
> > +             PYTHON_NOT_AVAILABLE=3D1
> > +     fi
> > +fi
> > +
> > +# Check execution of perf script gecko command
> > +test_gecko_command() {
> > +    echo "Testing Gecko Command"
> > +    perf script gecko -a sleep 0.5
> > +    # Store the content of the file in the 'out' variable
> > +    out=3D$(< "gecko_profile.json")
> > +    # Get the length of the gecko_profile.json output in 'out'
> > +     length=3D${#out}
> > +     if [ "$length" -gt 0 ]; then
> > +        echo "PASS: \"Gecko Command\""
> > +    else
> > +        echo "FAIL: \"Gecko Command\""
> > +        err=3D1
> > +        exit
> > +    fi
> > +}
> > +
> > +# with the help of python json libary validate the json output
> > +if [ "$PYTHON_NOT_AVAILABLE" !=3D "0" ]; then
> > +     validate_json_format()
> > +     {
> > +             if [ "$out" ] ; then
> > +                     if [ "$PYTHON -c import json; json.load($out)" ];=
 then
> > +                             echo "PASS: \"The file contains valid JSO=
N format\""
> > +                     else
> > +                             echo "FAIL: \"The file does not contain v=
alid JSON format\""
> > +                             err=3D1
> > +                             exit
> > +                     fi
> > +             else
> > +                     echo "FAIL: \"File not found\""
> > +                     err=3D2
> > +                     exit
> > +             fi
> > +     }
> > +fi
> > +
> > +# validate output for the presence of "meta".
> > +test_meta() {
> > +    find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "threads".
> > +test_threads() {
> > +     find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "samples".
> > +test_samples() {
> > +     find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "frameTable".
> > +test_frametable() {
> > +     find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "stackTable".
> > +test_stacktable() {
> > +     find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "stringTable"
> > +test_stringtable() {
> > +     find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "pausedRanges".
> > +test_pauseranges(){
> > +     find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +test_gecko_command
> > +validate_json_format
> > +test_meta
> > +test_threads
> > +test_samples
> > +test_frametable
> > +test_stacktable
> > +test_stringtable
> > +test_pauseranges
> > +cleanup
> > +exit $err
> > --
> > 2.34.1
> >
