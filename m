Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E241B8089E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442831AbjLGOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443022AbjLGOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:09:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84F10F0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:09:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEC8C433C9;
        Thu,  7 Dec 2023 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701958179;
        bh=BjBnV3kL3685DCGYUGVnlSe0u7QDs/DMd9WjbShQbns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sEcFOS2fRrK0cHEs+GdHYd8OBAU1lM1XGk1JZz3CyZse9dNAqmkyLFZAWALoOyjpa
         8yOnSK1d+btluKAcPL48bcIwjkKLBDpH4XOIUwmB2fljU2EqO+M4NbEzS2yLhxX33a
         MA/N0a09PldZbjpEyegrp2kgM0S7W48yhuI14QDsHzrzyv4gkAuZIub97KFcnwn9SO
         mI8cstM96MDHXkT3eii/RWcJhZeYzqErIn9VDUjEtq918Y0LKqwUnKzH06FLkieYes
         C1KRJoc9vVJhnJXNSG4ovMWi535JfrshGfd6GsWYu7kvUeaJuNA+jZYNXwtPt/IvTg
         LIquhHnqet4aQ==
Date:   Thu, 7 Dec 2023 15:09:35 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Sjoerd Simons <sjoerd@collabora.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bus: moxtet: Add spi device table
Message-ID: <20231207150935.1db44032@dellmb>
In-Reply-To: <20231123142403.2262032-2-sjoerd@collabora.com>
References: <20231123142403.2262032-1-sjoerd@collabora.com>
        <20231123142403.2262032-2-sjoerd@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 15:23:38 +0100
Sjoerd Simons <sjoerd@collabora.com> wrote:

> The moxtet module was failing to auto-load on my system. Add a SPI id
> table to allow it to do so.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>=20
> ---
>=20
>  drivers/bus/moxtet.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> index 48c18f95660a..e384fbc6c1d9 100644
> --- a/drivers/bus/moxtet.c
> +++ b/drivers/bus/moxtet.c
> @@ -830,6 +830,12 @@ static void moxtet_remove(struct spi_device *spi)
>  	mutex_destroy(&moxtet->lock);
>  }
> =20
> +static const struct spi_device_id moxtet_spi_ids[] =3D {
> +	{ "moxtet" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
> +
>  static const struct of_device_id moxtet_dt_ids[] =3D {
>  	{ .compatible =3D "cznic,moxtet" },
>  	{},
> @@ -841,6 +847,7 @@ static struct spi_driver moxtet_spi_driver =3D {
>  		.name		=3D "moxtet",
>  		.of_match_table =3D moxtet_dt_ids,
>  	},
> +	.id_table	=3D moxtet_spi_ids,
>  	.probe		=3D moxtet_probe,
>  	.remove		=3D moxtet_remove,
>  };

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
