Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57C17D1225
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377618AbjJTPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377597AbjJTPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:04:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92B2A3;
        Fri, 20 Oct 2023 08:04:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KEg8nl027360;
        Fri, 20 Oct 2023 15:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LVOiRTAO2Nv1tPeA5Iy/AyNMI1QMzz04uMmGlfwa2QY=;
 b=CRZImF/3d9Jx9QYV1pPbyHkVkHs+qkrsl1RcRHpQCh9Kap5QImn3m/rTqufIa4Wq3ca4
 xY+sJqvxnP0lAoqnm9vzrB3rSu8JE+wE3VRtluU+uIi6hrM05yttwsykdg4gc8WKt3IA
 uQIjoD4rU4GFxCUD7LnyCmDHc4rYeNWyKoXquQbBfTIF/xp/WknWeuKCxefht0dZKMUS
 oYriA7D5djoKfL8zS4DRsqb5yda7N8/gE0krQNRMra+TaQ8pt1KvSKmk4BpfDsSXrEiT
 h3aagDUO4FR7MtTx1xCOun176j9hLaujYDcAj5gOaT7fe6jScPuH09WKQ9MpqJTPuyS4 VQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwmtadv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:04:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39KF41fF013267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 15:04:01 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 08:04:00 -0700
Message-ID: <9216f694-cce0-2b95-df34-e5b60538644a@quicinc.com>
Date:   Fri, 20 Oct 2023 09:03:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] bus: mhi: host: Add tracing support
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
References: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kxSBs2dPN89r4c-gdyPNqqGf5uXDFOhN
X-Proofpoint-ORIG-GUID: kxSBs2dPN89r4c-gdyPNqqGf5uXDFOhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310200125
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2023 3:52 AM, Krishna chaitanya chundru wrote:
> This change adds ftrace support for following functions which
> helps in debugging the issues when there is Channel state & MHI
> state change and also when we receive data and control events:
> 1. mhi_intvec_threaded_handler
> 2. mhi_process_data_event_ring
> 3. mhi_process_ctrl_ev_ring
> 4. mhi_gen_tre
> 5. mhi_update_channel_state
> 6. mhi_tryset_pm_state
> 7. mhi_pm_st_worker
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
> Changes in v2:
> - Passing the raw state into the trace event and using  __print_symbolic() as suggested by bjorn.
> - Change mhi_pm_st_worker to mhi_pm_st_transition as suggested by bjorn.
> - Fixed the kernel test rebot issues.
> - Link to v1: https://lore.kernel.org/r/20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com
> ---
>   MAINTAINERS                     |   1 +
>   drivers/bus/mhi/host/init.c     |   3 +
>   drivers/bus/mhi/host/internal.h |   1 +
>   drivers/bus/mhi/host/main.c     |  32 +++--
>   drivers/bus/mhi/host/pm.c       |   6 +-
>   include/trace/events/mhi_host.h | 287 ++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 317 insertions(+), 13 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35977b269d5e..4339c668a6ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13862,6 +13862,7 @@ F:	Documentation/mhi/
>   F:	drivers/bus/mhi/
>   F:	drivers/pci/endpoint/functions/pci-epf-mhi.c
>   F:	include/linux/mhi.h
> +F:	include/trace/events/mhi_host.h
>   
>   MICROBLAZE ARCHITECTURE
>   M:	Michal Simek <monstr@monstr.eu>
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index f78aefd2d7a3..3afa90a204fd 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -20,6 +20,9 @@
>   #include <linux/wait.h>
>   #include "internal.h"
>   
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mhi_host.h>

This feels redundant to me.  A few lines ago we included internal.h, and 
internal.h includes trace/events/mhi_host.h

