Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01A7EDD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjKPInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjKPInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:43:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836C1A8;
        Thu, 16 Nov 2023 00:43:09 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG7g29o002414;
        Thu, 16 Nov 2023 08:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OAxFSp7uVAX0Jgz4XWVzwP1RoKjGiHU1U+GgLHvxh2w=;
 b=hFXAV+cVi1M7KgEQZUhHI4QKirZZY2Ha1bRmsWtf6+p6W4jwAMhU9Yo8Ph6vXOZAdfgw
 v3eMW+rdNeGJrj6/wfDicas0h/8QH7JsogAa9EEtISyxMbso6eP+cVSql2BOJGml83Og
 KOI2EkJSE39hx7UOy7ddctp0P1XUKFsnHHDPbLEna1gRQCLhRCUM6L4k8E1BEqG+FmuD
 Wh9LchEs6qCf6VvxcqSUvdwZ7e0WMlo+ClByOI+GrUFbslQ3/Af05lmRhWeVOED2+hTe
 4lvDIZVF84FfD3Nwj98fs7hZ6Hnq1UuAhTpBd+q9uP9KKqQPGFz5Nhc6dRAoggv0l3nv kA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udeww840m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 08:42:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG8gfGr006447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 08:42:41 GMT
Received: from [10.216.58.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 00:42:30 -0800
Message-ID: <6ba4d0a9-c370-4851-8631-4c8f952b44d9@quicinc.com>
Date:   Thu, 16 Nov 2023 14:12:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable GCC for SDX75
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <konrad.dybcio@linaro.org>, <arnd@arndb.de>,
        <krzysztof.kozlowski@linaro.org>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20231116051401.4112494-1-quic_rohiagar@quicinc.com>
 <20231116051401.4112494-2-quic_rohiagar@quicinc.com>
 <CAA8EJprzSFrb1qC-khPmTTac5o2ZX8azYBNPmT8DjyeNo3SAZA@mail.gmail.com>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <CAA8EJprzSFrb1qC-khPmTTac5o2ZX8azYBNPmT8DjyeNo3SAZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LI53GRV1RN-kAjKDNNDeJ1iz9flTIjTl
X-Proofpoint-GUID: LI53GRV1RN-kAjKDNNDeJ1iz9flTIjTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_06,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=699 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/2023 10:56 AM, Dmitry Baryshkov wrote:
> On Thu, 16 Nov 2023 at 07:14, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>> Enable Global Clock controller framework support for
>> Qualcomm's SDX75 SoC.
> Please add:
>
> ... which is used for this and that board and/or device.
Sure will add something like this
"Enable Global Clock controller framework support for
Qualcomm's SDX75 SoC which is required to boot to console
on sdx75-idp platform."
Let me know if this doesnt look good.

Thanks,
Rohit.
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index b60aa1f89343..d1be1efa8a23 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1252,6 +1252,7 @@ CONFIG_SDM_GPUCC_845=y
>>   CONFIG_SDM_VIDEOCC_845=y
>>   CONFIG_SDM_DISPCC_845=y
>>   CONFIG_SDM_LPASSCC_845=m
>> +CONFIG_SDX_GCC_75=y
>>   CONFIG_SM_CAMCC_8250=m
>>   CONFIG_SM_DISPCC_6115=m
>>   CONFIG_SM_DISPCC_8250=y
>> --
>> 2.25.1
>>
>
