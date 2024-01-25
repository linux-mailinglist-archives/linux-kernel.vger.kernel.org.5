Return-Path: <linux-kernel+bounces-37873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4858E83B6DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A49B23B15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD04C612B;
	Thu, 25 Jan 2024 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ly4YdVhM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA2ECC;
	Thu, 25 Jan 2024 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147558; cv=none; b=ur33O4J7U/UCsDw6EkOzIYsL1qMytvDMe5wMglFIt+q9NYGHyXnWMvUw7KlEOZ4JiWXHlBMzu096Aq5VOjdCSu3QofzJ9bk8+rrNR/J4A4xTMZh/TBenD0bNUOdy3MJLMqtJsr8UzYy7/j18XGV6nKJQc2H138PPGf+PWgSxXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147558; c=relaxed/simple;
	bh=NCrXgo8X6xjF3SlYzP7XiFatP2p7TKGauBeFFN4Jrwk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=SiWwo8HPLoWzYMkwO3lVk4M8aSJpkZoSK1dX5xmTsHwZsGb5sXIfG6MI5IRviNInWPxvXCmd6FfjMFOD8hN1wwIU0rE9Gky9rIiP6qHR7CX0MdGmdhRrdOcWEMepsLqqVwspgVjF3WCXtRFG8CmfINusyBwOeWuaNINBwSx4RTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ly4YdVhM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P1mlQ7010829;
	Thu, 25 Jan 2024 01:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XF6nw0Fn8G72bTeRYYBW3pL3r4h0asY8dxKLJZc4cfc=; b=Ly
	4YdVhMhKSEXfGXfdadkyohiE+XslZgdcdHqliqe5YE7zC2BfkAeIr7b9rIeBAZW1
	e/NXED+gobEK3UhWqdKUqv2DL55aFEybl2lAtXEbhhds5/wS2d9xtfqHnlVtLx8E
	eYEP66oHDkasddmzGELiE9dYAfVE4POLaX8rXH/UriAsdX56BQUomUzQJxcdYXHZ
	0DzX8Uos6YNfjw68YTkQnL4nkaoPysYA7HbtLGLNnVLMlErXXSG5VkEb4DkDKJrj
	ofT8cva7MMLRB+snKjFuEVyQ/sgiVgymQRO7JuIEbaocOLd1BCgTrlY6Gcc2+DzU
	SNSVpp5YBY9QV7U/VL7Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtyxyt22h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 01:52:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P1qTqR001931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 01:52:29 GMT
