Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCD47A65FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjISN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjISN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:57:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD5410C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:57:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828CEC433C7;
        Tue, 19 Sep 2023 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695131853;
        bh=JzZ5xVm/GZHS4DZtfSUGhjc20ZbGt4Lo8VFDz2HUIxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSywzAKy5EmPzI8+fCU6TCCtlQGLZbOb4hBye0ZOJsH8VQLW3Ef9YMSqIWDOe/Hwo
         L/KYOEBybNvB6GM2wXfXdFDGn18YM6IKJP3P0WPTEMpNiP62ikXkXJd85jNVuPv6y1
         fQHS/WrOX2gXFj8GtxFBuyeMi/HLiUXOh0794bAdRC+tD0w9R1WhUJls5s81tZhwse
         on+DrlqqHHOEurhINMP28BbrgOC8qPtsgbNO9VljdGhaVa/s2YRpHh+RDakb23nmVd
         0xoZiRaX/zCvq0rPEgPYUxheI7qgkehCxoPqaBajGdsxidvG/pgfSVQ12tgHkkG2rZ
         WPrNEGwetv7DA==
Date:   Tue, 19 Sep 2023 14:57:27 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 01/12] dt-bindings: mfd: mt6397: Split out compatible
 for MediaTek MT6366 PMIC
Message-ID: <20230919135727.GS13143@google.com>
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919104357.3971512-2-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

Please notify me when you apply the other patches in this set and I'll
come back and merge this one.

On Tue, 19 Sep 2023, Chen-Yu Tsai wrote:

> The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
> a different set of regulators. Specifically, it lacks the camera related
> VCAM* LDOs and VLDO28, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.
> 
> The PMICs contain a chip ID register that can be used to detect which
> exact model is preset, so it is possible to share a common base
> compatible string.
> 
> Add a separate compatible for the MT6366 PMIC, with a fallback to the
> MT6358 PMIC.
> 
> Fixes: 49be16305587 ("dt-bindings: mfd: Add compatible for the MediaTek MT6366 PMIC")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 294693a8906c..10540aa7afa1 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -22,8 +22,9 @@ compatible:
>  	"mediatek,mt6323" for PMIC MT6323
>  	"mediatek,mt6331" for PMIC MT6331 and MT6332
>  	"mediatek,mt6357" for PMIC MT6357
> -	"mediatek,mt6358" for PMIC MT6358 and MT6366
> +	"mediatek,mt6358" for PMIC MT6358
>  	"mediatek,mt6359" for PMIC MT6359
> +	"mediatek,mt6366", "mediatek,mt6358" for PMIC MT6366
>  	"mediatek,mt6397" for PMIC MT6397
>  
>  Optional subnodes:
> @@ -40,6 +41,7 @@ Optional subnodes:
>  		- compatible: "mediatek,mt6323-regulator"
>  	see ../regulator/mt6323-regulator.txt
>  		- compatible: "mediatek,mt6358-regulator"
> +		- compatible: "mediatek,mt6366-regulator", "mediatek-mt6358-regulator"
>  	see ../regulator/mt6358-regulator.txt
>  		- compatible: "mediatek,mt6397-regulator"
>  	see ../regulator/mt6397-regulator.txt
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 

-- 
Lee Jones [李琼斯]
