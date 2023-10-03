Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1127B6EA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbjJCQel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjJCQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:34:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5CAF;
        Tue,  3 Oct 2023 09:34:37 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393Erddk013142;
        Tue, 3 Oct 2023 16:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FF73pH/SYbmbjDDOjovosivE4VxvLNDlhTfVVV+K1bM=;
 b=B7bHcW7RReBs1ljd7qMkUPf9w6CBSvDNz93NOjt9t9BNJJteUMM4WuByNLMCKQYgTkWc
 Z68I1dE8jSXy5sLmxFdDc/tZ6zE6l2Vz8ucaTSSXzMleB5RE26AlU6xa6W9ykPJmA4oC
 b3vEU0GjDaFjKhP7EztMl4nkp5YqWdV0TUwfTA3OUxL+kxpHPo38mu93J+j1dvVNSTNo
 L9pnWNYrZBrEl7WkAbZ+wxLv1/hj6p0lril4sYH+XMrB46p0WGhPYVXJBycoGqs07ddY
 zT/b4+N7717LCB7J2XgOP1LU1eOPyuh5Fn5coJtdurjNikHp7kFdD5L/ICvwWhSj1i6O bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg98rhx6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 16:34:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393GY50m030027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 16:34:05 GMT
Received: from [10.216.32.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 3 Oct
 2023 09:33:55 -0700
Message-ID: <a44fcc7b-0a79-4755-87a1-1d1704fd3e58@quicinc.com>
Date:   Tue, 3 Oct 2023 22:03:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] phy: qcom: Introduce Super-Speed USB UNIPHY driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
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
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <CAA8EJprhQz_Tj0Bhv6zhGa7h37Ug-Fp6Tof9tNscTFyZzkbJvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KukSnE5ys9HRpl3qozM40BtNCj8Gai-o
X-Proofpoint-GUID: KukSnE5ys9HRpl3qozM40BtNCj8Gai-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=554 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030125
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2023 8:24 PM, Dmitry Baryshkov wrote:
> On Tue, 3 Oct 2023 at 17:22, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>>
>>
>> On 9/30/2023 10:48 PM, Dmitry Baryshkov wrote:
>>> On 29/09/2023 11:42, Praveenkumar I wrote:
>>>> Adds Qualcomm 22ull Super-Speed USB UNIPHY driver support which
>>>> is present in Qualcomm IPQ5332 SoC. This PHY is interfaced with
>>>> SNPS DWC3 USB and SNPS DWC PCIe. Either one of the interface
>>>> can use the it and selection is done via mux present in TCSR
>>>> register. This driver selects the PHY for DWC3 USB and handles
>>>> the reset, clocks and regulator.
>>>>
>>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>> ---
>>>>    drivers/phy/qualcomm/Kconfig               |  11 +
>>>>    drivers/phy/qualcomm/Makefile              |   1 +
>>>>    drivers/phy/qualcomm/phy-qcom-uniphy-usb.c | 322 +++++++++++++++++++++
>>>>    3 files changed, 334 insertions(+)
>>>>    create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>>>>
>>>> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
>>>> index d891058b7c39..7257c8455c53 100644
>>>> --- a/drivers/phy/qualcomm/Kconfig
>>>> +++ b/drivers/phy/qualcomm/Kconfig
>>>> @@ -154,6 +154,17 @@ config PHY_QCOM_M31_USB
>>>>          management. This driver is required even for peripheral only or
>>>>          host only mode configurations.
>>>>    +config PHY_QCOM_UNIPHY_USB
>>>> +    tristate "Qualcomm USB Super-Speed UNIPHY driver"
>>> Can we please have more specific driver name? As I wrote earlier,
>>> there are two other (different) kinds of Qualcomm UNI PHY devices:
>>> - DSI / HDMI UNIPHY on apq8064 / msm8974 / msm8960 (?)
>>> - USB QMP UNI PHY drivers
>>>
>>> Adding a driver called UNIPHY, which is not related to those two kinds
>>> sounds pretty confusing to me.
>> This UNIPHY is different from above mentioned ones. This a custom
>> version for 22nm on Qualcomm IPQ5332.
>> Can we name the driver as phy-qcom-uniphy-usb-ss-22ull.c /
>> phy-qcom-usb-ss-22ull.c ?
> usb-ss-22ull sounds better. Or maybe usb-ipq-ss
Sure, will rename it to phy-qcom-usb-ss-22ull.c
>
>>>> +    depends on USB && (ARCH_QCOM || COMPILE_TEST)
>>>> +    select GENERIC_PHY
>>>> +    help
>>>> +      Enable this to support the Qualcomm USB Super-Speed UNIPHY
>>>> transceiver
>>>> +      with DWC3 USB core. It handles PHY initialization, clock
>>>> +      management required after resetting the hardware and power
>>>> +      management. This driver is required even for peripheral only or
>>>> +      host only mode configurations.
>>>> +
>>>>    config PHY_QCOM_USB_HS
>>>>        tristate "Qualcomm USB HS PHY module"
>>>>        depends on USB_ULPI_BUS
>>>> diff --git a/drivers/phy/qualcomm/Makefile
>>>> b/drivers/phy/qualcomm/Makefile
>>>> index ffd609ac6233..c3e0112a7a70 100644
>>>> --- a/drivers/phy/qualcomm/Makefile
>>>> +++ b/drivers/phy/qualcomm/Makefile
>>>> @@ -17,6 +17,7 @@ obj-$(CONFIG_PHY_QCOM_QMP_USB_LEGACY)    +=
>>>> phy-qcom-qmp-usb-legacy.o
>>>>    obj-$(CONFIG_PHY_QCOM_QUSB2)        += phy-qcom-qusb2.o
>>>>    obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)    += phy-qcom-snps-eusb2.o
>>>>    obj-$(CONFIG_PHY_QCOM_EUSB2_REPEATER)    += phy-qcom-eusb2-repeater.o
>>>> +obj-$(CONFIG_PHY_QCOM_UNIPHY_USB)    += phy-qcom-uniphy-usb.o
>>>>    obj-$(CONFIG_PHY_QCOM_USB_HS)         += phy-qcom-usb-hs.o
>>>>    obj-$(CONFIG_PHY_QCOM_USB_HSIC)     += phy-qcom-usb-hsic.o
>>>>    obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)    += phy-qcom-usb-hs-28nm.o
>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>>>> b/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>>>> new file mode 100644
>>>> index 000000000000..fdfc9c225995
>>>> --- /dev/null
>>>> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy-usb.c
>>> So, is it a USB PHY or UNI PHY (where I would expect that it handles
>>> USB and PCIe?)
>> It is a USB PHY and the PHY name is UNIPHY. Added the usb in the file
>> name to differentiate it.
--
Thanks,
Praveenkumar
