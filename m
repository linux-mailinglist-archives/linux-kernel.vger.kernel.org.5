Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C347853C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjHWJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjHWJTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0B13AB0;
        Wed, 23 Aug 2023 02:08:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6042865A98;
        Wed, 23 Aug 2023 09:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0160C433C8;
        Wed, 23 Aug 2023 09:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692781720;
        bh=H4akoTsFqgDveGtXgAv0yH52y77xn/v60Efi9ZHUW+o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lEvfAdLHwqQIfmwZEt7iDPX5wRYFubMK/7NWmhTfAq1HWhIpEky0F1l6hiyXcHgfP
         Qk6kdt6NHjs/lgL27WisLr5Sd3eqYIvURXjtMxN01TIoX0SOaQb9e+TZjAJPZcqWk8
         +7x4JOt8S3lYUXwLEfVIj2oLyQm7Zf+3vXkFh5CUCYO1HhJIyYFnvzuSQMw3LOeLUF
         SWyjXAuIigv/VP+4XN9RULymXb/zL/5pxGNvQl+QGFuruFb67YrQA0DecF9UWHlSD0
         GriuVtEkZK6xfydSfIOlgUjnul3VsfGqov+kyu8+nPqhuYEOcLAm5Q40XkoxLQo3pW
         dZz8lsgjelfOw==
Received: (nullmailer pid 1524828 invoked by uid 1000);
        Wed, 23 Aug 2023 09:08:37 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20230823081500.84005-2-krzysztof.kozlowski@linaro.org>
References: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
 <20230823081500.84005-2-krzysztof.kozlowski@linaro.org>
Message-Id: <169278171739.1524810.6441506448861500441.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: display: novatek,nt35950: define
 ports
Date:   Wed, 23 Aug 2023 04:08:37 -0500
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2023 10:14:59 +0200, Krzysztof Kozlowski wrote:
> The panel-common schema does not define what "ports" property is, so
> bring the definition by referencing the panel-common-dual.yaml. Panels
> can be single- or dual-link, thus require only one port@0.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Use panel-common-dual
> 
> Changes since v1:
> 1. Rework to add ports to device schema, not to panel-common.
> ---
>  .../devicetree/bindings/display/panel/novatek,nt35950.yaml     | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/novatek,nt35950.example.dtb: panel@0: False schema does not allow {'compatible': ['sharp,ls055d1sx04', 'novatek,nt35950'], 'reg': [[0]], 'backlight': [[4294967295]], 'reset-gpios': [[4294967295, 94, 0]], 'avdd-supply': [[4294967295]], 'avee-supply': [[4294967295]], 'dvdd-supply': [[4294967295]], 'vddio-supply': [[4294967295]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@1': {'reg': [[1]], 'endpoint': {'remote-endpoint': [[4294967295]]}}}, '$nodename': ['panel@0']}
	from schema $id: http://devicetree.org/schemas/display/panel/novatek,nt35950.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230823081500.84005-2-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

