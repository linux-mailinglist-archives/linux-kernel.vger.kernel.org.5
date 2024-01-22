Return-Path: <linux-kernel+bounces-32805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C3836089
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C43B2A4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ABF3A8D8;
	Mon, 22 Jan 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="vAc8dA6p"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD83A27B;
	Mon, 22 Jan 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921325; cv=none; b=EF2s1l/9oPSj43x5AMHtFrKw828VEpQjGG4DwfXNDGuesa3GnfUddSWMCH1W/h+ge9luF72RD1/5XxC7peU0iGTJjgRF5v1l6+MlN/YGVdQqylarSvxxTa2AkOfNW10ztQ6+HvVT6EyCOYVNjqbM/EcGdO+t9DoIpXw66TyaoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921325; c=relaxed/simple;
	bh=VhDdZP99VuXDG0YlPbtEE9DiHyXudxtC85wCWHCNp0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ec1wXUqCWO/pYQKZSf9Q6PD1TC1PBYR8m/b8E3iBLxF4/bQvwgvqPSHeCtiET8OkldowUSdFU1/CXOioTQROyK/+C62/nJtOWZTzFGSUo1DZklN6shtSiJS5sfWOuqTxGZZRCAZ0e9j9LcXnTS/JW3OBTE9TTINTTPgb3ebnlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=vAc8dA6p; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705921309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=733fDA1vC7zKwBluwpjfcq4TVRYfPXDC67NVY7T7aqQ=;
	b=vAc8dA6pC47aVOf5mjHAD4DKA4dRwEc+4dmRDZXuXgcDAjk3lQmBQyWLIwZ5ERx4utx0Nw
	GmrQH4cNNE5vM4boQ9Y3Sr2mh0SksOhCzqErNeuXRj+qkZFOizrQ8lJ3F9W8opk0sqCYPy
	MM6p+RcEXW2zqbDh8/mClEB2B4V2X14=
Message-ID: <442f69f31ece6d441f3dc41c3dfeb4dcf52c00b8.camel@crapouillou.net>
Subject: Re: [Linaro-mm-sig] [PATCH v5 1/6] dma-buf: Add
 dma_buf_{begin,end}_access()
From: Paul Cercueil <paul@crapouillou.net>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>,  Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Mon, 22 Jan 2024 12:01:47 +0100
In-Reply-To: <8035f515-591f-4c87-bf0a-23d5705d9b1c@gmail.com>
References: <20240119141402.44262-1-paul@crapouillou.net>
	 <20240119141402.44262-2-paul@crapouillou.net>
	 <8035f515-591f-4c87-bf0a-23d5705d9b1c@gmail.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Christian,

Le lundi 22 janvier 2024 =C3=A0 11:35 +0100, Christian K=C3=B6nig a =C3=A9c=
rit=C2=A0:
> Am 19.01.24 um 15:13 schrieb Paul Cercueil:
> > These functions should be used by device drivers when they start
> > and
> > stop accessing the data of DMABUF. It allows DMABUF importers to
> > cache
> > the dma_buf_attachment while ensuring that the data they want to
> > access
> > is available for their device when the DMA transfers take place.
>=20
> As Daniel already noted as well this is a complete no-go from the=20
> DMA-buf design point of view.

What do you mean "as Daniel already noted"? It was him who suggested
this.

>=20
> Regards,
> Christian.

Cheers,
-Paul

