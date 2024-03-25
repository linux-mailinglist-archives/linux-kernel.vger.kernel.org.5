Return-Path: <linux-kernel+bounces-116982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81B188A5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8CE1F60DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09E65D723;
	Mon, 25 Mar 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="akKhJYSI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118416A1EA;
	Mon, 25 Mar 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368970; cv=none; b=eZykucc7siNfG/3IX8QkLtRXbrCwXoBzrtMDepB7q4x538FH+TsExf201KsNXqaMLTytOgG9u13t39QCyYG9apDQ8huq8LWniqdOdK/RFHKGbyAcVhToUGtZSR23Jdqb/EE8Vx+NQZxDLNmDWjnCMh914m1DoUZhXzbVRbbbu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368970; c=relaxed/simple;
	bh=Si9z81AhX/e8h9wr0lUqDPQ9mX+zZNKh96qgIrAf2FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=je+A8Froc3obY+42QbAUoPvDGZ/a4tZPgWPnyqo81RvbyMJMIL1bTVj2gh5TxEZ/OiRAHJc3HpR+PnZTsORfU7JGumnPKOPNqssCb2vNF/oUOIN8R0SxbaXt/DfsieUsoJRqYaGG8Yf23yUFPjlLx8zuY4sOetoihamadPvykVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=akKhJYSI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PAOnbh007665;
	Mon, 25 Mar 2024 12:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mQ+rCFVR3KoKFZAukI7+aYQbMAxmizaZl1CeVCVsWYk=; b=ak
	KhJYSI/UZHpqGHJw20LhuAwG/bmPTZ14V/JvsOT7vfnraBmpv6elUNqRL9qYlgfR
	g1jB/6kddzIvdJ0ypirZozPh7sR+5JocAq3Wnysk/HxvdAuJwtpaGmcEez2iivxZ
	ckR0jKEI/alRTzB6bFoGirc5Aq59OJfpFwoOYuAO4brJrcWAihHQ+bdN1izHmmpB
	v3/VO19khCrZYHKGiqMpAeP5ZcoFv3mwomPjcTYs+72uVRNwsUwwG9HU7WuekaK5
	yIkwiXd9dXEGpYIhgFov9Y88sA1+t12Ul7ac0bGQteptYC74LutliDiBvOzj7vVp
	q0KOhd59UQSXarX8WMJQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34hp0rh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 12:15:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PCFnMM017658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 12:15:49 GMT
Received: from [10.239.96.73] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 05:15:46 -0700
Message-ID: <758c6c24-749d-4170-8168-3c15da642b4e@quicinc.com>
Date: Mon, 25 Mar 2024 20:15:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] media: qcom: camss: Add new csiphy driver 2-1-2
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <quic_yon@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-4-quic_depengs@quicinc.com>
 <d5db5727-92c4-44e9-b5d0-d734d6940369@linaro.org>
Content-Language: en-US
From: Depeng Shao <quic_depengs@quicinc.com>
In-Reply-To: <d5db5727-92c4-44e9-b5d0-d734d6940369@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G7y042-WtS60H4z2iPgbsyMOFugKZhmW
X-Proofpoint-GUID: G7y042-WtS60H4z2iPgbsyMOFugKZhmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250068

Hi Bryan,


