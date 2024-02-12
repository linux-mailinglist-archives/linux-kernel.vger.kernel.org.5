Return-Path: <linux-kernel+bounces-61301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074518510B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EEE1F225BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B41BC44;
	Mon, 12 Feb 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W8AmDKDn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51B249F8;
	Mon, 12 Feb 2024 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733486; cv=none; b=iSUnU9fblwzfeTI4v4RiDEZBjiQnES76XKpKb1X6p0EVOBxC/gxFNzTh3g2OMF37pVH0WneqciqwkSSUqbwxXxXKl/X2fyWJcCEi2eX7ZYSNny0/BYPOA05d3CWe49BCJOOWXXbPKbScYJ1GXuMprizSSqJ6iTfdxE9sJp4ruNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733486; c=relaxed/simple;
	bh=iQs/o9CIQANTkXd8ve3L5t31ZIMZK9qmCwRgOcEU3HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uBo4fFawSumlfm1HWT2ZsbH0azXjJb1u4qen79TCfZXlhWPkvL5IjXlTniC3BhdbP3lfMzPpPjByrLMSMS5YpLhn7KSRB0SHchXXzHRYOBPTlOIJeUTnnGGUa2lIwm0XGKiem4UGbCSjmz4/Vw7pDzTTMqDh+cAu6Cw+kOpZdR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W8AmDKDn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C9iMv2010854;
	Mon, 12 Feb 2024 10:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=aQpeIXHrD7clHlUGVyHwyX33xTNaOosp2vtddFb6hxY=; b=W8
	AmDKDn92fU3o4v5SEyFjY8/WgYOaoXqihROd3oGAip+7CCbz06UP6bdc9I0HnLQU
	+cp6jM05e10+dEY6RukGeqK87Jl64oLRhQJ0kGUEbU8FbLdRNGHmDClN5aw7kYrO
	Kj03FU09WkH/35SrdUcZS9RWMOJw5xHwALn0jytyIhmZl5BcnG2gIu2l073BdPU+
	yxVa6R+OMnPiK6diFsSf4cKmxfk8ocRNRDlNGZ0WY+NSq7R+jpEECpNRJGf5yMCq
	I4YRhoY1xZjus7HTB4g8PwjB+jCF/Swle5uHrne5+hwMQAblErCMdmhGp24x7B3n
	Hw41hRjXRJPnU5Cps95Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62neb1hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:24:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CAOZVT030549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 10:24:35 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 02:24:30 -0800
Message-ID: <0adaa065-3883-ebfe-8259-05ebdbd821eb@quicinc.com>
Date: Mon, 12 Feb 2024 15:54:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 4/7] soc: qcom: Utilize qcom scmi vendor protocol for bus
 dvfs
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <conor+dt@kernel.org>,
        Amir Vajid <avajid@quicinc.com>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-5-quic_sibis@quicinc.com>
 <CAA8EJpr8qLZ8Y7PjU05ZoxSHWOf=q-KtM+s-tnR5X2t96rFWhw@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAA8EJpr8qLZ8Y7PjU05ZoxSHWOf=q-KtM+s-tnR5X2t96rFWhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rMe5dy7stri0tZ-3MaDGRWucw1CI_fVh
X-Proofpoint-GUID: rMe5dy7stri0tZ-3MaDGRWucw1CI_fVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_07,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120078



On 1/18/24 02:11, Dmitry Baryshkov wrote:
> On Wed, 17 Jan 2024 at 19:36, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>
>> This patch introduces a client driver that interacts with the SCMI QCOM
> 
> git grep This.patch Documentation/process/
> 
>> vendor protocol and passes on the required tuneables to start various
>> features running on the SCMI controller.
> 
> Is there any word about the 'memlat'? No. Unless one  reads into the
> patch, one can not come up with the idea of what is being introduced.

ack, will fix it in the re-spin.