> +
>   static DEFINE_IDA(mhi_controller_ida);
>   
>   const char * const mhi_ee_str[MHI_EE_MAX] = {
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 2e139e76de4c..a80a317a59a9 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -7,6 +7,7 @@
>   #ifndef _MHI_INT_H
>   #define _MHI_INT_H
>   
> +#include <trace/events/mhi_host.h>
>   #include "../common.h"
>   
>   extern struct bus_type mhi_bus_type;
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index dcf627b36e82..fcdb728ba49f 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -246,6 +246,11 @@ static void *mhi_to_virtual(struct mhi_ring *ring, dma_addr_t addr)
>   	return (addr - ring->iommu_base) + ring->base;
>   }
>   
> +dma_addr_t mhi_to_physical(struct mhi_ring *ring, void *addr)
> +{
> +	return (addr - ring->base) + ring->iommu_base;
> +}

This seems to be poorly named since we are using the iommu_base which 
suggests we are converting to an IOVA.

Why do we need this though?  This seems like it might be a security 
issue, or at the very least, not preferred, and I'm struggling to figure 
out what value this provides to you are I when looking at the log.

> +
>   static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
>   				 struct mhi_ring *ring)
>   {
> @@ -491,11 +496,9 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>   
>   	state = mhi_get_mhi_state(mhi_cntrl);
>   	ee = mhi_get_exec_env(mhi_cntrl);
> -	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
> -		TO_MHI_EXEC_STR(mhi_cntrl->ee),
> -		mhi_state_str(mhi_cntrl->dev_state),
> -		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>   
> +	trace_mhi_intvec_threaded_handler(mhi_cntrl->mhi_dev->name, mhi_cntrl->ee,
> +					  mhi_cntrl->dev_state, ee, state);

Why are we removing the debug message when adding this trace?  The 
commit text doesn't say.  (Looks like you do this several times, assume 
this comment applies to all isntances)

