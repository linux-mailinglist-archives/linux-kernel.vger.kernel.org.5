Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5B7BCE79
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbjJHNHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344772AbjJHNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:07:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9059C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:07:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BF2C433C7;
        Sun,  8 Oct 2023 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696770472;
        bh=20jId0YR8CWrXSKu6wj0Jv9I+ASNRRUWUTUEQPTOuN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDUzESCuM/qK63Q6jxR5QWjNlH5R70XJI+Iknsybmet4t+BdDzvTU2oCZvZ8RFhoP
         dzbfqr+7DsW+5n+RhHZjAEpr/ftDXW6+mjNSMIaUDnxo87ODIx9WlU/M6YUHWDAZFw
         jABtubbjXpF7gJldfKGmzPKn0eyh3x68pHwqkOz0=
Date:   Sun, 8 Oct 2023 15:07:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, Bai Ping <ping.bai@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] nvmem: imx: correct nregs for i.MX6SLL
Message-ID: <2023100826-cranium-granite-be85@gregkh>
References: <20231008-nvmem-imx-v1-0-cabeb18ab676@nxp.com>
 <20231008-nvmem-imx-v1-1-cabeb18ab676@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008-nvmem-imx-v1-1-cabeb18ab676@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 04:10:20PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The nregs for i.MX6SLL should be 80 per fuse map, correct it.
> 
> Fixes: 6da27821a6f5 ("nvmem: imx-ocotp: add support for imx6sll")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/nvmem/imx-ocotp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 434f197e27bf..c59cfe13a5f8 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -498,7 +498,7 @@ static const struct ocotp_params imx6sl_params = {
>  };
>  
>  static const struct ocotp_params imx6sll_params = {
> -	.nregs = 128,
> +	.nregs = 80,
>  	.bank_address_words = 0,
>  	.set_timing = imx_ocotp_set_imx6_timing,
>  	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
> 
> -- 
> 2.37.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
