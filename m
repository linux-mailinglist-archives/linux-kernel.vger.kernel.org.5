Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A411807F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjLGEYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGEYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:24:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA4CA9;
        Wed,  6 Dec 2023 20:24:55 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B73n22l002295;
        Thu, 7 Dec 2023 04:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+uVVnTaG7rhfM4bok7/Z3eGUhDAuQhQDo6QT/KosfdE=;
 b=cRripPacbR7wIABG1R6NhuTjuBO3w002qurkB1Mdm/yMSGbhPsmsUfhGCN5lC3ijAEjL
 czX7aLTUx+NqADOn8pTbfSjNv7JP3l6nqsiym9vywbWDQM+SKBOHjq7VekswWdQBt6gw
 8hAY9pjp5zQ9FLMYgcUoQ+yELrOgy9Olwlnm2RzMSeiLuMb129iaqAKbPkP2CupeZ+9s
 ZY3KxOVu21UXZq6lZWO3xc26n88d+WZHral8Lry92o0xw/NgmJe683uGV+I2A36kdEKg
 Fbg9051LNGl8J8gFESq1KztYLFZt8Fl8YaDymE34gB3fOib7hvReKL5roGxpBRjaS4WF qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utynu0tpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 04:24:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B74Ofxg002617
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 04:24:41 GMT
Received: from [10.216.5.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 20:24:36 -0800
Message-ID: <4e84d302-b2a1-d57b-7a1a-8ad5d7380ce7@quicinc.com>
Date:   Thu, 7 Dec 2023 09:54:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v7] bus: mhi: host: Add tracing support
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
References: <20231206-ftrace_support-v7-1-aca49a04268b@quicinc.com>
 <20231206105500.148ea367@gandalf.local.home>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231206105500.148ea367@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NZhU8o6duAfLY1SvUpnUHKox5XoAYWiy
X-Proofpoint-ORIG-GUID: NZhU8o6duAfLY1SvUpnUHKox5XoAYWiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_01,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070034
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/2023 9:25 PM, Steven Rostedt wrote:
> On Wed, 6 Dec 2023 21:12:57 +0530
> Krishna chaitanya chundru <quic_krichai@quicinc.com> wrote:
>
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index f78aefd2d7a3..6acb85f4c5f8 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -20,6 +20,9 @@
>>   #include <linux/wait.h>
>>   #include "internal.h"
>>   
>> +#define CREATE_TRACE_POINTS
>> +#include "trace.h"
>> +
>>   static DEFINE_IDA(mhi_controller_ida);
>>   
>>   const char * const mhi_ee_str[MHI_EE_MAX] = {
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index dcf627b36e82..507cf3351a97 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/skbuff.h>
>>   #include <linux/slab.h>
>>   #include "internal.h"
>> +#include "trace.h"
>>   
>>   int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
>>   			      void __iomem *base, u32 offset, u32 *out)
>> @@ -491,11 +492,9 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>>   
>>   	state = mhi_get_mhi_state(mhi_cntrl);
>>   	ee = mhi_get_exec_env(mhi_cntrl);
>> -	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
>> -		TO_MHI_EXEC_STR(mhi_cntrl->ee),
>> -		mhi_state_str(mhi_cntrl->dev_state),
>> -		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>>   
>> +	trace_mhi_intvec_states(mhi_cntrl->mhi_dev->name, mhi_cntrl->ee,
>> +				mhi_cntrl->dev_state, ee, state);
> I'm not sure if this was discussed before, but why not just pass in the
> mhi_cntrl pointer and do the assigning in the TRACE_EVENT()
> TP_fast_assign() portion?
>
> It will save on setting up the parameters.
>
>>   	if (state == MHI_STATE_SYS_ERR) {
>>   		dev_dbg(dev, "System error detected\n");
>>   		pm_state = mhi_tryset_pm_state(mhi_cntrl,
>> @@ -832,6 +831,10 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>>   	while (dev_rp != local_rp) {
>>   		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>>   
>> +		trace_mhi_ctrl_event(mhi_cntrl->mhi_dev->name, local_rp,
>> +				     local_rp->ptr, local_rp->dword[0],
>> +				     local_rp->dword[1]);
> And here..
>
>> +
>>   		switch (type) {
>>   		case MHI_PKT_TYPE_BW_REQ_EVENT:
>>   		{
>> @@ -997,6 +1000,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>>   	while (dev_rp != local_rp && event_quota > 0) {
>>   		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>>   
>> +		trace_mhi_data_event(mhi_cntrl->mhi_dev->name, local_rp, local_rp->ptr,
>> +				     local_rp->dword[0], local_rp->dword[1]);
> and here..
>
> for the local_rp. Especially since you are just repeating what you send
> into the two events. You can consolidate it down to just adding that in the
> TP_fast_assign() of the shared DECLARE_EVENT_CLASS().
>
>> +
>>   		chan = MHI_TRE_GET_EV_CHID(local_rp);
>>   
>>   		WARN_ON(chan >= mhi_cntrl->max_chan);
>> @@ -1235,6 +1241,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>>   	mhi_tre->dword[0] = MHI_TRE_DATA_DWORD0(info->len);
>>   	mhi_tre->dword[1] = MHI_TRE_DATA_DWORD1(bei, eot, eob, chain);
>>   
>> +	trace_mhi_gen_tre(mhi_cntrl->mhi_dev->name, mhi_chan->chan, mhi_tre,
>> +			  mhi_tre->ptr, mhi_tre->dword[0], mhi_tre->dword[1]);
> Same here. You can pass in the mhi_tre pointer.
>
>>   	/* increment WP */
>>   	mhi_add_ring_element(mhi_cntrl, tre_ring);
>>   	mhi_add_ring_element(mhi_cntrl, buf_ring);
>> @@ -1327,9 +1335,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>>   	enum mhi_cmd_type cmd = MHI_CMD_NOP;
>>   	int ret;
>>   
>> -	dev_dbg(dev, "%d: Updating channel state to: %s\n", mhi_chan->chan,
>> -		TO_CH_STATE_TYPE_STR(to_state));
>> -
>> +	trace_mhi_channel_command_start(mhi_cntrl->mhi_dev->name, mhi_chan->chan, to_state);
> And here..
>
>>   	switch (to_state) {
>>   	case MHI_CH_STATE_TYPE_RESET:
>>   		write_lock_irq(&mhi_chan->lock);
>> @@ -1396,9 +1402,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>>   		write_unlock_irq(&mhi_chan->lock);
>>   	}
>>   
>> -	dev_dbg(dev, "%d: Channel state change to %s successful\n",
>> -		mhi_chan->chan, TO_CH_STATE_TYPE_STR(to_state));
>> -
>> +	trace_mhi_channel_command_end(mhi_cntrl->mhi_dev->name, mhi_chan->chan, to_state);
> and here..
>
> Where you can also update the DECLARE_EVENT_CLASS() to directly access the
> mhi_cntrl and mhi_chan pointers. Sometimes it's better to do the
> dereference from inside the TP_fast_assign. That way, things like eprobes
> and bpf tracing can also have access to the full structure if needed.
>
> -- Steve

Hi Steve,

I will make changes as suggested in the next patch series.

- Krishna Chaitanya.

