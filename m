Return-Path: <linux-kernel+bounces-6582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9654819A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B1C1C250D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139761D55C;
	Wed, 20 Dec 2023 08:37:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5B1D52B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VyteU4X_1703061428;
Received: from 30.221.146.20(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VyteU4X_1703061428)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 16:37:09 +0800
Message-ID: <98276b4d-d842-4dac-ab06-2e0fd245f3a8@linux.alibaba.com>
Date: Wed, 20 Dec 2023 16:37:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf tools arch Arm CMN PMU JSON files build breakage on ubuntu
 18.04 cross build
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kajoljain <kjain@linux.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ian Rogers <irogers@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <ZBxP77deq7ikTxwG@kernel.org>
 <a21aa4e1-506a-916c-03bd-39d7403c7941@linux.ibm.com>
 <ZXxlERShV-TIGVit@kernel.org> <ZXxlj3g-KMG3iYjx@kernel.org>
From: Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <ZXxlj3g-KMG3iYjx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2023/12/15 下午10:41, Arnaldo Carvalho de Melo 写道:
> Em Fri, Dec 15, 2023 at 11:39:14AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Mar 27, 2023 at 09:52:11AM +0530, kajoljain escreveu:
>>> On 3/23/23 18:41, Arnaldo Carvalho de Melo wrote:
>>>> Exception processing pmu-events/arch/powerpc/power9/other.json
>>>> Traceback (most recent call last):
>>>>   File "pmu-events/jevents.py", line 997, in <module>
>>>>     main()
>>>>   File "pmu-events/jevents.py", line 979, in main
>>>>     ftw(arch_path, [], preprocess_one_file)
>>>>   File "pmu-events/jevents.py", line 935, in ftw
>>>>     ftw(item.path, parents + [item.name], action)
>>>>   File "pmu-events/jevents.py", line 933, in ftw
>>>>     action(parents, item)
>>>>   File "pmu-events/jevents.py", line 514, in preprocess_one_file
>>>>     for event in read_json_events(item.path, topic):
>>>>   File "pmu-events/jevents.py", line 388, in read_json_events
>>>>     events = json.load(open(path), object_hook=JsonEvent)
>>>>   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
>>>>     return loads(fp.read(),
>>>>   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
>>>>     return codecs.ascii_decode(input, self.errors)[0]
>>>> UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 55090: ordinal not in range(128)
>>>>   CC      /tmp/build/perf/tests/expr.o
>>>> pmu-events/Build:35: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
>>>> make[3]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 1
>>>> make[3]: *** Deleting file '/tmp/build/perf/pmu-events/pmu-events.c'
>>>> Makefile.perf:679: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
>>>> make[2]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
>>>> make[2]: *** Waiting for unfinished jobs....
>>
>>>> Now jevents is an opt-out feature so I'm noticing these problems.
>>  
>>>     Thanks for raising it. I will check this issue.
>>
>> Now I'm seeing this on:
> 
> Jing,
> 
> 	Please take a look at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d9df8731c0941f3add30f96745a62586a0c9d52
> 
> 	For the fix for the ppc case above.
> 

I'm sorry for the breakage. Thanks for the catch! I will fix it soon.

Thanks,
Jing


> - Arnaldo
>  
>> Exception processing pmu-events/arch/arm64/arm/cmn/sys/cmn.json
>> Traceback (most recent call last):
>>   File "pmu-events/jevents.py", line 1285, in <module>
>>     main()
>>   File "pmu-events/jevents.py", line 1267, in main
>>     ftw(arch_path, [], preprocess_one_file)
>>   File "pmu-events/jevents.py", line 1217, in ftw
>>     ftw(item.path, parents + [item.name], action)
>>   File "pmu-events/jevents.py", line 1217, in ftw
>>     ftw(item.path, parents + [item.name], action)
>>   File "pmu-events/jevents.py", line 1217, in ftw
>>     ftw(item.path, parents + [item.name], action)
>>   File "pmu-events/jevents.py", line 1215, in ftw
>>     action(parents, item)
>>   File "pmu-events/jevents.py", line 599, in preprocess_one_file
>>     for event in read_json_events(item.path, topic):
>>   File "pmu-events/jevents.py", line 416, in read_json_events
>>     events = json.load(open(path), object_hook=JsonEvent)
>>   File "/usr/lib/python3.6/json/__init__.py", line 296, in load
>>     return loads(fp.read(),
>>   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
>>     return codecs.ascii_decode(input, self.errors)[0]
>> UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 3071: ordinal not in range(128)
>>
> 

