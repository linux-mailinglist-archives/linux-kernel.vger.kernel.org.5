Return-Path: <linux-kernel+bounces-135751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C711A89CAC8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D132B25B89
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857A8143C7D;
	Mon,  8 Apr 2024 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DrXmJZ+v"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED5142915;
	Mon,  8 Apr 2024 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597249; cv=none; b=PFPoKiMcZ02W0LYXCTWFyzV0SnOrsDRUZMn7Em2qQc/HmKyOi5TJP0ZsM4e7LtEPms41KG5XpEVLIpLWNbgdN3JOQy/eiNqzPRiw3J7LcwceWRPzfiI4dQnDV2xg2u1IUm1YI7YyTYBURb9rsnlokeQg6FkDJwXJwAhVKUGb9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597249; c=relaxed/simple;
	bh=ycEuq9XAYdjVqKjZxvsc1TztcD1hPiLm41bxXcMv5Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q29KI0EruEKLi2GH23TFPM2FDaxmvI9M+hyrkVFcmbZhB3kzoXUdfLsR8MTOpDfhmLbT2T3jGIkbfQFUP7ow24xoUpJ14BnNZY5h3TrYBEVI3O8OqvdSATaQRDShA/Tm6PxESkdlNxWYz/nSar2+PNCSJ/sq7/uKjBY2SUjj+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DrXmJZ+v; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e455b630acso4850865ad.1;
        Mon, 08 Apr 2024 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712597247; x=1713202047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOjeDfz9E4F+jzvWRXwUZXbYmoM8nTnojNtQIe47BUs=;
        b=DrXmJZ+vl/pr8I8yyh4TeoI4BvhFJeHbJDRArp0Gmn+8r3kt3hvFW+x7Btz9stRgBJ
         6ekmB8D6FV4Hl7itWZh08cXTGZxD/IjrBVPBgZvBkKhASlPTXRQbbX+38VtJD2C8OEiU
         dVZbF7CYunrrxjTA/Z44Dm2IOEVyJuoxi95TJNBa6IiNAWHNEG20cckzcaKFzLYPybxq
         5vH0Dnffn2j5nvAo3AogW7QhFalQJogWtwW/0/xu3Eb6+uUaIrqqQtQ4sTcc4lcfyqrj
         bQekUHzYAdvUwL4/gk1rzd9YcC9Ws7+33f4SOhnCvymwHt5UYdHCAa4mbRO7dFAav4nY
         GsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597247; x=1713202047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOjeDfz9E4F+jzvWRXwUZXbYmoM8nTnojNtQIe47BUs=;
        b=lYWx1MELgIAZI3rMBYkZLRr+JRpq/gPU5ZQzs7Npj6C3lOeid9BJWhL0b1ymYJMOsM
         KUzuXyq329FvhOErk9pOmPgQyt4XIGizIXw6rMnRiGLok4kICPd6eQtNymFwC5UgbGXw
         GyOrj98D6yzx6j1l0aUGNTjXuotLTsksfxSXeZepsOD7SQ0cLBbYa7tmhtoeyG89ABdE
         ldYCEbNvXLBeP/BlwqRMW9lmdYNklrvjoL1xKRPVk50TZ/790PRQGhLiaih7GyRAmWFd
         oJ1l12Tl06taPYFw2jD888i931+YFbb/JT1vrSz4MKJfVKifnERZGTMXSyxARcL8PD3x
         wuVw==
X-Forwarded-Encrypted: i=1; AJvYcCVhnJOYOiMIvn+LyY8YqO6txEt2kpVZU5KQcnOXKCB4tTSbqKPBPwsLE45PCcI3C0Fb0rfCmKqgOLl4YFy9Vm9fhXKC35gBTn0i6i4fbz7tpWwWVNL1RK7uryDeCAClfuY3b0YnzSGrGA==
X-Gm-Message-State: AOJu0YzHsVDWJPYAE19KmzxwsjZlPUTTcIk5TSHY4oBsalM6mektbVgw
	cznebOinOvMVN9GhL/YG4FZvbgsrdUU41sBH/ZJdZFKRX1z2Chg8vv+N6KUSs8qlZE+hW7nAiLd
	aNb8NFQH3dQCWs6ZyXKywqh+nIrA=
X-Google-Smtp-Source: AGHT+IF8o23by08vrZR2GEbNpBf73nw0zhurJP4dptDChRyKgoq8H4Ozt0jNcKGtNTZll6pvAIltKtH5CZD77UZgbDw=
X-Received: by 2002:a17:902:c946:b0:1e4:24bc:48e with SMTP id
 i6-20020a170902c94600b001e424bc048emr3348565pla.22.1712597247611; Mon, 08 Apr
 2024 10:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-fix-secpwr-s4-v1-1-01aa7ee72c52@amlogic.com>
In-Reply-To: <20240408-fix-secpwr-s4-v1-1-01aa7ee72c52@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 8 Apr 2024 19:27:15 +0200
Message-ID: <CAFBinCD=xWuhoX9cWcKU3bSGcsDShKbxnMVTdyfD84AFZQn8aw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: fix S4 power-controller node
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 5:26=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> The power-controller module works well by adding its parent
> node secure-monitor.
>

Please add a Fixes tag here with the original commit where the
incorrectly placed node was added.
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-s4.dtsi
> index ce90b35686a2..24d00dce4969 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -65,10 +65,13 @@ xtal: xtal-clk {
>                 #clock-cells =3D <0>;
>         };
>
> -       pwrc: power-controller {
> -               compatible =3D "amlogic,meson-s4-pwrc";
> -               #power-domain-cells =3D <1>;
> -               status =3D "okay";
> +       sm: secure-monitor {
> +               compatible =3D "amlogic,meson-gxbb-sm";
> +
> +               pwrc: power-controller {
> +                       compatible =3D "amlogic,meson-s4-pwrc";
> +                       #power-domain-cells =3D <1>;
> +               };
In Documentation/devicetree/bindings/firmware/amlogic,meson-gxbb-sm.yaml
the hierarchy is:
firmware {
  secure-monitor {
     power-controller {
       ...
     }
  }
}

Is this patch correct (and the documentation needs to be adapted) or
is the documentation correct (and this patch has to be adapted)?

