Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6878788BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbjHYOkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjHYOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:39:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67FEC;
        Fri, 25 Aug 2023 07:39:34 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PEbgfJ010282;
        Fri, 25 Aug 2023 14:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6+7zABpXZX1TgJmmvsZ0KlkGB5sbzJTpSi9a6XkCODQ=;
 b=Udoza3nnUvKRvWwBzNxV81JIFZfZeYItWDqJhR+et3Dd50A8pxYGjlFJHXvUl/WnTHpZ
 PSdgPX5HcR2GVCBhC8XDTyuRjr8yPHj8LnKndLETewcf4jbsbVwc9GAumgBLDtblkn8+
 GWVlCDj9WsxqXSpZKed84Hes56JpVFwmj96WcAG6DB+Opq7t2CvfrdhOOD7eXo0cB1qn
 2eFPW7c3qXVo7wy0AmAfZAbqgB2FfO50yAVUtALCJMqH6w0AEb8rSYCBQ721wK7sRhKP
 /qlLITdDJiWXlQw4Wp/FvDbhVKkGpPHyqOO7G54jdo1oMwr1j+kY/yQ0hlz7itlzr3+o yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spx2sg4vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 14:39:28 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PEdBKO015511;
        Fri, 25 Aug 2023 14:39:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spx2sg4vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 14:39:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PD2CLR004047;
        Fri, 25 Aug 2023 14:39:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn21s086k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 14:39:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PEdN7X32637400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:39:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B954B20040;
        Fri, 25 Aug 2023 14:39:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B45A2004D;
        Fri, 25 Aug 2023 14:39:23 +0000 (GMT)
Received: from [9.171.39.59] (unknown [9.171.39.59])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 14:39:23 +0000 (GMT)
Message-ID: <4f2438fc-2360-8833-3751-fe3bc8b11afb@linux.ibm.com>
Date:   Fri, 25 Aug 2023 16:39:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/18] perf s390 s390_cpumcfdg_dump: Don't scan all
 PMUs
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824041330.266337-1-irogers@google.com>
 <20230824041330.266337-7-irogers@google.com> <ZOdiX4eJHFfFbQhi@kernel.org>
 <428afeb4-d5ca-8115-73fc-881119a1cd51@linux.ibm.com>
 <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fVt1vxK0CJ=aYjZzs4mushbxAx8056uxVQZUfsLAKpVoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wLyzL3BFUfWzBQhcyFxlrYCLGx5RC_YQ
X-Proofpoint-GUID: Ifn6l6nB2jwwUsk2YRLRK7stbpmKonJt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250129
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 15:14, Ian Rogers wrote:
> On Fri, Aug 25, 2023 at 1:20 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> On 8/24/23 15:59, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Aug 23, 2023 at 09:13:18PM -0700, Ian Rogers escreveu:
>>>> Rather than scanning all PMUs for a counter name, scan the PMU
>>>> associated with the evsel of the sample. This is done to remove a
>>>> dependence on pmu-events.h.
>>>
>>> I'm applying this one, and CCing the S/390 developers so that they can
>>> try this and maybe provide an Acked-by/Tested-by,
>>>
>>> - Arnaldo
>>
>>
>> Arnaldo,
>>
>> I have downloaded this patch set of 18 patches (using b4), but they do not
>> apply on my git tree.
>>
>> Which git branch do I have to use to test this. Thanks a lot.
> 
> Hi Thomas,
> 
> the changes are in the perf-tools-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
> 
> Thanks,
> Ian
> 


Hi Ian,

thanks for the pointer.

Unfurtunately this patch set fails again on s390.
Here is the test output from the current 6.5.0rc7 kernel:

# ./perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs                          : Ok
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : Ok
  6.6: Parsing of terms (event modifiers)                            : Ok
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
 95: perf all metricgroups test                                      : Ok
 96: perf all metrics test                                           : Ok
# 

This looks good.

However when I use the check-out from perf-tools-next, I get this output:
# ./perf test 6 10 'perf all metricgroups test' 'perf all metrics test'
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs                          : FAILED!
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : FAILED!
  6.6: Parsing of terms (event modifiers)                            : Ok
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : FAILED!
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
 93: perf all metricgroups test                                      : FAILED!
 94: perf all metrics test                                           : FAILED!
# 

So some tests are failing again.

I am out for the next two weeks, Sumanth Korikkar (on to list) might be able to help.
Thanks a lot.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

