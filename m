Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F597BDBA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346429AbjJIMXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346492AbjJIMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:23:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EF0B6;
        Mon,  9 Oct 2023 05:23:00 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399CCcB0028812;
        Mon, 9 Oct 2023 12:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=suP35r1I9Tl7Cfr9eTF8H/MOSNej0t7TcjZBQBeGero=;
 b=iknY5SyQ1Ak+PDP/eh9dd1stRLx0L9lD8X9l0s0usw0t1Qfw9s88KR2S40Qjr+PIRVzT
 ma+qb2Rg1gTgUBYXlL1+bcEwjjIfAKqrki4wfaAc0Q//SZ1ubce8KMdQ0g4s3lR1Vb1g
 6DXkBmST4ZbkKrpuS5odle3BApIPOl0PuJZL9JCQnRblx67OtnhB5Su35ddZqpj2ODDD
 ae5CMk7NVheCRyOrFtPnmum6Da1yJqU/cxYpnW9okj/hMfw34Wk2/saH93CVNIuS6rNt
 XixhNe+bw6J68ooO6tsTz/Tilp4XMqwub8nsv8Z7WI5RzHeuP8dzR5F1LYCxoul8/apF kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkhx2jb92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 12:22:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399CMKRB017690
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 12:22:20 GMT
Received: from [10.216.45.67] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 9 Oct
 2023 05:22:11 -0700
Message-ID: <55435a32-1c3f-479b-b257-a190ef3fc7cb@quicinc.com>
Date:   Mon, 9 Oct 2023 17:52:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] phy: qcom: Introduce Super-Speed USB UNIPHY driver
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_kathirav@quicinc.com>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-3-quic_ipkumar@quicinc.com>
 <412492d1-fcc9-481c-9d28-b208a644ba1d@linaro.org>
 <7975c638-29cf-45ce-9d76-b8a93d750eb7@quicinc.com>
 <CAA8EJprhQz_Tj0Bhv6zhGa7h37Ug-Fp6Tof9tNscTFyZzkbJvw@mail.gmail.com>
 <0007b5ff-34d4-44c0-80bd-8277d5842c01@linaro.org>
Content-Language: en-US
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <0007b5ff-34d4-44c0-80bd-8277d5842c01@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lslQH4pSDAP-WMR6p4dijFZIEMlxgnM5
X-Proofpoint-ORIG-GUID: lslQH4pSDAP-WMR6p4dijFZIEMlxgnM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=380
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2023 5:27 AM, Konrad Dybcio wrote:
> On 3.10.2023 16:54, Dmitry Baryshkov wrote:
>> On Tue, 3 Oct 2023 at 17:22, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>>>
>>>
>>> On 9/30/2023 10:48 PM, Dmitry Baryshkov wrote:
>>>> On 29/09/2023 11:42, Praveenkumar I wrote:
>>>>> Adds Qualcomm 22ull Super-Speed USB UNIPHY driver support which
>>>>> is present in Qualcomm IPQ5332 SoC. This PHY is interfaced with
>>>>> SNPS DWC3 USB and SNPS DWC PCIe. Either one of the interface
>>>>> can use the it and selection is done via mux present in TCSR
>>>>> register. This driver selects the PHY for DWC3 USB and handles
>>>>> the reset, clocks and regulator.
>>>>>
>>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>>> ---
>>>>>    drivers/phy/qualcomm/Kconfig               |  11 +
>>>>>    drivers/phy/qualcomm/Makefile              |   1 +
>>>>>    drivers/phy/qualcomm/phy-qcom-uniphy-usb.c | 322 +++++++++++++++++++++
>>>>>    3 files changed, 334 insertions(+)
>>>>>    create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>>>>>
>>>>> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
>>>>> index d891058b7c39..7257c8455c53 100644
>>>>> --- a/drivers/phy/qualcomm/Kconfig
>>>>> +++ b/drivers/phy/qualcomm/Kconfig
>>>>> @@ -154,6 +154,17 @@ config PHY_QCOM_M31_USB
>>>>>          management. This driver is required even for peripheral only or
>>>>>          host only mode configurations.
>>>>>    +config PHY_QCOM_UNIPHY_USB
>>>>> +    tristate "Qualcomm USB Super-Speed UNIPHY driver"
>>>> Can we please have more specific driver name? As I wrote earlier,
>>>> there are two other (different) kinds of Qualcomm UNI PHY devices:
>>>> - DSI / HDMI UNIPHY on apq8064 / msm8974 / msm8960 (?)
>>>> - USB QMP UNI PHY drivers
>>>>
>>>> Adding a driver called UNIPHY, which is not related to those two kinds
>>>> sounds pretty confusing to me.
>>> This UNIPHY is different from above mentioned ones. This a custom
>>> version for 22nm on Qualcomm IPQ5332.
>>> Can we name the driver as phy-qcom-uniphy-usb-ss-22ull.c /
>>> phy-qcom-usb-ss-22ull.c ?
>> usb-ss-22ull sounds better. Or maybe usb-ipq-ss
> usb-ipq-ss is as safe as usb-msm-ss
>
> We can not rely on the hardware never ever changing down the
> product line :D
Not all IPQ platforms having this UNIPHY. Only IPQ5332 and IPQ5018 are 
having
this custom version of UNIPHY. Hence thought usb-ipq-ss might confuse.
>
> Konrad
--
Thanks,
Praveenkumar
