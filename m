Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6279118F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjIDGmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjIDGmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:42:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7E8E6;
        Sun,  3 Sep 2023 23:42:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3846eih6016971;
        Mon, 4 Sep 2023 06:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oxk+I1stnZ29bBdQ58vVQQnSWGkt1Pm4rP9gtybo3ow=;
 b=P1tgtMUADJJn4SWo9/fzzKa7l/oKnh2fbbPaNB0OqseiyowXPvEE9kUyc42bHOC9dfUe
 4ZO4u+G0gYgTnP+TaIYVtTlc6RH97NfqhAZrEcUsw3fzHqVZqt2ziPo43pw8WVKBt9Hd
 MR4mojcpk5xllIXWI3PEWQ4D2I14dpD+QeVQ25LdNZg2Za+bQd8Uk4yNGm/HHMReu/7S
 Lwj+2ujpEp/KTXVYObAjZn5kYhL4yRfYI9t/5Vq1xtu44yMLXh4HcTWDYQ3RGnRPqj9v
 g9+TmJwxXb8lse/ri5OL3bM/7RHDYCv6oEV5yUkrJBKOodTiDtnBop9iwnhHbIRd9/Rp Qg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suxbftvcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 06:42:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3846g2Vo008606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 06:42:02 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 3 Sep
 2023 23:41:57 -0700
Message-ID: <64808e4c-f835-487e-a608-d00e81820f47@quicinc.com>
Date:   Mon, 4 Sep 2023 12:11:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: Fix hwlock index for SMEM for IPQ
 platforms
Content-Language: en-US
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_anusha@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20230904063344.4144086-1-quic_viswanat@quicinc.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <20230904063344.4144086-1-quic_viswanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SY2_upGK-rjNGleEzW_gULwHZ_cy7SEi
X-Proofpoint-ORIG-GUID: SY2_upGK-rjNGleEzW_gULwHZ_cy7SEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=681 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040059
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/2023 12:03 PM, Vignesh Viswanathan wrote:
> SMEM uses lock index 3 of the TCSR Mutex hwlock for allocations
> in SMEM region shared by the Host and FW.
>
> Fix the SMEM hwlock index to 3 for IPQ5332, IPQ6018, IPQ8074 and IPQ9574.


Fixes tag please?


>
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 2 +-
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 1abc992ede31..a47c79c3d5f0 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -135,7 +135,7 @@ smem@4a800000 {
>   			reg = <0x0 0x4a800000 0x0 0x100000>;
>   			no-map;
>   
> -			hwlocks = <&tcsr_mutex 0>;
> +			hwlocks = <&tcsr_mutex 3>;
>   		};
>   
>   		q6_region: wcnss@4a900000 {
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 56537cf8243f..9577341592c3 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -211,7 +211,7 @@ q6_region: memory@4ab00000 {
>   	smem {
>   		compatible = "qcom,smem";
>   		memory-region = <&smem_region>;
> -		hwlocks = <&tcsr_mutex 0>;
> +		hwlocks = <&tcsr_mutex 3>;
>   	};
>   
>   	soc: soc@0 {
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 00ed71936b47..92fd924bbdbe 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -101,7 +101,7 @@ smem@4ab00000 {
>   			reg = <0x0 0x4ab00000 0x0 0x100000>;
>   			no-map;
>   
> -			hwlocks = <&tcsr_mutex 0>;
> +			hwlocks = <&tcsr_mutex 3>;
>   		};
>   
>   		memory@4ac00000 {
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index f22f7e78850d..cc0e4a2b67d2 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -195,7 +195,7 @@ tz_region: tz@4a600000 {
>   		smem@4aa00000 {
>   			compatible = "qcom,smem";
>   			reg = <0x0 0x4aa00000 0x0 0x100000>;
> -			hwlocks = <&tcsr_mutex 0>;
> +			hwlocks = <&tcsr_mutex 3>;
>   			no-map;
>   		};
>   
