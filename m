Return-Path: <linux-kernel+bounces-6546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB7819A31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68C7B2261C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B991A582;
	Wed, 20 Dec 2023 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5ILEGR6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF818E02
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e6c8b70766so26632687b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703059951; x=1703664751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PgKolIXuJTwKVfBoxNsrynSZdunVi3AR1eHlhs/pfFE=;
        b=a5ILEGR6tPLO6OEVRiiAB0KaWFvpU8h6clzpc1InVjngFhdA6LuE3Y5hNP1kHXZ9KB
         1z3hJGpG42oj80KRyEhK69wjjrWKx9FA47z/bml1q2kk3X2mhTQ/lgpk+mvBt0nWy+Nx
         DfPHyqTN7/upuqqi/z8cMdRmJL2/vDraLjsSd8htZuOGcrRrFWqT/K6O3tiJnQjyaIo0
         FMaouJ16QQAjD60/BHxjXCjjQyLYnciX5+0ku//A6ywUeYlhFUKbycKzFvN3UG9SOirG
         vIpX7U7/2GnV1UeyF5yWJmdfgAW2ijpajPMqMNEiMyaJIqgjhXIGJpUEOplPH6oMf/tY
         im0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703059951; x=1703664751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgKolIXuJTwKVfBoxNsrynSZdunVi3AR1eHlhs/pfFE=;
        b=S53ptN21tb4tiRUy29AOx9zJnOazfU5n7aUxFrn3TTeTAbeq1MPmJeDUkHJceIkrgm
         +Byyf0GasUmhrzXl7mQp9HYBF04wKigse/GJ0Sa7yImgXdApjon3DA/NvgNzkLMsHeCx
         9Pbg1ZQiVEUcBb9xsqSgIpkNYlRHAR7CFbPpJJE21vtyUuUizOAcs+hIjuodYHo5WGj4
         EJZYvZb6d+DGAbKnBx/ZVgL/twMmhKPlERliL8p1hElMYVVDTTvmEUZDfwxuBMXgtVIo
         pbFhWA3YtNPE6pRskZeMFN+yiAe2ama7U7rHUf2ltC+jOeD8p6PgCXp3Ascg190CvccH
         +BqQ==
X-Gm-Message-State: AOJu0YyybfpvcP/zN4TzO5KBMpEV41SCPyPVtbYkoGDtj62oRANNxNnL
	k6JfZVVXQ4Jow7BAqJj+WiyG9RN/uXti2MCkUFNflA==
X-Google-Smtp-Source: AGHT+IG6M94Fki//9AXoJvMebZbrc7lGqvWRopfshTINgXg16PxvimXtlWZJiaEThUIdQlTspz3U++1M/akRmFFqzrY=
X-Received: by 2002:a0d:dd4a:0:b0:5e7:7a39:6977 with SMTP id
 g71-20020a0ddd4a000000b005e77a396977mr2138159ywe.53.1703059951168; Wed, 20
 Dec 2023 00:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-2-git-send-email-quic_dikshita@quicinc.com>
 <f0682d53-a2f1-4b68-abe1-90a35c9a0641@linaro.org> <87fea0ec-b0c4-1c68-d5b0-86deac8a25d8@quicinc.com>
In-Reply-To: <87fea0ec-b0c4-1c68-d5b0-86deac8a25d8@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 10:12:19 +0200
Message-ID: <CAA8EJpqFAEHRa+=ohSC-ucgSkg5CRUpWgGzG4BLbRFnZvqgmtg@mail.gmail.com>
Subject: Re: [PATCH v2 01/34] media: introduce common helpers for video
 firmware handling
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org, 
	bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org, 
	quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 10:01, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
>
>
> On 12/18/2023 11:54 PM, Dmitry Baryshkov wrote:
> > On 18/12/2023 13:31, Dikshita Agarwal wrote:
> >> Re-organize the video driver code by introducing a new folder
> >> 'vcodec' and placing 'venus' driver code inside that.
> >>
> >> Introduce common helpers for trustzone based firmware
> >> load/unload etc. which are placed in common folder
> >> i.e. 'vcodec'.
> >> Use these helpers in 'venus' driver. These helpers will be
> >> used by 'iris' driver as well which is introduced later
> >> in this patch series.
> >
> > But why do you need to move the venus driver to subdir?
>
> Currently venus driver is present in drivers/media/platform/qcom folder
> which also has camss folder. We introduced vcodec to keep common code and
> moved venus inside that, to indicate that the common code is for vcodec
> drivers i.e venus and iris. Keeping this in qcom folder would mean, common
> code will be used for camss only which is not the case here.

