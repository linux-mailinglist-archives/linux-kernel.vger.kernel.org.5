Return-Path: <linux-kernel+bounces-145906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F868A5C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7612E1C210C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3994157482;
	Mon, 15 Apr 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rdukYCQh"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB8156C53;
	Mon, 15 Apr 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215218; cv=none; b=PfXHU36jjkHUx8fwNd1DsbbPknLMFXNgJf9Kh6sM5IS+tLFxsVYHzl+H8CXUUhgQc0rV3KSmq+aETHIhbpiv+rwSHvaTxbNPOwGa8aopDm/5KYuFYGpy9ZfN8ql+qaJxjVuH4s39MS8jG4zrRJ6lw89cTWwY8Jq7uS5RDHjkPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215218; c=relaxed/simple;
	bh=QK/YnNEsRDQzA+VI9ZfCIug3P5VhevsltSl+SmjeDe0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=hzNApZIFHBIzCRrVkeu1qlOh2GfZH1MGwgHOVmXbPfJxbTGYbfUry49ojrewFBsgfTXPRDf76xK7onjQrEAEePBYWoFQZAFzgr3uqDB5Z/xPElJIG+sO1lkwy9/toZ6f1tcDNhK1Tf9CH3BE0l77pJKDqQkGPrecjNZOe1O2qRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=fail (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rdukYCQh reason="signature verification failed"; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F57F497;
	Mon, 15 Apr 2024 23:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713215167;
	bh=QK/YnNEsRDQzA+VI9ZfCIug3P5VhevsltSl+SmjeDe0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rdukYCQh9mMFKAPdTqd4jo4lB4a4B7xptpHd357YCY6nsrtHDE8p4O2e61Yb+mMxi
	 yKJPDLBT5H6E9wcVtgSM3TW7Vas5B4YrUJkgnLXrP6kJ0tc0rBjudUOeDKylS3L9Le
	 RHF8woqIolcFMRosZ1uhKhaSSd4+78XmA8SkQZdg=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415-fix-cocci-v1-4-477afb23728b@chromium.org>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org> <20240415-fix-cocci-v1-4-477afb23728b@chromium.org>
Subject: Re: [PATCH 04/35] media: uvcvideo: Use max() macro
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
To: Abylay Ospan <aospan@netup.ru>, Alain Volmat <alain.volmat@foss.st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Benjamin Mugnier <benjamin.mugnier@foss.st.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Dmitry Osipenko <digetx@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>, Hugues Fruchet <hugues.fruchet@foss.st.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Martin Tuma <martin.tuma@digiteqautomotive.com>, Matthi
 as Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Pavel Machek <pavel@ucw.cz>, Ricardo Ribalda <ribalda@chromium.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Samuel Holland <samuel@sholland.org>, Sergey Kozlov <serjk@netup.ru>, Sowjanya Komatineni <skomatineni@nvidia.com>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Sylvain Petinot <sylvain.petinot@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>
Date: Mon, 15 Apr 2024 22:06:49 +0100
Message-ID: <171321520986.2333277.5902882675169324919@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Ricardo Ribalda (2024-04-15 20:34:21)
> It makes the code slightly more clear and makes cocci incredibly happy:
>=20
> drivers/media/usb/uvc/uvc_ctrl.c:839:22-23: WARNING opportunity for max()
>=20
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc=
_ctrl.c
> index a4a987913430..4b685f883e4d 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -836,7 +836,7 @@ static s32 uvc_get_le_value(struct uvc_control_mappin=
g *mapping,
>         while (1) {
>                 u8 byte =3D *data & mask;
>                 value |=3D offset > 0 ? (byte >> offset) : (byte << (-off=
set));
> -               bits -=3D 8 - (offset > 0 ? offset : 0);
> +               bits -=3D 8 - max(offset, 0);

This looks semantically the same to me so:


Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>                 if (bits <=3D 0)
>                         break;
> =20
>=20
> --=20
> 2.44.0.683.g7961c838ac-goog
>

