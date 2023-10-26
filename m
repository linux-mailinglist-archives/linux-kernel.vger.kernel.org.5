Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565297D7C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbjJZFnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJZFnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:43:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBAD115;
        Wed, 25 Oct 2023 22:43:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso72636266b.0;
        Wed, 25 Oct 2023 22:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698298998; x=1698903798; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG2UysggiUwoOTUDtuwATYwEsAqlGEHP6tlUqmAyNpE=;
        b=ar/2J/JqFPEjVt2wsBrYSbQxJkTFugSvD28HqhB4i6WP0frX1rJIMEtIcCC4kA6TSN
         RjwSxf8sgawbIpLxGUzJSZ8xR7VIz+BgHfWE13fv3RB3FhMAgjwp+ZCWi75WjI2VTXby
         nsOqHgZ/YUIydNai0CgjOVISCncl7z15UmxAcfjcu0lbFNTS2hIl8JcavJeFVhdy61GS
         8ZPzYUbMnZZQuWlkU9V4eDFJ/suvWdhoOB7kXEQ+grUVVNG7lpa43Qrm98pAX97vBD8R
         mbu4CQ8e4UllMU8leEz+0BTPXaNJjcEZnhkonQC0lj7zZmBK+FZLs1ApQHU/peeAxWN9
         Cqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698298998; x=1698903798;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rG2UysggiUwoOTUDtuwATYwEsAqlGEHP6tlUqmAyNpE=;
        b=QyT1OyXNxmokemeGnsWcnIRZcThaYIiSI3SFXRxGiWIhuCoEsnB66C+We5ucrOUcj5
         rbtBWn9yC/dEEVftVJCySKVfsxYcdJGJ9R4nWu2Af4ywsM36Pr0wMl5l6tXKP0aExoJV
         C6vI431b5d+F32KjuSnSMmBVrmmx7VLApqPuLOpTeapCzZCciG0tOJDAU2t21kf2qmni
         c0TrLqeK6kaMZ5fvOa43uOeXdeoG6u+IVOnh1s/6LCpKtLlhgVhMgq0Ak+ZY83rroLlC
         jFf1/AfR4fyooLa89Ti2z9nWwwBX2ZSM5Y6G6I1sWhhU1OQAIs70UtNOlQgwRS48aKMo
         qTKg==
X-Gm-Message-State: AOJu0YywaBo7XuKmYRVKw/h9zc1B+ovxoIyDOJLpr6kVl4GsWs+wI3aW
        SS3400440D0AbyYnoZcUUBLVelI7lzmlq6gNMn4=
X-Google-Smtp-Source: AGHT+IE2Vvk6/8UrLk+Fqp68uEGIMn/w0ixG329AL4BRaLr6Z9i9Tbw3TAkzOcjxqMEkG/Sa24yY7g==
X-Received: by 2002:a17:907:7285:b0:9b2:be5e:7545 with SMTP id dt5-20020a170907728500b009b2be5e7545mr13394942ejc.36.1698298997475;
        Wed, 25 Oct 2023 22:43:17 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id y19-20020a170906519300b009adc7733f98sm11085906ejk.97.2023.10.25.22.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:43:17 -0700 (PDT)
Message-ID: <a9bb417341ee2f13c63f13afc1a5a3be330dcf07.camel@gmail.com>
Subject: Re: [RFT PATCH 03/17] ASoC: codecs: adav80x: Handle component name
 prefix
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Date:   Thu, 26 Oct 2023 07:43:15 +0200
In-Reply-To: <20231023095428.166563-4-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
         <20231023095428.166563-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 11:54 +0200, Krzysztof Kozlowski wrote:
> Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
> to include also the component's name prefix.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0sound/soc/codecs/adav80x.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
> index bb08969c5917..c8c0fc928211 100644
> --- a/sound/soc/codecs/adav80x.c
> +++ b/sound/soc/codecs/adav80x.c
> @@ -229,7 +229,7 @@ static int adav80x_dapm_sysclk_check(struct snd_soc_d=
apm_widget
> *source,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return strcmp(source->name, cl=
k) =3D=3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return snd_soc_dapm_widget_nam=
e_cmp(source, clk) =3D=3D 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int adav80x_dapm_pll_check(struct snd_soc_dapm_widget *sourc=
e,

