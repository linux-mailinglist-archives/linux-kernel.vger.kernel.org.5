Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9514D777E16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjHJQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjHJQVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:21:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7A8270E;
        Thu, 10 Aug 2023 09:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1502A662F0;
        Thu, 10 Aug 2023 16:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCDDC433CA;
        Thu, 10 Aug 2023 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691684497;
        bh=lEKql8+vNOvT3PVTTDq2YEYXsHM2wKRCKSo4hM72quc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rwcTsvzgxpHJKEXDpPjhSIwq3guyZlltoXOyBQLY3GG4KVTE5zUkVjkLsjOPyj2ei
         WQN4eOeICL4iVLRGZWhqhwMLtaNhtPnrOffjutkLhGCVtGrgXbohvzQxA0aVTJ4CZG
         vXre1mRyO0tz3Q13ip6bBy0P6vE9UjuSz3v2UDSX7jT9X6eanbunmOaBfQ+lhOIPFC
         GO2q4oHg8QzODusO+2KO39INa1nX+TfUoV+WrGp1NBYrYxFt0aSOUJt3t/QvFkgUbI
         O3ZpRqa6TgNpFrDkBDVjUMWG+WMuRo/KEQiHWnpFLzboec04TjHfwIwhY6h7j2ZFiw
         /wM+t41Xo8ggw==
Received: (nullmailer pid 480249 invoked by uid 1000);
        Thu, 10 Aug 2023 16:21:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230810144116.855951-2-luca.ceresoli@bootlin.com>
References: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
 <20230810144116.855951-2-luca.ceresoli@bootlin.com>
Message-Id: <169168448913.480168.11890907861387742608.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: Add panels based
 on ILITEK ILI9806E
Date:   Thu, 10 Aug 2023 10:21:30 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 16:41:15 +0200, Luca Ceresoli wrote:
> Add bindings for LCD panels based on the ILITEK ILI9806E RGB controller
> connected over SPI and the "ShenZhen New Display Co NDS040480800-V3"
> 480x800 panel based on it.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v2:
>  - remove T: line form MAINTAINERS entry
>  - reference spi-peripheral-props.yaml
>  - add 'maxItems: 1' to reg
>  - use unevaluatedProperties
>  - remove out of scope backlight node
> ---
>  .../display/panel/ilitek,ili9806e.yaml        | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810144116.855951-2-luca.ceresoli@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

