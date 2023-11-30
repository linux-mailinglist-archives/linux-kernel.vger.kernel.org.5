Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E37FF312
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjK3O6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346158AbjK3O6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:58:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF39170E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:58:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C164C433C7;
        Thu, 30 Nov 2023 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701356326;
        bh=8Js8Hy2kLo1L6YkFwnzWN4hkYezVwJRoYHViVMUicgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpNt6hKjXd68EwOlbz1pBTdNJaj7J+27Hno3vGBqWlu+gZizrLjcv7HizbZ2UACJ7
         ASITdqOtS3LB7mfmk4ik5b0U4OJkQNaTEw5/X/w11xwGLogCN+SdkqBOvGMQ1xwm9D
         CvJV3niMs7u1kSvjFKbpJZiuQEpCM+I+h7FVBDT8nsoe+7CNZCo481jqPbUGuohsFg
         BpEhp8JVi9wbZjpUjwq+9GhD0bHyo815nC4O7BBTKhW5tfZaO6F01LXNVnhp7bddkP
         fqOM5l0H9HSKegNN9HxdDUOPlEnk2vkUzsyf7YxjbI7rES86ZxFx+Ng9oqJJnYpeMG
         EEAJ1+mSaNQ+A==
Date:   Thu, 30 Nov 2023 14:58:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Increase max number of io-channels
Message-ID: <20231130-power-rubbed-fbf64a8c6978@spud>
References: <441d9babc7042892350a58ba4300df4761876ae3.1701334008.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BPoyXFuPPPfwP3S7"
Content-Disposition: inline
In-Reply-To: <441d9babc7042892350a58ba4300df4761876ae3.1701334008.git.michal.simek@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BPoyXFuPPPfwP3S7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 09:46:54AM +0100, Michal Simek wrote:
> arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts is defining 30 channels
> that's why increase it.
> But AMS binding defines 51 channels
> Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> that's why increase number to 51.

Please write commit messages for bindings in terms of how they relate to
some hardware. In this case I think it would be sufficient to say that
the Analog Monitoring system has 51 channels, the opening sentence about
the dts as justification provides no actionable information.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>  Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml b/Doc=
umentation/devicetree/bindings/hwmon/iio-hwmon.yaml
> index e5b24782f448..be5c7d4579bb 100644
> --- a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
> @@ -19,7 +19,7 @@ properties:
> =20
>    io-channels:
>      minItems: 1
> -    maxItems: 8 # Should be enough
> +    maxItems: 51 # Should be enough
>      description: >
>        List of phandles to ADC channels to read the monitoring values
> =20
> --=20
> 2.36.1
>=20

--BPoyXFuPPPfwP3S7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWijIQAKCRB4tDGHoIJi
0lICAQC1KW3GVEI4tqQWELA4CLCh/wITQ8ofp4IPCooF4IJVWQD+NKt3+qwCkPnx
L96KirOZwabT/HBwdu4dRpfvte7q4Ak=
=DlYh
-----END PGP SIGNATURE-----

--BPoyXFuPPPfwP3S7--
