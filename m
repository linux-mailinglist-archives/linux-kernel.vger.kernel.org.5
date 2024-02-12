Return-Path: <linux-kernel+bounces-61678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5801F851545
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB07A285199
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06D3F9C4;
	Mon, 12 Feb 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQ7nBvEO"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C683F9C6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744183; cv=none; b=orI4JlxDj8Z4GKJbtG8Jb37dWE6rcGHP2CIi/T1XbTbORV8d7FhjN4He0RT61g5dBisfwxW7/8T1ntbwqiw9ycogmztT5FUZPLYlwzkyeHyQ3Duw4spsDFgXBMzqB3T0TZyDqdqrHMU/fWNMB05Is7l5PgNpiS5cCICeNRYgICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744183; c=relaxed/simple;
	bh=hgZBYdK3u7WdsN9oj+8KcDSkVgg4v9o6LesLZ5f1+0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohpYdPEb/BAv2nb1xpPaSXj+lVW/LJGIipeoAuqAPSwh5w0HMSybCmNVNlJ9LNPqKezeBvo5Ikml3EWzl2Gb35+OPyg7k7a+7FcNEzX9e77JY757tII/4Txt19+q4IQEBDVzIArVZqjMGtEaocCEYrYH2m0UkbC7B3bx/fc24eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQ7nBvEO; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc236729a2bso2954979276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744180; x=1708348980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ohK73ZlViFpR7kUkijJnUO0JZVw/Yr0/hymWJUVBw3U=;
        b=CQ7nBvEORdnxW1zBAExmdqYucNfGXBQjhliVNcsgPV+k3GNYTDpoC55vU4NRVHm8oU
         d0ZMsU39Y0cghUifsc3OAGOn2WVbXf8qnT/S2qXE7t0enRJGUtV1cIrNMb+Q7mKKbEV3
         GP+BrUcDmPMRvAqcgIfN/S4LVEgXlnzvMT1XLuwHM4M8X2T22eX9wnG5cGAZI6AK07pG
         0ZlGjPuULJbu8wqwjvXY9Q+pWHiKMHE5qTs5W4iFXRk0fClZahDmdrYSHMbC+7mYV0El
         UI05dgZJCLlPvCCWydof2W3cokOGbZCSfskZZftAbpNjLicq5F2SSYi7z6tHQYD9Kdos
         3UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744180; x=1708348980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohK73ZlViFpR7kUkijJnUO0JZVw/Yr0/hymWJUVBw3U=;
        b=S1zTeYPPua3OIhj0nPuV5db9W/o/6RwFWRa7zIubgYUpPBvuwVorxXv4+iWlgwsrqx
         6W0DbKhZKrb8aZ9ATViD6DhGT26p+qv/orqRLzVoDMfdeZg0e5cvmaGVKCWF73EXV+lJ
         cnphuwlvudJeVBz7nL+5dfhW9MUomtlIWV1OYGVMaK4GiRw49ZfjhOK7oY3L/Qj38sle
         m+t5XF8GvsgKreQRMvZTIaXdZUza1ZKIn5njJPgpv4tYrGORPAUrPKoNH6UF4y5z1dST
         AE0MtxBpaJVueTIl8634+C8MePqHGNN0fo18cTKFRfbfHYhGhPx3VCjoI8Cn+T6f3SFm
         Iw1g==
X-Forwarded-Encrypted: i=1; AJvYcCWKbScRT7aHOdSc3l8nqP53jGsi4P76MDZRTfIAtB0ymkC4CssFFF7cLlqSmhX6d8SWgAIUKCBf/aIsjRVhSWVwqJhEx2SnCqyeX3wA
X-Gm-Message-State: AOJu0Yz795EqpfliAGpy61zxYrdVc+dSgX89JadfmVWVKm0O0ob8hAls
	4fT3pE0NOlX5NoNcoALkQk/NCvb75FIST/4eYOxfeU9js48V1SU58EBEkGbbD2DLYatOwMJ3Ohu
	1kn8tromaaVvU1mobbVBYOTLOyOXRxtDY9mUtOQ==
