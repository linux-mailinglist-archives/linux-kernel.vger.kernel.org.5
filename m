Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDD7F8AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjKYMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjKYMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:21:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69EBD6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:21:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEFDC433C7;
        Sat, 25 Nov 2023 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700914889;
        bh=NokKKbjP7/sQSnXyJk7VS1kmyB9mZyNesxHCciD9GTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZn1ThndkOxaashwIdkq7g0vJIDCBIrMA6MwUpzzpcR2SEnw0+PJRhbP/Lo128eId
         EUM5asAXzdU38JeWM1oGUECkoCOzVjIiP+O32x05fHTVuLAPr+Eg2dAHeIGtPrNH8l
         Fro+ofqk2VSxRF57cijh2a1U9QTzUvs5i0qmzj0hrRKLQ2fWz7xKHMkvURudMokFVd
         xC55+IbcYeMw8AEVGXiQcRlbeiJc+dzMSI8oM8XBwAXmr67PXGWJ2n3FL35oFo/sEx
         sSGp08vzujBog9qZ7cllzcegwoz1S9W5fMPxy1DFU/WwYoNnJlgfqJLRZvvtQzufKE
         1Wb5BZgnf8jGg==
Date:   Sat, 25 Nov 2023 12:21:24 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     paul.cercueil@analog.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] dt-bindings: iio: Add binding documentation for
 AD7091R-8
Message-ID: <20231125-pennant-untie-90b5f0828258@spud>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
 <8ce972a3708f7789237c86c44e23cdcb23a35103.1700751907.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PpbYFIjhbA0yHs/g"
Content-Disposition: inline
In-Reply-To: <8ce972a3708f7789237c86c44e23cdcb23a35103.1700751907.git.marcelo.schmitt1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PpbYFIjhbA0yHs/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 01:42:21PM -0300, Marcelo Schmitt wrote:

> +  spi-max-frequency: true

This is not needed, since you have unevaluatedProperties: false &
include the spi periph props.

> +  adi,conversion-start-gpios:
> +    description:

> +      Device tree identifier of the CONVST pin.

"gpio connected to the CONVST pin".

> +      This logic input is used to initiate conversions on the analog
> +      input channels.
> +    maxItems: 1

This looks pretty decent to be overall though.

--PpbYFIjhbA0yHs/g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWHmxAAKCRB4tDGHoIJi
0p1xAQCpqjmqfhVCI9G10fGp0R0KaL5NUz2lINY4C7iNmT/CfAEAuBsu2q+bVFVP
hMsHHj47qNHfR+n8TOZtwwVR460T3Aw=
=fPlx
-----END PGP SIGNATURE-----

--PpbYFIjhbA0yHs/g--
