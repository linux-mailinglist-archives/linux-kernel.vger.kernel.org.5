Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4587B4864
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbjJAPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjJAPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:21:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48029DD
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 08:21:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143A1C433C8;
        Sun,  1 Oct 2023 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696173707;
        bh=Pcid93qlZOziU6QAuWsUqgL3T/hz96UA6NSdFcYv2gA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WFRc6ICXH9pmMNC90RDePARwjYzjp/5Ph4dMMzp4HRjMOtXqMoAELm4sAEfBTDmzM
         rYAq29O9nxcaLwIyEeu2VtOGd/KN7CEb0Yk9E3MtL0sFkYgAuYr4MGqY7sG/KBZdcb
         9bSWd5Zu5NwH+PlKkmCNLF/7HzLOtxZeSQCxvkxzloVoAM1XacHvPVW43eK0XaqzOQ
         VrJ7XuszE3Mwo0+ReEm7WSOIQvquuGRzcC09OvId6JUW3WZpRrX5TehaelTjx/+dd3
         IOkizea1pa3ET+FmZHCPXTixP/th2w4OUSP5i7CoQ6g6nlHJjqKy1EPvn9NJXjMWye
         EYm4R6TZbeuSw==
Received: (nullmailer pid 4073099 invoked by uid 1000);
        Sun, 01 Oct 2023 15:21:45 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-phy@lists.infradead.org
In-Reply-To: <20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr>
References: <20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr>
Message-Id: <169617370596.4073083.7671485602396327173.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: Convert PXA1928 USB/HSIC PHY to DT
 schema
Date:   Sun, 01 Oct 2023 10:21:45 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 01 Oct 2023 15:05:43 +0200, Duje Mihanović wrote:
> Convert the binding for the Marvell PXA1928 USB and HSIC PHYs from TXT
> to DT schema.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  .../bindings/phy/marvell,pxa1928-hsic-phy.yaml     | 37 +++++++++++++++++
>  .../bindings/phy/marvell,pxa1928-usb-phy.yaml      | 46 ++++++++++++++++++++++
>  .../devicetree/bindings/phy/pxa1928-usb-phy.txt    | 18 ---------
>  3 files changed, 83 insertions(+), 18 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.example.dts:21.34-35 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/phy/marvell,pxa1928-usb-phy.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231001-pxa1928-usb-yaml-v1-1-9309a8c0c03f@skole.hr

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