X-Google-Smtp-Source: AGHT+IGXA61bIdJsTnlkmCl+pkCsbebIrN7AhidOcuaepMDxCCAHREyt3NmcZ4dG+zMXnz/g7yaQ26Z0banvcKYyMt0=
X-Received: by 2002:a25:a28d:0:b0:dc6:db0c:4ff0 with SMTP id
 c13-20020a25a28d000000b00dc6db0c4ff0mr5356971ybi.32.1707744180516; Mon, 12
 Feb 2024 05:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-5-quic_sibis@quicinc.com> <CAA8EJpr8qLZ8Y7PjU05ZoxSHWOf=q-KtM+s-tnR5X2t96rFWhw@mail.gmail.com>
 <0adaa065-3883-ebfe-8259-05ebdbd821eb@quicinc.com>
In-Reply-To: <0adaa065-3883-ebfe-8259-05ebdbd821eb@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 12 Feb 2024 15:22:49 +0200
Message-ID: <CAA8EJpqjqCVs6DEaUQowk2d3yS66cSC8vnVQzv+MxhvobeNvEg@mail.gmail.com>
Subject: Re: [RFC 4/7] soc: qcom: Utilize qcom scmi vendor protocol for bus dvfs
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, jassisinghbrar@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org, 
	Amir Vajid <avajid@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 12:24, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
