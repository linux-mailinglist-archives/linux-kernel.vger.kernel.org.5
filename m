Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12D811C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442148AbjLMSSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjLMSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:18:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F170AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:18:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670E5C433C7;
        Wed, 13 Dec 2023 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702491524;
        bh=VmD4PSEal/Oz36jy5f+5kaRai9u7pyp8fynzdDmI2do=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=X2P92CgdOxQRlOF6Y/p2g5JD1pkpHumiiu9p5GDFPCiLmujjHvpYytSN41+m+dFbM
         LPf5Fcv5lFuMzDJb7YIYytx5y3jShptvJAUD3lox1shQM+eGRGvAK/IWDCNsbqpKCq
         nF191Vv4/8qxf+i5UjcXUNEjGbZqMPoLzvXAQpnbV9BFN7vlzDMtZMVx4SMZ8fIuNs
         Ffws+/iE/wjlT7ufm7QnqblkO7NomQZk22M6/MWNlp0dgUgn1EbrPkfoFgtuWTTx/2
         oSb2w4EBkFOXrY4I/yfFIbRQ5KloinB/P3cxzOrlhbN+W5DKTgSPHVLlw1RzW6T92Q
         +o/7nl5bbZt8A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Dec 2023 20:18:35 +0200
Message-Id: <CXNEVH8BZUJT.1UHVUI66SZMTE@suppilovahvero>
Cc:     <patrick.rudolph@9elements.com>, <vincent@vtremblay.dev>,
        <peteryin.openbmc@gmail.com>, <lakshmiy@us.ibm.com>,
        <bhelgaas@google.com>, <naresh.solanki@9elements.com>,
        <alexander.stein@ew.tq-group.com>, <festevam@denx.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <geissonator@yahoo.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: arm: aspeed: add IBM system1-bmc
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ninad Palsule" <ninad@linux.ibm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <johannes.holland@infineon.com>, <linux@roeck-us.net>,
        <broonie@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-2-ninad@linux.ibm.com>
In-Reply-To: <20231212164004.1683589-2-ninad@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 12, 2023 at 6:39 PM EET, Ninad Palsule wrote:
> Document the new compatibles used on IBM system1-bmc
>
> Tested:

this not very useful line :-) (nit)

>     This board is tested using the simics simulator.

Just leave this (w/o indentation)

>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  Documentation/devicetree/bindings/trivial-devices.yaml   | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 6f7543463d89..ebebe14c42aa 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -85,6 +85,7 @@ properties:
>                - facebook,yosemite4-bmc
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
> +              - ibm,system1-bmc
>                - ibm,tacoma-bmc
>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 441b55723675..b12a60d2eb0f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -135,6 +135,8 @@ properties:
>            - ibm,cffps1
>              # IBM Common Form Factor Power Supply Versions 2
>            - ibm,cffps2
> +            # Infineon barometric pressure and temperature sensor
> +          - infineon,dps310
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IR38060 Voltage Regulator

BR, Jarkko
