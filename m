Return-Path: <linux-kernel+bounces-20967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652708287DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F81E286533
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A2239AC2;
	Tue,  9 Jan 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7IxSwhN"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969C38FB0;
	Tue,  9 Jan 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28b1095064so321723266b.2;
        Tue, 09 Jan 2024 06:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704809779; x=1705414579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfKKmsgrBNevkxdWqBtR6SySOi1WLHhsxeOVYSFipik=;
        b=b7IxSwhNwiEalVIX272dphlPd0yyO9OZBc52kNX/2l8oAHsLCbcjxf+GSokwbPLmLI
         STKCgCXEHiCmNmWRjuw2ijkKJFuXQwC6yWXsCj6VI4rs+WvFOEsQf5NW2kDC1LZl+cJ0
         NXY4InjFXq1rZ96AymBuyHJCp2SOsW+QnG+E/FhW9Np6UpWvRgEtSZKCFmzP2OFhZRad
         T1bU3GuGCvwTYmF9iudUm8YHpCCBjQkf9dc+TCIhKJJgm1I0Yr7WBmvHOmMPqbQkle7c
         miNMM7yvjQ9U37Qjjeo+txkd71wM9/6JHlNco3dndBDtmDLweuP6+Oh5nLv3GgAu0v3s
         fBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809779; x=1705414579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfKKmsgrBNevkxdWqBtR6SySOi1WLHhsxeOVYSFipik=;
        b=pwxunlVGiMcxM2tBTneY/k6KiIJX0WgO+ImQW7Jmxx/jii/fc1dOQVVyyHTuyq5nyB
         8TmXqiPDlojYHSrgg/9lo4kMEq9LFoGepYKKGfvJ/9YCVglT1VSA4Bus0x9rb4hDdN/r
         clgh0FCg9WruiyC2v62FjI4rCiZBa4aZCsiuenk4055JaZqnTUaS19I0W7iokJjXjZig
         uZ/sBJF6pL/Mw8tV/wWP+slgO/I6xURRwzLh+5ZxpgTU/7YiegHOB50l16vDStNApPAf
         2qII8r2DuT6zPay1fGaFG7VBEFaqFv4fMqdv9m8KtruK289MU8U5uXA0/14ndI0TXOCx
         4Y4Q==
X-Gm-Message-State: AOJu0YyeT6iVcZQjlUHL71ATgEfKDQdxVDHicwwYipTl//8mfaI3zEgn
	81xGTtsYbCGR81w2kip3IOFVJqhovKzaaYdvN0w=
X-Google-Smtp-Source: AGHT+IHrnXDoXiFmgZB8pnUib0FZSixSpHYIUBlJTfVPoTkImZsXEmElnr3lXwcWDIqgM9foKbqDkNseDvscZLyDkgE=
X-Received: by 2002:a17:907:2d09:b0:a29:1419:f522 with SMTP id
 gs9-20020a1709072d0900b00a291419f522mr330417ejc.72.1704809778626; Tue, 09 Jan
 2024 06:16:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109075551.870001-1-chancel.liu@nxp.com> <20240109075551.870001-4-chancel.liu@nxp.com>
In-Reply-To: <20240109075551.870001-4-chancel.liu@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 9 Jan 2024 16:16:06 +0200
Message-ID: <CAEnQRZAgwmNZ8ruV6rPJ_OTzjLHL0jgPLFNbBeW1fXYG+QjAbw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: fsl,micfil: Add compatible string
 for i.MX95 platform
To: Chancel Liu <chancel.liu@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:58=E2=80=AFAM Chancel Liu <chancel.liu@nxp.com> wr=
ote:
>
> Add compatible string "fsl,imx95-micfil" for i.MX95 platform.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,micfil.yaml     | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.yaml b/Do=
cumentation/devicetree/bindings/sound/fsl,micfil.yaml
> index b7e605835639..f0d3d11d07d2 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,micfil.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,micfil.yaml
> @@ -15,10 +15,17 @@ description: |
>
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx8mm-micfil
> -      - fsl,imx8mp-micfil
> -      - fsl,imx93-micfil
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx95-micfil
> +          - const: fsl,imx93-micfil
> +
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-micfil
> +              - fsl,imx8mp-micfil
> +              - fsl,imx93-micfil

My yaml knowledge is very limited. Can you describe in natural
language in the commit what exactly we are doing here.

Why something like this:


>    compatible:
>     enum:
>       - fsl,imx8mm-micfil
>       - fsl,imx8mp-micfil
>       - fsl,imx93-micfil
+        - fsl,imx95-micfil

Isn't enough?

