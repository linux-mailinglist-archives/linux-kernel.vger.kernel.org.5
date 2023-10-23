Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB47D3052
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjJWKsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:48:15 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1FDEE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:48:13 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4a8ba764ae3so664008e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698058092; x=1698662892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDsOzmmnvUm1G11MYBhQGWKR4I6cbpM4/80jOVhzQFw=;
        b=V2mpTn+RXmev0GNCyXxqFC+VC+e0BiuMHYv6FSY0G7AEiwXGEWlfljPZUjgLkYxKmw
         lyZegSywbAkSwT+xTftY5LW8dCMGX6+DH5JEKdeh5453wzlkXsfI6uNEGDeC/CopICpw
         lQq7UWz9KJIsvsQI00zUwVBlpW2zOJybOlQm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698058092; x=1698662892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDsOzmmnvUm1G11MYBhQGWKR4I6cbpM4/80jOVhzQFw=;
        b=DNJdhq9jIlfREJpwEeulFcP1NXv95bfGYxNTJLLE8QPjrcn0vaKL9pS0CkmhJGriVk
         9JQZRGEcNWKzC0N4gJZ7LRDAZ6ysDHaElQq7e8HrmcVzhYtNiLXZ7tzxAs8CpoodCSR9
         b6u+7QJ9MtugkgwNkpYAXGkE4Mme5z9KxYJB55+5FJ02xWOieVVPLuqhpVbBD1emBsls
         xgsqwyenhlWz9JNUt3gOjDAo/c8O21mvfvdbbfj3zMQTqVoTkBJAitxbqVJzm2eSvNwm
         hAWy9DoaHKnZC1y+xAfRuEWE0nUv2vv6PJYipBarS8fKivHBir/JamN7HsQRtAriUQMA
         lldQ==
X-Gm-Message-State: AOJu0Ywa3BOxAzc868R5PiwkHWBUimXqs9HoxIGG2YQ240grphl7R3Bh
        CYKOu4FCUbDV26lnJA29ILv0/LwuqAymni8KDI0=
X-Google-Smtp-Source: AGHT+IGve9u0NUaGzDDPLVNugYoFMUOlteA8Zifcfe9gvNMo/6ZWm+3T75K7EbtNJkVnhXAJpn5BgQ==
X-Received: by 2002:a05:6122:2225:b0:496:80b6:2fd1 with SMTP id bb37-20020a056122222500b0049680b62fd1mr6812038vkb.5.1698058092191;
        Mon, 23 Oct 2023 03:48:12 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id n4-20020ab071c4000000b007b0fe35afb3sm846148uao.35.2023.10.23.03.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 03:48:11 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4a8ba764ae3so663993e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:48:11 -0700 (PDT)
X-Received: by 2002:a1f:9dd4:0:b0:496:187e:b33f with SMTP id
 g203-20020a1f9dd4000000b00496187eb33fmr3723710vke.3.1698058090760; Mon, 23
 Oct 2023 03:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com> <20231023043751.17114-8-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023043751.17114-8-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 23 Oct 2023 18:47:34 +0800
X-Gmail-Original-Message-ID: <CAC=S1niRYwftnmi8VABzENf2g94ELEBZrB3NRRdvwn0Ro6tO1A@mail.gmail.com>
Message-ID: <CAC=S1niRYwftnmi8VABzENf2g94ELEBZrB3NRRdvwn0Ro6tO1A@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] mailbox: mediatek: Add secure CMDQ driver support
 for CMDQ driver
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Oct 23, 2023 at 12:39=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediate=
k.com> wrote:
>
> CMDQ driver will probe a secure CMDQ driver when has_sec flag
> in platform data is true and its device node in dts has defined a
> event id of CMDQ_SYNC_TOKEN_SEC_EOF.
>
> Secure CMDQ driver support on mt8188 and mt8195 currently.
> So add a has_sec flag to their driver data to probe it.
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c       | 42 ++++++++++++++++++++++--
>  include/linux/mailbox/mtk-cmdq-mailbox.h | 11 +++++++
>  2 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 3bdfb9a60614..4db5eb76f353 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -87,6 +87,7 @@ struct gce_plat {
>         u8 shift;
>         bool control_by_sw;
>         bool sw_ddr_en;
> +       bool has_sec;
>         u32 gce_num;
>  };
>
> @@ -560,14 +561,23 @@ static int cmdq_probe(struct platform_device *pdev)
>         int alias_id =3D 0;
>         static const char * const clk_name =3D "gce";
>         static const char * const clk_names[] =3D { "gce0", "gce1" };
> +       struct resource *res;
> +       struct platform_device *mtk_cmdq_sec;
> +       u32 hwid =3D 0;
>
>         cmdq =3D devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
>         if (!cmdq)
>                 return -ENOMEM;
>
> -       cmdq->base =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(cmdq->base))
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
The devm_platform_ioremap_resource() helper was added on purpose [1].
Please stick to it unless you have a strong reason to re-split it.

