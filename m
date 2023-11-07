Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7B7E37F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKGJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:37:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 988D292;
        Tue,  7 Nov 2023 01:37:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADCDFEC;
        Tue,  7 Nov 2023 01:38:17 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 041713F703;
        Tue,  7 Nov 2023 01:37:30 -0800 (PST)
Message-ID: <47e3d265-e48e-238f-7528-b0eb4c250cb1@arm.com>
Date:   Tue, 7 Nov 2023 09:37:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf test: Add option to change objdump binary
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20231103113501.490012-1-james.clark@arm.com>
 <CAP-5=fWazX_q1W8HN7ErrRMB2bx5sz3x1V=+XqY7Hxx0jR0p9w@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWazX_q1W8HN7ErrRMB2bx5sz3x1V=+XqY7Hxx0jR0p9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/11/2023 15:41, Ian Rogers wrote:
> On Fri, Nov 3, 2023 at 4:35 AM James Clark <james.clark@arm.com> wrote:
>>
>> All of the other Perf subcommands that use objdump have an option to
>> specify the binary, so add the same option to perf test.
>>
>> This is useful if you have built the kernel with a different toolchain
>> to the system one, where the system objdump may fail to disassemble
>> vmlinux.
>>
>> Now this can be fixed with something like this:
>>
>>    $ perf test --objdump llvm-objdump "object code reading"
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> There is also "perf config" for things like this.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian

That seems a bit better for this use case so I added it in V2.

Thanks for the review.

James
