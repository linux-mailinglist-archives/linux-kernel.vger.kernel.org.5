Return-Path: <linux-kernel+bounces-6524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7B8199F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF351F24D48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF391B285;
	Wed, 20 Dec 2023 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PgZXFddF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6B168D1;
	Wed, 20 Dec 2023 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK5rbPN002203;
	Wed, 20 Dec 2023 08:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UwMiIgYyDLV2fecao97aVA6TgwE60G6nvAMw3MYtEgI=; b=Pg
	ZXFddFMHTR579aP5J6xae0TftLR7zZAWoSVidmZ+2bcl2GdU8A/+w36C+4BT022J
	atQe6cIB53IRjQwfbSAZytwnTlUOhJlJ1PD3UeqnsPU9BECt0AbjV6F5OdmdEDkL
	0gbtuWaTO1AKiwMbMCJiW8XoE1abf0zCHC+4pUfyAx9c4DWyQYXlQOKoZeUxljrN
	wQpaKwz57FIg6V6L3cv1kt0y1enuzYLBaphat9G7aSeEEuDmWnkSnPBJ+Wwd3+H4
	bUqTgWml2LAaLbCUag+JsxKGvW9xJFY569Xk5wbRfKiymz9xX/Mgh4PEKCctD3Et
	I7i9zI/tUPUcj+THCUdQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3th6r9rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:01:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK81b88001242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:01:37 GMT
Received: from [10.216.36.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:01:32 -0800
Message-ID: <87fea0ec-b0c4-1c68-d5b0-86deac8a25d8@quicinc.com>
Date: Wed, 20 Dec 2023 13:31:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/34] media: introduce common helpers for video
 firmware handling
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stanimir.k.varbanov@gmail.com>, <quic_vgarodia@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mchehab@kernel.org>,
        <bryan.odonoghue@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_abhinavk@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-2-git-send-email-quic_dikshita@quicinc.com>
 <f0682d53-a2f1-4b68-abe1-90a35c9a0641@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <f0682d53-a2f1-4b68-abe1-90a35c9a0641@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bqNatCUS5GSjNmkxnWtRtUKH1FlofATv
X-Proofpoint-ORIG-GUID: bqNatCUS5GSjNmkxnWtRtUKH1FlofATv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312200054



On 12/18/2023 11:54 PM, Dmitry Baryshkov wrote:
> On 18/12/2023 13:31, Dikshita Agarwal wrote:
>> Re-organize the video driver code by introducing a new folder
>> 'vcodec' and placing 'venus' driver code inside that.
>>
>> Introduce common helpers for trustzone based firmware
>> load/unload etc. which are placed in common folder
>> i.e. 'vcodec'.
>> Use these helpers in 'venus' driver. These helpers will be
>> used by 'iris' driver as well which is introduced later
>> in this patch series.
> 
> But why do you need to move the venus driver to subdir?

