Return-Path: <linux-kernel+bounces-155644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8517A8AF524
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D3F1F22D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F313DDA5;
	Tue, 23 Apr 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NoLQs1lS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9231BC23;
	Tue, 23 Apr 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892246; cv=none; b=uXPPSQ2eM91MJ4xEZKFvmBbAWgdjVngRaylGI2Ro/Zsm9rH/vNlO2T/QICOAiopOg30FSAgP3mQFHwNR7FeQ+dbfbhJWWGOlr1EElriDA056a8tVsXMWmzDrMp51zj84ghKprITKx+QJDhHyh4obxZv1bGYPSc3YJSK/pmhQh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892246; c=relaxed/simple;
	bh=3iJsSjxbI0PNipnxd/KeM1DCk6cveiFrDgu3Xi+l1Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s6gphxlWwj2aKIpXgCIEEWM13imqOqs2wPYO978x9eKgswKumrqoawrRmUkGJ/VBBzOxDqzDXKRx9NQZyLmaTwoH730pGV8vXj91EPxMsA/MCoKwDft15JED+mmNIFScW5doFF6mG5KDLDCQmOfxWe0S3qhal7FKTt49XB4JKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NoLQs1lS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NBI66Z007348;
	Tue, 23 Apr 2024 17:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iwfP7SYyKYAwAEtQZw+SpCrrNAmXiipoup29vOfLkR8=; b=No
	LQs1lSuLQagIs4RxVZYijk6ekijLT9OH0KL0M8aq/0CX0vfJUdSlKCN9E810mwjS
	Ls38RwaPpWWZbMAjQnAMRQlG70z0pLrKo7VjcBWHmBE7GBQgR55u7UCXxgQS3g+j
	K3yIaw7qQwHCBRvV2H3tDZJ83GmKhqo5OI1qT3pKRcbZdzQRTIarrPeXxjFaKJuz
	4uDFWCWEWAYW469lR/rrUh1UZmoqKLcGt6owboQDze261U7o5rKzACVpvsa2Y30M
	zkSUhkKQYmd8Tseud6vibHhIxXxG+3YdggYTR3r3kLituAabN7DlkYkMv+FSx8n3
	T/1CF85n7u8Hz5TXRFxg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp8chsn2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 17:10:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NHAWY6008955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 17:10:32 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 10:10:26 -0700
Message-ID: <d5581614-71ad-5f7f-e948-bdbab3ef854e@quicinc.com>
Date: Tue, 23 Apr 2024 22:40:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 2/5] mailbox: Add support for QTI CPUCP mailbox
 controller
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        <quic_gkohli@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_psodagud@quicinc.com>, <abel.vesa@linaro.org>
References: <20240422164035.1045501-1-quic_sibis@quicinc.com>
 <20240422164035.1045501-3-quic_sibis@quicinc.com>
 <d6052413-5706-446b-b508-2a5ed839acc4@linaro.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <d6052413-5706-446b-b508-2a5ed839acc4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: upaUshkJipjEYvkzg4rZ8gJBqozeNrgc
X-Proofpoint-ORIG-GUID: upaUshkJipjEYvkzg4rZ8gJBqozeNrgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230039



On 4/23/24 04:47, Konrad Dybcio wrote:
> 
> 
> On 4/22/24 18:40, Sibi Sankar wrote:
>> Add support for CPUSS Control Processor (CPUCP) mailbox controller,
>> this driver enables communication between AP and CPUCP by acting as
>> a doorbell between them.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> 
> [...]
> 
>> +
>> +static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +    struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct 
>> qcom_cpucp_mbox, mbox);
>> +    unsigned long chan_id = channel_number(chan);
>> +    u32 *val = data;
>> +
>> +    writel(*val, cpucp->tx_base + APSS_CPUCP_TX_MBOX_CMD(chan_id) + 
>> APSS_CPUCP_MBOX_CMD_OFF);
> 

Hey Konrad,

Thanks for taking time to review the series.

> Just checking in, is *this access only* supposed to be 32b instead of 64 
> like others?

yeah, the readl and writely in the driver were used intentionally.

> 
> [...]
> 
>> +
>> +    writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +    writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
>> +    writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
> 
> If these writes are here to prevent a possible interrupt storm type 
> tragedy,
> you need to read back these registers to ensure the writes have left the 
> CPU
> complex and reached the observer at the other end of the bus (not to be
> confused with barriers which only ensure that such accesses are ordered
> *when still possibly within the CPU complex*).

I couldn't find anything alluding to ^^. This sequence was just
meant to reset the mailbox. Looks like we do need to preserve the
ordering so relaxed read/writes aren't an option.

-Sibi

> 
> Moreover, if the order of them arriving (en/clear/mask) doesn't matter, you
> can add _relaxed for a possible nanosecond-order perf gain
> 
>> +
>> +    irq = platform_get_irq(pdev, 0);
>> +    if (irq < 0)
>> +        return irq;
>> +
>> +    ret = devm_request_irq(dev, irq, qcom_cpucp_mbox_irq_fn,
>> +                   IRQF_TRIGGER_HIGH, "apss_cpucp_mbox", cpucp);
>> +    if (ret < 0)
>> +        return dev_err_probe(dev, ret, "Failed to register irq: 
>> %d\n", irq);
>> +
>> +    writeq(APSS_CPUCP_RX_MBOX_CMD_MASK, cpucp->rx_base + 
>> APSS_CPUCP_RX_MBOX_MAP);
> 
> Similarly here, unless read back, we may potentially miss some 
> interrupts if
> e.g. a channel is opened and that write "is decided" (by the silicon) to 
> leave
> the internal buffer first

At this point in time we don't expect any interrupts. They are expected
only after channel activation. Also there were no recommendations for
reading it back here as well.

-Sibi

> 
> 
>> +
>> +    mbox = &cpucp->mbox;
>> +    mbox->dev = dev;
>> +    mbox->num_chans = APSS_CPUCP_IPC_CHAN_SUPPORTED;
>> +    mbox->chans = cpucp->chans;
>> +    mbox->ops = &qcom_cpucp_mbox_chan_ops;
>> +    mbox->txdone_irq = false;
>> +    mbox->txdone_poll = false;
> 
> "false" == 0 is the default value (as you're using k*z*alloc)
> 
> 
>> +
>> +    ret = devm_mbox_controller_register(dev, mbox);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "Failed to create mailbox\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id qcom_cpucp_mbox_of_match[] = {
>> +    { .compatible = "qcom,x1e80100-cpucp-mbox" },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_cpucp_mbox_of_match);
>> +
>> +static struct platform_driver qcom_cpucp_mbox_driver = {
>> +    .probe = qcom_cpucp_mbox_probe,
>> +    .driver = {
>> +        .name = "qcom_cpucp_mbox",
>> +        .of_match_table = qcom_cpucp_mbox_of_match,
>> +    },
>> +};
>> +module_platform_driver(qcom_cpucp_mbox_driver);
> 
> That's turbo late. Go core_initcall.
> 
> Konrad

