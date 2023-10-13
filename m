Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558507C828B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjJMJyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjJMJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:54:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD0A9;
        Fri, 13 Oct 2023 02:54:21 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D5HQNM015306;
        Fri, 13 Oct 2023 09:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Dd1hsR4xXjeTkRBch04KBr6UdBKUrM80WzAg32k9rwA=;
 b=lt8cZUCTnVnWipQt7GP13z1ng3kU5Rev+5HG9YDiPyAllIrR+kKm8ymzdBM1yCFiVxAs
 xE/o5KSLYsEzcTfq8rvYMWlH6rcyboom8ReIr2SusOQPNDbU57RTMDlRLnPiOHiNvR2I
 19qKRUOLvqcEGCpmeZKr/+aX0lzh/I5Uy7d6aTgpgWuYRVTdMX9mWZDpmIfzlNsHHa8I
 uAr+cHuB3hGT5Bre0mdakZswpviz5+IJXLvmsLKR01SheCO1g+5QEssmNHRDIRboZuri
 iOoZw7PqLK8kb6cm7G3mfcIs/5ZzWcsbc8cfVkw32GX5FhdwmmUI0ytjdblXAJpc/ATe /w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt11ha7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 09:54:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39D9riJw029261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 09:53:44 GMT
Received: from [10.216.22.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 02:53:38 -0700
Message-ID: <4c23ee39-dc28-8883-caf6-21a316873cbd@quicinc.com>
Date:   Fri, 13 Oct 2023 15:23:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] bus: mhi: host: Add tracing support
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
References: <20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com>
 <20231005224047.GJ3553829@hu-bjorande-lv.qualcomm.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231005224047.GJ3553829@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DqMvMK5U1n879R_UL4X6dVcKFXZg67yY
X-Proofpoint-ORIG-GUID: DqMvMK5U1n879R_UL4X6dVcKFXZg67yY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130081
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/6/2023 4:10 AM, Bjorn Andersson wrote:
> On Thu, Oct 05, 2023 at 03:55:20PM +0530, Krishna chaitanya chundru wrote:
>> This change adds ftrace support for following:
>> 1. mhi_intvec_threaded_handler
>> 2. mhi_process_data_event_ring
>> 3. mhi_process_ctrl_ev_ring
>> 4. mhi_gen_tre
>> 5. mhi_update_channel_state
>> 6. mhi_tryset_pm_state
>> 7. mhi_pm_st_worker
> This is not the best "problem description".
>
>> Usage:
>> 	echo 1 > /sys/kernel/debug/tracing/events/mhi_host/enable
>> 	cat /sys/kernel/debug/tracing/trace
> This does not need to be included in the commit message, how to use the
> tracing framework is documented elsewhere.
Removed this now.
> [..]
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index dcf627b36e82..499590437e9b 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -491,11 +491,10 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>>   
>>   	state = mhi_get_mhi_state(mhi_cntrl);
>>   	ee = mhi_get_exec_env(mhi_cntrl);
>> -	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
>> -		TO_MHI_EXEC_STR(mhi_cntrl->ee),
>> -		mhi_state_str(mhi_cntrl->dev_state),
>> -		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>>   
>> +	trace_mhi_intvec_threaded_handler(mhi_cntrl->mhi_dev->name, TO_MHI_EXEC_STR(mhi_cntrl->ee),
>> +					  mhi_state_str(mhi_cntrl->dev_state),
>> +					  TO_MHI_EXEC_STR(ee), mhi_state_str(state));
> All these helper functions that translates a state to a string, pass the
> raw state into the trace event and use __print_symbolic() in your
> TP_printk() instead.
>
> This will allow you to read the state, but you can have tools act of the
> numerical value.
>
>
> (This comment applies to all the trace events)
changed the events as you suggested.
>>   	if (state == MHI_STATE_SYS_ERR) {
>>   		dev_dbg(dev, "System error detected\n");
>>   		pm_state = mhi_tryset_pm_state(mhi_cntrl,
> [..]
>> diff --git a/include/trace/events/mhi_host.h b/include/trace/events/mhi_host.h
> [..]
>> +
>> +TRACE_EVENT(mhi_pm_st_worker,
> Why is this trace event called "worker", isn't the event a
> "mhi_pm_state_transition"?
>
> Don't just name your trace event based on the function that triggers
> them, but what they represent and make sure they carry useful
> information to understand the system.
>
> If you want to trace the flow through your functions, you can use e.g.
> ftrace.
>
> Regards,
> Bjorn

Changed as you suggested.

- KC

