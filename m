Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B797D9239
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbjJ0ImA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbjJ0Ila (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:41:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B2171D;
        Fri, 27 Oct 2023 01:40:55 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R4it2A004319;
        Fri, 27 Oct 2023 08:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xK2pFr5GAzIQ3scH5dwtO9q5UfJLtIUXvIbAOvHWIU4=;
 b=HIq801a28vefsOcBfQFlP6NF+17TJxUy/4nzDZPUzJq8SpSf5S8yi3lu/qt4l+wHfPhd
 VYO/a1p/UsFTNkjWnQr5P6I5YnZ0Uyfo3FEB259euMm7uJIWR3pCEiZRvebxW2KAfasE
 kOn7s6lRdkJJOuBHGxtlyEg7Dut/zLDuip2FTAr8g0u2xZFAPU6VotYSiqqRye3wCiEp
 dhEYXpMaFKMbFFxvU3nFR5NaH5JkatrQVpHi5Z2uAC+BB1grxIgLvoLxFdVeFeCpJgYV
 E60spMcjELBRlxs4sMY2VU4YL8oRt/q9QQ9SFnHBMJU+xR4Bqik+KLya5kPeQin/NPAI zg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxas1fv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 08:40:50 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39R8eoF4020292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 08:40:50 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 27 Oct
 2023 01:40:47 -0700
Message-ID: <aa71f7e3-71c5-1d2f-bc73-6db977025b41@quicinc.com>
Date:   Fri, 27 Oct 2023 14:10:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tracing/kprobes: Fix the description of variable length
 arguments
Content-Language: en-US
To:     Yujie Liu <yujie.liu@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20231027041315.2613166-1-yujie.liu@intel.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231027041315.2613166-1-yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fjY3N6CHYf5pH3Y66ZhhZTAz3NQRREI4
X-Proofpoint-ORIG-GUID: fjY3N6CHYf5pH3Y66ZhhZTAz3NQRREI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1011 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310270074
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2023 9:43 AM, Yujie Liu wrote:
> Fix the following kernel-doc warnings:
> 
> kernel/trace/trace_kprobe.c:1029: warning: Excess function parameter 'args' description in '__kprobe_event_gen_cmd_start'
> kernel/trace/trace_kprobe.c:1097: warning: Excess function parameter 'args' description in '__kprobe_event_add_fields'
> 
> Refer to the usage of variable length arguments elsewhere in the kernel
> code, "@..." is the proper way to express it in the description.
> 
> Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310190437.paI6LYJF-lkp@intel.com/
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>

Not related to this patch, but I see order of the argument as well is 
not proper in the document of the __kprobe_event_gen_cmd_start(),
if you can fix that too.

LGTM, Thanks for this.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   kernel/trace/trace_kprobe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a8fef6ab0872..95c5b0668cb7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1007,7 +1007,7 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
>    * @name: The name of the kprobe event
>    * @loc: The location of the kprobe event
>    * @kretprobe: Is this a return probe?
> - * @args: Variable number of arg (pairs), one pair for each field
> + * @...: Variable number of arg (pairs), one pair for each field
>    *
>    * NOTE: Users normally won't want to call this function directly, but
>    * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
> @@ -1080,7 +1080,7 @@ EXPORT_SYMBOL_GPL(__kprobe_event_gen_cmd_start);
>   /**
>    * __kprobe_event_add_fields - Add probe fields to a kprobe command from arg list
>    * @cmd: A pointer to the dynevent_cmd struct representing the new event
> - * @args: Variable number of arg (pairs), one pair for each field
> + * @...: Variable number of arg (pairs), one pair for each field
>    *
>    * NOTE: Users normally won't want to call this function directly, but
>    * rather use the kprobe_event_add_fields() wrapper, which
