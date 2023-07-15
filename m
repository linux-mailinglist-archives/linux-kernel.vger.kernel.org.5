Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0B754C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 23:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjGOVa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 17:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOVa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 17:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00077270A;
        Sat, 15 Jul 2023 14:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A00560BB8;
        Sat, 15 Jul 2023 21:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AC5C433C9;
        Sat, 15 Jul 2023 21:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689456621;
        bh=XMEb/elm+pgGpMlhnXd5GXTk4SB+tgLImFkGqaygzss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIm6gh+Fv2agAUROjp8kseDzWfHI4jD7Jyn/PrfLqxFcLC0bhO92GuHh0C5Mad4Qz
         GHhoerD/v8U3rJGA2xNa/i81RyX67HHtAY85W/Dcft4cpcvO7EuRzhOQgrgE7+6vg1
         dyJhusDgdwikr1OUIK2bJiL8gvsg4zZpKqdLa/gG0Cn6px9hivkePv1z9ZuDy6lKN5
         skyuM8WL5txjJJet+HtSwSrq1/wyWpuFtdG8bDl+WtaJQ7DVKzKF8nAfQ2NYkZilIs
         NUS8/Qz5fvTGZL/2dn3K+1UZEke566yeHnGmo3+NzW4jfm76/+rM9X64vACyPEVgxY
         IlVQzbdNBazHw==
Date:   Sat, 15 Jul 2023 14:33:49 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: [PATCH v3 1/2] remoteproc: Introduce traces for remoteproc events
Message-ID: <g4aei4ro6nf7o2pgw4hvzrbdf6e5ipaelqj4gn6woodpjg2tu5@voytlrf2b337>
References: <cover.1683741283.git.quic_gokukris@quicinc.com>
 <5c7c2657d12808e211942d71ad79e3846f4e70bb.1683741283.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7c2657d12808e211942d71ad79e3846f4e70bb.1683741283.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:05:03AM -0700, Gokul krishna Krishnakumar wrote:
> Adding Traces for the following remoteproc events:
> 	rproc_subdev_event,
> 	rproc_interrupt_event,
> 	rproc_load_event,
> 	rproc_start_event,
> 	rproc_stop_event

No need to list the individual trace events, instead please use the
commit message do capture what problem(s) you intend you have for these
trace events - so that someone reading this can understand why these
particular events was added (and why others weren't).

> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/Makefile           |   1 +
>  drivers/remoteproc/qcom_tracepoints.c |  12 +++
>  include/trace/events/rproc_qcom.h     | 128 ++++++++++++++++++++++++++
>  3 files changed, 141 insertions(+)
>  create mode 100644 drivers/remoteproc/qcom_tracepoints.c
>  create mode 100644 include/trace/events/rproc_qcom.h
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 91314a9b43ce..3399fcaba39b 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_debugfs.o
>  remoteproc-y				+= remoteproc_sysfs.o
>  remoteproc-y				+= remoteproc_virtio.o
>  remoteproc-y				+= remoteproc_elf_loader.o
> +remoteproc-y				+= qcom_tracepoints.o
>  obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>  obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
> diff --git a/drivers/remoteproc/qcom_tracepoints.c b/drivers/remoteproc/qcom_tracepoints.c
> new file mode 100644
> index 000000000000..1b587ef54aa7
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_tracepoints.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/rproc_qcom.h>
> +EXPORT_TRACEPOINT_SYMBOL(rproc_load_event);
> +EXPORT_TRACEPOINT_SYMBOL(rproc_start_event);
> +EXPORT_TRACEPOINT_SYMBOL(rproc_stop_event);
> +EXPORT_TRACEPOINT_SYMBOL(rproc_interrupt_event);
> +EXPORT_TRACEPOINT_SYMBOL(rproc_subdev_event);
> diff --git a/include/trace/events/rproc_qcom.h b/include/trace/events/rproc_qcom.h
> new file mode 100644
> index 000000000000..48ad26ce18a3
> --- /dev/null
> +++ b/include/trace/events/rproc_qcom.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rproc_qcom
> +
> +#if !defined(_TRACE_RPROC_QCOM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RPROC_QCOM_H
> +#include <linux/tracepoint.h>
> +#include <linux/remoteproc.h>
> +
> +/*
> + * Tracepoints for remoteproc and subdevice events
> + */
> +TRACE_EVENT(rproc_load_event,

Please split these into more specific events, so that one can easily
enable specific events depending on which answers one is looking for.

Please avoid the _event suffix.

Regards,
Bjorn
