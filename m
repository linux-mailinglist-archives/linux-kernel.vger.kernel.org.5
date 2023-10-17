Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2E7CBE98
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjJQJJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJQJJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:09:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3222D10CA;
        Tue, 17 Oct 2023 02:09:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H7mUeA008676;
        Tue, 17 Oct 2023 09:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PVimyCO5k9k/ebomuq2s7w+2bBOqbDRmPdY9WCc3tZ8=;
 b=IqhW7wEaxCt/0jm4lbqP+eHsuG4ruunFo2Z6crPp5H3aS664mqKmzhJ2PX/eiD9YeCLm
 QWosPwREmcm44BKliXUiGz+7wKGtlVMabGJIrNo2zbG4OMni+dHBykiJX3X4DHfXj4H9
 LOn3e0bHOUHhi/JHQ+nSjxVt7mKyxIuUxusod5ecxlmNOzhzUfi4W7zskR7LH345gQKN
 6Vj4RIjCcX32+09eRRFj6Fd6+FzlxUxuo9OmhtmwIVTP/6NjYWziUwvzPrJDEBLw0hWD
 twxOhLvTG6UfTDQ0AjNhH85qz4AETgFLiOZCqdiKnBIeVpxXwpzoWFVwpejusFuWlP5b Jw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsc00sd38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 09:08:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H98jLR007335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 09:08:45 GMT
Received: from [10.218.41.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 02:08:40 -0700
Message-ID: <646dfd10-0270-462f-484c-50bcb5e9af64@quicinc.com>
Date:   Tue, 17 Oct 2023 14:38:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] bus: mhi: host: Add tracing support
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
References: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
 <20231016111357.74b991d4@gandalf.local.home>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231016111357.74b991d4@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5DYZJkPQNPjYlScJsfzH-GbAaBOCuDJE
