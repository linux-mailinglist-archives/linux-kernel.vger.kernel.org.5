Return-Path: <linux-kernel+bounces-73024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6781385BC40
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D978282798
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785DA6A02F;
	Tue, 20 Feb 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UTizOyuf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F956997D;
	Tue, 20 Feb 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432329; cv=none; b=n7iJZB1sHtBLw86OotYGRSJHXBG7scCprEpfyU/Wi5eBR6CjP7yz8qBeAGvfxvXv99B3OdnjeHrYaH+XIRWDywd7dZrh7M28FfGFFjZjAceKw0/9Qs+uDDEsNc73H+wf9slzYBg2zNR8vbD12aHiAB/wRKVzIRuVTYOKGwJyo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432329; c=relaxed/simple;
	bh=sllmESvhwefKtD+mcwJUgwkGcuVOxcsWD1b0mvfzBoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FMPoHJy+3GvEc24jKldlSyLhdQyNPeh/pHUrxq9rZ7XDzJPlBsx4RF1z0IWi4aHeVu6jyrDstPIFu2a5x5Usekv/EYevXw6sdi/3CaipEDFSiLXv/GOouMM4o6Fp7hlp5ZOWdaZUK9hCvKYSxqUKX3o7iOCevEJxMAQNxs7T/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UTizOyuf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KAEioE025078;
	Tue, 20 Feb 2024 12:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+LpGty1WpTBAu3u7mkOybl2Gl1+n/qkpH75rRLI6A+8=; b=UT
	izOyufZn3dlb5lmhN0gMUnMZUzW3VhGArJoLZZ3pVDpdRNq9pJOp8px/4VG4wqt8
	GWi0oktlhZLirGRpZGdf+HSOr/KT3gl+LzHndOrkK+NFiyhBd0Ql4fQQ8ma8y8yO
	hBSLciudHciG4YxG/hl4LMkDl8lyXoXw1oMlpENSKM/9esowMnsyfYzhH1Pyfdzs
	t3X5AQdus8elLzYDZ+JZNrZMCaY9CPJv3KivhIkkLx1fLEFzi82afhUe+2gKlgih
	R6SzJzxUA3cbfj8CYY81fYbIpKjJQGQn/06IMovG0w/4b3QJoWUUcRd8zryFxOcM
	gxygtLWW+rdzt2+iR/kA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct5787v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:31:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KCVlQS017701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:31:47 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:31:41 -0800
Message-ID: <3e1e56dc-adb6-e4ec-b99b-688c707ddf0a@quicinc.com>
Date: Tue, 20 Feb 2024 18:01:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/5] arm64: dts: qcom: ipq9574: Add SPI nand support
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-5-quic_mdalam@quicinc.com>
 <17c6b3df-2acd-45e2-8167-02c629b1e972@quicinc.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <17c6b3df-2acd-45e2-8167-02c629b1e972@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: St93OQcwmYXz7tjkL789OcImyOxEtwXK
X-Proofpoint-GUID: St93OQcwmYXz7tjkL789OcImyOxEtwXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402200090



On 2/16/2024 9:10 PM, Kathiravan Thirumoorthy wrote:
> 
> 
> On 2/15/2024 7:18 PM, Md Sadre Alam wrote:
>> Add SPI NAND support for ipq9574 SoC.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>   .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 43 +++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 27 ++++++++++++
>>   2 files changed, 70 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>> index 91e104b0f865..5b54a027fa5d 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>> @@ -139,6 +139,49 @@ gpio_leds_default: gpio-leds-default-state {
>>           drive-strength = <8>;
>>           bias-pull-up;
>>       };
>> +
>> +    qpic_snand_default_state: qpic-snand-default-state {
>> +        clock-pins {
>> +            pins = "gpio5";
>> +            function = "qspi_clk";
>> +            drive-strength = <8>;
>> +            bias-disable;
>> +        };
>> +
>> +        cs-pins {
>> +            pins = "gpio4";
>> +            function = "qspi_cs";
>> +            drive-strength = <8>;
>> +            bias-disable;
>> +        };
>> +
>> +        data-pins {
>> +            pins = "gpio0", "gpio1", "gpio2";
> 
> 
> As per the pinctrl driver[1], there are 4 data pins.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/qcom/pinctrl-ipq9574.c#n296

   Will fix in next patch.
> 
> 
>> +            function = "qspi_data";
>> +            drive-strength = <8>;
>> +            bias-disable;
>> +        };
>> +    };
>> +};
>> +
>> +&qpic_bam {
>> +    status = "okay";
>> +};
>> +
>> +&qpic_nand {
>> +    pinctrl-0 = <&qpic_snand_default_state>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +
>> +    flash@0 {
>> +        compatible = "spi-nand";
>> +        reg = <0>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        nand-ecc-engine = <&qpic_nand>;
>> +        nand-ecc-strength = <4>;
>> +        nand-ecc-step-size = <512>;
>> +    };
>>   };
>>   &usb_0_dwc3 {
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 7f2e5cbf3bbb..d963dd2035dd 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -319,6 +319,33 @@ tcsr: syscon@1937000 {
>>               reg = <0x01937000 0x21000>;
>>           };
>> +        qpic_bam: dma-controller@7984000 {
> 
> 
> Nodes should be ordered by unit address in ascending order. So please move these nodes to the right place.
  Ok
> 
> 
>> +            compatible = "qcom,bam-v1.7.0";
>> +            reg = <0x7984000 0x1c000>;
> 
> 
> address should be padded to 8 bytes.
Ok
> 
>> +            interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&gcc GCC_QPIC_AHB_CLK>;
>> +            clock-names = "bam_clk";
>> +            #dma-cells = <1>;
>> +            qcom,ee = <0>;
>> +            status = "disabled";
>> +        };
>> +
>> +        qpic_nand: spi@79b0000 {
>> +            compatible = "qcom,ipq9574-snand";
>> +            reg = <0x79b0000 0x10000>;
> 
> 
> Ditto..
Ok
> 
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            clocks = <&gcc GCC_QPIC_CLK>,
>> +            <&gcc GCC_QPIC_AHB_CLK>,
>> +            <&gcc GCC_QPIC_IO_MACRO_CLK>;
> 
> 
> Fix the alignment.
Ok
> 
>> +            clock-names = "core", "aon", "iom";
>> +            dmas = <&qpic_bam 0>,
>> +                <&qpic_bam 1>,
>> +                <&qpic_bam 2>;
> 
> 
> Here as well.
Ok
> 
> 
>> +            dma-names = "tx", "rx", "cmd";
>> +            status = "disabled";
>> +        };
>> +
>>           sdhc_1: mmc@7804000 {
>>               compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
>>               reg = <0x07804000 0x1000>,

