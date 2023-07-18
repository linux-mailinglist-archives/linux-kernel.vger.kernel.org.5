Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F46D75795E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGRKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGRKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:37:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978BCF0;
        Tue, 18 Jul 2023 03:37:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I4uRuo001695;
        Tue, 18 Jul 2023 10:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LOy8dN1LMbsCPe8GwGrP+qIqVm7Ey3w4gxhyogzgpfg=;
 b=LLNZeg0JY3l6X0hKzNOnSDPaxZknClwT1ccScobiHuXLhGG4oVXB7wqCvyNYVYltZNcq
 6czvSf/dBpI+TbidXq8TzJUBo2bSStjd7khsCSWV4tIfKCMfQAYaHip4YD7bUxtvgj7B
 qQNyMvfopOXxXShiENCm/i8YQImp/I+V0vhv5leBnNpzWwQMABbYqGekvvJnvfQrwCTe
 NFCmdGy6MKZYfCec385UWXDcdK+Rl1ALIA51HBLuxXnuHykGKVqRwG9avVv7IQhSXKLa
 XPrj+e1Nmg9pIkzU2eLxie0VbvVdpff4jmnwoHHWBXYTITGWYzGTpyqoDaa8A/UZmnuu fw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwcg6se9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 10:37:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36IAbqOw002970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 10:37:52 GMT
Received: from [10.218.15.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 03:37:48 -0700
Message-ID: <d954ee43-d0cc-ef2b-8467-57883e9defd7@quicinc.com>
Date:   Tue, 18 Jul 2023 16:07:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 0/2] spi-geni-qcom: Add SPI device mode support for
 GENI based QuPv3
Content-Language: en-CA
To:     Praveen Talari <quic_ptalari@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_arandive@quicinc.com>
References: <20230714042203.14251-1-quic_ptalari@quicinc.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <20230714042203.14251-1-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ygdvlzfOVDxfbv9yiESlIVTV0gpXeFW7
X-Proofpoint-GUID: ygdvlzfOVDxfbv9yiESlIVTV0gpXeFW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=587
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180095
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

LGTM...


On 7/14/2023 9:52 AM, Praveen Talari wrote:
> This series adds spi device mode functionality to geni based Qupv3.
> The common header file contains spi slave related registers and masks.
>
> Praveen Talari (2):
>    soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
>    spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
> ---
> v6 -> v7:
> - Corrected author mail
>
> v5 -> v6:
> - Added code comments
> - Dropped get_spi_master api
>
> v4 -> v5:
> - Addressed review comments in driver
>
> v3 -> v4:
> - Used existing property spi-slave
> - Hence dropped dt-binding changes
>
> v2 -> v3:
> - Modified commit message
> - Addressed comment on dt-binding
>
> v1 -> v2:
> - Added dt-binding change for spi slave
> - Modified commit message
> - Addressed review comments in driver
>
>   drivers/spi/spi-geni-qcom.c      | 53 ++++++++++++++++++++++++++++----
>   include/linux/soc/qcom/geni-se.h |  9 ++++++
>   2 files changed, 56 insertions(+), 6 deletions(-)


Reviewed-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>

