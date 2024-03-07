Return-Path: <linux-kernel+bounces-95895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B928754AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B66F1C22A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB8212FF71;
	Thu,  7 Mar 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeFvaO3e"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7E12FF60;
	Thu,  7 Mar 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830459; cv=none; b=tX7aAx+OLdhZmlYdMzuExX0SE7eZdDBEJ04zaTZMK4s3j2mQ2HM9CF9h2EHA9gvoQn150xXuifUvjb6di8FN+slTek4z/UBOColXruJ71skhUR/hGVoQG3Z2iTZ3jz51PatYxrcjRAKjWzAsjW/oDescW+cIblOdxcioX0ZXLBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830459; c=relaxed/simple;
	bh=+RE4n9mAzcXU0KaJBBAYHpuHhevdCr+49p3v6p1z9G0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czG96EjRZ6dTHxseJEs9klAvhOorAeDsHCvi7aFe52u2MNzdT+eZAn2azsXxdGifS5Ect8GNGEaycWel1N8U/tkkofmF1fmIWUgUOipkYUMSq+DVwuTDSMpncZTnqaJWKaUv1LM3loANA4CnB0W32atANYu6n/iajXOUpNOawxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeFvaO3e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41316512055so529955e9.2;
        Thu, 07 Mar 2024 08:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709830455; x=1710435255; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+RE4n9mAzcXU0KaJBBAYHpuHhevdCr+49p3v6p1z9G0=;
        b=MeFvaO3ejJ68ARnHfodDhBUkWmEL8kremBv8F2rchpPTfFRIy41W2EsCGa8tZ/1nIE
         kysSkweEG6q3f2nZUk6s9wxoIq74kjBV7E+6xe+VppxwIZrotZqTCroT4NiNv0xXlGLD
         YVcAY/5fvAjgoXvfHITDeUeviaK+n6yzR6mydZwyvi5VdambFzUo3TsHr8O4Gcq/sy0l
         ZXHJx5E1Fbta+YzycAmsLjoV64mpNzDmIAnYZ0aMEs+tBhCrp6EMp2ILR3mbZ7cvlQv7
         EiciT59sgcfz3E2ZIcmT2nbDVlhLMsH5VfdMYNMmcxf8kJzsgPqnWaSFEpDCBXxTKtfT
         eNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830455; x=1710435255;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RE4n9mAzcXU0KaJBBAYHpuHhevdCr+49p3v6p1z9G0=;
        b=TJeJYaXOt/SidC7KvO/Wl8UVWHgqpmBh8zI3mt2J7nT2Lv+STYwEqJzyvVSgwA30Y5
         5KWkIc+f4CK1VCh6o1p/0eoixvsvZfnz34EPctcYCWD9clei26nuL1JRqIupmGuTHKBJ
         L9C/Nkk7t+RottwJBWxl3kYu6EQz+TQyhCyku3w8BL7pKFCpvuafejfJoO1QAcgdfXvx
         gG1hMW7ShovJWAwF9TH82OupUR5pTeHBwt9TUpsDE6ASTdp2xKF6zmY+Fk/+A9q3odcv
         Zs49spXmwIHeIXHoFYEBKOStA0aZkYjQnJrfANat0sGp/qM52TJJXeDNV0H+HDk1fbcC
         AsAw==
X-Forwarded-Encrypted: i=1; AJvYcCVyJXgtpVA0hhLPN8yCZCd0Ljj2TIeSaJzrxyIQzyfRqUaI+u1lrGaJlf8H5t8CUjpKbmjwJ8e4gzUW62v3lpA07Js0dvrAZ11iVfHJVECFR757f9FLCNHLU79wI8TU8rieX36iZtsi15n+7Z/FnPGs6ZbHiYXGfxLbtNBWVjpU
X-Gm-Message-State: AOJu0YyBnDUttetpeTxKveCPu+TYgfatB7YJnExgl7bYcNfZTmcYR8Md
	dhuLyPdlI/REb7fqSOtAxzw2UVywijxvtFnJeNrvsRhmmpRC1e75
X-Google-Smtp-Source: AGHT+IFSULhdksAcmPLfuUG4QaQrSYpxp1yb2lDbrmftQyt4UV+KxEf1vBTb1vWFQ7MHwehs7u7YGA==
X-Received: by 2002:a05:600c:1f95:b0:412:abfd:2c0e with SMTP id je21-20020a05600c1f9500b00412abfd2c0emr15398689wmb.41.1709830455113;
        Thu, 07 Mar 2024 08:54:15 -0800 (PST)
