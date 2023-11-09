Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CD77E63A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKIGSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKIGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:18:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B0926A9;
        Wed,  8 Nov 2023 22:18:13 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A96G35Y001445;
        Thu, 9 Nov 2023 06:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+UazTuebt/gafleKH0mZXxsLU+Kiwi4+2tiVxlTgWh0=;
 b=k2TPDRoYTcrYKs0ITuO7cbcXT9atyvze99Du1DDIrAR1nbb/RsHP1qHyXix9Ws26RZ+D
 6tZURgBmF27b2oMVefTn2CLwU7X5feyHyVgA/SEZnhdlYBA4+44uqCI+T2dtbK+EEdMr
 ZkRXb/5KGFCu9+H5u6npOAQLO2r5DRw2h63+6J6oyc862/keaU8jaCrflEZY9oj2TBz3
 QGmCBQt3CO1Mh81f5HnVlzMgkAxehbUiVjmHn+FCBgxU9TxxEYFYLUJmYsLGCqzgBED6
 5DJek1Jegr7lSX88dOCIHK/KSbvLrue9ApdrFrxftR2iAWchSEuCvIefecK6ROsAjJ08 aw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8s0885g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 06:17:56 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A96HuDW025629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 06:17:56 GMT
Received: from [10.239.133.9] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 22:17:51 -0800
Message-ID: <a9c6e292-37be-6e01-6520-f45ae7d8b09a@quicinc.com>
Date:   Thu, 9 Nov 2023 14:17:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] coresight: Add remote etm support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>
References: <20231107060939.13449-1-quic_jinlmao@quicinc.com>
 <20231107060939.13449-2-quic_jinlmao@quicinc.com>
 <3bc959e4-9308-4827-ae6d-2ec6fc47d946@linaro.org>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <3bc959e4-9308-4827-ae6d-2ec6fc47d946@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fuo2L-wIxvTS0ehns18vcb7a3O6cSGnk
X-Proofpoint-ORIG-GUID: fuo2L-wIxvTS0ehns18vcb7a3O6cSGnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_04,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/7/2023 11:26 PM, Krzysztof Kozlowski wrote:
> On 07/11/2023 07:09, Mao Jinlong wrote:
>> Add support for ETM trace collection on remote processor using
>> coreSight framework.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig           |   9 +
>>   drivers/hwtracing/coresight/Makefile          |   1 +
>>   drivers/hwtracing/coresight/coresight-core.c  |   3 +
>>   drivers/hwtracing/coresight/coresight-qmi.h   | 109 ++++++
>>   .../coresight/coresight-remote-etm.c          | 325 ++++++++++++++++++
>>   include/linux/coresight.h                     |   1 +
>>   6 files changed, 448 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/coresight-qmi.h
>>   create mode 100644 drivers/hwtracing/coresight/coresight-remote-etm.c
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 06f0a7594169..425886ab7401 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -247,4 +247,13 @@ config CORESIGHT_DUMMY
>>   
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called coresight-dummy.
>> +
>> +config CORESIGHT_REMOTE_ETM
>> +	tristate "Remote processor ETM trace support"
>> +	select QCOM_QMI_HELPERS
>> +	help
>> +	  Enables support for ETM trace collection on remote processor using
>> +	  CoreSight framework. Enabling this will allow turning on ETM
>> +	  tracing on remote processor via sysfs by configuring the required
>> +	  CoreSight components.
>>   endif
.....
>> +}
>> +
>> +static const struct of_device_id remote_etm_match[] = {
>> +	{.compatible = "qcom,coresight-remote-etm"},
> Please order your patches correctly, so binding is documented before the
> users.
>
>> +	{}
>> +};
>> +
>> +static struct platform_driver remote_etm_driver = {
>> +	.probe          = remote_etm_probe,
>> +	.remove         = remote_etm_remove,
>> +	.driver         = {
>> +		.name   = "coresight-remote-etm",
>> +		.of_match_table = remote_etm_match,
>> +	},
>> +};
>> +
>> +int __init remote_etm_init(void)
>> +{
>> +	return platform_driver_register(&remote_etm_driver);
>> +}
>> +module_init(remote_etm_init);
>> +
>> +void __exit remote_etm_exit(void)
>> +{
>> +	platform_driver_unregister(&remote_etm_driver);
>> +}
>> +module_exit(remote_etm_exit);
> Why aren't you using module platform driver?
>
> Best regards,
> Krzysztof

Thanks for the review. I will check and address your comments.

Thanks
Jinlong Mao

>
