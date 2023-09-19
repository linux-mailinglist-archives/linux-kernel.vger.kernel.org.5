Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A527A6B54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjISTR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjISTR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:17:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D38B3;
        Tue, 19 Sep 2023 12:17:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65F9C433C8;
        Tue, 19 Sep 2023 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695151041;
        bh=n02489mUNl/0R12Yc0s9p+3ObxDVOgscmi2laCeL04I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFAfbLxsrm3mRsO7rdjY3PX8HGPn8MZfMNJcpPFViXZftCbFmXJIW6Sg7Nb+881J0
         KqxX29GbU4O2SNRL6LhKmZPBVyiYUKVcbhvmOLJtNi6y7nEFgQb/+NHqkwrxYpIgtU
         0XZDwcSxio/n/Vsb1WbXt0yuGstStdCTL1/qP0GkViEcJ0bvvYCrCY3zp8raQ+AYVw
         yffdgaYt+zU4BUenYjepH7evoqH1fmgCvPkO3OwRmzXqggZeKZNkmUKjXzB6uAGPNk
         L1m6/MmNWiBZtzsEz04TBx1j11FgviGimVagV4wRs+2fGvEkZ44btXUkaR37Iq18zH
         hbs9/8zKsFD0Q==
Received: (nullmailer pid 50528 invoked by uid 1000);
        Tue, 19 Sep 2023 19:17:19 -0000
Date:   Tue, 19 Sep 2023 14:17:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: pinctrl: realtek: add RTD1319D
 pinctrl binding
Message-ID: <169515103907.50473.10305858283838262730.robh@kernel.org>
References: <20230919101117.4097-1-tychang@realtek.com>
 <20230919101117.4097-7-tychang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919101117.4097-7-tychang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Sep 2023 18:11:16 +0800, Tzuyi Chang wrote:
> Add device tree bindings for RTD1319D.
> 
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2 to v3 change:
>     1. Use '-pins$' to be node name pattern.
>     2. Remove if/then condition under the patternProperties
>        "-pins$".
> v1 to v2 change:
>     1. Add a description for RTD1319D.
>     2. Rename realtek,pdrive, realtekmndrive and realtek,dcycle.
>     3. Add a description for PMOS and NMOS driving strength.
>     4. Remove the wildcard in the compatible strings.
>     5. Use '-pins$' to be node name pattern.
> ---
>  .../pinctrl/realtek,rtd1319d-pinctrl.yaml     | 187 ++++++++++++++++++
>  1 file changed, 187 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1319d-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

