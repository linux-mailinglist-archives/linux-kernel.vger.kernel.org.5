Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7A778242
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjHJUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjHJUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4092733;
        Thu, 10 Aug 2023 13:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE674649C3;
        Thu, 10 Aug 2023 20:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71169C433C7;
        Thu, 10 Aug 2023 20:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691700043;
        bh=rSop7mtUo0fVzOHPGZwCTWk0QCEHsqpxokmcv5oQRik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ihaai8JMGBeEaVhKzZgO1THthNuHwjwNz5ayoQWfDv9qBcUAs4+jYjHimYtPrdp/V
         jNkYz8WWtJau6tL0NXJf2xDX6Ohvj51I7lJX9QFsRf+porZP876As9/YDvyTOKC3xi
         HhgM8dUEQSh3AZGAqnHRwq+Jd0Ie8t8eDK+qGfhYcOw7ATCzm9DEJjmQdF3isaOICM
         6Q/7g2PuydUAtoRDpp4rOe3bkFbARIZGWSlbhbIERPC0HFhvfrFBwSeDfA3bmz2tMt
         hV74dAdmBX8IgKyg3/Zv9OPUx577a2YSX8djziRBjSCAyvmF8xqVqgMfXjVHdg7pZA
         Sc9g8NNdoyZLw==
Received: (nullmailer pid 1136259 invoked by uid 1000);
        Thu, 10 Aug 2023 20:40:41 -0000
Date:   Thu, 10 Aug 2023 14:40:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4
 board
Message-ID: <20230810204041.GA1135827-robh@kernel.org>
References: <20230810070032.335161-1-Delphine_CC_Chiu@wiwynn.com>
 <20230810070032.335161-2-Delphine_CC_Chiu@wiwynn.com>
 <169165202180.3911788.1110313008758620193.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169165202180.3911788.1110313008758620193.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:20:21AM -0600, Rob Herring wrote:
> 
> On Thu, 10 Aug 2023 15:00:29 +0800, Delphine CC Chiu wrote:
> > Document the new compatibles used on Facebook Yosemite 4.
> > 
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Changelog:
> > v7 - Revise changelog format
> > v6 - Change project name from yosemitev4 to yosemite4
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810070032.335161-2-Delphine_CC_Chiu@wiwynn.com

The bot was having an issue. This can be ignored.

Rob
