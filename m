Return-Path: <linux-kernel+bounces-8501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FADC81B8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647EC1C22ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD47AE94;
	Thu, 21 Dec 2023 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAPUkHd6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FB7AE87;
	Thu, 21 Dec 2023 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cd5cdba609so628816a12.0;
        Thu, 21 Dec 2023 05:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165939; x=1703770739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVUFSbN3qi21K+lCGgFuXM1K02jusWBDY0oqKAcbjUE=;
        b=QAPUkHd6JRzBTxtyg3IkME3wab2rzwrm5fQzYFTOaxES52XV1NNgRC2gFG/cNR/opt
         BMzge6g906prBOo9utL9hZiSNSH5tWpU9mHWAetFVrC6I1t2bIclrQ4s+wbmKpzuZ7UD
         1sHn/fafPWI2XZULxNyzmx3+ONGlN0V2fI5i43nMf7BnvguKwLpWKPaWMp09y+X3uDkK
         HVY4pVW0b4JAH7pogFi5eydce8rrJGueIPibnhYx+zHWGUdTO+ub8bR+k3SCR/hHlbmD
         CxqpUUCTKn4PLXsjWkrtfxtb7ie/2xnpl/mbSL1CVFL4lvRBGba13z7krCQEtfQlxNyj
         xZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165939; x=1703770739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVUFSbN3qi21K+lCGgFuXM1K02jusWBDY0oqKAcbjUE=;
        b=daRirpWoa5r9C0ktNRqY1QV06ziTH9FnJlpE+Q2f5ta8AZgzadA3oX3bapQOZa7Jo2
         SOk6sfM0SS6wGxkSnveouMiK3x8iuyV9ehzJZw+Wm3bPkwdt1h66f+qRX1o56zI69ZZT
         uRDa/wQF1CZvWHlHg2aNzfFmp0AJVYYH79OFtKIGwy4/3vF9J0GM5MVguvvgAWj70jvq
         Ix6kb0QLUv1Je3onQiTZwDfj8Fa96XgOWHaMTBcAdoqn8/C6ApwZ0HcFOYo0Iy0POSPZ
         vCK4DU25brp2TuWQH/OlnAhreKSexz79tDTjgWFg9NsDSTIGbDcG/wbf5g0y0+ZA3PD2
         VcOA==
X-Gm-Message-State: AOJu0YyX+KWqHsSXXL6vX/APxkWcA3yhDE+480FVxoJku9yjmZRqtlc7
	4ZnVMQTL57lU4o8ZTzM3uNIo8DszKq7y0848Nno=
X-Google-Smtp-Source: AGHT+IFlh/Oi4Rh9z2yexbUVp+/+hBYRZSKMbmJvkm1t1WKRzufF4OUG2BbIe7r4iun30lTocKIp+8mlYzXxvdOnkuE=
X-Received: by 2002:a17:90b:3648:b0:28b:6aa5:34a3 with SMTP id
 nh8-20020a17090b364800b0028b6aa534a3mr5032677pjb.60.1703165938655; Thu, 21
 Dec 2023 05:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
 <769a1510-f8d2-4095-9879-42f413141dee@gmail.com> <a240d2ac-db0e-481b-8d13-3ae76cfd2fe7@foss.st.com>
 <e5ba1e14-4bbf-43e3-933a-fee6d4b90641@gmail.com>
In-Reply-To: <e5ba1e14-4bbf-43e3-933a-fee6d4b90641@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 21 Dec 2023 07:38:47 -0600
Message-ID: <CAHCN7xJ3Ktn+TnoOYdnNvKTddGCfLp4OQ+gM0WonWj-aqnsGuA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add support for video hardware codec of
 STMicroelectronics STM32 SoC series
To: Alex Bee <knaerzche@gmail.com>
Cc: Hugues FRUCHET <hugues.fruchet@foss.st.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Marco Felsch <m.felsch@pengutronix.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>, 
	Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil@xs4all.nl>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-media@vger.kernel.org, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 7:31=E2=80=AFAM Alex Bee <knaerzche@gmail.com> wrot=