X-Proofpoint-GUID: 5DYZJkPQNPjYlScJsfzH-GbAaBOCuDJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170075
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/2023 8:43 PM, Steven Rostedt wrote:
> On Fri, 13 Oct 2023 15:22:19 +0530
> Krishna chaitanya chundru <quic_krichai@quicinc.com> wrote:
>
>> +++ b/include/trace/events/mhi_host.h
>> @@ -0,0 +1,287 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM mhi_host
>> +
>> +#if !defined(_TRACE_EVENT_MHI_HOST_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_EVENT_MHI_HOST_H
>> +
>> +#include <linux/tracepoint.h>
>> +#define MHI_STATE						\
>> +	EM(MHI_STATE_RESET,	"RESET")			\
>> +	EM(MHI_STATE_READY,	"READY")			\
>> +	EM(MHI_STATE_M0,	"M0")				\
>> +	EM(MHI_STATE_M1,	"M1")				\
>> +	EM(MHI_STATE_M2,	"M2")				\
>> +	EM(MHI_STATE_M3,	"M3")				\
>> +	EM(MHI_STATE_M3_FAST,	"M3 FAST")			\
>> +	EM(MHI_STATE_BHI,	"BHI")				\
>> +	EMe(MHI_STATE_SYS_ERR,	"SYS ERROR")
>> +
>> +#define MHI_EE							\
>> +	EM(MHI_EE_PBL,		"PRIMARY BOOTLOADER")		\
>> +	EM(MHI_EE_SBL,		"SECONDARY BOOTLOADER")		\
>> +	EM(MHI_EE_AMSS,		"MISSION MODE")			\
>> +	EM(MHI_EE_RDDM,		"RAMDUMP DOWNLOAD MODE")	\
>> +	EM(MHI_EE_WFW,		"WLAN FIRMWARE")		\
>> +	EM(MHI_EE_PTHRU,	"PASS THROUGH")			\
>> +	EM(MHI_EE_EDL,		"EMERGENCY DOWNLOAD")		\
>> +	EM(MHI_EE_FP,		"FLASH PROGRAMMER")		\
>> +	EM(MHI_EE_DISABLE_TRANSITION,	"DISABLE")		\
>> +	EMe(MHI_EE_NOT_SUPPORTED,	"NOT SUPPORTED")
>> +
>> +#define MHI_PM_STATE							\
>> +	EM(MHI_PM_STATE_DISABLE,	"DISABLE")			\
>> +	EM(MHI_PM_STATE_POR,		"POWER ON RESET")		\
>> +	EM(MHI_PM_STATE_M0,		"M0")				\
>> +	EM(MHI_PM_STATE_M2,		"M2")				\
>> +	EM(MHI_PM_STATE_M3_ENTER,	"M?->M3")			\
>> +	EM(MHI_PM_STATE_M3,		"M3")				\
>> +	EM(MHI_PM_STATE_M3_EXIT,	"M3->M0")			\
>> +	EM(MHI_PM_STATE_FW_DL_ERR,	"Firmware Download Error")	\
>> +	EM(MHI_PM_STATE_SYS_ERR_DETECT,		"SYS ERROR Detect")	\
>> +	EM(MHI_PM_STATE_SYS_ERR_PROCESS,	"SYS ERROR Process")	\
>> +	EM(MHI_PM_STATE_SHUTDOWN_PROCESS,	"SHUTDOWN Process")	\
>> +	EMe(MHI_PM_STATE_LD_ERR_FATAL_DETECT,	"Linkdown or Error Fatal Detect")
>> +
>> +#define MHI_CH_STATE						\
>> +	EM(MHI_CH_STATE_TYPE_RESET, "RESET")			\
>> +	EM(MHI_CH_STATE_TYPE_STOP, "STOP")			\
>> +	EMe(MHI_CH_STATE_TYPE_START, "START")
>> +
>> +#define MHI_DEV_ST_TRANSITION						\
>> +	EM(DEV_ST_TRANSITION_PBL,	"PBL")				\
>> +	EM(DEV_ST_TRANSITION_READY,	"READY")			\
>> +	EM(DEV_ST_TRANSITION_SBL,	"SBL")				\
>> +	EM(DEV_ST_TRANSITION_MISSION_MODE,	"MISSION MODE")		\
>> +	EM(DEV_ST_TRANSITION_FP,		"FLASH PROGRAMMER")	\
>> +	EM(DEV_ST_TRANSITION_SYS_ERR,		"SYS ERROR")		\
>> +	EMe(DEV_ST_TRANSITION_DISABLE,		"DISABLE")
>> +
>> +/* Enums require being exported to userspace, for user tool parsing */
>> +#undef	EM
>> +#undef	EMe
>> +#define	EM(a, b)	TRACE_DEFINE_ENUM(a);
>> +#define	EMe(a, b)	TRACE_DEFINE_ENUM(a);
>> +
>> +MHI_STATE
>> +MHI_EE
>> +MHI_PM_STATE
>> +MHI_CH_STATE
>> +MHI_DEV_ST_TRANSITION
>> +
>> +/*
>> + * Now redefine the EM() and EMe() macros to map the enums to the strings
>> + * that will be printed in the output.
>> + */
>> +#undef EM
>> +#undef EMe
>> +#define EM(a, b)	{a, b},
>> +#define EMe(a, b)	{a, b}
>> +
>> +TRACE_EVENT(mhi_gen_tre,
>> +
>> +	TP_PROTO(const char *name, int ch_num, u64 wp, __le64 tre_ptr,
>> +		 __le32 dword0, __le32 dword1),
>> +
>> +	TP_ARGS(name, ch_num, wp, tre_ptr, dword0, dword1),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(int, ch_num)
> This is fine as __string() is four bytes in the event (2 bytes for offset
> where the string exists, and 2 bytes for its length).
>
>> +		__field(u64, wp)
>> +		__field(__le64, tre_ptr)
> Which makes the two 8 byte fields aligned. Good!
>
>> +		__field(__le32, dword0)
>> +		__field(__le32, dword1)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__entry->ch_num = ch_num;
>> +		__entry->wp = wp;
>> +		__entry->tre_ptr = tre_ptr;
>> +		__entry->dword0 = dword0;
>> +		__entry->dword1 = dword1;
>> +	),
>> +
>> +	TP_printk("%s: Chan: %d WP: 0x%llx TRE: 0x%llx 0x%08x 0x%08x\n",
>> +		  __get_str(name), __entry->ch_num, __entry->wp, __entry->tre_ptr,
>> +		  __entry->dword0, __entry->dword1)
>> +);
>> +
>> +TRACE_EVENT(mhi_intvec_threaded_handler,
>> +
>> +	TP_PROTO(const char *name, int local_ee, int state, int dev_ee, int dev_state),
>> +
>> +	TP_ARGS(name, local_ee, state, dev_ee, dev_state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(int, local_ee)
>> +		__field(int, state)
>> +		__field(int, dev_ee)
>> +		__field(int, dev_state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__entry->local_ee = local_ee;
>> +		__entry->state = state;
>> +		__entry->dev_ee = dev_ee;
>> +		__entry->dev_state = dev_state;
>> +	),
>> +
>> +	TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",
>> +		  __get_str(name),
>> +		  __print_symbolic(__entry->local_ee, MHI_EE),
>> +		  __print_symbolic(__entry->state, MHI_STATE),
>> +		  __print_symbolic(__entry->dev_ee, MHI_EE),
>> +		  __print_symbolic(__entry->dev_state, MHI_STATE))
>> +);
>> +
>> +TRACE_EVENT(mhi_tryset_pm_state,
>> +
>> +	TP_PROTO(const char *name, int pm_state),
>> +
>> +	TP_ARGS(name, pm_state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(int, pm_state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		if (pm_state)
>> +			pm_state = __fls(pm_state);
>> +		__entry->pm_state = pm_state;
>> +	),
>> +
>> +	TP_printk("%s: PM state: %s\n", __get_str(name),
>> +		  __print_symbolic(__entry->pm_state, MHI_PM_STATE))
>> +);
>> +
>> +TRACE_EVENT(mhi_process_data_event_ring,
>> +
>> +	TP_PROTO(const char *name, __le64 ptr, __le32 dword0, __le32 dword1),
>> +
>> +	TP_ARGS(name, ptr, dword0, dword1),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(__le64, ptr)
> Here, I would switch the __field(__le64, ptr) with the __string().
>
> 		__field(__le64, ptr)
> 		__string(name, name)
>
> otherwise you just created a 4 byte hole in the ring buffer, wasting
> precious ring buffer space.
>
>> +		__field(__le32, dword0)
>> +		__field(__le32, dword1)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__entry->ptr = ptr;
>> +		__entry->dword0 = dword0;
>> +		__entry->dword1 = dword1;
>> +	),
>> +
>> +	TP_printk("%s: Processing Event:0x%llx 0x%08x 0x%08x\n",
>> +		  __get_str(name), __entry->ptr, __entry->dword0, __entry->dword1)
>> +);
>> +
>> +TRACE_EVENT(mhi_process_ctrl_ev_ring,
>> +
>> +	TP_PROTO(const char *name, u64 rp, __le64 ptr, __le32 dword0, __le32 dword1, int state),
>> +
>> +	TP_ARGS(name, rp, ptr, dword0, dword1, state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(u64, rp)
>> +		__field(__le64, ptr)
> I would move __string(name, name) here (after the two 8 byte fields).
>
> -- Steve

I will reoder as suggested in my next patch.

-- KC.

>> +		__field(__le32, dword0)
>> +		__field(__le32, dword1)
>> +		__field(int, state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__entry->rp = rp;
>> +		__entry->ptr = ptr;
>> +		__entry->dword0 = dword0;
>> +		__entry->dword1 = dword1;
>> +		__entry->state = state;
>> +	),
>> +
>> +	TP_printk("%s: RP:0x%llx Processing Event:0x%llx 0x%08x 0x%08x state:%s\n",
>> +		  __get_str(name), __entry->rp, __entry->ptr, __entry->dword0,
>> +		  __entry->dword1, __print_symbolic(__entry->state, MHI_STATE))
>> +);
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
>> +		  __print_symbolic(__entry->state, MHI_CH_STATE))
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
>> +		  __print_symbolic(__entry->state, MHI_CH_STATE))
>> +);
>> +
>> +TRACE_EVENT(mhi_pm_st_transition,
>> +
>> +	TP_PROTO(const char *name, int state),
>> +
>> +	TP_ARGS(name, state),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(name, name)
>> +		__field(int, state)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(name, name);
>> +		__entry->state = state;
>> +	),
>> +
>> +	TP_printk("%s: Handling state transition: %s\n", __get_str(name),
>> +		  __print_symbolic(__entry->state, MHI_DEV_ST_TRANSITION))
>> +);
>> +
>> +#endif
>> +#include <trace/define_trace.h>