Currently venus driver is present in drivers/media/platform/qcom folder
which also has camss folder. We introduced vcodec to keep common code and
moved venus inside that, to indicate that the common code is for vcodec
drivers i.e venus and iris. Keeping this in qcom folder would mean, common
code will be used for camss only which is not the case here.
> 
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/Kconfig                |   2 +-
>>   drivers/media/platform/qcom/Makefile               |   2 +-
>>   drivers/media/platform/qcom/vcodec/firmware.c      | 147 +++++++++
>>   drivers/media/platform/qcom/vcodec/firmware.h      |  21 ++
>>   .../media/platform/qcom/{ => vcodec}/venus/Kconfig |   0
>>   .../platform/qcom/{ => vcodec}/venus/Makefile      |   4 +-
>>   .../media/platform/qcom/{ => vcodec}/venus/core.c  | 102 +++++-
>>   .../media/platform/qcom/{ => vcodec}/venus/core.h  |   0
>>   .../media/platform/qcom/{ => vcodec}/venus/dbgfs.c |   0
>>   .../media/platform/qcom/{ => vcodec}/venus/dbgfs.h |   0
>>   .../platform/qcom/vcodec/venus/firmware_no_tz.c    | 194 +++++++++++
>>   .../platform/qcom/vcodec/venus/firmware_no_tz.h    |  19 ++
>>   .../platform/qcom/{ => vcodec}/venus/helpers.c     |   0
>>   .../platform/qcom/{ => vcodec}/venus/helpers.h     |   0
>>   .../media/platform/qcom/{ => vcodec}/venus/hfi.c   |   0
>>   .../media/platform/qcom/{ => vcodec}/venus/hfi.h   |   0
>>   .../platform/qcom/{ => vcodec}/venus/hfi_cmds.c    |   0
>>   .../platform/qcom/{ => vcodec}/venus/hfi_cmds.h    |   0
>>   .../platform/qcom/{ => vcodec}/venus/hfi_helper.h  |   0
>>   .../platform/qcom/{ => vcodec}/venus/hfi_msgs.c    |   0
>>   .../platform/qcom/{ => vcodec}/venus/hfi_msgs.h    |   0
>>   .../platform/qcom/{ => vcodec}/venus/hfi_parser.c  |   0
>>   .../platform/qcom/{ => vcodec}/venus/hfi_parser.h  |   0
>>   .../qcom/{ => vcodec}/venus/hfi_plat_bufs.h        |   0
>>   .../qcom/{ => vcodec}/venus/hfi_plat_bufs_v6.c     |   0
>>   .../qcom/{ => vcodec}/venus/hfi_platform.c         |   0
>>   .../qcom/{ => vcodec}/venus/hfi_platform.h         |   0
>>   .../qcom/{ => vcodec}/venus/hfi_platform_v4.c      |   0
>>   .../qcom/{ => vcodec}/venus/hfi_platform_v6.c      |   0
>>   .../platform/qcom/{ => vcodec}/venus/hfi_venus.c   |  21 +-
>>   .../platform/qcom/{ => vcodec}/venus/hfi_venus.h   |   0
>>   .../qcom/{ => vcodec}/venus/hfi_venus_io.h         |   0
>>   .../platform/qcom/{ => vcodec}/venus/pm_helpers.c  |   0
>>   .../platform/qcom/{ => vcodec}/venus/pm_helpers.h  |   0
>>   .../media/platform/qcom/{ => vcodec}/venus/vdec.c  |   0
>>   .../media/platform/qcom/{ => vcodec}/venus/vdec.h  |   0
>>   .../platform/qcom/{ => vcodec}/venus/vdec_ctrls.c  |   0
>>   .../media/platform/qcom/{ => vcodec}/venus/venc.c  |   0
>>   .../media/platform/qcom/{ => vcodec}/venus/venc.h  |   0
>>   .../platform/qcom/{ => vcodec}/venus/venc_ctrls.c  |   0
>>   drivers/media/platform/qcom/venus/firmware.c       | 363
>> ---------------------
>>   drivers/media/platform/qcom/venus/firmware.h       |  26 --
>>   42 files changed, 492 insertions(+), 409 deletions(-)
>>   create mode 100644 drivers/media/platform/qcom/vcodec/firmware.c
>>   create mode 100644 drivers/media/platform/qcom/vcodec/firmware.h
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/Kconfig (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/Makefile (83%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/core.c (91%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/core.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/dbgfs.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/dbgfs.h (100%)
>>   create mode 100644
>> drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.c
>>   create mode 100644
>> drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.h
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/helpers.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/helpers.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_cmds.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_cmds.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_helper.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_msgs.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_msgs.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_parser.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_parser.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_plat_bufs.h
>> (100%)
>>   rename drivers/media/platform/qcom/{ =>
>> vcodec}/venus/hfi_plat_bufs_v6.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform.c
>> (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform.h
>> (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform_v4.c
>> (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform_v6.c
>> (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus.c (99%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus_io.h
>> (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/pm_helpers.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/pm_helpers.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec_ctrls.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc.c (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc.h (100%)
>>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc_ctrls.c (100%)
>>   delete mode 100644 drivers/media/platform/qcom/venus/firmware.c
>>   delete mode 100644 drivers/media/platform/qcom/venus/firmware.h
>>
>> diff --git a/drivers/media/platform/qcom/Kconfig
>> b/drivers/media/platform/qcom/Kconfig
>> index cc5799b..e94142f 100644
>> --- a/drivers/media/platform/qcom/Kconfig
>> +++ b/drivers/media/platform/qcom/Kconfig
>> @@ -3,4 +3,4 @@
>>   comment "Qualcomm media platform drivers"
>>     source "drivers/media/platform/qcom/camss/Kconfig"
>> -source "drivers/media/platform/qcom/venus/Kconfig"
>> +source "drivers/media/platform/qcom/vcodec/venus/Kconfig"
>> diff --git a/drivers/media/platform/qcom/Makefile
>> b/drivers/media/platform/qcom/Makefile
>> index 4f055c3..3d2d82b 100644
>> --- a/drivers/media/platform/qcom/Makefile
>> +++ b/drivers/media/platform/qcom/Makefile
>> @@ -1,3 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   obj-y += camss/
>> -obj-y += venus/
>> +obj-y += vcodec/venus/
>> diff --git a/drivers/media/platform/qcom/vcodec/firmware.c
>> b/drivers/media/platform/qcom/vcodec/firmware.c
>> new file mode 100644
>> index 0000000..dbc220a
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/vcodec/firmware.c
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights
>> reserved.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/firmware.h>
>> +#include <linux/kernel.h>
>> +#include <linux/iommu.h>
>> +#include <linux/of_device.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/soc/qcom/mdt_loader.h>
>> +
>> +#include "firmware.h"
>> +
>> +bool use_tz(struct device *core_dev)
> 
> All these functions must get some sane prefix. Otherwise a generic 'use_tz'
> function is too polluting for the global namespace.
> 
I understand, will check and do the needful.
>> +{
>> +    struct device_node *np;
>> +
>> +    np = of_get_child_by_name(core_dev->of_node, "video-firmware");
>> +    if (!np)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>> +int protect_secure_region(u32 cp_start, u32 cp_size, u32 cp_nonpixel_start,
>> +              u32 cp_nonpixel_size, u32 pas_id)
>> +{
>> +    int ret;
>> +    /*
>> +     * Clues for porting using downstream data:
>> +     * cp_start = 0
>> +     * cp_size = venus_ns/virtual-addr-pool[0] - yes, address and not size!
>> +     *   This works, as the non-secure context bank is placed
>> +     *   contiguously right after the Content Protection region.
>> +     *
>> +     * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
>> +     * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
>> +     */
>> +    ret = qcom_scm_mem_protect_video_var(cp_start,
>> +                         cp_size,
>> +                         cp_nonpixel_start,
>> +                         cp_nonpixel_size);
>> +    if (ret)
>> +        qcom_scm_pas_shutdown(pas_id);
>> +
>> +    return ret;
>> +}
>> +
>> +int load_fw(struct device *dev, const char *fw_name, phys_addr_t *mem_phys,
>> +        size_t *mem_size, u32 pas_id, bool use_tz)
>> +{
>> +    const struct firmware *firmware = NULL;
>> +    struct reserved_mem *rmem;
>> +    struct device_node *node;
>> +    void *mem_virt = NULL;
>> +    ssize_t fw_size = 0;
>> +    int ret;
>> +
>> +    if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> 
> Why? Can you just depend on it?
> 
Sure, Will check this and get back.
>> +        (use_tz && !qcom_scm_is_available()))
>> +        return -EPROBE_DEFER;
>> +
>> +    if (!fw_name || !(*fw_name))
>> +        return -EINVAL;
>> +
>> +    *mem_phys = 0;
>> +    *mem_size = 0;
>> +
>> +    node = of_parse_phandle(dev->of_node, "memory-region", 0);
>> +    if (!node) {
>> +        dev_err(dev, "no memory-region specified\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    rmem = of_reserved_mem_lookup(node);
>> +    of_node_put(node);
>> +    if (!rmem) {
>> +        dev_err(dev, "failed to lookup reserved memory-region\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = request_firmware(&firmware, fw_name, dev);
>> +    if (ret) {
>> +        dev_err(dev, "%s: failed to request fw \"%s\", error %d\n",
>> +            __func__, fw_name, ret);
>> +        return ret;
>> +    }
>> +
>> +    fw_size = qcom_mdt_get_size(firmware);
>> +    if (fw_size < 0) {
>> +        ret = fw_size;
>> +        dev_err(dev, "%s: out of bound fw image fw size: %ld\n",
>> +            __func__, fw_size);
>> +        goto err_release_fw;
>> +    }
>> +
>> +    *mem_phys = rmem->base;
>> +    *mem_size = rmem->size;
>> +
>> +    if (*mem_size < fw_size) {
>> +        ret = -EINVAL;
>> +        goto err_release_fw;
>> +    }
>> +
>> +    mem_virt = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
>> +    if (!mem_virt) {
>> +        dev_err(dev, "unable to remap fw memory region %pa size %#zx\n",
>> +            mem_phys, *mem_size);
>> +        goto err_release_fw;
>> +    }
>> +
>> +    if (use_tz)
>> +        ret = qcom_mdt_load(dev, firmware, fw_name, pas_id, mem_virt,
>> +                    *mem_phys, *mem_size, NULL);
>> +    else
>> +        ret = qcom_mdt_load_no_init(dev, firmware, fw_name, pas_id,
>> mem_virt,
>> +                        *mem_phys, *mem_size, NULL);
>> +    if (ret) {
>> +        dev_err(dev, "%s: error %d loading fw \"%s\"\n",
>> +            __func__, ret, fw_name);
>> +    }
>> +
>> +    memunmap(mem_virt);
>> +err_release_fw:
>> +    release_firmware(firmware);
>> +    return ret;
>> +}
>> +
>> +int auth_reset_fw(u32 pas_id)
>> +{
>> +    return qcom_scm_pas_auth_and_reset(pas_id);
>> +}
>> +
>> +void unload_fw(u32 pas_id)
>> +{
>> +    qcom_scm_pas_shutdown(pas_id);
>> +}
>> +
>> +int set_hw_state(bool resume)
>> +{
>> +    return qcom_scm_set_remote_state(resume, 0);
>> +}
>> diff --git a/drivers/media/platform/qcom/vcodec/firmware.h
>> b/drivers/media/platform/qcom/vcodec/firmware.h
>> new file mode 100644
>> index 0000000..7d410a8
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/vcodec/firmware.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights
>> reserved.
>> + */
>> +
>> +#ifndef _FIRMWARE_H_
>> +#define _FIRMWARE_H_
>> +
>> +#include <linux/device.h>
>> +#include <linux/types.h>
>> +
>> +bool use_tz(struct device *core_dev);
>> +int load_fw(struct device *dev, const char *fw_name, phys_addr_t *mem_phys,
>> +        size_t *mem_size, u32 pas_id, bool use_tz);
>> +int auth_reset_fw(u32 pas_id);
>> +int protect_secure_region(u32 cp_start, u32 cp_size, u32 cp_nonpixel_start,
>> +              u32 cp_nonpixel_size, u32 pas_id);
>> +void unload_fw(u32 pas_id);
>> +int set_hw_state(bool resume);
>> +
>> +#endif
>> diff --git a/drivers/media/platform/qcom/venus/Kconfig
>> b/drivers/media/platform/qcom/vcodec/venus/Kconfig
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/Kconfig
>> rename to drivers/media/platform/qcom/vcodec/venus/Kconfig
>> diff --git a/drivers/media/platform/qcom/venus/Makefile
>> b/drivers/media/platform/qcom/vcodec/venus/Makefile
>> similarity index 83%
>> rename from drivers/media/platform/qcom/venus/Makefile
>> rename to drivers/media/platform/qcom/vcodec/venus/Makefile
>> index 91ee6be..f6f3a88 100644
>> --- a/drivers/media/platform/qcom/venus/Makefile
>> +++ b/drivers/media/platform/qcom/vcodec/venus/Makefile
>> @@ -1,7 +1,9 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   # Makefile for Qualcomm Venus driver
>>   -venus-core-objs += core.o helpers.o firmware.o \
>> +venus-core-objs += ../firmware.o
>> +
>> +venus-core-objs += core.o helpers.o firmware_no_tz.o \
>>              hfi_venus.o hfi_msgs.o hfi_cmds.o hfi.o \
>>              hfi_parser.o pm_helpers.o dbgfs.o \
>>              hfi_platform.o hfi_platform_v4.o \
>> diff --git a/drivers/media/platform/qcom/venus/core.c
>> b/drivers/media/platform/qcom/vcodec/venus/core.c
>> similarity index 91%
>> rename from drivers/media/platform/qcom/venus/core.c
>> rename to drivers/media/platform/qcom/vcodec/venus/core.c
>> index 9cffe97..56d9a53 100644
>> --- a/drivers/media/platform/qcom/venus/core.c
>> +++ b/drivers/media/platform/qcom/vcodec/venus/core.c
>> @@ -22,7 +22,8 @@
>>   #include <media/v4l2-ioctl.h>
>>     #include "core.h"
>> -#include "firmware.h"
>> +#include "../firmware.h"
>> +#include "firmware_no_tz.h"
>>   #include "pm_helpers.h"
>>   #include "hfi_venus_io.h"
>>   @@ -86,6 +87,8 @@ static void venus_sys_error_handler(struct
>> work_struct *work)
>>       struct venus_core *core =
>>               container_of(work, struct venus_core, work.work);
>>       int ret, i, max_attempts = RPM_WAIT_FOR_IDLE_MAX_ATTEMPTS;
>> +    const struct venus_resources *res = core->res;
>> +    const char *fwpath = NULL;
>>       const char *err_msg = "";
>>       bool failed = false;
>>   @@ -107,7 +110,10 @@ static void venus_sys_error_handler(struct
>> work_struct *work)
>>         mutex_lock(&core->lock);
>>   -    venus_shutdown(core);
>> +    if (core->use_tz)
>> +        unload_fw(VENUS_PAS_ID);
>> +    else
>> +        unload_fw_no_tz(core);
> 
> This is more than introducing helpers.
> 
The new helpers are written to make the code generic for video drivers.
which requires changes in the calling function also.
>>         venus_coredump(core);
>>   @@ -127,12 +133,39 @@ static void venus_sys_error_handler(struct
>> work_struct *work)
>>           failed = true;
>>       }
>>   -    ret = venus_boot(core);
>> +    ret = of_property_read_string_index(core->dev->of_node,
>> "firmware-name", 0,
>> +                        &fwpath);
>> +    if (ret)
>> +        fwpath = core->res->fwname;
>> +
>> +    ret = load_fw(core->dev, fwpath, &core->fw.mem_phys,
>> &core->fw.mem_size,
>> +              VENUS_PAS_ID, core->use_tz);
> 
> So, we had a nice local 'venus_boot'. Instead we now have a pile of code
> with non-generic prefixes, etc. If you are introducing helpers, please
> refrain from inlining of calling functions, etc. Just move the code to your
> helpers.
> 
As mentioned in above comment, the common helpers are written to make the
code generic. I Will try to make it more clear, working on the same.
> NAK for the rest of the patch.
> 
>>       if (ret && !failed) {
>> -        err_msg = "boot Venus";
>> +        err_msg = "load FW";
>>           failed = true;
>>       }
>>   +    if (core->use_tz)
>> +        ret = auth_reset_fw(VENUS_PAS_ID);
>> +    else
>> +        ret = auth_reset_fw_no_tz(core, core->fw.mem_phys,
>> core->fw.mem_size);
>> +    if (ret && !failed) {
>> +        err_msg = "Auth and Reset";
>> +        failed = true;
>> +    }
>> +
>> +    if (core->use_tz && res->cp_size) {
>> +        ret = protect_secure_region(res->cp_start,
>> +                        res->cp_size,
>> +                        res->cp_nonpixel_start,
>> +                        res->cp_nonpixel_size,
>> +                        VENUS_PAS_ID);
>> +        if (ret && !failed) {
>> +            err_msg = "Protect CP Mem";
>> +            failed = true;
>> +        }
>> +    }
>> +
>>       ret = hfi_core_resume(core, true);
>>       if (ret && !failed) {
>>           err_msg = "resume HFI";
>> @@ -281,7 +314,9 @@ static irqreturn_t venus_isr_thread(int irq, void
>> *dev_id)
>>     static int venus_probe(struct platform_device *pdev)
>>   {
>> +    const struct venus_resources *res;
>>       struct device *dev = &pdev->dev;
>> +    const char *fwpath = NULL;
>>       struct venus_core *core;
>>       int ret;
>>   @@ -362,14 +397,42 @@ static int venus_probe(struct platform_device *pdev)
>>       if (ret)
>>           goto err_runtime_disable;
>>   -    ret = venus_firmware_init(core);
>> +    core->use_tz = use_tz(core->dev);
>> +
>> +    if (!core->use_tz) {
>> +        ret = init_fw_no_tz(core);
>> +        if (ret)
>> +            goto err_of_depopulate;
>> +    }
>> +
>> +    ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
>> +                        &fwpath);
>>       if (ret)
>> -        goto err_of_depopulate;
>> +        fwpath = core->res->fwname;
>>   -    ret = venus_boot(core);
>> +    ret = load_fw(core->dev, fwpath, &core->fw.mem_phys,
>> &core->fw.mem_size,
>> +              VENUS_PAS_ID, core->use_tz);
>>       if (ret)
>>           goto err_firmware_deinit;
>>   +    if (core->use_tz)
>> +        ret = auth_reset_fw(VENUS_PAS_ID);
>> +    else
>> +        ret = auth_reset_fw_no_tz(core, core->fw.mem_phys,
>> core->fw.mem_size);
>> +    if (ret)
>> +        goto err_firmware_deinit;
>> +
>> +    res = core->res;
>> +    if (core->use_tz && res->cp_size) {
>> +        ret = protect_secure_region(res->cp_start,
>> +                        res->cp_size,
>> +                        res->cp_nonpixel_start,
>> +                        res->cp_nonpixel_size,
>> +                        VENUS_PAS_ID);
>> +        if (ret)
>> +            goto err_firmware_deinit;
>> +    }
>> +
>>       ret = hfi_core_resume(core, true);
>>       if (ret)
>>           goto err_venus_shutdown;
>> @@ -399,9 +462,13 @@ static int venus_probe(struct platform_device *pdev)
>>   err_dev_unregister:
>>       v4l2_device_unregister(&core->v4l2_dev);
>>   err_venus_shutdown:
>> -    venus_shutdown(core);
>> +    if (core->use_tz)
>> +        unload_fw(VENUS_PAS_ID);
>> +    else
>> +        unload_fw_no_tz(core);
>>   err_firmware_deinit:
>> -    venus_firmware_deinit(core);
>> +    if (!core->use_tz)
>> +        deinit_fw_no_tz(core);
>>   err_of_depopulate:
>>       of_platform_depopulate(dev);
>>   err_runtime_disable:
>> @@ -430,10 +497,15 @@ static void venus_remove(struct platform_device *pdev)
>>       ret = hfi_core_deinit(core, true);
>>       WARN_ON(ret);
>>   -    venus_shutdown(core);
>> +    if (core->use_tz)
>> +        unload_fw(VENUS_PAS_ID);
>> +    else
>> +        unload_fw_no_tz(core);
>> +
>>       of_platform_depopulate(dev);
>>   -    venus_firmware_deinit(core);
>> +    if (!core->use_tz)
>> +        deinit_fw_no_tz(core);
>>         pm_runtime_put_sync(dev);
>>       pm_runtime_disable(dev);
>> @@ -455,8 +527,12 @@ static void venus_core_shutdown(struct
>> platform_device *pdev)
>>       struct venus_core *core = platform_get_drvdata(pdev);
>>         pm_runtime_get_sync(core->dev);
>> -    venus_shutdown(core);
>> -    venus_firmware_deinit(core);
>> +    if (core->use_tz) {
>> +        unload_fw(VENUS_PAS_ID);
>> +    } else {
>> +        unload_fw_no_tz(core);
>> +        deinit_fw_no_tz(core);
>> +    }
>>       pm_runtime_put_sync(core->dev);
>>   }
>>   diff --git a/drivers/media/platform/qcom/venus/core.h
>> b/drivers/media/platform/qcom/vcodec/venus/core.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/core.h
>> rename to drivers/media/platform/qcom/vcodec/venus/core.h
>> diff --git a/drivers/media/platform/qcom/venus/dbgfs.c
>> b/drivers/media/platform/qcom/vcodec/venus/dbgfs.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/dbgfs.c
>> rename to drivers/media/platform/qcom/vcodec/venus/dbgfs.c
>> diff --git a/drivers/media/platform/qcom/venus/dbgfs.h
>> b/drivers/media/platform/qcom/vcodec/venus/dbgfs.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/dbgfs.h
>> rename to drivers/media/platform/qcom/vcodec/venus/dbgfs.h
>> diff --git a/drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.c
>> b/drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.c
>> new file mode 100644
>> index 0000000..9dca6e23
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.c
>> @@ -0,0 +1,194 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2017 Linaro Ltd.
>> + */
>> +
>> +#include <linux/iommu.h>
>> +#include <linux/of_device.h>
>> +#include "core.h"
>> +#include "firmware_no_tz.h"
>> +#include "hfi_venus_io.h"
>> +
>> +#define VENUS_FW_MEM_SIZE        (6 * SZ_1M)
>> +#define VENUS_FW_START_ADDR        0x0
>> +
>> +int init_fw_no_tz(struct venus_core *core)
>> +{
>> +    struct platform_device_info info;
>> +    struct iommu_domain *iommu_dom;
>> +    struct platform_device *pdev;
>> +    struct device_node *np;
>> +    int ret;
>> +
>> +    np = of_get_child_by_name(core->dev->of_node, "video-firmware");
>> +
>> +    memset(&info, 0, sizeof(info));
>> +    info.fwnode = &np->fwnode;
>> +    info.parent = core->dev;
>> +    info.name = np->name;
>> +    info.dma_mask = DMA_BIT_MASK(32);
>> +
>> +    pdev = platform_device_register_full(&info);
>> +    if (IS_ERR(pdev)) {
>> +        of_node_put(np);
>> +        return PTR_ERR(pdev);
>> +    }
>> +
>> +    pdev->dev.of_node = np;
>> +
>> +    ret = of_dma_configure(&pdev->dev, np, true);
>> +    if (ret) {
>> +        dev_err(core->dev, "dma configure fail\n");
>> +        goto err_unregister;
>> +    }
>> +
>> +    core->fw.dev = &pdev->dev;
>> +
>> +    iommu_dom = iommu_domain_alloc(&platform_bus_type);
>> +    if (!iommu_dom) {
>> +        dev_err(core->fw.dev, "Failed to allocate iommu domain\n");
>> +        ret = -ENOMEM;
>> +        goto err_unregister;
>> +    }
>> +
>> +    ret = iommu_attach_device(iommu_dom, core->fw.dev);
>> +    if (ret) {
>> +        dev_err(core->fw.dev, "could not attach device\n");
>> +        goto err_iommu_free;
>> +    }
>> +
>> +    core->fw.iommu_domain = iommu_dom;
>> +
>> +    of_node_put(np);
>> +
>> +    return 0;
>> +
>> +err_iommu_free:
>> +    iommu_domain_free(iommu_dom);
>> +err_unregister:
>> +    platform_device_unregister(pdev);
>> +    of_node_put(np);
>> +    return ret;
>> +}
>> +
>> +void deinit_fw_no_tz(struct venus_core *core)
>> +{
>> +    struct iommu_domain *iommu;
>> +
>> +    if (!core->fw.dev)
>> +        return;
>> +
>> +    iommu = core->fw.iommu_domain;
>> +
>> +    iommu_detach_device(iommu, core->fw.dev);
>> +
>> +    if (iommu) {
>> +        iommu_domain_free(iommu);
>> +        iommu = NULL;
>> +    }
>> +
>> +    platform_device_unregister(to_platform_device(core->fw.dev));
>> +}
>> +
>> +static void reset_cpu_no_tz(struct venus_core *core)
>> +{
>> +    u32 fw_size = core->fw.mapped_mem_size;
>> +    void __iomem *wrapper_base;
>> +
>> +    if (IS_IRIS2_1(core))
>> +        wrapper_base = core->wrapper_tz_base;
>> +    else
>> +        wrapper_base = core->wrapper_base;
>> +
>> +    writel(0, wrapper_base + WRAPPER_FW_START_ADDR);
>> +    writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
>> +    writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
>> +    writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
>> +    writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
>> +    writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>> +
>> +    if (IS_IRIS2_1(core)) {
>> +        /* Bring XTSS out of reset */
>> +        writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
>> +    } else {
>> +        writel(0x0, wrapper_base + WRAPPER_CPU_CGC_DIS);
>> +        writel(0x0, wrapper_base + WRAPPER_CPU_CLOCK_CONFIG);
>> +
>> +        /* Bring ARM9 out of reset */
>> +        writel(0, wrapper_base + WRAPPER_A9SS_SW_RESET);
>> +    }
>> +}
>> +
>> +void set_hw_state_no_tz(struct venus_core *core, bool resume)
>> +{
>> +    if (resume) {
>> +        reset_cpu_no_tz(core);
>> +    } else {
>> +        if (IS_IRIS2_1(core))
>> +            writel(WRAPPER_XTSS_SW_RESET_BIT,
>> +                   core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>> +        else
>> +            writel(WRAPPER_A9SS_SW_RESET_BIT,
>> +                   core->wrapper_base + WRAPPER_A9SS_SW_RESET);
>> +    }
>> +}
>> +
>> +int auth_reset_fw_no_tz(struct venus_core *core, phys_addr_t mem_phys,
>> +            size_t mem_size)
>> +{
>> +    struct iommu_domain *iommu;
>> +    struct device *dev;
>> +    int ret;
>> +
>> +    dev = core->fw.dev;
>> +    if (!dev)
>> +        return -EPROBE_DEFER;
>> +
>> +    iommu = core->fw.iommu_domain;
>> +    core->fw.mapped_mem_size = mem_size;
>> +
>> +    ret = iommu_map(iommu, VENUS_FW_START_ADDR, mem_phys, mem_size,
>> +            IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
>> +    if (ret) {
>> +        dev_err(dev, "could not map video firmware region\n");
>> +        return ret;
>> +    }
>> +
>> +    reset_cpu_no_tz(core);
>> +
>> +    return 0;
>> +}
>> +
>> +void unload_fw_no_tz(struct venus_core *core)
>> +{
>> +    const size_t mapped = core->fw.mapped_mem_size;
>> +    struct iommu_domain *iommu;
>> +    size_t unmapped;
>> +    u32 reg;
>> +    struct device *dev = core->fw.dev;
>> +    void __iomem *wrapper_base = core->wrapper_base;
>> +    void __iomem *wrapper_tz_base = core->wrapper_tz_base;
>> +
>> +    if (IS_IRIS2_1(core)) {
>> +        /* Assert the reset to XTSS */
>> +        reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>> +        reg |= WRAPPER_XTSS_SW_RESET_BIT;
>> +        writel(reg, wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>> +    } else {
>> +        /* Assert the reset to ARM9 */
>> +        reg = readl(wrapper_base + WRAPPER_A9SS_SW_RESET);
>> +        reg |= WRAPPER_A9SS_SW_RESET_BIT;
>> +        writel(reg, wrapper_base + WRAPPER_A9SS_SW_RESET);
>> +    }
>> +
>> +    iommu = core->fw.iommu_domain;
>> +
>> +    if (core->fw.mapped_mem_size && iommu) {
>> +        unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, mapped);
>> +
>> +        if (unmapped != mapped)
>> +            dev_err(dev, "failed to unmap firmware\n");
>> +        else
>> +            core->fw.mapped_mem_size = 0;
>> +    }
>> +}
>> diff --git a/drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.h
>> b/drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.h
>> new file mode 100644
>> index 0000000..5f008ef
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2017 Linaro Ltd.
>> + */
>> +#ifndef __FIRMWARE_NO_TZ_H__
>> +#define __FIRMWARE_NO_TZ_H__
>> +
>> +struct device;
>> +
>> +#define VENUS_PAS_ID    9
>> +
>> +int init_fw_no_tz(struct venus_core *core);
>> +void deinit_fw_no_tz(struct venus_core *core);
>> +int auth_reset_fw_no_tz(struct venus_core *core, phys_addr_t mem_phys,
>> +            size_t mem_size);
>> +void unload_fw_no_tz(struct venus_core *core);
>> +void set_hw_state_no_tz(struct venus_core *core, bool resume);
>> +
>> +#endif
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c
>> b/drivers/media/platform/qcom/vcodec/venus/helpers.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/helpers.c
>> rename to drivers/media/platform/qcom/vcodec/venus/helpers.c
>> diff --git a/drivers/media/platform/qcom/venus/helpers.h
>> b/drivers/media/platform/qcom/vcodec/venus/helpers.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/helpers.h
>> rename to drivers/media/platform/qcom/vcodec/venus/helpers.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi.c
>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_cmds.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_cmds.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_cmds.c
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_cmds.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_cmds.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_cmds.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_helper.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_helper.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_helper.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_msgs.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_msgs.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_msgs.c
>> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_msgs.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_msgs.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_msgs.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_parser.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_parser.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_parser.c
>> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_parser.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_parser.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_parser.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_plat_bufs.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
>> diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_platform.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_platform.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_platform.c
>> diff --git a/drivers/media/platform/qcom/venus/hfi_platform.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_platform.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_platform.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_platform.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v4.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_platform_v4.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_platform_v4.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_platform_v4.c
>> diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v6.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_platform_v6.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_platform_v6.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_platform_v6.c
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_venus.c
>> similarity index 99%
>> rename from drivers/media/platform/qcom/venus/hfi_venus.c
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_venus.c
>> index f9437b6..5a68db9 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/vcodec/venus/hfi_venus.c
>> @@ -13,11 +13,12 @@
>>   #include <linux/slab.h>
>>     #include "core.h"
>> +#include "../firmware.h"
>>   #include "hfi_cmds.h"
>>   #include "hfi_msgs.h"
>>   #include "hfi_venus.h"
>>   #include "hfi_venus_io.h"
>> -#include "firmware.h"
>> +#include "firmware_no_tz.h"
>>     #define HFI_MASK_QHDR_TX_TYPE        0xff000000
>>   #define HFI_MASK_QHDR_RX_TYPE        0x00ff0000
>> @@ -635,7 +636,10 @@ static int venus_power_off(struct venus_hfi_device
>> *hdev)
>>       if (!hdev->power_enabled)
>>           return 0;
>>   -    ret = venus_set_hw_state_suspend(hdev->core);
>> +    if (hdev->core->use_tz)
>> +        ret = set_hw_state(false);
>> +    else
>> +        set_hw_state_no_tz(hdev->core, false);
>>       if (ret)
>>           return ret;
>>   @@ -655,7 +659,13 @@ static int venus_power_on(struct venus_hfi_device
>> *hdev)
>>       if (hdev->power_enabled)
>>           return 0;
>>   -    ret = venus_set_hw_state_resume(hdev->core);
>> +    if (hdev->core->use_tz) {
>> +        ret = set_hw_state(true);
>> +        if (ret == -EINVAL)
>> +            ret = 0;
>> +    } else {
>> +        set_hw_state_no_tz(hdev->core, true);
>> +    }
>>       if (ret)
>>           goto err;
>>   @@ -668,7 +678,10 @@ static int venus_power_on(struct venus_hfi_device
>> *hdev)
>>       return 0;
>>     err_suspend:
>> -    venus_set_hw_state_suspend(hdev->core);
>> +    if (hdev->core->use_tz)
>> +        set_hw_state(false);
>> +    else
>> +        set_hw_state_no_tz(hdev->core, false);
>>   err:
>>       hdev->power_enabled = false;
>>       return ret;
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_venus.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_venus.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_venus.h
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h
>> b/drivers/media/platform/qcom/vcodec/venus/hfi_venus_io.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/hfi_venus_io.h
>> rename to drivers/media/platform/qcom/vcodec/venus/hfi_venus_io.h
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c
>> b/drivers/media/platform/qcom/vcodec/venus/pm_helpers.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/pm_helpers.c
>> rename to drivers/media/platform/qcom/vcodec/venus/pm_helpers.c
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h
>> b/drivers/media/platform/qcom/vcodec/venus/pm_helpers.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/pm_helpers.h
>> rename to drivers/media/platform/qcom/vcodec/venus/pm_helpers.h
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c
>> b/drivers/media/platform/qcom/vcodec/venus/vdec.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/vdec.c
>> rename to drivers/media/platform/qcom/vcodec/venus/vdec.c
>> diff --git a/drivers/media/platform/qcom/venus/vdec.h
>> b/drivers/media/platform/qcom/vcodec/venus/vdec.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/vdec.h
>> rename to drivers/media/platform/qcom/vcodec/venus/vdec.h
>> diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c
>> b/drivers/media/platform/qcom/vcodec/venus/vdec_ctrls.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/vdec_ctrls.c
>> rename to drivers/media/platform/qcom/vcodec/venus/vdec_ctrls.c
>> diff --git a/drivers/media/platform/qcom/venus/venc.c
>> b/drivers/media/platform/qcom/vcodec/venus/venc.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/venc.c
>> rename to drivers/media/platform/qcom/vcodec/venus/venc.c
>> diff --git a/drivers/media/platform/qcom/venus/venc.h
>> b/drivers/media/platform/qcom/vcodec/venus/venc.h
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/venc.h
>> rename to drivers/media/platform/qcom/vcodec/venus/venc.h
>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> b/drivers/media/platform/qcom/vcodec/venus/venc_ctrls.c
>> similarity index 100%
>> rename from drivers/media/platform/qcom/venus/venc_ctrls.c
>> rename to drivers/media/platform/qcom/vcodec/venus/venc_ctrls.c
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c
>> b/drivers/media/platform/qcom/venus/firmware.c
>> deleted file mode 100644
>> index fe7da2b..0000000
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ /dev/null
>> @@ -1,363 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-only
>> -/*
>> - * Copyright (C) 2017 Linaro Ltd.
>> - */
>> -
>> -#include <linux/device.h>
>> -#include <linux/firmware.h>
>> -#include <linux/kernel.h>
>> -#include <linux/iommu.h>
>> -#include <linux/io.h>
>> -#include <linux/of.h>
>> -#include <linux/of_address.h>
>> -#include <linux/of_reserved_mem.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/of_device.h>
>> -#include <linux/firmware/qcom/qcom_scm.h>
>> -#include <linux/sizes.h>
>> -#include <linux/soc/qcom/mdt_loader.h>
>> -
>> -#include "core.h"
>> -#include "firmware.h"
>> -#include "hfi_venus_io.h"
>> -
>> -#define VENUS_PAS_ID            9
>> -#define VENUS_FW_MEM_SIZE        (6 * SZ_1M)
>> -#define VENUS_FW_START_ADDR        0x0
>> -
>> -static void venus_reset_cpu(struct venus_core *core)
>> -{
>> -    u32 fw_size = core->fw.mapped_mem_size;
>> -    void __iomem *wrapper_base;
>> -
>> -    if (IS_IRIS2_1(core))
>> -        wrapper_base = core->wrapper_tz_base;
>> -    else
>> -        wrapper_base = core->wrapper_base;
>> -
>> -    writel(0, wrapper_base + WRAPPER_FW_START_ADDR);
>> -    writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
>> -    writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
>> -    writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
>> -    writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
>> -    writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>> -
>> -    if (IS_IRIS2_1(core)) {
>> -        /* Bring XTSS out of reset */
>> -        writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
>> -    } else {
>> -        writel(0x0, wrapper_base + WRAPPER_CPU_CGC_DIS);
>> -        writel(0x0, wrapper_base + WRAPPER_CPU_CLOCK_CONFIG);
>> -
>> -        /* Bring ARM9 out of reset */
>> -        writel(0, wrapper_base + WRAPPER_A9SS_SW_RESET);
>> -    }
>> -}
>> -
>> -int venus_set_hw_state(struct venus_core *core, bool resume)
>> -{
>> -    int ret;
>> -
>> -    if (core->use_tz) {
>> -        ret = qcom_scm_set_remote_state(resume, 0);
>> -        if (resume && ret == -EINVAL)
>> -            ret = 0;
>> -        return ret;
>> -    }
>> -
>> -    if (resume) {
>> -        venus_reset_cpu(core);
>> -    } else {
>> -        if (IS_IRIS2_1(core))
>> -            writel(WRAPPER_XTSS_SW_RESET_BIT,
>> -                   core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>> -        else
>> -            writel(WRAPPER_A9SS_SW_RESET_BIT,
>> -                   core->wrapper_base + WRAPPER_A9SS_SW_RESET);
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>> -static int venus_load_fw(struct venus_core *core, const char *fwname,
>> -             phys_addr_t *mem_phys, size_t *mem_size)
>> -{
>> -    const struct firmware *mdt;
>> -    struct reserved_mem *rmem;
>> -    struct device_node *node;
>> -    struct device *dev;
>> -    ssize_t fw_size;
>> -    void *mem_va;
>> -    int ret;
>> -
>> -    *mem_phys = 0;
>> -    *mem_size = 0;
>> -
>> -    dev = core->dev;
>> -    node = of_parse_phandle(dev->of_node, "memory-region", 0);
>> -    if (!node) {
>> -        dev_err(dev, "no memory-region specified\n");
>> -        return -EINVAL;
>> -    }
>> -
>> -    rmem = of_reserved_mem_lookup(node);
>> -    of_node_put(node);
>> -    if (!rmem) {
>> -        dev_err(dev, "failed to lookup reserved memory-region\n");
>> -        return -EINVAL;
>> -    }
>> -
>> -    ret = request_firmware(&mdt, fwname, dev);
>> -    if (ret < 0)
>> -        return ret;
>> -
>> -    fw_size = qcom_mdt_get_size(mdt);
>> -    if (fw_size < 0) {
>> -        ret = fw_size;
>> -        goto err_release_fw;
>> -    }
>> -
>> -    *mem_phys = rmem->base;
>> -    *mem_size = rmem->size;
>> -
>> -    if (*mem_size < fw_size || fw_size > VENUS_FW_MEM_SIZE) {
>> -        ret = -EINVAL;
>> -        goto err_release_fw;
>> -    }
>> -
>> -    mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
>> -    if (!mem_va) {
>> -        dev_err(dev, "unable to map memory region %pa size %#zx\n",
>> mem_phys, *mem_size);
>> -        ret = -ENOMEM;
>> -        goto err_release_fw;
>> -    }
>> -
>> -    if (core->use_tz)
>> -        ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
>> -                    mem_va, *mem_phys, *mem_size, NULL);
>> -    else
>> -        ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
>> -                        mem_va, *mem_phys, *mem_size, NULL);
>> -
>> -    memunmap(mem_va);
>> -err_release_fw:
>> -    release_firmware(mdt);
>> -    return ret;
>> -}
>> -
>> -static int venus_boot_no_tz(struct venus_core *core, phys_addr_t mem_phys,
>> -                size_t mem_size)
>> -{
>> -    struct iommu_domain *iommu;
>> -    struct device *dev;
>> -    int ret;
>> -
>> -    dev = core->fw.dev;
>> -    if (!dev)
>> -        return -EPROBE_DEFER;
>> -
>> -    iommu = core->fw.iommu_domain;
>> -    core->fw.mapped_mem_size = mem_size;
>> -
>> -    ret = iommu_map(iommu, VENUS_FW_START_ADDR, mem_phys, mem_size,
>> -            IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV, GFP_KERNEL);
>> -    if (ret) {
>> -        dev_err(dev, "could not map video firmware region\n");
>> -        return ret;
>> -    }
>> -
>> -    venus_reset_cpu(core);
>> -
>> -    return 0;
>> -}
>> -
>> -static int venus_shutdown_no_tz(struct venus_core *core)
>> -{
>> -    const size_t mapped = core->fw.mapped_mem_size;
>> -    struct iommu_domain *iommu;
>> -    size_t unmapped;
>> -    u32 reg;
>> -    struct device *dev = core->fw.dev;
>> -    void __iomem *wrapper_base = core->wrapper_base;
>> -    void __iomem *wrapper_tz_base = core->wrapper_tz_base;
>> -
>> -    if (IS_IRIS2_1(core)) {
>> -        /* Assert the reset to XTSS */
>> -        reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>> -        reg |= WRAPPER_XTSS_SW_RESET_BIT;
>> -        writel(reg, wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>> -    } else {
>> -        /* Assert the reset to ARM9 */
>> -        reg = readl(wrapper_base + WRAPPER_A9SS_SW_RESET);
>> -        reg |= WRAPPER_A9SS_SW_RESET_BIT;
>> -        writel(reg, wrapper_base + WRAPPER_A9SS_SW_RESET);
>> -    }
>> -
>> -    iommu = core->fw.iommu_domain;
>> -
>> -    if (core->fw.mapped_mem_size && iommu) {
>> -        unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, mapped);
>> -
>> -        if (unmapped != mapped)
>> -            dev_err(dev, "failed to unmap firmware\n");
>> -        else
>> -            core->fw.mapped_mem_size = 0;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>> -int venus_boot(struct venus_core *core)
>> -{
>> -    struct device *dev = core->dev;
>> -    const struct venus_resources *res = core->res;
>> -    const char *fwpath = NULL;
>> -    phys_addr_t mem_phys;
>> -    size_t mem_size;
>> -    int ret;
>> -
>> -    if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
>> -        (core->use_tz && !qcom_scm_is_available()))
>> -        return -EPROBE_DEFER;
>> -
>> -    ret = of_property_read_string_index(dev->of_node, "firmware-name", 0,
>> -                        &fwpath);
>> -    if (ret)
>> -        fwpath = core->res->fwname;
>> -
>> -    ret = venus_load_fw(core, fwpath, &mem_phys, &mem_size);
>> -    if (ret) {
>> -        dev_err(dev, "fail to load video firmware\n");
>> -        return -EINVAL;
>> -    }
>> -
>> -    core->fw.mem_size = mem_size;
>> -    core->fw.mem_phys = mem_phys;
>> -
>> -    if (core->use_tz)
>> -        ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
>> -    else
>> -        ret = venus_boot_no_tz(core, mem_phys, mem_size);
>> -
>> -    if (ret)
>> -        return ret;
>> -
>> -    if (core->use_tz && res->cp_size) {
>> -        /*
>> -         * Clues for porting using downstream data:
>> -         * cp_start = 0
>> -         * cp_size = venus_ns/virtual-addr-pool[0] - yes, address and
>> not size!
>> -         *   This works, as the non-secure context bank is placed
>> -         *   contiguously right after the Content Protection region.
>> -         *
>> -         * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
>> -         * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
>> -         */
>> -        ret = qcom_scm_mem_protect_video_var(res->cp_start,
>> -                             res->cp_size,
>> -                             res->cp_nonpixel_start,
>> -                             res->cp_nonpixel_size);
>> -        if (ret) {
>> -            qcom_scm_pas_shutdown(VENUS_PAS_ID);
>> -            dev_err(dev, "set virtual address ranges fail (%d)\n",
>> -                ret);
>> -            return ret;
>> -        }
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>> -int venus_shutdown(struct venus_core *core)
>> -{
>> -    int ret;
>> -
>> -    if (core->use_tz)
>> -        ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
>> -    else
>> -        ret = venus_shutdown_no_tz(core);
>> -
>> -    return ret;
>> -}
>> -
>> -int venus_firmware_init(struct venus_core *core)
>> -{
>> -    struct platform_device_info info;
>> -    struct iommu_domain *iommu_dom;
>> -    struct platform_device *pdev;
>> -    struct device_node *np;
>> -    int ret;
>> -
>> -    np = of_get_child_by_name(core->dev->of_node, "video-firmware");
>> -    if (!np) {
>> -        core->use_tz = true;
>> -        return 0;
>> -    }
>> -
>> -    memset(&info, 0, sizeof(info));
>> -    info.fwnode = &np->fwnode;
>> -    info.parent = core->dev;
>> -    info.name = np->name;
>> -    info.dma_mask = DMA_BIT_MASK(32);
>> -
>> -    pdev = platform_device_register_full(&info);
>> -    if (IS_ERR(pdev)) {
>> -        of_node_put(np);
>> -        return PTR_ERR(pdev);
>> -    }
>> -
>> -    pdev->dev.of_node = np;
>> -
>> -    ret = of_dma_configure(&pdev->dev, np, true);
>> -    if (ret) {
>> -        dev_err(core->dev, "dma configure fail\n");
>> -        goto err_unregister;
>> -    }
>> -
>> -    core->fw.dev = &pdev->dev;
>> -
>> -    iommu_dom = iommu_domain_alloc(&platform_bus_type);
>> -    if (!iommu_dom) {
>> -        dev_err(core->fw.dev, "Failed to allocate iommu domain\n");
>> -        ret = -ENOMEM;
>> -        goto err_unregister;
>> -    }
>> -
>> -    ret = iommu_attach_device(iommu_dom, core->fw.dev);
>> -    if (ret) {
>> -        dev_err(core->fw.dev, "could not attach device\n");
>> -        goto err_iommu_free;
>> -    }
>> -
>> -    core->fw.iommu_domain = iommu_dom;
>> -
>> -    of_node_put(np);
>> -
>> -    return 0;
>> -
>> -err_iommu_free:
>> -    iommu_domain_free(iommu_dom);
>> -err_unregister:
>> -    platform_device_unregister(pdev);
>> -    of_node_put(np);
>> -    return ret;
>> -}
>> -
>> -void venus_firmware_deinit(struct venus_core *core)
>> -{
>> -    struct iommu_domain *iommu;
>> -
>> -    if (!core->fw.dev)
>> -        return;
>> -
>> -    iommu = core->fw.iommu_domain;
>> -
>> -    iommu_detach_device(iommu, core->fw.dev);
>> -
>> -    if (core->fw.iommu_domain) {
>> -        iommu_domain_free(iommu);
>> -        core->fw.iommu_domain = NULL;
>> -    }
>> -
>> -    platform_device_unregister(to_platform_device(core->fw.dev));
>> -}
>> diff --git a/drivers/media/platform/qcom/venus/firmware.h
>> b/drivers/media/platform/qcom/venus/firmware.h
>> deleted file mode 100644
>> index aaccd84..0000000
>> --- a/drivers/media/platform/qcom/venus/firmware.h
>> +++ /dev/null
>> @@ -1,26 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0-only */
>> -/*
>> - * Copyright (C) 2017 Linaro Ltd.
>> - */
>> -#ifndef __VENUS_FIRMWARE_H__
>> -#define __VENUS_FIRMWARE_H__
>> -
>> -struct device;
>> -
>> -int venus_firmware_init(struct venus_core *core);
>> -void venus_firmware_deinit(struct venus_core *core);
>> -int venus_boot(struct venus_core *core);
>> -int venus_shutdown(struct venus_core *core);
>> -int venus_set_hw_state(struct venus_core *core, bool suspend);
>> -
>> -static inline int venus_set_hw_state_suspend(struct venus_core *core)
>> -{
>> -    return venus_set_hw_state(core, false);
>> -}
>> -
>> -static inline int venus_set_hw_state_resume(struct venus_core *core)
>> -{
>> -    return venus_set_hw_state(core, true);
>> -}
>> -
>> -#endif
> 