Received: from [10.216.3.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 17:52:25 -0800
Message-ID: <a5f8c98c-81d3-6845-83af-ffb893d252a6@quicinc.com>
Date: Thu, 25 Jan 2024 07:22:21 +0530
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
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Steven Rostedt
	<rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20240105-ftrace_support-v9-1-a2dca64cc6ea@quicinc.com>
 <bd98da3f-17c2-e4c7-cb7c-b76090cab06b@quicinc.com>
In-Reply-To: <bd98da3f-17c2-e4c7-cb7c-b76090cab06b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5lTPb2l0YEQUEh-DymGihlsxPOIufJdx
X-Proofpoint-GUID: 5lTPb2l0YEQUEh-DymGihlsxPOIufJdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250012



On 1/8/2024 6:52 PM, Krishna Chaitanya Chundru wrote:
> Hi Steven,
> 
> Even though I added your reviewed-by tag, I incorporated changes 
> mentioned in the previous patch.
> 
> Can you please review it once.
> 
> Thanks & Regards,
> 
> Krishna Chaitanya.
> 
Hi Steven,

Can you please review it once.

Thanks & Regards,
Krishna Chaitanya.

> On 1/5/2024 5:53 PM, Krishna chaitanya chundru wrote:
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
>> Reviewed-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>> ---
>> Changes in v9:
>> - Change the implementations of some array so that the strings to enum 
>> mapping
>> - is same in both trace header and other files as suggested by steve.
>> - Link to v8: 
>> https://lore.kernel.org/r/20231207-ftrace_support-v8-1-7f62d4558555@quicinc.com 
>>
>>
>> Changes in v8:
>> - Pass the structure and derefernce the variables in TP_fast_assign as 
>> suggested by steve
>> - Link to v7: 
>> https://lore.kernel.org/r/20231206-ftrace_support-v7-1-aca49a04268b@quicinc.com 
>>
>>
>> Changes in v7:
>> - change log format as pointed by mani.
>> - Link to v6: 
>> https://lore.kernel.org/r/20231204-ftrace_support-v6-1-9b206546dac2@quicinc.com 
>>
>>
>> Changes in v6:
>> - use 'rp' directly as suggested by jeffrey.
>> - Link to v5: 
>> https://lore.kernel.org/r/20231127-ftrace_support-v5-1-eb67daead4f1@quicinc.com 
>>
>>
>> Changes in v5:
>> - Use DECLARE_EVENT_CLASS for multiple events as suggested by steve.
>> - Instead of converting to u64 to print address, use %px to print the 
>> address to avoid
>> - warnings in some platforms.
>> - Link to v4: 
>> https://lore.kernel.org/r/20231111-ftrace_support-v4-1-c83602399461@quicinc.com 
>>
>>
>> Changes in v4:
>> - Fix compilation issues in previous patch which happended due to 
>> rebasing.
>> - In the defconfig FTRACE config is not enabled due to that the 
>> compilation issue is not
>> - seen in my workspace.
>> - Link to v3: 
>> https://lore.kernel.org/r/20231111-ftrace_support-v3-1-f358d2911a74@quicinc.com 
>>
>>
>> Changes in v3:
>> - move trace header file from include/trace/events to 
>> drivers/bus/mhi/host/ so that
>> - we can include driver header files.
>> - Use macros directly in the trace events as suggested Jeffrey Hugo.
>> - Reorder the structure in the events as suggested by steve to avoid 
>> holes in the buffer.
>> - removed the mhi_to_physical function as this can give security issues.
>> - removed macros to define strings as we can get those from driver 
>> headers.
>> - Link to v2: 
>> https://lore.kernel.org/r/20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com 
>>
>>
>> Changes in v2:
>> - Passing the raw state into the trace event and using  
>> __print_symbolic() as suggested by bjorn.
>> - Change mhi_pm_st_worker to mhi_pm_st_transition as suggested by bjorn.
>> - Fixed the kernel test rebot issues.
>> - Link to v1: 
>> https://lore.kernel.org/r/20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com 
>>
>> ---
>>   drivers/bus/mhi/common.h        |  38 +++---
>>   drivers/bus/mhi/host/init.c     |  63 +++++----
>>   drivers/bus/mhi/host/internal.h |  40 ++++++
>>   drivers/bus/mhi/host/main.c     |  19 ++-
>>   drivers/bus/mhi/host/pm.c       |   7 +-
>>   drivers/bus/mhi/host/trace.h    | 275 
>> ++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 378 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>> index f794b9c8049e..dda340aaed95 100644
>> --- a/drivers/bus/mhi/common.h
>> +++ b/drivers/bus/mhi/common.h
>> @@ -297,30 +297,30 @@ struct mhi_ring_element {
>>       __le32 dword[2];
>>   };
>> +#define MHI_STATE_LIST                \
>> +    mhi_state(RESET,    "RESET")    \
>> +    mhi_state(READY,    "READY")    \
>> +    mhi_state(M0,        "M0")        \
>> +    mhi_state(M1,        "M1")        \
>> +    mhi_state(M2,        "M2")        \
>> +    mhi_state(M3,        "M3")        \
>> +    mhi_state(M3_FAST,    "M3_FAST")    \
>> +    mhi_state(BHI,        "BHI")        \
>> +    mhi_state_end(SYS_ERR,    "SYS ERROR")
>> +
>> +#undef mhi_state
>> +#undef mhi_state_end
>> +
>> +#define mhi_state(a, b)        case MHI_STATE_##a: return b;
>> +#define mhi_state_end(a, b)    case MHI_STATE_##a: return b;
>> +
>>   static inline const char *mhi_state_str(enum mhi_state state)
>>   {
>>       switch (state) {
>> -    case MHI_STATE_RESET:
>> -        return "RESET";
>> -    case MHI_STATE_READY:
>> -        return "READY";
>> -    case MHI_STATE_M0:
>> -        return "M0";
>> -    case MHI_STATE_M1:
>> -        return "M1";
>> -    case MHI_STATE_M2:
>> -        return "M2";
>> -    case MHI_STATE_M3:
>> -        return "M3";
>> -    case MHI_STATE_M3_FAST:
>> -        return "M3 FAST";
>> -    case MHI_STATE_BHI:
>> -        return "BHI";
>> -    case MHI_STATE_SYS_ERR:
>> -        return "SYS ERROR";
>> +    MHI_STATE_LIST
>>       default:
>>           return "Unknown state";
>>       }
>> -};
>> +}
>>   #endif /* _MHI_COMMON_H */
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index f78aefd2d7a3..c28bc02872fe 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -20,50 +20,49 @@
>>   #include <linux/wait.h>
>>   #include "internal.h"
>> +#define CREATE_TRACE_POINTS
>> +#include "trace.h"
>> +
>>   static DEFINE_IDA(mhi_controller_ida);
>> +#undef mhi_ee
>> +#undef mhi_ee_end
>> +
>> +#define mhi_ee(a, b)        [MHI_EE_##a] = b,
>> +#define mhi_ee_end(a, b)    [MHI_EE_##a] = b,
>> +
>>   const char * const mhi_ee_str[MHI_EE_MAX] = {
>> -    [MHI_EE_PBL] = "PRIMARY BOOTLOADER",
>> -    [MHI_EE_SBL] = "SECONDARY BOOTLOADER",
>> -    [MHI_EE_AMSS] = "MISSION MODE",
>> -    [MHI_EE_RDDM] = "RAMDUMP DOWNLOAD MODE",
>> -    [MHI_EE_WFW] = "WLAN FIRMWARE",
>> -    [MHI_EE_PTHRU] = "PASS THROUGH",
>> -    [MHI_EE_EDL] = "EMERGENCY DOWNLOAD",
>> -    [MHI_EE_FP] = "FLASH PROGRAMMER",
>> -    [MHI_EE_DISABLE_TRANSITION] = "DISABLE",
>> -    [MHI_EE_NOT_SUPPORTED] = "NOT SUPPORTED",
>> +    MHI_EE_LIST
>>   };
>> +#undef dev_st_trans
>> +#undef dev_st_trans_end
>> +
>> +#define dev_st_trans(a, b)    [DEV_ST_TRANSITION_##a] = b,
>> +#define dev_st_trans_end(a, b)    [DEV_ST_TRANSITION_##a] = b,
>> +
>>   const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
>> -    [DEV_ST_TRANSITION_PBL] = "PBL",
>> -    [DEV_ST_TRANSITION_READY] = "READY",
>> -    [DEV_ST_TRANSITION_SBL] = "SBL",
>> -    [DEV_ST_TRANSITION_MISSION_MODE] = "MISSION MODE",
>> -    [DEV_ST_TRANSITION_FP] = "FLASH PROGRAMMER",
>> -    [DEV_ST_TRANSITION_SYS_ERR] = "SYS ERROR",
>> -    [DEV_ST_TRANSITION_DISABLE] = "DISABLE",
>> +    DEV_ST_TRANSITION_LIST
>>   };
>> +#undef ch_state_type
>> +#undef ch_state_type_end
>> +
>> +#define ch_state_type(a, b)    [MHI_CH_STATE_TYPE_##a] = b,
>> +#define ch_state_type_end(a, b)    [MHI_CH_STATE_TYPE_##a] = b,
>> +
>>   const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
>> -    [MHI_CH_STATE_TYPE_RESET] = "RESET",
>> -    [MHI_CH_STATE_TYPE_STOP] = "STOP",
>> -    [MHI_CH_STATE_TYPE_START] = "START",
>> +    MHI_CH_STATE_TYPE_LIST
>>   };
>> +#undef mhi_pm_state
>> +#undef mhi_pm_state_end
>> +
>> +#define mhi_pm_state(a, b)    [MHI_PM_STATE_##a] = b,
>> +#define mhi_pm_state_end(a, b)    [MHI_PM_STATE_##a] = b,
>> +
>>   static const char * const mhi_pm_state_str[] = {
>> -    [MHI_PM_STATE_DISABLE] = "DISABLE",
>> -    [MHI_PM_STATE_POR] = "POWER ON RESET",
>> -    [MHI_PM_STATE_M0] = "M0",
>> -    [MHI_PM_STATE_M2] = "M2",
>> -    [MHI_PM_STATE_M3_ENTER] = "M?->M3",
>> -    [MHI_PM_STATE_M3] = "M3",
>> -    [MHI_PM_STATE_M3_EXIT] = "M3->M0",
>> -    [MHI_PM_STATE_FW_DL_ERR] = "Firmware Download Error",
>> -    [MHI_PM_STATE_SYS_ERR_DETECT] = "SYS ERROR Detect",
>> -    [MHI_PM_STATE_SYS_ERR_PROCESS] = "SYS ERROR Process",
>> -    [MHI_PM_STATE_SHUTDOWN_PROCESS] = "SHUTDOWN Process",
>> -    [MHI_PM_STATE_LD_ERR_FATAL_DETECT] = "Linkdown or Error Fatal 
>> Detect",
>> +    MHI_PM_STATE_LIST
>>   };
>>   const char *to_mhi_pm_state_str(u32 state)
>> diff --git a/drivers/bus/mhi/host/internal.h 
>> b/drivers/bus/mhi/host/internal.h
>> index 2e139e76de4c..9a2f2ca2be7c 100644
>> --- a/drivers/bus/mhi/host/internal.h
>> +++ b/drivers/bus/mhi/host/internal.h
>> @@ -42,6 +42,11 @@ enum mhi_ch_state_type {
>>       MHI_CH_STATE_TYPE_MAX,
>>   };
>> +#define MHI_CH_STATE_TYPE_LIST                \
>> +    ch_state_type(RESET,        "RESET")    \
>> +    ch_state_type(STOP,        "STOP")        \
>> +    ch_state_type_end(START,    "START")
>> +
>>   extern const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX];
>>   #define TO_CH_STATE_TYPE_STR(state) (((state) >= 
>> MHI_CH_STATE_TYPE_MAX) ? \
>>                        "INVALID_STATE" : \
>> @@ -50,6 +55,18 @@ extern const char * const 
>> mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX];
>>   #define MHI_INVALID_BRSTMODE(mode) (mode != MHI_DB_BRST_DISABLE && \
>>                       mode != MHI_DB_BRST_ENABLE)
>> +#define MHI_EE_LIST                        \
>> +    mhi_ee(PBL,            "PRIMARY BOOTLOADER")    \
>> +    mhi_ee(SBL,            "SECONDARY BOOTLOADER")    \
>> +    mhi_ee(AMSS,            "MISSION MODE")        \
>> +    mhi_ee(RDDM,            "RAMDUMP DOWNLOAD MODE")\
>> +    mhi_ee(WFW,            "WLAN FIRMWARE")    \
>> +    mhi_ee(PTHRU,            "PASS THROUGH")        \
>> +    mhi_ee(EDL,            "EMERGENCY DOWNLOAD")    \
>> +    mhi_ee(FP,            "FLASH PROGRAMMER")    \
>> +    mhi_ee(DISABLE_TRANSITION,    "DISABLE")        \
>> +    mhi_ee_end(NOT_SUPPORTED,    "NOT SUPPORTED")
>> +
>>   extern const char * const mhi_ee_str[MHI_EE_MAX];
>>   #define TO_MHI_EXEC_STR(ee) (((ee) >= MHI_EE_MAX) ? \
>>                    "INVALID_EE" : mhi_ee_str[ee])
>> @@ -72,6 +89,15 @@ enum dev_st_transition {
>>       DEV_ST_TRANSITION_MAX,
>>   };
>> +#define DEV_ST_TRANSITION_LIST                    \
>> +    dev_st_trans(PBL,        "PBL")            \
>> +    dev_st_trans(READY,        "READY")        \
>> +    dev_st_trans(SBL,        "SBL")            \
>> +    dev_st_trans(MISSION_MODE,    "MISSION MODE")        \
>> +    dev_st_trans(FP,        "FLASH PROGRAMMER")    \
>> +    dev_st_trans(SYS_ERR,        "SYS ERROR")        \
>> +    dev_st_trans_end(DISABLE,    "DISABLE")
>> +
>>   extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
>>   #define TO_DEV_STATE_TRANS_STR(state) (((state) >= 
>> DEV_ST_TRANSITION_MAX) ? \
>>                   "INVALID_STATE" : dev_state_tran_str[state])
>> @@ -93,6 +119,20 @@ enum mhi_pm_state {
>>       MHI_PM_STATE_MAX
>>   };
>> +#define MHI_PM_STATE_LIST                            \
>> +    mhi_pm_state(DISABLE,            "DISABLE")            \
>> +    mhi_pm_state(POR,            "POWER ON RESET")        \
>> +    mhi_pm_state(M0,            "M0")                \
>> +    mhi_pm_state(M2,            "M2")                \
>> +    mhi_pm_state(M3_ENTER,            "M?->M3")            \
>> +    mhi_pm_state(M3,            "M3")                \
>> +    mhi_pm_state(M3_EXIT,            "M3->M0")            \
>> +    mhi_pm_state(FW_DL_ERR,            "Firmware Download Error")    \
>> +    mhi_pm_state(SYS_ERR_DETECT,        "SYS ERROR Detect")        \
>> +    mhi_pm_state(SYS_ERR_PROCESS,        "SYS ERROR Process")        \
>> +    mhi_pm_state(SHUTDOWN_PROCESS,        "SHUTDOWN Process")        \
>> +    mhi_pm_state_end(LD_ERR_FATAL_DETECT,    "Linkdown or Error Fatal 
>> Detect")
>> +
>>   #define MHI_PM_DISABLE                    BIT(0)
>>   #define MHI_PM_POR                    BIT(1)
>>   #define MHI_PM_M0                    BIT(2)
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index dcf627b36e82..189f4786403e 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/skbuff.h>
>>   #include <linux/slab.h>
>>   #include "internal.h"
>> +#include "trace.h"
>>   int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
>>                     void __iomem *base, u32 offset, u32 *out)
>> @@ -491,11 +492,8 @@ irqreturn_t mhi_intvec_threaded_handler(int 
>> irq_number, void *priv)
>>       state = mhi_get_mhi_state(mhi_cntrl);
>>       ee = mhi_get_exec_env(mhi_cntrl);
>> -    dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
>> -        TO_MHI_EXEC_STR(mhi_cntrl->ee),
>> -        mhi_state_str(mhi_cntrl->dev_state),
>> -        TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>> +    trace_mhi_intvec_states(mhi_cntrl, ee, state);
>>       if (state == MHI_STATE_SYS_ERR) {
>>           dev_dbg(dev, "System error detected\n");
>>           pm_state = mhi_tryset_pm_state(mhi_cntrl,
>> @@ -832,6 +830,8 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller 
>> *mhi_cntrl,
>>       while (dev_rp != local_rp) {
>>           enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>> +        trace_mhi_ctrl_event(mhi_cntrl, local_rp);
>> +
>>           switch (type) {
>>           case MHI_PKT_TYPE_BW_REQ_EVENT:
>>           {
>> @@ -997,6 +997,8 @@ int mhi_process_data_event_ring(struct 
>> mhi_controller *mhi_cntrl,
>>       while (dev_rp != local_rp && event_quota > 0) {
>>           enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>> +        trace_mhi_data_event(mhi_cntrl, local_rp);
>> +
>>           chan = MHI_TRE_GET_EV_CHID(local_rp);
>>           WARN_ON(chan >= mhi_cntrl->max_chan);
>> @@ -1235,6 +1237,7 @@ int mhi_gen_tre(struct mhi_controller 
>> *mhi_cntrl, struct mhi_chan *mhi_chan,
>>       mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
>>       mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
>> +    trace_mhi_gen_tre(mhi_cntrl, mhi_chan, mhi_tre);
>>       /* increment WP */
>>       mhi_add_ring_element(mhi_cntrl, tre_ring);
>>       mhi_add_ring_element(mhi_cntrl, buf_ring);
>> @@ -1327,9 +1330,7 @@ static int mhi_update_channel_state(struct 
>> mhi_controller *mhi_cntrl,
>>       enum mhi_cmd_type cmd = MHI_CMD_NOP;
>>       int ret;
>> -    dev_dbg(dev, "%d: Updating channel state to: %s\n", mhi_chan->chan,
>> -        TO_CH_STATE_TYPE_STR(to_state));
>> -
>> +    trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state);
>>       switch (to_state) {
>>       case MHI_CH_STATE_TYPE_RESET:
>>           write_lock_irq(&mhi_chan->lock);
>> @@ -1396,9 +1397,7 @@ static int mhi_update_channel_state(struct 
>> mhi_controller *mhi_cntrl,
>>           write_unlock_irq(&mhi_chan->lock);
>>       }
>> -    dev_dbg(dev, "%d: Channel state change to %s successful\n",
>> -        mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
>> -
>> +    trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state);
>>   exit_channel_update:
>>       mhi_cntrl->runtime_put(mhi_cntrl);
>>       mhi_device_put(mhi_cntrl->mhi_dev);
>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>> index 8a4362d75fc4..5a2394b5b2e1 100644
>> --- a/drivers/bus/mhi/host/pm.c
>> +++ b/drivers/bus/mhi/host/pm.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/wait.h>
>>   #include "internal.h"
>> +#include "trace.h"
>>   /*
>>    * Not all MHI state transitions are synchronous. Transitions like 
>> Linkdown,
>> @@ -123,6 +124,7 @@ enum mhi_pm_state __must_check 
>> mhi_tryset_pm_state(struct mhi_controller *mhi_cn
>>       if (unlikely(!(dev_state_transitions[index].to_states & state)))
>>           return cur_state;
>> +    trace_mhi_tryset_pm_state(mhi_cntrl, state);
>>       mhi_cntrl->pm_state = state;
>>       return mhi_cntrl->pm_state;
>>   }
>> @@ -753,7 +755,6 @@ void mhi_pm_st_worker(struct work_struct *work)
>>       struct mhi_controller *mhi_cntrl = container_of(work,
>>                               struct mhi_controller,
>>                               st_worker);
>> -    struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>       spin_lock_irq(&mhi_cntrl->transition_lock);
>>       list_splice_tail_init(&mhi_cntrl->transition_list, &head);
>> @@ -761,8 +762,8 @@ void mhi_pm_st_worker(struct work_struct *work)
>>       list_for_each_entry_safe(itr, tmp, &head, node) {
>>           list_del(&itr->node);
>> -        dev_dbg(dev, "Handling state transition: %s\n",
>> -            TO_DEV_STATE_TRANS_STR(itr->state));
>> +
>> +        trace_mhi_pm_st_transition(mhi_cntrl, itr->state);
>>           switch (itr->state) {
>>           case DEV_ST_TRANSITION_PBL:
>> diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
>> new file mode 100644
>> index 000000000000..c74be0949178
>> --- /dev/null
>> +++ b/drivers/bus/mhi/host/trace.h
>> @@ -0,0 +1,275 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM mhi_host
>> +
>> +#if !defined(_TRACE_EVENT_MHI_HOST_H) || 
>> defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_EVENT_MHI_HOST_H
>> +
>> +#include <linux/tracepoint.h>
>> +#include <linux/trace_seq.h>
>> +#include "../common.h"
>> +#include "internal.h"
>> +
>> +#undef mhi_state
>> +#undef mhi_state_end
>> +
>> +#define mhi_state(a, b)        TRACE_DEFINE_ENUM(MHI_STATE_##a);
>> +#define mhi_state_end(a, b)    TRACE_DEFINE_ENUM(MHI_STATE_##a);
>> +
>> +MHI_STATE_LIST
>> +
>> +#undef mhi_state
>> +#undef mhi_state_end
>> +
>> +#define mhi_state(a, b)        { MHI_STATE_##a, b },
>> +#define mhi_state_end(a, b)    { MHI_STATE_##a, b }
>> +
>> +#undef mhi_pm_state
>> +#undef mhi_pm_state_end
>> +
>> +#define mhi_pm_state(a, b)        TRACE_DEFINE_ENUM(MHI_PM_STATE_##a);
>> +#define mhi_pm_state_end(a, b)        
>> TRACE_DEFINE_ENUM(MHI_PM_STATE_##a);
>> +
>> +MHI_PM_STATE_LIST
>> +
>> +#undef mhi_pm_state
>> +#undef mhi_pm_state_end
>> +
>> +#define mhi_pm_state(a, b)        { MHI_PM_STATE_##a, b },
>> +#define mhi_pm_state_end(a, b)        { MHI_PM_STATE_##a, b }
>> +
>> +#undef mhi_ee
>> +#undef mhi_ee_end
>> +
>> +#define mhi_ee(a, b)            TRACE_DEFINE_ENUM(MHI_EE_##a);
>> +#define mhi_ee_end(a, b)        TRACE_DEFINE_ENUM(MHI_EE_##a);
>> +
>> +MHI_EE_LIST
>> +
>> +#undef mhi_ee
>> +#undef mhi_ee_end
>> +
>> +#define mhi_ee(a, b)            { MHI_EE_##a, b },
>> +#define mhi_ee_end(a, b)        { MHI_EE_##a, b }
>> +
>> +#undef ch_state_type
>> +#undef ch_state_type_end
>> +
>> +#define ch_state_type(a, b)        
>> TRACE_DEFINE_ENUM(MHI_CH_STATE_TYPE_##a);
>> +#define ch_state_type_end(a, b)        
>> TRACE_DEFINE_ENUM(MHI_CH_STATE_TYPE_##a);
>> +
>> +MHI_CH_STATE_TYPE_LIST
>> +
>> +#undef ch_state_type
>> +#undef ch_state_type_end
>> +
>> +#define ch_state_type(a, b)        { MHI_CH_STATE_TYPE_##a, b },
>> +#define ch_state_type_end(a, b)        { MHI_CH_STATE_TYPE_##a, b }
>> +
>> +#undef dev_st_trans
>> +#undef dev_st_trans_end
>> +
>> +#define dev_st_trans(a, b)        
>> TRACE_DEFINE_ENUM(DEV_ST_TRANSITION_##a);
>> +#define dev_st_trans_end(a, b)        
>> TRACE_DEFINE_ENUM(DEV_ST_TRANSITION_##a);
>> +
>> +DEV_ST_TRANSITION_LIST
>> +
>> +#undef dev_st_trans
>> +#undef dev_st_trans_end
>> +
>> +#define dev_st_trans(a, b)        { DEV_ST_TRANSITION_##a, b },
>> +#define dev_st_trans_end(a, b)        { DEV_ST_TRANSITION_##a, b }
>> +
>> +TRACE_EVENT(mhi_gen_tre,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan 
>> *mhi_chan,
>> +         struct mhi_ring_element *mhi_tre),
>> +
>> +    TP_ARGS(mhi_cntrl, mhi_chan, mhi_tre),
>> +
>> +    TP_STRUCT__entry(
>> +        __string(name, mhi_cntrl->mhi_dev->name)
>> +        __field(int, ch_num)
>> +        __field(void *, wp)
>> +        __field(__le64, tre_ptr)
>> +        __field(__le32, dword0)
>> +        __field(__le32, dword1)
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        __assign_str(name, mhi_cntrl->mhi_dev->name);
>> +        __entry->ch_num = mhi_chan->chan;
>> +        __entry->wp = mhi_tre;
>> +        __entry->tre_ptr = mhi_tre->ptr;
>> +        __entry->dword0 = mhi_tre->dword[0];
>> +        __entry->dword1 = mhi_tre->dword[1];
>> +    ),
>> +
>> +    TP_printk("%s: Chan: %d Tre: 0x%p Tre buf: 0x%llx dword0: 0x%08x 
>> dword1: 0x%08x\n",
>> +          __get_str(name), __entry->ch_num, __entry->wp, 
>> __entry->tre_ptr,
>> +          __entry->dword0, __entry->dword1)
>> +);
>> +
>> +TRACE_EVENT(mhi_intvec_states,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, int dev_ee, int 
>> dev_state),
>> +
>> +    TP_ARGS(mhi_cntrl, dev_ee, dev_state),
>> +
>> +    TP_STRUCT__entry(
>> +        __string(name, mhi_cntrl->mhi_dev->name)
>> +        __field(int, local_ee)
>> +        __field(int, state)
>> +        __field(int, dev_ee)
>> +        __field(int, dev_state)
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        __assign_str(name, mhi_cntrl->mhi_dev->name);
>> +        __entry->local_ee = mhi_cntrl->ee;
>> +        __entry->state = mhi_cntrl->dev_state;
>> +        __entry->dev_ee = dev_ee;
>> +        __entry->dev_state = dev_state;
>> +    ),
>> +
>> +    TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",
>> +          __get_str(name),
>> +          __print_symbolic(__entry->local_ee, MHI_EE_LIST),
>> +          __print_symbolic(__entry->state, MHI_STATE_LIST),
>> +          __print_symbolic(__entry->dev_ee, MHI_EE_LIST),
>> +          __print_symbolic(__entry->state, MHI_STATE_LIST))
>> +);
>> +
>> +TRACE_EVENT(mhi_tryset_pm_state,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, int pm_state),
>> +
>> +    TP_ARGS(mhi_cntrl, pm_state),
>> +
>> +    TP_STRUCT__entry(
>> +        __string(name, mhi_cntrl->mhi_dev->name)
>> +        __field(int, pm_state)
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        __assign_str(name, mhi_cntrl->mhi_dev->name);
>> +        if (pm_state)
>> +            pm_state = __fls(pm_state);
>> +        __entry->pm_state = pm_state;
>> +    ),
>> +
>> +    TP_printk("%s: PM state: %s\n", __get_str(name),
>> +          __print_symbolic(__entry->pm_state, MHI_PM_STATE_LIST))
>> +);
>> +
>> +DECLARE_EVENT_CLASS(mhi_process_event_ring,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, struct 
>> mhi_ring_element *rp),
>> +
>> +    TP_ARGS(mhi_cntrl, rp),
>> +
>> +    TP_STRUCT__entry(
>> +        __string(name, mhi_cntrl->mhi_dev->name)
>> +        __field(__le32, dword0)
>> +        __field(__le32, dword1)
>> +        __field(int, state)
>> +        __field(__le64, ptr)
>> +        __field(void *, rp)
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        __assign_str(name, mhi_cntrl->mhi_dev->name);
>> +        __entry->rp = rp;
>> +        __entry->ptr = rp->ptr;
>> +        __entry->dword0 = rp->dword[0];
>> +        __entry->dword1 = rp->dword[1];
>> +        __entry->state = MHI_TRE_GET_EV_STATE(rp);
>> +    ),
>> +
>> +    TP_printk("%s: Tre: 0x%p Tre buf: 0x%llx dword0: 0x%08x dword1: 
>> 0x%08x state: %s\n",
>> +          __get_str(name), __entry->rp, __entry->ptr, __entry->dword0,
>> +          __entry->dword1, __print_symbolic(__entry->state, 
>> MHI_STATE_LIST))
>> +);
>> +
>> +DEFINE_EVENT(mhi_process_event_ring, mhi_data_event,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, struct 
>> mhi_ring_element *rp),
>> +
>> +    TP_ARGS(mhi_cntrl, rp)
>> +);
>> +
>> +DEFINE_EVENT(mhi_process_event_ring, mhi_ctrl_event,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, struct 
>> mhi_ring_element *rp),
>> +
>> +    TP_ARGS(mhi_cntrl, rp)
>> +);
>> +
>> +DECLARE_EVENT_CLASS(mhi_update_channel_state,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan 
>> *mhi_chan, int state),
>> +
>> +    TP_ARGS(mhi_cntrl, mhi_chan, state),
>> +
>> +    TP_STRUCT__entry(
>> +        __string(name, mhi_cntrl->mhi_dev->name)
>> +        __field(int, ch_num)
>> +        __field(int, state)
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        __assign_str(name, mhi_cntrl->mhi_dev->name);
>> +        __entry->ch_num = mhi_chan->chan;
>> +        __entry->state = state;
>> +    ),
>> +
>> +    TP_printk("%s: chan%d: Updating state to: %s\n",
>> +          __get_str(name), __entry->ch_num,
>> +          __print_symbolic(__entry->state, MHI_CH_STATE_TYPE_LIST))
>> +);
>> +
>> +DEFINE_EVENT(mhi_update_channel_state, mhi_channel_command_start,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan 
>> *mhi_chan, int state),
>> +
>> +    TP_ARGS(mhi_cntrl, mhi_chan, state)
>> +);
>> +
>> +DEFINE_EVENT(mhi_update_channel_state, mhi_channel_command_end,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan 
>> *mhi_chan, int state),
>> +
>> +    TP_ARGS(mhi_cntrl, mhi_chan, state)
>> +);
>> +
>> +TRACE_EVENT(mhi_pm_st_transition,
>> +
>> +    TP_PROTO(struct mhi_controller *mhi_cntrl, int state),
>> +
>> +    TP_ARGS(mhi_cntrl, state),
>> +
>> +    TP_STRUCT__entry(
>> +        __string(name, mhi_cntrl->mhi_dev->name)
>> +        __field(int, state)
>> +    ),
>> +
>> +    TP_fast_assign(
>> +        __assign_str(name, mhi_cntrl->mhi_dev->name);
>> +        __entry->state = state;
>> +    ),
>> +
>> +    TP_printk("%s: Handling state transition: %s\n", __get_str(name),
>> +          __print_symbolic(__entry->state, DEV_ST_TRANSITION_LIST))
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

