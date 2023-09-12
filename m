Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D243A79C726
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjILGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjILGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:47:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3827E76;
        Mon, 11 Sep 2023 23:47:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C6N6N2018219;
        Tue, 12 Sep 2023 06:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sds1xdU1dqNFPapFsLerVH3F0XspPNYXUwFsvL5xkNs=;
 b=fEuQWR4R/JEZzm0yCFcGAVzheHwMj0kMUHsp8VYq3dklyp5muCDu4OLBgg6aaEVSAxdv
 QR3t6EWg47R3p9cDwG9FT9X770CaoMYtHKM6g1NTby/yhfYU1zZ6oUOKx7jQp56yjA4E
 aZs1d9xn63gJEW4Fxe0LT98CPslJUOPFC4zFHDVyl0YIrn1E6GgxxrameX0QL+uLaAlo
 Gm4AHCYtU96TvMuckbHvCwuEhygCKZJ086fA8wohEn3RTn0+kNMrHyMJgoKUROgrqwuC
 CyyR+7DH1hW4z2rrHVZk+Y/SA0C+45Czkz0vJCSAfhYEx5auj1DAvulmZkLiH/cjpqNj xQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1xkjtqmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:47:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38C6kvm6028858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:46:57 GMT
Received: from [10.233.19.96] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 11 Sep
 2023 23:46:49 -0700
Message-ID: <0e69140a-bd2f-16b1-ea34-f2d86ecfc414@quicinc.com>
Date:   Tue, 12 Sep 2023 14:46:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RESEND PATCH v6 0/3] Add support for vibrator in multiple PMICs
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>
References: <20230828053205.218950-1-quic_fenglinw@quicinc.com>
Content-Language: en-US
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <20230828053205.218950-1-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V_HtDXT30fQNn7iVzwUwXdIKNnDSwBh2
X-Proofpoint-ORIG-GUID: V_HtDXT30fQNn7iVzwUwXdIKNnDSwBh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone help to review the driver changes?
thanks

Fenglin Wu

On 8/28/2023 1:32 PM, Fenglin Wu wrote:
> Add SW support for the vibrator module inside PMI632, PM7250B, PM7325B, PM7550BA.
> It is very similar to the vibrator module inside PM8916 which is supported in
> pm8xxx-vib driver but just the drive amplitude is controlled with 2 registers,
> and the register base offset in each PMIC is different.
> 
> Changes in v6:
>    1. Add "qcom,pmi632-vib" as a standalone compatible string.
> 
> Changes in v5:
>    1. Drop "qcom,spmi-vib-gen2" generic compatible string as requested
>       and use device specific compatible strings only.
> 
> Changes in v4:
>    1. Update to use the combination of the HW type and register offset
>       as the constant match data, the register base address defined in
>       'reg' property will be added when accessing SPMI registers using
>       regmap APIs.
>    2. Remove 'qcom,spmi-vib-gen1' generic compatible string.
> 
> Changes in v3:
>    1. Refactor the driver to support different type of the vibrators with
>      better flexibility by introducing the HW type with corresponding
>      register fields definitions.
>    2. Add 'qcom,spmi-vib-gen1' and 'qcom,spmi-vib-gen2' compatible
>      strings, and add PMI632, PM7250B, PM7325B, PM7550BA as compatbile as
>      spmi-vib-gen2.
> 
> Changes in v2:
>    Remove the "pm7550ba-vib" compatible string as it's compatible with pm7325b.
> 
> 
> Fenglin Wu (3):
>    input: pm8xxx-vib: refactor to easily support new SPMI vibrator
>    dt-bindings: input: qcom,pm8xxx-vib: add new SPMI vibrator module
>    input: pm8xxx-vibrator: add new SPMI vibrator support
> 
>   .../bindings/input/qcom,pm8xxx-vib.yaml       |  16 +-
>   drivers/input/misc/pm8xxx-vibrator.c          | 171 ++++++++++++------
>   2 files changed, 132 insertions(+), 55 deletions(-)
> 
