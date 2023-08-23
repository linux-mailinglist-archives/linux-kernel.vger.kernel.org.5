Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B650785DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjHWRAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHWRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440FE68;
        Wed, 23 Aug 2023 10:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0B1649E3;
        Wed, 23 Aug 2023 17:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE625C433C7;
        Wed, 23 Aug 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692810027;
        bh=8VEsVfqtU9S9MgX99shwdJkXDGcWzkQCx635Hl8h+H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uF1ZA1gZ2i/TKYqocN8CHEInCnahoWHZcMnr7altexmz1FDwEk+yWK3yUgfd7eAYG
         bVuhcvBdVQsy7u51Ur8zIP85JADUqrO61CbjAsdyZGpMmGzv13kcjkw1Il8mzWaHbO
         n8FXFiF5v6NoRB3bQdcOQnBjizF/0Kj07NMYWhkmdvO2kUYHoJl/kQKT2ZDcqts64v
         OfgbDPfj+ylvXEjmxdH/KYDhugkwVrQ475Cv/+B7Bm1m43glz5uH48+i8Tq5HD6GQx
         KYmFh+6Bduj6IgUjNDDRGBAiT1FiSAYRL+AKPNmcvf3zJNAq2xLf9KJNQvnjIQG1dd
         1Ol7aKTGt9MQg==
Received: (nullmailer pid 2470418 invoked by uid 1000);
        Wed, 23 Aug 2023 17:00:25 -0000
Date:   Wed, 23 Aug 2023 12:00:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arc: Explicitly include correct DT includes
Message-ID: <20230823170025.GA2470216-robh@kernel.org>
References: <20230714173949.4038981-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714173949.4038981-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:39:49AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arc/plat-axs10x/axs10x.c | 1 -
>  1 file changed, 1 deletion(-)

Ping!

> 
> diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
> index b821df7b0089..1feb990a56bc 100644
> --- a/arch/arc/plat-axs10x/axs10x.c
> +++ b/arch/arc/plat-axs10x/axs10x.c
> @@ -6,7 +6,6 @@
>   */
>  
>  #include <linux/of_fdt.h>
> -#include <linux/of_platform.h>
>  #include <linux/libfdt.h>
>  
>  #include <asm/asm-offsets.h>
> -- 
> 2.40.1
> 
