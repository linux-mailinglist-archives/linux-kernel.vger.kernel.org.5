Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E3B7BD74F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345981AbjJIJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345982AbjJIJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:39:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17D3BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:39:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qpmjP-0000d1-MB; Mon, 09 Oct 2023 11:39:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qpmjN-000Nea-QY; Mon, 09 Oct 2023 11:39:17 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5FD11232713;
        Mon,  9 Oct 2023 09:15:14 +0000 (UTC)
Date:   Mon, 9 Oct 2023 11:15:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v4 4/4] spi: Use struct_size() helper
Message-ID: <20231009-onshore-underage-c58415adfd92-mkl@pengutronix.de>
References: <20230714091748.89681-1-andriy.shevchenko@linux.intel.com>
 <20230714091748.89681-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byg2avbsrmzwgr6r"
Content-Disposition: inline
In-Reply-To: <20230714091748.89681-5-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
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


--byg2avbsrmzwgr6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

this change (75e308ffc4f0 ("spi: Use struct_size() helper")) reached
mainline with v6.6-rc1 and causes the following warning in my mcp251xfd
CAN driver.

On 14.07.2023 12:17:48, Andy Shevchenko wrote:
> The Documentation/process/deprecated.rst suggests to use flexible array
> members to provide a way to declare having a dynamically sized set of
> trailing elements in a structure.This makes code robust agains bunch of
> the issues described in the documentation, main of which is about the
> correctness of the sizeof() calculation for this data structure.
>
> Due to above, prefer struct_size() over open-coded versions.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/spi/spi.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 04daf61dfd3f..7f8b478fdeb3 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -13,6 +13,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/kthread.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/overflow.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/u64_stats_sync.h>
> @@ -1085,6 +1086,8 @@ struct spi_transfer {
>   * @state: for use by whichever driver currently owns the message
>   * @resources: for resource management when the SPI message is processed
>   * @prepared: spi_prepare_message was called for the this message
> + * @t: for use with spi_message_alloc() when message and transfers have
> + *	been allocated together
>   *
>   * A @spi_message is used to execute an atomic sequence of data transfer=
s,
>   * each represented by a struct spi_transfer.  The sequence is "atomic"
> @@ -1139,6 +1142,9 @@ struct spi_message {
>
>  	/* List of spi_res resources when the SPI message is processed */
>  	struct list_head        resources;
> +
> +	/* For embedding transfers into the memory of the message */
> +	struct spi_transfer	t[];

|   CHECK   drivers/net/can/spi/mcp251xfd/mcp251xfd-chip-fifo.c
| drivers/net/can/spi/mcp251xfd/mcp251xfd-chip-fifo.c: note: in included fi=
le:
| drivers/net/can/spi/mcp251xfd/mcp251xfd.h:632:38: warning: array of flexi=
ble structures
| drivers/net/can/spi/mcp251xfd/mcp251xfd.h:547:36: warning: array of flexi=
ble structures

Line 632 is an array of struct mcp251xfd_tef_ring in the struct mcp251xfd_p=
riv:

| struct mcp251xfd_priv {
[...]
| 	struct mcp251xfd_tef_ring tef[MCP251XFD_FIFO_TEF_NUM];
[...]
| }

=2E..and struct mcp251xfd_tef_ring contains a struct spi_transfer:

| struct mcp251xfd_tef_ring {
| 	unsigned int head;
| 	unsigned int tail;
|=20
| 	/* u8 obj_num equals tx_ring->obj_num */
| 	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
|=20
| 	union mcp251xfd_write_reg_buf irq_enable_buf;
| 	struct spi_transfer irq_enable_xfer;
| 	struct spi_message irq_enable_msg;
|=20
| 	union mcp251xfd_write_reg_buf uinc_buf;
| 	union mcp251xfd_write_reg_buf uinc_irq_disable_buf;
| 	struct spi_transfer uinc_xfer[MCP251XFD_TX_OBJ_NUM_MAX];
| };

The warning in line 547 is similar, but for the TX ring.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--byg2avbsrmzwgr6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUjxJ8ACgkQvlAcSiqK
BOjJ4gf/bk1cLR7h+ToiM55xZZJ7zSij0pPzDrb3UXKY9PAtVRew1qG9c6gng5mT
6eOeeE+3b5TuTQ5pSG5iPWqM49YBYBJA63+NJH7uR5ovmajqILrfuvo1tdhTyvo4
s1HGCQtuMpiORVM3/6Gl4UjkynuQCNSH6wBsr4bjk0OLxad7qz6soETRGPup6lNx
9qJrZc8pYP5SQ5n5ory79I0+K/LH9A/d+SQKPoQsXWWtMwBXQw94JkvXbmoh104Y
rphNNFO5/LmgAFoq1GZU17vDhKB/nhRt6SGmHajODb7otkRyH4TTeuSgQ/khcghk
MHMUJp6XKmWogO5kmfnM3X9B5sWHXg==
=bTCd
-----END PGP SIGNATURE-----

--byg2avbsrmzwgr6r--
