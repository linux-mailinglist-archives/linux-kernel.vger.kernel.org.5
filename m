Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6580E54F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345974AbjLLH7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjLLH7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:59:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D438A0;
        Mon, 11 Dec 2023 23:59:27 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC7udCt003711;
        Tue, 12 Dec 2023 07:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=/seUik955UQWg68KwzoQTWDJHGnHWX+SuCpnFn49NjA=; b=Tn
        O6yorVxYFZsZ0wnu8CAeL/UOySXIZNCyaaTCjk/dGryIvCdzzeWVmUTRAsLtnXAW
        UD8bSMFf2avxJ1XVd/Xyodk1y9NJy/4Agfl7YMrOQMDArFp6Z6askchPjoZAXUIY
        krsMtZGGiVR4SBvJeET7AQMuG8wWTDnxCoN2WCmtiepxnWCeRlB/sSakmS7OUbYQ
        iiG30vd15LG8LX1lzrqg65sMQHtLRUuvGNZAOR63HHK9OFXFp0Ta6pnKWi6aUDp8
        mdVGODgWYbWqTv1/X/T2Yoe33Esj2xxo+31jXIrTvyFWXi1AAaVCyq4mMY7kqKbU
        HZNVdVYGZob1a7zCKkRA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxg6xgek4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 07:59:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC7xJFR030966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 07:59:19 GMT
Received: from [10.216.17.154] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 23:59:14 -0800
Message-ID: <42fb155b-60b6-bbfb-f52e-cca66ad5b11d@quicinc.com>
Date:   Tue, 12 Dec 2023 13:29:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sc7280: Move video-firmware to
 chrome-common
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
References: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
 <20231201-sc7280-venus-pas-v3-2-bc132dc5fc30@fairphone.com>
Content-Language: en-US
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20231201-sc7280-venus-pas-v3-2-bc132dc5fc30@fairphone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VWlmNUropSG8foccOOtBS8ydXSl6gZIe
X-Proofpoint-ORIG-GUID: VWlmNUropSG8foccOOtBS8ydXSl6gZIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120061
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/2023 3:03 PM, Luca Weiss wrote:
> If the video-firmware node is present, the venus driver assumes we're on
> a system that doesn't use TZ for starting venus, like on ChromeOS
> devices.
> 
> Move the video-firmware node to chrome-common.dtsi so we can use venus
> on a non-ChromeOS devices. We also need to move the secure SID 0x2184
> for iommu since (on some boards) we cannot touch that.
> 
> At the same time also disable the venus node by default in the dtsi,
> like it's done on other SoCs.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>

Regards,
Vikash
> ---
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |  9 +++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index 5d462ae14ba1..459ff877df54 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -104,6 +104,17 @@ &scm {
>  	dma-coherent;
>  };
>  
> +&venus {
> +	iommus = <&apps_smmu 0x2180 0x20>,
> +		 <&apps_smmu 0x2184 0x20>;
> +
> +	status = "okay";
> +
> +	video-firmware {
> +		iommus = <&apps_smmu 0x21a2 0x0>;
> +	};
> +};
> +
>  &watchdog {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 326897af117a..0ff9a2484096 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3836,10 +3836,11 @@ venus: video-codec@aa00000 {
>  					<&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>;
>  			interconnect-names = "cpu-cfg", "video-mem";
>  
> -			iommus = <&apps_smmu 0x2180 0x20>,
> -				 <&apps_smmu 0x2184 0x20>;
> +			iommus = <&apps_smmu 0x2180 0x20>;
>  			memory-region = <&video_mem>;
>  
> +			status = "disabled";
> +
>  			video-decoder {
>  				compatible = "venus-decoder";
>  			};
> @@ -3848,10 +3849,6 @@ video-encoder {
>  				compatible = "venus-encoder";
>  			};
>  
> -			video-firmware {
> -				iommus = <&apps_smmu 0x21a2 0x0>;
> -			};
> -
>  			venus_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
> 
