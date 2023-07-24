Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B2D75EE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjGXIzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjGXIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:54:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CDEE3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:54:56 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qNrKw-0002ZA-Jt; Mon, 24 Jul 2023 10:54:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D5AC31F83E8;
        Mon, 24 Jul 2023 08:54:36 +0000 (UTC)
Date:   Mon, 24 Jul 2023 10:54:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Goud, Srinivas" <srinivas.goud@amd.com>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "gcnu.goud@gmail.com" <gcnu.goud@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [PATCH 2/3] can: xilinx_can: Add ECC support
Message-ID: <20230724-headpiece-switch-1717818d1be1-mkl@pengutronix.de>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-3-git-send-email-srinivas.goud@amd.com>
 <20230613-sprinkler-pasta-08ae2bd72ac8-mkl@pengutronix.de>
 <PH8PR12MB6675A9F83C930189272E784BE13FA@PH8PR12MB6675.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s4xj6l7d5v25ys75"
Content-Disposition: inline
In-Reply-To: <PH8PR12MB6675A9F83C930189272E784BE13FA@PH8PR12MB6675.namprd12.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s4xj6l7d5v25ys75
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.07.2023 05:23:02, Goud, Srinivas wrote:
> >> +	if (priv->ecc_enable) {
> >> +		u32 reg_ecc;
> >> +
> >> +		reg_ecc =3D priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
> >> +		if (isr & XCAN_IXR_E2BERX_MASK) {
> >> +			priv->ecc_2bit_rxfifo_cnt +=3D
> >> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK,
> >reg_ecc);
> >> +			netdev_dbg(ndev, "%s: RX FIFO 2bit ECC error count
> >%d\n",
> >> +				   __func__, priv->ecc_2bit_rxfifo_cnt);
> >> +		}
> >> +		if (isr & XCAN_IXR_E1BERX_MASK) {
> >> +			priv->ecc_1bit_rxfifo_cnt +=3D reg_ecc &
> >> +				XCAN_ECC_1BIT_CNT_MASK;
> >
> >Please use FIELD_GET here, too.
> >
> >> +			netdev_dbg(ndev, "%s: RX FIFO 1bit ECC error count
> >%d\n",
> >> +				   __func__, priv->ecc_1bit_rxfifo_cnt);
> >> +		}
> >> +
> >> +		reg_ecc =3D priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
> >> +		if (isr & XCAN_IXR_E2BETXOL_MASK) {
> >> +			priv->ecc_2bit_txolfifo_cnt +=3D
> >> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK,
> >reg_ecc);
> >> +			netdev_dbg(ndev, "%s: TXOL FIFO 2bit ECC error count
> >%d\n",
> >> +				   __func__, priv->ecc_2bit_txolfifo_cnt);
> >> +		}
> >> +		if (isr & XCAN_IXR_E1BETXOL_MASK) {
> >> +			priv->ecc_1bit_txolfifo_cnt +=3D reg_ecc &
> >> +				XCAN_ECC_1BIT_CNT_MASK;
> >
> >same here
> >
> >> +			netdev_dbg(ndev, "%s: TXOL FIFO 1bit ECC error count
> >%d\n",
> >> +				   __func__, priv->ecc_1bit_txolfifo_cnt);
> >> +		}
> >> +
> >> +		reg_ecc =3D priv->read_reg(priv, XCAN_TXTLFIFO_ECC_OFFSET);
> >> +		if (isr & XCAN_IXR_E2BETXTL_MASK) {
> >> +			priv->ecc_2bit_txtlfifo_cnt +=3D
> >> +				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK,
> >reg_ecc);
> >> +			netdev_dbg(ndev, "%s: TXTL FIFO 2bit ECC error count
> >%d\n",
> >> +				   __func__, priv->ecc_2bit_txtlfifo_cnt);
> >> +		}
> >> +		if (isr & XCAN_IXR_E1BETXTL_MASK) {
> >> +			priv->ecc_1bit_txtlfifo_cnt +=3D reg_ecc &
> >> +				XCAN_ECC_1BIT_CNT_MASK;
> >
> >same here
> >
> >> +			netdev_dbg(ndev, "%s: TXTL FIFO 1bit ECC error count
> >%d\n",
> >> +				   __func__, priv->ecc_1bit_txtlfifo_cnt);
> >> +		}
> >> +
> >> +		/* Reset FIFO ECC counters */
> >> +		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET,
> >XCAN_ECC_CFG_REECRX_MASK |
> >> +				XCAN_ECC_CFG_REECTXOL_MASK |
> >XCAN_ECC_CFG_REECTXTL_MASK);
> >
> >This is racy - you will lose events that occur between reading the regis=
ter value
> >and clearing the register. You can save the old value and add the differ=
ence
> >between the new and the old value to the total counter. What happens when
> >the counter overflows? The following pseudocode should handle the u16
> >counter rolling over to 0:
> As per IP specifications when counter reaching maximum value of 0xFFFF wi=
ll=20
> stays there until reset.
>=20
> Not sure we can avoid this race condition completely, as we need to reset
> the counters after reaching the 0xFFFF to avoid losing the events.
>=20
> To minimize the race condition, we can reset the counters after reaching=
=20
> the events to 0xFFFF instead of resetting for every interrupt.=20
> Can you please suggest if we can go this approach.

Ok, the counter doesn't overflow. To keep the logic in the driver
simple, I think it's best to read the value and reset the counter
directly in the next line. Please add a comment like: "The counter
reaches its maximum at 0xffff and does not overflow. Accept the small
race window between reading and resetting."

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s4xj6l7d5v25ys75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS+PEkACgkQvlAcSiqK
BOhBsAf/Uy9GZxrB5atT0YrG+tWWdXCviS7jrEfFCO/18HVSkDAy1S1rOwzPqMAP
K905oZNNqdbcbfVA03kGzQe+SiS1AT9KZug+OlHwWxCbnEilYy6QgGGcGQsZnEel
orari5fW4sTmZYPFpByDVpgoju2NL3rdpaBJ3OZywR3nV6lZK4dk7vieHFmtvUHR
bfNAWh3LGj+55Zc6OH44lfalZyQXLrB7R1H0GeDP0m358WejiYVyezDl5dk2HC6p
1ntGQ22ADAPDHiogtiBLTahdl+9W4EXgulhHQ8zrlmtkUd2xIC7Xcg9rgDUiEAY/
/TxHQf39Jth7nuLgdmrFMMqhAbjhYQ==
=TgLA
-----END PGP SIGNATURE-----

--s4xj6l7d5v25ys75--
