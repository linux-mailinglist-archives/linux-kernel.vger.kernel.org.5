Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3010E7C8416
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjJMLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMLJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:09:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828AD91
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:09:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E240C433C8;
        Fri, 13 Oct 2023 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697195350;
        bh=le+2qGTCU1t+l8JNaHTYW0wqbcQZU/JZA582Ub2H9/k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MACYzMfx8sEglf6T2OY6eGNLR1drRbk8bdeU/kbbWrplHpJ9NJMOH6ttGFxieOfvv
         SHW1iFesy7aWFZoUMynFWQEXzBVmDToN8Ed3nb8e+CazabhuG1aobve+21TepOZGzL
         uUu0wxEsufiaEGoh6P2LTajcrkQstcK2GhG5Jc4uaqGNy0NDQJf9OX+segg61sdzkf
         61yhkNV0oBEx4ORnuPAstcJplM+vgPLq4zwYSxtVpM4uv/UnN6pRcy8mFzws5ZGLxx
         D6X7KS1UGsEi4nS+faaHIfKcTq3TK2BuEkaEVffH+SjOqgdi+7pOCYNl6ldcI1yFX6
         suIETj7z8anQg==
Received: (nullmailer pid 3388714 invoked by uid 1000);
        Fri, 13 Oct 2023 11:09:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
Cc:     devicetree@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org,
        srinivas.kandagatla@linaro.org
In-Reply-To: <20231013101450.573-3-praveen.teja.kundanala@amd.com>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
 <20231013101450.573-3-praveen.teja.kundanala@amd.com>
Message-Id: <169719534802.3388697.15453927606673268163.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt
 to yaml
Date:   Fri, 13 Oct 2023 06:09:08 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Oct 2023 15:44:47 +0530, Praveen Teja Kundanala wrote:
> Convert the xlnx,zynqmp-nvmem.txt to yaml.
> 
> Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
> ---
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 46 ---------------
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml     | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
>  create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml:18:11: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231013101450.573-3-praveen.teja.kundanala@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

