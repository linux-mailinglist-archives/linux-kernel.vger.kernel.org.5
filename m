Return-Path: <linux-kernel+bounces-148435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B36FE8A8285
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BA7B2745B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7113D282;
	Wed, 17 Apr 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cme5pWh6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE3913CAB7;
	Wed, 17 Apr 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354700; cv=none; b=rEC9HnbN0zEhV6Uvwgd9ARI7cQ4B27ew1z9ixS3iuKXUday5OG3ELfdHd7vd3inYmFKS3Cq9nwhX79OcIORbbIFdsVyIVXrMneWTU899ub7maQg/9YB4ROVC/gj5GN107iPUnnPQ0bbcmejXZ6eVsKgFRsB4i9/tRfvHir8YxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354700; c=relaxed/simple;
	bh=w/qEAfIT6mNfdhYWJyn21TsMoPUHKZvm6cuKJ4/7MkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jfud4WOpfeG6SgIp0ZhenSGCH8pVi469voqUCEes7AuctzEejNET5wWrPvL3N7T/GNF3tpJSrZcLjzHqlA1vf3EVzHElux+HvXtvyY/wf/dA57T5acaefKMog9676DAH/QBj/gfOTGjqMn8MUFpED77cFlAFaJwi5rg7FYbAZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cme5pWh6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8H0In015900;
	Wed, 17 Apr 2024 11:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7OpK8fAn8Bstj4FjsyxtdvNCzzYZGhcbwrFWt7rF7Yw=; b=Cm
	e5pWh6YiTmKeTlCOBSdjHQyyXJLJT2yRUiTUkn0mUYJmiDo5vhtNBiih9PhbQ1HX
	za1v82dsivqXZiGP8OGu5Rovi1sHFSjXjCA1sYxOzmfW0PhXRDXYqnqwnFf4h753
	2sG58VTnbP2LNbL48Mug2BTR08DefFyJgI5gmk9rPMoiz0IM1ocCIxP5husKh8bN
	Q1em7fWDkmEyhVRLsP0TaksBc7+P1dkbdHzBc6bPUC2ys8hON6vh+q15JmbxbiY2
	EmoKIAIAfRkyTodbb16vlg7guHPSV4HisDyLZC+U30QkN3ktQShYKQrSZz5/uKfB
	DwkQ3xnPu6C+P8i7TuVw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjarpgekm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:51:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HBpTC1007293
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 11:51:29 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 04:51:24 -0700
Message-ID: <f32b7e43-5e39-0c82-1e03-18a2219adfdb@quicinc.com>
Date: Wed, 17 Apr 2024 17:21:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/5] mailbox: Add support for QTI CPUCP mailbox controller
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        <quic_gkohli@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_psodagud@quicinc.com>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
 <20240328095044.2926125-3-quic_sibis@quicinc.com>
 <CAA8EJpoQyzF1E2xFPHvzz5Nk=w3J2abd3Y13nc+4FK-jRQbnFw@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAA8EJpoQyzF1E2xFPHvzz5Nk=w3J2abd3Y13nc+4FK-jRQbnFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yu2ifjpdiDuyaqi2QG2Tv1vwulmxlDXX
X-Proofpoint-ORIG-GUID: Yu2ifjpdiDuyaqi2QG2Tv1vwulmxlDXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170081



On 4/16/24 21:51, Dmitry Baryshkov wrote:
> On Thu, 28 Mar 2024 at 11:52, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> Add support for CPUSS Control Processor (CPUCP) mailbox controller,
>> this driver enables communication between AP and CPUCP by acting as
>> a doorbell between them.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> rfc:
>> * Use chan->lock and chan->cl to detect if the channel is no longer
>>    Available. [Dmitry]
>> * Use BIT() instead of using manual shifts. [Dmitry]
>> * Don't use integer as a pointer value. [Dmitry]
>> * Allow it to default to of_mbox_index_xlate. [Dmitry]
>> * Use devm_of_iomap. [Dmitry]
>> * Use module_platform_driver instead of module init/exit. [Dmitry]
>> * Get channel number using mailbox core (like other drivers) and
>>    further simplify the driver by dropping setup_mbox func.

Hey Dmitry,

Thanks for taking time to review the series.

