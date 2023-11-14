Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090A57EB032
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjKNMtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjKNMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:49:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E8192;
        Tue, 14 Nov 2023 04:49:06 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE9lspi005733;
        Tue, 14 Nov 2023 12:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZhmJYQjl3F7Ag95sFanvsUwnsEwogKV61yK9PHsLMJM=;
 b=TmTPad4EC3NZ5hsrawP6B4/Zb9siC4SBFXQgTp3YyN936VWLzBziumMz3fL4hqUvv3WX
 Md2ZKW/43tVs8JwgPFpy3ebTO/Uu41WGJ/a1Anr2Xfk3J1s/bCN/zmlygI+IY2IC9lNv
 WRjb5zFbcl9TVf6Ecgc7+cPKQGUmY1AHqzn7Gl9EP2w5pWOP4qHEGUu8gSbmlhB/O7Kn
 CMcNouQUyw0D0GIVZGZc7STr4N49WfYyz+0NhoInQ08VKSAaC+abEKQ12x3qH0IqKTmf
 9uimYz/uaj/HxYSWyvN+QQYbPJoYfI/p+33l+vQy2Tn9akz+KkMtCl+BjTgN2jmhCTMg AA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubmtvaqm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:48:56 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AECmtIK002825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 12:48:55 GMT
Received: from [10.216.63.64] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 14 Nov
 2023 04:48:49 -0800
Message-ID: <dffe07e5-a6f5-397a-7715-ffb25474ac84@quicinc.com>
Date:   Tue, 14 Nov 2023 18:18:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 idp and
 rb3 board
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_nainmeht@quicinc.com>
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
 <20231103184655.23555-3-quic_kbajaj@quicinc.com>
 <CAA8EJprNyu0r_mV9hbKA1fSvoEvTHuk5umxU8H64Voj_cnZcFQ@mail.gmail.com>
 <1830fc44-7bac-4db5-af59-112410d73a64@linaro.org>
 <af05dbdb-21bf-34f0-e9b3-9f6b9a0c3115@quicinc.com>
 <CAA8EJpq89g9EeyKcogU+Mt9ie6Bk-rmgi=GqyycYBm_291i1Bw@mail.gmail.com>
 <d5492e4d-6c70-7d6c-3f5b-a0b5d9266ab0@quicinc.com>
 <CAA8EJpr+8MSEHbziTJhhnkeFhPemRARL_bpWEvHmVvAcbp++Cw@mail.gmail.com>
 <62650f39-9703-fdc5-c72a-801b8e9f6470@quicinc.com>
 <CWXSYVQ15C8X.2RXH2M2HH62RY@fairphone.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CWXSYVQ15C8X.2RXH2M2HH62RY@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P9l3dThmnTJRknN7xv4D5ttJ4TpllT_S
