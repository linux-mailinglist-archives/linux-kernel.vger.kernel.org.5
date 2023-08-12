Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FBD77A321
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 23:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHLVrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 17:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjHLVrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 17:47:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC541994;
        Sat, 12 Aug 2023 14:47:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565331f0736so2465879a12.0;
        Sat, 12 Aug 2023 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691876821; x=1692481621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XIVKEk9hF0SCRk7Qzd9oCXXMWM/9mF7BaXO0YvGbVI=;
        b=PIBlUJodY1DcRjutKFENePOaeJignkjBOBWsB3Nihv5junA5CTy008F/g2jz4PGLKW
         YSj+Ql5xpSgwgtWwWl/647SsWKdrgsnftTYP+M57yVE/kIm80VZa21eVdVqt0asr0V4K
         +kWBUgTPaiUmmsfmyE0UDwMQWQpnDP1igjymAVS7uQDM3PBm3DuOK0E5Uh18F1kK9bok
         lV5atCakX7OC9FVcpUASP0UDfToEYcHyHW9ZI+12Xb5bObCwAXFeWMdnBz/fzFeObqwa
         7jjNa6HUT4xAZAOVtRR86KXhxeuM5b5Lqh0+BcIz0Akw9A5efeyfXkZ/27qDwv7wkbdV
         b8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691876821; x=1692481621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XIVKEk9hF0SCRk7Qzd9oCXXMWM/9mF7BaXO0YvGbVI=;
        b=ahCz0AgkxkU1Qhc3mWX1Al67p+Zk7xO1W81sSNckJnvbrhnRd7AkQWOOWfVJVbIur3
         r2Fkb15uyqWt0q75sWGQCDY07BwfNzZijz1Qy5VfnbEUTPTihY9L+VhrctOs4SC4+jQv
         3wIwhqCPh7JXed1Th6gJVnkWNExrEO/B6xBNusSWADP7Ds1Z99JBEraz8KcaQc9XOVP6
         2OB1zpGcLppZm8cfyqtPXNwf6sP4v9iIwkCT3Ku2gduM+UqNNVILWXpTqoX5BrNgH+ks
         Tq9po3D3dINNyQQ1j3fu22JEr6Ktdtp3a96EwoOyYL26XW+5peU6+qOFL//+k1P7cJql
         aO1Q==
X-Gm-Message-State: AOJu0YyrS6hu273A/iYKs4XdVc7NKTV1dxSDcJtKVmoHz/wCRH/+OI27
        ulxvM4BMMfdQZPzcp4m2pwY=
X-Google-Smtp-Source: AGHT+IEVyrPVxAI4hQrC5J9JS0Uv5vDVIsL28Nb2gk8+uzgiereP8bHwOwml2QjZl0FrpIeNKjFzbg==
X-Received: by 2002:a17:902:dac8:b0:1bb:7f71:df43 with SMTP id q8-20020a170902dac800b001bb7f71df43mr8042786plx.34.1691876820808;
        Sat, 12 Aug 2023 14:47:00 -0700 (PDT)
Received: from yoga ([2400:1f00:13:dd22:5ae5:bc57:c1e5:1a03])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b001b9e9f191f2sm6330410plx.15.2023.08.12.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 14:47:00 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Sun, 13 Aug 2023 03:16:52 +0530
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        =?utf-8?B?wqA=?= Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] perf test: Add support for testing gecko script
Message-ID: <ZNf9zM1mYAqCYqnf@yoga>
References: <ZNcxsN4Pvn5YPWsI@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNcxsN4Pvn5YPWsI@yoga>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 12:46:00PM +0530, Anup Sharma wrote:
> This commit add support for testing gecko script. The test checks
> for the presence of required sections such as "meta," "threads,"
> "samples," "frameTable," "stackTable," "stringTable," and
> "pausedRanges" which are few essential parameter to be present
> in output file. Also it verifies the validity of the JSON format
> using Python's JSON library if available.
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> 
> ---
> Patch needed for testing:
>     https://lore.kernel.org/linux-perf-users/ZNOS0vo58DnVLpD8@yoga/T/#u

