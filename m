Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084E579AFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376276AbjIKWTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243171AbjIKQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:56:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00A110;
        Mon, 11 Sep 2023 09:56:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498D4C433C8;
        Mon, 11 Sep 2023 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694451373;
        bh=Y7SJ+v7BXjVozGwx+J8uyS7CcVLahIvWjaQ730vSWCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIs7H5J9qh+/vQZbRcQkkGuUsmwRuh9CHhEDotPRKQRi7T+p5N+zf27CipLkU0/Z/
         uuAXzJD/UPFsuwR/ST29vQrmzllHup7naqD3R0o6mwk4/CPzT8TbuyhQG/6ES2V6XQ
         TyKpvt2tGFWrxchhVT9qShnFTNpvh95bB5/ts10iELKiYRpeV9RIM4TIuVcszjPGZa
         taYCGN7GORziAu2dBKOQ982XEObI+qsiNhssp1xCYw0rIq+YBSFcg2Umdpht28mMfZ
         5MeNR53CEPfmHSJmneJsoQPnRxvNWy1+reAqFSnwJg8H5hapBD1tAxLvUgkueCrc3h
         Aze/zavd44OzQ==
Received: (nullmailer pid 1367058 invoked by uid 1000);
        Mon, 11 Sep 2023 16:56:10 -0000
Date:   Mon, 11 Sep 2023 11:56:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        srk@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-evm-gesi: Specify base dtb for
 overlay file
Message-ID: <20230911165610.GA1362932-robh@kernel.org>
References: <20230911052158.89185-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911052158.89185-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:51:58AM +0530, Siddharth Vadapalli wrote:
> Specify the base dtb file k3-j721s2-common-proc-board.dtb on which the
> k3-j721s2-evm-gesi-exp-board.dtbo overlay has to be applied. Name the
> resulting dtb as k3-j721s2-evm.dtb.
> 
> Fixes: cac04e27f093 ("arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI")
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Note: This patch is based on linux-next tagged next-20230911.
> 
>  arch/arm64/boot/dts/ti/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index e7b8e2e7f083..ef8ca50fbb36 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -63,9 +63,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
>  
>  # Boards with J721s2 SoC
> +k3-j721s2-evm-dtbs := k3-j721s2-common-proc-board.dtb k3-j721s2-evm-gesi-exp-board.dtbo

Move this next to the "dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb" line.

>  dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
> -dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
> -dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo

I think dropping these will cause them to not get installed (by 
dtbs_install). Presumably you want them.

> +dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
>  
>  # Boards with J784s4 SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
> -- 
> 2.34.1
> 
