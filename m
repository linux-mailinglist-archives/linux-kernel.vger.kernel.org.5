Return-Path: <linux-kernel+bounces-137878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BD89E8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D76A286B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D00C157;
	Wed, 10 Apr 2024 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUGE75SO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BC8F44;
	Wed, 10 Apr 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722964; cv=none; b=j3LhVIZSxEz3zdCTedZJEWJkvuiGm3d9mCWzbVbdSduMpG1RIiUummkYPUcI1x9/echo3/Pai061KXiFamM5QGz71n3+WtWOdIOs6qsbHfvIw/ya7460ai7NFmoATjxAe4fCQcuzdJo+IXt/mNiwaVE5GDFjsWDf6KGL1k0CqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722964; c=relaxed/simple;
	bh=8w/BdtBmOjOFnNyWhqSdLs2iYk08/1oMEjepAgqZSJ4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=smSU90LcElZzM+4t4ZCB7+2qSmnG8MMqsUtWM90vqgrS+H177VKU7/y7yjN1Vvkh0hahVSidrQR0cKG2s1UxETJOHLOM+u+f10NOHFYXdj+0rpf6xwJFZZzd5hjwcGOhb8tA/V4X/nTMtBwLZsgrtn+ZPmUm8j8WYqqPXK3CMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUGE75SO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34641b7c49aso717827f8f.2;
        Tue, 09 Apr 2024 21:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712722961; x=1713327761; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50/EoYp4xiPcQjk7THZgfgs+ueFYqdmiSEQ2Y/A5NR4=;
        b=VUGE75SOYQyibLm8h71XMlrmnXGMiMslaF5LPny+V5DBBJ0PTyW6GHL+3BdzYUNzM+
         fBOo+im7vwb9M+7QWFB1qhshAKV/UmOky9xML0LY74hqN0CBGcwBK018z7fa5uF7Qw/b
         WepuEU/pl95JumFNLjDyeUavlsK7L0xepNs6zfB5Cz9I2jj7HmCozLqWDVehUyih518X
         1bEBme+1kLjEvmEdxK0+hW3Tn/GyTY+whJBu/bmEEIdYKzGcXlDuC4d1U48qqd8H3btE
         gvmghnAzWvcmArcrKSKaYwj8uy/XZBtcDym6rg9msTxefX9A7JnuVRwm5HRqRvYy83mc
         hMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712722961; x=1713327761;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50/EoYp4xiPcQjk7THZgfgs+ueFYqdmiSEQ2Y/A5NR4=;
        b=UF+ZEyz4stmkYbVSIrFvs4sgVVp0V+lXPEnFG6TNASjh+tCFKc0gpf6rHWvustqxSq
         oiywyV18EVSvnPdKprhaS1ONaRfvm8F57SFLuGgzgcwC/oGe+kVppSV4clxq3rWngd2g
         MMOzVALSLLnAt2wLdMY6i41zrdeEOnx8hIXu6YKZZuoltxLjXxqatU9lAywsJfVtVgZn
         L61VR+ZjkYy/vrhQQI1+ktOfSZySTAsYB7OuNvdJzLI93n6Z8cT4tEnQFEEDamAYxvBm
         4U5zke1rb4AR5o/FtzSTSV74ItN3TTX4bZWMiUt8X2wwLgEtLgjYflDqNsboFSwQZgbP
         hX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtPE972roTy2WhR214T4fbVQN7A+CCrxkECZGftEY4UHgJlQ7qegUZHFQcX7HTC1YnL26WfFqXsE/HgkT4Kms2/YF4aHUqgP1NP0Z+n3uOEVc+BmRmwMVhrPtvtNoFqfjg1Lb+GOuUjA==
X-Gm-Message-State: AOJu0YyNIpPs/ovQ6Zk3Yw38mT4aMgJoR3yAM4+VmDkFqfrocEpYJxhf
	Z9SjXyrQIU4oqFPlP2iptMuS8Znb6qAoCgWRP5OIA7dBVNx++PFB
X-Google-Smtp-Source: AGHT+IHhKHEr3v3LDAgyhKHwIE9KipXbIkSHGprCwjFscoVbk1+9ZU+3a0NumbkHPHLpvO0f/FlwAg==
X-Received: by 2002:adf:fc4b:0:b0:343:7d3c:ddcd with SMTP id e11-20020adffc4b000000b003437d3cddcdmr964972wrs.1.1712722961051;
        Tue, 09 Apr 2024 21:22:41 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d638d000000b00343ad4bca7dsm12898554wru.85.2024.04.09.21.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 21:22:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 1/2] dt-bindings: panel-simple-dsi: add New Khadas TS050
 panel bindings
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20240409082641.359627-1-jacobe.zang@wesion.com>
Date: Wed, 10 Apr 2024 08:22:25 +0400
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Neil Armstrong <narmstrong@baylibre.com>,
 David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 quic_jesszhan@quicinc.com,
 sam@ravnborg.org,
 nick@khadas.com,
 thierry.reding@gmail.com,
 dri-devel@lists.freedesktop.org,
 devicetree <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 AML <linux-amlogic@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CCAF214-09FE-4580-99CD-AB95E78FFB8F@gmail.com>
References: <20240409082641.359627-1-jacobe.zang@wesion.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

> On 9 Apr 2024, at 12:26=E2=80=AFPM, Jacobe Zang =
<jacobe.zang@wesion.com> wrote:
>=20
> This add the bindings for the New Khadas TS050 1080x1920 5" LCD DSI =
panel
> designed to work with the Khadas VIM3 and VIM3L Single Board =
Computers.
>=20
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git =
a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml =
b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> index f9160d7bac3ca..e194309f31b72 100644
> --- =
a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> +++ =
b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> @@ -36,6 +36,8 @@ properties:
>       - jdi,fhd-r63452
>         # Khadas TS050 5" 1080x1920 LCD panel
>       - khadas,ts050
> +        # Khadas NEW TS050 5" 1080x1920 LCD panel
> +      - khadas,newts050

Products are only new until they are old. At some future point there =
will
inevitably be a third iteration requiring a =E2=80=98new new=E2=80=99 =
name. IMHO it would
be better to use something like khadas,ts050v2.

CH.

>         # Kingdisplay KD097D04 9.7" 1536x2048 TFT LCD panel
>       - kingdisplay,kd097d04
>         # LG ACX467AKM-7 4.95" 1080=C3=971920 LCD Panel
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic


