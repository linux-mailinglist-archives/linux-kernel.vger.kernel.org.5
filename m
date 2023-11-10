Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070F77E80E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbjKJSTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbjKJSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C7463822A;
        Fri, 10 Nov 2023 05:57:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDAC312FC;
        Fri, 10 Nov 2023 05:58:13 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D89E63F7C5;
        Fri, 10 Nov 2023 05:57:23 -0800 (PST)
Message-ID: <da4e59bc-759e-4ccc-2c5b-b8acf7049847@arm.com>
Date:   Fri, 10 Nov 2023 13:57:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] perf test: Add support for setting objdump binary
 via perf config
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Yonghong Song <yhs@fb.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20231106151051.129440-1-james.clark@arm.com>
 <20231106151051.129440-3-james.clark@arm.com> <ZUv1TgveArYdvTsl@kernel.org>
 <2e0fb2d4-1410-6a7e-902d-8249a9ea523a@arm.com> <ZU0FaXoGf/HcLBlb@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZU0FaXoGf/HcLBlb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2023 16:14, Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 09, 2023 at 10:26:34AM +0000, James Clark escreveu:
>>
>>
>> On 08/11/2023 20:53, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Nov 06, 2023 at 03:10:49PM +0000, James Clark escreveu:
>>>> Add a perf config variable that does the same thing as "perf test
>>>> --objdump <x>".
>>>>
>>>> Also update the man page.
>>>
>>> That is ok, if one wants to change objdump just for testing, as a
>>> followup improvement it may be interesting to allow that for the other
>>> tools that have --objdump as well as to add this as a global option,
>>> that affects all tools, no?
>>
>> For the tools they already all share annotate.objdump in the config. Do
>> you mean that the tests could share the same config instead?
> 
> Probably.
>  
>> Maybe I could have used annotate.objdump for the tests, but it was used
>> in a slightly different way, and I thought it would be easier for people
>> to find if it started with "test."
> 
> Well, we can have both, with "test." overriding "annotate."?
> 

Yeah overriding could work. IMO just one config value is probably enough
though, so we could change it to annotate.objdump in the tests too, and
remove the docs change. At least until someone has a usecase for a
separate config value for the tests and then add the overriding behavior.

I don't have any strong feelings about either way.

> Anyway, I applied this patch locally, now trying to fix some unrelated
> problem that is making 'perf test' fail so that I can push
> perf-tools-next publicly.
> 
> - Arnaldo
>  
>>>
>>> Anyway, applied both patches.
>>>
>>> - Arnaldo
>>>  
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>> ---
>>>>  tools/perf/Documentation/perf-config.txt |  4 ++++
>>>>  tools/perf/tests/builtin-test.c          | 12 ++++++++++++
>>>>  2 files changed, 16 insertions(+)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
>>>> index 0b4e79dbd3f6..16398babd1ef 100644
>>>> --- a/tools/perf/Documentation/perf-config.txt
>>>> +++ b/tools/perf/Documentation/perf-config.txt
>>>> @@ -722,6 +722,10 @@ session-<NAME>.*::
>>>>  		Defines new record session for daemon. The value is record's
>>>>  		command line without the 'record' keyword.
>>>>  
>>>> +test.*::
>>>> +
>>>> +	test.objdump::
>>>> +		objdump binary to use for disassembly and annotations.
>>>>  
>>>>  SEE ALSO
>>>>  --------
>>>> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
>>>> index a8d17dd50588..113e92119e1d 100644
>>>> --- a/tools/perf/tests/builtin-test.c
>>>> +++ b/tools/perf/tests/builtin-test.c
>>>> @@ -14,6 +14,7 @@
>>>>  #include <sys/wait.h>
>>>>  #include <sys/stat.h>
>>>>  #include "builtin.h"
>>>> +#include "config.h"
>>>>  #include "hist.h"
>>>>  #include "intlist.h"
>>>>  #include "tests.h"
>>>> @@ -514,6 +515,15 @@ static int run_workload(const char *work, int argc, const char **argv)
>>>>  	return -1;
>>>>  }
>>>>  
>>>> +static int perf_test__config(const char *var, const char *value,
>>>> +			     void *data __maybe_unused)
>>>> +{
>>>> +	if (!strcmp(var, "test.objdump"))
>>>> +		test_objdump_path = value;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  int cmd_test(int argc, const char **argv)
>>>>  {
>>>>  	const char *test_usage[] = {
>>>> @@ -541,6 +551,8 @@ int cmd_test(int argc, const char **argv)
>>>>          if (ret < 0)
>>>>                  return ret;
>>>>  
>>>> +	perf_config(perf_test__config, NULL);
>>>> +
>>>>  	/* Unbuffered output */
>>>>  	setvbuf(stdout, NULL, _IONBF, 0);
>>>>  
>>>> -- 
>>>> 2.34.1
>>>>
>>>
> 