On 3/20/2024 11:21 PM, Bryan O'Donoghue wrote:
> On 20/03/2024 14:11, Depeng Shao wrote:
>> From: Yongsheng Li <quic_yon@quicinc.com>
>>
>> The CSIPHY register offset of SM8550 is different with
>> SM8250, so add a new driver for the SM8550 platform.
>>
>> Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
>> Co-developed-by: Depeng Shao <depengs@qti.qualcomm.com>
>
> You're listing yourself ? Twice with a different CD and SOB.
> Shouldn't this be
> Co-developed-by: Depeng Shao <quic_depengs@quicinc.com>
>
> ?
Sorry for mistake, will update it in new patch.
>
>> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/camss/Makefile    |   1 +
>>   .../platform/qcom/camss/camss-csiphy-2-1-2.c  | 343 ++++++++++++++++++
>>   .../media/platform/qcom/camss/camss-csiphy.h  |   1 +
>>   3 files changed, 345 insertions(+)
>>   create mode 100644 
>> drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c
>>
>> diff --git a/drivers/media/platform/qcom/camss/Makefile 
>> b/drivers/media/platform/qcom/camss/Makefile
>> index 0d4389ab312d..28eba4bf3e38 100644
>> --- a/drivers/media/platform/qcom/camss/Makefile
>> +++ b/drivers/media/platform/qcom/camss/Makefile
>> @@ -9,6 +9,7 @@ qcom-camss-objs += \
>>           camss-csid-gen2.o \
>>           camss-csiphy-2ph-1-0.o \
>>           camss-csiphy-3ph-1-0.o \
>> +        camss-csiphy-2-1-2.o \
>
> File name here is incorrect camss-csiphy-3ph-1-2.o this is a 3 phase 
> capable PHY right ? So both the filename and the commit title need to 
> reflect that.
>
> I thought we had discussed offline using an offset instead of a new 
> file ?
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/6dc8f49ef7c6ca69783aa02bdca81c77e66ecc0d 
>
>
> Then just set the offset
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/022a837257d9e1fa8070f0dfa2f683e903111aa0 
>
>
Yes, this is a good idea, but looks like the code in your x1e80100 
branch hasn't ready yet, could we have a separate patch for this 
optimization, then I can rebase my change based on it.


