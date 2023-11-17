Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2A7EEFBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbjKQKGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjKQKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:06:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60437B0;
        Fri, 17 Nov 2023 02:05:56 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH4YImN014405;
        Fri, 17 Nov 2023 10:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RTLiox/mifORbRB6ih+BFAwXXdRUmyiZAnvIy+pBRxg=;
 b=Zt0sv5XgyciIhyAbgOl9wQhFrrC8aVK7iIvYR4ufcNCunidEw2q6UncKIaDfbiKEbtmL
 KZ9Pz1cbqVsxXIjjlfkKl3kalo66/Z/tnpTgb4Iw21SkwaAQK0z09GJmIju0ZUtPscK3
 0fE+T7u0s/ZaNCmcccXttwmO6VyD4drgbza9K9pN6BD9qJoBQWVWLBSv5YokG4h7v8Vq
 S69kwPpEqlhNpGwNr76oXrOqI1kvKNnwrc6pEMHfzktc3Ebf3MtLZX0Uw6miH8WtXM5J
 BUxBpT1A+FiX8yLCFrb/OlxWFhYAKtulKIRGESnjNK8bpOHLPa8MafFH03EWR6YSU1fI lA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udw1s92g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:05:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHA5hh8029407
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 10:05:43 GMT
Received: from [10.253.8.81] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 02:05:39 -0800
Message-ID: <02603c3d-a509-4bdd-a67b-7f494df4eeba@quicinc.com>
Date:   Fri, 17 Nov 2023 18:05:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Robert Marko <robert.marko@sartura.hr>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-9-quic_luoj@quicinc.com>
 <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
 <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
 <CA+HBbNGnEneK8S+dZM6iS+C8jFnEtg4Wpe2tBBoP+Y_H0ZmyWA@mail.gmail.com>
 <d677e73a-5ca2-4034-9b4b-1e6140601066@quicinc.com>
 <f5da6540-e532-4b83-890d-2ffdf4bf6fcc@lunn.ch>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <f5da6540-e532-4b83-890d-2ffdf4bf6fcc@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CGznaSBeDUHJP0lvNmKozXD0dScTmbO3
X-Proofpoint-GUID: CGznaSBeDUHJP0lvNmKozXD0dScTmbO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_07,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=743 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311170074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2023 1:08 AM, Andrew Lunn wrote:
>> Yes, the clock driver of qca8084 is probed as the MDIO device, the
>> configuration sequence here to lighten the qca8084 PHY need to
>> be completed before the clock APIs available to call.
> 
> Please cleanly separate clock from MDIO. The MDIO driver should only
> use the common clock framework API calls. If the clock driver is not
> loaded yet, trying to get a clock should return -EPROBE_DEFER. The
> MDIO driver should return that from its probe function. The driver
> core will then try to probe the MDIO driver later, by which time the
> clock driver should of loaded.
> 
>        Andrew
> 

Ok, will update the patches to take this solution using the clock
consume APIs. Thanks Andrew for the suggestion.