>   	if (state == MHI_STATE_SYS_ERR) {
>   		dev_dbg(dev, "System error detected\n");
>   		pm_state = mhi_tryset_pm_state(mhi_cntrl,
> @@ -832,6 +835,12 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>   	while (dev_rp != local_rp) {
>   		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>   
> +		trace_mhi_process_ctrl_ev_ring(mhi_cntrl->mhi_dev->name,
> +					       mhi_to_physical(ev_ring, local_rp),
> +					       local_rp->ptr, local_rp->dword[0],
> +					       local_rp->dword[1],
> +					       MHI_TRE_GET_EV_STATE(local_rp));

Why not just pass in the local_rp as a single parameter and have the 
trace implementation decode it?  (Looks like you do this several times, 
assume this comment applies to all isntances)

> +
>   		switch (type) {
>   		case MHI_PKT_TYPE_BW_REQ_EVENT:
>   		{
> @@ -997,6 +1006,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>   	while (dev_rp != local_rp && event_quota > 0) {
>   		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>   
> +		trace_mhi_process_data_event_ring(mhi_cntrl->mhi_dev->name, local_rp->ptr,
> +						  local_rp->dword[0], local_rp->dword[1]);
> +
>   		chan = MHI_TRE_GET_EV_CHID(local_rp);
>   
>   		WARN_ON(chan >= mhi_cntrl->max_chan);
> @@ -1235,6 +1247,9 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>   	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
>   	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
>   
> +	trace_mhi_gen_tre(mhi_cntrl->mhi_dev->name, mhi_chan->chan,
> +			  mhi_to_physical(tre_ring, mhi_tre),
> +			  mhi_tre->ptr, mhi_tre->dword[0], mhi_tre->dword[1]);
>   	/* increment WP */
>   	mhi_add_ring_element(mhi_cntrl, tre_ring);
>   	mhi_add_ring_element(mhi_cntrl, buf_ring);
> @@ -1327,9 +1342,8 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>   	enum mhi_cmd_type cmd = MHI_CMD_NOP;
>   	int ret;
>   
> -	dev_dbg(dev, "%d: Updating channel state to: %s\n", mhi_chan->chan,
> -		TO_CH_STATE_TYPE_STR(to_state));
> -
> +	trace_mhi_update_channel_state_start(mhi_cntrl->mhi_dev->name, mhi_chan->chan,
> +					     to_state);
>   	switch (to_state) {
>   	case MHI_CH_STATE_TYPE_RESET:
>   		write_lock_irq(&mhi_chan->lock);
> @@ -1396,9 +1410,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>   		write_unlock_irq(&mhi_chan->lock);
>   	}
>   
> -	dev_dbg(dev, "%d: Channel state change to %s successful\n",
> -		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
> -
> +	trace_mhi_update_channel_state_end(mhi_cntrl->mhi_dev->name, mhi_chan->chan, to_state);
>   exit_channel_update:
>   	mhi_cntrl->runtime_put(mhi_cntrl);
>   	mhi_device_put(mhi_cntrl->mhi_dev);
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 8a4362d75fc4..e32afdc92fde 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -123,6 +123,7 @@ enum mhi_pm_state __must_check mhi_tryset_pm_state(struct mhi_controller *mhi_cn
>   	if (unlikely(!(dev_state_transitions[index].to_states & state)))
>   		return cur_state;
>   
> +	trace_mhi_tryset_pm_state(mhi_cntrl->mhi_dev->name, state);
>   	mhi_cntrl->pm_state = state;
>   	return mhi_cntrl->pm_state;
>   }
> @@ -753,7 +754,6 @@ void mhi_pm_st_worker(struct work_struct *work)
>   	struct mhi_controller *mhi_cntrl = container_of(work,
>   							struct mhi_controller,
>   							st_worker);
> -	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>   
>   	spin_lock_irq(&mhi_cntrl->transition_lock);
>   	list_splice_tail_init(&mhi_cntrl->transition_list, &head);
> @@ -761,8 +761,8 @@ void mhi_pm_st_worker(struct work_struct *work)
>   
>   	list_for_each_entry_safe(itr, tmp, &head, node) {
>   		list_del(&itr->node);
> -		dev_dbg(dev, "Handling state transition: %s\n",
> -			TO_DEV_STATE_TRANS_STR(itr->state));
> +
> +		trace_mhi_pm_st_transition(mhi_cntrl->mhi_dev->name, itr->state);
>   
>   		switch (itr->state) {
>   		case DEV_ST_TRANSITION_PBL:
> diff --git a/include/trace/events/mhi_host.h b/include/trace/events/mhi_host.h
> new file mode 100644
> index 000000000000..a496d99f8fad
> --- /dev/null
> +++ b/include/trace/events/mhi_host.h
> @@ -0,0 +1,287 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM mhi_host
> +
> +#if !defined(_TRACE_EVENT_MHI_HOST_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_EVENT_MHI_HOST_H
> +
> +#include <linux/tracepoint.h>
> +#define MHI_STATE						\
> +	EM(MHI_STATE_RESET,	"RESET")			\
> +	EM(MHI_STATE_READY,	"READY")			\
> +	EM(MHI_STATE_M0,	"M0")				\
> +	EM(MHI_STATE_M1,	"M1")				\
> +	EM(MHI_STATE_M2,	"M2")				\
> +	EM(MHI_STATE_M3,	"M3")				\
> +	EM(MHI_STATE_M3_FAST,	"M3 FAST")			\
> +	EM(MHI_STATE_BHI,	"BHI")				\
> +	EMe(MHI_STATE_SYS_ERR,	"SYS ERROR")
> +
> +#define MHI_EE							\
> +	EM(MHI_EE_PBL,		"PRIMARY BOOTLOADER")		\
> +	EM(MHI_EE_SBL,		"SECONDARY BOOTLOADER")		\
> +	EM(MHI_EE_AMSS,		"MISSION MODE")			\
> +	EM(MHI_EE_RDDM,		"RAMDUMP DOWNLOAD MODE")	\
> +	EM(MHI_EE_WFW,		"WLAN FIRMWARE")		\
> +	EM(MHI_EE_PTHRU,	"PASS THROUGH")			\
> +	EM(MHI_EE_EDL,		"EMERGENCY DOWNLOAD")		\
> +	EM(MHI_EE_FP,		"FLASH PROGRAMMER")		\
> +	EM(MHI_EE_DISABLE_TRANSITION,	"DISABLE")		\
> +	EMe(MHI_EE_NOT_SUPPORTED,	"NOT SUPPORTED")
> +
> +#define MHI_PM_STATE							\
> +	EM(MHI_PM_STATE_DISABLE,	"DISABLE")			\
> +	EM(MHI_PM_STATE_POR,		"POWER ON RESET")		\
> +	EM(MHI_PM_STATE_M0,		"M0")				\
> +	EM(MHI_PM_STATE_M2,		"M2")				\
> +	EM(MHI_PM_STATE_M3_ENTER,	"M?->M3")			\
> +	EM(MHI_PM_STATE_M3,		"M3")				\
> +	EM(MHI_PM_STATE_M3_EXIT,	"M3->M0")			\
> +	EM(MHI_PM_STATE_FW_DL_ERR,	"Firmware Download Error")	\
> +	EM(MHI_PM_STATE_SYS_ERR_DETECT,		"SYS ERROR Detect")	\
> +	EM(MHI_PM_STATE_SYS_ERR_PROCESS,	"SYS ERROR Process")	\
> +	EM(MHI_PM_STATE_SHUTDOWN_PROCESS,	"SHUTDOWN Process")	\
> +	EMe(MHI_PM_STATE_LD_ERR_FATAL_DETECT,	"Linkdown or Error Fatal Detect")
> +
> +#define MHI_CH_STATE						\
> +	EM(MHI_CH_STATE_TYPE_RESET, "RESET")			\
> +	EM(MHI_CH_STATE_TYPE_STOP, "STOP")			\
> +	EMe(MHI_CH_STATE_TYPE_START, "START")
> +
> +#define MHI_DEV_ST_TRANSITION						\
> +	EM(DEV_ST_TRANSITION_PBL,	"PBL")				\
> +	EM(DEV_ST_TRANSITION_READY,	"READY")			\
> +	EM(DEV_ST_TRANSITION_SBL,	"SBL")				\
> +	EM(DEV_ST_TRANSITION_MISSION_MODE,	"MISSION MODE")		\
> +	EM(DEV_ST_TRANSITION_FP,		"FLASH PROGRAMMER")	\
> +	EM(DEV_ST_TRANSITION_SYS_ERR,		"SYS ERROR")		\
> +	EMe(DEV_ST_TRANSITION_DISABLE,		"DISABLE")
> +
> +/* Enums require being exported to userspace, for user tool parsing */
> +#undef	EM
> +#undef	EMe
> +#define	EM(a, b)	TRACE_DEFINE_ENUM(a);
> +#define	EMe(a, b)	TRACE_DEFINE_ENUM(a);
> +
> +MHI_STATE
> +MHI_EE
> +MHI_PM_STATE
> +MHI_CH_STATE
> +MHI_DEV_ST_TRANSITION
> +
> +/*
> + * Now redefine the EM() and EMe() macros to map the enums to the strings
> + * that will be printed in the output.
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)	{a, b},
> +#define EMe(a, b)	{a, b}
> +
> +TRACE_EVENT(mhi_gen_tre,
> +
> +	TP_PROTO(const char *name, int ch_num, u64 wp, __le64 tre_ptr,
> +		 __le32 dword0, __le32 dword1),
> +
> +	TP_ARGS(name, ch_num, wp, tre_ptr, dword0, dword1),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, ch_num)
> +		__field(u64, wp)
> +		__field(__le64, tre_ptr)
> +		__field(__le32, dword0)
> +		__field(__le32, dword1)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ch_num = ch_num;
> +		__entry->wp = wp;
> +		__entry->tre_ptr = tre_ptr;
> +		__entry->dword0 = dword0;
> +		__entry->dword1 = dword1;
> +	),
> +
> +	TP_printk("%s: Chan: %d WP: 0x%llx TRE: 0x%llx 0x%08x 0x%08x\n",
> +		  __get_str(name), __entry->ch_num, __entry->wp, __entry->tre_ptr,
> +		  __entry->dword0, __entry->dword1)
> +);
> +
> +TRACE_EVENT(mhi_intvec_threaded_handler,
> +
> +	TP_PROTO(const char *name, int local_ee, int state, int dev_ee, int dev_state),
> +
> +	TP_ARGS(name, local_ee, state, dev_ee, dev_state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, local_ee)
> +		__field(int, state)
> +		__field(int, dev_ee)
> +		__field(int, dev_state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->local_ee = local_ee;
> +		__entry->state = state;
> +		__entry->dev_ee = dev_ee;
> +		__entry->dev_state = dev_state;
> +	),
> +
> +	TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",
> +		  __get_str(name),
> +		  __print_symbolic(__entry->local_ee, MHI_EE),
> +		  __print_symbolic(__entry->state, MHI_STATE),
> +		  __print_symbolic(__entry->dev_ee, MHI_EE),
> +		  __print_symbolic(__entry->dev_state, MHI_STATE))
> +);
> +
> +TRACE_EVENT(mhi_tryset_pm_state,
> +
> +	TP_PROTO(const char *name, int pm_state),
> +
> +	TP_ARGS(name, pm_state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, pm_state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		if (pm_state)
> +			pm_state = __fls(pm_state);
> +		__entry->pm_state = pm_state;
> +	),
> +
> +	TP_printk("%s: PM state: %s\n", __get_str(name),
> +		  __print_symbolic(__entry->pm_state, MHI_PM_STATE))
> +);
> +
> +TRACE_EVENT(mhi_process_data_event_ring,
> +
> +	TP_PROTO(const char *name, __le64 ptr, __le32 dword0, __le32 dword1),
> +
> +	TP_ARGS(name, ptr, dword0, dword1),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(__le64, ptr)
> +		__field(__le32, dword0)
> +		__field(__le32, dword1)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ptr = ptr;
> +		__entry->dword0 = dword0;
> +		__entry->dword1 = dword1;
> +	),
> +
> +	TP_printk("%s: Processing Event:0x%llx 0x%08x 0x%08x\n",
> +		  __get_str(name), __entry->ptr, __entry->dword0, __entry->dword1)
> +);
> +
> +TRACE_EVENT(mhi_process_ctrl_ev_ring,
> +
> +	TP_PROTO(const char *name, u64 rp, __le64 ptr, __le32 dword0, __le32 dword1, int state),
> +
> +	TP_ARGS(name, rp, ptr, dword0, dword1, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(u64, rp)
> +		__field(__le64, ptr)
> +		__field(__le32, dword0)
> +		__field(__le32, dword1)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->rp = rp;
> +		__entry->ptr = ptr;
> +		__entry->dword0 = dword0;
> +		__entry->dword1 = dword1;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: RP:0x%llx Processing Event:0x%llx 0x%08x 0x%08x state:%s\n",
> +		  __get_str(name), __entry->rp, __entry->ptr, __entry->dword0,
> +		  __entry->dword1, __print_symbolic(__entry->state, MHI_STATE))
> +);
> +
> +TRACE_EVENT(mhi_update_channel_state_start,
> +
> +	TP_PROTO(const char *name, int ch_num, int state),
> +
> +	TP_ARGS(name, ch_num, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, ch_num)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ch_num = ch_num;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: ch%d: Updating state to: %s\n",
> +		  __get_str(name), __entry->ch_num,
> +		  __print_symbolic(__entry->state, MHI_CH_STATE))
> +);
> +
> +TRACE_EVENT(mhi_update_channel_state_end,
> +
> +	TP_PROTO(const char *name, int ch_num, int state),
> +
> +	TP_ARGS(name, ch_num, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, ch_num)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->ch_num = ch_num;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: ch%d: Updated state to: %s\n",
> +		  __get_str(name), __entry->ch_num,
> +		  __print_symbolic(__entry->state, MHI_CH_STATE))
> +);
> +
> +TRACE_EVENT(mhi_pm_st_transition,
> +
> +	TP_PROTO(const char *name, int state),
> +
> +	TP_ARGS(name, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: Handling state transition: %s\n", __get_str(name),
> +		  __print_symbolic(__entry->state, MHI_DEV_ST_TRANSITION))
> +);
> +
> +#endif
> +#include <trace/define_trace.h>
> 
> ---
> base-commit: 3006adf3be79cde4d14b1800b963b82b6e5572e0
> change-id: 20231005-ftrace_support-6869d4156139
> 
> Best regards,

