Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1141177922D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjHKOt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:49:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A32702;
        Fri, 11 Aug 2023 07:49:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2681223aaacso1479667a91.0;
        Fri, 11 Aug 2023 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691765394; x=1692370194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jmlNWfJoLZDUmRULuiEZynvlYEqrawPUWB/GSO72IE=;
        b=lNWWs7CMtHnHITv8MOct/Ykb7NYLuQYG1nZnaza1RUoBYNTNnKzD8pkDItk45CbooA
         t4oisSKgYPbU1PcHyEMaFnbOHvsTuhW7oBnPgoUxAdxKbs+tXTJgIa6tjLKT6zRIbycn
         0g5LXd2mBbi57Gy85rufpFONwuV3vhyBJcDvWnp3Bm1u3MfCp+tgzXOplw/vGAIf0zP+
         OsV2GUkp10jtR7sG+6GNcCk2qCeEb9VF3RRc4m2kYNi6dq2zg0um35VnmBDVTE2ZCfyN
         E9MXWL4Hl9kdpU7ohU82tZcvIPrkA+ZZMsrUjdfgqMZ3FNMIdPPTDMpKPUpdv8MXlBVM
         41OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691765394; x=1692370194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jmlNWfJoLZDUmRULuiEZynvlYEqrawPUWB/GSO72IE=;
        b=HmiUhHubp7GrLi3RMCL3dpdS1dediZ9R3uKKmYRG489s02546RzWQ6p7b4qSjYsp3z
         7OVu5I22/ne9cygAVycYVLOkPF/JFUl76l3vP4obOFtbgFHzAHQvWXa7KHSnneMDSjMK
         hUiPRBiBB2o6SQ/8/ZYJrINs1i9S+/ia1reLe9KLaHtFLWIhUtXZ45/mGrTazkPu9i98
         0blRDlVQ829tNchvkzkn9V2WFPZo3B5EoVYHuuAjsqvVnELSgGOtrWITFXzRsLf60B00
         k/d44ECCLpGta72CS45rX9kiaME5YHQuTCm4U9MEWzXc+ej8GzVKLqHxsERhVo7oFgYP
         v7hw==
X-Gm-Message-State: AOJu0Yw0eaPehqQY+C5Wlw0iB/moEwJJpnAk8G6OgTSyHnYmkKndD+Yu
        1+t+t/n1aKct4uMW3b8GoBQ=
X-Google-Smtp-Source: AGHT+IG60weU/Gz0353ajBdi+j/9yitTd9IJSm7OwdiTnBQnDc4I8JwqSvNeo0LCg01B+ddz2nmQ1g==
X-Received: by 2002:a17:90a:d203:b0:261:219b:13b3 with SMTP id o3-20020a17090ad20300b00261219b13b3mr2770866pju.16.1691765393504;
        Fri, 11 Aug 2023 07:49:53 -0700 (PDT)
Received: from yoga ([2400:1f00:13:4c5a:a3ae:41e6:8de3:1052])
        by smtp.gmail.com with ESMTPSA id ei23-20020a17090ae55700b00262e604724dsm5307146pjb.50.2023.08.11.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:49:53 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Fri, 11 Aug 2023 20:19:36 +0530
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
Subject: Re: [PATCH] perf test: Add support for testing gecko script
Message-ID: <ZNZKgFloAEUZVgH5@yoga>
References: <ZNPocw1rC6d/v5RV@yoga>
 <CAP-5=fVJyx71LwbNRZqMp3qg=uufVLiaZ+q4-JzAoaE3HcJmUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVJyx71LwbNRZqMp3qg=uufVLiaZ+q4-JzAoaE3HcJmUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:01:20PM -0700, Ian Rogers wrote:
