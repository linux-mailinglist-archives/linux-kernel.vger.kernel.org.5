Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A67779E61
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjHLI6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLI6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:58:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82160E60;
        Sat, 12 Aug 2023 01:58:50 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37C8llZe031769;
        Sat, 12 Aug 2023 08:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vZrd4GhN7Po0SDO1OgCjvzNqp2VIJZDaDCDq4Shgwoo=;
 b=igsTdzAIFcLKVsZBUHVTjRANohGiYcbqyab20+hVAMF7jOk40rZi4ds70/FOl70gsuxH
 lePWuHTdw8+DAzm6vh2Z0jARwUvGUVb+pdKHZYz4kVfEcekIBmMWGmueZaDZn90boP1B
 NpHHX79BW7B3PPjrNIeOHqUlfjZytcL5xrlSiKWa2GW8qSMNAP8zv9M5CEn1U+adS9jl
 NuTm0rGbjTtM97VuI3jd2c3DDTuOF9eDdaZxKKCVGeX25cZD1hqLHMxoSY2d7nB1vFSs
 78YwW3blp7zfMhSTsMq8FsWnnYrWPiqR14HA/y+KRvHsuUUKKiqAFfxUy4WcDQIEJmwy gA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3mt06vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 08:58:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37C8wWUD000929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 08:58:32 GMT
Received: from [10.216.24.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 12 Aug
 2023 01:58:26 -0700
Message-ID: <3c1a9e91-d49a-b191-4f3c-506fe41ea343@quicinc.com>
Date:   Sat, 12 Aug 2023 14:28:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
 <ZJsDpqttBYtbQ0yg@hovoldconsulting.com>
 <26ae15d1-4e13-3ab7-6844-3a7d3ed03af4@quicinc.com>
 <ZLEOk-9VImJNHYHa@hovoldconsulting.com>
 <f02104c0-d177-0e4e-dcb0-ffca589c8b00@quicinc.com>
 <ZLppB67LyWk1kD8w@hovoldconsulting.com>
 <ea41e06c-bd2a-e375-4e7c-8cff85d29627@linaro.org>
 <ZLqAHyD5HH6Ka5pl@hovoldconsulting.com>
 <dd622171-a4d3-4143-9e8a-f5a47d3e7916@linaro.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <dd622171-a4d3-4143-9e8a-f5a47d3e7916@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K3bohqmYqcvvVu6ynYL486F_dmSVTPK0
X-Proofpoint-ORIG-GUID: K3bohqmYqcvvVu6ynYL486F_dmSVTPK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308120082
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2023 10:18 PM, Konrad Dybcio wrote:
> On 21.07.2023 14:54, Johan Hovold wrote:
>> On Fri, Jul 21, 2023 at 02:10:07PM +0200, Konrad Dybcio wrote:
>>> On 21.07.2023 13:16, Johan Hovold wrote:
>>>> On Fri, Jul 14, 2023 at 04:08:45PM +0530, Krishna Kurapati PSSNV wrote:
>>>>> On 7/14/2023 2:30 PM, Johan Hovold wrote:
>>>>>> On Mon, Jul 03, 2023 at 12:35:48AM +0530, Krishna Kurapati PSSNV wrote:
>>>>>>> On 6/27/2023 9:13 PM, Johan Hovold wrote:
>>>>>>>> On Wed, Jun 07, 2023 at 02:16:37PM +0200, Johan Hovold wrote:
>>>>>>>>> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:
>>>>>>
>>>>>>>>>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>>>>>>>>>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>>>>>>>>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
>>>>>>>>>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>>>>>>>>>> +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
>>>>>>>>>> +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>>>>>>>>> +			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
>>>>>>>>>> +	}
>>>>>>>>
>>>>>>>>> When testing this on the X13s I get:
>>>>>>>>>
>>>>>>>>> 	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2
>>
>>> Sidenote, I get this on any Qcom device on any platform I try
>>> to enter suspend on, without these MP patches.
>>
>> Ok, that might provide some hint. But on sc8280xp (X13s) we only get it
>> on one of the four MP ports (i.e. on one out of six ports in total).
>>
>> While on sa8295p-adp there are no such errors on any port.
> I've been playing with 8450 and it looks like snps,dis_u2_susphy_quirk
> causes this error.
> 
> The downstream tree contains this property and I'm inclined to believe
> it means that this platforms should define it (as the devicetrees are
> machine-generated to a degree, AFAIK), especially since this quirk does
> the exact same thing on a known-working downstream, namely unsetting
> DWC3_GUSB2PHYCFG_SUSPHY.
> 
> Digging a bit deeper, dwc3-msm-core [1], the downstream version of dwc3-qcom
> performs a bit of a dance in a couple of places.. Look for that register name.
> 
> Unfortunately I have little idea what the "USB2 suspend phy" is.. is it a PHY
> used in suspend? Is it the suspension of the USB2 PHY? No clue.
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/blob/KERNEL.PLATFORM.1.0.r2-08800-WAIPIOLE.0/drivers/usb/dwc3/dwc3-msm-core.c
> 

The description for that bit (BIT(6)) as per the databook is as follows:

---

6 SUSPENDUSB20 R_W Suspend USB2.0 HS/FS/LS PHY (SusPHY)
When set, USB2.0 PHY enters Suspend mode if Suspend
conditions are valid.

For DRD/OTG configurations, it is recommended that this bit is set
to 0 during coreConsultant configuration. If it is set to 1, then the
application must clear this bit after power-on reset. Application
needs to set it to 1 after the core initialization completes.
For all other configurations, this bit can be set to 1 during core
configuration.

Note:
■ In host mode, on reset, this bit is set to 1. Software can override
this bit after reset.
■ In device mode, before issuing any device endpoint command

when operating in 2.0 speeds, disable this bit and enable it after
the command completes. If you issue a command without
disabling this bit when the device is in L2 state and if mac2_clk
(utmi_clk/ulpi_clk) is gated off, the command will not get
completed

---

"L2" is the term we say when PHY is suspended, i.e., the main PLL is 
shut off. Internally, I was able to find out that there are several 
conditions where phy can fail to enter L2. The entry into L2 is 
controlled by the USB controller itself, but can be limited by toggling 
GUSB2PHY SUSPENDABLE bit.  if that bit is 0 then controller won't place 
HSPHY into L2. For the failure to enter L2, there can be several 
situations, like there may be some pending line state change that 
happened on the bus.

But Johan's error seems to be different as the register itself reads 
zero which I don't understand.

Regards,
Krishna,
