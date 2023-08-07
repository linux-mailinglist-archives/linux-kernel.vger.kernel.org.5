Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7A771855
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHGC1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHGC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4F795
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4479B61305
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999E5C433C7;
        Mon,  7 Aug 2023 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691375261;
        bh=iJ2z82p0DxEKxBAy/Uy/k+cv7auNTA6XBM0RzAeWTYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEOZQRoWl2w1znZJpNHYIudRisLtK7+FSJmJrGxABK8lDHJWuGZX+dbSAvPCs7g8G
         KdG9+KG9DXnEL56dA8ZE1mcTp9ZTGWRMLcPzP5FT2qixOeMT1xzQL6Lso4qqhTWTTB
         3Jn/PiGFLEB190PvqVWP0rxo4F/eWAzMQcCXnmvD+odGVUL1fPJQA6H9Xm3ruRnQ9i
         UZKvmPICjKkDVl0lp8rtF3BnaOtslh1ghOgvMyCsYVO7ic2KwffsOEfTdWu9pX85cX
         DiQnG0ieL/bG9WnoE9DOFJg7CucRkPY5PLFqSmIV8rL4iCp9s/RpFWDwFmCfqg2Tg2
         TtXOGsm+UGZgA==
Date:   Mon, 7 Aug 2023 10:27:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 2/9] firmware: imx: scu: increase RPC timeout
Message-ID: <20230807022729.GK151430@dragon>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731090449.2845997-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:04:42PM +0800, Peng Fan (OSS) wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> When system loading is high, we can met some command timeout

s/met/meet

> issue occasionaly, so increase the timeout to a more safe value.

s/occasionaly/occasionally

Shawn

> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 2d24359420d8..14ff9d3504bf 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -20,7 +20,7 @@
>  #include <linux/platform_device.h>
>  
>  #define SCU_MU_CHAN_NUM		8
> -#define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
> +#define MAX_RX_TIMEOUT		(msecs_to_jiffies(3000))
>  
>  struct imx_sc_chan {
>  	struct imx_sc_ipc *sc_ipc;
> -- 
> 2.37.1
> 