>
>>           camss-csiphy.o \
>>           camss-ispif.o \
>>           camss-vfe-4-1.o \
>> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c 
>> b/drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c
>> new file mode 100644
>> index 000000000000..df7860d7a4f4
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-2-1-2.c
>> @@ -0,0 +1,343 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * camss-csiphy-2-1-2.c
>> + *
>> + * Qualcomm MSM Camera Subsystem - CSIPHY Module 3phase v2.0
>> + *
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include "camss.h"
>> +#include "camss-csiphy.h"
>> +
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +
>> +
>> +#define CSIPHY_CMN_CSI_COMMON_CTRLn(n)    (0x1000 + 0x4 * (n))
>> +#define CSIPHY_CMN_CSI_COMMON_CTRL5_CLK_ENABLE    BIT(7)
>> +#define CSIPHY_CMN_CSI_COMMON_CTRL6_COMMON_PWRDN_B    BIT(0)
>> +#define CSIPHY_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID    BIT(1)
>> +#define CSIPHY_CMN_CSI_COMMON_CTRL7_CONTROL    0x7A
>> +#define CSIPHY_CMN_CSI_COMMON_CTRL0_PHY_SW_RESET    BIT(0)
>> +#define CSIPHY_CMN_CSI_COMMON_CTRL0_SWI_ENABLE_LANESYNC BIT(1)
>> +#define CSIPHY_CMN_CSI_COMMON_STATUSn(n)    (0x10B0 + 0x4 * (n))
>> +
>> +#define CSIPHY_DEFAULT_PARAMS            0
>> +#define CSIPHY_LANE_ENABLE               1
>> +#define CSIPHY_SETTLE_CNT_LOWER_BYTE     2
>> +#define CSIPHY_SETTLE_CNT_HIGHER_BYTE    3
>> +#define CSIPHY_DNP_PARAMS                4
>> +#define CSIPHY_2PH_REGS                  5
>> +#define CSIPHY_3PH_REGS                  6
>> +
>> +struct csiphy_reg_t {
>> +    s32 reg_addr;
>> +    s32 reg_data;
>> +    s32 delay;
>> +    u32 csiphy_param_type;
>> +};
>> +
>> +/* 2.1.2 2PH */
>> +static const struct
>> +csiphy_reg_t lane_regs_sm8550[5][20] = {
>
> So per the tree I shared with you..
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/fa666c241eb530a08aa6b391e15b018296e93f66 
>
>
> We don't need to break this up into a multi-dimensional array
>
> its just a straight write of values


Yeah, agree, I also don't want to do like this, I just follow the old 
driver's format


>> +    {
>> +        {0x0E90, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E98, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E94, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
>> +        {0x00A0, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0090, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0098, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0094, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0494, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x04A0, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0490, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0498, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0494, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0894, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x08A0, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0890, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0898, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0894, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C94, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0CA0, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C90, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +    },
>> +    {
>> +        {0x0C98, 0x08, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C94, 0x07, 0x01, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E30, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E28, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E00, 0x80, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E0C, 0xFF, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E38, 0x1F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E2C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E34, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E1C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E14, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E3C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E04, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E20, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0E08, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
>> +        {0x0E10, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0030, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0000, 0x8E, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0038, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x002C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +    },
>> +    {
>> +        {0x0034, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x001C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0014, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x003C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0004, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0020, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0008, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
>> +        {0x0010, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0430, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0400, 0x8E, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0438, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x042C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0434, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x041C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0414, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x043C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0404, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0420, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0408, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
>> +        {0x0410, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +    },
>> +    {
>> +        {0x0830, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0800, 0x8E, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0838, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x082C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0834, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x081C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0814, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x083C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0804, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0820, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0808, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
>> +        {0x0810, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C30, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C00, 0x8E, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C38, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C2C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C34, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C1C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C14, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C3C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +    },
>> +    {
>> +        {0x0C04, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C20, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C08, 0x10, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
>> +        {0x0C10, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0094, 0xD7, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x005C, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0060, 0xBD, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0064, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0494, 0xD7, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x045C, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0460, 0xBD, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0464, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0894, 0xD7, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x085C, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0860, 0xBD, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0864, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C94, 0xD7, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C5C, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C60, 0xBD, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +        {0x0C64, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
>> +    }
>> +};
>> +
>> +static void csiphy_hw_version_read(struct csiphy_device *csiphy,
>> +                   struct device *dev)
>> +{
>> +    u32 hw_version;
>> +
>> +    writel(CSIPHY_CMN_CSI_COMMON_CTRL6_SHOW_REV_ID,
>> +           csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(6));
>> +
>> +    hw_version = readl_relaxed(csiphy->base +
>> +                   CSIPHY_CMN_CSI_COMMON_STATUSn(12));
>> +    hw_version |= readl_relaxed(csiphy->base +
>> +                   CSIPHY_CMN_CSI_COMMON_STATUSn(13)) << 8;
>> +    hw_version |= readl_relaxed(csiphy->base +
>> +                   CSIPHY_CMN_CSI_COMMON_STATUSn(14)) << 16;
>> +    hw_version |= readl_relaxed(csiphy->base +
>> +                   CSIPHY_CMN_CSI_COMMON_STATUSn(15)) << 24;
>> +
>> +    dev_info(dev, "CSIPHY 3PH HW Version = 0x%08x\n", hw_version);
>> +}
>> +
>> +/*
>> + * csiphy_reset - Perform software reset on CSIPHY module
>> + * @csiphy: CSIPHY device
>> + */
>> +static void csiphy_reset(struct csiphy_device *csiphy)
>> +{
>> +    writel_relaxed(0x1, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(0));
>> +    usleep_range(5000, 8000);
>> +    writel_relaxed(0x0, csiphy->base + CSIPHY_CMN_CSI_COMMON_CTRLn(0));
>> +}
>> +
>> +static irqreturn_t csiphy_isr(int irq, void *dev)
>> +{
>> +    struct csiphy_device *csiphy = dev;
>> +    int i;
>> +
>> +    for (i = 0; i < 11; i++) {
>> +        int c = i + 22;
>> +        u8 val = readl_relaxed(csiphy->base +
>> +                       CSIPHY_CMN_CSI_COMMON_STATUSn(i));
>> +
>> +        writel_relaxed(val, csiphy->base +
>> +                    CSIPHY_CMN_CSI_COMMON_CTRLn(c));
>> +    }
>> +
>> +    writel_relaxed(0x1, csiphy->base + 
>> CSIPHY_CMN_CSI_COMMON_CTRLn(10));
>> +    writel_relaxed(0x0, csiphy->base + 
>> CSIPHY_CMN_CSI_COMMON_CTRLn(10));
>> +
>> +    for (i = 22; i < 33; i++)
>> +        writel_relaxed(0x0, csiphy->base +
>> +                    CSIPHY_CMN_CSI_COMMON_CTRLn(i));
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +/*
>> + * csiphy_settle_cnt_calc - Calculate settle count value
>> + *
>> + * Helper function to calculate settle count value. This is
>> + * based on the CSI2 T_hs_settle parameter which in turn
>> + * is calculated based on the CSI2 transmitter link frequency.
>> + *
>> + * Return settle count value or 0 if the CSI2 link frequency
>> + * is not available
>> + */
>> +static u8 csiphy_settle_cnt_calc(s64 link_freq, u32 timer_clk_rate)
>> +{
>> +    u32 ui; /* ps */
>> +    u32 timer_period; /* ps */
>> +    u32 t_hs_prepare_max; /* ps */
>> +    u32 t_hs_settle; /* ps */
>> +    u8 settle_cnt;
>> +
>> +    if (link_freq <= 0)
>> +        return 0;
>> +
>> +    ui = div_u64(1000000000000LL, link_freq);
>> +    ui /= 2;
>> +    t_hs_prepare_max = 85000 + 6 * ui;
>> +    t_hs_settle = t_hs_prepare_max;
>> +
>> +    timer_period = div_u64(1000000000000LL, timer_clk_rate);
>> +    settle_cnt = t_hs_settle / timer_period - 6;
>> +
>> +    return settle_cnt;
>> +}
>
> Yep this is all literal copy/paste of existing code.
>
> Please try taking
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/aa27ac8e1ffedd48c5ef6ac0f75f1f15716fe296 
>
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/fa666c241eb530a08aa6b391e15b018296e93f66 
>
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/e9e99dee4e723755274e6430bb43adfbf77d2a1a 
>
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/5dc53c39b96eb22bdfe47554f047e6b63ddb25c0 
>
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/36655b353fa71269812cff0e695341ff12042546 
>
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/6dc8f49ef7c6ca69783aa02bdca81c77e66ecc0d 
>
>
> and
>
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/042ec64867d43e014c2b369db3b92b4f5432497f 
>
>
> into your tree
>
> it works for me on sm8250 and is WIP for x1e80100
>
> Point being we need to make an effort to unify/reuse/fix init 
> sequences upstream not to copy/paste from one file to another.
>
I asked can we have a separate change for the csiphy optimization in 
above, looks like this the separate series.

Sorry, I just want to make sure the merge order since there are many 
ongoing changes, they will conflict with each other.

>> +
>> +static void csiphy_config_lanes(struct csiphy_device *csiphy,
>> +                     u8 settle_cnt)
>> +{
>> +    const struct csiphy_reg_t *r;
>> +    int i, l, array_size;
>> +    u32 val;
>> +
>> +    switch (csiphy->camss->res->version) {
>> +    case CAMSS_8550:
>> +        r = &lane_regs_sm8550[0][0];
>> +        array_size = ARRAY_SIZE(lane_regs_sm8550[0]);
>> +        break;
>> +    default:
>> +        WARN(1, "unknown csi version\n");
>> +        return;
>> +    }
>> +
>> +    for (l = 0; l < 5; l++) {
>
> These hard-coded values in control loops must be done away with upstream.
>
Won't have these code if I rebase the change based on yours.
> ---
> bod


Thanks,

Depeng


