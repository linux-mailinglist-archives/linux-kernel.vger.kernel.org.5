Return-Path: <linux-kernel+bounces-17478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B6824DFC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B375F1C21B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648F95399;
	Fri,  5 Jan 2024 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H+mKHlKK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C915228;
	Fri,  5 Jan 2024 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4053Y5TX031429;
	Fri, 5 Jan 2024 05:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VY7uvXebZw2VgVfK+qIMw+k+a62Uq1W2zFyOrV4pavw=; b=H+
	mKHlKKhrgEhr678/M/bp6vu0Pa2fe4yKgWfmstUW6ARNq24EGPxD//RtKJ2C+ukg
	5tHyyfvp83gA6cpf9MBC6yqvZjUptqqT5i3rjFK3BHs543vd5rHEqxHGQd2UtOdG
	HWteXmoA6XVgZ2HIBVuuHRx9CugqJNguWcGgtWBmcrNleF/mlcAiJkvHuQaXo8kg
	pKhxAppWc7pBHwDeJecrQHFTVkB1kWBWtITUlpVtZZSLzeIhKrJ4f87WENDHEiVI
	VfITJQsUlw6ZBd+LPKB4dvZhDbyOa2j0FXDJ+XLncnNXtaPQsMOAibWZQ+E/XzR0
	huF0WdTzKqsQ2U2BefKQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve98v86nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 05:06:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40556jP6006614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 05:06:45 GMT
Received: from [10.216.4.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 21:06:41 -0800
Message-ID: <dbcd2f31-d4dc-12d8-7e32-911e07d7c7d1@quicinc.com>
Date: Fri, 5 Jan 2024 10:36:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v8] bus: mhi: host: Add tracing support
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
CC: Manivannan Sadhasivam <mani@kernel.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20231207-ftrace_support-v8-1-7f62d4558555@quicinc.com>
 <20240104110127.42da8ec8@gandalf.local.home>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240104110127.42da8ec8@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tWFyZcAOkzmmadFoISVaCIsnIVGOM5X2
X-Proofpoint-ORIG-GUID: tWFyZcAOkzmmadFoISVaCIsnIVGOM5X2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401050040


