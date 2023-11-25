Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08127F8CB9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjKYRXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYRXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:23:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38F12B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:23:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37AFC433C7;
        Sat, 25 Nov 2023 17:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700933025;
        bh=gMkhf8RPl8pp028nV+oUvr++bgtB47tDt4Up7ve1fzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hh023ng28djz1q4kDTHiPGNqU29wd1KvWNHRej6344yvso4XGCNTbbj3WxhlV2yZA
         aAknmdPsVKQHmQfjV3gGIiXVnE+yGzxEhINmn//SXR+Iy0Edgq9Nw93nYs1XEDiJq+
         HSGn3KMdZqaELxEvfBd+dnJX/Sk5VL0bM/mlXX2ST3My8fpXOaOIHuvb5W3kx7uzht
         NccDLmRJ0POfOmFbgPXkWjBo/erH7oL+yl94BSx6txwa3/4OLOIOYYpDEehZgwxCFw
         kp8GDQlRZn9mCZY6FNVJ9qVk1+hDkawhJCXh9YpNKZnpx/c4+o0KtO0Cxcx/90kNDV
         6yEpTtt3NLznw==
Date:   Sat, 25 Nov 2023 17:23:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Marius Cristea <marius.cristea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: improve section MICROCHIP MCP3564 ADC
 DRIVER
Message-ID: <20231125172338.132cee83@jic23-huawei>
In-Reply-To: <20231122075629.21411-1-lukas.bulwahn@gmail.com>
References: <20231122075629.21411-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 08:56:29 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC") adds a new
> iio driver and corresponding MAINTAINERS section. It however uses spaces
> instead of a single tab for all the entries in that MAINTAINERS section.
> 
> Although, the get_maintainer.pl script handles spaces instead of tabs
> silently, the MAINTAINERS will quickly get into a messy state with
> different indentations throughout the file. So, the checkpatch.pl script
> complains when spaces instead of a single tab are used.
> 
> Fix this recently added section using tabs instead of spaces.
> Further, add the driver's ABI documentation file to this section as well.
> 
> Fixes: 33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Good to cleanup, but I'm guessing no super rush to do so and this can wait for
next merge window.

As such, applied to the togreg branch of iio.git and initially pushed out
as testing for 0-day to ignore this one.

Jonathan

> ---
>  MAINTAINERS | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04c6fcbb21aa..c74ec0681aa1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14213,11 +14213,12 @@ F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
>  F:	drivers/regulator/mcp16502.c
>  
>  MICROCHIP MCP3564 ADC DRIVER
> -M:      Marius Cristea <marius.cristea@microchip.com>
> -L:      linux-iio@vger.kernel.org
> -S:      Supported
> -F:      Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> -F:      drivers/iio/adc/mcp3564.c
> +M:	Marius Cristea <marius.cristea@microchip.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
> +F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> +F:	drivers/iio/adc/mcp3564.c
>  
>  MICROCHIP MCP3911 ADC DRIVER
>  M:	Marcus Folkesson <marcus.folkesson@gmail.com>