> 
>>
>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
>> Co-developed-by: Amir Vajid <avajid@quicinc.com>
>> Signed-off-by: Amir Vajid <avajid@quicinc.com>
>> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/soc/qcom/Kconfig            |  10 +
>>   drivers/soc/qcom/Makefile           |   1 +
>>   drivers/soc/qcom/qcom_scmi_client.c | 486 ++++++++++++++++++++++++++++
> 
> Should it go to drivers/firmware/arm_scmi instead? Or maybe to drivers/devfreq?

I don't think it should go into arm_scmi unless Sudeep wants it there.
As for drivers/devfreq, I would have moved it there if this driver
benfitted being classified as a devfreq device. We can't use any of
the available governors on it and the tuneables appear way too custom.
These are the reasons why I placed it in drivers/soc/qcom instead.

> 
>>   3 files changed, 497 insertions(+)
>>   create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index c6ca4de42586..1530558aebfb 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -264,6 +264,16 @@ config QCOM_ICC_BWMON
>>            the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
>>            memory throughput even with lower CPU frequencies.
>>
>> +config QCOM_SCMI_CLIENT
>> +       tristate "Qualcomm Technologies Inc. SCMI client driver"
>> +       depends on QCOM_SCMI_VENDOR_PROTOCOL || COMPILE_TEST
>> +       default n
>> +       help
>> +         SCMI client driver registers for SCMI QCOM vendor protocol.
>> +
>> +         This driver interacts with the vendor protocol and passes on the required
>> +         tuneables to start various features running on the SCMI controller.
>> +
>>   config QCOM_INLINE_CRYPTO_ENGINE
>>          tristate
>>          select QCOM_SCM
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 05b3d54e8dc9..c2a51293c886 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -32,5 +32,6 @@ obj-$(CONFIG_QCOM_APR) += apr.o
>>   obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>>   obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=        kryo-l2-accessors.o
>>   obj-$(CONFIG_QCOM_ICC_BWMON)   += icc-bwmon.o
>> +obj-$(CONFIG_QCOM_SCMI_CLIENT) += qcom_scmi_client.o
>>   qcom_ice-objs                  += ice.o
>>   obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)        += qcom_ice.o
>> diff --git a/drivers/soc/qcom/qcom_scmi_client.c b/drivers/soc/qcom/qcom_scmi_client.c
>> new file mode 100644
>> index 000000000000..418aa7900496
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qcom_scmi_client.c
>> @@ -0,0 +1,486 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/qcom_scmi_vendor.h>
>> +#include <linux/scmi_protocol.h>
>> +
>> +#define MAX_MEMORY_TYPES       3
>> +#define MEMLAT_ALGO_STR                0x74616C6D656D /* "memlat" */
>> +#define INVALID_IDX            0xFF
>> +#define MAX_NAME_LEN           20
>> +#define MAX_MAP_ENTRIES                6
>> +#define MAX_MONITOR_CNT                4
>> +#define SCMI_VENDOR_MSG_START  3
>> +#define SCMI_VENDOR_MSG_MODULE_START   16
>> +
>> +enum scmi_memlat_protocol_cmd {
>> +       MEMLAT_SET_LOG_LEVEL = SCMI_VENDOR_MSG_START,
>> +       MEMLAT_FLUSH_LOGBUF,
>> +       MEMLAT_SET_MEM_GROUP = SCMI_VENDOR_MSG_MODULE_START,
>> +       MEMLAT_SET_MONITOR,
>> +       MEMLAT_SET_COMMON_EV_MAP,
>> +       MEMLAT_SET_GRP_EV_MAP,
>> +       MEMLAT_ADAPTIVE_LOW_FREQ,
>> +       MEMLAT_ADAPTIVE_HIGH_FREQ,
>> +       MEMLAT_GET_ADAPTIVE_CUR_FREQ,
>> +       MEMLAT_IPM_CEIL,
>> +       MEMLAT_FE_STALL_FLOOR,
>> +       MEMLAT_BE_STALL_FLOOR,
>> +       MEMLAT_WB_PCT,
>> +       MEMLAT_IPM_FILTER,
>> +       MEMLAT_FREQ_SCALE_PCT,
>> +       MEMLAT_FREQ_SCALE_CEIL_MHZ,
>> +       MEMLAT_FREQ_SCALE_FLOOR_MHZ,
>> +       MEMLAT_SAMPLE_MS,
>> +       MEMLAT_MON_FREQ_MAP,
>> +       MEMLAT_SET_MIN_FREQ,
>> +       MEMLAT_SET_MAX_FREQ,
>> +       MEMLAT_GET_CUR_FREQ,
>> +       MEMLAT_START_TIMER,
>> +       MEMLAT_STOP_TIMER,
>> +       MEMLAT_GET_TIMESTAMP,
>> +       MEMLAT_MAX_MSG
>> +};
>> +
>> +struct map_table {
>> +       u16 v1;
>> +       u16 v2;
>> +};
>> +
> 
> Any documentation for these structures? It won't bite you, but it will
> help reviewers and other developers.

