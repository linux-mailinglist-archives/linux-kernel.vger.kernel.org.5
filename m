Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE67F226C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjKUAlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjKUAlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:41:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81410F1;
        Mon, 20 Nov 2023 16:41:10 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL0Zd8O016973;
        Tue, 21 Nov 2023 00:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=X8xZvS6shZckfz0tektajGeeKEM/8ral5kfB64Bb0jE=;
 b=VYD4rZazIwewET3s7EeayauIg2O/Dkc029yQE9TyMlkgf/9uifEgCjsnZggyqbm+cSH9
 88wr1nmx+wlqdTcdi2yyW7sr9z+Sb257OBUiI6o35mni+mZfIiFt/y8+9GSRTxhJQecr
 lwvujBfCWDiTnw0RKBScAh6IYGr71XAAY0SbK00rpujCM0iJeQVO+CY1/OsVTRARXAIO
 eF35+61ZgqygRw9Uw02LvUOFxd3BSgWJnE1acSl5JgfZkRWEtxCXclAZH8bPphsJYu/N
 rbH+EGJS3qfyvbYxjAhq3gxU5X9wI6ur8yh2hGkkJCaDzt9vEFICvLcaGpDbQ1hGsBjs lg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug5371vme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:41:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL0f2Hr022514
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:41:02 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 16:40:56 -0800
Message-ID: <5a98975e-d11c-43b8-ad95-1a2633733a19@quicinc.com>
Date:   Tue, 21 Nov 2023 08:40:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] arm64: dts: qcom: sm8550-aim300: add PCIe0
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231117101817.4401-1-quic_tengfan@quicinc.com>
 <20231117101817.4401-8-quic_tengfan@quicinc.com>
 <37a3a407-07e7-49d8-bbce-b1dac8cfcf5a@linaro.org>
 <247f4654-ec65-4857-8b35-1a79088e8b87@linaro.org>
 <1ae2da80-77e8-487a-a94d-b329e6f48360@linaro.org>
 <26df42ac-edb0-ac72-d5cb-4a4ae6819736@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <26df42ac-edb0-ac72-d5cb-4a4ae6819736@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BcXLPgx7PBaSS9C0AX8IGK_-WW4j0xW5
X-Proofpoint-GUID: BcXLPgx7PBaSS9C0AX8IGK_-WW4j0xW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=927 spamscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/20/2023 1:59 AM, Neil Armstrong 写道:
> Le 18/11/2023 à 01:08, Konrad Dybcio a écrit :
>> On 17.11.2023 11:41, neil.armstrong@linaro.org wrote:
>>> On 17/11/2023 11:29, Dmitry Baryshkov wrote:
>>>> On 17/11/2023 12:18, Tengfei Fan wrote:
>>>>> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
>>>>> thus skip pcie_1_phy_aux_clk input clock to GCC.
>>>>>
>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/sm8550-aim300.dts | 32 
>>>>> ++++++++++++++++++++++
>>>>>    1 file changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts 
>>>>> b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>>> index 202b979da8ca..3aca0a433a00 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8550-aim300.dts
>>>>> @@ -393,6 +393,38 @@
>>>>>        };
>>>>>    };
>>>>> +&gcc {
>>>>> +    clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>>>>> +         <&pcie0_phy>,
>>>>> +         <&pcie1_phy>,
>>>>> +         <0>,
>>>>> +         <&ufs_mem_phy 0>,
>>>>> +         <&ufs_mem_phy 1>,
>>>>> +         <&ufs_mem_phy 2>,
>>>>> +         <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>>>>> +};
>>>>
>>>> NAK, this should go to sm8550.dtsi unless there is a good reason.
>>>
>>> Actually this is how QRD8550 was designed, so it's fine to mimic.
>> Does CCF not handle this gracefully?
> 
> CCF handles this very gracefully and it's a perfectly valid DT in regard
> to the bindings...
> 
> neil
> 
>>
>> Konrad
> 
Thanks Konrad and Neil comments and disscusion this patch, I also will 
confirm this with internal team.

-- 
Thx and BRs,
Tengfei Fan
