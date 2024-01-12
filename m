Return-Path: <linux-kernel+bounces-24538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D05CD82BE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDE4B215E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C55B1E3;
	Fri, 12 Jan 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS0iao3U"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232857310;
	Fri, 12 Jan 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e80d40a41so8037524e87.1;
        Fri, 12 Jan 2024 02:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705053842; x=1705658642; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=49mGNK36uTAc2PcGxvuMH6FjMrZ7N2e/dp51dNcG2WI=;
        b=TS0iao3U15Q4mYmhJW2KtRm0i/xDGi7Tbkl9WyTW71DxaEpm5qQFe9qGmFEAgQ95Me
         tUi0usc5SFDOo2VIGCCW6gsbxfkTwsjKk54RFOuUA551usnSTeo5XH/w5yJKgJiuUw4r
         sSZzx+OzTKHu8tpjh4Zub38fFWWfTQDggVZTRUT4n3P/UZDFbk4dDgzk5ALHtb2qqsio
         5vWCG1nJbnM6Bw1nFqDnaNDf5mFeiYjyAFGR6QSgmrTqWtuWclCcDaHuVFFh1+H8jWRY
         HNsV+U/wVXI6LHSERyFmraMDXgWkfvCy8L6P+OYQMU2IBSO1wggWiE5qlIBn5BYphsSQ
         wl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053842; x=1705658642;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49mGNK36uTAc2PcGxvuMH6FjMrZ7N2e/dp51dNcG2WI=;
        b=VRtMt8eaamKvwXo3zsBgStBXMbmqM869AGGSX8QQdJPHVxfVbVV389+qMCcpNfkUTF
         TDvEhhPic2HC2qBNW8NA7uXCso0c3DbJELU0dvegH4fo3jfirpKeil2MjQxh4EoX0dSb
         t6Qzmf6VN/D2xgjbZpfRq4hJe4FWPaeyRJkIwnd9CUCfRgqYJCDwGx9fXtbd2+eo7iDF
         9n/bOL3PHnXHQk27DFoVOcAcRz8DlEOED+pmQImltQLYRLix6+a3iF1P6h97N/F4PgrT
         urU3z0v6zgtp6/i8bq61N8sN5GM+eYA2SQVa/N5cHqAEocwbrKlMdjuIUOyrglZxFuFz
         xW5A==
X-Gm-Message-State: AOJu0YxHuvvoKIRqLh6j1zFoHLe3DgaJ2q8fkuEbcmAa4lWxHaFfpguD
	09gY2RNarFkH2XEw/YluLVI=
X-Google-Smtp-Source: AGHT+IEJgqgQRPe4+wGucPThB/wEKQwuXAHrrbJUK/XGlr7TnjYBQAAXKDwmwnzWG8Ho0OJhEyyxYw==
X-Received: by 2002:a05:6512:3188:b0:50e:6b48:5407 with SMTP id i8-20020a056512318800b0050e6b485407mr667018lfe.82.1705053841920;
        Fri, 12 Jan 2024 02:04:01 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id y22-20020a056512335600b0050eea9541casm26727lfd.44.2024.01.12.02.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 02:04:01 -0800 (PST)
Date: Fri, 12 Jan 2024 12:03:57 +0200
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, <christian.koenig@amd.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
 <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 <tjmercier@google.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Vijayanand Jitta <quic_vjitta@quicinc.com>, Joakim Bech
 <joakim.bech@linaro.org>, Jeffrey Kardatzke <jkardatzke@google.com>, Pavel
 Machek <pavel@ucw.cz>, Simon Ser <contact@emersion.fr>,
 <jianjiao.zeng@mediatek.com>, <kuohong.wang@mediatek.com>,
 <youlin.pei@mediatek.com>
Subject: Re: [PATCH v4 0/7] dma-buf: heaps: Add restricted heap
Message-ID: <20240112120357.724e9326@eldfell>
In-Reply-To: <20240112092014.23999-1-yong.wu@mediatek.com>
References: <20240112092014.23999-1-yong.wu@mediatek.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lS=3R00MGWXjD0UrR5LXr4S";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/lS=3R00MGWXjD0UrR5LXr4S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jan 2024 17:20:07 +0800
Yong Wu <yong.wu@mediatek.com> wrote:

> The purpose of this patchset is for MediaTek secure video playback, and
> also to enable other potential uses of this in the future. The 'restricted
> dma-heap' will be used to allocate dma_buf objects that reference memory
> in the secure world that is inaccessible/unmappable by the non-secure
> (i.e. kernel/userspace) world.  That memory will be used by the secure/
> trusted world to store secure information (i.e. decrypted media content).
> The dma_bufs allocated from the kernel will be passed to V4L2 for video
> decoding (as input and output). They will also be used by the drm
> system for rendering of the content.
>=20
> This patchset adds two MediaTek restricted heaps and they will be used in
> v4l2[1] and drm[2].
> 1) restricted_mtk_cm: secure chunk memory for MediaTek SVP (Secure Video
>    Path). The buffer is reserved for the secure world after bootup and it
>    is used for vcodec's ES/working buffer;
> 2) restricted_mtk_cma: secure CMA memory for MediaTek SVP. This buffer is
>    dynamically reserved for the secure world and will be got when we start
>    playing secure videos. Once the security video playing is complete, the
>    CMA will be released. This heap is used for the vcodec's frame buffer.=
=20
>=20
> [1] https://lore.kernel.org/linux-mediatek/20231206081538.17056-1-yunfei.=
dong@mediatek.com/
> [2] https://lore.kernel.org/all/20231223182932.27683-1-jason-jh.lin@media=
tek.com/
>=20
> Change note:
> v4: 1) Rename the heap name from "secure" to "restricted". suggested from
>      Simon/Pekka. There are still several "secure" string in MTK file
>      since we use ARM platform in which we call this "secure world"/
>      "secure command".

