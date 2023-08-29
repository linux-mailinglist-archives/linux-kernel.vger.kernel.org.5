Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C138D78BDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjH2FIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjH2FHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:07:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E6194;
        Mon, 28 Aug 2023 22:07:27 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T56Xtt027948;
        Tue, 29 Aug 2023 05:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/m5FrDuQYlMc/xyO8GAUUAjp+FGYZ8YrdeCkWwpkXxU=;
 b=hkCFTzfjgJJxf+ixhl9Y+a13L0rZ2+U9DuqcsEkQgKhrX17S6iPIiLU/vDdioaXABcqV
 qnxBmkkW1tGtXkTHSozva8364BQrkrntiejCyiXMewKaay/C++MCgdNnbGBsn6DfLKMx
 z5ajxkUVKcHZRpl/JfxRY/7+DoYlgCL/oMc8QPbtsMJMbBa6UFoSGfPW2wMzx39z/iiL
 /o4sXwqgvpUYUPtRGARGNA+FPrdex436FLoHWov4iigfrJHTZm5V6w+R/qW00Hl42hIm
 nivBFmlEJmNeb+t9DinRyRaNJWT9pu9pnmavWNN2P0UcuJSwyPK0EehTJHzuMmGIJJvU mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8s70p90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:07:00 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T56YbO027967;
        Tue, 29 Aug 2023 05:06:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8s70p8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:06:59 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37T462kX020543;
        Tue, 29 Aug 2023 05:06:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3y9066-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:06:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37T56u1X19464916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 05:06:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F58F20043;
        Tue, 29 Aug 2023 05:06:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F32B920040;
        Tue, 29 Aug 2023 05:06:51 +0000 (GMT)
Received: from [9.43.109.109] (unknown [9.43.109.109])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 05:06:51 +0000 (GMT)
Message-ID: <0eed406a-c336-c948-18cb-d46e9992af06@linux.ibm.com>
Date:   Tue, 29 Aug 2023 10:36:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 0/2] perf list: Remove duplicate PMUs
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825135237.921058-1-irogers@google.com>
Content-Language: en-US
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20230825135237.921058-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TRIPq8e-pMebachRblXPaAzDo55CXf7J
X-Proofpoint-ORIG-GUID: JjByNKl2VLND9b2z_nLXirh5Zsd16_VM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_02,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290043
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Patchset looks good to me.

Reviewed-by: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain

On 8/25/23 19:22, Ian Rogers wrote:
> When there are multiple PMUs, differing by ordered suffixes, by
> default only display one. This avoids repeated listing of events, in
> particular when there are 10s of uncore PMUs. If "-v" is passed to
> "perf list" then still list all PMUs.
> 
> Listing fewer PMU/event combinations helps speed the all PMU event
> tests.
> 
> Before:
> ```
> $ perf list
> ...
>   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> ```
> 
> After:
> ```
> $ perf list
> ...
>   uncore_imc_free_running/data_read/                 [Kernel PMU event]
>   uncore_imc_free_running/data_total/                [Kernel PMU event]
>   uncore_imc_free_running/data_write/                [Kernel PMU event]
> ...
> $ perf list -v
> ...
>   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> ...
> ```
> 
> The PMUs are sorted by name then suffix as a part of this change.
> 
> v5: Improved the 2nd patch's commit message and removed an unused
>     variable as suggested by Kan Liang <kan.liang@linux.intel.com>.
> v4: Rebase on top of lazy PMU changes. Ignore numeric ordering due to
>     gaps, suggested by Kan Liang <kan.liang@linux.intel.com>. Fold
>     patches 2 & 3 as suggested by John Garry <john.g.garry@oracle.com>
>     (done by accident as part of rebasing).
> v3: Add detail to patch 1 sorting commit message about the suffix and
>     why sorting is necessary.
> v2: List all PMUs when "-v" is passed as suggested by John Garry
>     <john.g.garry@oracle.com>.
> 
> Ian Rogers (2):
>   perf pmus: Sort pmus by name then suffix
>   perf pmus: Skip duplicate PMUs and don't print list suffix by default
> 
>  tools/perf/builtin-list.c         |  8 +++
>  tools/perf/util/pmu.c             | 17 ++++--
>  tools/perf/util/pmu.h             |  3 +-
>  tools/perf/util/pmus.c            | 99 ++++++++++++++++++++++++++++++-
>  tools/perf/util/pmus.h            |  2 +
>  tools/perf/util/print-events.h    |  1 +
>  tools/perf/util/s390-sample-raw.c |  3 +-
>  7 files changed, 123 insertions(+), 10 deletions(-)
> 
