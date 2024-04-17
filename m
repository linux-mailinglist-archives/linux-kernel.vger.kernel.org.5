Return-Path: <linux-kernel+bounces-149051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B558A8B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896971C20C14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D0173341;
	Wed, 17 Apr 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9g0lEyf"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00B174EC0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378488; cv=none; b=uNrk10KIajZcRolrvmkbiRckOy3tarMZM5gbxV4ZIxP2uxKJBu4Npl++0TpA+GBNSP3UFP/o3ajDoT4A/NOgWkg2EZNA/XKNANLJgOwH9Qeh3c375Y6F1uzO4f1gh4DhFPqiPV81lf75liqYh1MjdJk2+lYCGSgLBfP6V2BwHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378488; c=relaxed/simple;
	bh=wmN8h4ozB0UgeEBmo+osjEtM80kKRFiGaQdWkFBBeZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMKqY3ys8U8mqD+hH0OTQYZaJvcnk6edQb1CIAmrmlguzhTvkx6rKGpRSkpd7UDgBil4tCObpDut0cL28XL2prbVLazrrPyk1dVQBX0sQccjfwlOcSY9eZmfPg0DFyQ5Gf/qT2G/bfbvzArjcTRoPOTNvj7RITXQwfKmC2MG07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N9g0lEyf; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso53209276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713378486; x=1713983286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMJDNkP5na580+qTNDtzkCRkb8re5nWvcJtefU2xHjw=;
        b=N9g0lEyf+Wd+sxViMrtYayfC6wep/Wnz4cPJeau2olF0rFVNkcGrGIWZDpAbN4qka2
         N0q+sfEl9RS7Qgs25KpK6M9tDOUyF8Vyzlk+Iq7xEE+UDI8CkNowev82GsF39a3NJlrh
         HLm986gWDS7/ER1ZJ1mVzAp7C59StJ/hYHiXOBeSsBPU/Z3iyFHk7hzO5aAUHCBPnqZP
         iwti9xibQwcNaHvakSGiWizfrCXHCWu/5X7Hicc1Rd4QLX0mKgH8Aciscxb6eXipcM9U
         9o+JU2JSKIzV118CWgWavweHwuAQk/X3KWiHlpKyBCDsOq/shsLCEsbaOH0F5IgjgbAf
         hR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713378486; x=1713983286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMJDNkP5na580+qTNDtzkCRkb8re5nWvcJtefU2xHjw=;
        b=sY5e8FlAN0m3JcxSnfUs9FP743baKyownfv9mzp7YpLK28Mhz6b41I5NtrY82UOSJX
         fpDyF2mZSbqyAYJyWze5qmkyPlgDZD1YYLtA6LPE2QnxEbxAUF2gYSE7zWrXjuS3FRyH
         RwJDcSpmMyZy7H4JsQFTLgxL8NyTCiNi7zYXy5Inq33xbEC6k94Jw8CScnqa312qxep5
         smvmyF64iMprnEkZfkoE8NwykZCmWA0g7mAMec1bsqNNj26WRM1QAjn7xOoR4Rt21GhS
         ht9xR7J22MmttDORYmJz2xgi6LX1lXV+gly/gZY60ctMeBbfBHM7IP3Q9PBrgVL5Ezjf
         uwBg==
X-Forwarded-Encrypted: i=1; AJvYcCXbs4tiydg8zUO+tiZEUEVMCP3rgQfsGGNAWZnpYuo1JuG5JIR/VG8+E+IjtAZ/1OsOcHN0xbMv03HzRY3iLEAf2UGfW/x6+GnOrtbR
X-Gm-Message-State: AOJu0Yy//7VTRtMt/RR31iDmJJW7MjO1/2XnLTrgO7/wXnwyPcYRJKZ4
	NK6k7zT1N3xJnbNVfPJTTXbRSHBCHEAfuBEwGbj22nYFHKFum+Pd0UkMjr8tzPTFqAjJQJLEMX3
	WNBVuCXLl8Y6mZGdrgptsEYv54dlV6aF44+HPUw==
X-Google-Smtp-Source: AGHT+IGNZsIVHisXMUcEjOiWQc3WhEb2Vk0LdTw1DW+G0Yj6S9aOq3AZOiVXyBoF3w9qrKG3Ncm8qaeSCQZv4+1YnC8=
X-Received: by 2002:a5b:c4e:0:b0:dcf:4663:ecd8 with SMTP id
 d14-20020a5b0c4e000000b00dcf4663ecd8mr208017ybr.8.1713378485731; Wed, 17 Apr
 2024 11:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417132856.1106250-1-quic_sibis@quicinc.com> <20240417132856.1106250-3-quic_sibis@quicinc.com>
