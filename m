Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C097AFE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjI0Ia0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjI0I3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:29:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E64F4;
        Wed, 27 Sep 2023 01:29:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R8FR7x032656;
        Wed, 27 Sep 2023 08:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HpJgdl/mtnzZkUABcW4CfNA7EBSkZK/fcBh9bbFEqCE=;
 b=Ge8rp72c3geUNE2DCAzKksxYNZCGE9D4gEnzP4Xx6gUi7yX1eEHIpVebspDg3QVTBtzQ
 o508+74V/10ypkUHHRmRp2Ut9xVgg4kYuE2ybs+G3Tz4KhQG3TnvZQMMuj5hoQrbVk3O
 lcy6dWW/B4ysdBi2KgQzL32HAqKkaTBsw8/dmOCS9Ha6zhnSaETkO+aoYeF55PQagd6k
 fL6V6sd+wCt4ExJW8kyM+6L/nNtaEx1CPZpiD3WSX0lNVEg9Qx2JfBNRZrtB3/hYgyrZ
 PDZflcRj3QzCqHfnmKvxUaqLpY/IBQLv0hvG5nZeWscmyn9hMKm5BVF++/8d48HzEw4+ yA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc8v48sem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:29:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R8TVu9000622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:29:31 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 01:29:26 -0700
Message-ID: <c71623bd-d70b-7b25-2f13-a5ec3d4f7c93@quicinc.com>
Date:   Wed, 27 Sep 2023 13:59:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 4/4] dt-bindings: ufs: qcom: Align clk binding property
 for Qualcomm UFS
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mani@kernel.org>,
        <alim.akhtar@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230927081858.15961-1-quic_nitirawa@quicinc.com>
 <20230927081858.15961-5-quic_nitirawa@quicinc.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230927081858.15961-5-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0oSsOqBPKUmKC7wxsBT_Tw0AiuoVPywk
X-Proofpoint-ORIG-GUID: 0oSsOqBPKUmKC7wxsBT_Tw0AiuoVPywk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270068
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
I have reposted this patch by removing the change id. Please ignore this.

Regards,
Nitin


On 9/27/2023 1:48 PM, Nitin Rawat wrote:
> Align the binding property for clock such that "clocks" property
> comes first followed by "clock-names" property.
> 
> Change-Id: I53282da8eee8ec349d315de7ada56c99bb12b00d
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>   .../devicetree/bindings/ufs/qcom,ufs.yaml        | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 802640efa956..d17bdc4e934f 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -295,14 +295,6 @@ examples:
>                               <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
>               interconnect-names = "ufs-ddr", "cpu-ufs";
>   
> -            clock-names = "core_clk",
> -                          "bus_aggr_clk",
> -                          "iface_clk",
> -                          "core_clk_unipro",
> -                          "ref_clk",
> -                          "tx_lane0_sync_clk",
> -                          "rx_lane0_sync_clk",
> -                          "rx_lane1_sync_clk";
>               clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>                        <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>                        <&gcc GCC_UFS_PHY_AHB_CLK>,
> @@ -311,6 +303,14 @@ examples:
>                        <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>                        <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>                        <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +            clock-names = "core_clk",
> +                          "bus_aggr_clk",
> +                          "iface_clk",
> +                          "core_clk_unipro",
> +                          "ref_clk",
> +                          "tx_lane0_sync_clk",
> +                          "rx_lane0_sync_clk",
> +                          "rx_lane1_sync_clk";
>               freq-table-hz = <75000000 300000000>,
>                               <0 0>,
>                               <0 0>,
