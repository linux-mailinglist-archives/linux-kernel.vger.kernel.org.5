Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228AD7E02A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbjKCMOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbjKCMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:14:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7A1123;
        Fri,  3 Nov 2023 05:14:03 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3AxT8O028056;
        Fri, 3 Nov 2023 12:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=46A8X1eP2WUVzUclJZb6kwAOpw9cdJyQ7xhfMFXTtpI=;
 b=n2JYyDB0uA1jEpZte4SSsLHsu8VaV6zwq5pv9X6isD/+eiOms4ks2/SIgrhAfEyM+Mb7
 lgYJ5uIU3U54M6ZZFPbnH0PDzt2ZGS8l1nsBRKE8Sk+L0tF0o8MQ7Z5NST7R/HT8vqf7
 bdEW/3bwsj4pJdLg53dYYRyF3puDbSmBbTd6U/752h+e2Ut66wev68Yim9LJbqGHr+kU
 kjiHiqebXXVdh1o2Tei7FSfiZuqRx6PjvODz8r/8MICNykREDu1hcOFAtC6ZfRqOvIq/
 u8VTuCa7anFnBaJedgo7Sv++RMiNcWLO2oEwPMyYAhJCrIfmvJR8wjSfg0iFBas7Satp HA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4yk0r4hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 12:13:37 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3CDaWh027723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 12:13:36 GMT
Received: from [10.216.26.1] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 05:13:30 -0700
Message-ID: <99036bf8-ae62-5f25-fef4-6eb05d42f4af@quicinc.com>
Date:   Fri, 3 Nov 2023 17:43:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 4/5] spi: qpic: Add support for qpic spi nand driver
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
 <20231031120307.1600689-5-quic_mdalam@quicinc.com>
 <691607ce-ed05-4fd8-9989-ebd58f2e1664@linaro.org>
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <691607ce-ed05-4fd8-9989-ebd58f2e1664@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uZH-wH5qIg5B4Fu3Ppk4OaLQ38eHave5
X-Proofpoint-GUID: uZH-wH5qIg5B4Fu3Ppk4OaLQ38eHave5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=930 bulkscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030102
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2023 10:43 PM, Krzysztof Kozlowski wrote:
> On 31/10/2023 13:03, Md Sadre Alam wrote:
>> Add qpic spi nand driver support for qcom soc.
> 
> What is "qcom soc"? Did you mean Qualcomm and SoC?

Yes Qualcomm SoC

> 
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> ---
>>   drivers/spi/Kconfig          |   7 +
>>   drivers/spi/Makefile         |   1 +
>>   drivers/spi/spi-qpic-snand.c | 604 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 612 insertions(+)
>>   create mode 100644 drivers/spi/spi-qpic-snand.c
>>
> 
> ...
> 
>> +
>> +static int qcom_snand_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
>> +	spi_unregister_master(ctlr);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct qcom_nandc_props ipq9574_snandc_props = {
>> +	.dev_cmd_reg_start = 0x7000,
>> +	.is_bam = true,
>> +	.qpic_v2 = true,
>> +};
>> +
>> +static const struct of_device_id qcom_snandc_of_match[] = {
>> +	{
>> +		.compatible = "qcom,ipq9574-nand",
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.

Ok
> 
> Best regards,
> Krzysztof
> 
