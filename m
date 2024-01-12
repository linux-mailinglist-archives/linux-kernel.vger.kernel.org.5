Return-Path: <linux-kernel+bounces-24420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF182BC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8B41C23094
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD66B5D8F7;
	Fri, 12 Jan 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P/HHYg1y"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD115D8F6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ccbc328744so75175041fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 00:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705047471; x=1705652271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLUoJHH9vL1bZ2GgbR3YmRRkEoCjkjm9bBOPWHQDlGA=;
        b=P/HHYg1yaD9tXJ/D9nGC0v8sCFr8Zx95lDaeN0Ac+qtmL21aP/E2CciwnHawuxxk8a
         1CcCkM/Png3GlpQg0reO0My5ftHFr5rX9tKTb7Um6bz7luO1UckmmpCvfZ6nuM8PyKU6
         SHiFQ5U6a2tpK9C1hi7ApJwnLbpzlbAYbWMiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705047471; x=1705652271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLUoJHH9vL1bZ2GgbR3YmRRkEoCjkjm9bBOPWHQDlGA=;
        b=I68UEwcSBGZaRuMCJfOOQ231pCo39jhRX5RR5++GgGVIIcJ9mR7zHZYL/bq7nRE2ra
         NFhcPAKpWMiuKcTn8fjRyHpXj6h7imXFSuKR2Ko7e9NINTq4jg0Xs52DF2zRXwfMn1RZ
         5rahgFOH5adSppgopNCSUJPktYtANRvlX8mm/w/4WNI9JQPKGJvoYjToNAadFBi3+L6V
         jOgqxC0o2JgjWWV7veEPku2WiD8jyOO5RvB6bKmHjn8z/25/zEZrwO/o4+r2UlKsgzVl
         DyrmwAHFOABJfIGx1aaAW2/4aXFaEOcQLqNK8wApcHGLY0HM3DAJtVPKCOYBPEnNqp8r
         uGdA==
X-Gm-Message-State: AOJu0Yyk/fVV0VEsP8Ar1WxiNWJOxieXqhjI7B/pvXNMSwwnGYgXo09p
	Ak/Ttc8yWue6Og+v5puN9I9ma5fCNR8n6qpFLaug/YF2gj/Q
X-Google-Smtp-Source: AGHT+IFnPq0abOqgKKGI/Lb7ZpqZ+iFRv9oNGRxuG8trKPUudrojUe1vsbrgqwS0pyK/Y0QND6YXPHJynUU7wm90eOs=
X-Received: by 2002:a2e:8346:0:b0:2cc:e9de:3905 with SMTP id
 l6-20020a2e8346000000b002cce9de3905mr412718ljh.68.1705047471044; Fri, 12 Jan
 2024 00:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com> <20240111105247.117766-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240111105247.117766-3-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jan 2024 16:17:40 +0800
Message-ID: <CAGXv+5Grq8XrpP9yssduXtetxWBb3PB1z7O6rvvaW=CcSPB8Dg@mail.gmail.com>
Subject: Re: [PATCH 2/7] ASoC: mediatek: mt8173-afe-pcm: Use devm_snd_soc_register_component()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	matthias.bgg@gmail.com, ribalda@chromium.org, nicolas.ferre@microchip.com, 
	u.kleine-koenig@pengutronix.de, kuninori.morimoto.gx@renesas.com, 
	nfraprado@collabora.com, alsa-devel@alsa-project.org, trevor.wu@mediatek.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:53=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Function devm_snd_soc_register_component() allocates a new struct
