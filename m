Return-Path: <linux-kernel+bounces-45612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8095843303
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB3428682E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACFB4C98;
	Wed, 31 Jan 2024 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N55y1LIB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796F5667;
	Wed, 31 Jan 2024 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665822; cv=none; b=gvlbR/3IivQOpPWnPPao+Va3CNs6r96//6MBWbhCwoDNPjKGjUclB0uix4px6cLfiojmFUMdoXFeZ3Ta+0f59pp5uvoxPODuBKVYShx3z3s8VtoqNzmi0/tfQ8ulK8r3wc6DFu2AUbfxidNTNsikW6PjFUKO47sOaQ9UgZnkCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665822; c=relaxed/simple;
	bh=/8Wby2OiydINwAPdsuxfMFpTvjRqr3bToN//tTrsRIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mhdKt4cNZ7yxGMf/VPfExUh6MuO0xteh24vUxZU97GkEl4CP6+IXpZDwO/kPn3VSubF4vUVqLe6Wu/tqi5y+mHhIv4o9YD+DZu/7yue9T+4sPK+2Ou0nVXMubtbUegOzQHTV2YCk8qDKfyH+nsza5T6/o4zKrVGGf+69dnEqq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N55y1LIB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V0QK9c022721;
	Wed, 31 Jan 2024 01:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cMM4QYyHY9BblaVLuPOFRGFx0CWwGbQV8FlLVlpwXCY=; b=N5
	5y1LIBeqzD+nhqyQW6OcVMre/JL5VBq0iBTAewa+895u9mn6k026oZzEBT6ZE6ti
	xhypuICfI7CGmyYvjkf5x27RXUmq7WgkyGB/CASDpzfU6rSO7nbMtNT+0LCDShE3
	NyNhhupZMm9eR0G72JvHwmjK4M71pk2NLeApZhE7ryqm8TEZYl6lTml8rxmH0I0a
	x3ifDsbbNUAtaOPTv1X2lVjTe8CBpKQgvR6GibDFVrSusrvz/oVGbd+uGNs1aRJP
	JrppQ9F6Foc9oGAo4xkyBvcc0fs7z4DRgRZ1GTqW2heX5eAGGuZcRmtnXsASrONA
	0jzOADtzTQZtR/qANHKg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy9b8rcbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 01:50:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V1oDaB008163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 01:50:13 GMT
Received: from [10.216.5.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 17:50:08 -0800
Message-ID: <98602d57-5b52-1180-4a71-26223b9b4738@quicinc.com>
Date: Wed, 31 Jan 2024 07:20:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v9] bus: mhi: host: Add tracing support
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240105-ftrace_support-v9-1-a2dca64cc6ea@quicinc.com>
 <20240130081152.GH32821@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240130081152.GH32821@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 63ALK7QvKyowvRoFY-BRepx_pk4y6lGd
X-Proofpoint-ORIG-GUID: 63ALK7QvKyowvRoFY-BRepx_pk4y6lGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310014



On 1/30/2024 1:41 PM, Manivannan Sadhasivam wrote:
> On Fri, Jan 05, 2024 at 05:53:03PM +0530, Krishna chaitanya chundru wrote:
>> This change adds ftrace support for following functions which
>> helps in debugging the issues when there is Channel state & MHI
>> state change and also when we receive data and control events:
>> 1. mhi_intvec_mhi_states
>> 2. mhi_process_data_event_ring
>> 3. mhi_process_ctrl_ev_ring
>> 4. mhi_gen_tre
>> 5. mhi_update_channel_state
>> 6. mhi_tryset_pm_state
>> 7. mhi_pm_st_worker
>>
>> Change the implementation of the arrays which has enum to strings mapping
>> to make it consistent in both trace header file and other files.
>>
>> Where ever the trace events are added, debug messages are removed.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Few nitpicks below.
> 
I will make suggested changes in next patch.

