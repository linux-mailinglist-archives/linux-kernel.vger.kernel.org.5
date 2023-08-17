Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C777FAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353186AbjHQP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353221AbjHQP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:26:54 -0400
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BE8E6B;
        Thu, 17 Aug 2023 08:26:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A1DF3FB03;
        Thu, 17 Aug 2023 17:26:48 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6bQjX7_ypAhh; Thu, 17 Aug 2023 17:26:47 +0200 (CEST)
Date:   Thu, 17 Aug 2023 17:26:45 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     David Heidelberg <david@ixit.cz>
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>, Liu Ying <victor.liu@nxp.com>,
        kernel@puri.sm, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mxsfb: Exclude i.MX8MQ from power-domains
 requirement
Message-ID: <ZN48NYcefTkM4703@qwark.sigxcpu.org>
References: <20230730184120.94984-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230730184120.94984-1-david@ixit.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_FAIL,SPF_HELO_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Jul 30, 2023 at 09:41:20PM +0300, David Heidelberg wrote:
> i.MX8MQ uses as secondary compatible fsl,imx6sx-lcdif, which triggers
> requirement of power-domains, thou it's not required.
> 
> Fixes: f62678a77d58 ("dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.MX6SL power-domains property")
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/display/fsl,lcdif.yaml        | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> index fc11ab5fc465..2d868276b0f9 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -129,8 +129,15 @@ allOf:
>                - fsl,imx8mp-lcdif
>                - fsl,imx93-lcdif
>      then:
> -      required:
> -        - power-domains
> +      if:
> +        properties:
> +          compatible:
> +            not:
> +              contains:
> +                const: fsl,imx8mq-lcdif
> +      then:
> +        required:
> +          - power-domains
>  
>  examples:
>    - |
> -- 
> 2.40.1
> 

Thanks a lot to Marek and Liu for confirming!

Acked-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido
