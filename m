Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32737781ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjHJUBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjHJUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:01:33 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F72723
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:01:32 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40c72caec5cso7751cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691697691; x=1692302491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3a6HnsOh4DT9Ujbqfy0w0JsFhQjH8Jgx+l1c+nZXaM=;
        b=2ndBwu2BV7oFMLU5bffiVgeEgwKkXTn1nottU+EVbhMqW4iKDL/mvIrehIQQy8gAGM
         3zzQJJBR6Wri6OFLwV66Ig1HQxgxytaNGoQHfGBQZinf8uTkzpA7j/BFYK+JFh7f2t48
         bUWFsURrXI9uNMxo9aDpdgFFe5kTA8NVFQ+WS622jTazjTYcFTjI2xbAy78Ra1xic4Lm
         huzNXhitbKnu56x3gV7/V7eW5DshWEd5X6hyACj+u10Py9859Wv+cE7uJVUzk0226nNb
         DvHY2HfzU44DMrFVyrS68KC7F9TcVreqO3xPPvpYjT0v1L5efBTIcRaTGuNoD55V1bT5
         eTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691697691; x=1692302491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3a6HnsOh4DT9Ujbqfy0w0JsFhQjH8Jgx+l1c+nZXaM=;
        b=I9qh1ZdUyYcUjz9q+PfIC9clwMunqDzSaZ3TY88z0q7SFp7X8QgT9InBQCst7tGrVZ
         segs/NM4FsPvP2WY3jNZJOCr9wb/C/UmzCWeSizY+ChLLHc2NS3Hi2i7v7dYn5GHMGAi
         JuyBGp2AsLjkH5evyESBcIOGhRDqhhuQ89ji+b18JMEIbk+TmiePUfq+XUi7iF3MYCuS
         bEXZeJeLQOU21mD1mU/OKmTakBsHf9D/TbncsjwbYcbIqA7k/lVpwy2dvjJPhMCh3DM3
         ELH3Bm7LXOQVodjsSZ9rB6C/Vuj2D3addSjHvIAe4g9IiIXvSeMGUvm5iCdY9VL+uM9V
         gMJQ==
X-Gm-Message-State: AOJu0Yx/1IAMCMpW/hDUUX8g5JCAfUfd7N/1D3fTj82XmOA92tqryQ+l
        zcUV0CwYrajyRBNq2D2aCaSZoO3Co043RZ2Scpk0Tw==
X-Google-Smtp-Source: AGHT+IEh1ar6vsvTxB784befVYzFQXdBfJs7Ecdw+6d5JHLlnXTAXE20SWwRi0jhJpu9Q0RNQFdghIAI12a8Bf7T8wY=
X-Received: by 2002:ac8:5acc:0:b0:40f:d1f4:aa58 with SMTP id
 d12-20020ac85acc000000b0040fd1f4aa58mr72140qtd.8.1691697691298; Thu, 10 Aug
 2023 13:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZNPocw1rC6d/v5RV@yoga>
In-Reply-To: <ZNPocw1rC6d/v5RV@yoga>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Aug 2023 13:01:20 -0700
Message-ID: <CAP-5=fVJyx71LwbNRZqMp3qg=uufVLiaZ+q4-JzAoaE3HcJmUg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add support for testing gecko script
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 12:26=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> This commit add support for testing gecko script. The test checks
> for the presence of required sections such as "meta," "threads,"
> "samples," "frameTable," "stackTable," "stringTable," and
> "pausedRanges" which are few essential parameter to be present
> in output file. Also it verifies the validity of the JSON format
> using Python's JSON library if available.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Hi Anup,

I was trying to test this and grabbing other patches didn't resolve
the issue I see:
```
111: perf script gecko test                                          :
--- start ---
test child forked, pid 2886031
./tools/perf/tests/shell/test_gecko.sh: line 120: prepare_perf_data:
command not found
Testing Gecko Command
 Error: Couldn't find script `gecko'
...
```

It can be useful when sending a patch like this to, under a ---, list
patches necessary for testing.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_gecko.sh | 131 +++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 tools/perf/tests/shell/test_gecko.sh
>
> diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/shel=
l/test_gecko.sh
> new file mode 100644
> index 000000000000..457c85474a62
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_gecko.sh
> @@ -0,0 +1,131 @@
> +#!/bin/bash
> +# perf script gecko test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=3D0
> +
> +cleanup() {
> +  rm -rf gecko_profile.json
> +  trap - exit term int
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup exit term int
> +
> +report() {
> +    if [ "$1" =3D 0 ]; then
> +        echo "PASS: \"$2\""
> +    else
> +        echo "FAIL: \"$2\" Error message: \"$3\""
> +        err=3D1
> +    fi
> +}
> +
> +find_str_or_fail() {
> +    grep -q "$1" <<< "$2"
> +    if [ "$?" !=3D 0 ]; then
> +        report 1 "$3" "Failed to find required string:'${1}'."
> +    else
> +        report 0 "$3"
> +    fi
> +}
> +
> +# To validate the json format, check if python is installed
> +if [ "$PYTHON" =3D "" ] ; then
> +       if which python3 > /dev/null ; then
> +               PYTHON=3Dpython3
> +       elif which python > /dev/null ; then
> +               PYTHON=3Dpython
> +       else
> +               echo Skipping JSON format check, python not detected plea=
se set environment variable PYTHON.
> +               PYTHON_NOT_AVAILABLE=3D1
> +       fi
> +fi
> +
> +# Check execution of perf script gecko command
> +test_gecko_command() {
> +    echo "Testing Gecko Command"
> +    perf script gecko -a sleep 0.5
> +       # Store the content of the file in the 'out' variable
> +    out=3D$(< "gecko_profile.json")
> +       # Get the length of the gecko_profile.json output in 'out'
> +       length=3D${#out}
> +       if [ "$length" -gt 0 ]; then
> +        echo "PASS: \"Gecko Command\""
> +    else
> +        echo "FAIL: \"Gecko Command\""
> +        err=3D1
> +        exit
> +    fi
> +}
> +
> +# with the help of python json libary validate the json output
> +if [ "$PYTHON_NOT_AVAILABLE" !=3D "0" ]; then
> +       validate_json_format()
> +       {
> +               if [ "$out" ] ; then
> +                       if [ "$PYTHON -c import json; json.load($out)" ];=
 then
> +                               echo "PASS: \"The file contains valid JSO=
N format\""
> +                       else
> +                               echo "FAIL: \"The file does not contain v=
alid JSON format\""
> +                               err=3D1
> +                               exit
> +                       fi
> +               else
> +                       echo "FAIL: \"File not found\""
> +                       err=3D2
> +                       exit
> +               fi
> +       }
> +fi
> +
> +# validate output for the presence of "meta".
> +test_meta() {
> +    find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "threads".
> +test_threads() {
> +       find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "samples".
> +test_samples() {
> +       find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "frameTable".
> +test_frametable() {
> +       find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "stackTable".
> +test_stacktable() {
> +       find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "stringTable"
> +test_stringtable() {
> +       find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "pausedRanges".
> +test_pauseranges(){
> +       find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
> +}
> +
> +prepare_perf_data
> +test_gecko_command
> +validate_json_format
> +test_meta
> +test_threads
> +test_samples
> +test_frametable
> +test_stacktable
> +test_stringtable
> +test_pauseranges
> +cleanup
> +exit $err
> --
> 2.34.1
>
