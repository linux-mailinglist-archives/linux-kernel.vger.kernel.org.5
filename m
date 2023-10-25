Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EF67D6B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjJYM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJYM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:28:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AF28F;
        Wed, 25 Oct 2023 05:28:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96B5B660731F;
        Wed, 25 Oct 2023 13:28:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698236922;
        bh=XVUNCwXvwwO8iAGXwgWiNkikQdtq3Qfu7s3r4hSQ49Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VvaXFBCXSZopdm9zEMBPwk52IGi4WqgdVNuy/su89jrUPEmGfR3Oh2C+7rodLTPs8
         MsF+R+8rndzXh7Dwkmx4UoffY9LX9WYImV1DCu4O2I238ybFyQmHsTCnJGatMusYbT
         7VcI//prbtGebFGqWqNCwPBHw2BCcEglfjRgxFarDMdoaTth2X6hboQhferuPcYshq
         56XPcLdv+MLLr8x4ZtmzjbYwdwhedhEQ9SCGVXTZ0tJBEa13eO52w4TZ/J5sEJ9D7F
         INdKjtHNV9aNoJhlN0RIeMd3oi/fI/446tUbAV/ytB/IE40yf3xBjrp9zcJ3XLlmiF
         07Pdti5Kv8WHw==
Message-ID: <42c8fbc2-49db-4cca-aabe-520e4eee597a@collabora.com>
Date:   Wed, 25 Oct 2023 14:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: dts: mt7986: change cooling trips
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230820153135.42588-1-linux@fw-web.de>
 <20230820153135.42588-3-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230820153135.42588-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/08/23 17:31, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Critical and hot trips for emergency system shutdown and limiting
> system load.
> 
> Change passive trip to active to make sure fan is activated on the
> lowest trip.
> 
> Fixes: 1f5be05132f3 ("arm64: dts: mt7986: add thermal-zones")
> Suggested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 207510abda89..36d8945400df 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -614,22 +614,34 @@ cpu_thermal: cpu-thermal {
>   			thermal-sensors = <&thermal 0>;
>   
>   			trips {
> +				cpu_trip_crit: crit {
> +					temperature = <125000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +
> +				cpu_trip_hot: hot {
> +					temperature = <120000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
>   				cpu_trip_active_high: active-high {
>   					temperature = <115000>;
>   					hysteresis = <2000>;
>   					type = "active";
>   				};
>   
> -				cpu_trip_active_low: active-low {
> +				cpu_trip_active_med: active-med {
>   					temperature = <85000>;
>   					hysteresis = <2000>;
>   					type = "active";
>   				};
>   
> -				cpu_trip_passive: passive {

Rule of thumb is that each commit has to build on its own: this will break build
because of mt7986a-bananapi-bpi-r3.dts referencing the now unexistant
cpu_trip_passive phandle.

Solving that is simple.
Merge commit [2/3] and [3/3] in a single commit.

Obviously, retain both fixes tags :-)

Cheers,
Angelo

