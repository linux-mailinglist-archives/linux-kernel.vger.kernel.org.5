Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB537F8C96
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjKYRFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:05:19 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA61F129
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:05:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1r6w5W-0000xM-ND; Sat, 25 Nov 2023 18:05:02 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1r6w5U-00BWxZ-3K; Sat, 25 Nov 2023 18:05:00 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9834E2538FD;
        Sat, 25 Nov 2023 17:04:59 +0000 (UTC)
Date:   Sat, 25 Nov 2023 18:04:59 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, git@amd.com, michal.simek@xilinx.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, appana.durga.rao@xilinx.com,
        naga.sureshkumar.relli@xilinx.com
Subject: Re: [PATCH v6 3/3] can: xilinx_can: Add ethtool stats interface for
 ECC errors
Message-ID: <20231125-distract-upstage-a18902149a63-mkl@pengutronix.de>
References: <1700910933-23868-1-git-send-email-srinivas.goud@amd.com>
 <1700910933-23868-4-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jgdzz4e4cfbadnp"
Content-Disposition: inline
In-Reply-To: <1700910933-23868-4-git-send-email-srinivas.goud@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4jgdzz4e4cfbadnp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.11.2023 16:45:33, Srinivas Goud wrote:
> Add ethtool stats interface for reading FIFO 1bit/2bit ECC errors informa=
tion.
>=20
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
> Changes in v6:
> None
>=20
> Changes in v5:
> Address review comments
> Add get_strings and get_sset_count stats interface
> Use u64 stats helper function
>=20
> Changes in v4:
> None
>=20
> Changes in v3:
> None
>=20
> Changes in v2:
> Add ethtool stats interface
>=20
>  drivers/net/can/xilinx_can.c | 54 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 54 insertions(+)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index c8691a1..40c912b 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -228,6 +228,7 @@ struct xcan_devtype_data {
>   * @transceiver:		Optional pointer to associated CAN transceiver
>   * @rstc:			Pointer to reset control
>   * @ecc_enable:			ECC enable flag
> + * @stats_lock:			Lock for synchronizing ECC errors stats
>   * @ecc_2bit_rxfifo_cnt:	RXFIFO 2bit ECC count
>   * @ecc_1bit_rxfifo_cnt:	RXFIFO 1bit ECC count
>   * @ecc_2bit_txolfifo_cnt:	TXOLFIFO 2bit ECC count
> @@ -254,6 +255,7 @@ struct xcan_priv {
>  	struct phy *transceiver;
>  	struct reset_control *rstc;
>  	bool ecc_enable;
> +	spinlock_t stats_lock; /* Lock for synchronizing ECC errors stats */
>  	u64_stats_t ecc_2bit_rxfifo_cnt;
>  	u64_stats_t ecc_1bit_rxfifo_cnt;
>  	u64_stats_t ecc_2bit_txolfifo_cnt;
> @@ -347,6 +349,12 @@ static const struct can_tdc_const xcan_tdc_const_can=
fd2 =3D {
>  	.tdcf_max =3D 0,
>  };
> =20
> +static const char xcan_priv_flags_strings[][ETH_GSTRING_LEN] =3D {
> +	"err-ecc-rx-2-bit", "err-ecc-rx-1-bit",
> +	"err-ecc-txol-2-bit", "err-ecc-txol-1-bit",
> +	"err-ecc-txtl-2-bit", "err-ecc-txtl-1-bit",
> +};
> +
>  /**
>   * xcan_write_reg_le - Write a value to the device register little endian
>   * @priv:	Driver private data structure
> @@ -1171,6 +1179,9 @@ static void xcan_err_interrupt(struct net_device *n=
dev, u32 isr)
> =20
>  	if (priv->ecc_enable && isr & XCAN_IXR_ECC_MASK) {
>  		u32 reg_rx_ecc, reg_txol_ecc, reg_txtl_ecc;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&priv->stats_lock, flags);

The register access doesn't have to be protected by the spinlock, only
when you touch priv->ecc_*cnt.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4jgdzz4e4cfbadnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmViKTgACgkQvlAcSiqK
BOiREQgAtl7uFO/XnkgoCkRiMxHvAtvcVrUswBxeFAW76mVjE9V/Hg3V4LQ3vcPV
Tzt+wM53Wd7FDXJMj6P8qaUrzC2PVrBeqqGb8RoPrEr6pSY/qf2Rj85OJG/xs8RT
Z0zB4U87ccavRZ4ozzCiVDQ+3eAfQp8RbeUnBFKIQKCnZfVInzvUMG2l+gFTvLjg
MtXCmOEIhlrFFWSDG1JeeIhXKXBBhGsUqe+sTDOytMlFPnR7h2SLZOsZ5NxgGqGX
PNYkIMjfiiK57iJmPEo+/opqh7nTw4FFSRrGr9g9RmuveF3uCVLjqOHBLMf0lZTE
14Pn5JTlqvNMrSOK/jZzgMFmsgCvxA==
=5s7P
-----END PGP SIGNATURE-----

--4jgdzz4e4cfbadnp--
