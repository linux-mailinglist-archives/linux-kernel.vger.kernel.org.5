Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5D76BCF0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjHAStN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjHAStC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:49:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1B2702;
        Tue,  1 Aug 2023 11:48:53 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371GA6pf001835;
        Tue, 1 Aug 2023 18:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QxwyS3/sNwp0tL3VMiwf7gLqShqkMYpOrrA7vE/7Z1w=;
 b=Q3qmQ5yzh5AuHILxf28Qi44dIhZTqyw07ujaOQHsQCpmxypr2toPDu53/HbBlYK/T49E
 prR9jTE2CEWAFeDkTxhq1Lk5nCeo1j3xqU6WF8pWp2VWN6P82cxOD6KJ1WEM6BUDUqzl
 i8XsXORh8h2JYyR8lqrCsFQNWu79TAzT8dJfGLEjI+Wv3FE68a85gSZU9MTIQzU8rGAG
 llcgcc5mPVg5qr0lKe+qELIkBH/kMXLHhGjltUK8HJGVDjZNQkr+C+MgJOWXiy1zwt91
 0ad9+hVwIff5wXozPSf+rcJKwlhhyhUYoGifMSDXHPNSIs0fCFpHF407xJFpabYOv8ax dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b30avd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 18:48:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371Imcmo012798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 18:48:38 GMT
Received: from [10.110.112.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 1 Aug
 2023 11:48:37 -0700
Message-ID: <6a304661-28df-0868-e222-b0be8dcef00c@quicinc.com>
Date:   Tue, 1 Aug 2023 11:48:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/7] soc: qcom: add QCOM PBS driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
 <20230725193423.25047-4-quic_amelende@quicinc.com>
 <de3b4739-5446-c1ab-571f-a36c4aff5e0f@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <de3b4739-5446-c1ab-571f-a36c4aff5e0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Izg-M7hnepr_H2pzZLxQQyuAIgDT7-dk
X-Proofpoint-ORIG-GUID: Izg-M7hnepr_H2pzZLxQQyuAIgDT7-dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010168
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 8:36 AM, Konrad Dybcio wrote:
> On 25.07.2023 21:34, Anjelique Melendez wrote:
>> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
>> driver supports configuring software PBS trigger events through PBS RAM
>> on Qualcomm Technologies, Inc (QTI) PMICs.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
> [...]
> 
>> +
>> +	u32			base;
>> +};
>> +
>> +static int qcom_pbs_read(struct pbs_dev *pbs, u32 address, u8 *val)
>> +{
>> +	int ret;
>> +
>> +	address += pbs->base;
> Any reason not to just keep the base address in struct pbs_dev and use
> normal regmap r/w helpers?
> 
> [...]

We created the qcom_pbs read/write helpers to limit code duplication when printing
error messages. 
I am ok with calling regmap_bulk_read/write() and regmap_update_bits()
in code instead of these helpers but wondering how everyone would feel with the error messages
either being duplicated or if error messages should just be removed?

qcom_pbs_read() is called twice, qcom_pbs_write() is called twice(), and 
qcom_pbs_masked_write() is called 6 times.
> 
>> +
>> +static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
>> +{
>> +	u16 retries = 2000, delay = 1000;
>> +	int ret;
>> +	u8 val;
>> +
>> +	while (retries--) {
>> +		ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (val == 0xFF) {
> This should be a constant, not a magic value
ack
> 
>> +			/* PBS error - clear SCRATCH2 register */
>> +			ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			dev_err(pbs->dev, "NACK from PBS for bit %u\n", bit_pos);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (val & BIT(bit_pos)) {
>> +			dev_dbg(pbs->dev, "PBS sequence for bit %u executed!\n", bit_pos);
>> +			break;
>> +		}
>> +
>> +		usleep_range(delay, delay + 100);
> So worst case scenario this will wait for over 2 seconds?
Yes, worst case scenario will result in waiting for 2.2 seconds
> 
>> +	}
>> +
>> +	if (!retries) {
>> +		dev_err(pbs->dev, "Timeout for PBS ACK/NACK for bit %u\n", bit_pos);
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
> return 0 instead of break above?
ack
> 
>> +}
>> +
>> +/**
>> + * qcom_pbs_trigger_event() - Trigger the PBS RAM sequence
>> + * @pbs: Pointer to PBS device
>> + * @bitmap: bitmap
>> + *
>> + * This function is used to trigger the PBS RAM sequence to be
>> + * executed by the client driver.
>> + *
>> + * The PBS trigger sequence involves
>> + * 1. setting the PBS sequence bit in PBS_CLIENT_SCRATCH1
>> + * 2. Initiating the SW PBS trigger
>> + * 3. Checking the equivalent bit in PBS_CLIENT_SCRATCH2 for the
>> + *    completion of the sequence.
>> + * 4. If PBS_CLIENT_SCRATCH2 == 0xFF, the PBS sequence failed to execute
>> + *
>> + * Returns: 0 on success, < 0 on failure
>> + */
>> +int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
>> +{
>> +	u8 val, mask;
>> +	u16 bit_pos;
>> +	int ret;
>> +
>> +	if (!bitmap) {
>> +		dev_err(pbs->dev, "Invalid bitmap passed by client\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (IS_ERR_OR_NULL(pbs))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&pbs->lock);
>> +	ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	if (val == 0xFF) {
>> +		/* PBS error - clear SCRATCH2 register */
>> +		ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
>> +		if (ret < 0)
>> +			goto out;
>> +	}
>> +
>> +	for (bit_pos = 0; bit_pos < 8; bit_pos++) {
>> +		if (bitmap & BIT(bit_pos)) {
>> +			/*
>> +			 * Clear the PBS sequence bit position in
>> +			 * PBS_CLIENT_SCRATCH2 mask register.
>> +			 */
> Don't think the "in the X register" parts are useful.
ack
> 
>> +			ret = qcom_pbs_masked_write(pbs, PBS_CLIENT_SCRATCH2, BIT(bit_pos), 0);
>> +			if (ret < 0)
>> +				goto error;
>> +
>> +			/*
>> +			 * Set the PBS sequence bit position in
>> +			 * PBS_CLIENT_SCRATCH1 register.
>> +			 */
>> +			val = mask = BIT(bit_pos);
> You're using mask/val for half the function calls..
> Stick with one approach.
ack
> 
> [...]
> 
>> +struct pbs_dev *get_pbs_client_device(struct device *dev)
>> +{
>> +	struct device_node *pbs_dev_node;
>> +	struct platform_device *pdev;
>> +	struct pbs_dev *pbs;
>> +
>> +	pbs_dev_node = of_parse_phandle(dev->of_node, "qcom,pbs", 0);
>> +	if (!pbs_dev_node) {
>> +		dev_err(dev, "Missing qcom,pbs property\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	pdev = of_find_device_by_node(pbs_dev_node);
>> +	if (!pdev) {
>> +		dev_err(dev, "Unable to find PBS dev_node\n");
>> +		pbs = ERR_PTR(-EPROBE_DEFER);
>> +		goto out;
>> +	}
>> +
>> +	pbs = platform_get_drvdata(pdev);
>> +	if (!pbs) {
> This check seems unnecessary, the PBS driver would have had to fail
> probing if set_drvdata never got called.
> > Konrad
