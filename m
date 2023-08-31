Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF3878EE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbjHaNJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjHaNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:09:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A131A4;
        Thu, 31 Aug 2023 06:09:08 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VCeiMC027349;
        Thu, 31 Aug 2023 13:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OwzPjGSLhqM1CWMZJdC21er6tHXS2yZCDBB1mbhXGA0=;
 b=X/pyhYC9ho/T+ZALC+tXk/X9xREEDCZ3quHyTtYFR+j/GilEHV0T1yPg3fIxPneYtjz6
 rUoW2Ec9riIvn/1YGP6juSaFwS9FIHyfcFre9A5JpRs9Xf3od3BODwvVlbTae2SVoVzn
 AwMMHai3DUfPXKdbSGFVQrzL1lAThD/5y2ypDdx8kWWSzBLXiUuLAQR8owQr4K+Yc+X6
 KZBlmEzjtF6U3VtckGZ6lS4i7Y6lgpet9YMLBAtn9QYKYIcSZax78sajTuCJ2VPVv9N8
 4KqNTvO54hBdzaF1+lZ7DZKKhQsG324/erE8pRH01HMaOKBXSEWthBH+jpOE5urYz2hY dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3str1ngehn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 13:08:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VD8Bvp008094
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 13:08:11 GMT
Received: from [10.201.3.91] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 31 Aug
 2023 06:08:04 -0700
Message-ID: <36103bcd-fd4e-4a1a-b65e-238f6b63544c@quicinc.com>
Date:   Thu, 31 Aug 2023 18:38:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] phy: qcom: uniphy: Rename ipq4019 USB phy driver to
 UNIPHY driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-3-quic_ipkumar@quicinc.com>
 <d30742d6-7fe2-c5fe-ac42-86642acc076e@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <d30742d6-7fe2-c5fe-ac42-86642acc076e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dJH7yNdDb4WX9KE1xtrsPdKLIgklPI7U
X-Proofpoint-ORIG-GUID: dJH7yNdDb4WX9KE1xtrsPdKLIgklPI7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=993 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/2023 10:25 PM, Krzysztof Kozlowski wrote:
> On 29/08/2023 15:58, Praveenkumar I wrote:
>> UNIPHY / Combo PHY used on various qualcomm SoC's are very similar to
>> ipq4019 PHY. Hence renaming this driver to uniphy driver and can be
>> used for other SoC's which are having the similar UNIPHY.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   MAINTAINERS                                                | 7 ++++---
>>   drivers/phy/qualcomm/Kconfig                               | 7 ++++---
>>   drivers/phy/qualcomm/Makefile                              | 2 +-
>>   .../qualcomm/{phy-qcom-ipq4019-usb.c => phy-qcom-uniphy.c} | 0
>>   4 files changed, 9 insertions(+), 7 deletions(-)
>>   rename drivers/phy/qualcomm/{phy-qcom-ipq4019-usb.c => phy-qcom-uniphy.c} (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ff1f273b4f36..7f4553c1a69a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17774,13 +17774,14 @@ F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
>>   F:	drivers/mailbox/qcom-ipcc.c
>>   F:	include/dt-bindings/mailbox/qcom-ipcc.h
>>   
>> -QUALCOMM IPQ4019 USB PHY DRIVER
>> +QUALCOMM UNIPHY DRIVER
>>   M:	Robert Marko <robert.marko@sartura.hr>
>>   M:	Luka Perkov <luka.perkov@sartura.hr>
>> +M:	Praveenkumar I <quic_ipkumar@quicinc.com>
>>   L:	linux-arm-msm@vger.kernel.org
>>   S:	Maintained
>> -F:	Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
>> -F:	drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
>> +F:	Documentation/devicetree/bindings/phy/qcom,uniphy.yaml
> You broke the path in your previous commit, but anyway this will go away.
>
>> +F:	drivers/phy/qualcomm/phy-qcom-uniphy.c
>>   
>>   QUALCOMM IPQ4019 VQMMC REGULATOR DRIVER
>>   M:	Robert Marko <robert.marko@sartura.hr>
>> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
>> index d891058b7c39..e6981bc212b3 100644
>> --- a/drivers/phy/qualcomm/Kconfig
>> +++ b/drivers/phy/qualcomm/Kconfig
>> @@ -28,12 +28,13 @@ config PHY_QCOM_EDP
>>   	  Enable this driver to support the Qualcomm eDP PHY found in various
>>   	  Qualcomm chipsets.
>>   
>> -config PHY_QCOM_IPQ4019_USB
>> -	tristate "Qualcomm IPQ4019 USB PHY driver"
>> +config PHY_QCOM_UNIPHY
>> +	tristate "Qualcomm UNIPHY driver"
>>   	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>>   	select GENERIC_PHY
>>   	help
>> -	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
>> +	  Enable this driver to support the Qualcomm UNIPHY found in various
>> +	  Qualcomm chipsets.
> I don't quite get why this is renamed, either. Just because you re-use
> it? Re-usage is not affected with old name...
Understood. As suggested by Dmitry Baryshkov, will add new driver for 
Qualcomm IPQ5332 USB Gen3
PHY driver.

- Praveenkumar
>
> Best regards,
> Krzysztof
>
