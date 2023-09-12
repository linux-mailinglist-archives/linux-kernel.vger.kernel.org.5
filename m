Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F15B79D172
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjILMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjILMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:54:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE91C4;
        Tue, 12 Sep 2023 05:54:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DBE3F6607326;
        Tue, 12 Sep 2023 13:54:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694523293;
        bh=2ZOrTSWdVG6ed/ekxU88dRAtYT7IEpOy67CbW6Jz6Ro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U9mrSOCl8o5oUy/F290nNkDTNRLRibjObsvv5WIGzt3R+/gClOcFXuc/Z8jjEm1Wo
         +uXk9WYouTSWzSbtioFmklaV7i+IJIMa8nWoO41eGKPRW18YbqJ5A6/WHz5xHy6Vnd
         OoCGg/f22W/PCOE3BfoQR1E3hZcyk6eulP5yLaeq0lKA8BQ3BVi7DqldOa6YiVv5br
         S/Suhf7K2+jzt826DXYK6NmpKJnBs7h4iuLpnmzGRl3lxGlHUa0kDvLMChrihG/4ax
         IPcQP+VSmaaL7wSwI6lwK+5vYL4aDL4nW9BCddZVQY85kjcMH0Ge93uejT5ln4kJmY
         +qzD3SVHjNXTQ==
Message-ID: <f8759d51-f808-8082-ceaf-6c6dcaebe2d9@collabora.com>
Date:   Tue, 12 Sep 2023 14:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RESEND PATCH] arm64: dts: mediatek: Fix "status" values
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20230804225813.12493-1-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804225813.12493-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/08/23 00:58, Rob Herring ha scritto:
> The defined value for "status" is "disabled", not "disable".
> 
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Arnd, Please take this directly I guess. I think Mediatek maintainership
> needs some help. Maybe AngeloGioacchino should be co-maintainer as
> that's the only response I seem to be getting.

Sorry but I've seen this message just now as I've been on holiday in August.

Thing is, the MediaTek scene is starting to see more and more code, bringing
an obvious increase in the amount of reviews to be done and in the required
efforts to maintain the MTK bits - and we will possibly (hopefully) see even
more of that.

If Matthias needs/wants a co-maintainer for MediaTek I'm here and I will be
proud to become one.

Cheers,
Angelo

> 
> I think for future .dts patches I will not bother splitting them up by
> sub-arch because it's a pain to chase down the maintainers to apply
> stuff in a timely manner. /rant
> 
>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index e4605d23fdc8..86cedb0bf1a9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -585,11 +585,11 @@ &pwrap {
>   };
>   
>   &sata {
> -	status = "disable";
> +	status = "disabled";
>   };
>   
>   &sata_phy {
> -	status = "disable";
> +	status = "disabled";
>   };
>   
>   &spi0 {


