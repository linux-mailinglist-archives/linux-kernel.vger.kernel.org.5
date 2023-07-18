Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D869A7577BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGRJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjGRJTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D247198B;
        Tue, 18 Jul 2023 02:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B046A614E1;
        Tue, 18 Jul 2023 09:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA20C433C8;
        Tue, 18 Jul 2023 09:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689671977;
        bh=hO5EzDtJUJpNoHo8brEsTUnqJsLjzJEcU/q1SwyRLAg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G56zDGJUEcogP2ywZ1hWd4eZlOhgeum0fkFqMvVLjUBMvMeBD/Ra4HoOUf8TZNRG1
         ybcNSfb9qapMSJcvPNxkS1hMnFUoRZH6sPraUu58jpWdvcQwxdPf7YfjG6L57EsGLI
         vjOLfJFPOmUAWGWBZT+M0ZUTnXHQo7uOwCNxXzUCOj5j+QR1R43Xl6Rn4J1jB6f/is
         6JcGQyt/5fY5o0Wfyoal8JK2IGeknYAq8XUPpR1F2oxFsveIO2RvZM1RS7pGgio87s
         vj0ygsqaXsxa01NOaWzph8jCShGnlmyaJ8AuE7gHzuHuGwM3WDdpPltZ0/R7fVwFFC
         v46/gweYqgvxQ==
Received: (nullmailer pid 343549 invoked by uid 1000);
        Tue, 18 Jul 2023 09:19:35 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Viktar Simanenka <viteosen@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20230718080727.323426-1-viteosen@gmail.com>
References: <20230718080727.323426-1-viteosen@gmail.com>
Message-Id: <168967197544.343533.16496491344005174471.robh@kernel.org>
Subject: Re: [PATCH] TinyDRM display driver for Philips PCD8544 display
 controller
Date:   Tue, 18 Jul 2023 03:19:35 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 11:07:27 +0300, Viktar Simanenka wrote:
> Support for common monochrome LCD displays based on PCD8544 (such as Nokia 5110/3310 LCD) SPI controlled displays.
> 
> Signed-off-by: Viktar Simanenka <viteosen@gmail.com>
> ---
>  .../bindings/display/philips,pcd8544.yaml     |  92 ++++
>  drivers/gpu/drm/tiny/Kconfig                  |  11 +
>  drivers/gpu/drm/tiny/pcd8544.c                | 506 ++++++++++++++++++
>  3 files changed, 609 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/philips,pcd8544.yaml
>  create mode 100644 drivers/gpu/drm/tiny/pcd8544.c
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/philips,pcd8544.example.dts:21.13-23: Warning (reg_format): /example-0/display@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/display/philips,pcd8544.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/philips,pcd8544.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/philips,pcd8544.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/philips,pcd8544.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/philips,pcd8544.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/philips,pcd8544.example.dtb: display@0: Unevaluated properties are not allowed ('write-only' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/philips,pcd8544.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230718080727.323426-1-viteosen@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

