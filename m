Return-Path: <linux-kernel+bounces-105676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7CB87E276
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A32E282A91
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8381EB21;
	Mon, 18 Mar 2024 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhIRGsTu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BAD8814;
	Mon, 18 Mar 2024 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710731908; cv=none; b=oQolXirGSMBWCu75F/snoDfNQbEdzFBR9fnKASyAhw6DjfbSl6QyRZtwFVdKFgw+HxR6SEoc/8tgrRv5tvhECIqpbva/wNeSqxiUaZDPltDDY3ldW7VdHl/VUc6bERGj3lpycXGJajvlJUNqz42kZGLZXdhgbyG9jxwqj5mj/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710731908; c=relaxed/simple;
	bh=14bYwfyKnrSuarvwBbfH0P3zulZ9dmGFZADpCDhjnF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MplPqgcsDTqpDu6yFT74e3mL7f1rjGP3Uls+5A8qjbcQaV8Eu8NcBouB49AcWECTTV4XQdntNPwVOvfyqDr9H8fwDuzvKkclGmCsbj4iXLKuRkA9fOJ4M3vcunNlKy5NV8jcz5oQf74JOKHIjbPpCM9cqKDP6PF/SIsrUMikKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhIRGsTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3913C433F1;
	Mon, 18 Mar 2024 03:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710731907;
	bh=14bYwfyKnrSuarvwBbfH0P3zulZ9dmGFZADpCDhjnF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhIRGsTuZwzldYs8aRcPWfxlGWleW5ZmIKYwJ5bPhHwhuY3rvfmtTnLpEaLVP4mEB
	 LThjSdGB8XJJa7gc7ujKZIHaKIK2qbJVX3nteOyMq/YdCBeubcXMfZVp3vvDy2kOlH
	 zyjbWCAvJQhzptd8jNNaKshAiGyhvHp7gy+G8ujfSlfLj/VRO0WzxSKGVI4cUx6Lnd
	 iUdVGq3ve8VweS9yJoNYTf/tfgaq6JTfZfjgtn/IGzxNBog6GMlcVcnTbjVeYW43rK
	 Coqx83aOfuasLB1vtJN/3wZ3EmKmQgc8ct6ctbVbw2D6EOgtcXhQGuqq9brrTgRG/D
	 /as2zBebvpk6Q==
Date: Sun, 17 Mar 2024 22:18:25 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, 
	quic_collinsd@quicinc.com, quic_lsrao@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight
 request
Message-ID: <vuyzqntyhzz5at5q7rxkix6ogavow4kltge26q62ihzhsblsuv@o43un23zaf4w>
References: <20240215-rpmh-rsc-fixes-v4-1-9cbddfcba05b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-rpmh-rsc-fixes-v4-1-9cbddfcba05b@quicinc.com>

On Thu, Feb 15, 2024 at 10:55:44AM +0530, Maulik Shah wrote:
> Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte aligned
> addresses associated with it. These control voltage, enable state, mode,
> and in legacy targets, voltage headroom. The current in-flight request
> checking logic looks for exact address matches. Requests for different
> addresses of the same RPMh resource as thus not detected as in-flight.
> 
> Add new cmd-db API cmd_db_match_resource_addr() to enhance the in-flight
> request check for VRM requests by ignoring the address offset.
> 
> This ensures that only one request is allowed to be in-flight for a given
> VRM resource. This is needed to avoid scenarios where request commands are
> carried out by RPMh hardware out-of-order leading to LDO regulator
> over-current protection triggering.
> 
> Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs")
> cc: stable@vger.kernel.org
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Tested-by: Elliot Berman <quic_eberman@quicinc.com> # sm8650-qrd
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
> Changes in v4:
> - Simplify cmd_db_match_resource_addr()
> - Remove unrelated changes to newly added logic
> - Update function description comments

You changed things, but retained Konrad's Reviewed-by...

> - Replace Signed-off-by: with Tested-by: from Elliot

Did Elliot test v4, or did you just translate his incorrect(?) s-o-b
from v1 into a tested-by?

We're about to write into the git history that Elliot says this version
is tested to the best of his abilities...

