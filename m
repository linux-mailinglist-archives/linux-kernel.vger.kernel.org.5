Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5DF800FA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjLAP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjLAP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:59:14 -0500
X-Greylist: delayed 185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 07:59:19 PST
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:ff05:10b::237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2404E10D0;
        Fri,  1 Dec 2023 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1701446356;
        bh=NlYWjLxPgga+B6qXor9bK7J/rZPEyiB4nWhkpLB9Hb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RYHXQIaPlyRkFm3RtNjmTLNaa5JBy9v13O/VPSc73TOp/6/bCFbKcKd2ky739Qlrz
         CLtd0DeqZJTC/2Agn62NB8AjKrjhvIKUtJY9C+cIdhwwnE66tCxh2AdtzpFNUaOWo4
         xMpe4X5pZ4A+ztXIPvYQnubcvMGk3JYgR2TefPg50O1BGCfXOc/vv7KvFcovUSAuOp
         G2O4mx5na+mIFTmI8SVgyuoXcQtlJhIkr5NQtk1MVhM2pYLHuK7ZDcq7lG4jLYj4MI
         JDDAed2RuhS15e6r9nHEdQUwtp+2V+/UGeSoiDQ8MaKDTON+CQ/NvKvUH086q5VYf+
         RuQ25/QwcSeqQ==
Received: from localhost (tlha232.cesnet.cz [IPv6:2001:718:1:6::134:232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 62624118007E;
        Fri,  1 Dec 2023 16:59:12 +0100 (CET)
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <hvilleneuve@dimonoff.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 6/7] serial: max310x: add macro for max number of ports
Date:   Fri, 01 Dec 2023 16:59:12 +0100
MIME-Version: 1.0
Message-ID: <ddbc67dd-f8a3-4a6a-954a-bee49260ecab@cesnet.cz>
In-Reply-To: <20231130191050.3165862-7-hugo@hugovil.com>
References: <20231130191050.3165862-1-hugo@hugovil.com>
 <20231130191050.3165862-7-hugo@hugovil.com>
Organization: CESNET
User-Agent: Trojita/unstable-2022-08-22; Qt/5.15.10; wayland; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On =C4=8Dtvrtek 30. listopadu 2023 20:10:48 CET, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Add macro to hold the maximum number of UART ports per IC/device.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

> ---
>  drivers/tty/serial/max310x.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index f3a99daebdaa..58dd5cc62014 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -30,6 +30,7 @@
>  #define MAX310X_MAJOR=09=09=09204
>  #define MAX310X_MINOR=09=09=09209
>  #define MAX310X_UART_NRMAX=09=0916
> +#define MAX310X_MAX_PORTS=09=094 /* Maximum number of UART ports per IC. *=
/
> =20
>  /* MAX310X register definitions */
>  #define MAX310X_RHR_REG=09=09=09(0x00) /* RX FIFO */
> @@ -1502,7 +1503,7 @@ static const struct max310x_if_cfg=20
> __maybe_unused max310x_spi_if_cfg =3D {
>  static int max310x_spi_probe(struct spi_device *spi)
>  {
>  =09const struct max310x_devtype *devtype;
> -=09struct regmap *regmaps[4];
> +=09struct regmap *regmaps[MAX310X_MAX_PORTS];
>  =09unsigned int i;
>  =09int ret;
> =20
> @@ -1605,7 +1606,7 @@ static int max310x_i2c_probe(struct=20
> i2c_client *client)
>  =09const struct max310x_devtype *devtype =3D
>  =09=09=09device_get_match_data(&client->dev);
>  =09struct i2c_client *port_client;
> -=09struct regmap *regmaps[4];
> +=09struct regmap *regmaps[MAX310X_MAX_PORTS];
>  =09unsigned int i;
>  =09u8 port_addr;
> =20

