Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EABE7BAEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjJEWk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjJEWk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:40:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EBDCE;
        Thu,  5 Oct 2023 15:40:55 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395MTNUn001120;
        Thu, 5 Oct 2023 22:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ptoxpTRqhOD5uRlDmhFsSGRP/spC1frZB3ObOCK/CbI=;
 b=Qdq5dgoSWkp9EKh1vfcRW8btmJSumSTwA1v/BJEKxdfEdJfeztGkpp3LbraOT6tVZE0S
 YzW+Dq268A1hxnmRh7JRWhIKT7nI0ix5eqOx9qA7rBjvEXR2Jsq9VUKm17ZmM5oFBRLU
 7yXuU1nTyk+CB1Fn0gNNXcQSm8UWD35buEdU1dCXSWgWQMrsjDQSGjWcFhCTzWMnvTCn
 mgnFDWlmFcDklgEKCu7Vt2rdLqtNCs7xg+lyD6JixhNLD+D6tnk3ROwxaxTYrwaKVanp
 q2ZBP31gDgV+ExTo5nZOMeDsvvlnVGvM7N6wPT8A4t6ZXl1gvSrNn+FtBsEJEL+ybQkN 1w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thfkh2w0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 22:40:49 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395Memm6004754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 22:40:48 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 5 Oct 2023 15:40:47 -0700
Date:   Thu, 5 Oct 2023 15:40:47 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: Add tracing support
Message-ID: <20231005224047.GJ3553829@hu-bjorande-lv.qualcomm.com>
References: <20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JktFufEr0O3dTFaZH_XmFFeuIu1NWPaC
X-Proofpoint-ORIG-GUID: JktFufEr0O3dTFaZH_XmFFeuIu1NWPaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_17,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 03:55:20PM +0530, Krishna chaitanya chundru wrote:
> This change adds ftrace support for following:
> 1. mhi_intvec_threaded_handler
> 2. mhi_process_data_event_ring
> 3. mhi_process_ctrl_ev_ring
> 4. mhi_gen_tre
> 5. mhi_update_channel_state
> 6. mhi_tryset_pm_state
> 7. mhi_pm_st_worker

This is not the best "problem description".

> 
> Usage:
> 	echo 1 > /sys/kernel/debug/tracing/events/mhi_host/enable
> 	cat /sys/kernel/debug/tracing/trace

This does not need to be included in the commit message, how to use the
tracing framework is documented elsewhere.

[..]
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index dcf627b36e82..499590437e9b 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -491,11 +491,10 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>  
>  	state = mhi_get_mhi_state(mhi_cntrl);
>  	ee = mhi_get_exec_env(mhi_cntrl);
> -	dev_dbg(dev, "local ee: %s state: %s device ee: %s state: %s\n",
> -		TO_MHI_EXEC_STR(mhi_cntrl->ee),
> -		mhi_state_str(mhi_cntrl->dev_state),
> -		TO_MHI_EXEC_STR(ee), mhi_state_str(state));
>  
> +	trace_mhi_intvec_threaded_handler(mhi_cntrl->mhi_dev->name, TO_MHI_EXEC_STR(mhi_cntrl->ee),
> +					  mhi_state_str(mhi_cntrl->dev_state),
> +					  TO_MHI_EXEC_STR(ee), mhi_state_str(state));

All these helper functions that translates a state to a string, pass the
raw state into the trace event and use __print_symbolic() in your
TP_printk() instead.

This will allow you to read the state, but you can have tools act of the
numerical value.


(This comment applies to all the trace events)

>  	if (state == MHI_STATE_SYS_ERR) {
>  		dev_dbg(dev, "System error detected\n");
>  		pm_state = mhi_tryset_pm_state(mhi_cntrl,
[..]
> diff --git a/include/trace/events/mhi_host.h b/include/trace/events/mhi_host.h
[..]
> +
> +TRACE_EVENT(mhi_pm_st_worker,

Why is this trace event called "worker", isn't the event a
"mhi_pm_state_transition"?

Don't just name your trace event based on the function that triggers
them, but what they represent and make sure they carry useful
information to understand the system.

If you want to trace the flow through your functions, you can use e.g.
ftrace.

Regards,
Bjorn
