Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A27E02C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346810AbjKCMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjKCMZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:25:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354BBCE;
        Fri,  3 Nov 2023 05:24:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3C9oVD018300;
        Fri, 3 Nov 2023 12:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3iX5zSAME6yEJ7E/80TetCkqNTN9mTZI1MihvK+yZBs=;
 b=jrpaY5m3+AAP8ph0OfMrxvOP2Os6AL8538lJfH/ssxlVtdtdp34kGYFX+5Ch/GPOiAmL
 y39/DTPv/zXiwTaOjwBMBbExjQvp9CAOvhgOWM4rtFuhn4cUsdallNXw71s6D35c/tqA
 741DRJ8967/5/z3/oMSTp5vr8BbKQl4qDSXEKT4qj71O/MU+WjCmMMIv0U/+SJbVaUpW
 oZc9/UpG3dxCffqQqyMaWOMHuQqIrMwOl7Snsvun1cpXdMWYV5m4CNVHsU6Ks4P0VwRc
 fvbWq0pKyx4JjnsfwB66nH1behpO+f0VENVEVDUEM8cSUwmwZa6CGD8H9lrr9tyq4X8h KA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u47d5337n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 12:24:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3COfW5031421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 12:24:41 GMT
Received: from [10.201.203.219] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 05:24:35 -0700
Message-ID: <553c1373-c9a0-b2af-2286-058824e31bad@quicinc.com>
Date:   Fri, 3 Nov 2023 17:54:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/5] mtd: nand: ecc-qcom: Add support for ECC Engine
 Driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <qpic_varada@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
 <20231031120307.1600689-2-quic_mdalam@quicinc.com>
 <b9af01d2-1a86-4b41-9bd6-3bf7a0dde1c0@linaro.org>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <b9af01d2-1a86-4b41-9bd6-3bf7a0dde1c0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gAmE5KsgDX63mYcZ97cBJ87Lcdo6qxmx
X-Proofpoint-ORIG-GUID: gAmE5KsgDX63mYcZ97cBJ87Lcdo6qxmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030103
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2023 10:41 PM, Krzysztof Kozlowski wrote:
> On 31/10/2023 13:03, Md Sadre Alam wrote:
> 
> Eh? Empty?

QPIC controller has the ecc pipelined so will keep the ecc support
inlined in both raw nand and serial nand driver.

Droping this driver since device node was NAK-ed
https://www.spinics.net/lists/linux-arm-msm/msg177596.html
> 
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> ---
>>   drivers/mtd/nand/Kconfig    |   7 ++
>>   drivers/mtd/nand/Makefile   |   1 +
>>   drivers/mtd/nand/ecc-qcom.c | 198 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 206 insertions(+)
>>   create mode 100644 drivers/mtd/nand/ecc-qcom.c
>>
> 
> ...
> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(qcom_ecc_config);
>> +
>> +void qcom_ecc_enable(struct qcom_ecc *ecc)
>> +{
>> +	ecc->use_ecc = true;
>> +}
>> +EXPORT_SYMBOL(qcom_ecc_enable);
> 
> Drop this and all other exports. Nothing here explains the need for them.
> 
>> +
>> +void qcom_ecc_disable(struct qcom_ecc *ecc)
>> +{
>> +	ecc->use_ecc = false;
>> +}
>> +EXPORT_SYMBOL(qcom_ecc_disable);
>> +
>> +static const struct of_device_id qpic_ecc_dt_match[] = {
>> +	{
>> +		.compatible = "qcom,ipq9574-ecc",
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
> Checkpatch is preerquisite. Don't send patches which have obvious issues
> pointed out by checkpatch. It's a waste of reviewers time.
> 
>> +	},
>> +	{},
>> +};
>> +
>> +static int qpic_ecc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct qpic_ecc *ecc;
>> +	u32 max_eccdata_size;
>> +
>> +	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
>> +	if (!ecc)
>> +		return -ENOMEM;
>> +
>> +	ecc->caps = of_device_get_match_data(dev);
>> +
>> +	ecc->dev = dev;
>> +	platform_set_drvdata(pdev, ecc);
>> +	dev_info(dev, "probed\n");
> 
> No, no such messages.
> 
> 
> 
> Best regards,
> Krzysztof
> 
