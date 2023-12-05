Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2F804CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjLEIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjLEIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:45:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF3C0;
        Tue,  5 Dec 2023 00:46:03 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B55Nx1U023771;
        Tue, 5 Dec 2023 08:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AkRfUrfNG0Yc35NEBBPXHy7JmBwfiCTeSJJylk1FaZg=;
 b=IJLJiK0xFbNEywOuGqkegwjpb5QWIfY5IGnOz4lGqE2/xifcxkojaEoYytfxWOfqlgd0
 QlFo77XSMLUPGUZ914AwPkycwr+FbCpgOLFPdxuyq0NTXIPJo0J9UJ2jtlRg0bK6zS+K
 km5Wesyb9CK4e/zoF8/2YzcIDCADOqFpy4rPbGAc83MWKZeAZohzuhHfKe9vlRFp5JSV
 AIgqyVbsnrT5VcXOyJqmtbvkvC0DcDd3wFn/IjqKo978TyiqI/mu61nFs1TbXcriPeSk
 EYUqKwUDUizXUnDemA10E3Q/liqw+munrGbYJY499lBFnIQpsiW9PynOvcqL1Mq6WJ9W vQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usdbnapxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 08:45:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B58jQHs008228
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 08:45:26 GMT
Received: from [10.50.1.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 00:45:19 -0800
Message-ID: <2c996304-f82f-5311-3d88-d459c07ef741@quicinc.com>
Date:   Tue, 5 Dec 2023 14:15:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280
 soc
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204-sc7280-ufs-v5-0-926ceed550da@fairphone.com>
 <20231204-sc7280-ufs-v5-2-926ceed550da@fairphone.com>
 <621388b9-dcee-4af2-9763-e5d623d722b7@quicinc.com>
 <CXFJNBNKTRHH.2CS6TO2MEGJWL@fairphone.com> <20231204172829.GA69580@thinkpad>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20231204172829.GA69580@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B3LvmleG2ex5vrOzMouqnGdZjfmUaGPf
X-Proofpoint-GUID: B3LvmleG2ex5vrOzMouqnGdZjfmUaGPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050071
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2023 10:58 PM, Manivannan Sadhasivam wrote:
> On Mon, Dec 04, 2023 at 01:21:42PM +0100, Luca Weiss wrote:
>> On Mon Dec 4, 2023 at 1:15 PM CET, Nitin Rawat wrote:
>>>
>>>
>>> On 12/4/2023 3:54 PM, Luca Weiss wrote:
>>>> From: Nitin Rawat <quic_nitirawa@quicinc.com>
>>>>
>>>> Add UFS host controller and PHY nodes for sc7280 soc.
>>>>
>>>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # QCM6490 FP5
>>>> [luca: various cleanups and additions as written in the cover letter]
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sc7280.dtsi | 74 +++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 73 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>> index 04bf85b0399a..8b08569f2191 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>>> @@ -15,6 +15,7 @@
>>>>    #include <dt-bindings/dma/qcom-gpi.h>
>>>>    #include <dt-bindings/firmware/qcom,scm.h>
>>>>    #include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/interconnect/qcom,icc.h>
>>>>    #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>>>    #include <dt-bindings/interconnect/qcom,sc7280.h>
>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> @@ -906,7 +907,7 @@ gcc: clock-controller@100000 {
>>>>    			clocks = <&rpmhcc RPMH_CXO_CLK>,
>>>>    				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
>>>>    				 <0>, <&pcie1_phy>,
>>>> -				 <0>, <0>, <0>,
>>>> +				 <&ufs_mem_phy 0>, <&ufs_mem_phy 1>, <&ufs_mem_phy 2>,
>>>>    				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>>>>    			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
>>>>    				      "pcie_0_pipe_clk", "pcie_1_pipe_clk",
>>>> @@ -2238,6 +2239,77 @@ pcie1_phy: phy@1c0e000 {
>>>>    			status = "disabled";
>>>>    		};
>>>>    
>>>> +		ufs_mem_hc: ufs@1d84000 {
>>>> +			compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
>>>> +				     "jedec,ufs-2.0";
>>>> +			reg = <0x0 0x01d84000 0x0 0x3000>;
>>>> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			phys = <&ufs_mem_phy>;
>>>> +			phy-names = "ufsphy";
>>>> +			lanes-per-direction = <2>;
>>>> +			#reset-cells = <1>;
>>>> +			resets = <&gcc GCC_UFS_PHY_BCR>;
>>>> +			reset-names = "rst";
>>>> +
>>>> +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>>>> +			required-opps = <&rpmhpd_opp_nom>;
>>>> +
>>>> +			iommus = <&apps_smmu 0x80 0x0>;
>>>> +			dma-coherent;
>>>> +
>>>> +			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
>>>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>>>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>>>> +					 &cnoc2 SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
>>>> +			interconnect-names = "ufs-ddr", "cpu-ufs";
>>>> +
>>>> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>>>> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>>>> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
>>>> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>>>> +				 <&rpmhcc RPMH_CXO_CLK>,
>>>> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>>>> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>>>> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
>>>> +			clock-names = "core_clk",
>>>> +				      "bus_aggr_clk",
>>>> +				      "iface_clk",
>>>> +				      "core_clk_unipro",
>>>> +				      "ref_clk",
>>>> +				      "tx_lane0_sync_clk",
>>>> +				      "rx_lane0_sync_clk",
>>>> +				      "rx_lane1_sync_clk";
>>>> +			freq-table-hz =
>>>> +				<75000000 300000000>,
>>>> +				<0 0>,
>>>> +				<0 0>,
>>>> +				<75000000 300000000>,
>>>> +				<0 0>,
>>>> +				<0 0>,
>>>> +				<0 0>,
>>>> +				<0 0>;
>>>> +			status = "disabled";
>>>> +		};
>>>> +
>>>> +		ufs_mem_phy: phy@1d87000 {
>>>> +			compatible = "qcom,sc7280-qmp-ufs-phy";
>>>> +			reg = <0x0 0x01d87000 0x0 0xe00>;
>>>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>>>> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
>>>> +				 <&gcc GCC_UFS_1_CLKREF_EN>;
>>>> +			clock-names = "ref", "ref_aux", "qref";
>>>> +
>>>> +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>>
>> Hi Nitin,
>>
>>>
>>> GCC_UFS_PHY_GDSC is UFS controller GDSC. For sc7280 Phy we don't need this.
>>
>> In the current dt-bindings the power-domains property is required.
>>
>> Is there another power-domain for the PHY to use, or do we need to
>> adjust the bindings to not require power-domains property for ufs phy on
>> sc7280?
>>
> 
> PHYs are backed by MX power domain. So you should use that.
> 
>> Also, with "PHY" in the name, it's interesting that this is not for the
>> phy ;)
>>
> 
> Yes, confusing indeed. But the controllers (PCIe, UFS, USB etc...) are backed by
> GDSCs and all the analog components (PHYs) belong to MX domain since it is kind
> of always ON.
> 
> I'll submit a series to fix this for the rest of the SoCs.
> 
> - Mani
> 

Hi Mani,

UFS Phy is a passive driver and its resource enable/disable is 
controlled by UFS controller driver.

Since PHY belongs to MX domain which is always on. IMO, there is no need 
for explicitly voting for MX domain for sc7280 and older targets.

Only starting SM8550, we have a separate UFS PHY GDSC which needs to be 
voted for enabling or disabling and hence we need to have power-domain 
property for SM8550.

Hence, I feel updating the binding to reflect that power-domains is not 
a required field would be more correct.


Regards,
Nitin



>> Regards
>> Luca
>>
>>>
>>>> +
>>>> +			resets = <&ufs_mem_hc 0>;
>>>> +			reset-names = "ufsphy";
>>>> +
>>>> +			#clock-cells = <1>;
>>>> +			#phy-cells = <0>;
>>>> +
>>>> +			status = "disabled";
>>>> +		};
>>>> +
>>>>    		ipa: ipa@1e40000 {
>>>>    			compatible = "qcom,sc7280-ipa";
>>>>    
>>>>
>>
> 
