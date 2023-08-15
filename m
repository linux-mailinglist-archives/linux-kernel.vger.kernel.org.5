Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3E77C64F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjHODRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 23:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjHODOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:14:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB31E52;
        Mon, 14 Aug 2023 20:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E29631F2;
        Tue, 15 Aug 2023 03:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD6BC433C7;
        Tue, 15 Aug 2023 03:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692069283;
        bh=aEqYKksjhQLir8WG8R1TLcbnRt6Stl4Lku02MnI04Ug=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uEdUxtiX1ir6k+G7ttFJmF9hwx1EtNyLNlhCZ0obnCAs5e+VJx6LA01LWZ49LeT6e
         RB6mur83O4fp832cGUILaYsFrufmapQCKs1Oy4pLHVIuptyxmr3MqblWk6HAlYCYDX
         /ixIcEWz8v+3F9G/xayocmnc3jDwqgSJCp4Dqd0RtFAYXPeGInol2AjbXMxVSR+ZDY
         YyQ0G66vSI2/H4zQ6fN3xq9xowVu76jMkAxCLg0nOFZ9gHUj8Iy6tb0SuJFsLVSmrH
         g1fX/FrQF33Ce2RyQ9GDyKm9KiiJtzir+d87IzakbJGIbM1otkcdW9PPCyu8M2atRk
         W1YRfFQ3OGJlg==
Received: (nullmailer pid 3595615 invoked by uid 1000);
        Tue, 15 Aug 2023 03:14:41 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     like@awinic.com
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        liweilei@awinic.com, devicetree@vger.kernel.org,
        wangweidong.a@awinic.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, liangdong@awinic.com, broonie@kernel.org,
        conor+dt@kernel.org
In-Reply-To: <20230815020044.2159900-3-like@awinic.com>
References: <20230815020044.2159900-1-like@awinic.com>
 <20230815020044.2159900-3-like@awinic.com>
Message-Id: <169206928174.3595586.4376041388738556088.robh@kernel.org>
Subject: Re: [PATCH v3 2/2] regulator: dt-bindings: Add Awinic AW37503
Date:   Mon, 14 Aug 2023 21:14:41 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Aug 2023 02:00:44 +0000, like@awinic.com wrote:
> From: Alec Li <like@awinic.com>
> 
> Add aw37503 regulator device-tree binding documentation.
> 
> Signed-off-by: Alec Li <like@awinic.com>
> ---
>  .../bindings/regulator/awinic,aw37503.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.example.dtb: regulator@3e: outp: Unevaluated properties are not allowed ('enable-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/awinic,aw37503.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.example.dtb: regulator@3e: outn: Unevaluated properties are not allowed ('enable-gpios' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/awinic,aw37503.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230815020044.2159900-3-like@awinic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

