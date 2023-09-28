Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9327B2896
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjI1Wtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjI1Wtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:49:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49289180;
        Thu, 28 Sep 2023 15:49:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7121DC433C8;
        Thu, 28 Sep 2023 22:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695941376;
        bh=v0+vkpTY/RLF/EzpXIGRgfx86rBxRuba+sYAoF7Bu6o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vDn45AGf7UUATdgrquYxTLTtfAYRwT9ECykm29dys80QWEZpoK8fo+Mc3967A/80B
         eevEiwNOq8PS2CR6w5O1Qa1HYkDRl9M672vmPmvmoUSJ7VlL4ckAp4ZVEDgS2ybbDx
         9unC1GEdi56xrp7dbPqt4HS7YbTXDLOZNmolHs2IFVbRq6BnRF0ewbXvtzAgqW/05+
         y83SekigV4O86uf2yqMrbo3Kix8xTGbe/riK30NA4ikxGPAqUzjY39M3RiH5v3Dlom
         j/ceddyaqdPwjDaHl4kMq3r4+1AKRF9V5bQqXNAjiFAmp/ENfic0ICK1ahr/ywoG7I
         jy6TVRmfCG/zQ==
Received: (nullmailer pid 1490249 invoked by uid 1000);
        Thu, 28 Sep 2023 22:49:33 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     robh+dt@kernel.org, nm@ti.com, rafael@kernel.org,
        vireshk@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20230928210525.1265958-2-robimarko@gmail.com>
References: <20230928210525.1265958-1-robimarko@gmail.com>
 <20230928210525.1265958-2-robimarko@gmail.com>
Message-Id: <169594137337.1490220.6287570268277812840.robh@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: opp: opp-v2-kryo-cpu: Document
 named opp-microvolt property
Date:   Thu, 28 Sep 2023 17:49:33 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Sep 2023 23:04:05 +0200, Robert Marko wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Document named opp-microvolt property for opp-v2-kryo-cpu schema.
> This property is used to declare multiple voltage ranges selected on the
> different values read from efuses. The selection is done based on the
> speed pvs values and the named opp-microvolt property is selected by the
> qcom-cpufreq-nvmem driver.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v4:
> * Describe PVS
> * Add description for opp-microvolt entries
> ---
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml: patternProperties:^opp-?[0-9]+$:patternProperties:^opp-microvolt-speed[0-9]+-pvs[0-9]+$: {'description': 'Named opp-microvolt property following the same generic\nbinding for named opp-microvolt.\n\nThe correct voltage range is selected based on the values\nin the efuse for the speed and the pvs (power variable\nscaling).\n', 'minItems': 1, 'maxItems': 4, 'items': [{'description': 'nominal voltage'}, {'description': 'minimum voltage'}, {'description': 'maximum voltage'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230928210525.1265958-2-robimarko@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