On 1/4/2024 9:31 PM, Steven Rostedt wrote:
> On Thu, 7 Dec 2023 10:00:47 +0530
> Krishna chaitanya chundru <quic_krichai@quicinc.com> wrote:
>
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
>> Where ever the trace events are added, debug messages are removed.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> Changes in v8:
>> - Pass the structure and derefernce the variables in TP_fast_assign as suggested by steve
>> - Link to v7: https://lore.kernel.org/r/20231206-ftrace_support-v7-1-aca49a04268b@quicinc.com
> So this looks good from a tracing POV.
>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> But I do have some more comments that could be done by new patches.
>
>
>
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
>> +		  __get_str(name),
>> +		  TO_MHI_EXEC_STR(__entry->local_ee),
>> +		  mhi_state_str(__entry->state),
>> +		  TO_MHI_EXEC_STR(__entry->dev_ee),
>> +		  mhi_state_str(__entry->dev_state))
> So the above may have issues with user space parsing.
>
> For one, that mhi_state_str() is:
>
> static inline const char *mhi_state_str(enum mhi_state state)
> {
>          switch (state) {
>          case MHI_STATE_RESET:
>                  return "RESET";
>          case MHI_STATE_READY:
>                  return "READY";
>          case MHI_STATE_M0:
>                  return "M0";
>          case MHI_STATE_M1:
>                  return "M1";
>          case MHI_STATE_M2:
>                  return "M2";
>          case MHI_STATE_M3:
>                  return "M3";
>          case MHI_STATE_M3_FAST:
>                  return "M3 FAST";
>          case MHI_STATE_BHI:
>                  return "BHI";
>          case MHI_STATE_SYS_ERR:
>                  return "SYS ERROR";
>          default:
>                  return "Unknown state";
>          }
> };
>   
> Which if this could be changed into:
>
> #define MHI_STATE_LIST			\
> 	EM(RESET,    "RESET")		\
> 	EM(READY,    "READY")		\
> 	EM(M0,       "M0")		\
> 	EM(M1,       "M1")		\
> 	EM(M2,       "M2")		\
> 	EM(M3,       "M3")		\
> 	EM(M3_FAST,  "M3_FAST")		\
> 	EM(BHI,      "BHI")		\
> 	EMe(SYS_ERR, "SYS ERROR")
>
> #undef EM
> #undef EMe
>
> #define EM(a, b)  case MHI_STATE_##a: return b;
> #define EMe(a, b) case MHI_STATE_##a: return b;
>
> static inline const char *mhi_state_str(enum mhi_state state)
> {
>          switch (state) {
> 	MHI_STATE_LIST
> 	default:
> 		return "Unknown state";
> }
>
> Then you could use that macro in the trace header:
>
> #undef EM
> #undef EMe
>
> #define EM(a, b)	TRACE_DEFINE_ENUM(MHI_STATE_##a);
> #define EMe(a, b)	TRACE_DEFINE_ENUM(MHI_STATE_##a);
>
> MHI_STATE_LIST
>
> And in the print fmts:
>
> #undef EM
> #undef EMe
>
> #define EM(a, b)   { MHI_STATE_##a, b },
> #define EMe(a, b)  { MHI_STATE_##a, b }
>
>
> 	TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",
> 		  __get_str(name),
> 		  TO_MHI_EXEC_STR(__entry->local_ee),
>
> 		  __print_symbolic(__entry->state), MHI_STATE_LIST),
>
> 		  TO_MHI_EXEC_STR(__entry->dev_ee),
>
> 		  __print_symbolic(__entry->dev_state, MHI_STATE_LIST))
>
>
> And that will be exported to user space in the
> /sys/kernel/tracing/events/*/*/format file, as:
>
> 	__print_symbolic(REC->state, {
> 	        { MHI_STATE_RESET, "RESET"},
> 	        { MHI_STATE_READY, "READY"},
> 	        { MHI_STATE_M0, "M0"},
> 	        { MHI_STATE_M1, "M1"},
> 	        { MHI_STATE_M2, "M2"},
> 	        { MHI_STATE_M3, "M3"},
> 	        { MHI_STATE_M3_FAST, "M3 FAST"},
> 	        { MHI_STATE_BHI, "BHI"},
> 	        { MHI_STATE_SYS_ERR, "SYS ERROR"} }
>
> Which libtracevent knows how to parse. Oh, it wouldn't even show the enum
> names as the TRACE_DEFINE_ENUM() above, would tell the kernel to replace
> them with their actual numeric values. That way, when trace-cmd or perf
> reads the raw data, it knows how to print it.
>
> Now what about those TO_MHI_EXEC_STR() macros? They are not the same. They are:
>
> #define TO_MHI_EXEC_STR(ee) (((ee) >= MHI_EE_MAX) ? \
>                               "INVALID_EE" : mhi_ee_str[ee])
>
> Where that mhi_ee_str[] is:
>
> const char * const mhi_ee_str[MHI_EE_MAX] = {
>          [MHI_EE_PBL] = "PRIMARY BOOTLOADER",
>          [MHI_EE_SBL] = "SECONDARY BOOTLOADER",
>          [MHI_EE_AMSS] = "MISSION MODE",
>          [MHI_EE_RDDM] = "RAMDUMP DOWNLOAD MODE",
>          [MHI_EE_WFW] = "WLAN FIRMWARE",
>          [MHI_EE_PTHRU] = "PASS THROUGH",
>          [MHI_EE_EDL] = "EMERGENCY DOWNLOAD",
>          [MHI_EE_FP] = "FLASH PROGRAMMER",
>          [MHI_EE_DISABLE_TRANSITION] = "DISABLE",
>          [MHI_EE_NOT_SUPPORTED] = "NOT SUPPORTED",
> };
>
> Which would require doing the same thing for that as well.
>
> #define MHI_EE_LIST 					\
> 	EM(PBL,			"PRIMARY BOOTLOADER")	\
> 	EM(SBL,			"SECONDARY BOOTLOADER")	\
> 	EM(AMSS,		"MISSION MODE")		\
> 	EM(RDDM,		"RAMDUMP DOWNLOAD MODE")\
> 	EM(WFW,			"WLAN FIRMWARE")	\
> 	EM(PTHRU,		"PASS THROUGH")		\
> 	EM(EDL,			"EMERGENCY DOWNLOAD")	\
> 	EM(FP,			"FLASH PROGRAMMER")	\
> 	EM(DISABLE_TRANSITION,	"DISABLE")		\
> 	EMe(NOT_SUPPORTED,	"NOT SUPPORTED")
>
> And have:
>
> #undef EM
> #undef EMe
>
> #define EM(a, b)  [MHI_EE_##a] = b,
> #define EMe(a, b) [MHI_EE_##a] = b,
>
> const char * const mhi_ee_str[MHI_EE_MAX] = {
> 	MHI_EE_LIST
> };
>
> and so on. That way the user space parsing will know how to properly parse
> these events.
>
> Note, if you don't want to modify the other files, you can still just all
> the above to the trace.h file and it will still properly map the enums to
> the strings. That is, don't modify the mhi_ee_str(), but instead just add
> the MHI_EE_LIST macro in the trace header, and use the __print_symbolic()
> with it.
>
> I only mentioned modifying the strings to make it consistent if new strings
> are added.
>
> -- Steve

