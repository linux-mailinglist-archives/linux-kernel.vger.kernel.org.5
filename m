Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3F7E9165
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjKLPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:17:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BBA2688;
        Sun, 12 Nov 2023 07:17:22 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACFH16i031655;
        Sun, 12 Nov 2023 15:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rshSxOKREaibv4UeEAeF1J8j26NHtl8y6YdFV0mWAao=;
 b=mhKept8LBjbPMF83lvOBnRL2xRfDjnKbhrX0HNlMThTUc67MzIbLzNJTAjwN98ahxJUs
 Q0DC6nX4v0qbXtRyRHxDKBiGrIUH7Hib34p1+Vzw0rbYR17w+WLxQfeycP+ChXrInspl
 ORzokMDHDabRXRum3O4Vf/0+tVSs/Lipy5oJF26+WbKu7pRL44eU3W8yehtlRJm9HhG3
 l2ZIRskieCKOUud9SDf3HUhJe/bJJac46xGNK3pXLOR7gDbBvsY7SKhEsnyInMTqu4uj
 VErsWGlMQ/oFXMzwWG/iQCScdZ1v1WzsFfhLX3tWa7DlqUeO/3dIGLu//LdhBYxQ9Ahn KQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ua2wfhvtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 15:17:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ACFGxUj003702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Nov 2023 15:16:59 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 12 Nov
 2023 07:16:53 -0800
Message-ID: <857eda79-ce06-4afb-1393-c6d14dcda8a2@quicinc.com>
Date:   Sun, 12 Nov 2023 20:46:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/3] dt-bindings: Document gpi/scm/smmu for SC8380XP
Content-Language: en-US
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <vkoul@kernel.org>, <quic_gurus@quicinc.com>,
        <conor+dt@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <iommu@lists.linux.dev>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>
References: <20231025140640.22601-1-quic_sibis@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20231025140640.22601-1-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 88i6J94PxPNfGStcfcL4Gb-BKWOZF9MO
X-Proofpoint-ORIG-GUID: 88i6J94PxPNfGStcfcL4Gb-BKWOZF9MO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=815
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311120134
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be re-spinning the series with a part number change please refrain
from picking this up as is. Thanks.

-Sibi

On 10/25/23 19:36, Sibi Sankar wrote:
> This series documents gpu/scm/smmu for the Qualcomm SC8380XP platform, aka Snapdragon X Elite.
> 
> Dependencies: None
> Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat
> 
> Rajendra Nayak (1):
>    dt-bindings: arm-smmu: Add compatible for SC8380XP SoC
> 
> Sibi Sankar (2):
>    dt-bindings: dma: qcom: gpi: add compatible for SC8380XP
>    dt-bindings: firmware: qcom,scm: document SCM on SC8380XP SoCs
> 
>   Documentation/devicetree/bindings/dma/qcom,gpi.yaml      | 1 +
>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml    | 2 ++
>   3 files changed, 4 insertions(+)
> 
