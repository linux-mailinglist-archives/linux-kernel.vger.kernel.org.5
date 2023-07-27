Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA27653FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjG0MbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjG0MbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:31:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44409A0;
        Thu, 27 Jul 2023 05:31:15 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R5GolW001008;
        Thu, 27 Jul 2023 12:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f1y238/ILA4BizL9CYD0+AacWxi3K0rHpiC/AW+wefk=;
 b=IojXUhMVox2GJfdr+JsDgiJfd/pu4XvA0UQazibeIOsh/hsXiUfLICao93JCY37deKs2
 MTrplfDkBaZiRnqERKK+FvA6vvkl2RYU+m3DNlPHjcMnOtnPuSoP07CX0usmsX4OENw1
 zmLurMmPhDuMIMJa3uEIbwVwsDyyhC67uznhaHwgtCWQlVpcghUSGrntEpiZHMLSG11N
 Eq3mALPk15X9hT/LZVyOavI4AJEM1qLyMPN1z9gI+KgXIooF2/DTQAvqJflaYuGNn4Ns
 q+nQ7EMbQicsNADuhkBaaz696VvZ/w/2pOIvpMNxYjxVYHZfLTW29J67VorGudUVcxaI 5A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s37g0j0um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 12:31:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RCUdRV027615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 12:30:39 GMT
Received: from [10.216.40.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 05:30:18 -0700
Message-ID: <2790272a-7290-f780-d5ca-108e2df57363@quicinc.com>
Date:   Thu, 27 Jul 2023 18:00:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] dt-bindings: qcom: Update RPMHPD entries for some SoCs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     <mathieu.poirier@linaro.org>, <mchehab@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <quic_vgarodia@quicinc.com>,
        <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <freedreno@lists.freedesktop.org>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <jonathan@marek.ca>,
        <conor+dt@kernel.org>, <robh+dt@kernel.org>, <airlied@gmail.com>,
        <linux-mmc@vger.kernel.org>, <quic_tdas@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <dmitry.baryshkov@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <sean@poorly.run>,
        <ulf.hansson@linaro.org>, <devicetree@vger.kernel.org>,
        <vladimir.zapolskiy@linaro.org>, <rfoss@kernel.org>,
        <mani@kernel.org>, <linux-media@vger.kernel.org>,
        <sboyd@kernel.org>, <quic_abhinavk@quicinc.com>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <marijn.suijten@somainline.org>, <neil.armstrong@linaro.org>,
        <robdclark@gmail.com>
References: <1690448953-23425-1-git-send-email-quic_rohiagar@quicinc.com>
 <169045659774.1058731.6391693092002547810.robh@kernel.org>
 <fa84ec4f-bdb9-dace-c56a-46174a9b47ee@quicinc.com>
 <2edb92b8-a6a8-c115-757c-daccef6be5f0@linaro.org>
 <432ab1d3-0f9e-4072-ff4d-6362886584b8@quicinc.com>
 <e9a4e015-7e25-92be-9a7a-8e5dcf3848fa@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <e9a4e015-7e25-92be-9a7a-8e5dcf3848fa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -_B1Iy2EK5EOKImXcuD7-X2i62OrXsCm
X-Proofpoint-ORIG-GUID: -_B1Iy2EK5EOKImXcuD7-X2i62OrXsCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=759 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270112
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/2023 5:57 PM, Krzysztof Kozlowski wrote:
> On 27/07/2023 14:21, Rohit Agarwal wrote:
>>>> https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
>>> Please mention the dependency in patch changelog ---, so it is obvious
>>> for people applying it and also for the bot.
>> Sure. Will send a cover letter for this patch mentioning the changelogs
>> and will
>> keep the version as v2 since there no change at all in the patch.
> There is no need for cover letter for one patch.
Yes, I thought the same and thus didnt include the cover letter and 
changelogs initially.
Can you please help where I can add the changelogs and the dependency link?

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
