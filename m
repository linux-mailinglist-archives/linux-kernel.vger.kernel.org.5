Return-Path: <linux-kernel+bounces-11951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AC381EE19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997C01F21E48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA452C87A;
	Wed, 27 Dec 2023 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm2deBjh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985872C852;
	Wed, 27 Dec 2023 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bae735875bso115975739f.2;
        Wed, 27 Dec 2023 02:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703672042; x=1704276842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRme2CYkuej+oUl410fWyMnS0uLqwabA9u7BWCoKP+o=;
        b=fm2deBjh4ywe7Mi6jhmDtX1AaSzeqVBSOljOvnNT5eDmK3jcbRtXXejVdVvkFxzOV5
         7ueZb7FaXfXz2s4Axci5fWmGV/p+UfFvfFlDXkr+4C0+1MDeh1fRCyYDgMSau64p0WR8
         RzUE5UP/b5VIPuDQGqWGp/GRPFQfaBQ+YtYcavu5rMdFkgkNgu9ElxuEyx9BlmK2dgUB
         5K6+mrvA+sGuqGpT8gX/zDbl/C0e9XncGMEXVxvlX3Sa+k1SNvqHiDx0Xp75+KdTQKBF
         TR7uUYXuk1lHxEonWkM6pnXumPqZw2D2BhJ9rstikNTQi6kVSASPZxadaz5S2RlJ7vIi
         YLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672042; x=1704276842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRme2CYkuej+oUl410fWyMnS0uLqwabA9u7BWCoKP+o=;
        b=sIPMyFFOWwZ8VX6NnHEd72y1vZWyU+61nUjqRqO79Jtth9BWniRkcCxs5mMXys5aoS
         /5z38fOcu8dZBomsoEKdAeLJ8D101fmk+tIxG7fJBNDzb9c7nTUbn3ISuhFfXJT7EXj5
         kn9BhPGNnlB5KZeWu9ye/ubnYOKXIY2ZYV8H62dQbs+6pUVEgxw5/s1v7xLJMVgNacbP
         R3kjon5D4NXsuLH1ezADnkmrtaqUPkH3E/e/41p5AXCtbHWkbmodKNHY6WQYrlu9N13p
         SExL0tUtTPxS2rd+e1wevpDj6+2wNQb5d2pDu+2CGrzrtJLf0pZzZ0gbSMDCFxViVWiR
         T3/Q==
X-Gm-Message-State: AOJu0YwQ3bOfFbSr68ujvzjOCntx3uAuT+y8/hyUshyD/XeVF4Ap3hXV
	v1PP1WlBzZjXXnzcqwmLXZEP/Z68kKMQw5xbbV0=
X-Google-Smtp-Source: AGHT+IGX3kgTnoLFpwcULIR2XP64wsIvyR1qrnOqNlsZ5KnM2HAG0vPRlOFg+PwmfJmRT1lMaiTHvxcGaf3r8K23v0c=
X-Received: by 2002:a92:c267:0:b0:35d:a84e:f729 with SMTP id
 h7-20020a92c267000000b0035da84ef729mr15136859ild.63.1703672042700; Wed, 27
 Dec 2023 02:14:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225080608.967953-1-chancel.liu@nxp.com>
In-Reply-To: <20231225080608.967953-1-chancel.liu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 27 Dec 2023 18:13:51 +0800
Message-ID: <CAA+D8APY3KL6+7kpeqGLm-n_gLTLHOWvMoEZxhrRH2X+9O1d-w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable
To: Chancel Liu <chancel.liu@nxp.com>
Cc: Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 4:06=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
> There is error message when defer probe happens:
>
> fsl_rpmsg rpmsg_audio: Unbalanced pm_runtime_enable!
>
> Fix the error handler with pm_runtime_enable.
>
> Fixes: b73d9e6225e8 ("ASoC: fsl_rpmsg: Add CPU DAI driver for audio base =
on rpmsg")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
wang shengjiu
> ---
>  sound/soc/fsl/fsl_rpmsg.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_rpmsg.c b/sound/soc/fsl/fsl_rpmsg.c
> index 5c5c04ce9db7..00852f174a69 100644
> --- a/sound/soc/fsl/fsl_rpmsg.c
> +++ b/sound/soc/fsl/fsl_rpmsg.c
> @@ -238,7 +238,7 @@ static int fsl_rpmsg_probe(struct platform_device *pd=
ev)
>         ret =3D devm_snd_soc_register_component(&pdev->dev, &fsl_componen=
t,
>                                               &fsl_rpmsg_dai, 1);
>         if (ret)
> -               return ret;
> +               goto err_pm_disable;
>
>         rpmsg->card_pdev =3D platform_device_register_data(&pdev->dev,
>                                                          "imx-audio-rpmsg=
",
> @@ -248,16 +248,22 @@ static int fsl_rpmsg_probe(struct platform_device *=
pdev)
>         if (IS_ERR(rpmsg->card_pdev)) {
>                 dev_err(&pdev->dev, "failed to register rpmsg card\n");
>                 ret =3D PTR_ERR(rpmsg->card_pdev);
> -               return ret;
> +               goto err_pm_disable;
>         }
>
>         return 0;
> +
> +err_pm_disable:
> +       pm_runtime_disable(&pdev->dev);
> +       return ret;
>  }
>
>  static void fsl_rpmsg_remove(struct platform_device *pdev)
>  {
>         struct fsl_rpmsg *rpmsg =3D platform_get_drvdata(pdev);
>
> +       pm_runtime_disable(&pdev->dev);
> +
>         if (rpmsg->card_pdev)
>                 platform_device_unregister(rpmsg->card_pdev);
>  }
> --
> 2.42.0
>

