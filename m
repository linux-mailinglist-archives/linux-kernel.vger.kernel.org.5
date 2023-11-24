Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69F17F73D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjKXM3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXM3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:29:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51169B6;
        Fri, 24 Nov 2023 04:30:00 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOAmVcP006462;
        Fri, 24 Nov 2023 12:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E+uhhrwE0lBW1HCbABnxn7Q6DvKrVi6bSAwgVFhmrS0=;
 b=fbToO+YzZLMLBUjd+dPCzkgV+3JmgcUezpWyYrx7imjTX5CoCCdL4X8ywuIBrzkkX3DN
 cVQHh9ROjwxvreyHtkTnhYlAbEJO5X/iGo8uLQ2NFdsMDsW48pL8a2ujy2XTZ5JYQoIV
 +jtx/JFMUJpt3KZo+OcVihMzxuySTerCe9iyLRLkgEg6VOijKpAH2mpz5Tqg3RHnPLnn
 ArS6HcGtgr0CI1fO3qr4uIflfO+z/YWx4cqUyEzbfP7A+DRDHoB4VSvmZRQeVOj7T72V
 ijWR7KV2DitfT0VjCRKkEunozZwCLEzvHeXZBBfS1QhyR9i7ekDkpAxRu5ze0yTICxX9 uA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ujtd8g615-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:29:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOCTqr0001683
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 12:29:52 GMT
Received: from [10.216.35.253] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 04:29:46 -0800
Message-ID: <a29123a3-afe1-8f92-ff6c-835926d411af@quicinc.com>
Date:   Fri, 24 Nov 2023 17:59:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: Move video-firmware to
 chrome-common
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com>
 <20231002-sc7280-venus-pas-v2-2-bd2408891317@fairphone.com>
 <4cfad910-1821-3a31-c372-3f6b199e8f71@quicinc.com>
 <CX5ENKY70B5J.2D6DXKGI4EGX3@fairphone.com>
 <ff021f49-f81b-0fd1-bd2c-895dbbb03d56@quicinc.com>
 <CX70EBXCOB66.3998C482R86CN@fairphone.com>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <CX70EBXCOB66.3998C482R86CN@fairphone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ty8QG3gRwUxx8l7l2JZD7PyzeyMM1R1e
X-Proofpoint-GUID: Ty8QG3gRwUxx8l7l2JZD7PyzeyMM1R1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311240097
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/2023 5:05 PM, Luca Weiss wrote:
> On Fri Nov 24, 2023 at 7:38 AM CET, Vikash Garodia wrote:
>>
>> On 11/22/2023 7:50 PM, Luca Weiss wrote:
>>> On Wed Nov 22, 2023 at 2:17 PM CET, Vikash Garodia wrote:
>>>>
>>>> On 10/2/2023 7:50 PM, Luca Weiss wrote:
>>>>> If the video-firmware node is present, the venus driver assumes we're on
>>>>> a system that doesn't use TZ for starting venus, like on ChromeOS
>>>>> devices.
>>>>>
>>>>> Move the video-firmware node to chrome-common.dtsi so we can use venus
>>>>> on a non-ChromeOS devices.
>>>>>
>>>>> At the same time also disable the venus node by default in the dtsi,
>>>>> like it's done on other SoCs.
>>>>>
>>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 8 ++++++++
>>>>>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 6 ++----
>>>>>  2 files changed, 10 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
>>>>> index 5d462ae14ba1..cd491e46666d 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
>>>>> @@ -104,6 +104,14 @@ &scm {
>>>>>  	dma-coherent;
>>>>>  };
>>>>>  
>>>>> +&venus {
>>>>> +	status = "okay";
>>>>> +
>>>>> +	video-firmware {
>>>>> +		iommus = <&apps_smmu 0x21a2 0x0>;
>>>>> +	};
>>>>> +};
>>>>> +
>>>>>  &watchdog {
>>>>>  	status = "okay";
>>>>>  };
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>>> index 66f1eb83cca7..fa53f54d4675 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>>> @@ -3740,6 +3740,8 @@ venus: video-codec@aa00000 {
>>>>>  				 <&apps_smmu 0x2184 0x20>;
>> 0x2184 is a secure SID. I think qcm6490-fairphone-fp5.dts needs to override the
>> iommus property as well to retain only the non secure SID i.e 0x2180 ? I am
>> seeing below crash
>>
>> Call trace:
>> [   47.663593]  qcom_smmu_write_s2cr+0x64/0xa4
>> [   47.663616]  arm_smmu_attach_dev+0x120/0x284
>> [   47.663647]  __iommu_attach_device+0x24/0xf8
>> [   47.676845]  __iommu_device_set_domain+0x70/0xd0
>> [   47.681632]  __iommu_group_set_domain_internal+0x60/0x1b4
>> [   47.687218]  iommu_setup_default_domain+0x358/0x418
>> [   47.692258]  __iommu_probe_device+0x3e4/0x404
>>
>> Could you please reconfirm if Video SID 0x2184 (and mask) is allowed by the
>> qcm6490-fairphone-fp5 hardware having TZ ?
> 
> Hi,
> 
> On FP5 it seems it's no problem to have both SIDs in there, probe and
> using venus appears to work fine.
> 
> Are you using different firmware than QCM6490.LA.3.0 on the device where
> you tested this?
I was testing this on RB3 board which uses firmware [1].

Regards,
Vikash

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/qcom/vpu-2.0

>>
>>>>>  			memory-region = <&video_mem>;
>>>>>  
>>>>> +			status = "disabled";
>>>>> +
>>>>>  			video-decoder {
>>>>>  				compatible = "venus-decoder";
>>>>>  			};
>>>>> @@ -3748,10 +3750,6 @@ video-encoder {
>>>>>  				compatible = "venus-encoder";
>>>>>  			};
>>>>>  
>>>>> -			video-firmware {
>>>>> -				iommus = <&apps_smmu 0x21a2 0x0>;
>>>>> -			};
>>>>> -
>>>>>  			venus_opp_table: opp-table {
>>>>>  				compatible = "operating-points-v2";
>>>>>  
>>>>>
>>>> Changes look good. Is this tested on SC7280 ?
>>>
>>> Hi Vikash,
>>>
>>> I didn't test it myself on sc7280 (just qcm6490-fp5) but dtx_diff
>>> reports no differences except for status = okay property being added, so
>>> there should be no change on those boards. See below.
>>>
>>> Regards
>>> Luca
>>
>> I tested on SC7280 (herobrine) and all good.
> 
> Great, thanks!
> 
> Regards
> Luca
> 
>>
>> Regards,
>> Vikash
> 
