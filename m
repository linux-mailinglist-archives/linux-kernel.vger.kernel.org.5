Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE54475C219
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGUIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjGUIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:54:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA733359F;
        Fri, 21 Jul 2023 01:53:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C91AA660709A;
        Fri, 21 Jul 2023 09:53:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689929632;
        bh=yDavRhK9bOtXKv6o2o89j6GKJ9ipNjcKAv95IXEuXEc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U+uYKlW+oeRYXdBzoqAg8CcwKx/rJ4zThVd3T7McdVyA6IkeZcp16SDUw+z8LvIzJ
         TO5Qg/Fvj6tJEcRSvgyUrMjJw3iR7ZBoQ/AGOhXwPpZWB2Wp+roOg+zZHxjmA75LT0
         z9gEGXzHaNzk1r3FQk2P6HYKlo551mqvyV4fLm3nJN1uulH52p8HRwUa7Kke2Q+IVx
         8OMHRIb5YBXPP/QxR1AL9mepCOROoVaFLq1x/SYgl2uLw7RlO5xS+7xvwmrOLOyvos
         z8WMxS+hNvmudlrDqDDi+RlbR4U3ZPHtK92tpyry0cQIycGRsiWmn/Xrn7pSUwFwmh
         De38lcaHGlVfw==
Message-ID: <651da0fc-2654-afb5-d364-31d97715e66f@collabora.com>
Date:   Fri, 21 Jul 2023 10:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v2 1/7] mfd: mt6358: Add missing registers for LDO
 voltage calibration
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230721082903.2038975-1-wenst@chromium.org>
 <20230721082903.2038975-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230721082903.2038975-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/07/23 10:28, Chen-Yu Tsai ha scritto:
> Most of the LDOs, except the "VSRAM_*" ones, on the MT6358 and MT6366
> PMICs support a finer output voltage calibration within the range of
> +0 mV to +100 mV with 10 mV step. Some of the registers for this
> function are missing from the register table.
> 

Please mention that you're doing this addition *because* you're using
those new definitions right after, and in the regulator driver:

[...]
In preparation for adding support for improved output voltage selection
in mt6358-regulator, add the relevant missing registers for the same.
[...]

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Add the missing ones for MT6358.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   include/linux/mfd/mt6358/registers.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
> index 3d33517f178c..5ea2590be710 100644
> --- a/include/linux/mfd/mt6358/registers.h
> +++ b/include/linux/mfd/mt6358/registers.h
> @@ -262,6 +262,12 @@
>   #define MT6358_LDO_VBIF28_CON3                0x1db0
>   #define MT6358_VCAMA1_ANA_CON0                0x1e08
>   #define MT6358_VCAMA2_ANA_CON0                0x1e0c
> +#define MT6358_VFE28_ANA_CON0                 0x1e10
> +#define MT6358_VCN28_ANA_CON0                 0x1e14
> +#define MT6358_VBIF28_ANA_CON0                0x1e18
> +#define MT6358_VAUD28_ANA_CON0                0x1e1c
> +#define MT6358_VAUX18_ANA_CON0                0x1e20
> +#define MT6358_VXO22_ANA_CON0                 0x1e24
>   #define MT6358_VCN33_ANA_CON0                 0x1e28
>   #define MT6358_VSIM1_ANA_CON0                 0x1e2c
>   #define MT6358_VSIM2_ANA_CON0                 0x1e30

