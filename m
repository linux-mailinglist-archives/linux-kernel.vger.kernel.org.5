Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B857B5DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjJBXd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJBXd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:33:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE6B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:33:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BE1C433C7;
        Mon,  2 Oct 2023 23:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696289604;
        bh=x7E5rRwIO9QzR2zAUVHOPZNxzyfVQczJI3WiJU6auLM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=M4d6wjuAVuXg/vxLhw6h0arwR2nr6kVBjfBVz4C3044a8Erf3OEPA7H5iELfe1hQ6
         xsKXNMEchKBjug/iYewoGySgyoWCjhQYCAE3YPcfzb+GEu59RvZgAr6As+UkmiF68Q
         JisCP5stZBK8fwmU6Hjg1tilrjC4oKDASSzQp9MuQhlRIl8VVc6pJgvQjlxE/cfao7
         E1FAYmDmvXO2JgAYBqIDpeXgtgqS0BrKrapLGsrH4nOJmZc7cqbgRfytYNGq4rMVk6
         YyxwC7cLRsx3lm3ItR6y7UNXQgDaBTreHEem4p8Bdtn60E7g7F6Xmw97HxGJohH2bg
         fyEbZILG86HIg==
Received: (nullmailer pid 2855035 invoked by uid 1000);
        Mon, 02 Oct 2023 23:33:21 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Shawn Anastasio <sanastasio@raptorengineering.com>
Cc:     Timothy Pearson <tpearson@raptorengineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <8b014f8b302f8b41c45c4f6fb114cf18e84a76fa.1696285339.git.sanastasio@raptorengineering.com>
References: <cover.1696285339.git.sanastasio@raptorengineering.com>
 <8b014f8b302f8b41c45c4f6fb114cf18e84a76fa.1696285339.git.sanastasio@raptorengineering.com>
Message-Id: <169628960125.2855019.8844044849290949450.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: sie,cronos-cpld: Add initial DT
 binding
Date:   Mon, 02 Oct 2023 18:33:21 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 02 Oct 2023 17:32:21 -0500, Shawn Anastasio wrote:
> The SIE Cronos Platform Controller CPLD is a multi-purpose platform
> controller that provides both a watchdog timer and an LED controller. As
> both functions are provided by the same CPLD, a multi-function device is
> exposed as the parent of both functions.
> 
> Add a DT binding for this device.
> 
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> ---
>  .../bindings/mfd/sie,cronos-cpld.yaml         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sie,cronos-cpld.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/sie,cronos-cpld.example.dts:20.11-24: Warning (reg_format): /example-0/cpld@3f:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/mfd/sie,cronos-cpld.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/sie,cronos-cpld.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/sie,cronos-cpld.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/sie,cronos-cpld.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mfd/sie,cronos-cpld.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/8b014f8b302f8b41c45c4f6fb114cf18e84a76fa.1696285339.git.sanastasio@raptorengineering.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