>>
>>   drivers/mailbox/Kconfig           |   8 ++
>>   drivers/mailbox/Makefile          |   2 +
>>   drivers/mailbox/qcom-cpucp-mbox.c | 205 ++++++++++++++++++++++++++++++
>>   3 files changed, 215 insertions(+)
>>   create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c
>>
[snip]
..
>> +
>> +       status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
>> +
>> +       for (i = 0; i < APSS_CPUCP_IPC_CHAN_SUPPORTED; i++) {
>> +               val = 0;
>> +               if (status & ((u64)1 << i)) {
> 
> BIT() or test_bit()

I'll use BIT()

> 
>> +                       val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD + (i * 8) + APSS_CPUCP_MBOX_CMD_OFF);
> 
> #define APSS_CPUCP_MBOX_CMD_OFF(i)

ack

> 
>> +                       chan = &cpucp->chans[i];
>> +                       spin_lock_irqsave(&chan->lock, flags);
>> +                       if (chan->cl)
>> +                               mbox_chan_received_data(chan, &val);
>> +                       spin_unlock_irqrestore(&chan->lock, flags);
>> +                       writeq(status, cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
> 
> Why is status written from inside the loop? If the bits are cleared by
> writing 1, then you should be writing BIT(i) to that register. Also
> make sure that it is written at the correct time, so that if there is
> an event before notifying the driver, it doesn't get lost.

Thanks for catching this. I probably didn't run into this scenario
because of using just one channel at point any time. I'll move it
outside the loop.

> 
>> +               }
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int qcom_cpucp_mbox_startup(struct mbox_chan *chan)
>> +{
>> +       struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
>> +       unsigned long chan_id = channel_number(chan);
>> +       u64 val;
>> +
>> +       val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +       val |= BIT(chan_id);
>> +       writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +
>> +       return 0;
>> +}
>> +
>> +static void qcom_cpucp_mbox_shutdown(struct mbox_chan *chan)
>> +{
>> +       struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
>> +       unsigned long chan_id = channel_number(chan);
>> +       u64 val;
>> +
>> +       val = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +       val &= ~BIT(chan_id);
>> +       writeq(val, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +}
>> +
>> +static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +       struct qcom_cpucp_mbox *cpucp = container_of(chan->mbox, struct qcom_cpucp_mbox, mbox);
>> +       unsigned long chan_id = channel_number(chan);
>> +       u32 *val = data;
>> +
>> +       writel(*val, cpucp->tx_base + APSS_CPUCP_TX_MBOX_CMD + (chan_id * 8) + APSS_CPUCP_MBOX_CMD_OFF);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct mbox_chan_ops qcom_cpucp_mbox_chan_ops = {
>> +       .startup = qcom_cpucp_mbox_startup,
>> +       .send_data = qcom_cpucp_mbox_send_data,
>> +       .shutdown = qcom_cpucp_mbox_shutdown
>> +};
>> +
>> +static int qcom_cpucp_mbox_probe(struct platform_device *pdev)
>> +{
>> +       struct qcom_cpucp_mbox *cpucp;
>> +       struct mbox_controller *mbox;
>> +       int ret;
>> +
>> +       cpucp = devm_kzalloc(&pdev->dev, sizeof(*cpucp), GFP_KERNEL);
>> +       if (!cpucp)
>> +               return -ENOMEM;
>> +
>> +       cpucp->dev = &pdev->dev;
>> +
>> +       cpucp->rx_base = devm_of_iomap(cpucp->dev, cpucp->dev->of_node, 0, NULL);
>> +       if (IS_ERR(cpucp->rx_base))
>> +               return PTR_ERR(cpucp->rx_base);
>> +
>> +       cpucp->tx_base = devm_of_iomap(cpucp->dev, cpucp->dev->of_node, 1, NULL);
>> +       if (IS_ERR(cpucp->tx_base))
>> +               return PTR_ERR(cpucp->tx_base);
>> +
>> +       writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_EN);
>> +       writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
>> +       writeq(0, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
>> +
>> +       cpucp->irq = platform_get_irq(pdev, 0);
>> +       if (cpucp->irq < 0) {
>> +               dev_err(&pdev->dev, "Failed to get the IRQ\n");
>> +               return cpucp->irq;
> 
> It already prints the error message.

ack

> 
>> +       }
>> +
>> +       ret = devm_request_irq(&pdev->dev, cpucp->irq, qcom_cpucp_mbox_irq_fn,
>> +                              IRQF_TRIGGER_HIGH, "apss_cpucp_mbox", cpucp);
>> +       if (ret < 0) {
>> +               dev_err(&pdev->dev, "Failed to register the irq: %d\n", ret);
>> +               return ret;
> 
> return dev_err_probe();

ack

> 
>> +       }
>> +
>> +       writeq(APSS_CPUCP_RX_MBOX_CMD_MASK, cpucp->rx_base + APSS_CPUCP_RX_MBOX_MAP);
>> +
>> +       mbox = &cpucp->mbox;
>> +       mbox->dev = cpucp->dev;
>> +       mbox->num_chans = APSS_CPUCP_IPC_CHAN_SUPPORTED;
>> +       mbox->chans = cpucp->chans;
>> +       mbox->ops = &qcom_cpucp_mbox_chan_ops;
>> +       mbox->txdone_irq = false;
>> +       mbox->txdone_poll = false;
>> +
>> +       ret = mbox_controller_register(mbox);
> 
> Use devm_mbox_controller_register()

ack

>  >> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed to create mailbox\n");
>> +               return ret;
> 
> return dev_err_probe();

I guess ^^ is a typo? Since devm_mbox_controller_register wouldn't
return -EPROBE_DEFER.

> 
>> +       }
>> +
>> +       platform_set_drvdata(pdev, cpucp);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_cpucp_mbox_remove(struct platform_device *pdev)
>> +{
>> +       struct qcom_cpucp_mbox *cpucp = platform_get_drvdata(pdev);
>> +
>> +       mbox_controller_unregister(&cpucp->mbox);
>  > This will be replaced by devm_mbox_controller_register().

ack

> 
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id qcom_cpucp_mbox_of_match[] = {
>> +       { .compatible = "qcom,x1e80100-cpucp-mbox"},
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_cpucp_mbox_of_match);
>> +
>> +static struct platform_driver qcom_cpucp_mbox_driver = {
>> +       .probe = qcom_cpucp_mbox_probe,
>> +       .remove = qcom_cpucp_mbox_remove,
>> +       .driver = {
>> +               .name = "qcom_cpucp_mbox",
>> +               .of_match_table = qcom_cpucp_mbox_of_match,
>> +               .suppress_bind_attrs = true,
> 
> No need to. Please drop.

ack

-Sibi

> 
>> +       },
>> +};
>> +module_platform_driver(qcom_cpucp_mbox_driver);
>> +
>> +MODULE_DESCRIPTION("QTI CPUCP MBOX Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.34.1
>>
>>
> 
> 