- Krishna Chaitanya.
>> Reviewed-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>> ---
>> Changes in v9:
>> - Change the implementations of some array so that the strings to enum mapping
>> - is same in both trace header and other files as suggested by steve.
>> - Link to v8: https://lore.kernel.org/r/20231207-ftrace_support-v8-1-7f62d4558555@quicinc.com
>>
>> Changes in v8:
>> - Pass the structure and derefernce the variables in TP_fast_assign as suggested by steve
>> - Link to v7: https://lore.kernel.org/r/20231206-ftrace_support-v7-1-aca49a04268b@quicinc.com
>>
>> Changes in v7:
>> - change log format as pointed by mani.
>> - Link to v6: https://lore.kernel.org/r/20231204-ftrace_support-v6-1-9b206546dac2@quicinc.com
>>
>> Changes in v6:
>> - use 'rp' directly as suggested by jeffrey.
>> - Link to v5: https://lore.kernel.org/r/20231127-ftrace_support-v5-1-eb67daead4f1@quicinc.com
>>
>> Changes in v5:
>> - Use DECLARE_EVENT_CLASS for multiple events as suggested by steve.
>> - Instead of converting to u64 to print address, use %px to print the address to avoid
>> - warnings in some platforms.
>> - Link to v4: https://lore.kernel.org/r/20231111-ftrace_support-v4-1-c83602399461@quicinc.com
>>
>> Changes in v4:
>> - Fix compilation issues in previous patch which happended due to rebasing.
>> - In the defconfig FTRACE config is not enabled due to that the compilation issue is not
>> - seen in my workspace.
>> - Link to v3: https://lore.kernel.org/r/20231111-ftrace_support-v3-1-f358d2911a74@quicinc.com
>>
>> Changes in v3:
>> - move trace header file from include/trace/events to drivers/bus/mhi/host/ so that
>> - we can include driver header files.
>> - Use macros directly in the trace events as suggested Jeffrey Hugo.
>> - Reorder the structure in the events as suggested by steve to avoid holes in the buffer.
>> - removed the mhi_to_physical function as this can give security issues.
>> - removed macros to define strings as we can get those from driver headers.
>> - Link to v2: https://lore.kernel.org/r/20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com
>>
>> Changes in v2:
>> - Passing the raw state into the trace event and using  __print_symbolic() as suggested by bjorn.
>> - Change mhi_pm_st_worker to mhi_pm_st_transition as suggested by bjorn.
>> - Fixed the kernel test rebot issues.
>> - Link to v1: https://lore.kernel.org/r/20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com
>> ---
>>   drivers/bus/mhi/common.h        |  38 +++---
>>   drivers/bus/mhi/host/init.c     |  63 +++++----
>>   drivers/bus/mhi/host/internal.h |  40 ++++++
>>   drivers/bus/mhi/host/main.c     |  19 ++-
>>   drivers/bus/mhi/host/pm.c       |   7 +-
>>   drivers/bus/mhi/host/trace.h    | 275 ++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 378 insertions(+), 64 deletions(-)
>>
> 
> [...]
> 
>> +TRACE_EVENT(mhi_gen_tre,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>> +		 struct mhi_ring_element *mhi_tre),
>> +
>> +	TP_ARGS(mhi_cntrl, mhi_chan, mhi_tre),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, mhi_cntrl->mhi_dev->name)
>> +		__field(int, ch_num)
>> +		__field(void *, wp)
>> +		__field(__le64, tre_ptr)
>> +		__field(__le32, dword0)
>> +		__field(__le32, dword1)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
>> +		__entry->ch_num = mhi_chan->chan;
>> +		__entry->wp = mhi_tre;
>> +		__entry->tre_ptr = mhi_tre->ptr;
>> +		__entry->dword0 = mhi_tre->dword[0];
>> +		__entry->dword1 = mhi_tre->dword[1];
>> +	),
>> +
>> +	TP_printk("%s: Chan: %d Tre: 0x%p Tre buf: 0x%llx dword0: 0x%08x dword1: 0x%08x\n",
> 
> Use caps for printing the acronyms everywhere. Like TRE, DWORD etc...
> 
>> +		  __get_str(name), __entry->ch_num, __entry->wp, __entry->tre_ptr,
>> +		  __entry->dword0, __entry->dword1)
>> +);
>> +
>> +TRACE_EVENT(mhi_intvec_states,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, int dev_ee, int dev_state),
>> +
>> +	TP_ARGS(mhi_cntrl, dev_ee, dev_state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, mhi_cntrl->mhi_dev->name)
>> +		__field(int, local_ee)
>> +		__field(int, state)
>> +		__field(int, dev_ee)
>> +		__field(int, dev_state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
>> +		__entry->local_ee = mhi_cntrl->ee;
>> +		__entry->state = mhi_cntrl->dev_state;
>> +		__entry->dev_ee = dev_ee;
>> +		__entry->dev_state = dev_state;
>> +	),
>> +
>> +	TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",
> 
> "Local EE... State:...Device EE.."
> 
>> +		  __get_str(name),
>> +		  __print_symbolic(__entry->local_ee, MHI_EE_LIST),
>> +		  __print_symbolic(__entry->state, MHI_STATE_LIST),
>> +		  __print_symbolic(__entry->dev_ee, MHI_EE_LIST),
>> +		  __print_symbolic(__entry->state, MHI_STATE_LIST))
>> +);
>> +
> 
> [...]
> 
>> +DECLARE_EVENT_CLASS(mhi_update_channel_state,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan, int state),
>> +
>> +	TP_ARGS(mhi_cntrl, mhi_chan, state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, mhi_cntrl->mhi_dev->name)
>> +		__field(int, ch_num)
>> +		__field(int, state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
>> +		__entry->ch_num = mhi_chan->chan;
>> +		__entry->state = state;
>> +	),
>> +
>> +	TP_printk("%s: chan%d: Updating state to: %s\n",
>> +		  __get_str(name), __entry->ch_num,
>> +		  __print_symbolic(__entry->state, MHI_CH_STATE_TYPE_LIST))
> 
> So same trace will get printed for both mhi_channel_command_start() and
> mhi_channel_command_end()?
> 
> - Mani
> 

