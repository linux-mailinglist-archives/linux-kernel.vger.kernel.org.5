Return-Path: <linux-kernel+bounces-97488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0489E876AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280F81C214F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616005A4E3;
	Fri,  8 Mar 2024 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf1JhdDm"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967BB5646D;
	Fri,  8 Mar 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924237; cv=none; b=updM53HJZh6J6OWPPytaFFedgiFG4ni5CYnzP5Xal49ICA+UlWViVB3fStLWf1a6J+KLCOj6+KrLjX38hHr8L4zTEqJhkBG80wyuLMLVcGHDGVjnDr49IQkEWC51N8MaVGP+qewbWUSi6DaWxpHOeR8tI1OrmXJA4KX8T5aQhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924237; c=relaxed/simple;
	bh=FJgFmqNXVg7ulbIhGqVx48qvgnBGK9ovdaTclrAmH14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W4n/hZTsHN+VC8AixolMqqnFffaF9K2zxGqeFeBSrphPC1kRwUNlEeIQTV3TAGRFbM+o8y/t1R0hbgwNEWtC2AvIEpwYHPP+oT7ja9Umht3mO4P7oy77UgAeQU65VnatbmsVTADwhux3piuiqjj4rmTGe8anW57oHX+lct+XSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf1JhdDm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51364c3d5abso2712221e87.2;
        Fri, 08 Mar 2024 10:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709924234; x=1710529034; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJgFmqNXVg7ulbIhGqVx48qvgnBGK9ovdaTclrAmH14=;
        b=kf1JhdDmJlaIpU3VBjzwGeFuen+DpVS85iCt+qThum26VQjL24HD3GfvVi/oRJ4W9H
         4gAhfel8QrZutSUBTQHyBasYyk31ujPeVmTQrJO0O8/9xb5rwNStMMVkcCXIi9jwTsr2
         GyZJPXGuBpclSqdzpKUMtGoATf2M/8EA1j3KU76xPCQz9FieGRJU65/Z7Wp09aFTLu9H
         KrMZ1Z/NrSj2hy4v1FUQ0qBEN4rQtQnFRLYjWPbJcpemtwcXTp+5uuCcvr3x7PqmGd+f
         YLVPGXeuDNKjo9LaO4VQ0a+VP9LiokOldWWlw1LJdzDU/Wg1ZRJR2V8skrqzTgTA8On7
         Z5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709924234; x=1710529034;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJgFmqNXVg7ulbIhGqVx48qvgnBGK9ovdaTclrAmH14=;
        b=dUvRA1IB6wWXSrepokSXtQKykhydK5zxWIG3ubQKC7gCzY3lohv5QmPJNfcTkZTmY1
         RY65UU7GP7eS7gV+BGSoqf+rCCUcKhsbQQXenaCE6k0JU7MwPR1pJn4ngb4qs6oyIfIH
         kWZUGSrInH6N9J3nttGVOO78+IvVCygBSEudAaMDr4tbOLuVoj8bgdK6LtQ6OCmYMDmq
         c3VC0YqppuytsF9Y/dta5ZH+cOBjNCs5ZBEyv3XImGJp27Vq66lOlUxoWCRu6iGJVUKq
         7QJGswn1Zjze3QE2X1P7g81hsbTp+n9LAo3vyrlGJWla2jf1fy7HEjS1QUKeqBGSnb28
         f1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWyfT+S2NCPWzTmVpXUfz9pB0ShYTVizucjFwonQT6OZikJpAcIoYJYss+bz4/0BPwuWKQaT4wBNQLryah019vKE6gIcjLAZMy56jH1hq0VtiGi+IE46W1VkTAPYw++3tclwRsdGToUhtp/1dF7rv3hm1XW6aUzjbYVuixiKLzdWbxifwOBAR/cGpWxZ/nPmnT8rgmt0BG
X-Gm-Message-State: AOJu0Yz3JgFAN/J2AJXq1i7KjDkFPf0+YKtkh2P9HwIjJeeHmmzQbTw5
	5j9OlXZKWCsPQLZ/FEJ/OSEFmRlVuWOqAKlK9OEJpggatG0/5wPR
X-Google-Smtp-Source: AGHT+IFb+l5lb3Rt/se2MEwUbkeIsA8alEVe6QpXMRmHCrxeUIUjHWtLgHUhvNRZB35lAOZhG2h2Kg==
X-Received: by 2002:ac2:5f08:0:b0:513:1e47:bc5b with SMTP id 8-20020ac25f08000000b005131e47bc5bmr3833679lfq.25.1709924233403;
        Fri, 08 Mar 2024 10:57:13 -0800 (PST)
