Return-Path: <linux-kernel+bounces-147560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F618A763F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343291C22B46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96F69946;
	Tue, 16 Apr 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKkfCZ7n"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86358203;
	Tue, 16 Apr 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302333; cv=none; b=WDHqd/6/RXCmYdOnG7rS9zlv88ypBQza+pl2914L8swwj87AfBjZnbzc383LBoGQnPTt+PbFWzV9uSQKtJFyQSsHIAz30K48CbLGWF7Z1BlbZk3OGof8LixH7pHkdhXM0+bU+MMPXalfvY6RUxSV2BEm5aQP9pTnBsJnYv/LUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302333; c=relaxed/simple;
	bh=rHxBWPbUv6UV42+sEgbA1iJcX867tFp5OytmZQZ3UGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afbRBju0EdysIdbh/hBKz4Uze/zHTsD7H4A5QS5SLHxfIygdWZ77rqDvuCLaqFcK0Zs2ofRZCHJq5T31G85LnZJwn9pWrb9va0CvvKnY2hwbAjdablxL5+KdkHawLpFkLU8Z9/a7trLAD8cxJiuHSyKlUDXIcyBa6c/tQV1MUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKkfCZ7n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2aa67da7a1dso1468853a91.3;
        Tue, 16 Apr 2024 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713302331; x=1713907131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBEr7AmEEZkKSiw3BsMpmaMNJ9Caj0ON73VIII8SWsI=;
        b=iKkfCZ7nBgrWRgs8tRnni+CY+zd1ab1GbRxrFerN8YH5NYScv23E3vKlnO5mrMiiub
         V75QOjMyzdNtdOIHuEQFrIa7Iogmt3y4s/iISfjZxZUKsF5sCMTZy8lYqEIbrSDqxlaH
         0Jw+9LYAiLNbhR9NMOtM+A/p4RlcagDykwWX2PmSRMjqu2IkeBD22pCLOz+MjI+kRCsT
         wEx2z1CrTD8nrhhHMz1fPljL7RZdM6Z4ccAcAEAImzni2ZhF0Gn5ILU6qrHzxVWZYyf/
         Ex/V/mJNGPrH99/C9w/AxziQCoZc8I67SLzraAn7Rlyt5X6uGsTnHweXgaQ1XOy/wCSV
         U9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713302331; x=1713907131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBEr7AmEEZkKSiw3BsMpmaMNJ9Caj0ON73VIII8SWsI=;
        b=V5hA/f4Mds2yYfnlZzuJg2M1QlbpXVR0k00UbK5w2Pn18xFZaWAN7nWimYVM/9iSR4
         U1FbZYzXyhFlPYAE780JzZbxh0+VBntWRAlUQHRof2j/l606PXAEd5wbtL6VxIs2X6IN
         4btO8dSX5WBtdLewQsWwMg5Kj7qAk68TND6vhEf4Nji7yIFQKVog0avtkNhDyxaOPYW7
         lsKDfI38jxqqehXV+zhv8BHzokfdsn5wcwC4HctFVhqH3VS4SjWbcxCx2emjRD58fn/S
         xiwzeEpCSKfENWd6YC5RAqS6NQSqk9CsGnbLkgFZvrhINEmcruFqXt7L4hadhb8XxUfB
         j8IA==
X-Forwarded-Encrypted: i=1; AJvYcCXfw36PPHVnyxefr+0hAsn7DFxFtKjmwX02wh0WrlgkJYxv63RWGXWHr0RnlqAezIWi2rUQ7KsWbtNlSxLiQKussFgwhXeAFQd7jdAFd3WG6Z1nBGpwABTI3aMa1kVz5g86x+s0OMXDsA==
X-Gm-Message-State: AOJu0YxVgvAw34aS/FSYjOjfUcNufiKBAMsVISKXvh4HuaSkH9NZmHou
	+SpHwYVpPg4loFSZQrg7CwgS//5X+mML6E7LYJ3jBx9ICIrAxO3fjkLlrPsS8hTJLImQFRg3igD
	ZWUKBG42R959i8j/V2aQNNZgDpac=
X-Google-Smtp-Source: AGHT+IFhlEFxkQR+ieC/Pa0fKkP87ACk2PMEqPN62geu1ZxkPfEDzM2tLQRrA2jUzsAT+yFWyAIlwAZgs2PhJ+8rSX4=
X-Received: by 2002:a17:90b:180d:b0:29f:7fad:ba50 with SMTP id
 lw13-20020a17090b180d00b0029f7fadba50mr13315078pjb.8.1713302330612; Tue, 16
 Apr 2024 14:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305004859.201085-1-aford173@gmail.com> <20240305004859.201085-2-aford173@gmail.com>
In-Reply-To: <20240305004859.201085-2-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 16 Apr 2024 16:18:38 -0500
Message-ID: <CAHCN7xLsEvP0A3mQJRzX=nXGr30WD4RU9vQVw9ynqzSi6cDNRg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] arm64: dts: imx8mp-beacon-kit: Enable HDMI bridge HPD
To: dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com, laurent.pinchart@ideasonboard.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 6:49=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> The DSI to HDMI bridge supports hot-plut-detect, but the
> driver didn't previously support a shared IRQ GPIO.  With
> the driver updated, the interrupt can be added to the bridge.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Shawn,

Patch 1/2 has been applied and sits in linux-next.  Are you OK to
apply this to the IMX branch so the hot-plug detection can work?

Thank you,

adam

adam
> ---
> V2:  No Change
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/a=
rm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> index a08057410bde..fba8fd04398d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -304,6 +304,8 @@ adv_bridge: hdmi@3d {
>                 compatible =3D "adi,adv7535";
>                 reg =3D <0x3d>, <0x3c>, <0x3e>, <0x3f>;
>                 reg-names =3D "main", "cec", "edid", "packet";
> +               interrupt-parent =3D <&gpio4>;
> +               interrupts =3D <27 IRQ_TYPE_EDGE_FALLING>;
>                 adi,dsi-lanes =3D <4>;
>                 #sound-dai-cells =3D <0>;
>
> --
> 2.43.0
>

