Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27047ACE24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjIYCbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjIYCbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:31:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF1C2;
        Sun, 24 Sep 2023 19:31:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295EBC433C8;
        Mon, 25 Sep 2023 02:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695609092;
        bh=wZEBT6XR8mvPnx5In5pdpKcEzvWvq0vEkyU3ibd2N9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lm3KUnQSLCYOLn46cVbAGsWrtYsQkYQMsydgtF5jmTkjpLn26/dDKi8kM+LjCn7xV
         rsS6VbFWXE3YYRmXmRdSn2dzYR2DRTuJgvB55r9tCLaQaxOYD6Sow+JIheO0I7SYx+
         /WuA5dlklOmD76AJwlFdFlyCWaQVLhg1yBJeACRrawDqoZWH0rcaqjP50h7TOtjyjF
         VIgn6TAvTFOYFQUsI06yF472MfQUegB7fOrxLG94LCFpX1FdhNUEZ2tTD5hJXIwACF
         MOICHpzQMyO5J4xyYxf0huU7/41JnbHy08M6vuGUfdg4nFHbYEs44YbsduKSPqYPXI
         JwSt4ZTjW5eiQ==
Date:   Mon, 25 Sep 2023 10:31:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mp: add reserve-memory nodes for
 DSP
Message-ID: <20230925023117.GZ7231@dragon>
References: <20230912153021.21786-1-iuliana.prodan@oss.nxp.com>
 <20230912153021.21786-3-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912153021.21786-3-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:30:21PM +0300, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> Add the reserve-memory nodes used by DSP when the rpmsg
> feature is enabled.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index cc406bb338fe..59e672382b07 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -211,6 +211,19 @@
>  			reg = <0 0x92400000 0 0x2000000>;
>  			no-map;
>  		};
> +		dsp_vdev0vring0: vdev0vring0@942f0000 {
> +			reg = <0 0x942f0000 0 0x8000>;
> +			no-map;
> +		};

Please have a newline between nodes.

Shawn

> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
> +			reg = <0 0x942f8000 0 0x8000>;
> +			no-map;
> +		};
> +		dsp_vdev0buffer: vdev0buffer@94300000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x94300000 0 0x100000>;
> +			no-map;
> +		};
>  	};
>  
>  	pmu {
> -- 
> 2.17.1
> 
