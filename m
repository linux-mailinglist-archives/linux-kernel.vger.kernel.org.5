Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4B7A4D89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjIRPwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIRPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:52:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07841170E;
        Mon, 18 Sep 2023 08:51:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3EDE4881C;
        Mon, 18 Sep 2023 16:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695049001;
        bh=WLUi2NPc78JIOjN9Lo65OK6JYmPKUjzxwfThVedkFnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSwdo2nwGyvMql3NYl/k6Zelnks+AtZKpuC9OAZ9NhTvxMxwgul7gmmrWFBAxF6aT
         nK3YKPBpZl2i4Liz94J793vPPxIkmnM1Q0dmEFDneLrMs5Pt8lQCocnEhbNmcgU63K
         lvYxxIY04wvUGES+sUe7T6AiNe3QBiwAXT5dvR90=
Date:   Mon, 18 Sep 2023 17:58:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] arm64: xilinx: Use lower case for partition address
Message-ID: <20230918145829.GB16823@pendragon.ideasonboard.com>
References: <cover.1695040866.git.michal.simek@amd.com>
 <a96ac9a32a363b04958157548f290d480c21590c.1695040866.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a96ac9a32a363b04958157548f290d480c21590c.1695040866.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Mon, Sep 18, 2023 at 02:41:13PM +0200, Michal Simek wrote:
> Lower case should be used for register address.
> Issue is reported as:
> flash@0: partitions: Unevaluated properties are not allowed
> ('partition@22A0000' was unexpected)
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index c4774a42d5fc..157dcb4a27a8 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -222,9 +222,9 @@ partition@2280000 {
>  				label = "Secure OS Storage";
>  				reg = <0x2280000 0x20000>; /* 128KB */
>  			};
> -			partition@22A0000 {
> +			partition@22a0000 {
>  				label = "User";
> -				reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
> +				reg = <0x22a0000 0x1d60000>; /* 29.375 MB */
>  			};
>  		};
>  	};

-- 
Regards,

Laurent Pinchart
