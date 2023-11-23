Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9055A7F65E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjKWSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjKWSC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:02:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEB10D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:03:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCA9C433C8;
        Thu, 23 Nov 2023 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700762585;
        bh=nuppog5gHM5PDdmOf0v6VeS1jwQuAhpresQvggmV4bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJ61VMyvko7QS9/SGSXmW+7k2SIUFTWVAOhWXRnNDB29CULQ3Sl73hQSpDFcm/HU4
         dLIeOY6KaNugid4myURGXb8kVIoELKiWeY8W/wUAYTZLBK7PBSfo98/bObspjxb/U0
         UdIbyLVQN0fBW25Ekbn9YfA8t6lSAAl2wabSHpth68uRqfw+nB0cpRO1r/IoRPKKh2
         MHAhtYfYFFTSGa8PrgdvL1kfpopFX1ZvTEDG5ql2g3+sjl9zpsDs1IeDjmUc8mrwMt
         rbziIftMB094bNgVretH/dzHYVgAKDxl+gQ/F/rAuctAfrHgDuUGKKSNV5ZYl0Q4Pk
         1zCMY7vqNE8yQ==
Date:   Thu, 23 Nov 2023 18:02:58 +0000
From:   Conor Dooley <conor@kernel.org>
To:     mitrutzceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: adc: add AD7173
Message-ID: <20231123-ninth-joylessly-89e8531cf756@spud>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K9w0PSfQdN+TWI+G"
Content-Disposition: inline
In-Reply-To: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K9w0PSfQdN+TWI+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Yo,

This looks a lot better IMO, thanks.

On Thu, Nov 23, 2023 at 05:23:21PM +0200, mitrutzceclan wrote:
> +patternProperties:
> +  "^channel@[0-9a-f]$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false

> +      bipolar:
> +        type: boolean

This should be defined in adc.yaml, so duping it here is not needed?

> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: adi,ad7173-8
> +    then:
> +      properties:
> +        refin2-supply: false
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            adi,reference-select:
> +              enum:
> +                - refin
> +                - refout-avss
> +                - avdd

I assume you tested that this restriction works as intended?

Cheers,
Conor.

--K9w0PSfQdN+TWI+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+T0gAKCRB4tDGHoIJi
0ps9AP9/++/sCN1dTPtbBoPrxYvOvaRbVFVVoZdi0QouNZ+uQQEAqTtA7VnxEYk0
sIL+bDAZpJIzJU7lUWDbroIR91pOjAU=
=Re9o
-----END PGP SIGNATURE-----

--K9w0PSfQdN+TWI+G--