[1]: a04f30356e75 ("mailbox: mtk-cmdq: Make use of the helper function
devm_platform_ioremap_resource()")

> +       if (!res)
> +               return -EINVAL;
> +
> +       cmdq->base =3D devm_ioremap_resource(dev, res);
> +       if (IS_ERR(cmdq->base)) {
> +               dev_err(dev, "failed to ioremap cmdq\n");
>                 return PTR_ERR(cmdq->base);
> +       }
>
>         cmdq->irq =3D platform_get_irq(pdev, 0);
>         if (cmdq->irq < 0)
> @@ -585,6 +595,8 @@ static int cmdq_probe(struct platform_device *pdev)
>                 dev, cmdq->base, cmdq->irq);
>
>         if (cmdq->pdata->gce_num > 1) {
> +               hwid =3D of_alias_get_id(dev->of_node, clk_name);
Why get hwid here while it's only used in the has_sec branch?

> +
>                 for_each_child_of_node(phandle->parent, node) {
>                         alias_id =3D of_alias_get_id(node, clk_name);
>                         if (alias_id >=3D 0 && alias_id < cmdq->pdata->gc=
e_num) {
> @@ -653,6 +665,30 @@ static int cmdq_probe(struct platform_device *pdev)
>                 return err;
>         }
>
> +       if (cmdq->pdata->has_sec) {
> +               struct cmdq_sec_plat gce_sec_plat;
> +
> +               if (of_property_read_u32_index(dev->of_node, "mediatek,gc=
e-events", 0,
> +                                              &gce_sec_plat.cmdq_event) =
=3D=3D 0) {
> +                       gce_sec_plat.gce_dev =3D dev;
> +                       gce_sec_plat.base =3D cmdq->base;
> +                       gce_sec_plat.base_pa =3D res->start;
> +                       gce_sec_plat.hwid =3D hwid;
> +                       gce_sec_plat.gce_num =3D cmdq->pdata->gce_num;
> +                       gce_sec_plat.clocks =3D cmdq->clocks;
> +                       gce_sec_plat.thread_nr =3D cmdq->pdata->thread_nr=
;
> +
> +                       mtk_cmdq_sec =3D platform_device_register_data(de=
v, "mtk_cmdq_sec",
> +                                                                    PLAT=
FORM_DEVID_AUTO,
> +                                                                    &gce=
_sec_plat,
> +                                                                    size=
of(gce_sec_plat));
> +                       if (IS_ERR(mtk_cmdq_sec)) {
> +                               dev_err(dev, "failed to register platform=
_device mtk_cmdq_sec\n");
> +                               return PTR_ERR(mtk_cmdq_sec);
> +                       }
> +               }
> +       }
> +
>         return 0;
>  }
>
> @@ -693,6 +729,7 @@ static const struct gce_plat gce_plat_v6 =3D {
>         .thread_nr =3D 24,
>         .shift =3D 3,
>         .control_by_sw =3D true,
> +       .has_sec =3D true,
>         .gce_num =3D 2
>  };
>
> @@ -708,6 +745,7 @@ static const struct gce_plat gce_plat_v8 =3D {
>         .thread_nr =3D 32,
>         .shift =3D 3,
>         .control_by_sw =3D true,
> +       .has_sec =3D true,
>         .gce_num =3D 2
>  };
>
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mai=
lbox/mtk-cmdq-mailbox.h
> index f78a08e7c6ed..fdda995a69ce 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -79,6 +79,17 @@ struct cmdq_pkt {
>         bool                    loop;
>  };
>
> +struct cmdq_sec_plat {
> +       struct device *gce_dev;
> +       void __iomem *base;
> +       dma_addr_t base_pa;
> +       u32 hwid;
> +       u32 gce_num;
> +       struct clk_bulk_data *clocks;
> +       u32 thread_nr;
> +       u32 cmdq_event;
> +};
I feel this should be in mtk-cmdq-sec-mailbox.h.

Regards,
Fei



> +
>  u8 cmdq_get_shift_pa(struct mbox_chan *chan);
>
>  #endif /* __MTK_CMDQ_MAILBOX_H__ */
> --
> 2.18.0
>
>