> snd_soc_component, adds components and initializes them; since this
> is also devm, it automatically unregisters components and frees
> memory upon destruction.
>
> That's exactly what we're doing in the probe function of this driver:
> switch to that function instead, allowing to remove the last goto and
> to discard the .remove_new() callback for this driver.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 58 +++-------------------
>  1 file changed, 8 insertions(+), 50 deletions(-)
>
> diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/media=
tek/mt8173/mt8173-afe-pcm.c
> index ea611730de9c..b887e10635fe 100644
> --- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
> @@ -1129,72 +1129,31 @@ static int mt8173_afe_pcm_dev_probe(struct platfo=
rm_device *pdev)
>         afe->runtime_resume =3D mt8173_afe_runtime_resume;
>         afe->runtime_suspend =3D mt8173_afe_runtime_suspend;
>
> -       ret =3D devm_snd_soc_register_component(&pdev->dev,
> -                                        &mtk_afe_pcm_platform,
> -                                        NULL, 0);
> +       ret =3D devm_snd_soc_register_component(&pdev->dev, &mtk_afe_pcm_=
platform, NULL, 0);
>         if (ret)
>                 return ret;
>
> -       comp_pcm =3D devm_kzalloc(&pdev->dev, sizeof(*comp_pcm), GFP_KERN=
EL);
> -       if (!comp_pcm)
> -               return -ENOMEM;
> -
> -       ret =3D snd_soc_component_initialize(comp_pcm,
> -                                          &mt8173_afe_pcm_dai_component,
> -                                          &pdev->dev);
> +       ret =3D devm_snd_soc_register_component(&pdev->dev, &mt8173_afe_p=
cm_dai_component,
> +                                             mt8173_afe_pcm_dais,
> +                                             ARRAY_SIZE(mt8173_afe_pcm_d=
ais));
>         if (ret)
>                 return ret;
>
> -#ifdef CONFIG_DEBUG_FS
> -       comp_pcm->debugfs_prefix =3D "pcm";
> -#endif

To match existing behavior, can you move this to the component driver?
In snd_soc_component_initialize(), component->debugfs_prefix will take
component_driver->debugfs_prefix as default if it is not set.

Same for the HDMI component.

ChenYu

> -
> -       ret =3D snd_soc_add_component(comp_pcm,
> -                                   mt8173_afe_pcm_dais,
> -                                   ARRAY_SIZE(mt8173_afe_pcm_dais));
> +       ret =3D devm_snd_soc_register_component(&pdev->dev, &mt8173_afe_h=
dmi_dai_component,
> +                                             mt8173_afe_hdmi_dais,
> +                                             ARRAY_SIZE(mt8173_afe_hdmi_=
dais));
>         if (ret)
>                 return ret;
>
> -       comp_hdmi =3D devm_kzalloc(&pdev->dev, sizeof(*comp_hdmi), GFP_KE=
RNEL);
> -       if (!comp_hdmi) {
> -               ret =3D -ENOMEM;
> -               goto err_cleanup_components;
> -       }
> -
> -       ret =3D snd_soc_component_initialize(comp_hdmi,
> -                                          &mt8173_afe_hdmi_dai_component=
,
> -                                          &pdev->dev);
> -       if (ret)
> -               goto err_cleanup_components;
> -
> -#ifdef CONFIG_DEBUG_FS
> -       comp_hdmi->debugfs_prefix =3D "hdmi";
> -#endif
> -
> -       ret =3D snd_soc_add_component(comp_hdmi,
> -                                   mt8173_afe_hdmi_dais,
> -                                   ARRAY_SIZE(mt8173_afe_hdmi_dais));
> -       if (ret)
> -               goto err_cleanup_components;
> -
>         ret =3D devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler=
,
>                                0, "Afe_ISR_Handle", (void *)afe);
>         if (ret) {
>                 dev_err(afe->dev, "could not request_irq\n");
> -               goto err_cleanup_components;
> +               return ret;
>         }
>
>         dev_info(&pdev->dev, "MT8173 AFE driver initialized.\n");
>         return 0;
> -
> -err_cleanup_components:
> -       snd_soc_unregister_component(&pdev->dev);
> -       return ret;
> -}
> -
> -static void mt8173_afe_pcm_dev_remove(struct platform_device *pdev)
> -{
> -       snd_soc_unregister_component(&pdev->dev);
>  }
>
>  static const struct of_device_id mt8173_afe_pcm_dt_match[] =3D {
> @@ -1215,7 +1174,6 @@ static struct platform_driver mt8173_afe_pcm_driver=
 =3D {
>                    .pm =3D &mt8173_afe_pm_ops,
>         },
>         .probe =3D mt8173_afe_pcm_dev_probe,
> -       .remove_new =3D mt8173_afe_pcm_dev_remove,
>  };
>
>  module_platform_driver(mt8173_afe_pcm_driver);
> --
> 2.43.0
>
>

