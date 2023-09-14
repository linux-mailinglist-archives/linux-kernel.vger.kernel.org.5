Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199377A0867
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjINPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjINPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:03:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDAD1FC2;
        Thu, 14 Sep 2023 08:03:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6D7C433C9;
        Thu, 14 Sep 2023 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694703810;
        bh=W3Y6Gm9/IGgV579HraWZyIC6jSTAdBWlzF8CdXDvIrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTz0CICJshUvrLKjdU+/bCj2Ns6Qc/YO8MYWzbwNg0PJGPHw/42/3YEBUCF/ekELD
         QFrRldUu1VvTfVbAUkqix6ISsfxCRzYqUCFYtwYbEvQAHMKvSmOrOHXvryIQpk0fFD
         Fc8Wta1JGgYvQHQZLQhsTq+mUh1UgMNDnq5mnUuHrP0Kqg+bKgU6tZm/KN7LoCPH6E
         a/zQgM7I7m/Qz2ldYrZA4CRoqi5LieliP0ZfKLU2oCkkmaeCKsNoIt+0NWkEXDDzMF
         gS2AZS0aGNYP1fXu3mHZLG6aY64RUxaJyL809CKE9MXS3AGs4r8HwEm4JQK4KVGbvC
         rVel0+SPJN4ZA==
Received: (nullmailer pid 1299783 invoked by uid 1000);
        Thu, 14 Sep 2023 15:03:28 -0000
Date:   Thu, 14 Sep 2023 10:03:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93 interrupts
Message-ID: <20230914150328.GA1293008-robh@kernel.org>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
 <20230914-vf610-gpio-v1-1-3ed418182a6a@nxp.com>
 <4520fa76-8645-a438-ba7d-ef50c9781249@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4520fa76-8645-a438-ba7d-ef50c9781249@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:47:29AM +0200, Krzysztof Kozlowski wrote:
> On 14/09/2023 04:20, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > i.MX8ULP and i.MX93 actually has two interrupts for each gpio
> > controller, one for
> 
> ...
> 
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,vf610-gpio
> > +              - fsl,imx7ulp-gpio
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +    else:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 2
> 
> Instead describe the items with "items:" and descriptions.

Except not here, but in the top level 'interrupts' entry.

Rob

