Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F267D9CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbjJ0PaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346167AbjJ0PaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:30:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28691AF;
        Fri, 27 Oct 2023 08:30:10 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39REugfc015711;
        Fri, 27 Oct 2023 15:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y+U9W/JHLYARpBMFCoQXnpc1aJF1e4944L+Jfilc+OI=;
 b=ppuZ1DbsyatG7wa0NCR/vZr/u7R5Ce4ete3lOaUVzR0iDBDlN/9qhULTHjJZi92OotPu
 Uu02B6kyC0VNKGkyEQPdoHr4zR6rFBBJDJZdYYDF6AJGYU/Ms1d2JxDLxAZcHUmgQBQ2
 m2c0fxELx19ejWNwBq1C0YA2d//fm+Jeze9bYK4oXgGGtyQUepGpyox6tlBEN7t3sgnl
 wsBD2/DKRqY7Q79EBpKfMoR3xDwiKSnrUjcd73ELDeGIcVdrh4HURTaf7E4b0Gll03uQ
 O+Nsglw7zNcchCyer/57V8FyueHHH4Eq8xraI5/9Q7EXFmf8/QXVGz0si760oZGka9s4 mw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxbvadmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 15:29:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39RFT8Xw002309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 15:29:08 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 27 Oct
 2023 08:29:07 -0700
Message-ID: <baf17652-e2e8-0083-459e-a6ea4372466b@quicinc.com>
Date:   Fri, 27 Oct 2023 09:29:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] bus: mhi: host: Add tracing support
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
References: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
 <9216f694-cce0-2b95-df34-e5b60538644a@quicinc.com>
 <ab9367fa-53e7-36d1-cac5-a3c1e28df4b3@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <ab9367fa-53e7-36d1-cac5-a3c1e28df4b3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kt-Z5ZEX-BG9MnBBUiS0qE6Tk0gpb4ik
X-Proofpoint-GUID: kt-Z5ZEX-BG9MnBBUiS0qE6Tk0gpb4ik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270133
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2023 1:11 AM, Krishna Chaitanya Chundru wrote:
> 
> On 10/20/2023 8:33 PM, Jeffrey Hugo wrote:
>> On 10/13/2023 3:52 AM, Krishna chaitanya chundru wrote:
>>> This change adds ftrace support for following functions which
>>> helps in debugging the issues when there is Channel state & MHI
>>> state change and also when we receive data and control events:
>>> 1. mhi_intvec_threaded_handler
>>> 2. mhi_process_data_event_ring
>>> 3. mhi_process_ctrl_ev_ring
>>> 4. mhi_gen_tre
>>> 5. mhi_update_channel_state
>>> 6. mhi_tryset_pm_state
>>> 7. mhi_pm_st_worker
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> ---
>>> Changes in v2:
>>> - Passing the raw state into the trace event and using 
>>> __print_symbolic() as suggested by bjorn.
>>> - Change mhi_pm_st_worker to mhi_pm_st_transition as suggested by bjorn.
>>> - Fixed the kernel test rebot issues.
>>> - Link to v1: 
>>> https://lore.kernel.org/r/20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com 
>>>
>>> ---
>>>   MAINTAINERS                     |   1 +
>>>   drivers/bus/mhi/host/init.c     |   3 +
>>>   drivers/bus/mhi/host/internal.h |   1 +
>>>   drivers/bus/mhi/host/main.c     |  32 +++--
>>>   drivers/bus/mhi/host/pm.c       |   6 +-
>>>   include/trace/events/mhi_host.h | 287 
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   6 files changed, 317 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 35977b269d5e..4339c668a6ab 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -13862,6 +13862,7 @@ F:    Documentation/mhi/
>>>   F:    drivers/bus/mhi/
>>>   F:    drivers/pci/endpoint/functions/pci-epf-mhi.c
>>>   F:    include/linux/mhi.h
>>> +F:    include/trace/events/mhi_host.h
>>>     MICROBLAZE ARCHITECTURE
>>>   M:    Michal Simek <monstr@monstr.eu>
>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>> index f78aefd2d7a3..3afa90a204fd 100644
>>> --- a/drivers/bus/mhi/host/init.c
>>> +++ b/drivers/bus/mhi/host/init.c
>>> @@ -20,6 +20,9 @@
>>>   #include <linux/wait.h>
>>>   #include "internal.h"
>>>   +#define CREATE_TRACE_POINTS
>>> +#include <trace/events/mhi_host.h>
>>
>> This feels redundant to me.  A few lines ago we included internal.h, 
>> and internal.h includes trace/events/mhi_host.h
> 
> As Steve mentioned, this is mandatory step for creating trace points & 
> trace events.

I understand this creates the trace points, and that needs to be done in 
C code.  It dtill seems redundant because we are including the header 
twice (and I am aware trace has the special multi-header read 
functionality for this).

The duplicate include still feels weird, but I have not come up with a 
better way to structure this.

