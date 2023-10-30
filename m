Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA77DB5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjJ3JF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjJ3JFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:05:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707EE94;
        Mon, 30 Oct 2023 02:05:22 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U7HYOd020046;
        Mon, 30 Oct 2023 09:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+BHBBy2hbEIEKkYqrqkXVOp/Y/qfuNbbQXEDeHpGtwA=;
 b=VK3uIspdfgrwF7vM3quQrb1kJ1QMazT9hmnNm48CivF0j3oEPyf0RjoUc8OoT6s3+F07
 v6p5ErwYib63aP7KC7A3W2WzUL0NtUAeXBWqgqDY9gyVkQXkpLMFBwhAFjMgJ5UZTbEd
 u3W5Hne8WeXLJN2u0Eo4rVVsgOK45EteY326HDX3Qgd8uGfCmoB8087kZ0xYWe+QyTvx
 0Kc7OhLgY19cBaYDq9s1RzWmYAeBqDZSn3ZX7Y2SECtwvr+dgiaaAKXGIDfu2sO2QmM8
 Frd5JF8oXBeLaWj7HLG0wRTB6heiFvdcDb6t+glJelzPSU0SdrrPm6aW4HZ8BQFvJsaa bw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0smrkek8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 09:05:16 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39U95EnS000976
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 09:05:14 GMT
Received: from [10.214.225.95] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 02:05:07 -0700
Message-ID: <7934a36a-9438-719a-2ed0-4a78757b044b@quicinc.com>
Date:   Mon, 30 Oct 2023 14:34:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/9] arm64: dts: qcom: sc7280: Add CDSP node
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
 <20231027-sc7280-remoteprocs-v1-7-05ce95d9315a@fairphone.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231027-sc7280-remoteprocs-v1-7-05ce95d9315a@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GwXz9xNa5tS4sBJylnvstFr-_uM972uO
X-Proofpoint-GUID: GwXz9xNa5tS4sBJylnvstFr-_uM972uO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_06,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300067
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2023 7:50 PM, Luca Weiss wrote:
> Add the node for the ADSP found on the SC7280 SoC, using standard
> Qualcomm firmware.
> 
> The memory region for sc7280-chrome-common.dtsi is taken from msm-5.4
> yupik.dtsi since the other areas also seem to match that file there,
> though I cannot be sure there.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |   5 +
>   arch/arm64/boot/dts/qcom/sc7280.dtsi               | 138 +++++++++++++++++++++
>   2 files changed, 143 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index eb55616e0892..6e5a9d4c1fda 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -29,6 +29,11 @@ adsp_mem: memory@86700000 {
>   			no-map;
>   		};
>   
> +		cdsp_mem: memory@88f00000 {
> +			reg = <0x0 0x88f00000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +

Just a question, why to do it here, if chrome does not use this ?

-Mukesh

>   		camera_mem: memory@8ad00000 {
>   			reg = <0x0 0x8ad00000 0x0 0x500000>;
>   			no-map;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index cc153f4e6979..e15646289bf7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3815,6 +3815,144 @@ nsp_noc: interconnect@a0c0000 {
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> +		remoteproc_cdsp: remoteproc@a300000 {
> +			compatible = "qcom,sc7280-cdsp-pas";
> +			reg = <0 0x0a300000 0 0x10000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +					      <&cdsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover",
> +					  "stop-ack", "shutdown-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "xo";
> +
> +			power-domains = <&rpmhpd SC7280_CX>,
> +					<&rpmhpd SC7280_MX>;
> +			power-domain-names = "cx", "mx";
> +
> +			interconnects = <&nsp_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			memory-region = <&cdsp_mem>;
> +
> +			qcom,qmp = <&aoss_qmp>;
> +
> +			qcom,smem-states = <&cdsp_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_CDSP
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "cdsp";
> +				qcom,remote-pid = <5>;
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "cdsp";
> +					qcom,non-secure-domain;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					compute-cb@1 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <1>;
> +						iommus = <&apps_smmu 0x11a1 0x0420>,
> +							 <&apps_smmu 0x1181 0x0420>;
> +					};
> +
> +					compute-cb@2 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <2>;
> +						iommus = <&apps_smmu 0x11a2 0x0420>,
> +							 <&apps_smmu 0x1182 0x0420>;
> +					};
> +
> +					compute-cb@3 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <3>;
> +						iommus = <&apps_smmu 0x11a3 0x0420>,
> +							 <&apps_smmu 0x1183 0x0420>;
> +					};
> +
> +					compute-cb@4 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <4>;
> +						iommus = <&apps_smmu 0x11a4 0x0420>,
> +							 <&apps_smmu 0x1184 0x0420>;
> +					};
> +
> +					compute-cb@5 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <5>;
> +						iommus = <&apps_smmu 0x11a5 0x0420>,
> +							 <&apps_smmu 0x1185 0x0420>;
> +					};
> +
> +					compute-cb@6 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <6>;
> +						iommus = <&apps_smmu 0x11a6 0x0420>,
> +							 <&apps_smmu 0x1186 0x0420>;
> +					};
> +
> +					compute-cb@7 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <7>;
> +						iommus = <&apps_smmu 0x11a7 0x0420>,
> +							 <&apps_smmu 0x1187 0x0420>;
> +					};
> +
> +					compute-cb@8 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <8>;
> +						iommus = <&apps_smmu 0x11a8 0x0420>,
> +							 <&apps_smmu 0x1188 0x0420>;
> +					};
> +
> +					/* note: secure cb9 in downstream */
> +
> +					compute-cb@11 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <11>;
> +						iommus = <&apps_smmu 0x11ab 0x0420>,
> +							 <&apps_smmu 0x118b 0x0420>;
> +					};
> +
> +					compute-cb@12 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <12>;
> +						iommus = <&apps_smmu 0x11ac 0x0420>,
> +							 <&apps_smmu 0x118c 0x0420>;
> +					};
> +
> +					compute-cb@13 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <13>;
> +						iommus = <&apps_smmu 0x11ad 0x0420>,
> +							 <&apps_smmu 0x118d 0x0420>;
> +					};
> +
> +					compute-cb@14 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <14>;
> +						iommus = <&apps_smmu 0x11ae 0x0420>,
> +							 <&apps_smmu 0x118e 0x0420>;
> +					};
> +				};
> +			};
> +		};
> +
>   		usb_1: usb@a6f8800 {
>   			compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
>   			reg = <0 0x0a6f8800 0 0x400>;
> 
