Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4737786F25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbjHXMcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbjHXMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9831BE2;
        Thu, 24 Aug 2023 05:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E8B659E0;
        Thu, 24 Aug 2023 12:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E60FC433C7;
        Thu, 24 Aug 2023 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692880329;
        bh=SUzUUFl1K+83knbejMOV4zUPz014soAlokca4RuHqJ8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QO/v9hxDAsr2gNRtnqHkLtxIU/+pcWkefL5cZ21hpE3XLVLHUQXQfXWwZ0Uq3YCgp
         azvAz3Hefb05qocd8YwFCHzw9CnrGFT0Y4LsiJZ0YXLeMKMSCzTBxePWiSCkLMViwB
         6CPzlQfLch0VK63CrKCag5vrlQcH6xHiPB5hbPE2e0Z853mwv21sSZEB6EyrSWXMMx
         El2g2g2OQ0dTzl0yIvoSWDe4IeK7JNwoYsWJ8bybmyJIii1BYmbwBmy44Q0F21O/pb
         r1gRB7ESQ2wrcMSt7cW6Fx8Kx5hIQ+rzcH4q41sKtBHmw6bog1t5m0vdFimOYbPUii
         3xTqfqqOPgG4w==
Received: (nullmailer pid 532809 invoked by uid 1000);
        Thu, 24 Aug 2023 12:32:06 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Martin_Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Cc:     benjamin.tissoires@redhat.com, arnd@arndb.de, axboe@kernel.dk,
        andriy.shevchenko@intel.com, nipun.gupta@amd.com,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        quic_jhugo@quicinc.com, jacek.lawrynowicz@linux.intel.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        mathieu.poirier@linaro.org, masahiroy@kernel.org,
        linus.walleij@linaro.org, tzimmermann@suse.de,
        devicetree@vger.kernel.org, ogabbay@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        damien.lemoal@opensource.wdc.com, linux@zary.sk,
        yangyicong@hisilicon.com, robh+dt@kernel.org
In-Reply-To: <20230824111015.57765-4-m.zatovic1@gmail.com>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
 <20230824111015.57765-4-m.zatovic1@gmail.com>
Message-Id: <169288032637.532792.16229113254951089494.robh@kernel.org>
Subject: Re: [PATCHv5 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand
 controller
Date:   Thu, 24 Aug 2023 07:32:06 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Aug 2023 13:10:14 +0200, Martin Zaťovič wrote:
> GPIO bitbanged Wiegand controller requires definitions of GPIO lines to be
> used on top of the common Wiegand properties. Wiegand utilizes two such
> lines - DATA0(low data line) and DATA1(high data line).
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-gpio.yaml        | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/wiegand/wiegand-gpio.example.dts:20.21-29.11: Warning (unit_address_vs_reg): /example-0/wiegand@f00: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230824111015.57765-4-m.zatovic1@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

