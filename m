Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059E67CC16C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbjJQLCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343755AbjJQLCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:02:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915DCF5;
        Tue, 17 Oct 2023 04:02:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BB0C433C8;
        Tue, 17 Oct 2023 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697540556;
        bh=kfOljpmUeVLUNn5bQwDqyoFFMYqfHS7AT/5JQ2FpBV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MU9haWBNsqryNCw//fK2aS3/NLu+uGWV3Z6/ii9SkOOjnAT0nYMcVgdFs0UC+8lXf
         B3VkUR1/zzsLk+vlcig4KfmlIQFB6vMM38vdDrewrw2An8eI4eBHktScXOL3PBey0a
         1deh6EgO1PCDmgOyCFS5k6WBIOgmxpjrJbtpI3Ck1zIieZTWCHH1O5errFRFH6MX07
         0XGPaFweEKsCQ5jWodNrBtrgdd48kSgpFpBNjcVptQqALbOVZmSUwr/Ie1KGk369FD
         DY6odmIbfjTm1SwsyHs9jn012U++es/DTFUYqzcZHcPN0VjSWVucrvAuVADI5qKlqf
         PPBAQl8CWy/JA==
Date:   Tue, 17 Oct 2023 12:02:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nik Bune <n2h9z4@gmail.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        skhan@linuxfoundation.org, stwiss.opensource@diasemi.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] dt-bindings: watchdog: da9062-wdt: convert txt to yaml
Message-ID: <20231017-able-unedited-b91872768fbd@spud>
References: <20231012-flaky-humvee-0a0532621940@spud>
 <20231014164942.154468-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H9If0aFZImYCFheU"
Content-Disposition: inline
In-Reply-To: <20231014164942.154468-1-n2h9z4@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H9If0aFZImYCFheU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 14, 2023 at 06:49:42PM +0200, Nik Bune wrote:
> >This property is a boolean...
> >
> >> +    description:
> >> +      Set what happens on watchdog timeout. If this bit is set the
> >> +      watchdog timeout triggers SHUTDOWN, if cleared the watchdog tri=
ggers
> >> +      POWERDOWN. Can be 0 or 1.
> >
> >... but you say "can be 0 or 1". Does this refer to the bit value, or
> >the property? There are no in-kernel users of this property as far as a
> >quick grep shows so it is a bi hard to tell.
> >
> >Otherwise, I'm happy with this.
> >
> >Thanks,
> >Conor.
>=20
> Hello, thank you for your review!
>=20
> Good point.=20
> It looks like it is related to property itself.=20
>=20
> I checked other bindings, like https://www.kernel.org/doc/Documentation/d=
evicetree/bindings/iio/adc/adi%2Cad7192.yaml . They have fields of type boo=
lean with description =E2=80=9CWhen this bit is set to 1=E2=80=9D.
> So I put it as boolean.
>=20
> I have just checked a couple more, and looks like they are mostly uint32 =
types with enum, when it goes about 0, 1 bit value in a description. =20
> $ref: /schemas/types.yaml#/definitions/uint32
> enum: [0, 1]

It _seems_ like the intention was for this to be an enum, now that I
re-read the description, since it is being used to override the
behaviour from the OTP.

With that changed
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--H9If0aFZImYCFheU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS5pxgAKCRB4tDGHoIJi
0vDdAP9xUcabNaj3GHiQRWdCIChrWv/+Uensqug6xHSbCVt8FAD/ZxFMRrqarqId
945rEZAeqpZy7W9HJKmkV7fbu9U91gQ=
=HqZ4
-----END PGP SIGNATURE-----

--H9If0aFZImYCFheU--
