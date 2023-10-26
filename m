Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D717D7C54
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJZFl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZFl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:41:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704513A;
        Wed, 25 Oct 2023 22:41:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso80311666b.0;
        Wed, 25 Oct 2023 22:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698298907; x=1698903707; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v88cIuoMfKK/xscvmw4mP2AX4C1KpNxy9EGTFm/wXII=;
        b=SYXJHRoIVN0by8Qyi+kKq59ReFb3FcWFRWDzTtkCCQD6rZNjUkUuBS2qZdRWhr/I0t
         ct6T+zW+Xy6GhzFUVQ2Ub6QJsQA4RPMVIZ9flFd8BIPLGhicsyuly/EH8dqsA1vdwAYq
         9C8nFmVa4YcHNmOtey6uqrNq6jb0X/i7SUDyGXLIuquKktViRoO/lcRfuXCihk15Ejsj
         7vn4sHMKLDmkujl8x4PrVs74pMEfCHZruaiE2Lu2h1a4jvRArG6/r8fJnyeTlssle4oT
         zTvxKJop7HNmwyrJFjj/wqgHwCpBjmnIEBivWynVF/DtLg8x8iEbcxl+q4212OMelXGt
         3TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698298907; x=1698903707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v88cIuoMfKK/xscvmw4mP2AX4C1KpNxy9EGTFm/wXII=;
        b=jVCOh/CN3htLwF6HnyOqwIJgEhkh718Kk6wm9HgQ7U8+aYUn35YTKVK8HquGVZCsrd
         aaEGD1hOsWB8VSObZliYb9zrs0pi8Oh09POQV8Vlis5EAmgoFJJTXYGRSJokxO4vTA9F
         GVD+4UkEUhWHIX6vJ5iPx1iZotnn5+FvnWrEm+Lf4MFLO2ygFpVmpRl663D+R0tDNfGU
         KQP7rFqmH9I8eZ7GGfr3RkDUgVYar6rkgFnVsS/c2lg5Y13/37psl13FccHtbWl5v8wz
         7QfBMcsoUAkT4+dSWPZP3xLDl6QlMNSbKVN33qpE1nQaG3tTen+rWxzhh6+owvF0MlpO
         y4hA==
X-Gm-Message-State: AOJu0Yz50FSgvG/+xY7KnHftJ9JKmebdwL0hguPUko8nJypG3JC3vJYk
        MwEbSQEidSzYl4p+88TicAM=
X-Google-Smtp-Source: AGHT+IE/n0OoxifurTDgldQZqpLM8AuCp+gQ7fUFj2/TTGB+7QsX1WZ+ulAcFK2YO66Nv03gm0DH7A==
X-Received: by 2002:a17:907:9286:b0:9b9:facb:d950 with SMTP id bw6-20020a170907928600b009b9facbd950mr13315954ejc.72.1698298907263;
        Wed, 25 Oct 2023 22:41:47 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id h11-20020a1709063b4b00b009b9aa8fffdasm10997701ejf.131.2023.10.25.22.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:41:46 -0700 (PDT)
Message-ID: <c44c8c13a91a695d758154335b38488c71de1d1c.camel@gmail.com>
Subject: Re: [RFT PATCH 02/17] ASoC: codecs: adau1373: Handle component name
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
Date:   Thu, 26 Oct 2023 07:41:45 +0200
In-Reply-To: <20231023095428.166563-3-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
         <20231023095428.166563-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

> =C2=A0sound/soc/codecs/adau1373.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
> index b0ab0a69b207..3582c4b968a0 100644
> --- a/sound/soc/codecs/adau1373.c
> +++ b/sound/soc/codecs/adau1373.c
> @@ -834,7 +834,7 @@ static int adau1373_check_aif_clk(struct snd_soc_dapm=
_widget
> *source,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0clk =3D "SYSCLK2";
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return strcmp(source->name, cl=
k) =3D=3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return snd_soc_dapm_widget_nam=
e_cmp(source, clk) =3D=3D 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int adau1373_check_src(struct snd_soc_dapm_widget *source,

