Return-Path: <linux-kernel+bounces-20111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743148279B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2243F285065
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3556777;
	Mon,  8 Jan 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C40OVGRf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256C5467C;
	Mon,  8 Jan 2024 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408KQdwX009770;
	Mon, 8 Jan 2024 20:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PQMgwo5v8yBuXGGB1Ie/PPOVUlA7ykfCipsRApxniaE=; b=C4
	0OVGRflLQsXRQU4qbFsHilnQoE9bxWtZ1d3oLCtQ1X4Db4vrdVfWIWLZyLT6baVz
	7HqyX5JZj2yyzCplVCD+P1fwvKLk66+qxIVqNt0WgRoz/e4uqwk9iw3j0rwHz+gj
	GiiEf1EzoL4Jq2r1HFdnpf0RxbLfXQt//A+WW2i67m+Xhnf+zAh4A6G8JcuZDTq/
	URVeT8eCU40mRwA9FXA31lgRyCjCbxBH9kgVfL/UWX0KVhgPtpUmsgjW7e5CEZqA
	+wRUU4PHR7y8j2EK4l3QG1GVU5upMfMHkleMaC5fblrZqlcshg1/pJN6DiP1NAwZ
	8oO62aJTPPlJvvw8EHtw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgkkh8rmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 20:52:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408Kq0He011437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 20:52:00 GMT
Received: from [10.110.97.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 12:51:59 -0800
Message-ID: <7b2ec96b-b72f-c848-7c35-36e61a4072ac@quicinc.com>
Date: Mon, 8 Jan 2024 12:51:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 04/41] usb: host: xhci-mem: Cleanup pending secondary
 event ring events
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
 <20240102214549.22498-5-quic_wcheng@quicinc.com>
 <734591a1-50b4-6dc7-0b93-077355ec12e4@linux.intel.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <734591a1-50b4-6dc7-0b93-077355ec12e4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h1WdLni0I-RNQn7WJw5CZxOmyf6I2X9g
X-Proofpoint-ORIG-GUID: h1WdLni0I-RNQn7WJw5CZxOmyf6I2X9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=748
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080172

Hi Mathias,

On 1/4/2024 6:48 AM, Mathias Nyman wrote:
> On 2.1.2024 23.45, Wesley Cheng wrote:
>> As part of xHCI bus suspend, the XHCI is halted.  However, if there are
>> pending events in the secondary event ring, it is observed that the xHCI
>> controller stops responding to further commands upon host or device
>> initiated bus resume.  Iterate through all pending events and update the
>> dequeue pointer to the beginning of the event ring.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ...
>> +/*
>> + * Move the event ring dequeue pointer to skip events kept in the 
>> secondary
>> + * event ring.  This is used to ensure that pending events in the 
>> ring are
>> + * acknowledged, so the XHCI HCD can properly enter suspend/resume.  The
>> + * secondary ring is typically maintained by an external component.
>> + */
>> +void xhci_skip_sec_intr_events(struct xhci_hcd *xhci,
>> +    struct xhci_ring *ring,    struct xhci_interrupter *ir)
>> +{
>> +    union xhci_trb *erdp_trb, *current_trb;
>> +    u64 erdp_reg;
>> +    u32 iman_reg;
>> +    dma_addr_t deq;
>> +
>> +    /* disable irq, ack pending interrupt and ack all pending events */
>> +    xhci_disable_interrupter(ir);
>> +    iman_reg = readl_relaxed(&ir->ir_set->irq_pending);
>> +    if (iman_reg & IMAN_IP)
>> +        writel_relaxed(iman_reg, &ir->ir_set->irq_pending);
>> +
>> +    /* last acked event trb is in erdp reg  */
>> +    erdp_reg = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
>> +    deq = (dma_addr_t)(erdp_reg & ERST_PTR_MASK);
>> +    if (!deq) {
>> +        xhci_err(xhci, "event ring handling not required\n");
>> +        return;
>> +    }
>> +
>> +    erdp_trb = current_trb = ir->event_ring->dequeue;
>> +    /* read cycle state of the last acked trb to find out CCS */
>> +    ring->cycle_state = le32_to_cpu(current_trb->event_cmd.flags) & 
>> TRB_CYCLE;
>> +
>> +    while (1) {
>> +        inc_deq(xhci, ir->event_ring);
>> +        erdp_trb = ir->event_ring->dequeue;
>> +        /* cycle state transition */
>> +        if ((le32_to_cpu(erdp_trb->event_cmd.flags) & TRB_CYCLE) !=
>> +            ring->cycle_state)
>> +            break;
>> +    }
>> +
>> +    xhci_update_erst_dequeue(xhci, ir, current_trb, true);
>> +}
> 
> Code above is very similar to the existing event ring processing parts 
> of xhci_irq()
> and xhci_handle_event()
> 
> I'll see if I can refactor the existing event ring processing, decouple 
> it from
> event handling so that it could be used by primary and secondary 
> interrupters with
> handlers, and this case where we just want to clear the event ring.
> 

Thanks, that makes sense.  Will take a look as well.

Thanks
Wesley Cheng

