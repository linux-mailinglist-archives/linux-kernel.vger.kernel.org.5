Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329C675A759
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGTHJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjGTHJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:09:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEA02737;
        Thu, 20 Jul 2023 00:08:46 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K5Nb39004008;
        Thu, 20 Jul 2023 07:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4u4VWKXuJbXsLHbL79Tc193Y4xrHuR7CkmDTmMtEJlA=;
 b=Z3VQV5RlMSRrsg4fBcpe6l7DE9NCHGyrLYjFfEhltdQzOPGxeZx6Q21B0KgoxEUK9CUM
 /Hl7rwFug/zwOM2+z9hmrMA3tn5uasR9INAiUvevk6cGykGVIOcfveXibBewV9amgRG+
 ZZ8c4nuCezTVIGPx9jRHaem4BZlhbQedQ04JGVPVgq8UbfEeHm2dLzzXMvt7JKx4+bHJ
 sMvwuxiIVKms2MiKR8cVtjO0QsryPCNIWpeQ7uot3VylGAp7jSrWpQoNuQ6QPqu2qKpi
 K4C8/fPU9WajrY0Anav+P5SDDa7hASCzvoGo05ij8LXQlneaBPEYYavQQbCfqCiiV8H7 bQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxqv06en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:08:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K78f63003563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 07:08:41 GMT
Received: from [10.216.19.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 00:08:36 -0700
Message-ID: <796e321f-1119-19a3-8910-71061d04e5c2@quicinc.com>
Date:   Thu, 20 Jul 2023 12:38:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V5 0/3] Introduce the read-modify-write API to collect
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>
References: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YCZLJqqoOpsQyl4b_R0Llu70RnTbo9Gt
X-Proofpoint-GUID: YCZLJqqoOpsQyl4b_R0Llu70RnTbo9Gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=611 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200058
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/20/2023 12:34 PM, Kathiravan T wrote:


$subject is messed up, it should be "Introduce the read-modify-write API 
to collect the crashdump on IPQ chipsets". Will correct it in next spin 
or let me know if I need to respin.


> On IPQ platforms, to collect the crashdump, we need to just modify the
> DLOAD bit in the TCSR register. Current infrastructure, overwrites the
> entire regiter value when enabling the crashdump feature, which leads to
> crashdump not gets collected. This series introduce the
> qcom_scm_io_update_field API to achieve the same.
>
> Intially this approach is posted by Poovendhan[1], later Mukesh
> integrated this patch in his minidump support series[2]. Based on the
> current feedback on the minidump series, seems it will take sometime to
> get into a good shape, in the meantime these patches doesn't have any
> dependency with the minidump series. As discussed with the Mukesh[3],
> posting these 3 patches to enable the crashdump on IPQ chipsets.
>
> Since the current version of minidump series is V4, I'm posting this as
> a V5. Please let me know if this should be V1.
>
> [1]
> https://lore.kernel.org/linux-arm-msm/20230113160012.14893-4-quic_poovendh@quicinc.com/
>
> [2]
> https://lore.kernel.org/linux-arm-msm/1676990381-18184-3-git-send-email-quic_mojha@quicinc.com/
>
> [3]
> https://lore.kernel.org/linux-arm-msm/d77f5601-2b08-a7c7-1400-7ab68b8add3a@quicinc.com/
>
>
> Mukesh Ojha (3):
>    firmware: qcom_scm: provide a read-modify-write function
>    pinctrl: qcom: Use qcom_scm_io_update_field()
>    firmware: scm: Modify only the download bits in TCSR register
>
>   drivers/firmware/qcom_scm.c            | 26 ++++++++++++++++++++++++--
>   drivers/pinctrl/qcom/pinctrl-msm.c     | 12 +++++-------
>   include/linux/firmware/qcom/qcom_scm.h |  2 ++
>   3 files changed, 31 insertions(+), 9 deletions(-)
>