Received: from ?IPv6:2001:8a0:e60f:3100:e743:3996:1359:d39d? ([2001:8a0:e60f:3100:e743:3996:1359:d39d])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b00412d60cb914sm3302940wmo.5.2024.03.07.08.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 08:54:14 -0800 (PST)
Message-ID: <75fa2711c1aace90a831f95a00b8ba41abf1c883.camel@gmail.com>
Subject: Re: [PATCH] can: mcp251xfd: fix infinite loop when xmit fails
From: vitor <ivitro@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com, 
 wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
  vitor.soares@toradex.com, stable@vger.kernel.org
Date: Thu, 07 Mar 2024 16:54:13 +0000
In-Reply-To: <xmk5cgskx2ug2psec6qgbxndbuqq5cnin7rd4zt3thnhybxgeo@xudpdob7tcg2>
References: <20240307120442.12262-1-ivitro@gmail.com>
	 <xmk5cgskx2ug2psec6qgbxndbuqq5cnin7rd4zt3thnhybxgeo@xudpdob7tcg2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marc,

On Thu, 2024-03-07 at 13:23 +0100, Marc Kleine-Budde wrote:
> Sorry, resend. I fsck up the linux-can ML's address.

Thanks for that.
>=20
> On 07.03.2024 12:04:42, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > When the mcp251xfd_start_xmit() function fails, the driver stops
> > processing messages, and the interrupt routine does not return,
> > running indefinitely even after killing the running application.
> >=20
> > Error messages:
> > [=C2=A0 441.298819] mcp251xfd spi2.0 can0: ERROR in
> > mcp251xfd_start_xmit: -16
> > [=C2=A0 441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer
> > not empty. (seq=3D0x000017c7, tef_tail=3D0x000017cf,
> > tef_head=3D0x000017d0, tx_head=3D0x000017d3).
> > ... and repeat forever.
> >=20
> > The issue can be triggered when multiple devices share the same
> > SPI interface. And there is concurrent access to the bus.
> >=20
> > The problem occurs because tx_ring->head increments even if
> > mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> > TX package while still expecting a response in
> > mcp251xfd_handle_tefif_one().
> >=20
> > This patch resolves the issue by decreasing tx_ring->head if
> > mcp251xfd_start_xmit() fails. With the fix, if we attempt to
> > trigger
> > the issue again, the driver prints an error and discard the
> > message.
>=20
> What about returning NETDEV_TX_BUSY, then the networking stack will
> retry.

Do you mean when err =3D=3D -EBUSY?

>=20
> > Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip
> > MCP25xxFD SPI CAN")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > =C2=A0drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 27 ++++++++++-----=
-
> > ----
> > =C2=A01 file changed, 14 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > index 160528d3cc26..a8eb941c1b95 100644
> > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > @@ -181,25 +181,26 @@ netdev_tx_t mcp251xfd_start_xmit(struct
> > sk_buff *skb,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_obj =3D mcp251xfd_ge=
t_tx_obj_next(tx_ring);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mcp251xfd_tx_obj_from_s=
kb(priv, tx_obj, skb, tx_ring-
> > >head);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Stop queue if we occupy t=
he complete TX FIFO */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_head =3D mcp251xfd_g=
et_tx_head(tx_ring);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_ring->head++;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mcp251xfd_get_tx_free(tx=
_ring) =3D=3D 0)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0netif_stop_queue(ndev);
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0frame_len =3D can_skb_g=
et_frame_len(skb);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D can_put_echo_skb(skb=
, ndev, tx_head, frame_len);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!err)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0netdev_sent_queue(priv->ndev, frame_len);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0can_put_echo_skb(skb, ndev, =
tx_head, frame_len);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_ring->head++;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D mcp251xfd_tx_ob=
j_write(priv, tx_obj);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out_err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0can_free_echo_skb(ndev, tx_head, NULL);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NETDEV_TX_OK;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tx_ring->head--;
> > +

I'm testing returning here when err =3D -EBUSY, but can_put_echo_skb()
should be invoked after mcp251xfd_tx_obj_write(). Otherwise, I get a
Kernel NULL pointer dereference error.


>=20
> I'm not sure, if we want an error message for -EBUSY. We could add
> proper ethtool statistics.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0netdev_err(priv->ndev, "ERROR in %s: %d\n",
> > __func__, err);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* Stop queue if we occupy the complete TX FIFO */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (mcp251xfd_get_tx_free(tx_ring) =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netif_=
stop_queue(ndev);
> > =C2=A0
> > - out_err:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netdev_err(priv->ndev, "ERRO=
R in %s: %d\n", __func__, err);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0netdev_sent_queue(priv->ndev, frame_len);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NETDEV_TX_OK;
> > =C2=A0}
>=20
> regards,
> Marc
>=20

Best regards,
Vitor Soares

