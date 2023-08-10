Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17EC77712D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjHJHU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjHJHU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72110C;
        Thu, 10 Aug 2023 00:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 615A960AFA;
        Thu, 10 Aug 2023 07:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE94C433C9;
        Thu, 10 Aug 2023 07:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691652025;
        bh=GGJchB0pjs96Duv9owBAcUnHzqV80CzKCVLMP1q2peM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z7z/k9nx9Ma1bhr6Wu6cmraIcVPwvNtJSQXSuKJxjhhbbcqG811Tu85dD7DdwCgo2
         mDEFrpbYpA/pd3/B4vgE/RnoPf1k3KqGtkccldKiL0RuBvcvwI5S4pHoCLUGfjXJ7a
         yqMhKudi9HW3YzuQkJSml3kDoeQ8KHiQkxpQElDpYHHAu7a/EHDybLLVeUe2v5obcd
         /vwtFAwAopq5u+svcZYdbioIR53POw2qLP34eww139WHdQgknJnqxWTwoU3c+lt0wW
         GWJwUPVflu1CPSTc/PjwRr2tlPzZ4g9LZu2WDug8uPI2SK3pY74a3uFUTK+zsig3Kl
         GA1jNDWxQ0oxA==
Received: (nullmailer pid 3911839 invoked by uid 1000);
        Thu, 10 Aug 2023 07:20:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20230810070032.335161-2-Delphine_CC_Chiu@wiwynn.com>
References: <20230810070032.335161-1-Delphine_CC_Chiu@wiwynn.com>
 <20230810070032.335161-2-Delphine_CC_Chiu@wiwynn.com>
Message-Id: <169165202180.3911788.1110313008758620193.robh@kernel.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite
 4 board
Date:   Thu, 10 Aug 2023 01:20:21 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 15:00:29 +0800, Delphine CC Chiu wrote:
> Document the new compatibles used on Facebook Yosemite 4.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changelog:
> v7 - Revise changelog format
> v6 - Change project name from yosemitev4 to yosemite4
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810070032.335161-2-Delphine_CC_Chiu@wiwynn.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

