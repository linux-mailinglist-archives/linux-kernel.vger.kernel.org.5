Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C838977187E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHGCym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjHGCyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93251171E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2915161305
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03A3C433C9;
        Mon,  7 Aug 2023 02:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691376862;
        bh=Co7bitjHl1G8SouxGx8spiP4TZY1ULqvzabs+FN5F3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/n+9sIwpi2uzfttCikXPZ+6fItqzzRTe8qj+/meEQfLhKpAGMxycNYZpDegfILyk
         Syb28HP4VoAtoSsatbYzlKoWzhUyGAz3bDTwGLhct8vOp2vsEGRrIoxT7MO6tzwjCW
         XdA2x9Xnk5a/XdCTDeMxOIc9iyM8+M7PkcmflR7b7sC0brG6IV8lWI6LWq43KTyQ9v
         8542j3II3SJXBqJLFFQMdP1AEO/UzyoKPt/9TdsJr37aOIRkIDetdriXPvDzfOThum
         FRLZf0TWliCBWmV0t1835eOpEgvFzsC8Z4sdCty9QKGlWzJS6AJuBGLhq7u3wDKpf6
         ut9964G1TsWNg==
Date:   Mon, 7 Aug 2023 10:54:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 5/9] firmware: imx: scu: use EOPNOTSUPP
Message-ID: <20230807025412.GN151430@dragon>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731090449.2845997-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:04:45PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> EOPNOTSUPP is preferred than ENOTSUPP.

Could you elaborate why?

Shawn

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/linux/firmware/imx/sci.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
> index 5cc63fe7e84d..7fa0f3b329b5 100644
> --- a/include/linux/firmware/imx/sci.h
> +++ b/include/linux/firmware/imx/sci.h
> @@ -25,27 +25,27 @@ int imx_scu_soc_init(struct device *dev);
>  #else
>  static inline int imx_scu_soc_init(struct device *dev)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  
>  static inline int imx_scu_enable_general_irq_channel(struct device *dev)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  
>  static inline int imx_scu_irq_register_notifier(struct notifier_block *nb)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  
>  static inline int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  
>  static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
>  {
> -	return -ENOTSUPP;
> +	return -EOPNOTSUPP;
>  }
>  #endif
>  #endif /* _SC_SCI_H */
> -- 
> 2.37.1
> 