In-Reply-To: <20240417132856.1106250-3-quic_sibis@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 21:27:54 +0300
Message-ID: <CAA8EJpq93GO+DMovuNdk8B-PYBF72SGxVXT2nwRX5w9X7pC4vg@mail.gmail.com>
Subject: Re: [PATCH V3 2/5] mailbox: Add support for QTI CPUCP mailbox controller
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, jassisinghbrar@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com, conor+dt@kernel.org, 
	quic_gkohli@quicinc.com, quic_nkela@quicinc.com, quic_psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 16:29, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> Add support for CPUSS Control Processor (CPUCP) mailbox controller,
> this driver enables communication between AP and CPUCP by acting as
> a doorbell between them.
>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>
> v2:
> * Use BIT() instead of manual shift. [Dmitry]
> * Define RX_MBOX_CMD to account for chan calculation. [Dmitry]
> * Clear the bit instead of the entire status within the spinlock. [Dmitry]
> * Use dev_err_probe instead. [Dmitry]
> * Drop superfluous error message while handling errors from get_irq. [Dmitry]
> * Use devm_mbox_controller_register and drop remove path. [Dmitry]
> * Define TX_MBOX_CMD to account for chan calculation.
> * Use cpucp->dev in probe path for conformity.
>
>  drivers/mailbox/Kconfig           |   8 ++
>  drivers/mailbox/Makefile          |   2 +
>  drivers/mailbox/qcom-cpucp-mbox.c | 188 ++++++++++++++++++++++++++++++
>  3 files changed, 198 insertions(+)
>  create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 42940108a187..23741a6f054e 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -273,6 +273,14 @@ config SPRD_MBOX
>           to send message between application processors and MCU. Say Y here if
>           you want to build the Spreatrum mailbox controller driver.
>
> +config QCOM_CPUCP_MBOX
> +       tristate "Qualcomm Technologies, Inc. CPUCP mailbox driver"
> +       depends on ARCH_QCOM || COMPILE_TEST
> +       help
> +         Qualcomm Technologies, Inc. CPUSS Control Processor (CPUCP) mailbox
> +         controller driver enables communication between AP and CPUCP. Say
> +         Y here if you want to build this driver.
> +
>  config QCOM_IPCC
>         tristate "Qualcomm Technologies, Inc. IPCC driver"
>         depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 18793e6caa2f..53b512800bde 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -59,4 +59,6 @@ obj-$(CONFIG_SUN6I_MSGBOX)    += sun6i-msgbox.o
>
>  obj-$(CONFIG_SPRD_MBOX)                += sprd-mailbox.o
>
> +obj-$(CONFIG_QCOM_CPUCP_MBOX)  += qcom-cpucp-mbox.o
> +
>  obj-$(CONFIG_QCOM_IPCC)                += qcom-ipcc.o
> diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
> new file mode 100644
> index 000000000000..059eb25f217c
> --- /dev/null
> +++ b/drivers/mailbox/qcom-cpucp-mbox.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/platform_device.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +
> +#define APSS_CPUCP_IPC_CHAN_SUPPORTED          3
> +#define APSS_CPUCP_MBOX_CMD_OFF                        0x4
> +
> +/* Tx Registers */
> +#define APSS_CPUCP_TX_MBOX_IDR                 0

I don't see _IDR defines being used.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +#define APSS_CPUCP_TX_MBOX_CMD(i)              (0x100 + ((i) * 8))
> +
> +/* Rx Registers */
> +#define APSS_CPUCP_RX_MBOX_IDR                 0
> +#define APSS_CPUCP_RX_MBOX_CMD(i)              (0x100 + ((i) * 8))
> +#define APSS_CPUCP_RX_MBOX_MAP                 0x4000
> +#define APSS_CPUCP_RX_MBOX_STAT                        0x4400
> +#define APSS_CPUCP_RX_MBOX_CLEAR               0x4800
> +#define APSS_CPUCP_RX_MBOX_EN                  0x4C00
> +#define APSS_CPUCP_RX_MBOX_CMD_MASK            0xFFFFFFFFFFFFFFFF


-- 
With best wishes
Dmitry

