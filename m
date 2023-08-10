Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92768776D79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHJBTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHJBTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1E010E6;
        Wed,  9 Aug 2023 18:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CBDD64D2F;
        Thu, 10 Aug 2023 01:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B74DC433C7;
        Thu, 10 Aug 2023 01:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691630358;
        bh=TB3ObTSE7LxprxKyIdCMl0H38M73hC+gEJTl1bWWpAc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UjtsVNARulJIuPJR2PiHBg8u1sSMi/GgztJCUIAMWtOCKCEkjTSLhZ7t/CPRGrp1P
         ZNAh3trNVsWdvje9GaWu3uCVesPwig8vM1TZhgH31x37v+7MuUqd4IPYNlz5fV4ziK
         WRoDLdcheSSDtZl2jeZ3kOTr/pFf4uJiqvvuW+6hO4nT1t0kSgEmqZAC/0kucBGDm5
         ahyxQl0XFfxY7My0n0J7SPYYex+ymk3OUM84myRl2pm3PRjKi8Coa+t7iEojbSFsQL
         Nv/D4sVM0oO2VhuWejZN9lZoyHpgTgUWh+w46J6R9jADI7yp5DIji/GFJY5GykqNJi
         SWrKG1bRRZJxA==
Received: (nullmailer pid 3365153 invoked by uid 1000);
        Thu, 10 Aug 2023 01:19:16 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     linux-kernel@vger.kernel.org, nm@ti.com, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        kristo@kernel.org, robh+dt@kernel.org
In-Reply-To: <20230810005850.21998-2-hnagalla@ti.com>
References: <20230810005850.21998-1-hnagalla@ti.com>
 <20230810005850.21998-2-hnagalla@ti.com>
Message-Id: <169163035646.3365117.5068119107443331919.robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: remoteproc: k3-dsp: correct
 optional sram properties for AM62A SoCs
Date:   Wed, 09 Aug 2023 19:19:16 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 09 Aug 2023 19:58:46 -0500, Hari Nagalla wrote:
> The C7xv-dsp on AM62A have 32KB L1 I-cache and a 64KB L1 D-cache. It
> does not have an addressable l1dram . So, remove this optional sram
> property from the bindings to fix device tree build warnings.
> 
> Also set the 'memory-regions' property as optional. This is because
> the remote processors can function without carveout regions.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> Changes since v1:
>  - Corrected dsp node binding doc file to fix yamllint warnings for am62a.
> 
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml     | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810005850.21998-2-hnagalla@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