e:
>
> Hi Hugues,
>
> Am 21.12.23 um 14:08 schrieb Hugues FRUCHET:
> > Hi Alex,
> >
> > This is because VDEC and VENC are two separated IPs with their own
> > hardware resources and no links between both.
> > On future SoCs, VDEC can ship on its own, same for VENC.
> >
> I think that's what the driver is/was designed for :)
>
> I don't  think there _has_ to be a link between variants in the same file=
.
> For Rockchip we only had the issue that there _is_ a link (shared
> resources) between encoder and decoder and they had (for that reason) to =
be
> defined has a _single_ variant. And there is no reason you can ship decod=
er
> and encoder seperated when you have two variants (with different
> compatibles).
> For Rockchip and iMX those files are even containing variants for complet=
ly
> different generations / different SoCs. I had to cleanup this mess for

The i.MX8M Mini and Plus have different power domains for encoder and
decoders as well as different clocks.  Keeping them separate would
almost be necessary.

adam

> Rockchip once - and it was no fun :) Anyways: It's up to the maintainers =
I
> guess - I just wanted to ask if I missunderstand something here.
>
> Greetings,
>
> Alex
>
> > Hoping that this clarify.
> >
> > Best regards,
> > Hugues.
> >
> > On 12/21/23 13:40, Alex Bee wrote:
> >> Hi Hugues, Hi Nicolas,
> >>
> >> is there any specific reason I'm not understanding / seeing why this
> >> is added in two seperate vdec* / venc* files and not a single vpu*
> >> file? Is it only for the seperate clocks (-names) / irqs (-names) /
> >> callbacks? Those are defined per variant and perfectly fit in a
> >> single file holding one vdec and one venc variant.
> >>
> >> Alex
> >>
> >> Am 21.12.23 um 09:47 schrieb Hugues Fruchet:
> >>> This patchset introduces support for VDEC video hardware decoder
> >>> and VENC video hardware encoder of STMicroelectronics STM32MP25
> >>> SoC series.
> >>>
> >>> This initial support implements H264 decoding, VP8 decoding and
> >>> JPEG encoding.
> >>>
> >>> This has been tested on STM32MP257F-EV1 evaluation board.
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> =3D history =3D
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> version 5:
> >>>     - Precise that video decoding as been successfully tested up to
> >>> full HD
> >>>     - Add Nicolas Dufresne reviewed-by
> >>>
> >>> version 4:
> >>>     - Fix comments from Nicolas about dropping encoder raw steps
> >>>
> >>> version 3:
> >>>     - Fix remarks from Krzysztof Kozlowski:
> >>>      - drop "items", we keep simple enum in such case
> >>>      - drop second example - it is the same as the first
> >>>     - Drop unused node labels as suggested by Conor Dooley
> >>>     - Revisit min/max resolutions as suggested by Nicolas Dufresne
> >>>
> >>> version 2:
> >>>     - Fix remarks from Krzysztof Kozlowski on v1:
> >>>      - single video-codec binding for both VDEC/VENC
> >>>      - get rid of "-names"
> >>>      - use of generic node name "video-codec"
> >>>
> >>> version 1:
> >>>    - Initial submission
> >>>
> >>> Hugues Fruchet (5):
> >>>    dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
> >>>    media: hantro: add support for STM32MP25 VDEC
> >>>    media: hantro: add support for STM32MP25 VENC
> >>>    arm64: dts: st: add video decoder support to stm32mp255
> >>>    arm64: dts: st: add video encoder support to stm32mp255
> >>>
> >>>   .../media/st,stm32mp25-video-codec.yaml       |  50 ++++++++
> >>>   arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
> >>>   arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 +++
> >>>   drivers/media/platform/verisilicon/Kconfig    |  14 ++-
> >>>   drivers/media/platform/verisilicon/Makefile   |   4 +
> >>>   .../media/platform/verisilicon/hantro_drv.c   |   4 +
> >>>   .../media/platform/verisilicon/hantro_hw.h    |   2 +
> >>>   .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 ++++++++++++++
> >>>   .../platform/verisilicon/stm32mp25_venc_hw.c  | 115
> >>> ++++++++++++++++++
> >>>   9 files changed, 307 insertions(+), 3 deletions(-)
> >>>   create mode 100644
> >>> Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
> >>>   create mode 100644
> >>> drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
> >>>   create mode 100644
> >>> drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
> >>>
> >>

