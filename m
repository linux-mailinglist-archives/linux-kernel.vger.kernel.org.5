Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9E07E00EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjKCKWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:22:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C06D4E;
        Fri,  3 Nov 2023 03:22:21 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A39DnDb005742;
        Fri, 3 Nov 2023 10:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nRY5lOltW/stmAHC4W+teHJxj9e8mY88qXIYFfyXbKQ=;
 b=SGoL+g5yIAHb39M3LwtjWJTL466p+0iGEJ1goME3jjjA/A9ysHi26p3GwOjDzVOy21cF
 nYTlQaKLN35KGtKDc0tXpyWsmesCKJ9AjPy76u4/bZxeobTv4xQi1cg+Ip+l3bViYmhQ
 oMo8nSqLmAR/+V+EaRiMhrfCwiciydDnY/rXGIjQjE/ABEpikZ9YSYnC5YPmS0XAu579
 qGHjGxQo/hPAR/h1jRmWxY6olFq3URwuOE6OWF2QteaAlXTSxg8lNh98ZzQyPoEkMs9g
 gScmfAgc5fgNGZlh+wNgWY2t2eVDO7lANUBpA+y1xegSLflgkf93yLy+XYLMiZ85o8cD Fg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u4r00gtmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 10:22:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A3AM6Cc020183
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Nov 2023 10:22:06 GMT
Received: from [10.214.16.225] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 3 Nov
 2023 03:22:00 -0700
Message-ID: <9a2ff779-163c-415d-9e78-84756ad77c86@quicinc.com>
Date:   Fri, 3 Nov 2023 15:51:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ARM: dts: msm: Add capacity and DPC properties for
 sc7280 soc
Content-Language: en-US
To:     <cros-qcom-dts-watchers@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ashayj@quicinc.com>,
        <quic_atulpant@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_pkondeti@quicinc.com>
References: <20231103095358.29312-1-quic_anshar@quicinc.com>
From:   Ankit Sharma <quic_anshar@quicinc.com>
In-Reply-To: <20231103095358.29312-1-quic_anshar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aqXp8JEJkrk7SJ-V2BsLJslyR6rjFI1C
X-Proofpoint-GUID: aqXp8JEJkrk7SJ-V2BsLJslyR6rjFI1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/2023 3:23 PM, Ankit Sharma wrote:
> The "capacity-dmips-mhz" and "dynamic-power-coefficient" are
> used to build Energy Model which in turn is used by EAS to take
> placement decisions.
>
> Change-Id: I57aa4b99734dc349034f84bd16b02609b4ac6e55
> Signed-off-by: Ankit Sharma <quic_anshar@quicinc.com>
> ---
Please ignore this, will resend again. Sorry for the spam.

Thanks,
Ankit
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 8601253aec70..b1890824188c 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -176,6 +176,8 @@
>   					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_0>;
>   			operating-points-v2 = <&cpu0_opp_table>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
>   			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
>   					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -204,6 +206,8 @@
>   					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_100>;
>   			operating-points-v2 = <&cpu0_opp_table>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
>   			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
>   					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -227,6 +231,8 @@
>   					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_200>;
>   			operating-points-v2 = <&cpu0_opp_table>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
>   			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
>   					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -250,6 +256,8 @@
>   					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_300>;
>   			operating-points-v2 = <&cpu0_opp_table>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
>   			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
>   					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -273,6 +281,8 @@
>   					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_400>;
>   			operating-points-v2 = <&cpu4_opp_table>;
> +			capacity-dmips-mhz = <1946>;
> +			dynamic-power-coefficient = <520>;
>   			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
>   					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -296,6 +306,8 @@
>   					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_500>;
>   			operating-points-v2 = <&cpu4_opp_table>;
> +			capacity-dmips-mhz = <1946>;
> +			dynamic-power-coefficient = <520>;
>   			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
>   					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -319,6 +331,8 @@
>   					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_600>;
>   			operating-points-v2 = <&cpu4_opp_table>;
> +			capacity-dmips-mhz = <1946>;
> +			dynamic-power-coefficient = <520>;
>   			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
>   					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -342,6 +356,8 @@
>   					   &CLUSTER_SLEEP_0>;
>   			next-level-cache = <&L2_700>;
>   			operating-points-v2 = <&cpu7_opp_table>;
> +			capacity-dmips-mhz = <1985>;
> +			dynamic-power-coefficient = <552>;
>   			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
>   					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
>   			qcom,freq-domain = <&cpufreq_hw 2>;
