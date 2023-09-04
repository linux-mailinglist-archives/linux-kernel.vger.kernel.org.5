Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA72C791A10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349143AbjIDOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIDOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:53:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE31ACC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:53:20 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qdAwc-0007kU-4G; Mon, 04 Sep 2023 16:52:50 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4D3C92186D5;
        Mon,  4 Sep 2023 14:52:48 +0000 (UTC)
Date:   Mon, 4 Sep 2023 16:52:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, git@amd.com, michal.simek@amd.com,
        linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, appana.durga.rao@xilinx.com,
        naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v4 1/3] dt-bindings: can: xilinx_can: Add ECC property
 'xlnx,has-ecc'
Message-ID: <20230904-crystal-jokester-a76c1506c442-mkl@pengutronix.de>
References: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
 <1693557645-2728466-2-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nin2tevzwjvssdyh"
Content-Disposition: inline
In-Reply-To: <1693557645-2728466-2-git-send-email-srinivas.goud@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nin2tevzwjvssdyh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.09.2023 14:10:43, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFOs for Xilinx AXI CAN Controller.
> Part of this feature configuration and counter registers added in
> IP for 1bit/2bit ECC errors.
>=20
> xlnx,has-ecc is optional property and added to Xilinx AXI CAN Controller
> node if ECC block enabled in the HW
>=20
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
> Changes in v4:
> Fix binding check warning
> Update property description=20
>=20
> Changes in v3:
> Update commit description
>=20
> Changes in v2:
> None
>=20
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/=
Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> index 64d57c3..50a2671 100644
> --- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> @@ -49,6 +49,10 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  xlnx,has-ecc:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: CAN Tx and Rx fifo has ECC (AXI CAN)

Are there 2 FIFOs? If so I'd phrase it this way:
"CAN TX and RX FIFOs have ECC support (AXI CAN)" - or -
"CAN TX and RX FIFOs support ECC"

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nin2tevzwjvssdyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmT17z0ACgkQvlAcSiqK
BOgWQQf+My4CPC2KjO558oJv4n5uvbTZcmM8qAT2RFDMOB+Kny4bi4yvygdF6ysD
sBj/FRevD9HgawxAHO7f99cCSdwg+DLex4Ya9wJ4Lu/SnebAP9WQxCx6esvnYdEa
tsGQqEQqBPn6RsuK9fcmeiIX9kNg9EWstA5e6LclXusSrkdpYGMiF1seeUEzxDK7
IBxfHm6I9n/HqOg92PJrhtOo4DFMAC0FXm35yqxTXidRW91CdpbECLJcRcnxhc2x
jco+vaxeVylUUkzLhxcfX5+7dcOAQ8bwQeWYg0tREThMxrUbfeMvOxgCJ802pHZK
XZroGNCv/NZ2s30019lKTfyPyalaRA==
=NA90
-----END PGP SIGNATURE-----

--nin2tevzwjvssdyh--
