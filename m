Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7775E0EC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGWJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:29:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA98E5E;
        Sun, 23 Jul 2023 02:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B74D60C80;
        Sun, 23 Jul 2023 09:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABC8C433C8;
        Sun, 23 Jul 2023 09:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690104569;
        bh=jJ5OqocH6H6RTXRPwl1ijcDVdgQPxVAgCpfaIurlLgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QXaDGg3z2iMyrx2I3JXd91PKwm46WlZY7lcRY/ighrIrBsyV0IOM+X2nHdWzxq22p
         +20/6NIhr0WVVRSDp6NQ148MpfWWTwYbwfJpetH+Owc6e/EeqntR/Q77wXSETCA9lZ
         mZB4JVKHyhQNDZxijzowuwEY+VlmdJibkZAy3edsym5+AiKfp8lT3Ua5foSSQDT6+L
         1hUuz+9fFGxmaQ2Nw1iUm9lZZFYfGk4rbY6VknVshVGh/0U1Gr6zXFRYSH6u53FN8o
         NPRlT2ADD34JXo0JEZAuSvql2NErUTZa8fN/kAadBcR4GklR76jUtZyVwh86ijmx2a
         fSLVjmAryHUTg==
Date:   Sun, 23 Jul 2023 10:29:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     lorenzo@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@puri.sm, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: imu: st,lsm6dsx: add mount-matrix
 property
Message-ID: <20230723102925.3d5f1c40@jic23-huawei>
In-Reply-To: <20230721103410.575555-1-martink@posteo.de>
References: <20230721103410.575555-1-martink@posteo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 10:34:10 +0000
Martin Kepplinger <martink@posteo.de> wrote:

> Add the mount-matrix optional property to the binding since it's supported
> and very useful when using the chip on a board.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Hi Martin,

A question on the example.

> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index b39f5217d8ff..443dce326c5e 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -93,6 +93,9 @@ properties:
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix
> +
>  required:
>    - compatible
>    - reg
> @@ -114,6 +117,9 @@ examples:
>              reg = <0x6b>;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_EDGE_RISING>;
> +            mount-matrix =  "1",  "0",  "0",
> +                            "0",  "1",  "0",
> +                            "0",  "0", "-1";

That's not a rotation matrix - so it's not a valid example...
IIRC it's a rotoinversion (determinant -1 whereas should be 1 for
a rotation matrix)
If a device is doing this we have a disagreement wrt to whether
it is using a left or right handed axis - which is a problem, though
one that is tricky to fix without causing people all sorts of problems..

Jonathan


>          };
>      };
>  ...