Hi,

I am really happy about this name change, thank you.

It is unfortunate that ARM specifications use the word "secure", but so
be it. When referring to specs, it's good to use the spec wording.

In everything that is not a direct reference to some spec though it
would be nice to use the "restricted" terminology if possible. I
presume there are other vendors who use words other than what ARM uses
for similar concepts. A common vocabulary would be nice.


Thanks,
pq

> v3: https://lore.kernel.org/linux-mediatek/20231212024607.3681-1-yong.wu@=
mediatek.com/
>     1) Separate the secure heap to a common file(secure_heap.c) and mtk
>      special file (secure_heap_mtk.c),  and put all the tee related code
>      into our special file.
>     2) About dt-binding, Add "mediatek," prefix since this is Mediatek TEE
>      firmware definition.
>     3) Remove the normal CMA heap which is a draft for qcom.
>     Rebase on v6.7-rc1.
>=20
> v2: https://lore.kernel.org/linux-mediatek/20231111111559.8218-1-yong.wu@=
mediatek.com/
>     1) Move John's patches into the vcodec patchset since they use the new
>        dma heap interface directly.
>        https://lore.kernel.org/linux-mediatek/20231106120423.23364-1-yunf=
ei.dong@mediatek.com/
>     2) Reword the dt-binding description.
>     3) Rename the heap name from mtk_svp to secure_mtk_cm.
>        This means the current vcodec/DRM upstream code doesn't match this.
>     4) Add a normal CMA heap. currently it should be a draft version.
>     5) Regarding the UUID, I still use hard code, but put it in a private
>     data which allow the others could set their own UUID. What's more, UU=
ID
>     is necessary for the session with TEE. If we don't have it, we can't
>     communicate with the TEE, including the get_uuid interface, which tri=
es
>     to make uuid more generic, not working. If there is other way to make
>     UUID more general, please free to tell me.
>    =20
> v1: https://lore.kernel.org/linux-mediatek/20230911023038.30649-1-yong.wu=
@mediatek.com/
>     Base on v6.6-rc1.
>=20
> Yong Wu (7):
>   dt-bindings: reserved-memory: Add mediatek,dynamic-restricted-region
>   dma-buf: heaps: Initialize a restricted heap
>   dma-buf: heaps: restricted_heap: Add private heap ops
>   dma-buf: heaps: restricted_heap: Add dma_ops
>   dma-buf: heaps: restricted_heap: Add MediaTek restricted heap and
>     heap_init
>   dma-buf: heaps: restricted_heap_mtk: Add TEE memory service call
>   dma_buf: heaps: restricted_heap_mtk: Add a new CMA heap
>=20
>  .../mediatek,dynamic-restricted-region.yaml   |  43 +++
>  drivers/dma-buf/heaps/Kconfig                 |  16 +
>  drivers/dma-buf/heaps/Makefile                |   4 +-
>  drivers/dma-buf/heaps/restricted_heap.c       | 237 +++++++++++++
>  drivers/dma-buf/heaps/restricted_heap.h       |  43 +++
>  drivers/dma-buf/heaps/restricted_heap_mtk.c   | 322 ++++++++++++++++++
>  6 files changed, 664 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/med=
iatek,dynamic-restricted-region.yaml
>  create mode 100644 drivers/dma-buf/heaps/restricted_heap.c
>  create mode 100644 drivers/dma-buf/heaps/restricted_heap.h
>  create mode 100644 drivers/dma-buf/heaps/restricted_heap_mtk.c
>=20


--Sig_/lS=3R00MGWXjD0UrR5LXr4S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmWhDo0ACgkQI1/ltBGq
qqdgnhAAiXIHptPG8WhqVlmOGF8J+Dj7PxjrLasFg2BG/gbUDAM2FICO1VBkblIw
bW1+LqpcdVG+FBs/hGrQOvEblaiIKjMXf5jyNnqPun4xGzi4VggC3sU7erHyIaAb
bLqfGVzrG782jns8Ibj9AeX1fck6aooUm8yD6w5JvGJRKRNIXKIeGPZrRkiotfnn
0NcTZ4BVoTufB5dzYgJABuiTmk1OyT4QkCVmVVE0mVn4tTc8Yd+s4m3rXqr/r3YE
A0geZB/426wfXy6oxNmf0ftQzsyEIcVP/WZJZKtbh6rnXQ2RcMkK38wTTG0Bmyuf
F1FW2L0GEyile6Vm6DyRJf97UQSzWCMraDUJKEd9+AbyjbreEnSUSL5WnPpWTbND
lmsCrC1rVM+/hTOD7or/0mF6kp2WgfSaaH+BhrkvDb8MGjj/84yEs4v0jAwBM5y4
knMaP00XF33xsX4OWEWbjniT+ZCdl9lhrGju9A+0+ZDTH+2LKAuzF5Rq9GgzWUzD
NqoAZ3aLTUS6KdLfjG6Dzz+eLtjrmOcOcP0gdxKbObO5DXo3yL/r3WZyGDoBDDNr
Ko38kjrDz+kuAsfKRzu1tDbPLnJLnVyt9rBl4NiD5Gl3BrJv0WvFRtuyzYrlNKHU
M5t91RcbiaPApyXCZT0eXqefR5B27nW2e20Kqcf3kEPh+dsLVzc=
=Y8bP
-----END PGP SIGNATURE-----

--Sig_/lS=3R00MGWXjD0UrR5LXr4S--

