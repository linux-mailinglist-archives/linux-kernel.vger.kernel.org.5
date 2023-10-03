Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B335C7B6B80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbjJCO2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJCO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:28:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E32A3;
        Tue,  3 Oct 2023 07:28:46 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393EQI8A013770;
        Tue, 3 Oct 2023 14:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ExWq9EdzaPi01pk0kQhkIduT1l/I3/KRXIIRj205f8o=;
 b=T5kB2lLgkvfJl688l1f3hE8YucITCqT08aDsMeuUL00Ojj6XLRS+s98eEH6D5/cV+UN9
 FtSQzpZ4c4Q/D1e6mRJroaEH4/VPK4CMUDRdoRKUFgR2z57z7B6Ty0EGJl+O4/zOpB7L
 Jcv6rqHgKnw6KW7qxNVhPXYhyo2Dfx1AEco7QJD2swCqdFbx/7RlC6ebPEgPgyeQNp0M
 fWN62B4XYjj0mooRloEbgxX830MnH4wWIXNni8Cta4wdmVxsoUjwwk7l0G7iO3/zGX4m
 7jGIK+j0/k6VeyIihs0n+f6iUxXdmvUNBAzTlOvBfhjLbzF6SF+B67S8JMWix70jo4Vc Cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgaw5h7md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 14:28:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393ESHM1030055
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 14:28:17 GMT
Received: from [10.216.32.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 3 Oct
 2023 07:28:07 -0700
Message-ID: <49bb695e-cb7b-41bf-a3ac-71a8a8417c9f@quicinc.com>
Date:   Tue, 3 Oct 2023 19:58:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: qcom: ipq5332: Add USB Super-Speed PHY
 node
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>, <quic_wcheng@quicinc.com>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_kathirav@quicinc.com>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-4-quic_ipkumar@quicinc.com>
 <5bf11343-6ab4-43a8-b12d-f2b072ce388a@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <5bf11343-6ab4-43a8-b12d-f2b072ce388a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kAlSabW30WWtkJdpmGMUADo_4iEbSRCh
X-Proofpoint-GUID: kAlSabW30WWtkJdpmGMUADo_4iEbSRCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_11,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=751 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2023 10:52 PM, Dmitry Baryshkov wrote:
> On 29/09/2023 11:42, Praveenkumar I wrote:
>> Add USB Super-Speed UNIPHY node and populate the phandle on
>> gcc node for the parent clock map.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index d3fef2f80a81..b08ffd8c094e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -158,6 +158,29 @@ usbphy0: phy@7b000 {
>>               status = "disabled";
>>           };
>>   +        usbphy1: phy@4b0000 {
>
> Are there other USB PHYs on this platform?
No. Only two USB PHYs.
>
>> +            compatible = "qcom,ipq5332-usb-uniphy";
>> +            reg = <0x4b0000 0x800>;
>> +
>> +            clocks = <&gcc GCC_PCIE3X1_PHY_AHB_CLK>,
>> +                 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
>> +                 <&gcc GCC_USB0_PIPE_CLK>;
>> +            clock-names = "ahb",
>> +                      "cfg_ahb",
>> +                      "pipe";
>> +
>> +            resets =  <&gcc GCC_USB0_PHY_BCR>;
>> +
>> +            #clock-cells = <0>;
>> +            clock-output-names = "usb0_pipe_clk_src";
>
> I'm not sure, what is the best approach her. For QMP USB and PCIe PHYs 
> we had to use fixed names historically. On the other hand for QMP DP 
> clocks we are fine with the generated names. I'd prefer the latter case.
Sure, will use the generated names.
>
>> +
>> +            qcom,phy-usb-mux-sel = <&tcsr 0x10540>;
>> +
>> +            #phy-cells = <0>;
>> +
>> +            status = "disabled";
>> +        };
>> +
>>           qfprom: efuse@a4000 {
>>               compatible = "qcom,ipq5332-qfprom", "qcom,qfprom";
>>               reg = <0x000a4000 0x721>;
>> @@ -200,7 +223,7 @@ gcc: clock-controller@1800000 {
>>                    <&sleep_clk>,
>>                    <0>,
>>                    <0>,
>> -                 <0>;
>> +                 <&usbphy1>;
>>           };
>>             tcsr_mutex: hwlock@1905000 {
>
--
Thanks,
Praveenkumar