Received: from ?IPv6:2001:8a0:e60f:3100:f642:8b0a:d2f8:3e61? ([2001:8a0:e60f:3100:f642:8b0a:d2f8:3e61])
        by smtp.gmail.com with ESMTPSA id m24-20020a195218000000b005130bbcd263sm19374lfb.271.2024.03.08.10.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:57:12 -0800 (PST)
Message-ID: <e19cafe1a7933d1e35ee4715fa36df8090c100eb.camel@gmail.com>
Subject: Re: [PATCH v2] can: mcp251xfd: fix infinite loop when xmit fails
From: vitor <ivitro@gmail.com>
To: mkl@pengutronix.de, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Thomas Kopp
 <thomas.kopp@microchip.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 08 Mar 2024 18:57:10 +0000
In-Reply-To: <20240308151523.191860-1-ivitro@gmail.com>
References: <20240308151523.191860-1-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-08 at 15:15 +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> When the mcp251xfd_start_xmit() function fails, the driver stops
> processing messages and the interrupt routine does not return,
> running indefinitely even after killing the running application.
>=20
> Error messages:
> [=C2=A0 441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit:
> -16
> [=C2=A0 441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not
> empty. (seq=3D0x000017c7, tef_tail=3D0x000017cf, tef_head=3D0x000017d0,
> tx_head=3D0x000017d3).
> ... and repeat forever.
>=20
> The issue can be triggered when multiple devices share the same
> SPI interface. And there is concurrent access to the bus.
>=20
> The problem occurs because tx_ring->head increments even if
> mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> TX package while still expecting a response in
> mcp251xfd_handle_tefif_one().
>=20
> This patch resolves the issue by decreasing tx_ring->head if
> mcp251xfd_start_xmit() fails. With the fix, if we trigger the issue
> and
> the err =3D -EBUSY, the driver returns NETDEV_TX_BUSY. The network
> stack
> retries to transmit the message.
> Otherwise, it prints an error and discards the message.
>=20
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip
> MCP25xxFD SPI CAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>=20
> V1->V2:
> =C2=A0 - Return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() =3D=3D -EBUSY
> =C2=A0 - Rework the commit message to address the change above
> =C2=A0 - Change can_put_echo_skb() to be called after
> mcp251xfd_tx_obj_write() succeed. Otherwise, we get Kernel NULL
> pointer dereference error.
>=20
> =C2=A0drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 29 +++++++++++------=
-
> --
> =C2=A01 file changed, 16 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> index 160528d3cc26..0fdaececebdd 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> @@ -181,25 +181,28 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff
> *skb,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_obj =3D mcp251xfd_get_=
tx_obj_next(tx_ring);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mcp251xfd_tx_obj_from_skb=
(priv, tx_obj, skb, tx_ring->head);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Stop queue if we occupy the=
 complete TX FIFO */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_head =3D mcp251xfd_get=
_tx_head(tx_ring);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_ring->head++;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mcp251xfd_get_tx_free(tx_r=
ing) =3D=3D 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0netif_stop_queue(ndev);
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0frame_len =3D can_skb_get=
_frame_len(skb);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D can_put_echo_skb(skb, =
ndev, tx_head, frame_len);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!err)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0netdev_sent_queue(priv->ndev, frame_len);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_ring->head++;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D mcp251xfd_tx_obj_=
write(priv, tx_obj);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto out_err;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0tx_ring->head--;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NETDEV_TX_OK;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (err =3D=3D -EBUSY)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NE=
TDEV_TX_BUSY;

Missing the stats for dropped packages. I will add on v3.

> =C2=A0
> - out_err:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netdev_err(priv->ndev, "ERROR =
in %s: %d\n", __func__, err);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__,
> err);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0can_put_echo_skb(skb, ndev, tx_head, frame_len);

Not sure if it is save to call this here.

> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0/* Stop queue if we occupy the complete TX FIFO */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (mcp251xfd_get_tx_free(tx_ring) =3D=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netif_sto=
p_queue(ndev);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0netdev_sent_queue(priv->ndev, frame_len);

This is not correct. Should be called only if can_put_echo_skb()
succeed. I will fix this in v3.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NETDEV_TX_OK;
> =C2=A0}

Best regards,
Vitor Soares

