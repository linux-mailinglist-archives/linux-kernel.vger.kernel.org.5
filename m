Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964297EE8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjKPVb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPVb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:31:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F498182
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:31:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F05C433C8;
        Thu, 16 Nov 2023 21:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700170312;
        bh=HkqW/xbxkGnLq1viptkMdud4OyAiGVdBsU1lpf5TE20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vz9TUSegoI7rqv//v7Cqe/+3+YqU9uRvzmIzQ8nHFagHeFeuhIQJeI2U/j3BH+bDH
         KzKEsLIy5+ryc5ae8pcTCdeScD7/geUH0qLHvIHcvXpePlpfXMti2xu0vUl7YtNKfC
         Rdu8rUiDYIMQ14XgCRihB56d86XXeRA//c2UFvekXJWByh2fYBsNWrs50wT7oX9VrH
         aMnheh2RrHl1cEljKEgrlgf+7OKjhm10Ah0ZmLD1vxdfFRpkA5QZrdTlT3/GxXTEz9
         R06QnSlaEjDdH6UR0K8HhkmMJCRCqqeZjC66QNRrsH9Oxvk5en0ydWc+V/juPEIySk
         dzt5lUokVfXug==
Date:   Thu, 16 Nov 2023 21:31:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC193X
Message-ID: <20231116-uncork-onscreen-d041bbe3bb3f@squawk>
References: <20231115134453.6656-1-marius.cristea@microchip.com>
 <20231115134453.6656-2-marius.cristea@microchip.com>
 <fedd4bcf-7892-4096-bcca-7ea72d39576f@linaro.org>
 <20231116-channel-variety-cc7c262924ad@squawk>
 <9d0749ee-08e5-4630-b1b4-27d6aa436b29@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qy1pUtZjnv7Y8u6G"
Content-Disposition: inline
In-Reply-To: <9d0749ee-08e5-4630-b1b4-27d6aa436b29@linaro.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qy1pUtZjnv7Y8u6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 09:00:50PM +0100, Krzysztof Kozlowski wrote:
> On 16/11/2023 19:21, Conor Dooley wrote:
>=20
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: interrupts
> >>
> >>
> >> I don't understand what do you want to say here. I am also 100% sure y=
ou
> >> did not test it on a real case (maybe example passes but nothing more).
> >=20
> > As far as I understand, the same pin on the device is used for both an
> > output or an input depending on the configuration. As an input, it is
> > the "slow-io" control, and as an output it is an interrupt.
> > I think Marius is trying to convey that either this pin can be in
> > exclusively one state or another.
> >=20
> > _However_ I am not sure that that is really the right thing to do - they
> > might well be mutually exclusive modes, but I think the decision can be
> > made at runtime, rather than at devicetree creation time. Say for
> > example the GPIO controller this is connected to is capable of acting as
> > an interrupt controller. Unless I am misunderstanding the runtime
> > configurability of this hardware, I think it is possible to actually
> > provide a "slow-io-gpios" and an interrupt property & let the operating
> > system decide at runtime which mode it wants to work in.
> >=20
> > I'm off travelling at the moment Marius, but I should be back in work on
> > Monday if you want to have a chat about it & explain a bit more to me?
>=20
> Sure, but which compatible contains "interrupts"?

Yeah, I did notice that - I figured you understood that that was meant
to not be a check on compatibles, but rather on regular old properties &
the rationale for the mutual exclusion was what you were missing.

--Qy1pUtZjnv7Y8u6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVaKOgAKCRB4tDGHoIJi
0smuAQCNpa1dlXPZqWLjgqP8b+I5SvrWhzNufcLR2XSaUA5qdQD/WziAESAZdybU
8u9x2hZK43Ao6LkoE6nWOYKlAOu0uw0=
=zWfv
-----END PGP SIGNATURE-----

--Qy1pUtZjnv7Y8u6G--
