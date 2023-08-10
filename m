Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43BA778411
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjHJXR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjHJXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:17:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9A2D76;
        Thu, 10 Aug 2023 16:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5275B669FD;
        Thu, 10 Aug 2023 23:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A2AC433C8;
        Thu, 10 Aug 2023 23:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691709469;
        bh=PflT+dpFfXcivxjANA04EvC0KDcMcvIWrxSzmMR+gmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQvlkreFmgQfFzptcYHY5nilAX7QVUMWZMV9Pc25FdEtgQ/n046DKME5jJObrMPFT
         wmdP4ShOvcWFyC2lxZeKTfW8RUxAWe2M63oOG7BgzZbn/qxFFZ3f5gaXkn8Qoe5Ds8
         NBEJr6Dz+Dq43Whr/7H1XXCGU9QGlwsUq+NzuM5oBkEJR6XK/dq8Fkddq+BlUVx2WA
         ueDWlyTR7mZzZbRWugAASa5TodXcZlfRbVdJkj6IBGaiiCawOGu+xVEwoVDRaQ/pL4
         3ERkRNtu2U2kXWq4VTJeU1AzfOmg/YqPUYsteT9u0FQViJ91gCrVMdvTL311VjzVW3
         rYRhva18jOerQ==
Received: (nullmailer pid 1545115 invoked by uid 1000);
        Thu, 10 Aug 2023 23:17:48 -0000
Date:   Thu, 10 Aug 2023 17:17:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Da Xue <da@libre.computer>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: add device for Genesys Logic hub
 gl3510
Message-ID: <20230810231748.GA1543958-robh@kernel.org>
References: <20230808100746.391365-1-jbrunet@baylibre.com>
 <20230808100746.391365-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100746.391365-2-jbrunet@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 12:07:45PM +0200, Jerome Brunet wrote:
> Add gl3510 USB 3 root hub device id
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> index cc4cf92b70d1..a7e7142651f8 100644
> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Genesys Logic GL850G USB 2.0 hub controller
> +title: Genesys Logic USB hub controller
>  
>  maintainers:
>    - Icenowy Zheng <uwu@icenowy.me>
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - usb5e3,608
>        - usb5e3,610
> +      - usb5e3.626

Should be a comma, not a period.

>  
>    reg: true
>  
> -- 
> 2.40.1
> 