X-Proofpoint-GUID: P9l3dThmnTJRknN7xv4D5ttJ4TpllT_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140099
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/2023 9:21 PM, Luca Weiss wrote:
> On Tue Nov 7, 2023 at 9:10 AM CET, Mukesh Ojha wrote:
>>
>>
>> On 11/7/2023 4:02 AM, Dmitry Baryshkov wrote:
>>> On Mon, 6 Nov 2023 at 16:46, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/6/2023 5:24 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, 6 Nov 2023 at 13:41, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 11/5/2023 6:38 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 03/11/2023 23:22, Dmitry Baryshkov wrote:
>>>>>>>> On Fri, 3 Nov 2023 at 20:49, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>>>>>>>>
>>>>>>>>> Add qcm6490 devicetree file for QCM6490 IDP and QCM6490 RB3
>>>>>>>>> platform. QCM6490 is derived from SC7280 meant for various
>>>>>>>>> form factor including IoT.
>>>>>>>>>
>>>>>>>>> Supported features are, as of now:
>>>>>>>>> * Debug UART
>>>>>>>>> * eMMC (only in IDP)
>>>>>>>>> * USB
>>>>>>>>>
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>>> +
>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi b/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..01adc97789d0
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-iot-common.dtsi
>>>>>>>>
>>>>>>>> I have mixed feelings towards this file. Usually we add such 'common'
>>>>>>>> files only for the phone platforms where most of the devices are
>>>>>>>> common.
>>>>>>>> Do you expect that IDP and RB3 will have a lot of common code other
>>>>>>>> than these regulator settings?
>>>>>>>
>>>>>>> I agree here. What exactly is common in the real hardware between IDP
>>>>>>> and RB3? Commit msg does not explain it, so I do not see enough
>>>>>>> justification for common file. Just because some DTS looks similar for
>>>>>>> different hardware does not mean you should creat common file.
>>>>>>
>>>>>> @Dmitry/@Krzysztof,
>>>>>>
>>>>>> Thank you for reviewing the RFC, we wanted to continue the
>>>>>> suggestion/discussion given on [1] , where we discussed that this
>>>>>> qcm6490 is going to be targeted for IOT segment and will have different
>>>>>> memory map and it is going to use some of co-processors like adsp/cdsp
>>>>>> which chrome does not use.
>>>>>>
>>>>>> So to your question what is common between RB3 and IDP, mostly they will
>>>>>> share common memory map(similar to [2]) and regulator settings and both
>>>>>> will use adsp/cdsp etc., we will be posting the memory map changes as
>>>>>> well in coming weeks once this RFC is acked.
>>>>>
>>>>> Is the memory map going to be the same as the one used on Fairphone5?
>>>>
>>>> No, Fairphone5 looks to be using chrome memory map and i suggested
>>>> here to move them into sc7280.dtsi
>>>>
>>>> https://lore.kernel.org/lkml/d5d53346-ca3b-986a-e104-d87c37115b62@quicinc.com/
>>>>
>>>>>
>>>>> Are ADSP and CDSP physically present on sc7280?
>>>>
>>>> Yes, they are present but not used.
>>>
>>> So ADSP and CDSP should go into sc7280.dtsi. They will anyway have
>>> status = "disabled";
>>>
>>>>
>>>>>
>>>>> I think that your goal should be to:
>>>>> - populate missing device in sc7280.dtsi
>>>>> - maybe add qcm6490.dtsi which defines SoC-level common data (e.g. memory map)
>>>>> - push the rest to board files.
>>>>
>>>> Agree to all of the point.
>>>> We started with the same thought at[3] but it got lost in discussion
>>>> due to its differentiation with mobile counter part(fairphone) which
>>>> follow chrome memory map and hence we came up with qcm6490-iot-common.
>>>> Do you think, qcm6490-iot.dtsi should be good ?
>>>
>>> No. DT describes hardware, and -iot is not a hardware abstraction / unification.
>>> If you consider your memory map to be generic for the qcm6490 (and FP5
>>> being the only exception), add it to the qcm6490.dtsi (and let FP5
>>> override it, like some of the phones do). If it can not be considered
>>> generic for the SoC, then you have no other choice than to replicate
>>> it to all board files.
>>
> 
> Hi Mukesh,
> 
>> Thanks for the suggestion.
>> Let me add @Luca here for information, if he want to share
>> anything about qcm6490 fp5 memory map.
> 
> Not sure I have much to share, just probably that on FP5 the memory
> setup and all the basics just come from a standard QCM6490.LA.3.0
> release.
> I don't see any hint that our ODM changed something in the memory map
> for the device either.
> 
> I'm also aware that other phones also use QCM6490 SoC, so I'm still
> wondering where the distinction between "FP5/ChromeOS memory map" vs
> this new QCM6490 memory map is.
> There's also e.g. this phone using QCM6490, I've not looked into this at
> all, but I'm guessing that phone uses the same memory map as FP5.
> https://www.crosscall.com/en_NL/core-z5-COZ5.MASTER.html

Was looking for your view on the things about qcm6490.dtsi one common 
dtsi file for all qcm6490.dtsi suggested in the mail, but looks like FP5
is following the memory map based out of sc7280, in that case we have to
replicate the new memory map for all our IOT boards(idp/rb3) based on
this SoC.

-Mukesh
> 
> Regards
> Luca
> 
>>
>> -Mukesh
>>>
>>>>
>>>> [3]
>>>> https://lore.kernel.org/linux-arm-msm/20231003175456.14774-3-quic_kbajaj@quicinc.com/
>>>>
>>>> -Mukesh
>>>>>
>>>>> I don't think that putting regulators to the common file is a good
>>>>> idea. Platforms will further change and limit voltage limits and
>>>>> modes, so they usually go to the board file.
>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Mukesh
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/linux-arm-msm/d97ebf74-ad03-86d6-b826-b57be209b9e2@quicinc.com/
>>>>>>
>>>>>> [2]
>>>>>> commit 90c856602e0346ce9ff234062e86a198d71fa723
>>>>>> Author: Douglas Anderson <dianders@chromium.org>
>>>>>> Date:   Tue Jan 25 14:44:20 2022 -0800
>>>>>>
>>>>>>         arm64: dts: qcom: sc7280: Factor out Chrome common fragment
>>>>>>
>>>>>>         This factors out a device tree fragment from some sc7280 device
>>>>>>         trees. It represents the device tree bits that should be included for
>>>>>>         "Chrome" based sc7280 boards. On these boards the bootloader (Coreboot
>>>>>>         + Depthcharge) configures things slightly different than the
>>>>>>         bootloader that Qualcomm provides. The modem firmware on these boards
>>>>>>         also works differently than on other Qulacomm products and thus the
>>>>>>         reserved memory map needs to be adjusted.
>>>>>>
>>>>>>         NOTES:
>>>>>>         - This is _not_ quite a no-op change. The "herobrine" and "idp"
>>>>>>           fragments here were different and it looks like someone simply
>>>>>>           forgot to update the herobrine version. This updates a few numbers
>>>>>>           to match IDP. This will also cause the `pmk8350_pon` to be disabled
>>>>>>           on idp/crd, which I belive is a correct change.
>>>>>>         - At the moment this assumes LTE skus. Once it's clearer how WiFi SKUs
>>>>>>           will work (how much of the memory map they can reclaim) we may add
>>>>>>           an extra fragment that will rejigger one way or the other.
>>>>>>
>>>>>>         Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>>>         Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>>>>>>         Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>>>>>         Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>>         Link:
>>>>>> https://lore.kernel.org/r/20220125144316.v2.3.Iac012fa8d727be46448d47027a1813ea716423ce@changeid
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Krzysztof
>>>>>>>
>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
> 
