Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055477A5F87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjISK2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjISK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:28:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4978F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:28:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50309daf971so4125201e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695119307; x=1695724107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQHjsvNbiZrx4g9lfYTl98XMHQ/DiEm4zN7iWnjsvMo=;
        b=KZGJ6CH4iq25DEmAKzPGRYj0I20z1IFga8p1XZO6WqoxdrcfJBI36vIwCkLgKJuPsc
         8SrRo+dldj9q0wVhuLoeBYUc6yoLgKJLfl2vBiQm5Q3Lqs1X6VtyIVf82+7olN2XMwI0
         +V7HYUHFMSlPlrS09odX8WY4hFwRM/M18Gi7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695119307; x=1695724107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQHjsvNbiZrx4g9lfYTl98XMHQ/DiEm4zN7iWnjsvMo=;
        b=ftaqs1xpEPOn94cGfPrZl/5JOyujGut3LFe6H3AM0aRsjC8JWFtY//XF/rnK8TG/zQ
         EIENvNfy0a4c4VUgnn0O5m+ZZmiJkaay1rbGxWIX6Ug3Ep9YXfzSxgL8ooFTXM8ZYwVp
         mUbWXNml7+UqSjHVdmYI752WTCK2oOd25ppRY61TzyAeas8vnxLF07n0sMJeg3p8TfVu
         JKvDKKglaZeu3bX/7ybumzDWfHWUh72PQOLFXQ+6Pl4oIYErojQrVuEzUWREMOpzoxnR
         JA3ZUkNe059dTD8WWANv5ctXVGa5J20dZiDudmZ9ko0Nh23oVMmi3iA2exIzaZLDTQu9
         0Urg==
X-Gm-Message-State: AOJu0YzYZoVzcyOmTLM3afjgydaiabSq7iqBeERW9dL3sNL1wgWYZVvU
        lYgk2r0O494C0c5qfur6K9yRqx7Xy6gVrt0fwbtprw==
X-Google-Smtp-Source: AGHT+IGM6xnlFEOYsGOy4vaMQaQCBEdxtKKl8J/sGO588nMpavoXIoMxtEAICrfWJ2kSxArbOreXBVnaWhrKp8Pal9c=
X-Received: by 2002:a05:6512:36c1:b0:503:3245:6eda with SMTP id
 e1-20020a05651236c100b0050332456edamr833333lfs.40.1695119306913; Tue, 19 Sep
 2023 03:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230919095938.70679-1-angelogioacchino.delregno@collabora.com> <20230919095938.70679-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919095938.70679-2-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 19 Sep 2023 18:28:15 +0800
Message-ID: <CAGXv+5Hk2Hd_GPk8WerpyZ0NGtoWOiMPY-LquJxLGbG2Wo6FMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: dt-bindings: mediatek: Add phandle to
 mediatek,scp on MDP3 RDMA
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, linqiheng@huawei.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 5:59=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The MDP3 RDMA needs to communicate with the SCP remote processor: allow
> specifying a phandle to a SCP core.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.y=
aml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> index d639a1461143..0e5ce2e77e99 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -46,6 +46,11 @@ properties:
>        include/dt-bindings/gce/<chip>-gce.h of each chips.
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>
> +  mediatek,scp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the System Control Processor (SCP) node
> +
>    power-domains:
>      oneOf:
>        - items:
> @@ -98,6 +103,7 @@ examples:
>          mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX 0x1000 0x1000>=
;
>          mediatek,gce-events =3D <CMDQ_EVENT_MDP_RDMA0_SOF>,
>                                <CMDQ_EVENT_MDP_RDMA0_EOF>;
> +        mediatek,scp =3D <&scp>;
>          power-domains =3D <&spm MT8183_POWER_DOMAIN_DISP>;
>          clocks =3D <&mmsys CLK_MM_MDP_RDMA0>,
>                   <&mmsys CLK_MM_MDP_RSZ1>;
> --
> 2.42.0
>
