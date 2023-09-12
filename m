Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A782879D622
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjILQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjILQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:21:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076310D;
        Tue, 12 Sep 2023 09:21:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC4AC433C8;
        Tue, 12 Sep 2023 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694535685;
        bh=4hOm+2OJehvueAvzDQRvNaUQyTECGiJcEkEuYx0W5Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQkFWGdpQipDRXUX/TXqCdZCefG/lNErl9W+iLkCzCkCQatTcSH5PH/xEEtwyYk4m
         0t5P4ERwzAczSVRzz5T04qokwZCI2pFmBZmPY5gOSUTQ+CQrfp1KnzAEWowaW8XVk8
         t13ClcE3LCMA0qSWwD9DqI1gcS4+FdOUGLUvnDVpvG4P8SHkUosEFbH7gstyV5bY/2
         5dHPsfG1sbLW312Xcy4aAepu3fVjMaxELKvsa4EWGTgdMaQr2dkNt1EU+rMYpDkfVB
         RPFh6TIbIJCpWa0etojhH0vL941RKx1+UAKX8O3iK+1cvt35pRHtUVxPSpAXa1YHya
         hVQqCHjtT0zaw==
Received: (nullmailer pid 885111 invoked by uid 1000);
        Tue, 12 Sep 2023 16:21:22 -0000
Date:   Tue, 12 Sep 2023 11:21:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        shumingf@realtek.com, ckeepax@opensource.cirrus.com,
        herve.codina@bootlin.com, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, fido_max@inbox.ru,
        povik+lin@cutebit.org, arnd@arndb.de,
        harshit.m.mogalapalli@oracle.com, liweilei@awinic.com,
        yijiangtao@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/5] ASoC: dt-bindings: Adds properties to
 "awinic,aw88395"
Message-ID: <20230912162122.GA880119-robh@kernel.org>
References: <20230912065852.347000-1-wangweidong.a@awinic.com>
 <20230912065852.347000-2-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912065852.347000-2-wangweidong.a@awinic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 02:58:48PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>

The subject is still pretty generic. Ideally, we'd never have the same 
subject twice. I'd do something like this:

ASoC: dt-bindings: awinic,aw88395: Add properties for multiple PA support

> 
> Adds properties to "awinic,aw88395" to make files more complete

Complete in what way? multiple PAs, right. It's not really clear 
to me though how these properties enable support for multiple PAs.

> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../bindings/sound/awinic,aw88395.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> index 4051c2538caf..4965aa4a5370 100644
> --- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> +++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
> @@ -32,11 +32,28 @@ properties:
>    reset-gpios:
>      maxItems: 1
>  
> +  awinic,audio-channel:
> +    description:
> +      It is used to distinguish multiple PA devices, so that different
> +      configurations can be loaded to different PA devices
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +
> +  awinic,sync-flag:
> +    description:
> +      Flag bit used to keep the phase synchronized in the case of multiple PA
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1
> +
>  required:
>    - compatible
>    - reg
>    - '#sound-dai-cells'
>    - reset-gpios
> +  - awinic,audio-channel
> +  - awinic,sync-flag
>  
>  unevaluatedProperties: false
>  
> @@ -51,5 +68,7 @@ examples:
>              reg = <0x34>;
>              #sound-dai-cells = <0>;
>              reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
> +            awinic,audio-channel = <0>;
> +            awinic,sync-flag = <0>;
>          };
>      };
> -- 
> 2.41.0
> 
