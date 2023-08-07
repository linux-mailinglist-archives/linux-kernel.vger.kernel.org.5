Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905127718BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjHGDR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHGDR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01BD10F7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67ADE6135F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756EDC433C8;
        Mon,  7 Aug 2023 03:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691378274;
        bh=ShAbwspktRuvKsLysoPPT5Cpsp9HEo0RpA8LYpuk9iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sctKM8k8hUazPzw+CJyz8j49kbhHnUbMD0WvoZF2RgDsbi2L/xnM4yjpSvBtVY49+
         GLQ0ajuLPEyeQ2RAu7r2+GiGLnO8dPrQYVuRCT/zrgj1Neeqz95Vuc9KiHbkr++RaT
         goT4mTpBHwzGu4KEVgVlP9cH1n9DDwXaxCMjq5KgGlqTQp3zGimgPqHIsoP7se0n+J
         iM8hsn8RjKu7klkRv/LszxB3dQS8Xj5MN8wqyyJccVgpIyqhRBaKcytzxmtP6Eku9l
         QpaUmdqkFxDv/7AYghsOdyfWq+WjKTtDBeYfn3oCfTWwwtMFtHwTI6UZG+GWGZy9+m
         WixWrxL3cvwGg==
Date:   Mon, 7 Aug 2023 11:17:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 7/9] firmware: imx: scu-irq: export
 imx_scu_irq_get_status
Message-ID: <20230807031743.GQ151430@dragon>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731090449.2845997-8-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:04:47PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Cleanup code to export imx_scu_irq_get_status API to make it could
> be used by others, such as SECO.

The first read on subject and commit log gets me the impression that
imx_scu_irq_get_status() is an existing function.  Please improve to
make it clear that this is a new function.

Shawn

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu-irq.c | 40 ++++++++++++++++++++----------
>  include/linux/firmware/imx/sci.h   |  6 +++++
>  2 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> index 4408f150b3d5..6549f3792a0f 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2019 NXP
> + * Copyright 2019,2023 NXP
>   *
>   * Implementation of the SCU IRQ functions using MU.
>   *
> @@ -66,29 +66,18 @@ static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
>  
>  static void imx_scu_irq_work_handler(struct work_struct *work)
>  {
> -	struct imx_sc_msg_irq_get_status msg;
> -	struct imx_sc_rpc_msg *hdr = &msg.hdr;
>  	u32 irq_status;
>  	int ret;
>  	u8 i;
>  
>  	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
> -		hdr->ver = IMX_SC_RPC_VERSION;
> -		hdr->svc = IMX_SC_RPC_SVC_IRQ;
> -		hdr->func = IMX_SC_IRQ_FUNC_STATUS;
> -		hdr->size = 2;
> -
> -		msg.data.req.resource = mu_resource_id;
> -		msg.data.req.group = i;
> -
> -		ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
> +		ret = imx_scu_irq_get_status(i, &irq_status);
>  		if (ret) {
>  			pr_err("get irq group %d status failed, ret %d\n",
>  			       i, ret);
>  			return;
>  		}
>  
> -		irq_status = msg.data.resp.status;
>  		if (!irq_status)
>  			continue;
>  
> @@ -97,6 +86,31 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
>  	}
>  }
>  
> +int imx_scu_irq_get_status(u8 group, u32 *irq_status)
> +{
> +	struct imx_sc_msg_irq_get_status msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_IRQ;
> +	hdr->func = IMX_SC_IRQ_FUNC_STATUS;
> +	hdr->size = 2;
> +
> +	msg.data.req.resource = mu_resource_id;
> +	msg.data.req.group = group;
> +
> +	ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
> +	if (ret)
> +		return ret;
> +
> +	if (irq_status)
> +		*irq_status = msg.data.resp.status;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(imx_scu_irq_get_status);
> +
>  int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
>  {
>  	struct imx_sc_msg_irq_enable msg;
> diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index 7fa0f3b329b5..df17196df5ff 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -21,6 +21,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev);
>  int imx_scu_irq_register_notifier(struct notifier_block *nb);
>  int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
>  int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
> +int imx_scu_irq_get_status(u8 group, u32 *irq_status);
>  int imx_scu_soc_init(struct device *dev);
>  #else
>  static inline int imx_scu_soc_init(struct device *dev)
> @@ -47,5 +48,10 @@ static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int imx_scu_irq_get_status(u8 group, u32 *irq_status)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  #endif /* _SC_SCI_H */
> -- 
> 2.37.1
> 