you can have .../platform/qcom/camss, .../platform/qcom/vcodec-common,
.../platform/qcom/venus and .../platform/qcom/iris.

If you were to use build helpers in a proper kernel module, this would
be more obvious.

> >
> >>
> >> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> >> ---
> >>   drivers/media/platform/qcom/Kconfig                |   2 +-
> >>   drivers/media/platform/qcom/Makefile               |   2 +-
> >>   drivers/media/platform/qcom/vcodec/firmware.c      | 147 +++++++++
> >>   drivers/media/platform/qcom/vcodec/firmware.h      |  21 ++
> >>   .../media/platform/qcom/{ => vcodec}/venus/Kconfig |   0
> >>   .../platform/qcom/{ => vcodec}/venus/Makefile      |   4 +-
> >>   .../media/platform/qcom/{ => vcodec}/venus/core.c  | 102 +++++-
> >>   .../media/platform/qcom/{ => vcodec}/venus/core.h  |   0
> >>   .../media/platform/qcom/{ => vcodec}/venus/dbgfs.c |   0
> >>   .../media/platform/qcom/{ => vcodec}/venus/dbgfs.h |   0
> >>   .../platform/qcom/vcodec/venus/firmware_no_tz.c    | 194 +++++++++++
> >>   .../platform/qcom/vcodec/venus/firmware_no_tz.h    |  19 ++
> >>   .../platform/qcom/{ => vcodec}/venus/helpers.c     |   0
> >>   .../platform/qcom/{ => vcodec}/venus/helpers.h     |   0
> >>   .../media/platform/qcom/{ => vcodec}/venus/hfi.c   |   0
> >>   .../media/platform/qcom/{ => vcodec}/venus/hfi.h   |   0
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_cmds.c    |   0
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_cmds.h    |   0
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_helper.h  |   0
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_msgs.c    |   0
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_msgs.h    |   0
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_parser.c  |   0
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_parser.h  |   0
> >>   .../qcom/{ => vcodec}/venus/hfi_plat_bufs.h        |   0
> >>   .../qcom/{ => vcodec}/venus/hfi_plat_bufs_v6.c     |   0
> >>   .../qcom/{ => vcodec}/venus/hfi_platform.c         |   0
> >>   .../qcom/{ => vcodec}/venus/hfi_platform.h         |   0
> >>   .../qcom/{ => vcodec}/venus/hfi_platform_v4.c      |   0
> >>   .../qcom/{ => vcodec}/venus/hfi_platform_v6.c      |   0
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_venus.c   |  21 +-
> >>   .../platform/qcom/{ => vcodec}/venus/hfi_venus.h   |   0
> >>   .../qcom/{ => vcodec}/venus/hfi_venus_io.h         |   0
> >>   .../platform/qcom/{ => vcodec}/venus/pm_helpers.c  |   0
> >>   .../platform/qcom/{ => vcodec}/venus/pm_helpers.h  |   0
> >>   .../media/platform/qcom/{ => vcodec}/venus/vdec.c  |   0
> >>   .../media/platform/qcom/{ => vcodec}/venus/vdec.h  |   0
> >>   .../platform/qcom/{ => vcodec}/venus/vdec_ctrls.c  |   0
> >>   .../media/platform/qcom/{ => vcodec}/venus/venc.c  |   0
> >>   .../media/platform/qcom/{ => vcodec}/venus/venc.h  |   0
> >>   .../platform/qcom/{ => vcodec}/venus/venc_ctrls.c  |   0
> >>   drivers/media/platform/qcom/venus/firmware.c       | 363
> >> ---------------------
> >>   drivers/media/platform/qcom/venus/firmware.h       |  26 --
> >>   42 files changed, 492 insertions(+), 409 deletions(-)
> >>   create mode 100644 drivers/media/platform/qcom/vcodec/firmware.c
> >>   create mode 100644 drivers/media/platform/qcom/vcodec/firmware.h
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/Kconfig (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/Makefile (83%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/core.c (91%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/core.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/dbgfs.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/dbgfs.h (100%)
> >>   create mode 100644
> >> drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.c
> >>   create mode 100644
> >> drivers/media/platform/qcom/vcodec/venus/firmware_no_tz.h
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/helpers.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/helpers.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_cmds.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_cmds.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_helper.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_msgs.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_msgs.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_parser.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_parser.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_plat_bufs.h
> >> (100%)
> >>   rename drivers/media/platform/qcom/{ =>
> >> vcodec}/venus/hfi_plat_bufs_v6.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform.c
> >> (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform.h
> >> (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform_v4.c
> >> (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_platform_v6.c
> >> (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus.c (99%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/hfi_venus_io.h
> >> (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/pm_helpers.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/pm_helpers.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/vdec_ctrls.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc.c (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc.h (100%)
> >>   rename drivers/media/platform/qcom/{ => vcodec}/venus/venc_ctrls.c (100%)
> >>   delete mode 100644 drivers/media/platform/qcom/venus/firmware.c
> >>   delete mode 100644 drivers/media/platform/qcom/venus/firmware.h
> >>
> >> diff --git a/drivers/media/platform/qcom/Kconfig
> >> b/drivers/media/platform/qcom/Kconfig
> >> index cc5799b..e94142f 100644
> >> --- a/drivers/media/platform/qcom/Kconfig
> >> +++ b/drivers/media/platform/qcom/Kconfig
> >> @@ -3,4 +3,4 @@
> >>   comment "Qualcomm media platform drivers"
> >>     source "drivers/media/platform/qcom/camss/Kconfig"
> >> -source "drivers/media/platform/qcom/venus/Kconfig"
> >> +source "drivers/media/platform/qcom/vcodec/venus/Kconfig"
> >> diff --git a/drivers/media/platform/qcom/Makefile
> >> b/drivers/media/platform/qcom/Makefile
> >> index 4f055c3..3d2d82b 100644
> >> --- a/drivers/media/platform/qcom/Makefile
> >> +++ b/drivers/media/platform/qcom/Makefile
> >> @@ -1,3 +1,3 @@
> >>   # SPDX-License-Identifier: GPL-2.0-only
> >>   obj-y += camss/
> >> -obj-y += venus/
> >> +obj-y += vcodec/venus/
> >> diff --git a/drivers/media/platform/qcom/vcodec/firmware.c
> >> b/drivers/media/platform/qcom/vcodec/firmware.c
> >> new file mode 100644
> >> index 0000000..dbc220a
> >> --- /dev/null
> >> +++ b/drivers/media/platform/qcom/vcodec/firmware.c
> >> @@ -0,0 +1,147 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights
> >> reserved.
> >> + */
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/firmware.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/iommu.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/firmware/qcom/qcom_scm.h>
> >> +#include <linux/of_reserved_mem.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/soc/qcom/mdt_loader.h>
> >> +
> >> +#include "firmware.h"
> >> +
> >> +bool use_tz(struct device *core_dev)
> >
> > All these functions must get some sane prefix. Otherwise a generic 'use_tz'
> > function is too polluting for the global namespace.
> >
> I understand, will check and do the needful.
> >> +{
> >> +    struct device_node *np;
> >> +
> >> +    np = of_get_child_by_name(core_dev->of_node, "video-firmware");
> >> +    if (!np)
> >> +        return true;
> >> +
> >> +    return false;
> >> +}
> >> +
> >> +int protect_secure_region(u32 cp_start, u32 cp_size, u32 cp_nonpixel_start,
> >> +              u32 cp_nonpixel_size, u32 pas_id)
> >> +{
> >> +    int ret;
> >> +    /*
> >> +     * Clues for porting using downstream data:
> >> +     * cp_start = 0
> >> +     * cp_size = venus_ns/virtual-addr-pool[0] - yes, address and not size!
> >> +     *   This works, as the non-secure context bank is placed
> >> +     *   contiguously right after the Content Protection region.
> >> +     *
> >> +     * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
> >> +     * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
> >> +     */
> >> +    ret = qcom_scm_mem_protect_video_var(cp_start,
> >> +                         cp_size,
> >> +                         cp_nonpixel_start,
> >> +                         cp_nonpixel_size);
> >> +    if (ret)
> >> +        qcom_scm_pas_shutdown(pas_id);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +int load_fw(struct device *dev, const char *fw_name, phys_addr_t *mem_phys,
> >> +        size_t *mem_size, u32 pas_id, bool use_tz)
> >> +{
> >> +    const struct firmware *firmware = NULL;
> >> +    struct reserved_mem *rmem;
> >> +    struct device_node *node;
> >> +    void *mem_virt = NULL;
> >> +    ssize_t fw_size = 0;
> >> +    int ret;
> >> +
> >> +    if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> >
> > Why? Can you just depend on it?
> >
> Sure, Will check this and get back.
> >> +        (use_tz && !qcom_scm_is_available()))
> >> +        return -EPROBE_DEFER;
> >> +
> >> +    if (!fw_name || !(*fw_name))
> >> +        return -EINVAL;
> >> +
> >> +    *mem_phys = 0;
> >> +    *mem_size = 0;
> >> +
> >> +    node = of_parse_phandle(dev->of_node, "memory-region", 0);
> >> +    if (!node) {
> >> +        dev_err(dev, "no memory-region specified\n");
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    rmem = of_reserved_mem_lookup(node);
> >> +    of_node_put(node);
> >> +    if (!rmem) {
> >> +        dev_err(dev, "failed to lookup reserved memory-region\n");
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    ret = request_firmware(&firmware, fw_name, dev);
> >> +    if (ret) {
> >> +        dev_err(dev, "%s: failed to request fw \"%s\", error %d\n",
> >> +            __func__, fw_name, ret);
> >> +        return ret;
> >> +    }
> >> +
> >> +    fw_size = qcom_mdt_get_size(firmware);
> >> +    if (fw_size < 0) {
> >> +        ret = fw_size;
> >> +        dev_err(dev, "%s: out of bound fw image fw size: %ld\n",
> >> +            __func__, fw_size);
> >> +        goto err_release_fw;
> >> +    }
> >> +
> >> +    *mem_phys = rmem->base;
> >> +    *mem_size = rmem->size;
> >> +
> >> +    if (*mem_size < fw_size) {
> >> +        ret = -EINVAL;
> >> +        goto err_release_fw;
> >> +    }
> >> +
> >> +    mem_virt = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> >> +    if (!mem_virt) {
> >> +        dev_err(dev, "unable to remap fw memory region %pa size %#zx\n",
> >> +            mem_phys, *mem_size);
> >> +        goto err_release_fw;
> >> +    }
> >> +
> >> +    if (use_tz)
> >> +        ret = qcom_mdt_load(dev, firmware, fw_name, pas_id, mem_virt,
> >> +                    *mem_phys, *mem_size, NULL);
> >> +    else
> >> +        ret = qcom_mdt_load_no_init(dev, firmware, fw_name, pas_id,
> >> mem_virt,
> >> +                        *mem_phys, *mem_size, NULL);
> >> +    if (ret) {
> >> +        dev_err(dev, "%s: error %d loading fw \"%s\"\n",
> >> +            __func__, ret, fw_name);
> >> +    }
> >> +
> >> +    memunmap(mem_virt);
> >> +err_release_fw:
> >> +    release_firmware(firmware);
> >> +    return ret;
> >> +}
> >> +
> >> +int auth_reset_fw(u32 pas_id)
> >> +{
> >> +    return qcom_scm_pas_auth_and_reset(pas_id);
> >> +}
> >> +
> >> +void unload_fw(u32 pas_id)
> >> +{
> >> +    qcom_scm_pas_shutdown(pas_id);
> >> +}
> >> +
> >> +int set_hw_state(bool resume)
> >> +{
> >> +    return qcom_scm_set_remote_state(resume, 0);
> >> +}
> >> diff --git a/drivers/media/platform/qcom/vcodec/firmware.h
> >> b/drivers/media/platform/qcom/vcodec/firmware.h
> >> new file mode 100644
> >> index 0000000..7d410a8
> >> --- /dev/null
> >> +++ b/drivers/media/platform/qcom/vcodec/firmware.h
> >> @@ -0,0 +1,21 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights
> >> reserved.
> >> + */
> >> +
> >> +#ifndef _FIRMWARE_H_
> >> +#define _FIRMWARE_H_
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/types.h>
> >> +
> >> +bool use_tz(struct device *core_dev);
> >> +int load_fw(struct device *dev, const char *fw_name, phys_addr_t *mem_phys,
> >> +        size_t *mem_size, u32 pas_id, bool use_tz);
> >> +int auth_reset_fw(u32 pas_id);
> >> +int protect_secure_region(u32 cp_start, u32 cp_size, u32 cp_nonpixel_start,
> >> +              u32 cp_nonpixel_size, u32 pas_id);
> >> +void unload_fw(u32 pas_id);
> >> +int set_hw_state(bool resume);
> >> +
> >> +#endif
> >> diff --git a/drivers/media/platform/qcom/venus/Kconfig
> >> b/drivers/media/platform/qcom/vcodec/venus/Kconfig
> >> similarity index 100%
> >> rename from drivers/media/platform/qcom/venus/Kconfig
> >> rename to drivers/media/platform/qcom/vcodec/venus/Kconfig
> >> diff --git a/drivers/media/platform/qcom/venus/Makefile
> >> b/drivers/media/platform/qcom/vcodec/venus/Makefile
> >> similarity index 83%
> >> rename from drivers/media/platform/qcom/venus/Makefile
> >> rename to drivers/media/platform/qcom/vcodec/venus/Makefile
> >> index 91ee6be..f6f3a88 100644
> >> --- a/drivers/media/platform/qcom/venus/Makefile
> >> +++ b/drivers/media/platform/qcom/vcodec/venus/Makefile
> >> @@ -1,7 +1,9 @@
> >>   # SPDX-License-Identifier: GPL-2.0
> >>   # Makefile for Qualcomm Venus driver
> >>   -venus-core-objs += core.o helpers.o firmware.o \
> >> +venus-core-objs += ../firmware.o
> >> +
> >> +venus-core-objs += core.o helpers.o firmware_no_tz.o \
> >>              hfi_venus.o hfi_msgs.o hfi_cmds.o hfi.o \
> >>              hfi_parser.o pm_helpers.o dbgfs.o \
> >>              hfi_platform.o hfi_platform_v4.o \
> >> diff --git a/drivers/media/platform/qcom/venus/core.c
> >> b/drivers/media/platform/qcom/vcodec/venus/core.c
> >> similarity index 91%
> >> rename from drivers/media/platform/qcom/venus/core.c
> >> rename to drivers/media/platform/qcom/vcodec/venus/core.c
> >> index 9cffe97..56d9a53 100644
> >> --- a/drivers/media/platform/qcom/venus/core.c
> >> +++ b/drivers/media/platform/qcom/vcodec/venus/core.c
> >> @@ -22,7 +22,8 @@
> >>   #include <media/v4l2-ioctl.h>
> >>     #include "core.h"
> >> -#include "firmware.h"
> >> +#include "../firmware.h"
> >> +#include "firmware_no_tz.h"
> >>   #include "pm_helpers.h"
> >>   #include "hfi_venus_io.h"
> >>   @@ -86,6 +87,8 @@ static void venus_sys_error_handler(struct
> >> work_struct *work)
> >>       struct venus_core *core =
> >>               container_of(work, struct venus_core, work.work);
> >>       int ret, i, max_attempts = RPM_WAIT_FOR_IDLE_MAX_ATTEMPTS;
> >> +    const struct venus_resources *res = core->res;
> >> +    const char *fwpath = NULL;
> >>       const char *err_msg = "";
> >>       bool failed = false;
> >>   @@ -107,7 +110,10 @@ static void venus_sys_error_handler(struct
> >> work_struct *work)
> >>         mutex_lock(&core->lock);
> >>   -    venus_shutdown(core);
> >> +    if (core->use_tz)
> >> +        unload_fw(VENUS_PAS_ID);
> >> +    else
> >> +        unload_fw_no_tz(core);
> >
> > This is more than introducing helpers.
> >
> The new helpers are written to make the code generic for video drivers.
> which requires changes in the calling function also.
> >>         venus_coredump(core);
> >>   @@ -127,12 +133,39 @@ static void venus_sys_error_handler(struct
> >> work_struct *work)
> >>           failed = true;
> >>       }
> >>   -    ret = venus_boot(core);
> >> +    ret = of_property_read_string_index(core->dev->of_node,
> >> "firmware-name", 0,
> >> +                        &fwpath);
> >> +    if (ret)
> >> +        fwpath = core->res->fwname;
> >> +
> >> +    ret = load_fw(core->dev, fwpath, &core->fw.mem_phys,
> >> &core->fw.mem_size,
> >> +              VENUS_PAS_ID, core->use_tz);
> >
> > So, we had a nice local 'venus_boot'. Instead we now have a pile of code
> > with non-generic prefixes, etc. If you are introducing helpers, please
> > refrain from inlining of calling functions, etc. Just move the code to your
> > helpers.
> >
> As mentioned in above comment, the common helpers are written to make the
> code generic. I Will try to make it more clear, working on the same.

First, you move the code, then you make it generic. Or vice versa.
First you split the code, then you move it. Don't do both in the same
patch.

> > NAK for the rest of the patch.


-- 
With best wishes
Dmitry

