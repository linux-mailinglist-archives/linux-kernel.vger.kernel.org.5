Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0C37A633F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjISMkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjISMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:40:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967A2E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:40:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD88C433C8;
        Tue, 19 Sep 2023 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695127214;
        bh=ruaomOsVSPAGgslF/yr7z7NtxZAHZH6/puP8bh0Ggi8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JNjCUw/8qkpApUTCB5VzsXkVhtVx0qCu7Tlf0SZKjNdvfhJu1ru700hGzrvA9TXDc
         LqYti3gGwtrsDXJlDiO+15GqJsBIDQhIjKpoxxmOIsy+kxhIvHEGltCWKbHanU8X3s
         UWMnLyVCJX260FN+by2l35LTfLGbROOWnofDBUabL+P/E8QNyG5/IlOiiXRDyY1F9o
         dV7wNtf9ankEPgR/f1Q7DYV1v/iCjKcezSGlW2ob1y9Iig879geHPd9LwH+bvcN+qh
         j14n49BMl/CNzAnC5yUT16ADitd3tcWpUiY5U5zKdqklrCKFAquQYm/3R1HE8KLTTA
         yGqwfzGfg7Seg==
Received: (nullmailer pid 3475446 invoked by uid 1000);
        Tue, 19 Sep 2023 12:40:11 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230919104357.3971512-3-wenst@chromium.org>
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-3-wenst@chromium.org>
Message-Id: <169512721150.3475200.12254070677030713993.robh@kernel.org>
Subject: Re: [PATCH v3 02/12] regulator: dt-bindings: mt6358: Convert to DT
 schema
Date:   Tue, 19 Sep 2023 07:40:11 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Sep 2023 18:43:45 +0800, Chen-Yu Tsai wrote:
> Convert this from the old style text based binding to the new DT schema
> style. This will make adding the MT6366 portion easier.
> 
> The examples have been trimmed down considerably, and the remaining
> entries now match what is seen in actual device trees, minus some
> properties that aren't covered by the bindings yet, or don't make
> sense on their own.
> 
> The original submitter seems to have left MediaTek, so instead the
> submitter and maintainer for the MT6366 binding is listed.
> 
> Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Added missing end-of-string match to regulator names
> - regulator-coupled-* properties in example dropped
> - #include and regulator-allowed-modes moved to new patch
> 
>  .../regulator/mediatek,mt6358-regulator.yaml  |  97 +++++
>  .../bindings/regulator/mt6358-regulator.txt   | 350 ------------------
>  2 files changed, 97 insertions(+), 350 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml: patternProperties: '^ldo_vxo22$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#]+\\$$'}
	hint: Fixed strings belong in 'properties', not 'patternProperties'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml: patternProperties: '^ldo_vusb$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#]+\\$$'}
	hint: Fixed strings belong in 'properties', not 'patternProperties'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230919104357.3971512-3-wenst@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

