Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B717777B36
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjHJOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjHJOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:46:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987DA211C;
        Thu, 10 Aug 2023 07:46:09 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ACw3eC003346;
        Thu, 10 Aug 2023 14:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5hAeCYRL/Wp9RdpbrzG061TkVG2kWkKxGH2spZL25is=;
 b=GxNI7/9EbsVjeF0+UfR4TmScsagNBfxtlBihGFf/fKfU+VJV/v0is9OQ3ZpCiAS2ZGAp
 yDXQai/dmIDX1lF4aP/2sg+Mt7LfT31svattvsBcc0BYct9AVDf7b4fIy5PguG8IwXyF
 Fv+ufxtLPgLAy26mFMAdGkkfK0FmJ66LoX4B0ziLodspvQvKE3bKucSkNET2VyNp9Ixq
 ejb9WiYmPXWtpzDulEFTeEv0gZaHR8/cS+Yd3JZFDeFwNE2h/gY7G6kOS2xqr9TMmM9j
 enLAIpL8lfv6jv8T+MmIptFLLwa0bxFBiQo15lB3Bj8QHUP1sg5crShOcDGnwzzTUOY7 yw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc5ffbpbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 14:46:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AEk0Ka006823
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 14:46:00 GMT
Received: from [10.216.45.127] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 07:45:56 -0700
Message-ID: <c79f578f-74eb-c6ed-ead6-3058483f9982@quicinc.com>
Date:   Thu, 10 Aug 2023 20:15:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] soc: qcom: llcc: Add support for QDU1000/QRU1000
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pOuLgfQnWFOZI532CYak2ln3IieVsxaB
X-Proofpoint-GUID: pOuLgfQnWFOZI532CYak2ln3IieVsxaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_11,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100126
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nit: Version v7 missed in subject..

-Mukesh

On 8/10/2023 11:41 AM, Komal Bajaj wrote:
> This patch series does the following -
>   * Refactor LLCC driver to support multiple configuration
>   * Add stub function for nvmem_cell_read_u8
>   * Add support for multi channel DDR configuration in LLCC
>   * Add LLCC support for the Qualcomm QDU1000 and QRU1000 SoCs
> 
> Changes in v7 -
>   - Changed the macro name as suggested by Mukesh.
>   - Added NULL check for llcc cfgs as suggested by Mukesh.
>   - Updated the num_config for qdu1000 to use ARRAY_SIZE().
>   - Link to v6: https://lore.kernel.org/lkml/20230802091429.20892-1-quic_kbajaj@quicinc.com/
> 
> Changes in v6 -
>   - Changed variable name from num_cfgs to num_config as suggested by Mukesh.
>   - Added a check for default llcc configuration as per suggestion from Mukesh.
>   - Updated the commit summary for the third and fifth patch.
>   - Fixed alignment in the fourth patch.
>   - Used ARRAY_SIZE() to calculate the num_config as per suggested by Konrad.
>   - Link to v5: https://lore.kernel.org/lkml/20230724084155.8682-1-quic_kbajaj@quicinc.com/
> 
> Changes in v5 -
>   - Separated out the secure qfprom driver changes to a separate series [1].
>   - Created a wrapper struct with a pointer to qcom_llcc_config and
>     length of array qcom_llcc_config.
>   - Added stub function for nvmem_cell_read_u8.
>   - Split commit 6/6 in the previous series into two commits.
>   - Link to v4: https://lore.kernel.org/lkml/20230623141806.13388-1-quic_kbajaj@quicinc.com/
> 
> Changes in v4 -
>   - Created a separate driver for reading from secure fuse region as suggested.
>   - Added patch for dt-bindings of secure qfprom driver accordingly.
>   - Added new properties in the dt-bindings for LLCC.
>   - Implemented new logic to read the nvmem cell as suggested by Bjorn.
>   - Separating the DT patches from this series as per suggestion.
>   - Link to v3: https://lore.kernel.org/lkml/20230512122134.24339-1-quic_kbajaj@quicinc.com/
> 
> Changes in v3 -
>   - Addressed comments from Krzysztof and Mani.
>   - Using qfprom to read DDR configuration from feature register.
>   - Link to v2: https://lore.kernel.org/lkml/20230313124040.9463-1-quic_kbajaj@quicinc.com/
> 
> Changes in v2:
>    - Addressing comments from Konrad.
>    - Link to v1: https://lore.kernel.org/lkml/20230313071325.21605-1-quic_kbajaj@quicinc.com/
> 
> [1] https://lore.kernel.org/linux-arm-msm/20230724082946.7441-1-quic_kbajaj@quicinc.com/
> 
> Komal Bajaj (6):
>    dt-bindings: cache: qcom,llcc: Add LLCC compatible for QDU1000/QRU1000
>    soc: qcom: llcc: Refactor llcc driver to support multiple
>      configuration
>    nvmem: core: Add stub for nvmem_cell_read_u8
>    soc: qcom: Add LLCC support for multi channel DDR
>    soc: qcom: llcc: Updating the macro name
>    soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support
> 
>   .../devicetree/bindings/cache/qcom,llcc.yaml  |  10 +
>   drivers/soc/qcom/llcc-qcom.c                  | 363 +++++++++++++-----
>   include/linux/nvmem-consumer.h                |   6 +
>   include/linux/soc/qcom/llcc-qcom.h            |   2 +-
>   4 files changed, 293 insertions(+), 88 deletions(-)
> 
> --
> 2.41.0
> 
