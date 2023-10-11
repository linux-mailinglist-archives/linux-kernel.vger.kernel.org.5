Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA07C5F90
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjJKVxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjJKVxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:53:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD5A9;
        Wed, 11 Oct 2023 14:53:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99de884ad25so44563866b.3;
        Wed, 11 Oct 2023 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697061211; x=1697666011; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk61Oui34cYd2D497FSomUJuk6Ez3oD0g+MbS48c0OI=;
        b=FFAvW+Agz6iXrjmajmZ9N5OHh8wiqGQOkhbdkbrpSPd8jKBFSLjKZcHcKsNEZ8snc2
         MmmPuUbJDsXGLpT5982UyU+L7T+f4OG/LzXbS0apf6WEfPBZ+WSqTV1Z+uRT+3iYFj4F
         3kVgb/3exz0YUP/2e/pePY5EalOxBf1r/aT8wPsytQVp63Ey5EAhR8pESGpts/HIGyB9
         Vc5NSqOB1bIx6BwyIZCJfg6a1c+lGhGm8fDvU9pnM+o13+kJfZT+d1HZnfI2t4JtCmIM
         1I1JKyEMN3CLa5kV2JNzltpYjVZHMmomBbNCVfZv6cUAvp8DHZHHShFitHHFzpcgbS3d
         2iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061211; x=1697666011;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wk61Oui34cYd2D497FSomUJuk6Ez3oD0g+MbS48c0OI=;
        b=icRN00sgWneHMFR2LY5T70Jfepu5EF9vKE7LBrBN3OL92Md2i7l6R7p9Rc4Co6OiDe
         GBdUiy7wwJs6rqvliy/xR9q6oubSU7ZfymOPDnB092ys6HUAFx1JxO3S1Szr0WiyiIQh
         UDl4ptTWw7C6d9YJEdOhgmbnnLWAnJwTmXwv1p6L3gPrjwrCd0sa1KTCxxghoasc6pRr
         Okv8jJIw6A0tvbfPlRk3y0gpnA8hSKpHAUgzGF/BGpxE9mGMpnlpf38ijELpi3Ex6q3B
         q376gdy7K2uz/NIz0GxOuxZI+uBD1+19Jpl67Q0UDFrgiOH75hcS9mR/hKwseb5fK+hr
         29yA==
X-Gm-Message-State: AOJu0YzFiCGnj/XWKfUjkJlFnCdFSSFdqDjRjnneuya5MPmrI9pDWyPv
        BnwC3lDIf5mnf+kkLnXAQCQ=
X-Google-Smtp-Source: AGHT+IGVnAq29JMbxyfSmfj4SDVv6KVOlkj+3dLI16KTIn3E3zl7iFe7YS/QTndQsKuTvjp+QDrNwQ==
X-Received: by 2002:a17:906:209a:b0:9ae:3f69:9b89 with SMTP id 26-20020a170906209a00b009ae3f699b89mr21354779ejq.7.1697061210928;
        Wed, 11 Oct 2023 14:53:30 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lc16-20020a170906dff000b0099c53c44083sm10185272ejc.79.2023.10.11.14.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:53:30 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:53:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: chipidea: Simplify Tegra DMA alignment code
Message-ID: <ZScZWFJCCMr7oWwX@orome.fritz.box>
References: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
 <a0d917d492b1f91ee0019e68b8e8bca9c585393f.1695934946.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/ARsLMUmfva5Ak1M"
Content-Disposition: inline
In-Reply-To: <a0d917d492b1f91ee0019e68b8e8bca9c585393f.1695934946.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/ARsLMUmfva5Ak1M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:06:03PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> The USB host on Tegra3 works with 32-bit alignment. Previous code tried
> to align the buffer, but it did align the wrapper struct instead, so
> the buffer was at a constant offset of 8 bytes (two pointers) from
> expected alignment.  Since kmalloc() guarantees at least 8-byte
> alignment already, the alignment-extending is removed.
>=20
> Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/usb/chipidea/host.c | 45 +++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index abddd39d1ff1..0cce19208370 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -30,8 +30,7 @@ struct ehci_ci_priv {
>  };
> =20
>  struct ci_hdrc_dma_aligned_buffer {
> -	void *kmalloc_ptr;
> -	void *old_xfer_buffer;
> +	void *original_buffer;
>  	u8 data[];
>  };
> =20
> @@ -380,60 +379,52 @@ static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
>  	return 0;
>  }
> =20
> -static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb)
> +static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb, bool copy_b=
ack)
>  {
>  	struct ci_hdrc_dma_aligned_buffer *temp;
> -	size_t length;
> =20
>  	if (!(urb->transfer_flags & URB_ALIGNED_TEMP_BUFFER))
>  		return;
> +	urb->transfer_flags &=3D ~URB_ALIGNED_TEMP_BUFFER;

This threw me off a bit until I realized it was already there
previously, just in a different place. Is there a particular reason why
this is moved?

Regardless, this looks fine, so:

Acked-by: Thierry Reding <treding@nvidia.com>

> =20
>  	temp =3D container_of(urb->transfer_buffer,
>  			    struct ci_hdrc_dma_aligned_buffer, data);
> +	urb->transfer_buffer =3D temp->original_buffer;
> +
> +	if (copy_back && usb_urb_dir_in(urb)) {
> +		size_t length;
> =20
> -	if (usb_urb_dir_in(urb)) {
>  		if (usb_pipeisoc(urb->pipe))
>  			length =3D urb->transfer_buffer_length;
>  		else
>  			length =3D urb->actual_length;
> =20
> -		memcpy(temp->old_xfer_buffer, temp->data, length);
> +		memcpy(temp->original_buffer, temp->data, length);
>  	}
> -	urb->transfer_buffer =3D temp->old_xfer_buffer;
> -	kfree(temp->kmalloc_ptr);
> =20
> -	urb->transfer_flags &=3D ~URB_ALIGNED_TEMP_BUFFER;
> +	kfree(temp);
>  }
> =20
>  static int ci_hdrc_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_f=
lags)
>  {
> -	struct ci_hdrc_dma_aligned_buffer *temp, *kmalloc_ptr;
> -	const unsigned int ci_hdrc_usb_dma_align =3D 32;
> -	size_t kmalloc_size;
> +	struct ci_hdrc_dma_aligned_buffer *temp;
> =20
>  	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length =3D=3D 0)
>  		return 0;
> -	if (!((uintptr_t)urb->transfer_buffer & (ci_hdrc_usb_dma_align - 1)) &&=
 !(urb->transfer_buffer_length & 3))
