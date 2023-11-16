Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2067EDEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbjKPKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345047AbjKPKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:48:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5618B;
        Thu, 16 Nov 2023 02:48:53 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG4r8A2027231;
        Thu, 16 Nov 2023 10:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J/GfrTozsME6TxWB6Io+G6rYB6XogVeT7NQ1aAvCyrE=;
 b=WHqdBDWc/J6jobRFhpx+Yr/6hjfHtfqJuPYh3z4lXevgRxd942vm6kZwd/EXnGMz2Xli
 OPoUQvJ1Y0I2jyyYVNLS2IZNBXNWzwBYwMc9FpSE4MtpNKzkOF4pdH2MZEp/WojJv4Vl
 xNVljAHurZxGTlusa2ATGPRA7IIWzkYxoPPFJdIL7F27wOvH3WBJgNuRzaHa2PKAGFBQ
 bcXu6MRvG1FzYEx0pRNX0FEhJ7hgnZ8CDtgFJIxUTpCGeVjP6USYqi7cx9QLDSGLxra5
 amERxp2mebbjlDdUGvkberZOfrDR0uW2N+f0AGjDLWOO+ZeMOL4K3z7073SCnXSERhi4 GQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud6echbe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:48:40 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGAmdO9031656
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:48:39 GMT
Received: from [10.253.72.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 02:48:34 -0800
Message-ID: <4cdaf41c-6cc0-470f-97a7-8b08fdde7f6c@quicinc.com>
Date:   Thu, 16 Nov 2023 18:48:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] net: mdio: ipq4019: configure CMN PLL clock for
 ipq5332
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
 <20231115032515.4249-5-quic_luoj@quicinc.com>
 <e1fecfd7-3de1-4719-879b-fd486fdc3815@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <e1fecfd7-3de1-4719-879b-fd486fdc3815@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xQMCGXHJXj6dafljrE4_RKd20FN4NeAo
X-Proofpoint-ORIG-GUID: xQMCGXHJXj6dafljrE4_RKd20FN4NeAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=783 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 11:19 PM, Andrew Lunn wrote:
>> +static void ipq_cmn_clock_config(struct mii_bus *bus)
>> +{
>> +	u32 reg_val;
>> +	const char *cmn_ref_clk;
>> +	struct ipq4019_mdio_data *priv = bus->priv;
> 
> Reverse christmass tree place.

will fix it in the next patch set.

> 
>> +
>> +	if (priv && priv->cmn_membase) {
> 
> Can priv be NULL? Can cmn_membase be NULL?

priv can't be NULL, cmn_membase is optional, the legacy chip does not
provide the cmn_membase in device node.

will remove the priv check here.

> 
>> +		reg_val = readl(priv->cmn_membase + CMN_PLL_REFERENCE_CLOCK);
>> +		reg_val &= ~(CMN_PLL_REFCLK_EXTERNAL | CMN_PLL_REFCLK_INDEX);
>> +
>> +		/* Select reference clock source */
>> +		cmn_ref_clk = of_get_property(bus->parent->of_node, "cmn_ref_clk", NULL);
>> +		if (!cmn_ref_clk) {
>> +			/* Internal 48MHZ selected by default */
>> +			reg_val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
>> +		} else {
>> +			if (!strcmp(cmn_ref_clk, "external_25MHz"))
> 
> Not strings, please use u32 values. You can then list the valid values
> in the yaml file, and get te tools to verify the DT.

will update this in the next patch.

> 
>> +				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
>> +					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 3));
>> +			else if (!strcmp(cmn_ref_clk, "external_31250KHz"))
>> +				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
>> +					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 4));
>> +			else if (!strcmp(cmn_ref_clk, "external_40MHz"))
>> +				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
>> +					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 6));
>> +			else if (!strcmp(cmn_ref_clk, "external_48MHz"))
>> +				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
>> +					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7));
>> +			else if (!strcmp(cmn_ref_clk, "external_50MHz"))
>> +				reg_val |= (CMN_PLL_REFCLK_EXTERNAL |
>> +					    FIELD_PREP(CMN_PLL_REFCLK_INDEX, 8));
>> +			else
>> +				reg_val |= FIELD_PREP(CMN_PLL_REFCLK_INDEX, 7);
> 
> If the value is not valid, return -EINVAL.

will add it in the next patch set.

> 
>     Andrew