>
>
> On 1/18/24 02:11, Dmitry Baryshkov wrote:
> > On Wed, 17 Jan 2024 at 19:36, Sibi Sankar <quic_sibis@quicinc.com> wrote:
> >>
> >> From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> >>
> >> This patch introduces a client driver that interacts with the SCMI QCOM
> >
> > git grep This.patch Documentation/process/
> >
> >> vendor protocol and passes on the required tuneables to start various
> >> features running on the SCMI controller.
> >
> > Is there any word about the 'memlat'? No. Unless one  reads into the
> > patch, one can not come up with the idea of what is being introduced.
>
> ack, will fix it in the re-spin.
>
> >
> >>
> >> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> >> Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> >> Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> >> Co-developed-by: Amir Vajid <avajid@quicinc.com>
> >> Signed-off-by: Amir Vajid <avajid@quicinc.com>
> >> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> >> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> >> ---
> >>   drivers/soc/qcom/Kconfig            |  10 +
> >>   drivers/soc/qcom/Makefile           |   1 +
> >>   drivers/soc/qcom/qcom_scmi_client.c | 486 ++++++++++++++++++++++++++++
> >
> > Should it go to drivers/firmware/arm_scmi instead? Or maybe to drivers/devfreq?
>
> I don't think it should go into arm_scmi unless Sudeep wants it there.
> As for drivers/devfreq, I would have moved it there if this driver
> benfitted being classified as a devfreq device. We can't use any of
> the available governors on it and the tuneables appear way too custom.
> These are the reasons why I placed it in drivers/soc/qcom instead.
>
> >
> >>   3 files changed, 497 insertions(+)
> >>   create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
> >>
> >> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> >> index c6ca4de42586..1530558aebfb 100644
> >> --- a/drivers/soc/qcom/Kconfig
> >> +++ b/drivers/soc/qcom/Kconfig
> >> @@ -264,6 +264,16 @@ config QCOM_ICC_BWMON
> >>            the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
> >>            memory throughput even with lower CPU frequencies.
> >>
> >> +config QCOM_SCMI_CLIENT
> >> +       tristate "Qualcomm Technologies Inc. SCMI client driver"
> >> +       depends on QCOM_SCMI_VENDOR_PROTOCOL || COMPILE_TEST
> >> +       default n
> >> +       help
> >> +         SCMI client driver registers for SCMI QCOM vendor protocol.
> >> +
> >> +         This driver interacts with the vendor protocol and passes on the required
> >> +         tuneables to start various features running on the SCMI controller.
> >> +
> >>   config QCOM_INLINE_CRYPTO_ENGINE
> >>          tristate
> >>          select QCOM_SCM
> >> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> >> index 05b3d54e8dc9..c2a51293c886 100644
> >> --- a/drivers/soc/qcom/Makefile
> >> +++ b/drivers/soc/qcom/Makefile
> >> @@ -32,5 +32,6 @@ obj-$(CONFIG_QCOM_APR) += apr.o
> >>   obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
> >>   obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=        kryo-l2-accessors.o
> >>   obj-$(CONFIG_QCOM_ICC_BWMON)   += icc-bwmon.o
> >> +obj-$(CONFIG_QCOM_SCMI_CLIENT) += qcom_scmi_client.o
> >>   qcom_ice-objs                  += ice.o
> >>   obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)        += qcom_ice.o
> >> diff --git a/drivers/soc/qcom/qcom_scmi_client.c b/drivers/soc/qcom/qcom_scmi_client.c
> >> new file mode 100644
> >> index 000000000000..418aa7900496
> >> --- /dev/null
> >> +++ b/drivers/soc/qcom/qcom_scmi_client.c
> >> @@ -0,0 +1,486 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +#include <linux/cpu.h>
> >> +#include <linux/err.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/init.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/qcom_scmi_vendor.h>
> >> +#include <linux/scmi_protocol.h>
> >> +
> >> +#define MAX_MEMORY_TYPES       3
> >> +#define MEMLAT_ALGO_STR                0x74616C6D656D /* "memlat" */
> >> +#define INVALID_IDX            0xFF
> >> +#define MAX_NAME_LEN           20
> >> +#define MAX_MAP_ENTRIES                6
> >> +#define MAX_MONITOR_CNT                4
> >> +#define SCMI_VENDOR_MSG_START  3
> >> +#define SCMI_VENDOR_MSG_MODULE_START   16
> >> +
> >> +enum scmi_memlat_protocol_cmd {
> >> +       MEMLAT_SET_LOG_LEVEL = SCMI_VENDOR_MSG_START,
> >> +       MEMLAT_FLUSH_LOGBUF,
> >> +       MEMLAT_SET_MEM_GROUP = SCMI_VENDOR_MSG_MODULE_START,
> >> +       MEMLAT_SET_MONITOR,
> >> +       MEMLAT_SET_COMMON_EV_MAP,
> >> +       MEMLAT_SET_GRP_EV_MAP,
> >> +       MEMLAT_ADAPTIVE_LOW_FREQ,
> >> +       MEMLAT_ADAPTIVE_HIGH_FREQ,
> >> +       MEMLAT_GET_ADAPTIVE_CUR_FREQ,
> >> +       MEMLAT_IPM_CEIL,
> >> +       MEMLAT_FE_STALL_FLOOR,
> >> +       MEMLAT_BE_STALL_FLOOR,
> >> +       MEMLAT_WB_PCT,
> >> +       MEMLAT_IPM_FILTER,
> >> +       MEMLAT_FREQ_SCALE_PCT,
> >> +       MEMLAT_FREQ_SCALE_CEIL_MHZ,
> >> +       MEMLAT_FREQ_SCALE_FLOOR_MHZ,
> >> +       MEMLAT_SAMPLE_MS,
> >> +       MEMLAT_MON_FREQ_MAP,
> >> +       MEMLAT_SET_MIN_FREQ,
> >> +       MEMLAT_SET_MAX_FREQ,
> >> +       MEMLAT_GET_CUR_FREQ,
> >> +       MEMLAT_START_TIMER,
> >> +       MEMLAT_STOP_TIMER,
> >> +       MEMLAT_GET_TIMESTAMP,
> >> +       MEMLAT_MAX_MSG
> >> +};
> >> +
> >> +struct map_table {
> >> +       u16 v1;
> >> +       u16 v2;
> >> +};
> >> +
> >
> > Any documentation for these structures? It won't bite you, but it will
> > help reviewers and other developers.
>
> ack
>
> >
> >> +struct map_param_msg {
> >> +       u32 hw_type;
> >> +       u32 mon_idx;
> >> +       u32 nr_rows;
> >> +       struct map_table tbl[MAX_MAP_ENTRIES];
> >> +} __packed;
> >> +
> >> +struct node_msg {
> >> +       u32 cpumask;
> >> +       u32 hw_type;
> >> +       u32 mon_type;
> >> +       u32 mon_idx;
> >> +       char mon_name[MAX_NAME_LEN];
> >> +};
> >> +
> >> +struct scalar_param_msg {
> >> +       u32 hw_type;
> >> +       u32 mon_idx;
> >> +       u32 val;
> >> +};
> >> +
> >> +enum common_ev_idx {
> >> +       INST_IDX,
> >> +       CYC_IDX,
> >> +       FE_STALL_IDX,
> >> +       BE_STALL_IDX,
> >> +       NUM_COMMON_EVS
> >> +};
> >> +
> >> +enum grp_ev_idx {
> >> +       MISS_IDX,
> >> +       WB_IDX,
> >> +       ACC_IDX,
> >> +       NUM_GRP_EVS
> >> +};
> >> +
> >> +#define EV_CPU_CYCLES          0
> >> +#define EV_INST_RETIRED                2
> >> +#define EV_L2_D_RFILL          5
> >> +
> >> +struct ev_map_msg {
> >> +       u32 num_evs;
> >> +       u32 hw_type;
> >> +       u32 cid[NUM_COMMON_EVS];
> >> +};
> >> +
> >> +struct cpufreq_memfreq_map {
> >> +       unsigned int                    cpufreq_mhz;
> >> +       unsigned int                    memfreq_khz;
> >> +};
> >> +
> >> +struct scmi_monitor_info {
> >> +       struct cpufreq_memfreq_map *freq_map;
> >> +       char mon_name[MAX_NAME_LEN];
> >> +       u32 mon_idx;
> >> +       u32 mon_type;
> >> +       u32 ipm_ceil;
> >> +       u32 mask;
> >> +       u32 freq_map_len;
> >> +};
> >> +
> >> +struct scmi_memory_info {
> >> +       struct scmi_monitor_info *monitor[MAX_MONITOR_CNT];
> >> +       u32 hw_type;
> >> +       int monitor_cnt;
> >> +       u32 min_freq;
> >> +       u32 max_freq;
> >> +};
> >> +
> >> +struct scmi_memlat_info {
> >> +       struct scmi_protocol_handle *ph;
> >> +       const struct qcom_scmi_vendor_ops *ops;
> >> +       struct scmi_memory_info *memory[MAX_MEMORY_TYPES];
> >> +       int memory_cnt;
> >> +};
> >> +
> >> +static int get_mask(struct device_node *np, u32 *mask)
> >> +{
> >> +       struct device_node *dev_phandle;
> >> +       struct device *cpu_dev;
> >> +       int cpu, i = 0;
> >> +       int ret = -ENODEV;
> >> +
> >> +       dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
> >> +       while (dev_phandle) {
> >> +               for_each_possible_cpu(cpu) {
> >> +                       cpu_dev = get_cpu_device(cpu);
> >> +                       if (cpu_dev && cpu_dev->of_node == dev_phandle) {
> >> +                               *mask |= BIT(cpu);
> >> +                               ret = 0;
> >> +                               break;
> >> +                       }
> >> +               }
> >
> > There is of_cpu_node_to_id(). No need to reinvent it.
>
> ack
>
> >
> >> +               dev_phandle = of_parse_phandle(np, "qcom,cpulist", i++);
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static struct cpufreq_memfreq_map *init_cpufreq_memfreq_map(struct device *dev,
> >> +                                                           struct device_node *of_node,
> >> +                                                           u32 *cnt)
> >> +{
> >> +       int len, nf, i, j;
> >> +       u32 data;
> >> +       struct cpufreq_memfreq_map *tbl;
> >> +       int ret;
> >> +
> >> +       if (!of_find_property(of_node, "qcom,cpufreq-memfreq-tbl", &len))
> >> +               return NULL;
> >> +       len /= sizeof(data);
> >> +
> >> +       if (len % 2 || len == 0)
> >> +               return NULL;
> >> +       nf = len / 2;
> >> +
> >> +       tbl = devm_kzalloc(dev, (nf + 1) * sizeof(struct cpufreq_memfreq_map),
> >> +                          GFP_KERNEL);
> >> +       if (!tbl)
> >> +               return NULL;
> >> +
> >> +       for (i = 0, j = 0; i < nf; i++, j += 2) {
> >> +               ret = of_property_read_u32_index(of_node, "qcom,cpufreq-memfreq-tbl",
> >> +                                                j, &data);
> >> +               if (ret < 0)
> >> +                       return NULL;
> >> +               tbl[i].cpufreq_mhz = data / 1000;
> >> +
> >> +               ret = of_property_read_u32_index(of_node, "qcom,cpufreq-memfreq-tbl",
> >> +                                                j + 1, &data);
> >> +               if (ret < 0)
> >> +                       return NULL;
> >> +
> >> +               tbl[i].memfreq_khz = data;
> >> +               pr_debug("Entry%d CPU:%u, Mem:%u\n", i, tbl[i].cpufreq_mhz,
> >> +                        tbl[i].memfreq_khz);
> >> +       }
> >> +       *cnt = nf;
> >> +       tbl[i].cpufreq_mhz = 0;
> >
> > This looks like a lame version of the OPP table.
>
> I didn't know listing multiple frequencies in a opp was allowed. We can
> probably get away with it here since we just parse the data here and not
> populate data in the opp core.

You are describing driver behaviour. DT describes hardware. So, the
proper way to describe this kind of data is the OPP table.




-- 
With best wishes
Dmitry

