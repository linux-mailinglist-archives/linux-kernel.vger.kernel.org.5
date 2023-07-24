Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BE775EDFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjGXIlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGXIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:41:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0020D1BDF;
        Mon, 24 Jul 2023 01:41:01 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O8Tdkp007381;
        Mon, 24 Jul 2023 08:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=feNvEr6+cV3XbdbYSQJm8tdbNPajljG0BvdcnvgF9zA=;
 b=LUjT57w4WnKicUHcirPV6ePFKlX9RVSRO3eRebM4BLMYb1BzJLk8CfcR0o1zWJjK2jEG
 eFfKTWCsqOdG70owGmN16/JLSR5I2DhdVSyljzMBvzt707iJXvh0HTulRULwSFaY8u13
 bdpz6Ym2W72B9ZWGA71v5cowgLX7HcKUydxoBn7/Pdjf4ti0bZX4ExZhst7EEDcHx2u7
 Rg0y2PGqe7E6B3Epv5RumGweS90lHKwAXx0Bj0rxBe19T0X8OIcr8C/IJWde8cCv9o8J
 JKXzRpnZufj1nsGP72vxQzZk5exmreK4FbeMqC34I0FK2vt8vf18uceldNBCeQjdz5wG zg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s07vp2qus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:40:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36O8esbm004223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:40:54 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 01:40:49 -0700
Message-ID: <15e5e159-643e-06bd-c6a3-51e4935d340f@quicinc.com>
Date:   Mon, 24 Jul 2023 14:10:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 0/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
Content-Language: en-US
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EDBsCmVVYOwxrXq38GMZwNyuBbOrx4NP
X-Proofpoint-ORIG-GUID: EDBsCmVVYOwxrXq38GMZwNyuBbOrx4NP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=672 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240077
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the spam, sent the same series twice.

Thanks
Komal

On 7/24/2023 2:08 PM, Komal Bajaj wrote:
> Changes in v5 -
>   - Separating this from original series [1].
>   - Added description of driver to secure qfprom binding.
>   - Replaced pm_runtime_enable() withh devm_pm_runtime_enable().
>   - Changed module license to GPL instead of GPL v2.
>
> This series introduces a new driver for reading secure fuse region and adding
> dt-bindings for same.
>
> [1] https://lore.kernel.org/linux-arm-msm/20230623141806.13388-1-quic_kbajaj@quicinc.com/
>
>
> Komal Bajaj (2):
>    dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
>    nvmem: sec-qfprom: Add Qualcomm secure QFPROM support
>
>   .../bindings/nvmem/qcom,sec-qfprom.yaml       |  58 ++++++++++
>   drivers/nvmem/Kconfig                         |  13 +++
>   drivers/nvmem/Makefile                        |   2 +
>   drivers/nvmem/sec-qfprom.c                    | 101 ++++++++++++++++++
>   4 files changed, 174 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
>   create mode 100644 drivers/nvmem/sec-qfprom.c
>
> --
> 2.40.1
>

