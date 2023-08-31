Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5978E513
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbjHaD0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbjHaD0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:26:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E538CD6;
        Wed, 30 Aug 2023 20:26:36 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V36gFG004878;
        Thu, 31 Aug 2023 03:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oYJZn488N/BZRN00px6pJJlFbTmU8t44WbwkIxCDnlU=;
 b=f/QdQfv+mf/6BGOwdjDJVxapUprGN+xN/6l6mS/CRvHGXCazzLApEHSqyHq20y7Ua4z+
 GIpI64z2/SSF+POJf7ssQbIIGIRi8enMv0B3qAt4N1ETeYCTfkmHh+8KnuSfee3x1COI
 Ki6HYpFLWlR0CFFqa8lghdoL2vWKqhniS3GeON6UXU9ec0SWoDJJjjOCF81D3Dnc+jwQ
 niS0vy2dgCv0sI326+HTUCIDNjvBTzD1KcTMMe77CGXZG78fb39irBbFqnsjSPJNUv+o
 NBpMdeaa27f8FJ7DmzS6S2N5T7o2JudTNnQl0SvAi8fMbCh3XgYdCdGOosfU+XR6otoi Kw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st6ct9ex3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 03:26:31 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37V3QUUY023871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 03:26:30 GMT
Received: from [10.201.192.51] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 20:26:25 -0700
Message-ID: <e034b837-6f0d-878a-94ad-ebf0a2b74aa0@quicinc.com>
Date:   Thu, 31 Aug 2023 08:56:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom,a53pll: add IPQ5018
 compatible
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>
References: <20230829095423.760641-1-quic_gokulsri@quicinc.com>
 <20230829095423.760641-2-quic_gokulsri@quicinc.com>
 <3722a8f6-8f63-fe7c-6983-ac96caa18c87@linaro.org>
 <d2080d0b-f0d2-b5f2-4fd5-c929735e406c@quicinc.com>
 <CAA8EJpo=e0JNWRhERUFFtLZ6o+hMhdBspC8yPi3j8U0AAo_FQw@mail.gmail.com>
From:   Gokul Sriram P <quic_gokulsri@quicinc.com>
In-Reply-To: <CAA8EJpo=e0JNWRhERUFFtLZ6o+hMhdBspC8yPi3j8U0AAo_FQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8iiXmqz88qF8Uv5P6CPsNcCgii2UPIW8
X-Proofpoint-ORIG-GUID: 8iiXmqz88qF8Uv5P6CPsNcCgii2UPIW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=571
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310030
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/2023 1:17 AM, Dmitry Baryshkov wrote:
> Each patch is individual, even if they form a series. Different
> patches might be developed by different parties or a combination of
> them.

I get it Dmitry. Thanks. Will update.

Regards,
Gokul