>=20
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >=20
> > ---
> > v5: New patch
> > ---
> > =C2=A0 drivers/dma-buf/dma-buf.c | 66
> > +++++++++++++++++++++++++++++++++++++++
> > =C2=A0 include/linux/dma-buf.h=C2=A0=C2=A0 | 37 ++++++++++++++++++++++
> > =C2=A0 2 files changed, 103 insertions(+)
> >=20
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 8fe5aa67b167..a8bab6c18fcd 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -830,6 +830,8 @@ static struct sg_table * __map_dma_buf(struct
> > dma_buf_attachment *attach,
> > =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_mmap()
> > =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_begin_cpu_access()
> > =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_end_cpu_access()
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_begin_access()
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_end_access()
> > =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_map_attachment_unlocke=
d()
> > =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_unmap_attachment_unloc=
ked()
> > =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 - dma_buf_vmap_unlocked()
> > @@ -1602,6 +1604,70 @@ void dma_buf_vunmap_unlocked(struct dma_buf
> > *dmabuf, struct iosys_map *map)
> > =C2=A0 }
> > =C2=A0 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF);
> > =C2=A0=20
> > +/**
> > + * @dma_buf_begin_access - Call before any hardware access from/to
> > the DMABUF
> > + * @attach:	[in]	attachment used for hardware access
> > + * @sg_table:	[in]	scatterlist used for the DMA transfer
> > + * @direction:=C2=A0 [in]=C2=A0=C2=A0=C2=A0 direction of DMA transfer
> > + */
> > +int dma_buf_begin_access(struct dma_buf_attachment *attach,
> > +			 struct sg_table *sgt, enum
> > dma_data_direction dir)
> > +{
> > +	struct dma_buf *dmabuf;
> > +	bool cookie;
> > +	int ret;
> > +
> > +	if (WARN_ON(!attach))
> > +		return -EINVAL;
> > +
> > +	dmabuf =3D attach->dmabuf;
> > +
> > +	if (!dmabuf->ops->begin_access)
> > +		return 0;
> > +
> > +	cookie =3D dma_fence_begin_signalling();
> > +	ret =3D dmabuf->ops->begin_access(attach, sgt, dir);
> > +	dma_fence_end_signalling(cookie);
> > +
> > +	if (WARN_ON_ONCE(ret))
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_begin_access, DMA_BUF);
> > +
> > +/**
> > + * @dma_buf_end_access - Call after any hardware access from/to
> > the DMABUF
> > + * @attach:	[in]	attachment used for hardware access
> > + * @sg_table:	[in]	scatterlist used for the DMA transfer
> > + * @direction:=C2=A0 [in]=C2=A0=C2=A0=C2=A0 direction of DMA transfer
> > + */
> > +int dma_buf_end_access(struct dma_buf_attachment *attach,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sg_table *sgt, enum
> > dma_data_direction dir)
> > +{
> > +	struct dma_buf *dmabuf;
> > +	bool cookie;
> > +	int ret;
> > +
> > +	if (WARN_ON(!attach))
> > +		return -EINVAL;
> > +
> > +	dmabuf =3D attach->dmabuf;
> > +
> > +	if (!dmabuf->ops->end_access)
> > +		return 0;
> > +
> > +	cookie =3D dma_fence_begin_signalling();
> > +	ret =3D dmabuf->ops->end_access(attach, sgt, dir);
> > +	dma_fence_end_signalling(cookie);
> > +
> > +	if (WARN_ON_ONCE(ret))
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_end_access, DMA_BUF);
> > +
> > =C2=A0 #ifdef CONFIG_DEBUG_FS
> > =C2=A0 static int dma_buf_debug_show(struct seq_file *s, void *unused)
> > =C2=A0 {
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 8ff4add71f88..8ba612c7cc16 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -246,6 +246,38 @@ struct dma_buf_ops {
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	int (*end_cpu_access)(struct dma_buf *, enum
> > dma_data_direction);
> > =C2=A0=20
> > +	/**
> > +	 * @begin_access:
> > +	 *
> > +	 * This is called from dma_buf_begin_access() when a
> > device driver
> > +	 * wants to access the data of the DMABUF. The exporter
> > can use this
> > +	 * to flush/sync the caches if needed.
> > +	 *
> > +	 * This callback is optional.
> > +	 *
> > +	 * Returns:
> > +	 *
> > +	 * 0 on success or a negative error code on failure.
> > +	 */
> > +	int (*begin_access)(struct dma_buf_attachment *, struct
> > sg_table *,
> > +			=C2=A0=C2=A0=C2=A0 enum dma_data_direction);
> > +
> > +	/**
> > +	 * @end_access:
> > +	 *
> > +	 * This is called from dma_buf_end_access() when a device
> > driver is
> > +	 * done accessing the data of the DMABUF. The exporter can
> > use this
> > +	 * to flush/sync the caches if needed.
> > +	 *
> > +	 * This callback is optional.
> > +	 *
> > +	 * Returns:
> > +	 *
> > +	 * 0 on success or a negative error code on failure.
> > +	 */
> > +	int (*end_access)(struct dma_buf_attachment *, struct
> > sg_table *,
> > +			=C2=A0 enum dma_data_direction);
> > +
> > =C2=A0=C2=A0	/**
> > =C2=A0=C2=A0	 * @mmap:
> > =C2=A0=C2=A0	 *
> > @@ -606,6 +638,11 @@ void dma_buf_detach(struct dma_buf *dmabuf,
> > =C2=A0 int dma_buf_pin(struct dma_buf_attachment *attach);
> > =C2=A0 void dma_buf_unpin(struct dma_buf_attachment *attach);
> > =C2=A0=20
> > +int dma_buf_begin_access(struct dma_buf_attachment *attach,
> > +			 struct sg_table *sgt, enum
> > dma_data_direction dir);
> > +int dma_buf_end_access(struct dma_buf_attachment *attach,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sg_table *sgt, enum
> > dma_data_direction dir);
> > +
> > =C2=A0 struct dma_buf *dma_buf_export(const struct dma_buf_export_info
> > *exp_info);
> > =C2=A0=20
> > =C2=A0 int dma_buf_fd(struct dma_buf *dmabuf, int flags);
>=20


