Return-Path: <linux-kernel+bounces-2998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B28165CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6C81F216A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1CF63CD;
	Mon, 18 Dec 2023 04:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oS6cT2dI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1463A3;
	Mon, 18 Dec 2023 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI3puf4023465;
	Mon, 18 Dec 2023 04:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xeul6s/+w82XEoiq5laE4xHU1pshQdW7eNnWsVjUtQM=; b=oS
	6cT2dIBpQBHFiNCbzIv0FN9LbKAPhGzF9YMCHkX3p4nK58+R5y6z/eu8nE8dvsRu
	P6UdIYtb5hx9eJjL1jiy+2Z+Bw7HNQGl4PiUIRH4i5YP8LjYMuxxNXOi9Hq0ZLKx
	WXSDW+uh7YxkyWp2i12XZGUyhR8LdWubsnOl0dgPuEZDoBlWO4UbLrufSogVor88
	q+q8PhwF4WdV9giruxVEzIg7rukR2CJtKzqR+xu0olZlpMpyhpoJkUt/g5HTeyWF
	O07hAhefgjYFvmOvh2Zzk6nZ7fbYczZv0ua247X0Lll3Q/pX6b+nK3c2DWv5rq1t
	xnZaSgEdK0WaYJRIjwog==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14yg3bm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 04:53:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI4rBb5002672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 04:53:11 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 20:53:07 -0800
Message-ID: <27ee13e7-5073-413c-8481-52b92d7c3687@quicinc.com>
Date: Mon, 18 Dec 2023 12:53:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
 <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>
 <4cb2bd57-f3d3-49f9-9c02-a922fd270572@lunn.ch>
 <ed0dd288-be8a-4161-a19f-2d4d2d17b3ec@quicinc.com>
 <ZXxXzm8hP68KrXYs@shell.armlinux.org.uk>
 <3a40570b-40bf-4609-b1f4-a0a6974accea@quicinc.com>
 <b5ff9f69-e341-4846-bc5a-ebe636b7a71a@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <b5ff9f69-e341-4846-bc5a-ebe636b7a71a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x0p1f1CJREIpgNTp7HVn7JkKP2_GolAg
X-Proofpoint-GUID: x0p1f1CJREIpgNTp7HVn7JkKP2_GolAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=801 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180031



On 12/17/2023 1:17 AM, Andrew Lunn wrote:
>> Yes, Russell, i will add an example in the DT doc in the next patch set.
>> The following is the device node used for the current qca8084 PHY
>> code design.
> 
> If you look at Christians work, this would be expressed differently:
> 
>> mdio: mdio@90000 {
>>      ethernet-phy-package@1 {
>>
>>          compatible = "qca,qca8084-package";
>>
>>          qcom,phy-work-mode = <2>;
>>          clocks = <&qca8k_nsscc NSS_CC_APB_BRIDGE_CLK>,
>>                 <&qca8k_nsscc NSS_CC_AHB_CLK>,
>>                 <&qca8k_nsscc NSS_CC_SEC_CTRL_AHB_CLK>,
>>                 <&qca8k_nsscc NSS_CC_TLMM_CLK>,
>>                 <&qca8k_nsscc NSS_CC_TLMM_AHB_CLK>,
>>                 <&qca8k_nsscc NSS_CC_CNOC_AHB_CLK>,
>>                 <&qca8k_nsscc NSS_CC_MDIO_AHB_CLK>,
>>                 <&qca8k_nsscc NSS_CC_MDIO_MASTER_AHB_CLK>,
>>                 <&qca8k_nsscc NSS_CC_SRDS0_SYS_CLK>,
>>                 <&qca8k_nsscc NSS_CC_SRDS1_SYS_CLK>;
>>          clock-names = "apb_bridge",
>>                  "ahb",
>>                  "sec_ctrl_ahb",
>>                  "tlmm",
>>                  "tlmm_ahb",
>>                  "cnoc_ahb",
>>                  "mdio_ahb",
>>                  "mdio_master_ahb",
>>                  "srds0_sys",
>>                  "srds1_sys";
>>          resets = <&qca8k_nsscc NSS_CC_SRDS0_SYS_ARES>,
>>                 <&qca8k_nsscc NSS_CC_SRDS1_SYS_ARES>,
>>                 <&qca8k_nsscc NSS_CC_DSP_ARES>;
>>          reset-names = "srds0_sys",
>>                        "srds1_sys";
>>
> 
> All the properties above are common to the package as a whole.
> 
> Then follow the four individual PHYs, and the properties which are
> specific to each one.

Thanks Andrew for the proposal.
For the pure PHY chip qca8084, there is no driver to parse the package
level device tree node for common clocks and resets.

For the common clocks and resets above, whether we can add a qca8084
common device tree node as the child node of MDIO bus node, and then
parse these common properties in the PHY probe function? since the DSA
driver is not enabled for the pure PHY chip.

> 
>>
>>          ethernet-phy@0 {
>>              compatible = "ethernet-phy-id004d.d180";
>>              reg = <0>;
>>              clocks = <qca8k_nsscc NSS_CC_GEPHY0_SYS_CLK>,
>>              clock-names = <"gephy_sys">;
>>              resets = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_ARES>,
>>                       <&qca8k_nsscc NSS_CC_GEPHY0_ARES>;
>>              reset-names = "gephy_sys", "gephy_soft";
>>          };
>>      
>>      
>>          ethernet-phy@1 {
>>              compatible = "ethernet-phy-id004d.d180";
>>              reg = <1>;
>>              clocks = <qca8k_nsscc NSS_CC_GEPHY1_SYS_CLK>,
>>              clock-names = <"gephy_sys">;
>>              resets = <&qca8k_nsscc NSS_CC_GEPHY1_SYS_ARES>,
>>                       <&qca8k_nsscc NSS_CC_GEPHY1_ARES>;
>>              reset-names = "gephy_sys", "gephy_soft";
>>      
>>          };
>>      
>>          ethernet-phy@2 {
>>              compatible = "ethernet-phy-id004d.d180";
>>              reg = <2>;
>>              clocks = <qca8k_nsscc NSS_CC_GEPHY2_SYS_CLK>,
>>              clock-names = <"gephy_sys">;
>>              resets = <&qca8k_nsscc NSS_CC_GEPHY2_SYS_ARES>,
>>                       <&qca8k_nsscc NSS_CC_GEPHY2_ARES>;
>>              reset-names = "gephy_sys", "gephy_soft";
>>      
>>          };
>>      
>>          ethernet-phy@3 {
>>              compatible = "ethernet-phy-id004d.d180";
>>              reg = <3>;
>>              clocks = <qca8k_nsscc NSS_CC_GEPHY3_SYS_CLK>,
>>              clock-names = <"gephy_sys">;
>>              reset-names = "gephy_sys", "gephy_soft";
>>          };
>> };
> 
> 	Andrew