> - Link to v3: https://lore.kernel.org/r/20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com
> Changes in v3:
> - Fix s-o-b chain
> - Add cmd-db API to compare addresses
> - Reuse already defined resource types in cmd-db
> - Add Fixes tag and Cc to stable
> - Retain Reviewed-by tag of v2
> - Link to v2: https://lore.kernel.org/r/20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com
> Changes in v2:
> - Use GENMASK() and FIELD_GET()
> - Link to v1: https://lore.kernel.org/r/20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com
> ---
>  drivers/soc/qcom/cmd-db.c   | 32 +++++++++++++++++++++++++++++++-
>  drivers/soc/qcom/rpmh-rsc.c |  3 ++-
>  include/soc/qcom/cmd-db.h   | 10 +++++++++-
>  3 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a5fd68411bed..86fb2cd4f484 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -1,6 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved. */
> +/*
> + * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
>  
> +#include <linux/bitfield.h>
>  #include <linux/debugfs.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -17,6 +21,8 @@
>  #define MAX_SLV_ID		8
>  #define SLAVE_ID_MASK		0x7
>  #define SLAVE_ID_SHIFT		16
> +#define SLAVE_ID(addr)		FIELD_GET(GENMASK(19, 16), addr)
> +#define VRM_ADDR(addr)		FIELD_GET(GENMASK(19, 4), addr)
>  
>  /**
>   * struct entry_header: header for each entry in cmddb
> @@ -220,6 +226,30 @@ const void *cmd_db_read_aux_data(const char *id, size_t *len)
>  }
>  EXPORT_SYMBOL_GPL(cmd_db_read_aux_data);
>  
> +/**
> + * cmd_db_match_resource_addr() - Compare if both Resource addresses are same
> + *
> + * @addr1: Resource address to compare
> + * @addr2: Resource address to compare
> + *
> + * Return: true if two addresses refer to the same resource, false otherwise
> + */
> +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
> +{
> +	/*
> +	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
> +	 * aligned addresses associated with it. Ignore the offset to check
> +	 * for VRM requests.
> +	 */
> +	if (addr1 == addr2)
> +		return true;
> +	else if (SLAVE_ID(addr1) == CMD_DB_HW_VRM && VRM_ADDR(addr1) == VRM_ADDR(addr2))

Is it a fact or a coincidence that GENMASK(19, 16) of the address
happens to have the same value as the associated rsc_hdr's slv_id?


I recognize that we probably don't want to start naively traversing the
headers here, but as previously requested I would still like to have an
interface where I can pass in an address and have its entry_header->id
resolved, for tracing/debug purposes. Perhaps there's some common
ground?

Regards,
Bjorn

> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
> +
>  /**
>   * cmd_db_read_slave_id - Get the slave ID for a given resource address
>   *
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index a021dc71807b..daf64be966fe 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
> @@ -557,7 +558,7 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>  		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
>  			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
>  			for (k = 0; k < msg->num_cmds; k++) {
> -				if (addr == msg->cmds[k].addr)
> +				if (cmd_db_match_resource_addr(msg->cmds[k].addr, addr))
>  					return -EBUSY;
>  			}
>  		}
> diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
> index c8bb56e6852a..47a6cab75e63 100644
> --- a/include/soc/qcom/cmd-db.h
> +++ b/include/soc/qcom/cmd-db.h
> @@ -1,5 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
> +/*
> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
>  
>  #ifndef __QCOM_COMMAND_DB_H__
>  #define __QCOM_COMMAND_DB_H__
> @@ -21,6 +24,8 @@ u32 cmd_db_read_addr(const char *resource_id);
>  
>  const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
>  
> +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2);
> +
>  enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
>  
>  int cmd_db_ready(void);
> @@ -31,6 +36,9 @@ static inline u32 cmd_db_read_addr(const char *resource_id)
>  static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
>  { return ERR_PTR(-ENODEV); }
>  
> +static inline bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
> +{ return false; }
> +
>  static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
>  { return -ENODEV; }
>  
> 
> ---
> base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
> change-id: 20240210-rpmh-rsc-fixes-372a79ab364b
> 
> Best regards,
> -- 
> Maulik Shah <quic_mkshah@quicinc.com>
> 

