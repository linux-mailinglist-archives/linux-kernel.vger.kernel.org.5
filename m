Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE57A724C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjITFrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:47:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E1E93;
        Tue, 19 Sep 2023 22:46:58 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K1pXlF018157;
        Wed, 20 Sep 2023 05:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6GHobqcPI1lLFkVx12BnXxNNr9ekUB2VMvDMISqHT2g=;
 b=gNtvTO5D9klZn6MDgxGPZeQcKlA+m/nfXRWomtNfCbzbRwUW/+yJcZhuOD8YdtxCF6Hg
 zOi/l8Cd0ucFjuH9CvIHjjV2WXopSezpr/pLwXDE6rXevodSXhiLpF7UQ97wvOT6WAX2
 t+7kxz+r5uv0i6z/MMbCeK60kgMtUlZ7k+3WwICM9FE/gVbVQ6q7URMrABiGEKM7Brfp
 gSfHIW4CjoSWhlGyUJ5TJdEL+/hnSXso8dMTm0XMI22JIqfv3L4iZbcAd/DFlQtmo/39
 S/P0kLjesKR47EfDEb38W5aTJjcT3MuEu429xZhwHJyTqwQBVAo+M3ocv9sMuUnupj7C xQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t79182aq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:46:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K5kC3N032083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 05:46:12 GMT
Received: from [10.239.132.204] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 22:46:03 -0700
Message-ID: <47d7da41-9d43-4042-b185-709047a1d4b5@quicinc.com>
Date:   Wed, 20 Sep 2023 13:46:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: add uart console support for
 SM4450
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>,
        <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-9-quic_tengfan@quicinc.com>
 <ieoxb7avgrmty7ktuycvkdf3sgfzw5jjkxuo3br3nfctg2hj7v@7jzeofaal7sy>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <ieoxb7avgrmty7ktuycvkdf3sgfzw5jjkxuo3br3nfctg2hj7v@7jzeofaal7sy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q35eD4NWgrdACoeltD4MT7gA1WsJhFk0
X-Proofpoint-GUID: q35eD4NWgrdACoeltD4MT7gA1WsJhFk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/20/2023 11:47 AM, Bjorn Andersson 写道:
> On Fri, Sep 15, 2023 at 10:15:08AM +0800, Tengfei Fan wrote:
>> Add base description of UART, TLMM, interconnect, TCSRCC and SMMU nodes
>> which helps SM4450 boot to shell with console on boards with this SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts |  18 +-
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi    | 313 +++++++++++++++++++++---
>>   2 files changed, 301 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> index 00a1c81ca397..0f253a2ba170 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> @@ -10,9 +10,23 @@
>>   	model = "Qualcomm Technologies, Inc. SM4450 QRD";
>>   	compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>>   
>> -	aliases { };
>> +	aliases {
>> +		serial0 = &uart7;
>> +	};
>>   
>>   	chosen {
>> -		bootargs = "console=hvc0";
>> +		stdout-path = "serial0:115200n8";
>>   	};
>>   };
>> +
>> +&qupv3_id_0 {
>> +	status = "okay";
>> +};
>> +
>> +&tlmm {
>> +	gpio-reserved-ranges = <0 4>, <136 1>;
>> +};
>> +
>> +&uart7 {
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
> [..]
>> +		qupv3_id_0: geniqup@ac0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0x0 0x00ac0000 0x0 0x2000>;
>> +			ranges;
>> +			clock-names = "m-ahb", "s-ahb";
>> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>> +			iommus = <&apps_smmu 0x163 0x0>;
>> +			interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>;
>> +			interconnect-names = "qup-core";
> 
> The patch ends up adding a smorgasbord of different things, some of
> which do relate to giving you a console and others mostly not related at
> all, because of the iommus and interconnects here.
> 
> If you omit these three properties from this, you can add the
> console, then add iommu and interconnect nodes in three clear patches.
> 
> 
> PS. Commit message says this is all needed for boot-to-shell, but I
> don't think you need scm, nor tcsr nodes to achieve that.
> 
> Regards,
> Bjorn

Hi Bjorn,
checked and confirmed your comments, you are right, will remove not 
related code.

-- 
Thx and BRs,
Tengfei Fan