> +	if (IS_ALIGNED((uintptr_t)urb->transfer_buffer, 4)
> +	    && IS_ALIGNED(urb->transfer_buffer_length, 4))
>  		return 0;
> =20
> -	/* Allocate a buffer with enough padding for alignment */
> -	kmalloc_size =3D ALIGN(urb->transfer_buffer_length, 4) +
> -		       sizeof(struct ci_hdrc_dma_aligned_buffer) +
> -		       ci_hdrc_usb_dma_align - 1;
> -
> -	kmalloc_ptr =3D kmalloc(kmalloc_size, mem_flags);
> -	if (!kmalloc_ptr)
> +	temp =3D kmalloc(sizeof(*temp) + ALIGN(urb->transfer_buffer_length, 4),=
 mem_flags);
> +	if (!temp)
>  		return -ENOMEM;
> =20
> -	/* Position our struct dma_aligned_buffer such that data is aligned */
> -	temp =3D PTR_ALIGN(kmalloc_ptr + 1, ci_hdrc_usb_dma_align) - 1;
> -	temp->kmalloc_ptr =3D kmalloc_ptr;
> -	temp->old_xfer_buffer =3D urb->transfer_buffer;
>  	if (usb_urb_dir_out(urb))
>  		memcpy(temp->data, urb->transfer_buffer,
>  		       urb->transfer_buffer_length);
> +
> +	temp->original_buffer =3D urb->transfer_buffer;
>  	urb->transfer_buffer =3D temp->data;
> -
>  	urb->transfer_flags |=3D URB_ALIGNED_TEMP_BUFFER;
> =20
>  	return 0;
> @@ -450,7 +441,7 @@ static int ci_hdrc_map_urb_for_dma(struct usb_hcd *hc=
d, struct urb *urb,
> =20
>  	ret =3D usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
>  	if (ret)
> -		ci_hdrc_free_dma_aligned_buffer(urb);
> +		ci_hdrc_free_dma_aligned_buffer(urb, false);
> =20
>  	return ret;
>  }
> @@ -458,7 +449,7 @@ static int ci_hdrc_map_urb_for_dma(struct usb_hcd *hc=
d, struct urb *urb,
>  static void ci_hdrc_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *u=
rb)
>  {
>  	usb_hcd_unmap_urb_for_dma(hcd, urb);
> -	ci_hdrc_free_dma_aligned_buffer(urb);
> +	ci_hdrc_free_dma_aligned_buffer(urb, true);
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> --=20
> 2.39.2
>=20

--/ARsLMUmfva5Ak1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUnGVgACgkQ3SOs138+
s6GlQxAAs20l59FM+iP1WLLvyZghQ+/JR+8K027PE1dn0I5fXFgEopON1ZJeAPgO
SaCW6ZWeCUYSaGwrBhmaKrs6cgRIVu4UuIdpAnErTsztL7eZIz5+uEP0/gFAJHrn
8VNQG4Pe22rvRZkaKlGgN5G5sD8E+amQdVWJH/8gLGefjybKP7xwOYKGB0itjx78
wnaKT/2Av3Kjqdm2JIA1WzmSYPvDGl5OSmImtw6Plpi7OYrjfElX0ena+ONR75YR
utcL/LJmDvQ54vUiYqjW4E16nInpeMEYfTyS5ohP7HucLZMPIJEbSAPeFIDf2ONV
LQfA7Fo3QDcrc1H5q3Q1Hecv/LRE3DJMQ2e7JCNFfmvs1qcZ8uj63xf/2aiPqeaO
Hpw4AV/StGUjbuz/swkA3bodcJkxfGdja8DNKGZOGTwu6kRW2g/donM8cclgEYpz
Y6Dw62w7exHf+1n/fGnBYomLJW8LviX7kKzeXQCFl6iWRDjHrElmhK/5x4k/HeeL
FGIpyO29RU7FvvNYKT6rCnPHEXDlyvv/qPIgW1/JMvTcOFZHlhRy1FTB5b919Oc+
lfo9Elh4YwELcUrlT+Dz3P0GsNwmegbTw+SpsayEXVdtpCXF0Nfl3F716ws0j9wg
a2ZVTwrpnUC9q/fA8OYLW4+8lIxXI6u8LLjsQfAOm8spclhaXYY=
=go0n
-----END PGP SIGNATURE-----

--/ARsLMUmfva5Ak1M--
