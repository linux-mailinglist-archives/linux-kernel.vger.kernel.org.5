Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1077C7276
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379526AbjJLQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbjJLQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:25:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE69E3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:25:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCC2C433C8;
        Thu, 12 Oct 2023 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697127924;
        bh=9feK3ItMeeWwJ7VIPlyWwFyXf9aBwpQbldW6FpaCPok=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MmifaNqVW0KF2jEk/QREfOeHUJJUTjUuR3z0Y7YzK/2lxDPf9rHQGgKgaHY65EXWd
         6A37+tC0FyDH0IMKT7Ape4MnoBEOrVGKvU4RIsui53qz7heLWtCnPICUmj+yprUCuc
         y/lmrDPTmwebPd65iJ+2z2dEr03L1Hpcz3dlzsPShupRgJsA9uNtbI5kUJgFNBtn7d
         dghuOJvsMkZXBhaHMk6fu7dC8hFFs0XdZmdQ5Bb22ZpEtUP8bd6Zg/l9lpQXRVsRPB
         8aRf5Ww2EVmOdoQ2W1uN02GQAhG+B8FMklmXGFFe2AFvS9TU9Ce270JNi0ElWgr3vt
         sYha2tz+uzW0Q==
Received: (nullmailer pid 1188735 invoked by uid 1000);
        Thu, 12 Oct 2023 16:25:22 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, kernel@collabora.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231012151538.468893-1-eugen.hristev@collabora.com>
References: <20231012151538.468893-1-eugen.hristev@collabora.com>
Message-Id: <169712792200.1188719.6103742227495646067.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: arm: mediatek: convert audsys and
 mt2701-afe-pcm to yaml
Date:   Thu, 12 Oct 2023 11:25:22 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Oct 2023 18:15:38 +0300, Eugen Hristev wrote:
> Convert the mediatek,audsys binding to YAML, together with the associated
> binding bindings/sound/mt2701-afe-pcm.yaml .
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> Changes in v3:
> - not added Rb Conor Dooley since the patch was changed in a big essence
> - As per review by Krzysztof, also convert the mt2701-afe-pcm and reference
> the correct schema in the audsys binding.
> 
> Changes in v2:
> - remove comment reference to inexistent binding
> 
> 
>  .../bindings/arm/mediatek/mediatek,audsys.txt |  39 ---
>  .../arm/mediatek/mediatek,audsys.yaml         | 153 ++++++++++++
>  .../bindings/sound/mt2701-afe-pcm.txt         | 146 -----------
>  .../bindings/sound/mt2701-afe-pcm.yaml        | 229 ++++++++++++++++++
>  4 files changed, 382 insertions(+), 185 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/mt2701-afe-pcm.yaml:11:4: [error] missing starting space in comment (comments)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231012151538.468893-1-eugen.hristev@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

