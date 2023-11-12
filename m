Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E77E915B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjKLPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:15:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8F30C2;
        Sun, 12 Nov 2023 07:15:13 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACFF8Ca009251;
        Sun, 12 Nov 2023 15:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=awVhwc95r7LVMY7vgianp7dyrdj/ns31VC3PzNHwCPE=;
 b=nijHx80MuydsrlzNFTtDe2CDAhymcfiWN/vd2obt62fe0SD3slN1BchHjH10HP2Ge4CL
 cu1i9u9Ddt9LN8+UJA2I2VdhUrHCHV+izETfGzM1ODqnHZqvepzeTDoMZvSDbfeEFf2F
 UzbUC3CsOD5SCHYGWkMlt74ucjhe2VtuzJ1EVoexwaioJpu7tmDqVSi4c7w6Js5A7QKV
 1lH/bx5AbCO1eC6/ZUcAG8Kk8r4PoKkYf4EfHqMqoxP3gaFLhVNwoig/xYDbnbA4tkLX
 Wbvielna0KamCqe+n4zBvjW1xowpdmACXIxvQsuFhhBwaABtHnulT3suHUSFyFjuZAjv 7Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2sw1vgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 15:15:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ACFF7Mc001315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 15:15:07 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 12 Nov
 2023 07:15:00 -0800
Message-ID: <b72ad7e7-691d-e85e-f2db-2cac1d489989@quicinc.com>
Date:   Sun, 12 Nov 2023 20:44:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] pinctrl: qcom: Introduce Pinctrl/GPIO for SC8380XP
Content-Language: en-US
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>
References: <20231025135058.11268-1-quic_sibis@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20231025135058.11268-1-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lf409IasT6Z21eXFVBdZk4XBWd_UxzNP
X-Proofpoint-GUID: lf409IasT6Z21eXFVBdZk4XBWd_UxzNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_13,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=587 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120134
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be re-spinning the series with a part numbers change please refrain
from picking this up as is. Thanks.

-Sibi

On 10/25/23 19:20, Sibi Sankar wrote:
> This series adds pinctrl/gpio support for the Qualcomm SC8380XP platform, aka Snapdragon X Elite.
> 
> Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat
> 
> Rajendra Nayak (2):
>    dt-bindings: pinctrl: qcom: Add SC8380XP pinctrl
>    pinctrl: qcom: Add SC8380XP pinctrl driver
> 
>   .../bindings/pinctrl/qcom,sc8380xp-tlmm.yaml  |  143 ++
>   drivers/pinctrl/qcom/Kconfig.msm              |   10 +
>   drivers/pinctrl/qcom/Makefile                 |    1 +
>   drivers/pinctrl/qcom/pinctrl-sc8380xp.c       | 1876 +++++++++++++++++
>   4 files changed, 2030 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8380xp-tlmm.yaml
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sc8380xp.c
> 