> On Wed, Aug 9, 2023 at 12:26 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > This commit add support for testing gecko script. The test checks
> > for the presence of required sections such as "meta," "threads,"
> > "samples," "frameTable," "stackTable," "stringTable," and
> > "pausedRanges" which are few essential parameter to be present
> > in output file. Also it verifies the validity of the JSON format
> > using Python's JSON library if available.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> 
> Hi Anup,
> 
> I was trying to test this and grabbing other patches didn't resolve
> the issue I see:
> ```
> 111: perf script gecko test                                          :
> --- start ---
> test child forked, pid 2886031
> ./tools/perf/tests/shell/test_gecko.sh: line 120: prepare_perf_data:
> command not found

got it, will fix it.

> Testing Gecko Command
>  Error: Couldn't find script `gecko'
> ...
> ```
> 
> It can be useful when sending a patch like this to, under a ---, list
> patches necessary for testing.

Thanks will send the v2 after adding the patch list.

> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/test_gecko.sh | 131 +++++++++++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >  create mode 100644 tools/perf/tests/shell/test_gecko.sh
> >
> > diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/shell/test_gecko.sh
> > new file mode 100644
> > index 000000000000..457c85474a62
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/test_gecko.sh
> > @@ -0,0 +1,131 @@
> > +#!/bin/bash
> > +# perf script gecko test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +err=0
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
> > +    if [ "$1" = 0 ]; then
> > +        echo "PASS: \"$2\""
> > +    else
> > +        echo "FAIL: \"$2\" Error message: \"$3\""
> > +        err=1
> > +    fi
> > +}
> > +
> > +find_str_or_fail() {
> > +    grep -q "$1" <<< "$2"
> > +    if [ "$?" != 0 ]; then
> > +        report 1 "$3" "Failed to find required string:'${1}'."
> > +    else
> > +        report 0 "$3"
> > +    fi
> > +}
> > +
> > +# To validate the json format, check if python is installed
> > +if [ "$PYTHON" = "" ] ; then
> > +       if which python3 > /dev/null ; then
> > +               PYTHON=python3
> > +       elif which python > /dev/null ; then
> > +               PYTHON=python
> > +       else
> > +               echo Skipping JSON format check, python not detected please set environment variable PYTHON.
> > +               PYTHON_NOT_AVAILABLE=1
> > +       fi
> > +fi
> > +
> > +# Check execution of perf script gecko command
> > +test_gecko_command() {
> > +    echo "Testing Gecko Command"
> > +    perf script gecko -a sleep 0.5
> > +       # Store the content of the file in the 'out' variable
> > +    out=$(< "gecko_profile.json")
> > +       # Get the length of the gecko_profile.json output in 'out'
> > +       length=${#out}
> > +       if [ "$length" -gt 0 ]; then
> > +        echo "PASS: \"Gecko Command\""
> > +    else
> > +        echo "FAIL: \"Gecko Command\""
> > +        err=1
> > +        exit
> > +    fi
> > +}
> > +
> > +# with the help of python json libary validate the json output
> > +if [ "$PYTHON_NOT_AVAILABLE" != "0" ]; then
> > +       validate_json_format()
> > +       {
> > +               if [ "$out" ] ; then
> > +                       if [ "$PYTHON -c import json; json.load($out)" ]; then
> > +                               echo "PASS: \"The file contains valid JSON format\""
> > +                       else
> > +                               echo "FAIL: \"The file does not contain valid JSON format\""
> > +                               err=1
> > +                               exit
> > +                       fi
> > +               else
> > +                       echo "FAIL: \"File not found\""
> > +                       err=2
> > +                       exit
> > +               fi
> > +       }
> > +fi
> > +
> > +# validate output for the presence of "meta".
> > +test_meta() {
> > +    find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "threads".
> > +test_threads() {
> > +       find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "samples".
> > +test_samples() {
> > +       find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "frameTable".
> > +test_frametable() {
> > +       find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "stackTable".
> > +test_stacktable() {
> > +       find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "stringTable"
> > +test_stringtable() {
> > +       find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +# validate output for the presence of "pausedRanges".
> > +test_pauseranges(){
> > +       find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
> > +}
> > +
> > +prepare_perf_data
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