> 
>>
>>> +
>>>   static DEFINE_IDA(mhi_controller_ida);
>>>     const char * const mhi_ee_str[MHI_EE_MAX] = {
>>> diff --git a/drivers/bus/mhi/host/internal.h 
>>> b/drivers/bus/mhi/host/internal.h
>>> index 2e139e76de4c..a80a317a59a9 100644
>>> --- a/drivers/bus/mhi/host/internal.h
>>> +++ b/drivers/bus/mhi/host/internal.h
>>> @@ -7,6 +7,7 @@
>>>   #ifndef _MHI_INT_H
>>>   #define _MHI_INT_H
>>>   +#include <trace/events/mhi_host.h>
>>>   #include "../common.h"
>>>     extern struct bus_type mhi_bus_type;
>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>> index dcf627b36e82..fcdb728ba49f 100644
>>> --- a/drivers/bus/mhi/host/main.c
>>> +++ b/drivers/bus/mhi/host/main.c
>>> @@ -246,6 +246,11 @@ static void *mhi_to_virtual(struct mhi_ring 
>>> *ring, dma_addr_t addr)
>>>       return (addr - ring->iommu_base) + ring->base;
>>>   }
>>>   +dma_addr_t mhi_to_physical(struct mhi_ring *ring, void *addr)
>>> +{
>>> +    return (addr - ring->base) + ring->iommu_base;
>>> +}
>>
>> This seems to be poorly named since we are using the iommu_base which 
>> suggests we are converting to an IOVA.
>>
>> Why do we need this though?  This seems like it might be a security 
>> issue, or at the very least, not preferred, and I'm struggling to 
>> figure out what value this provides to you are I when looking at the log.
>>
> I will rename the function to reflect it is converting to IOVA.
> 
> We MHI TRE we write the IOVA address, to correlate between TRE events in 
> the MHI ring and event we are processing  we want to log the IOVA address.
> 
> As we are logging only IOVA address which is provided in the devicetree 
> and not the original physical address we are not expecting any security 
> issues here.
> 
> Correct me if I was wrong.

The IOVA is not provided by DT, it is a runtime allocated value provided 
by the IOMMU, if present.  If not present, then it is a physical address.

Remember, x86 does not use devicetree.

While the IOVA (with an iommu) is not technically a physical address, 
but is treated as such by the device.  I can imagine an attacker doing 
bad things if they get a hold of the value.

Still, you haven't indicated why this is useful.

> 
>>> +
>>>   static void mhi_add_ring_element(struct mhi_controller *mhi_cntrl,
>>>                    struct mhi_ring *ring)
>>>   {
>>> @@ -491,11 +496,9 @@ irqreturn_t mhi_intvec_threaded_handler(int 
>>> irq_number, void *priv)
>>>         state = mhi_get_mhi_state(mhi_cntrl);
>>>       ee = mhi_get_exec_env(mhi_cntrl);
>>> -    dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
>>> -        TO_MHI_EXEC_STR(mhi_cntrl->ee),
>>> -        mhi_state_str(mhi_cntrl->dev_state),
>>> -        TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>>>   + trace_mhi_intvec_threaded_handler(mhi_cntrl->mhi_dev->name, 
>>> mhi_cntrl->ee,
>>> +                      mhi_cntrl->dev_state, ee, state);
>>
>> Why are we removing the debug message when adding this trace?  The 
>> commit text doesn't say.  (Looks like you do this several times, 
>> assume this comment applies to all isntances)
> 
> I will add this in the commit text in my next patch.
> 
> Just a query is recommended to keep both debug message and trace events. 
> If yes we will not remove the debug messages.

I think it would be preferred to have one mechanism or the other, not 
both.  It seems like you are doing an incomplete conversion.

> 
>>
>>>       if (state == MHI_STATE_SYS_ERR) {
>>>           dev_dbg(dev, "System error detected\n");
>>>           pm_state = mhi_tryset_pm_state(mhi_cntrl,
>>> @@ -832,6 +835,12 @@ int mhi_process_ctrl_ev_ring(struct 
>>> mhi_controller *mhi_cntrl,
>>>       while (dev_rp != local_rp) {
>>>           enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>>>   + trace_mhi_process_ctrl_ev_ring(mhi_cntrl->mhi_dev->name,
>>> +                           mhi_to_physical(ev_ring, local_rp),
>>> +                           local_rp->ptr, local_rp->dword[0],
>>> +                           local_rp->dword[1],
>>> +                           MHI_TRE_GET_EV_STATE(local_rp));
>>
>> Why not just pass in the local_rp as a single parameter and have the 
>> trace implementation decode it?  (Looks like you do this several 
>> times, assume this comment applies to all isntances)
> 
> MHI_TRE_GET_EV_STATE definition is present in drivers/bus/mhi/common.h 
> which is common for both EP & MHI driver.
> 
> If we keep this macro definition again in mhi_host.h it will be 
> redundant one.

What is wrong with including the right header over in the trace to get 
the definition?  I didn't ask for it to be redefined.

If the struct definition for local_rp changes, it will probably break 
this, which will require changes to the definition and use of 
trace_mhi_process_ctrl_ev_ring().  If trace_mhi_process_ctrl_ev_ring() 
just takes the struct and decodes it, the decode logic just needs to be 
updated (in one place) when the struct definition changes.

> 
> And we are only using this way only for this trace log. So we are using 
> the macro to get the state information.

No, you do the same thing for trace_mhi_process_data_event_ring() and 
trace_mhi_gen_tre().