Thanks steve for the these inputs, we will try these and will update as 
suggested in the next patch.

- Krishna chaitanya

>
>> +);
>> +
>> +TRACE_EVENT(mhi_tryset_pm_state,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, int pm_state),
>> +
>> +	TP_ARGS(mhi_cntrl, pm_state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, mhi_cntrl->mhi_dev->name)
>> +		__field(int, pm_state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
>> +		if (pm_state)
>> +			pm_state = __fls(pm_state);
>> +		__entry->pm_state = pm_state;
>> +	),
>> +
>> +	TP_printk("%s: PM state: %s\n", __get_str(name),
>> +		  to_mhi_pm_state_str(__entry->pm_state))
>> +);
>> +
>> +DECLARE_EVENT_CLASS(mhi_process_event_ring,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct
>> mhi_ring_element *rp), +
>> +	TP_ARGS(mhi_cntrl, rp),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, mhi_cntrl->mhi_dev->name)
>> +		__field(__le32, dword0)
>> +		__field(__le32, dword1)
>> +		__field(int, state)
>> +		__field(__le64, ptr)
>> +		__field(void *, rp)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
>> +		__entry->rp = rp;
>> +		__entry->ptr = rp->ptr;
>> +		__entry->dword0 = rp->dword[0];
>> +		__entry->dword1 = rp->dword[1];
>> +		__entry->state = MHI_TRE_GET_EV_STATE(rp);
>> +	),
>> +
>> +	TP_printk("%s: Tre: 0x%p Tre buf: 0x%llx dword0: 0x%08x dword1:
>> 0x%08x state: %s\n",
>> +		  __get_str(name), __entry->rp, __entry->ptr,
>> __entry->dword0,
>> +		  __entry->dword1, mhi_state_str(__entry->state))
>> +);
>> +
>> +DEFINE_EVENT(mhi_process_event_ring, mhi_data_event,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct
>> mhi_ring_element *rp), +
>> +	TP_ARGS(mhi_cntrl, rp)
>> +);
>> +
>> +DEFINE_EVENT(mhi_process_event_ring, mhi_ctrl_event,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct
>> mhi_ring_element *rp), +
>> +	TP_ARGS(mhi_cntrl, rp)
>> +);
>> +
>> +DECLARE_EVENT_CLASS(mhi_update_channel_state,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan
>> *mhi_chan, int state), +
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
>> +		  TO_CH_STATE_TYPE_STR(__entry->state))
>> +);
>> +
>> +DEFINE_EVENT(mhi_update_channel_state, mhi_channel_command_start,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan
>> *mhi_chan, int state), +
>> +	TP_ARGS(mhi_cntrl, mhi_chan, state)
>> +);
>> +
>> +DEFINE_EVENT(mhi_update_channel_state, mhi_channel_command_end,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan
>> *mhi_chan, int state), +
>> +	TP_ARGS(mhi_cntrl, mhi_chan, state)
>> +);
>> +
>> +TRACE_EVENT(mhi_pm_st_transition,
>> +
>> +	TP_PROTO(struct mhi_controller *mhi_cntrl, int state),
>> +
>> +	TP_ARGS(mhi_cntrl, state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, mhi_cntrl->mhi_dev->name)
>> +		__field(int, state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
>> +		__entry->state = state;
>> +	),
>> +
>> +	TP_printk("%s: Handling state transition: %s\n", __get_str(name),
>> +		  TO_DEV_STATE_TRANS_STR(__entry->state))
>> +);
>> +
>> +#endif
>> +#undef TRACE_INCLUDE_PATH
>> +#define TRACE_INCLUDE_PATH ../../drivers/bus/mhi/host
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

