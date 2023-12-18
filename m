Return-Path: <linux-kernel+bounces-3072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E078166EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E510E1C222E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C503E553;
	Mon, 18 Dec 2023 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f2//Jurm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63AE549
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9dadc7f36so196940a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702882603; x=1703487403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heetabb8aKzy5dkmKa1naMHxOgfU6ho5cqN9FwveJso=;
        b=f2//JurmVLG8h5SJSZ+vzAEz3jbJruN85qL/DQkHauyEO6KgTEHo0vsfayK44XDaup
         P2RQilD7p1RwmT0VmiLCeJrZJzexGutpS0fIY0vev+01Digu8fR+9EmMrADkgiLa6cdl
         kD8iYkffBXOq0oV8ZmdJDYkWiqOlkRFcKQOeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702882603; x=1703487403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heetabb8aKzy5dkmKa1naMHxOgfU6ho5cqN9FwveJso=;
        b=O0IdA7fk4t8l35XVTQrkoNpz2E81NlmAMDFczN4g63DNSmrUTPwkoZgaSHqx8duJ6A
         G93914aOwCDnQKmUxmARm729hB++BhlpRkIJPSD8acM0UL/DMyAKUlNwuwE1Lui3dpIP
         r9fV5sdegusAfo/4AuLMCLBfLVfoo6l7mMhKn8ETnQus8N1XIC2K0KCpkPi89RWG3bLS
         2PUk248xVPqhmlay2uWYDQTrN/inbpRBqfV5XG085opT/aRhDGcEO+vXC37fvtINfTOG
         HzcBvpBXFxsIfaSb0tEPuyJUfd14m98j7tBOzX5jlaDggu858SdwU35ZfC+8BFAy8u3/
         jwog==
X-Gm-Message-State: AOJu0YyuGI16xw+qNnLsck018bC5vPO37bvI2H05cwmYA4RbIN7z34sI
	ngrfB2WeyMpHj7SXXE7vO4/zcbjFVA3/95ANdBnbDg==
X-Google-Smtp-Source: AGHT+IFBmYDH/nzoA0pUtjCNMSjKS+RYrW/vSHjYltuPf9objOPGPz7RmjOPWQ13/+rKX6vsoSoI52lvLdNfvtYOqBM=
X-Received: by 2002:a05:6808:138f:b0:3b2:efd3:e78c with SMTP id
 c15-20020a056808138f00b003b2efd3e78cmr32596500oiw.1.1702882603322; Sun, 17
 Dec 2023 22:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702822744.git.u.kleine-koenig@pengutronix.de> <94780e5a414b20b6effa1e87208c14620c854e88.1702822744.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <94780e5a414b20b6effa1e87208c14620c854e88.1702822744.git.u.kleine-koenig@pengutronix.de>
From: Markus Mayer <mmayer@broadcom.com>
Date: Sun, 17 Dec 2023 22:56:32 -0800
Message-ID: <CAGt4E5uvRGq9Cw74T1kWNT0nyPt_R5aGvt9EE1XRkVQGH1tPJw@mail.gmail.com>
Subject: Re: [PATCH 01/15] memory: brcmstb_dpfe: Convert to platform remove
 callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, kernel@pengutronix.de, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 17 Dec 2023 at 06:30, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/memory/brcmstb_dpfe.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.=
c
> index a7ab3d377206..5028467b2dc9 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -909,13 +909,11 @@ static int brcmstb_dpfe_probe(struct platform_devic=
e *pdev)
>         return ret;
>  }
>
> -static int brcmstb_dpfe_remove(struct platform_device *pdev)
> +static void brcmstb_dpfe_remove(struct platform_device *pdev)
>  {
>         struct brcmstb_dpfe_priv *priv =3D dev_get_drvdata(&pdev->dev);
>
>         sysfs_remove_groups(&pdev->dev.kobj, priv->dpfe_api->sysfs_attrs)=
;
> -
> -       return 0;
>  }
>
>  static const struct of_device_id brcmstb_dpfe_of_match[] =3D {
> @@ -936,7 +934,7 @@ static struct platform_driver brcmstb_dpfe_driver =3D=
 {
>                 .of_match_table =3D brcmstb_dpfe_of_match,
>         },
>         .probe =3D brcmstb_dpfe_probe,
> -       .remove =3D brcmstb_dpfe_remove,
> +       .remove_new =3D brcmstb_dpfe_remove,
>         .resume =3D brcmstb_dpfe_resume,
>  };

Acked-by: Markus Mayer <mmayer@broadcom.com>

