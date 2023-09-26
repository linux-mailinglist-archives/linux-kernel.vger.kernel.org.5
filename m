Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3727AF0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjIZQZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIZQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:25:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D79C8E;
        Tue, 26 Sep 2023 09:25:16 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QDwh5m020866;
        Tue, 26 Sep 2023 16:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kn0NWfrf2PoJA+utp/K+B/7mDfqS5Mn1G1dsC5wgm6E=;
 b=j2xXP4VwzjZTvmyk4bS2D9EQ5n3uXudKaH7UeS0GwyN0LrQgWfVfGTFjXyN4CPk+TPm2
 uf/Rh6uRAimblBjYEOiJv4SUlOVRE/4o39+35ZgNKoi9dhqFBI6H6B1jNBLQEVK0/L9l
 PLzqSVTWyvhs0Xy1XLCknlJHK/HivC0wE3O46n3t+d6ZwfGiM63JiUvLWMiHEnJ/61+4
 s9ejxvoCZXOkwRkTSQYgI1bKyZhbS5vN9Yc4YOthMS2SU5Ybl+0OJhMdg9CCuPE01jlb
 TqSGX72UyoYCtRro2Al8D21yNye3DOECUWCvE+uQS9BRsM/GLpt6EyK3KLCLQ9i/1JeF Iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbmwwt26q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:25:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QGOSsC010322
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 16:24:28 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 26 Sep
 2023 09:24:22 -0700
Message-ID: <593fa9be-9f55-3649-e825-1dee31ac5c21@quicinc.com>
Date:   Tue, 26 Sep 2023 21:54:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V1 2/2] arm64: dts: qcom: sc7280: Add UFS host controller
 and phy nodes
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <alim.akhtar@samsung.com>,
        <bvanassche@acm.org>, <robh+dt@kernel.org>, <avri.altman@wdc.com>,
        <cros-qcom-dts-watchers@chromium.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230821094937.13059-1-quic_nitirawa@quicinc.com>
 <20230821094937.13059-3-quic_nitirawa@quicinc.com>
 <20230822070841.GA24753@thinkpad>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230822070841.GA24753@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5TkmNezfs8z-kSjLn0mFlFVUitDhXyq9
X-Proofpoint-ORIG-GUID: 5TkmNezfs8z-kSjLn0mFlFVUitDhXyq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260144
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 12:38 PM, Manivannan Sadhasivam wrote:
> On Mon, Aug 21, 2023 at 03:19:37PM +0530, Nitin Rawat wrote:
>> Add UFS host controller and PHY nodes for sc7280.
>>
> 
> You should split this patch into 2. One for SoC and another for board.
Updated in Latest Patchset.

> 
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 19 +++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 64 ++++++++++++++++++++++++
>>   2 files changed, 83 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 2ff549f4dc7a..c60cdd511222 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -451,6 +451,25 @@
>>   	status = "okay";
>>   };
>>
>> +&ufs_mem_hc {
>> +	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
>> +	vcc-supply = <&vreg_l7b_2p9>;
>> +	vcc-max-microamp = <800000>;
>> +	vccq-supply = <&vreg_l9b_1p2>;
>> +	vccq-max-microamp = <900000>;
>> +	vccq2-supply = <&vreg_l9b_1p2>;
>> +	vccq2-max-microamp = <900000>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&ufs_mem_phy {
>> +	vdda-phy-supply = <&vreg_l10c_0p8>;
>> +	vdda-pll-supply = <&vreg_l6b_1p2>;
>> +
>> +	status = "okay";
>> +};
>> +
>>   &sdhc_1 {
>>   	status = "okay";
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 925428a5f6ae..d4a15d56b384 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -908,6 +908,70 @@
>>   			};
>>   		};
>>
>> +		ufs_mem_phy: phy@1d87000 {
> 
> Please sort the nodes in ascending order.
Updated in Latest Patchset.

> 
>> +			compatible = "qcom,sc7280-qmp-ufs-phy";
>> +			reg = <0x0 0x01d87000 0x0 0xe00>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
>> +				 <&gcc GCC_UFS_1_CLKREF_EN>;
>> +			clock-names = "ref", "ref_aux", "qref";
>> +
>> +			resets = <&ufs_mem_hc 0>;
>> +			reset-names = "ufsphy";
>> +
>> +			#clock-cells = <1>;
>> +			#phy-cells = <0>;
>> +
>> +			status = "disabled";
>> +
>> +		};
>> +
>> +		ufs_mem_hc: ufs@1d84000 {
>> +			compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
>> +				     "jedec,ufs-2.0";
>> +			reg = <0x0 0x01d84000 0x0 0x3000>;
>> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>> +			phys = <&ufs_mem_phy>;
>> +			phy-names = "ufsphy";
>> +			lanes-per-direction = <2>;
>> +			#reset-cells = <1>;
>> +			resets = <&gcc GCC_UFS_PHY_BCR>;
>> +			reset-names = "rst";
>> +
>> +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>> +			required-opps = <&rpmhpd_opp_nom>;
>> +
>> +			iommus = <&apps_smmu 0x80 0x0>;
>> +			dma-coherent;
>> +
>> +			clock-names = "core_clk",
>> +				      "bus_aggr_clk",
>> +				      "iface_clk",
>> +				      "core_clk_unipro",
>> +				      "ref_clk",
>> +				      "tx_lane0_sync_clk",
>> +				      "rx_lane0_sync_clk",
>> +				      "rx_lane1_sync_clk";
> 
> "clocks" property should come first.
  DT binding shows clock-names first followed by clocks.
  Let me know if see still see concern, would update .

> 
> - Mani
> 
>> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
>> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>> +				 <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
>> +			freq-table-hz =
>> +				<75000000 300000000>,
>> +				<0 0>,
>> +				<0 0>,
>> +				<75000000 300000000>,
>> +				<0 0>,
>> +				<0 0>,
>> +				<0 0>,
>> +				<0 0>;
>> +			status = "disabled";
>> +		};
>> +
>>   		sdhc_1: mmc@7c4000 {
>>   			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
>>   			pinctrl-names = "default", "sleep";
>> --
>> 2.17.1
>>
> 

Thanks,
Nitin
