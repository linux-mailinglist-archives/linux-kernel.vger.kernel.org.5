Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB9766EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjG1N7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbjG1N7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:59:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B5CF2D76;
        Fri, 28 Jul 2023 06:59:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAE662F4;
        Fri, 28 Jul 2023 07:00:33 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C02233F67D;
        Fri, 28 Jul 2023 06:59:48 -0700 (PDT)
Message-ID: <81179172-cf6f-f5b9-c017-74aa6c95132a@arm.com>
Date:   Fri, 28 Jul 2023 14:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 0/1] perf tools: Add a place to put kernel config
 fragments for test runs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, masahiroy@kernel.org,
        leo.yan@linaro.org, broonie@kernel.org, Aishwarya.TCV@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
References: <20230628105303.4053478-1-james.clark@arm.com>
 <CAM9d7cgo97jJTTTV7F2kJ=sF9MBoRwegN4r0dWotbUD=Nr1_cQ@mail.gmail.com>
 <36767548-fbc3-9c4b-848c-d1d3102e442a@arm.com>
 <85fad198-278a-aea2-3ada-f4f6a31f02ef@arm.com> <ZMPCsEeO1Xad/pR6@kernel.org>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <ZMPCsEeO1Xad/pR6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2023 14:29, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 28, 2023 at 11:48:34AM +0100, James Clark escreveu:
>>
>>
>> On 30/06/2023 09:04, James Clark wrote:
>>>
>>>
>>> On 29/06/2023 23:03, Namhyung Kim wrote:
>>>> Hi James,
>>>>
>>>> On Wed, Jun 28, 2023 at 3:53 AM James Clark <james.clark@arm.com> wrote:
>>>>>
>>>>> Changes since RFC:
>>>>>
>>>>>  * Changed arch filename convention to use the ARCH= build time values
>>>>>    instead of uname
>>>>>
>>>>> It seems like there were no objections on the RFC, apart from maybe
>>>>> changing the perf tests to run as a kself test. But that's probably not
>>>>> going to happen for a while, if ever, and these fragments can always
>>>>> be moved in that case.
>>>>
>>>> I missed the RFC, sorry.  Could you please add a link for that?
>>>>
>>>> Thanks,
>>>> Namhyung
>>>
>>> Yep, it's here:
>>> https://lore.kernel.org/lkml/d02cce4a-47b1-a776-0d3a-a6a7c9a4d8fd@arm.com/T/
>>>
>>
>> Hi Arnaldo,
>>
>> Any interest in taking this one?
> 
> Yeah, looks useful, we can go on from this starting point and improve
> it.
> 
> I merged it into perf-tools-next.
> 
> Thanks,
> 
> - Arnaldo
>  

Thanks Arnaldo!

>> Thanks
>> James
>>
>>>>
>>>>
>>>>>
>>>>> James Clark (1):
>>>>>   perf tools: Add a place to put kernel config fragments for test runs
>>>>>
>>>>>  tools/perf/tests/config-fragments/README |  7 +++++++
>>>>>  tools/perf/tests/config-fragments/arm64  |  1 +
>>>>>  tools/perf/tests/config-fragments/config | 11 +++++++++++
>>>>>  3 files changed, 19 insertions(+)
>>>>>  create mode 100644 tools/perf/tests/config-fragments/README
>>>>>  create mode 100644 tools/perf/tests/config-fragments/arm64
>>>>>  create mode 100644 tools/perf/tests/config-fragments/config
>>>>>
>>>>>
>>>>> base-commit: ad5f604e186ac08d12c401e34ea96c09c38ddbc5
>>>>> --
>>>>> 2.34.1
>>>>>
> 
