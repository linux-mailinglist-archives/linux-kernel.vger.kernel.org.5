Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02E79DEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbjIMDdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjIMDdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:33:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F42170F;
        Tue, 12 Sep 2023 20:33:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D1VVes023409;
        Wed, 13 Sep 2023 03:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uFJyocmED4hz9zxf654Kw/VEVbsiQNhYNzZor0D7cI4=;
 b=kdcfk6CBHJEirtPrhb+oIGZax1z1OU+em6Eq6ZrV5oFWju/n1e2TF6lP1ZJOXx4wm0Qu
 /F5GPLm7uwz0CWC24AMg4MFRDjHGU7Wr/gFnREG3clJw9ScDnzZKZLu+fSCnCXpvrAuN
 STBJ2ilabS70foGDDalHOojEfyZG1wJDBAehIXYJ2tnHjPejnIraLQypXpRhDWB5EtH/
 WP1/G2/jnCFZRofGWOmK7nIg2sUR6v6fa+AtyvWftyaQ+6O7+xheg365PEIhZ8Mi6amn
 I+h8kkcey+kLzM4h44yj7ztus8uboGNSTRXquxfNO9GDJLoRFBct1LSUJ0XxPGQmQplF eg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t2y7q8mer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 03:32:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38D3WT0f004638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 03:32:29 GMT
Received: from [10.216.41.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 12 Sep
 2023 20:32:21 -0700
Message-ID: <ef61cef0-fd3a-d89c-b73e-b10e63fa7789@quicinc.com>
Date:   Wed, 13 Sep 2023 09:02:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc
 node
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <quic_saahtoma@quicinc.com>
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-7-quic_devipriy@quicinc.com>
 <CAA8EJpo75zWLXuF-HC-Xz+6mvu_S1ET-9gzW=mOq+FjKspDwhw@mail.gmail.com>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <CAA8EJpo75zWLXuF-HC-Xz+6mvu_S1ET-9gzW=mOq+FjKspDwhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gApxFy5Cy_uY5wxT9JTOvWBqjExHH7f3
X-Proofpoint-ORIG-GUID: gApxFy5Cy_uY5wxT9JTOvWBqjExHH7f3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 4:58 PM, Dmitry Baryshkov wrote:
> On Fri, 25 Aug 2023 at 12:15, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>
>> Add a node for the nss clock controller found on ipq9574 based devices.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V2:
>>          - Dropped the fixed clock node gcc_gpll0_out_aux and added
>>            support for the same in gcc driver
>>          - Updated the node name to clock-controller@39b00000
>>          - Added clock-names to retrieve the nssnoc clocks and add them
>>            to the list of pm clocks in nss driver
>>
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 48 +++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 51aba071c1eb..903311547e96 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -10,6 +10,8 @@
>>   #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
>> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
>>   #include <dt-bindings/thermal/thermal.h>
>>
>>   / {
>> @@ -18,6 +20,24 @@ / {
>>          #size-cells = <2>;
>>
>>          clocks {
>> +               bias_pll_cc_clk: bias-pll-cc-clk {
>> +                       compatible = "fixed-clock";
>> +                       clock-frequency = <1200000000>;
>> +                       #clock-cells = <0>;
>> +               };
>> +
>> +               bias_pll_nss_noc_clk: bias-pll-nss-noc-clk {
>> +                       compatible = "fixed-clock";
>> +                       clock-frequency = <461500000>;
>> +                       #clock-cells = <0>;
>> +               };
>> +
>> +               bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
>> +                       compatible = "fixed-clock";
>> +                       clock-frequency = <353000000>;
>> +                       #clock-cells = <0>;
>> +               };
> 
> Which part provides these clocks?
The Bias PLL generates these clocks based on the reference clock.
> 
>> +
>>                  sleep_clk: sleep-clk {
>>                          compatible = "fixed-clock";
>>                          #clock-cells = <0>;
>> @@ -722,6 +742,34 @@ frame@b128000 {
>>                                  status = "disabled";
>>                          };
>>                  };
>> +
>> +               nsscc: clock-controller@39b00000 {
>> +                       compatible = "qcom,ipq9574-nsscc";
>> +                       reg = <0x39b00000 0x80000>;
>> +                       clocks = <&gcc GCC_NSSNOC_NSSCC_CLK>,
>> +                                <&gcc GCC_NSSNOC_SNOC_CLK>,
>> +                                <&gcc GCC_NSSNOC_SNOC_1_CLK>,
>> +                                <&bias_pll_cc_clk>,
>> +                                <&bias_pll_nss_noc_clk>,
>> +                                <&bias_pll_ubi_nc_clk>,
>> +                                <&gcc GPLL0_OUT_AUX>,
>> +                                <0>,
>> +                                <0>,
>> +                                <0>,
>> +                                <0>,
>> +                                <0>,
>> +                                <0>,
>> +                                <&xo_board_clk>;
> 
> If you move xo_board closer to the start of the list, it will be
> slightly easier to review.
Sure okay
> 
>> +                       clock-names = "nssnoc_nsscc", "nssnoc_snoc", "nssnoc_snoc_1",
>> +                                     "bias_pll_cc_clk", "bias_pll_nss_noc_clk",
>> +                                     "bias_pll_ubi_nc_clk", "gpll0_out_aux", "uniphy0_nss_rx_clk",
>> +                                     "uniphy0_nss_tx_clk", "uniphy1_nss_rx_clk",
>> +                                     "uniphy1_nss_tx_clk", "uniphy2_nss_rx_clk",
>> +                                     "uniphy2_nss_tx_clk", "xo_board_clk";
> 
> You are using clock indices. Please drop clock-names.
Sure okay

Thanks,
Devi Priya
> 
>> +                       #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>> +                       #power-domain-cells = <1>;
>> +               };
>>          };
>>
>>          thermal-zones {
>> --
>> 2.34.1
>>
> 
> 
