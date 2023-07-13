Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622A4752079
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjGMLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjGMLyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:54:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1CF119;
        Thu, 13 Jul 2023 04:54:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DBrTo8029786;
        Thu, 13 Jul 2023 11:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bmlgJDGCjYLDy3hSSv+LiraQPudrj8Qf5Znev8iYer0=;
 b=b8fB6NutgGS0D01KdI4mhiv5imJ1ocCrSGKCfUVNi6eC0RonPxmJxMm85EHg83EuKqd/
 HY+iqz/C+NLwaYQqWvhPtzzB1If1IiVZ/7UconlQXxz4W6cLq5Gfwqb9R27zC/N3DQ4s
 bXt2kiy/UbciquvTjir3OMR/0P6hP5U/GdYgOF8+k/voo3w/rfkgEGvnuMOsum6n0SJD
 KPxat+MCRfTbQaLTRAKr52D+Tt8iBJY6m2cKgAe4bBTEZ2v9qfwkeUc383LE8Ndo6HKl
 7vGzDXTSbuFsR1NfRZIunwMJACKY7c69FcsGxr9A+X1cpkINg61ulhO8WE68uRsVxcLJ kQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3f01c9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:54:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DBsSek025718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:54:28 GMT
Received: from [10.110.44.63] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 04:54:24 -0700
Message-ID: <c1b4fe80-027d-4614-4186-dcfa5434fd23@quicinc.com>
Date:   Thu, 13 Jul 2023 17:24:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 0/2] spi-geni-qcom: Add SPI device mode support for
 GENI based QuPv3
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>
References: <20230707051636.5301-1-quic_ptalari@quicinc.com>
 <f26fed94-c6c2-cc39-62ec-8aee309456eb@linaro.org>
Content-Language: en-US
From:   Praveen Talari <quic_ptalari@quicinc.com>
In-Reply-To: <f26fed94-c6c2-cc39-62ec-8aee309456eb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R7_00s8hx0xVZGqjT_oPmNCNpii1zK27
X-Proofpoint-ORIG-GUID: R7_00s8hx0xVZGqjT_oPmNCNpii1zK27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=524 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130105
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 7/7/2023 5:59 PM, Konrad Dybcio wrote:
> On 7.07.2023 07:16, Praveen Talari wrote:
>> This series adds spi device mode functionality to geni based Qupv3.
>> The common header file contains spi slave related registers and masks.
>>
>> Praveen Talari (2):
>>    soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
>>    spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
>> ---
>> v4 -> v5:
>> - Addressed review comments in driver
> "fix bug" says exactly nothing
Addressed
>
> Konrad
>> v3 -> v4:
>> - Used existing property spi-slave
>> - Hence dropped dt-binding changes
>>
>> v2 -> v3:
>> - Modified commit message
>> - Addressed comment on dt-binding
>>
>> v1 -> v2:
>> - Added dt-binding change for spi slave
>> - Modified commit message
>> - Addressed review comments in driver
>>
>>   drivers/spi/spi-geni-qcom.c      | 53 ++++++++++++++++++++++++++++----
>>   include/linux/soc/qcom/geni-se.h |  9 ++++++
>>   2 files changed, 56 insertions(+), 6 deletions(-)
>>
