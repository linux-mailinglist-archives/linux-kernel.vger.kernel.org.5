Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD47E8C46
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjKKTGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKKTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:06:20 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265152D64;
        Sat, 11 Nov 2023 11:06:17 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2E62D1C0050; Sat, 11 Nov 2023 20:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699729575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1Ok56Rxa7o9YZFTQsUYiUo6ZSUFj5ZWmdayEaAumNY=;
        b=Tmi4ac1VEDo6wc6Mo8igDplIbkAxQ/bOiCnwI7pi2lGAPxUEeGgaXR/dmjl5/nmOquANIi
        HIgMqgvcj16ic44ldaffG6S/UxLOF5DM7Ns+LavMunfDtV+qcHwVJ6xUs7+Puhc4yo/5WN
        Gbth6dbsNfDu1w5T7TvK8sFf8CgiJFw=
Date:   Sat, 11 Nov 2023 20:06:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Jeffrey Kardatzke <jkardatzke@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        John Stultz <jstultz@google.com>,
        Yong Wu <yong.wu@mediatek.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2,04/21] v4l: add documentation for secure memory flag
Message-ID: <ZU/D3iDxIW6Q8bOq@duo.ucw.cz>
References: <20231106120423.23364-1-yunfei.dong@mediatek.com>
 <20231106120423.23364-5-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Ju1/ro8SjlcVrbE1"
Content-Disposition: inline
In-Reply-To: <20231106120423.23364-5-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ju1/ro8SjlcVrbE1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jeffrey Kardatzke <jkardatzke@google.com>
>=20
> Adds documentation for V4L2_MEMORY_FLAG_SECURE.

> --- a/Documentation/userspace-api/media/v4l/buffer.rst
> +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> @@ -696,7 +696,7 @@ enum v4l2_memory
> =20
>  .. _memory-flags:
> =20
> -Memory Consistency Flags
> +Memory Flags
>  ------------------------
> =20
>  .. raw:: latex
> @@ -728,6 +728,12 @@ Memory Consistency Flags
>  	only if the buffer is used for :ref:`memory mapping <mmap>` I/O and the
>  	queue reports the :ref:`V4L2_BUF_CAP_SUPPORTS_MMAP_CACHE_HINTS
>  	<V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS>` capability.
> +    * .. _`V4L2-MEMORY-FLAG-SECURE`:
> +
> +      - ``V4L2_MEMORY_FLAG_SECURE``
> +      - 0x00000002
> +      - DMA bufs passed into the queue will be validated to ensure they =
were
> +	allocated from a secure dma-heap.

Could we get some more information somewhere? Why would userspace want
to work with "secure" DMA heaps? How exactly are they different from
others? What attacks are these secure against? What is goal of all
this? DRM?

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Ju1/ro8SjlcVrbE1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZU/QpgAKCRAw5/Bqldv6
8l8+AJ4oQv5JySuz32NLbVDCZIWsPN9wVwCfRl5hbQ5bVuuW7/o0JdBhSJsRFeA=
=R/8x
-----END PGP SIGNATURE-----

--Ju1/ro8SjlcVrbE1--
