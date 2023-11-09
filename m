Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74CA7E63AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjKIGUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKIGUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:20:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A89A4;
        Wed,  8 Nov 2023 22:20:03 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A96F2Fg030849;
        Thu, 9 Nov 2023 06:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=o6WFDsYVLdv/n5kPtsDAkcnUc1GRBkPe5QQGlolDK88=;
 b=nb8jKAT7snJZdn1rTKxZdLCrx2yagf/amaHtQX4Qfee4el4wHiVbJsefIVtDSP0swdVh
 iOcBl52ga37yU2pOaH4S0/rLIhylWYQu3mdjNGr4ekGm6j8f3iTE9laWAEPgI6Eb0WN8
 IsheiV0iAoeA319VeMJ+sHdG3AiO1/UNuSKLW+KRymnO99U41WMo2nodraW7Lz88UoYr
 4Bb5HGQzuTu9rtPaxL602ZPCtgchRp+Ym9+/07Epz05TEPzOM/XWfw2opXG6xC2qsPhw
 /8pl1UsEAJzEQ7UzguB9at0YE+5cyPRT98mwUhQQgLO+65ShjeDr6RCnFQoB5weBTmvB rA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8s0885mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 06:19:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A96JsQF028324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 06:19:54 GMT
Received: from [10.239.133.9] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 22:19:50 -0800
Message-ID: <d59bd2c4-5730-a4c4-7b82-07ce564ae84c@quicinc.com>
Date:   Thu, 9 Nov 2023 14:19:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] coresight: Add remote etm support
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20231107060939.13449-1-quic_jinlmao@quicinc.com>
 <20231107060939.13449-2-quic_jinlmao@quicinc.com>
 <d396d9ba-9574-8f11-8bbb-d1fd939421c5@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <d396d9ba-9574-8f11-8bbb-d1fd939421c5@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VjY_-4w8KGhmRAuyOfByjDGBklUm9DZT
X-Proofpoint-ORIG-GUID: VjY_-4w8KGhmRAuyOfByjDGBklUm9DZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_04,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/2023 7:19 PM, James Clark wrote:
>
> On 07/11/2023 06:09, Mao Jinlong wrote:
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
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index 995d3b2c76df..a5283cab0bc0 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -29,5 +29,6 @@ obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>>   obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>>   		   coresight-cti-sysfs.o
>> +obj-$(CONFIG_CORESIGHT_REMOTE_ETM) += coresight-remote-etm.o
>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>>   obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index d7f0e231feb9..f365a3899821 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1094,6 +1094,7 @@ static int coresight_validate_source(struct coresight_device *csdev,
>>   	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>>   	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>>   	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
>> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC &&
......
> +{
> +	return platform_driver_register(&remote_etm_driver);
> +}
> +module_init(remote_etm_init);
> +
> +void __exit remote_etm_exit(void)
> +{
> +	platform_driver_unregister(&remote_etm_driver);
> +}
> +module_exit(remote_etm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("CoreSight Remote ETM driver");
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index a4cb7dd6ca23..f0a947a61680 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
>   	CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
>   	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
>   	CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM,
> +	CORESIGHT_DEV_SUBTYPE_SOURCE_REMOTE_PROC,
>   	CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS,
>   };
>   
Thanks for the review. I will check the comments and address your 
comments in next version.

Thanks
Jinlong Mao

