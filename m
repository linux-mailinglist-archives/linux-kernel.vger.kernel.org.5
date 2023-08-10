Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A2776F05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjHJETp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjHJETo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602E110CA;
        Wed,  9 Aug 2023 21:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E70C164DC0;
        Thu, 10 Aug 2023 04:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA18C433C7;
        Thu, 10 Aug 2023 04:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691641182;
        bh=trUtC0Ikk+qyjql4cASs+vqY8v7RGTje0N0Sl0etRKE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rLsEVYtqJJfycHjuKzSpk/LAbdPlIegAUN+6+p/fZ8eZDkkGegr+dqfVf8VuKPxfv
         i4n7lNwguD2HmbLtKg9rfrB7jVqSP3TXzf1LPmwcoDdbPHZqYz7zdjwmYWDwOnf6c9
         TKgBBRTSFFQ90WLrnriF9G16yru2GxfzSfrQgbmf3QsHgOcBl1ONcUesCU/dNbH07t
         bmM+QST1mx+UmHRjLFdZoTTmj4bek6R71EhWT11tJAAfNd7ZsgtH+TAxA+abAT/XAT
         El3P+5sYq632pZXzeheGk1y9tc8PW6Vv816dGhEqDuPx0q4I+I0j8MaBLiqr86iyyV
         yuoELXgQdWTyA==
Received: (nullmailer pid 3618888 invoked by uid 1000);
        Thu, 10 Aug 2023 04:19:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, patrick@stwcx.xyz,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230810034421.742166-2-Delphine_CC_Chiu@wiwynn.com>
References: <20230810034421.742166-1-Delphine_CC_Chiu@wiwynn.com>
 <20230810034421.742166-2-Delphine_CC_Chiu@wiwynn.com>
Message-Id: <169164117998.3618854.8025888421725054954.robh@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite
 4 board
Date:   Wed, 09 Aug 2023 22:19:40 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 11:44:18 +0800, Delphine CC Chiu wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810034421.742166-2-Delphine_CC_Chiu@wiwynn.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

