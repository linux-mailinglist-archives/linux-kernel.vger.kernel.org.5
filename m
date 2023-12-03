Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C585580209F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjLCEQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCEQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:16:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E032FC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:16:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37836C433C7;
        Sun,  3 Dec 2023 04:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701577019;
        bh=dNHaZIvvaL6GGnX3G4FpDDFAZEql/SRhtxrzRXaewmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5JUmFm/oayglVa+ESKehMFNjvY/n/cH68K/sEZ7dcraLOxPaOLgo1hpq8UxTh4/F
         uUIFb/ezUeoWdT4FNfSClHVsufzcyxTFi8IMUWtiOpKtX5W9RlqkIxKaq4yKZC/IEF
         UHoYOBaMOBridTzgUagDT1Rm5lhaYru2mnLp9oNzU9SH+uhGrBXQaPIYK1GripprL9
         NWsPzQVp9O2SFVT+yrlZV0FiKJM9XiE8n0N+Wx5w0/0pdzwyOW+C3KVGrDDz8sxQnP
         NJzHDGpH+gEfoCnXodsV2J9vC5H7hoZEWoByMaxjx4f+m1uCjQBQaptbIk6S0v5rHg
         MothIW7k/HoBA==
Date:   Sat, 2 Dec 2023 20:20:23 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: msm8953: Set initial address
 for memory
Message-ID: <t6ckvr7bcpoc3z4cam7bilp67nn6qyvrmnqch6tlkwug7n2neq@32f5mso75fvu>
References: <20231125-msm8953-misc-fixes-v2-0-df86655841d9@z3ntu.xyz>
 <20231125-msm8953-misc-fixes-v2-1-df86655841d9@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125-msm8953-misc-fixes-v2-1-df86655841d9@z3ntu.xyz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 01:19:27PM +0100, Luca Weiss wrote:
> The dtbs_check really doesn't like having memory without reg set.
> 
> The base address depends on the amount of RAM you have:
> 
>   <= 2.00 GiB RAM: 0x80000000
>    = 3.00 GiB RAM: 0x40000000
>    = 3.75 GiB RAM: 0x10000000
>  (more does not fit into the 32-bit physical address space)
> 
> So, let's pick one of the values, 0x10000000 which is used on devices
> with 3.75 GiB RAM. Since the bootloader will update it to what's present
> on the device it doesn't matter too much.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index e7de7632669a..a3ba24ca599b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -174,10 +174,10 @@ scm: scm {
>  		};
>  	};
>  
> -	memory {

Wouldn't it be sufficient to add @0 here, to please dtbs_check?

Regards,
Bjorn

> +	memory@10000000 {
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the reg */
> -		reg = <0 0 0 0>;
> +		reg = <0 0x10000000 0 0>;
>  	};
>  
>  	pmu {
> 
> -- 
> 2.43.0
> 