ack

> 
>> +struct map_param_msg {
>> +       u32 hw_type;
>> +       u32 mon_idx;
>> +       u32 nr_rows;
>> +       struct map_table tbl[MAX_MAP_ENTRIES];
>> +} __packed;
>> +
>> +struct node_msg {
>> +       u32 cpumask;
>> +       u32 hw_type;
>> +       u32 mon_type;
>> +       u32 mon_idx;
>> +       char mon_name[MAX_NAME_LEN];
>> +};
>> +
>> +struct scalar_param_msg {
>> +       u32 hw_type;
>> +       u32 mon_idx;
>> +       u32 val;
>> +};
>> +
>> +enum common_ev_idx {
>> +       INST_IDX,
>> +       CYC_IDX,
>> +       FE_STALL_IDX,
>> +       BE_STALL_IDX,
>> +       NUM_COMMON_EVS
>> +};
>> +
>> +enum grp_ev_idx {
>> +       MISS_IDX,
>> +       WB_IDX,
>> +       ACC_IDX,
>> +       NUM_GRP_EVS
>> +};
>> +
>> +#define EV_CPU_CYCLES          0
>> +#define EV_INST_RETIRED                2
>> +#define EV_L2_D_RFILL          5
>> +
>> +struct ev_map_msg {
>> +       u32 num_evs;
>> +       u32 hw_type;
>> +       u32 cid[NUM_COMMON_EVS];
>> +};
>> +
>> +struct cpufreq_memfreq_map {
>> +       unsigned int                    cpufreq_mhz;
>> +       unsigned int                    memfreq_khz;
>> +};
>> +
>> +struct scmi_monitor_info {
>> +       struct cpufreq_memfreq_map *freq_map;
>> +       char mon_name[MAX_NAME_LEN];
>> +       u32 mon_idx;
>> +       u32 mon_type;
>> +       u32 ipm_ceil;
>> +       u32 mask;
>> +       u32 freq_map_len;
>> +};
>> +
>> +struct scmi_memory_info {
>> +       struct scmi_monitor_info *monitor[MAX_MONITOR_CNT];
>> +       u32 hw_type;
>> +       int monitor_cnt;
>> +       u32 min_freq;
>> +       u32 max_freq;
>> +};
>> +
>> +struct scmi_memlat_info {
>> +       struct scmi_protocol_handle *ph;
>> +       const struct qcom_scmi_vendor_ops *ops;
>> +       struct scmi_memory_info *memory[MAX_MEMORY_TYPES];
>> +       int memory_cnt;
>> +};
>> +
>> +static int get_mask(struct device_node *np, u32 *mask)
>> +{
>> +       struct device_node *dev_phandle;
>> +       struct device *cpu_dev;
>> +       int cpu, i = 0;
>> +       int ret = -ENODEV;
>> +
>> +       dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
>> +       while (dev_phandle) {
>> +               for_each_possible_cpu(cpu) {
>> +                       cpu_dev = get_cpu_device(cpu);
>> +                       if (cpu_dev && cpu_dev->of_node == dev_phandle) {
>> +                               *mask |= BIT(cpu);
>> +                               ret = 0;
>> +                               break;
>> +                       }
>> +               }
> 
> There is of_cpu_node_to_id(). No need to reinvent it.

ack

> 
>> +               dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static struct cpufreq_memfreq_map *init_cpufreq_memfreq_map(struct device *dev,
>> +                                                           struct device_node *of_node,
>> +                                                           u32 *cnt)
>> +{
>> +       int len, nf, i, j;
>> +       u32 data;
>> +       struct cpufreq_memfreq_map *tbl;
>> +       int ret;
>> +
>> +       if (!of_find_property(of_node, "qcom,cpufreq-memfreq-tbl", &len))
>> +               return NULL;
>> +       len /= sizeof(data);
>> +
>> +       if (len % 2 || len == 0)
>> +               return NULL;
>> +       nf = len / 2;
>> +
>> +       tbl = devm_kzalloc(dev, (nf + 1) * sizeof(struct cpufreq_memfreq_map),
>> +                          GFP_KERNEL);
>> +       if (!tbl)
>> +               return NULL;
>> +
>> +       for (i = 0, j = 0; i < nf; i++, j += 2) {
>> +               ret = of_property_read_u32_index(of_node, "qcom,cpufreq-memfreq-tbl",
>> +                                                j, &data);
>> +               if (ret < 0)
>> +                       return NULL;
>> +               tbl[i].cpufreq_mhz = data / 1000;
>> +
>> +               ret = of_property_read_u32_index(of_node, "qcom,cpufreq-memfreq-tbl",
>> +                                                j + 1, &data);
>> +               if (ret < 0)
>> +                       return NULL;
>> +
>> +               tbl[i].memfreq_khz = data;
>> +               pr_debug("Entry%d CPU:%u, Mem:%u\n", i, tbl[i].cpufreq_mhz,
>> +                        tbl[i].memfreq_khz);
>> +       }
>> +       *cnt = nf;
>> +       tbl[i].cpufreq_mhz = 0;
> 
> This looks like a lame version of the OPP table.

I didn't know listing multiple frequencies in a opp was allowed. We can
probably get away with it here since we just parse the data here and not
populate data in the opp core.

> 
>> +
>> +       return tbl;
>> +}
>> +
>> +static int process_scmi_memlat_of_node(struct scmi_device *sdev, struct scmi_memlat_info *info)
>> +{
>> +       struct device_node *memlat_np, *memory_np, *monitor_np;
>> +       struct scmi_memory_info *memory;
>> +       struct scmi_monitor_info *monitor;
>> +       int ret = 0, i = 0, j;
>> +       u32 memfreq[2];
>> +
>> +       of_node_get(sdev->handle->dev->of_node);
>> +       memlat_np = of_find_node_by_name(sdev->handle->dev->of_node, "memlat");
>> +
>> +       info->memory_cnt = of_get_child_count(memlat_np);
>> +       if (info->memory_cnt <= 0)
>> +               pr_err("No memory nodes present\n");
>> +
>> +       for_each_child_of_node(memlat_np, memory_np) {
>> +               memory = devm_kzalloc(&sdev->dev, sizeof(*memory), GFP_KERNEL);
>> +               if (!memory) {
>> +                       ret = -ENOMEM;
>> +                       goto err;
>> +               }
>> +
>> +               ret = of_property_read_u32(memory_np, "reg", &memory->hw_type);
>> +               if (ret) {
>> +                       pr_err("Failed to read memory type\n");
>> +                       goto err;
>> +               }
>> +
>> +               memory->monitor_cnt = of_get_child_count(memory_np);
>> +               if (memory->monitor_cnt <= 0) {
>> +                       pr_err("No monitor nodes present\n");
>> +                       ret = -EINVAL;
>> +                       goto err;
>> +               }
>> +
>> +               ret = of_property_read_u32_array(memory_np, "freq-table-khz", memfreq, 2);
>> +               if (ret && (ret != -EINVAL)) {
>> +                       pr_err("Failed to read min/max freq %d\n", ret);
>> +                       goto err;
>> +               }
> 
> foo-min-frequency and foo-max-frequency please.

ack

> 
>> +
>> +               memory->min_freq = memfreq[0];
>> +               memory->max_freq = memfreq[1];
>> +               info->memory[i] = memory;
>> +               j = 0;
>> +               i++;
>> +
>> +               for_each_child_of_node(memory_np, monitor_np) {
>> +                       monitor = devm_kzalloc(&sdev->dev, sizeof(*monitor), GFP_KERNEL);
>> +                       if (!monitor) {
>> +                               ret = -ENOMEM;
>> +                               goto err;
>> +                       }
>> +
>> +                       monitor->mon_type = (of_property_read_bool(monitor_np, "qcom,compute-mon")) ? 1 : 0;
>> +                       monitor->ipm_ceil = (of_property_read_bool(monitor_np, "qcom,compute-mon")) ? 0 : 20000000;
> 
> Huh?

lol, will add more comments.

> 
>> +
>> +                       if (get_mask(monitor_np, &monitor->mask)) {
>> +                               pr_err("Failed to populate cpu mask %d\n", ret);
>> +                               goto err;
>> +                       }
>> +
>> +                       monitor->freq_map = init_cpufreq_memfreq_map(&sdev->dev, monitor_np,
>> +                                                                    &monitor->freq_map_len);
>> +                       snprintf(monitor->mon_name, MAX_NAME_LEN, "monitor-%d", j);
>> +                       monitor->mon_idx = j;
>> +
>> +                       memory->monitor[j] = monitor;
>> +                       j++;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +err:
>> +       of_node_put(memlat_np);
>> +
>> +       return ret;
>> +}
>> +
>> +static int configure_cpucp_common_events(struct scmi_memlat_info *info)
>> +{
>> +       const struct qcom_scmi_vendor_ops *ops = info->ops;
>> +       u8 ev_map[NUM_COMMON_EVS];
>> +       struct ev_map_msg msg;
>> +       int ret;
>> +
>> +       memset(ev_map, 0xFF, NUM_COMMON_EVS);
>> +
>> +       msg.num_evs = NUM_COMMON_EVS;
>> +       msg.hw_type = INVALID_IDX;
>> +       msg.cid[INST_IDX] = EV_INST_RETIRED;
>> +       msg.cid[CYC_IDX] = EV_CPU_CYCLES;
>> +       msg.cid[FE_STALL_IDX] = INVALID_IDX;
>> +       msg.cid[BE_STALL_IDX] = INVALID_IDX;
>> +
>> +       ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_COMMON_EV_MAP,
>> +                            sizeof(msg));
>> +       return ret;
>> +}
>> +
>> +static int configure_cpucp_grp(struct scmi_memlat_info *info, int memory_index)
>> +{
>> +       const struct qcom_scmi_vendor_ops *ops = info->ops;
>> +       struct scmi_memory_info *memory = info->memory[memory_index];
>> +       struct ev_map_msg ev_msg;
>> +       u8 ev_map[NUM_GRP_EVS];
>> +       struct node_msg msg;
>> +       int ret;
>> +
>> +       msg.cpumask = 0;
>> +       msg.hw_type = memory->hw_type;
>> +       msg.mon_type = 0;
>> +       msg.mon_idx = 0;
>> +       ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_MEM_GROUP, sizeof(msg));
>> +       if (ret < 0) {
>> +               pr_err("Failed to configure mem type %d\n", memory->hw_type);
>> +               return ret;
>> +       }
>> +
>> +       memset(ev_map, 0xFF, NUM_GRP_EVS);
>> +       ev_msg.num_evs = NUM_GRP_EVS;
>> +       ev_msg.hw_type = memory->hw_type;
>> +       ev_msg.cid[MISS_IDX] = EV_L2_D_RFILL;
>> +       ev_msg.cid[WB_IDX] = INVALID_IDX;
>> +       ev_msg.cid[ACC_IDX] = INVALID_IDX;
>> +       ret = ops->set_param(info->ph, &ev_msg, MEMLAT_ALGO_STR, MEMLAT_SET_GRP_EV_MAP,
>> +                            sizeof(ev_msg));
>> +       if (ret < 0) {
>> +               pr_err("Failed to configure event map for mem type %d\n", memory->hw_type);
>> +               return ret;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int configure_cpucp_mon(struct scmi_memlat_info *info, int memory_index, int monitor_index)
>> +{
>> +       const struct qcom_scmi_vendor_ops *ops = info->ops;
>> +       struct scmi_memory_info *memory = info->memory[memory_index];
>> +       struct scmi_monitor_info *monitor = memory->monitor[monitor_index];
>> +       struct scalar_param_msg scalar_msg;
>> +       struct map_param_msg map_msg;
>> +       struct node_msg msg;
>> +       int ret;
>> +       int i;
>> +
>> +       msg.cpumask = monitor->mask;
>> +       msg.hw_type = memory->hw_type;
>> +       msg.mon_type = monitor->mon_type;
>> +       msg.mon_idx = monitor->mon_idx;
>> +       strscpy(msg.mon_name, monitor->mon_name, sizeof(msg.mon_name));
>> +       ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_MONITOR, sizeof(msg));
>> +       if (ret < 0) {
>> +               pr_err("Failed to configure monitor %s\n", monitor->mon_name);
>> +               return ret;
>> +       }
>> +
>> +       scalar_msg.hw_type = memory->hw_type;
>> +       scalar_msg.mon_idx = monitor->mon_idx;
>> +       scalar_msg.val = monitor->ipm_ceil;
>> +       ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_IPM_CEIL,
>> +                            sizeof(scalar_msg));
>> +       if (ret < 0) {
>> +               pr_err("Failed to set ipm ceil for %s\n", monitor->mon_name);
>> +               return ret;
>> +       }
>> +
>> +       map_msg.hw_type = memory->hw_type;
>> +       map_msg.mon_idx = monitor->mon_idx;
>> +       map_msg.nr_rows = monitor->freq_map_len;
>> +       for (i = 0; i < monitor->freq_map_len; i++) {
>> +               map_msg.tbl[i].v1 = monitor->freq_map[i].cpufreq_mhz;
>> +               map_msg.tbl[i].v2 = monitor->freq_map[i].memfreq_khz / 1000;
>> +       }
> 
> So this table goes 1:1 to the firmware? Is it going to be the same for
> all versions of the SoC? If so, it might be better to turn it into the
> static data inside the driver. If it doesn't change, there is no need
> to put it to DT.

The table does go directly to the firmware but obviously varies across
SoCs. Also since it's a SCMI client driver we don't have a way to
distinguish between SoCs based on compatibles. So it made more sense to
move it to the device tree instead.

-Sibi

> 
>> +       ret = ops->set_param(info->ph, &map_msg, MEMLAT_ALGO_STR, MEMLAT_MON_FREQ_MAP,
>> +                            sizeof(map_msg));
>> +       if (ret < 0) {
>> +               pr_err("Failed to configure freq_map for %s\n", monitor->mon_name);
>> +               return ret;
>> +       }
>> +
>> +       scalar_msg.hw_type = memory->hw_type;
>> +       scalar_msg.mon_idx = monitor->mon_idx;
>> +       scalar_msg.val = memory->min_freq;
>> +       ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_SET_MIN_FREQ,
>> +                            sizeof(scalar_msg));
>> +       if (ret < 0) {
>> +               pr_err("Failed to set min_freq for %s\n", monitor->mon_name);
>> +               return ret;
>> +       }
>> +
>> +       scalar_msg.hw_type = memory->hw_type;
>> +       scalar_msg.mon_idx = monitor->mon_idx;
>> +       scalar_msg.val = memory->max_freq;
>> +       ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_SET_MAX_FREQ,
>> +                            sizeof(scalar_msg));
>> +       if (ret < 0)
>> +               pr_err("Failed to set max_freq for %s\n", monitor->mon_name);
>> +
>> +       return ret;
>> +}
>> +
>> +static int cpucp_memlat_init(struct scmi_device *sdev)
>> +{
>> +       const struct scmi_handle *handle = sdev->handle;
>> +       const struct qcom_scmi_vendor_ops *ops;
>> +       struct scmi_protocol_handle *ph;
>> +       struct scmi_memlat_info *info;
>> +       u32 cpucp_sample_ms = 8;
>> +       int ret, i, j;
>> +
>> +       if (!handle)
>> +               return -ENODEV;
>> +
>> +       ops = handle->devm_protocol_get(sdev, QCOM_SCMI_VENDOR_PROTOCOL, &ph);
>> +       if (IS_ERR(ops))
>> +               return PTR_ERR(ops);
>> +
>> +       info = devm_kzalloc(&sdev->dev, sizeof(*info), GFP_KERNEL);
>> +       if (!info)
>> +               return -ENOMEM;
>> +
>> +       ret = process_scmi_memlat_of_node(sdev, info);
>> +       if (ret)
>> +               pr_err("Failed to configure common events: %d\n", ret);
>> +
>> +       info->ph = ph;
>> +       info->ops = ops;
>> +
>> +       ret = configure_cpucp_common_events(info);
>> +       if (ret < 0)
>> +               pr_err("Failed to configure common events: %d\n", ret);
>> +
>> +       for (i = 0; i < info->memory_cnt; i++) {
>> +               ret = configure_cpucp_grp(info, i);
>> +               if (ret < 0)
>> +                       pr_err("Failed to configure mem group: %d\n", ret);
>> +
>> +               for (j = 0; j < info->memory[i]->monitor_cnt; j++) {
>> +                       /* Configure per monitor parameters */
>> +                       ret = configure_cpucp_mon(info, i, j);
>> +                       if (ret < 0)
>> +                               pr_err("Failed to configure monitor: %d\n", ret);
>> +               }
>> +       }
>> +
>> +       ret = ops->set_param(ph, &cpucp_sample_ms, MEMLAT_ALGO_STR, MEMLAT_SAMPLE_MS,
>> +                            sizeof(cpucp_sample_ms));
>> +       if (ret < 0)
>> +               pr_err("Failed to set cpucp sample_ms ret = %d\n", ret);
>> +
>> +       /* Start sampling and voting timer */
>> +       ret = ops->start_activity(ph, NULL, MEMLAT_ALGO_STR, MEMLAT_START_TIMER, 0);
>> +       if (ret < 0)
>> +               pr_err("Error in starting the mem group timer %d\n", ret);
>> +
>> +       dev_set_drvdata(&sdev->dev, info);
>> +
>> +       return ret;
>> +}
>> +
>> +static int scmi_client_probe(struct scmi_device *sdev)
>> +{
>> +       cpucp_memlat_init(sdev);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct scmi_device_id scmi_id_table[] = {
>> +       { .protocol_id = QCOM_SCMI_VENDOR_PROTOCOL, .name = "qcom_scmi_vendor_protocol" },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
>> +
>> +static struct scmi_driver qcom_scmi_client_drv = {
>> +       .name           = "qcom-scmi-driver",
>> +       .probe          = scmi_client_probe,
>> +       .id_table       = scmi_id_table,
>> +};
>> +module_scmi_driver(qcom_scmi_client_drv);
>> +
>> +MODULE_DESCRIPTION("QTI SCMI client driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.34.1
>>
>>
> 
> 

