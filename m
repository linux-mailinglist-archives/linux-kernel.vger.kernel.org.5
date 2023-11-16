Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FCA7EDDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjKPJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjKPJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:36:26 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354C01BC0;
        Thu, 16 Nov 2023 01:36:10 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG5AkBw032381;
        Thu, 16 Nov 2023 09:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GEuP6Rpji2X+1oMcUTO94Nar7xPCb3N4/EUxMMrf/9g=;
 b=ePhMpjb+EHMZuVH+IIKJnXvKthI7OxRzandm8JFsCLlW7ZWEDuXik7els5LAUytggbkx
 j8djCv7k4gTwFdD/U3yAjnyB+RmbD+EKpxvvi62YmvTmxynOwRMmHZ35OLLMecdMYB0K
 isjUeDf8u2SdQCzILgzexB2hYz7ZQ4PGyMKTYMESGY0udqT/divkIbKV8buQmXAdBlFx
 8lVQxLT3SSw1nJ0Xd3loQYbCw1ok+AJF1JyDlVz8zLMthNj7zfL+WLjl0Npbp+w8LK4k
 suxENXthknOakvv0sNewPJs8JYSf5BhrBwOULXP8OeJjTbCxYrrvQ8QRc1DmEifmUYG+ 6A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud1k51vg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:35:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG9Ztg8028243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:35:55 GMT
Received: from [10.253.72.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 01:35:52 -0800
Message-ID: <ccb4bdbd-b7d7-49f0-b8f4-6ea13a4ab407@quicinc.com>
Date:   Thu, 16 Nov 2023 17:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] net: mdio: ipq4019: increase eth_ldo_rdy for ipq5332
 platform
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-2-quic_luoj@quicinc.com>
 <c7ae6561-fbcc-40d9-a02c-61fc76e089d0@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <c7ae6561-fbcc-40d9-a02c-61fc76e089d0@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TH3DcYruvcjW6eYr3stYd3ERefWUPhEi
X-Proofpoint-ORIG-GUID: TH3DcYruvcjW6eYr3stYd3ERefWUPhEi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=592 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 9:44 PM, Andrew Lunn wrote:
>> +	for (ret = 0; ret < ETH_LDO_RDY_CNT; ret++) {
>> +		if (priv->eth_ldo_rdy[ret]) {
>> +			val = readl(priv->eth_ldo_rdy[ret]);
>> +			val |= BIT(0);
>> +			writel(val, priv->eth_ldo_rdy[ret]);
>> +			fsleep(IPQ_PHY_SET_DELAY_US);
>> +		}
> 
> Please add a new variable, rather than use ret this way.

OK, will add it in the next patch set.

> 
>> +	for (ret = 0; ret < ETH_LDO_RDY_CNT; ret++) {
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, ret + 1);
>> +		if (res)
>> +			priv->eth_ldo_rdy[ret] = devm_ioremap(&pdev->dev,
> 
> same here.

Ok.

> 
>      Andrew
> 
> ---
> pw-bot: cr
