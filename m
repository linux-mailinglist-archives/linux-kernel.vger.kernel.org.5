Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314117EA99A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjKNEfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjKNEfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:35:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88584D42;
        Mon, 13 Nov 2023 20:35:20 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE2enuY015545;
        Tue, 14 Nov 2023 04:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mmSUoAY3idS7EMo1OCwa4Vlm1FH71gDEVXdoggFmtBU=;
 b=dosNbqsgW/q1pTNuSCxKi3ZzAxlHAOo7REBG5XPeMeCJzuLZ7+7i8K/P2OsDjs896yvN
 XZSneSk9dAhG6buk8YVksZbnaUMvlnrMHZeWR3Jjib/98/CpeDhxReNq6Z/+SXd8x86i
 LwJHtmEv+MbT9rPNU0wBnvDAFmLBwG+NiTMl7n8ai42ynv8xQdWIQ4LKLWqVPnw51mg8
 hV/rEbLvbiH39HYCRmwOdN7HsPZ7nn0YGXZbj4Xtqyz5Q/r4mMtzwXWb9oFb8k89NWX/
 HBXx+wtNFvR5JlU+WoztxrlF3nUnQaTSmspyZlDEiQ3MjtlgZcMbLfx4fCTArd3Kp7ql QQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubj731qsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 04:35:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AE4ZCg4011384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 04:35:12 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 20:35:08 -0800
Message-ID: <311c74f4-82ba-9a8e-3351-d9c96a369ec5@quicinc.com>
Date:   Tue, 14 Nov 2023 10:05:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4] bus: mhi: host: Add tracing support
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
References: <20231111-ftrace_support-v4-1-c83602399461@quicinc.com>
 <20231111143710.3474e05a@rorschach.local.home>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231111143710.3474e05a@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4Wya69WRhd6HbwTtk4tdIMaZsN_sI4l8
X-Proofpoint-ORIG-GUID: 4Wya69WRhd6HbwTtk4tdIMaZsN_sI4l8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_01,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=935 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140033
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/12/2023 1:07 AM, Steven Rostedt wrote:
> On Sat, 11 Nov 2023 11:25:22 +0530
> Krishna chaitanya chundru <quic_krichai@quicinc.com> wrote:
>> diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
>> new file mode 100644
>> index 000000000000..0e99318f5d08
>> --- /dev/null
>> +++ b/drivers/bus/mhi/host/trace.h
>> +
>> +TRACE_EVENT(mhi_update_channel_state_start,
>> +
>> +	TP_PROTO(const char *name, int ch_num, int state),
>> +
>> +	TP_ARGS(name, ch_num, state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(int, ch_num)
>> +		__field(int, state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__entry->ch_num = ch_num;
>> +		__entry->state = state;
>> +	),
>> +
>> +	TP_printk("%s: ch%d: Updating state to: %s\n",
>> +		  __get_str(name), __entry->ch_num,
>> +		  TO_CH_STATE_TYPE_STR(__entry->state))
>> +);
>> +
>> +TRACE_EVENT(mhi_update_channel_state_end,
>> +
>> +	TP_PROTO(const char *name, int ch_num, int state),
>> +
>> +	TP_ARGS(name, ch_num, state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(int, ch_num)
>> +		__field(int, state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__entry->ch_num = ch_num;
>> +		__entry->state = state;
>> +	),
>> +
>> +	TP_printk("%s: ch%d: Updated state to: %s\n",
>> +		  __get_str(name), __entry->ch_num,
>> +		  TO_CH_STATE_TYPE_STR(__entry->state))
>> +);
>> +
> The above three events have the same format. You can save kilobytes of
> memory by converting them into a DECLARE_EVENT_CLASS() and use
> DEFINE_EVENT() for each event.
>
> A TRACE_EVENT() macro is really just a wrapper around
> DECLARE_EVENT_CLASS() and DEFINE_EVENT(). The DECLARE_EVENT_CLASS()
> does the bulk of the work and adds the most memory footprint. By
> breaking it apart for several events, it does save memory.
>
> Whenever you can use a single DECLARE_EVENT_CLASS() for multiple
> events, I strongly suggest doing so.
>
> Thanks,
>
> -- Steve

Sure steve I will change as suggested in my next patch.

- Krishna Chaitanya.

>
>> +#endif
>> +#undef TRACE_INCLUDE_PATH
>> +#define TRACE_INCLUDE_PATH .
>> +#undef TRACE_INCLUDE_FILE
>> +#define TRACE_INCLUDE_FILE trace
>> +
>> +#include <trace/define_trace.h>
>>
>> ---
>> base-commit: 3006adf3be79cde4d14b1800b963b82b6e5572e0
>> change-id: 20231005-ftrace_support-6869d4156139
>>
>> Best regards,
