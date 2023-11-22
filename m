Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F837F4789
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbjKVNSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbjKVNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:18:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8FBD61;
        Wed, 22 Nov 2023 05:17:59 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMBwiwT011949;
        Wed, 22 Nov 2023 13:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s/zFxEX45XRMx1ySoCsPKFQEP16B4/d6O0WqN/re6M8=;
 b=K8H9DG1FFYJPaOQK142Ijhll+AXlnZa6e/DTRERVyhWvw/WV6QQUO5/SZvaE1qindmkj
 93oXK1JrWIDcWOPzHYfZw1NueCJYSJjawxA0a5q2+MTC6NYnwsgaDi0FKjFaj7urDcnM
 dnznY1rv6fkbsNYI3fewG6rbtE0p92SnSteRlJE+tSoG7syVu9FnON2a9U0WowQkAJKQ
 AUZDnFLZ14soqVPYB6o8GA05wTrCtjTSdnLjVCAu65K6UCV64Xstf91qh40k+pzsYDEO
 u60H4J2x1mh0uDPuvxO//OdG6cKDYL297DyH6kvXm4WNaQ/G4vpFVWPlRno292UHy95e 7w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh8mw9hjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 13:17:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AMDHpTG029301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 13:17:51 GMT
Received: from [10.206.101.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 05:17:46 -0800
Message-ID: <4cfad910-1821-3a31-c372-3f6b199e8f71@quicinc.com>
Date:   Wed, 22 Nov 2023 18:47:43 +0530
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
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20231002-sc7280-venus-pas-v2-2-bd2408891317@fairphone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2C6O6dqSmy7akqZIlZXUzeo6H2p-pnZz
X-Proofpoint-ORIG-GUID: 2C6O6dqSmy7akqZIlZXUzeo6H2p-pnZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220094
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/2/2023 7:50 PM, Luca Weiss wrote:
> If the video-firmware node is present, the venus driver assumes we're on
> a system that doesn't use TZ for starting venus, like on ChromeOS
> devices.
> 
> Move the video-firmware node to chrome-common.dtsi so we can use venus
> on a non-ChromeOS devices.
> 
> At the same time also disable the venus node by default in the dtsi,
> like it's done on other SoCs.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 8 ++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 6 ++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index 5d462ae14ba1..cd491e46666d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -104,6 +104,14 @@ &scm {
>  	dma-coherent;
>  };
>  
> +&venus {
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
> index 66f1eb83cca7..fa53f54d4675 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3740,6 +3740,8 @@ venus: video-codec@aa00000 {
>  				 <&apps_smmu 0x2184 0x20>;
>  			memory-region = <&video_mem>;
>  
> +			status = "disabled";
> +
>  			video-decoder {
>  				compatible = "venus-decoder";
>  			};
> @@ -3748,10 +3750,6 @@ video-encoder {
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
Changes look good. Is this tested on SC7280 ?

Regards,
Vikash
