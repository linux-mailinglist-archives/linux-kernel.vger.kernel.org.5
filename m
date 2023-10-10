Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84E77BFECD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjJJOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjJJOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:11:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419CEB8;
        Tue, 10 Oct 2023 07:11:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE249C433C8;
        Tue, 10 Oct 2023 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696947080;
        bh=jj1+fLJZsCU4ttgJGWE1H7sLG+V4ATAPOgfWeIvsre0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6wAs56Yb0BsoZrPov/aXG2OPjbtjlNNEKin6nfyev5DQYEObqWGXGn/Ol7DOEWvL
         zcGLfLaYK+JRkRWH17ObOGGtHVWuU60hW33JoMfs5X3CBkFfpLCH63JiCndNGn3Hp5
         Hi5D7DwZWB9UIAtL0X+U1GNL3CvfOOyopaYZAhQA8NXZ2zHvM3eF1nsC/U3clFGlM7
         ILlnCSpYJ896+0fWMumCb5ocBMBmxvZF45pvtaD30o7TNYGrTCNa7/LXHrOyTOBYQ+
         3L4OkSK9LI4XBS55fXbyVEf3jNokOmqmiWWWIIsNtEyC3aMLYpHnJ2TvJOxirrIJi2
         DYE6oau2OsB1A==
Received: (nullmailer pid 753400 invoked by uid 1000);
        Tue, 10 Oct 2023 14:11:18 -0000
Date:   Tue, 10 Oct 2023 09:11:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andy.shevchenko@gmail.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v1 02/11] dt-bindings: leds: aw200xx: fix led dt node
 pattern
Message-ID: <20231010141118.GA686993-robh@kernel.org>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-3-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006160437.15627-3-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 07:04:28PM +0300, Dmitry Rokosov wrote:
> AW200XX controllers have the capability to declare more than 0xf LEDs,
> therefore, it is necessary to accept LED names using an appropriate
> regex pattern.
> 
> Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> index feb5febaf361..73b81f7a7258 100644
> --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -42,7 +42,7 @@ properties:
>        Leds matrix size
>  
>  patternProperties:
> -  "^led@[0-9a-f]$":
> +  "^led@[0-9a-f]+$":

There should be some updated constraints on 'reg' too. Actually, looks 
like they were missing altogether. Please add.

>      type: object
>      $ref: common.yaml#
>      unevaluatedProperties: false
> -- 
> 2.36.0
> 