To run this script:
./test_gecko.sh
or
bash test_gecko.sh

Expected output:

Testing Gecko Command
Staring Firefox Profiler on your default browser...
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
127.0.0.1 - - [13/Aug/2023 03:07:35] "GET /gecko_profile.json HTTP/1.1" 200 -
[ perf gecko: Captured and wrote into gecko_profile.json ]
PASS: "Gecko Command"
PASS: "The file contains valid JSON format"
PASS: "test_meta"
PASS: "test_threads"
PASS: "test_samples"
PASS: "test_frametable"
PASS: "test_stacktable"
PASS: "test_stringtable"
PASS: "test_pauseranges"

> changes in v2:
>     - Removed uncessary prepare_perf_data.
>     - provided patch which is required for testing this patch.
> ---
>  tools/perf/tests/shell/test_gecko.sh | 130 +++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_gecko.sh
> 
> diff --git a/tools/perf/tests/shell/test_gecko.sh b/tools/perf/tests/shell/test_gecko.sh
> new file mode 100755
> index 000000000000..44160eff87fd
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_gecko.sh
> @@ -0,0 +1,130 @@
> +#!/bin/bash
> +# perf script gecko test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +err=0
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
> +    if [ "$1" = 0 ]; then
> +        echo "PASS: \"$2\""
> +    else
> +        echo "FAIL: \"$2\" Error message: \"$3\""
> +        err=1
> +    fi
> +}
> +
> +find_str_or_fail() {
> +    grep -q "$1" <<< "$2"
> +    if [ "$?" != 0 ]; then
> +        report 1 "$3" "Failed to find required string:'${1}'."
> +    else
> +        report 0 "$3"
> +    fi
> +}
> +
> +# To validate the json format, check if python is installed
> +if [ "$PYTHON" = "" ] ; then
> +	if which python3 > /dev/null ; then
> +		PYTHON=python3
> +	elif which python > /dev/null ; then
> +		PYTHON=python
> +	else
> +		echo Skipping JSON format check, python not detected please set environment variable PYTHON.
> +		PYTHON_NOT_AVAILABLE=1
> +	fi
> +fi
> +
> +# Check execution of perf script gecko command
> +test_gecko_command() {
> +    echo "Testing Gecko Command"
> +    perf script gecko -a sleep 0.5
> +    # Store the content of the file in the 'out' variable
> +    out=$(< "gecko_profile.json")
> +    # Get the length of the gecko_profile.json output in 'out'
> +	length=${#out}
> +	if [ "$length" -gt 0 ]; then
> +        echo "PASS: \"Gecko Command\""
> +    else
> +        echo "FAIL: \"Gecko Command\""
> +        err=1
> +        exit
> +    fi
> +}
> +
> +# with the help of python json libary validate the json output
> +if [ "$PYTHON_NOT_AVAILABLE" != "0" ]; then
> +	validate_json_format()
> +	{
> +		if [ "$out" ] ; then
> +			if [ "$PYTHON -c import json; json.load($out)" ]; then
> +				echo "PASS: \"The file contains valid JSON format\""
> +			else
> +				echo "FAIL: \"The file does not contain valid JSON format\""
> +				err=1
> +				exit
> +			fi
> +		else
> +			echo "FAIL: \"File not found\""
> +			err=2
> +			exit
> +		fi
> +	}
> +fi
> +
> +# validate output for the presence of "meta".
> +test_meta() {
> +    find_str_or_fail "meta" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "threads".
> +test_threads() {
> +	find_str_or_fail "threads" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "samples".
> +test_samples() {
> +	find_str_or_fail "samples" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "frameTable".
> +test_frametable() {
> +	find_str_or_fail "frameTable" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "stackTable".
> +test_stacktable() {
> +	find_str_or_fail "stackTable" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "stringTable"
> +test_stringtable() {
> +	find_str_or_fail "stringTable" "$out" "${FUNCNAME[0]}"
> +}
> +
> +# validate output for the presence of "pausedRanges".
> +test_pauseranges(){
> +	find_str_or_fail "pausedRanges" "$out" "${FUNCNAME[0]}"
> +}
> +
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
