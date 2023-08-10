Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2A777034
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjHJGUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjHJGUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B216E5F;
        Wed,  9 Aug 2023 23:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFD2764FE7;
        Thu, 10 Aug 2023 06:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76573C433C8;
        Thu, 10 Aug 2023 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691648401;
        bh=ybQOwv3Oh8WC8k0+x3nqrATf7Zobodt21rXmGAujRVo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WLHxWTmiMb7m5m+hc+a3kZ3mpGQwusrMlid/tOdX5Bbp6J4MxgZokaWlHrmrVUG3/
         dOpSh+aSdrYcWs8FSrCrkkpBocsjo0LdmfWJk8RB6o0kgCwyBlLtbto5Oe02Npimpi
         GEuo5UC/VztS5jQiDpmvGE3eB1PVrpHlnbOThsN2Owk7jX1KTsTplnzD4pNM2Ccl1Z
         7F7f57vHlgxYw5aCNokBCYVm9ORCMpDpS3rhVfALIMx17pbJLDswoQJcqgC2Wzo/tj
         GG7yXpl8/Udk7MRiBWeY9H3jffqlVrjzd8sFYCDHD+EvusZREKvzfgMrta2guinvMD
         0AfbmQpn46+LQ==
Received: (nullmailer pid 3794146 invoked by uid 1000);
        Thu, 10 Aug 2023 06:19:59 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230810055440.3534-2-stanley_chang@realtek.com>
References: <20230810055440.3534-1-stanley_chang@realtek.com>
 <20230810055440.3534-2-stanley_chang@realtek.com>
Message-Id: <169164839935.3794130.5447014051711637044.robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC
 DWC3 USB
Date:   Thu, 10 Aug 2023 00:19:59 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 13:54:35 +0800, Stanley Chang wrote:
> Document the DWC3 USB bindings for Realtek SoCs.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3 change:
>     Add description for reg
>     Remove property for realtek,unlink-usb3-port.
>     Remove property for realtek,disable-usb3-phy.
>     Use the maximum-speed instead of the above two properties.
> v1 to v2 change:
>     Revise the subject.
>     Rename the file.
>     Fix dtschema warnings.
>     Remove the property realtek,enable-l4icg.
>     Drop status.
> ---
>  .../bindings/usb/realtek,rtd-dwc3.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810055440.3534-2-stanley_chang@realtek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

