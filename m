Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5857A6B50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjISTQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjISTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:16:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786A7E6;
        Tue, 19 Sep 2023 12:16:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD35C433C7;
        Tue, 19 Sep 2023 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695150982;
        bh=2dBJWJKc/+JVACFXll4TLB57G7St3eiReB7MSo203Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5WMLzdip741vVec0WAqJHL8yELft+IipaDXxYgVLl4ePuOcrSi6XesHpHH7W1SeF
         /RE7zN0GC5ebjfIZYQK9lJ4DKx3XZEUYnBL9j3AQzN90FkPVvt9h+NDoYsF5PXqQfi
         p4NNO04JCbSxPQE17t56I1C/J3CqkBq1p69d5pF8Dnzfpv3Sxuuvw6v6SQcXtdZ9CG
         QuIU7aNY+tTXRDuLKUpKJndgdhi2cY5HpYWpul8xImxYKZQVWqVGUuoSZ0am8k3MtU
         +J+8ivSkb8zVlSDqMcJYXlZ7LzHPa79e5X5U5qm+uVKymbdXQEhyUpA2Ulto0iX/ho
         9IS3aM9Kzo2fg==
Received: (nullmailer pid 49346 invoked by uid 1000);
        Tue, 19 Sep 2023 19:16:19 -0000
Date:   Tue, 19 Sep 2023 14:16:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 5/7] dt-bindings: pinctrl: realtek: add RTD1315E
 pinctrl binding
Message-ID: <169515097893.49290.12821083628902791514.robh@kernel.org>
References: <20230919101117.4097-1-tychang@realtek.com>
 <20230919101117.4097-6-tychang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919101117.4097-6-tychang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Sep 2023 18:11:15 +0800, Tzuyi Chang wrote:
> Add device tree bindings for RTD1315E.
> 
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> ---
> v2 to v3 change:
>     1. Remove if/then condition under the patternProperties
>        "-pins$".
> v1 to v2 change:
>     1. Add a description for RTD1315E.
>     2. Rename realtek,pdrive, realtekmndrive and realtek,dcycle.
>     3. Add a description for PMOS and NMOS driving strength.
>     4. Remove the wildcard in the compatible strings.
>     5. Use '-pins$' to be node name pattern.
> ---
>  .../pinctrl/realtek,rtd1315e-pinctrl.yaml     | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1315e-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

