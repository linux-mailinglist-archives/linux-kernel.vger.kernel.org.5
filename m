Return-Path: <linux-kernel+bounces-7306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3F81A56A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633321F26BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BFF46425;
	Wed, 20 Dec 2023 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GMlIvPix"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43241763;
	Wed, 20 Dec 2023 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703090242;
	bh=pvibR0nQA9GDkxI5bQPaqCc+AIH4+2nJTGzFe8u/X/U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GMlIvPixQSMHnq7CFgBfdPCbWcFBg9f4pftaiB69SPkKYKZOaPRo4Pdt1LyTHSqrD
	 8M7WsdN3jDfpS87hNjDXzNmRDG3xcAWYpt9IAfMkbo2lLnISVNI58j2wdEQRQJ0yLb
	 m3/5FCt1RQXxVBdmvVCtsHUasZaQVzU/OMGGqA/8RAxbYaRC7e6KRyJfZsjNLCm6hL
	 OHjC0V+0ZB9b0qcr0lNTyE7W8p8iGzRLLHxocP0by40jfoxPYFQZkNTFUlzFmVO+YE
	 GoqTifXTDbW3kBW9+cJ05cD3P+xXDRZY0BIZhfoLc6wEiOiyJnxD7G3oknzolWKpEr
	 mKJRHIoThHdng==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 04A4737814A9;
	Wed, 20 Dec 2023 16:37:18 +0000 (UTC)
Message-ID: <f8205a1ba599b354032d88dc16b0b6b88f8c2cf8.camel@collabora.com>
Subject: Re: [PATCH v4 0/5] Add support for video hardware codec of
 STMicroelectronics STM32 SoC series
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Hugues Fruchet <hugues.fruchet@foss.st.com>, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Benjamin Mugnier
 <benjamin.mugnier@foss.st.com>,  Heiko Stuebner <heiko@sntech.de>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-media@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
Cc: Marco Felsch <m.felsch@pengutronix.de>, Adam Ford <aford173@gmail.com>
Date: Wed, 20 Dec 2023 11:37:14 -0500
In-Reply-To: <20231220152732.2138260-1-hugues.fruchet@foss.st.com>
References: <20231220152732.2138260-1-hugues.fruchet@foss.st.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mercredi 20 d=C3=A9cembre 2023 =C3=A0 16:27 +0100, Hugues Fruchet a =C3=
=A9crit=C2=A0:
> This patchset introduces support for VDEC video hardware decoder
> and VENC video hardware encoder of STMicroelectronics STM32MP25
> SoC series.
>=20
> This initial support implements H264 decoding, VP8 decoding and
> JPEG encoding.
>=20
> This has been tested on STM32MP257F-EV1 evaluation board.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D history =3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> version 4:
>    - Fix comments from Nicolas about dropping encoder raw steps

As discussed in chat, The 4K resolution didn't work correctly, so all the
resolution have been set back to 1080p.

>=20
> version 3:
>    - Fix remarks from Krzysztof Kozlowski:
>     - drop "items", we keep simple enum in such case
>     - drop second example - it is the same as the first
>    - Drop unused node labels as suggested by Conor Dooley
>    - Revisit min/max resolutions as suggested by Nicolas Dufresne
>=20
> version 2:
>    - Fix remarks from Krzysztof Kozlowski on v1:
>     - single video-codec binding for both VDEC/VENC
>     - get rid of "-names"
>     - use of generic node name "video-codec"
>=20
> version 1:
>   - Initial submission
>=20
> Hugues Fruchet (5):
>   dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
>   media: hantro: add support for STM32MP25 VDEC
>   media: hantro: add support for STM32MP25 VENC
>   arm64: dts: st: add video decoder support to stm32mp255
>   arm64: dts: st: add video encoder support to stm32mp255
>=20
>  .../media/st,stm32mp25-video-codec.yaml       |  50 ++++++++
>  arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
>  arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 +++
>  drivers/media/platform/verisilicon/Kconfig    |  14 ++-
>  drivers/media/platform/verisilicon/Makefile   |   4 +
>  .../media/platform/verisilicon/hantro_drv.c   |   4 +
>  .../media/platform/verisilicon/hantro_hw.h    |   2 +
>  .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 ++++++++++++++
>  .../platform/verisilicon/stm32mp25_venc_hw.c  | 115 ++++++++++++++++++
>  9 files changed, 307 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-=
video-codec.yaml
>  create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vdec_hw.=
c
>  create mode 100644 drivers/media/platform/verisilicon/stm32mp25_venc_hw.=
c
>=20


