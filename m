Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B519B7926AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347390AbjIEQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353990AbjIEJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:02:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6538FBF;
        Tue,  5 Sep 2023 02:02:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8CDDE128D;
        Tue,  5 Sep 2023 11:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693904479;
        bh=i5xgoAvknUQnAeBrZlobtbTH4p/BfgvRHjqgFdrRzAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOHafGtT3Q36EEF7HniHebrGl8NFSP2+8LDoiWnYIVMmqAIhnixtIXnLXR5cQc8ut
         1w+tfxF0njauRH3r2BNE5GvHe3n0pybRvFN97mj1wlB85q1LqHnnq8qPXNIOePtBzS
         NN64tVqdxLSHqtJbpHR0azVqWOTCO2azMVlmxZVQ=
Date:   Tue, 5 Sep 2023 12:02:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] ARM: dts: stm32: add dcmipp support to stm32mp135
Message-ID: <20230905090258.GC31594@pendragon.ideasonboard.com>
References: <20230901155732.252436-1-alain.volmat@foss.st.com>
 <20230901155732.252436-5-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901155732.252436-5-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

Thank you for the patch.

On Fri, Sep 01, 2023 at 05:57:23PM +0200, Alain Volmat wrote:
> From: Hugues Fruchet <hugues.fruchet@foss.st.com>
> 
> Add dcmipp support to STM32MP135.
> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  arch/arm/boot/dts/st/stm32mp135.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp135.dtsi b/arch/arm/boot/dts/st/stm32mp135.dtsi
> index abf2acd37b4e..beee9ec7ed0d 100644
> --- a/arch/arm/boot/dts/st/stm32mp135.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp135.dtsi
> @@ -8,5 +8,13 @@
>  
>  / {
>  	soc {
> +		dcmipp: dcmipp@5a000000 {
> +			compatible = "st,stm32mp13-dcmipp";
> +			reg = <0x5a000000 0x400>;
> +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rcc DCMIPP_R>;
> +			clocks = <&rcc DCMIPP_K>;
> +			status = "disabled";

This needs a port, as it's marked as required in the bindings. You can
leave the endpoint out.

With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		};
>  	};
>  };

-- 
Regards,

Laurent Pinchart
