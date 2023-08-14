Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E477C1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjHNU7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjHNU7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:59:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8DEDD;
        Mon, 14 Aug 2023 13:59:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5234b80e9b6so6500009a12.2;
        Mon, 14 Aug 2023 13:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692046760; x=1692651560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1mAIR32hNZWrf1+R+AprBLrBz5L9RjZMLxPc7Z5zHs=;
        b=ORPQUcuDHZ9ButxoKtIk5eEB/aKakq6X2T2Z2x9vr+6O0veDl2O5AS9xcAfughT2lY
         WJ1SLrvOqZJuizFTMut7yMIw93MtRV/tTSIkPACTHytZInxKlzLhNjTkoUX7pdk8doeV
         k1rdaOzI4uq5WFMve14NN4jDwAGTXAOIomt4Y3ZptIr9WvfTZ8ojO9iFgZ4b6RFzlIPk
         quMqsV5+k6Bzo9EJJoP5iKINnQtBqbWYs+gp9m+NK86Ajj9w0bMCG11NajUGCaNsEADU
         WeflfM5HcC5KyNBo7pffdWVbnjuMw+wiyO9wT8VD0Bv/aKplyEFoIPLkTjUkzL3whJDy
         rkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046760; x=1692651560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1mAIR32hNZWrf1+R+AprBLrBz5L9RjZMLxPc7Z5zHs=;
        b=D4JJcf2gUI7pSIdKHzsks9x+IrjLNYxIp14VDnEYkjE1tp3GTp3yjhZ0nO1s6CRfex
         FoVuIBTa0gk3LuAAAntN67SEndX8cJcPXPF0Z0zm/txM9BzzXRszwW1L785nmCXgW0Ed
         ROpYBu53yBJEooU6ehVLQLyrwzTwPXkOmj5KAJhccDtSlupUID6jFrtQjvOboORxG2QO
         xSvookLe8ExfD6+i09ZaO+rFtFPuXKVEeeb/TcBaQl49qbtV7oZbiC3ujRD5CNcs3vA/
         ejs7cU8+W5xF8gjkJZtCdGaFbKZYR2F+n8AfbRbQmcLnEqSbBMaeYBiFCWNRK26yDpvb
         e58Q==
X-Gm-Message-State: AOJu0YzMPJcCw+GKx+PB4Pt3zt67gS1LHmlE/eYsIQE4soqjdj16gdjV
        oZGC6GISXEpue3nxXafyUGRjRY0LwcAjak1ZrAs=
X-Google-Smtp-Source: AGHT+IGnaMFQ8n9yvntKC+C+AAM0KQGIRcN7cA5qijB3IvqT7ZXVWCwk1VGgT2CWDi3iKfKEZWAhMNzr0926xZ1dSi8=
X-Received: by 2002:a05:6402:1245:b0:525:5ed2:abed with SMTP id
 l5-20020a056402124500b005255ed2abedmr3774395edw.30.1692046760052; Mon, 14 Aug
 2023 13:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org> <20230628-topic-a7xx_drmmsm-v2-8-1439e1b2343f@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v2-8-1439e1b2343f@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 14 Aug 2023 13:59:07 -0700
Message-ID: <CAF6AEGvFHDv47DMeLTVjp5wepuvCpQrNu7a_ijifhUUcsT30tg@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] drm/msm/a6xx: Add skeleton A7xx support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 2:03=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 49f38edf9854..3e69ef9dde3f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -46,6 +46,7 @@ enum adreno_family {
>         ADRENO_6XX_GEN2,  /* a640 family */
>         ADRENO_6XX_GEN3,  /* a650 family */
>         ADRENO_6XX_GEN4,  /* a660 family */
> +       ADRENO_7XX_GEN1,  /* a730 family */
>  };
>
>  #define ADRENO_QUIRK_TWO_PASS_USE_WFI          BIT(0)
> @@ -401,6 +402,17 @@ static inline int adreno_is_a640_family(const struct=
 adreno_gpu *gpu)
>         return gpu->info->family =3D=3D ADRENO_6XX_GEN2;
>  }
>
> +static inline int adreno_is_a730(struct adreno_gpu *gpu)
> +{
> +       return gpu->info->chip_ids[0] =3D=3D 0x07030001;
> +}
> +
> +static inline int adreno_is_a7xx(struct adreno_gpu *gpu)
> +{
> +       /* Update with non-fake (i.e. non-A702) Gen 7 GPUs */
> +       return adreno_is_a730(gpu);

just use the family enum here.. that lets you move the
adreno_is_a730() helper into the patch that actually adds a730

BR,
-R

> +}
> +
