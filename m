Return-Path: <linux-kernel+bounces-64772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96558542A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C51B2830A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446F10A36;
	Wed, 14 Feb 2024 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liPVWZFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B310A24;
	Wed, 14 Feb 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890926; cv=none; b=XFlSfXAaTIS493bATDGSBBeZ0JkqzLYkaGshueUHEvfEbsU35uOotW7+B07s88R98WTwqqaZ4Qxwv1VWNAbJmyChcHjR+J+PtH+PPKDX+/nFD2Zjw7CuaPKmQ719gXrc6qHQdmrjTnPBZLQCZYsWjZfEh8K/X4xTUaw/xX4Xbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890926; c=relaxed/simple;
	bh=26qLiOXzYeED5IFqKrSHmZtbA31FiyeXrlDpVXVqkyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVKhwRHtnQXYQiWLDPAxcjn+BjWbzilH+ViiRS82aEJy1gkfSgNMwDVo73+/nrVCWSlSlK5/TP1rpuUL9IuWWQNiZCE+aacYzGIQE38JQJKl5LGw2Sly/FJ07aYUquplol/Bo/2tiKiAVJcf2WFVBfvJZLJ7w93NgcCXWmIQs2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liPVWZFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A0C433F1;
	Wed, 14 Feb 2024 06:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707890926;
	bh=26qLiOXzYeED5IFqKrSHmZtbA31FiyeXrlDpVXVqkyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liPVWZFhHJpyNajvbqJtbbY+aBqy8k6HWFKYVurNV/BUVIybLsxhd2RwvJTkxIEK5
	 xUoevEOXM5Lr4uEoHoBjNGF8di97/+LePaaGwCQuvEaCbtdpIFKKG+rPkLYosMPu0P
	 fT+4dRxSjEeD5YkeVT1J0LbjFhKBXFGhh17HEEYyT69/sjgG1WtG8djQ6uqWU+vWrN
	 pN/OdyErb6W4/PcxTYdqiVrwvETH/4y/irRCofAsQdSpl/IE3akjlgaSzpFRymohgJ
	 V+1DovqQuiw3Q98kVJXqqphCXKw01RpyFAY2W45C9PkYE3Yr3r756nhUkJDM4zZy/h
	 BHY2bXVWMIhkg==
Date: Wed, 14 Feb 2024 00:08:43 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, 
	quic_collinsd@quicinc.com, quic_lsrao@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight
 request
Message-ID: <sizizst7xkexl3dd26sssgxtjhk7mcrawswbs76vdutsxsm6qh@mvilvzwydjpm>
References: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>

On Mon, Feb 12, 2024 at 10:18:08AM +0530, Maulik Shah wrote:
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
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

This says, "Elliot first certified the origin of the patch, then Maulik
took and certified the origin of the patch". But according to the From:
the author of the patch is you, Maulik.

How was Elliot able to certify the patch's origin before you, when
you're the author?

If the two of you collaborated, also add Co-developed-by: Elliot above
his s-o-b.

> ---
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
>  drivers/soc/qcom/cmd-db.c   | 41 +++++++++++++++++++++++++++++++++++------
>  drivers/soc/qcom/rpmh-rsc.c |  3 ++-
>  include/soc/qcom/cmd-db.h   | 10 +++++++++-
>  3 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a5fd68411bed..e87682b9755e 100644
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
> @@ -15,8 +19,8 @@
>  
>  #define NUM_PRIORITY		2
>  #define MAX_SLV_ID		8
> -#define SLAVE_ID_MASK		0x7
> -#define SLAVE_ID_SHIFT		16
> +#define SLAVE_ID(addr)		FIELD_GET(GENMASK(19, 16), addr)
> +#define VRM_ADDR(addr)		FIELD_GET(GENMASK(19, 4), addr)
>  
>  /**
>   * struct entry_header: header for each entry in cmddb
> @@ -221,9 +225,34 @@ const void *cmd_db_read_aux_data(const char *id, size_t *len)
>  EXPORT_SYMBOL_GPL(cmd_db_read_aux_data);
>  
>  /**
> - * cmd_db_read_slave_id - Get the slave ID for a given resource address
> + * cmd_db_match_resource_addr - Compare if both Resource addresses are same

() after the function name, please.

> + *
> + * @addr1: Resource address to compare
> + * @addr2: Resource address to compare
> + *
> + * Return: true on matching addresses, false otherwise

"Return: true if the two addresses refer to the same resource"

> + */
> +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
> +{
> +	/*
> +	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
> +	 * aligned addresses associated with it. Ignore the offset to check
> +	 * for VRM requests.
> +	 */
> +	if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
> +	    && VRM_ADDR(addr1) == VRM_ADDR(addr2))

One line please, it's just 83 characters.

> +		return true;
> +	else if (addr1 == addr2)
> +		return true;
> +	else
> +		return false;
> +}
> +EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
> +
> +/**
> + * cmd_db_read_slave_id - Get the slave ID for a given resource name
>   *
> - * @id: Resource id to query the DB for version
> + * @id: Resource id to query the DB for slave id

Although trivial, it's unrelated to the newly introduced logic. Please
submit a separate patch. Please also then add the () after the function
name.

Regards,
Bjorn

>   *
>   * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
>   */
> @@ -238,7 +267,7 @@ enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
>  		return CMD_DB_HW_INVALID;
>  
>  	addr = le32_to_cpu(ent->addr);
> -	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
> +	return SLAVE_ID(addr);
>  }
>  EXPORT_SYMBOL_GPL(cmd_db_read_slave_id);
>  
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

