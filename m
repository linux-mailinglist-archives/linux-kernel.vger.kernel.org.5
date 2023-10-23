Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9477D2EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjJWJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:42:13 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB9A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:42:11 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49d8fbd307fso1194686e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698054130; x=1698658930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH/fPEZ9qkWTKaawDCHK7vBhKEbCdSgmYhzD32um79w=;
        b=IGHNxUuKjy5+P/9FjPTgnVZXmF42slr5o9vrpWd7ep1m5Ws+/ZgUWDGn+04TcRZe/E
         6AM4jeF/tB7Kxv3dh/aArFRxOvx4iHFjqHBzYcfM+wjeP7vquWmJ49iyObiljzmuOQFW
         ga5eAuLZ4JiQE6Znrp6zuj0da8qbZq+PDTUbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054130; x=1698658930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH/fPEZ9qkWTKaawDCHK7vBhKEbCdSgmYhzD32um79w=;
        b=weAjPfpHclMojwWWe31yVIA4Zn8ukq8HAxGj+IV8GBXrCk827ftwYBkKR6/+k0Xrs9
         1mPzOnilJiruntvUFiIRin2Lhiddbsh9+VCHeCMaLHnlK23ItJRXxXiKTA8N5CEDNcSk
         V5FmWqnuXFeKS6Mfsec1gfvE4NLiMTiEceEeZAEr3NAdb5YqJdP1J+Yjthl0eTsI0kHP
         S4oLn1w+ywB9dPIaXiv0Df7Hkus78mXW3XatFsoRm7z5Msvnq9ubJGqUSQZQGUIdDHHB
         4o3HVwM41Xs7NvYE5BoRAYLWm1GfUfgzUHtX7t/lzfEDUwxZtOzDEVnW/EevpbpqPFdQ
         6h8Q==
X-Gm-Message-State: AOJu0YxT8xZdwT/PC0zRx6D/fe+HumFc1NhAwsjCZR+7E9SYmbAr+2Dq
        itpMegbCsJuR23qhPIVex7FWmhktvif9HhOTS3Y=
X-Google-Smtp-Source: AGHT+IF4Fmi5idt2dZAC9nnYo1TfZ9qhTiwutAQb0TBvLAW05EOu3PtjEzXlHHkctPkgEgJXmS5PuA==
X-Received: by 2002:a1f:1d07:0:b0:4a1:8aa1:8dcd with SMTP id d7-20020a1f1d07000000b004a18aa18dcdmr6146623vkd.15.1698054130591;
        Mon, 23 Oct 2023 02:42:10 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id r8-20020a056122008800b0049d20faf953sm826949vka.55.2023.10.23.02.42.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 02:42:10 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-49d8fbd307fso1194675e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:42:10 -0700 (PDT)
X-Received: by 2002:a05:6122:2020:b0:4a1:a334:57f6 with SMTP id
 l32-20020a056122202000b004a1a33457f6mr7545591vkd.1.1698054129715; Mon, 23 Oct
 2023 02:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com> <20231023043751.17114-7-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023043751.17114-7-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 23 Oct 2023 17:41:33 +0800
X-Gmail-Original-Message-ID: <CAC=S1njt-esHwUEr4O5BVUmmgpB=Gm084h+tY-KsKp9LkPXNBQ@mail.gmail.com>
Message-ID: <CAC=S1njt-esHwUEr4O5BVUmmgpB=Gm084h+tY-KsKp9LkPXNBQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] mailbox: mediatek: Add CMDQ driver support for mt8188
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Oct 23, 2023 at 12:58=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediate=
k.com> wrote:
>
> Add CMDQ driver support for mt8188 by adding its compatible and
> driver data in CMDQ driver.
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmd=
q-mailbox.c
> index 56fe01cd9731..3bdfb9a60614 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -704,12 +704,20 @@ static const struct gce_plat gce_plat_v7 =3D {
>         .gce_num =3D 1
>  };
>
> +static const struct gce_plat gce_plat_v8 =3D {
> +       .thread_nr =3D 32,
> +       .shift =3D 3,
> +       .control_by_sw =3D true,
> +       .gce_num =3D 2
> +};
> +
>  static const struct of_device_id cmdq_of_ids[] =3D {
>         {.compatible =3D "mediatek,mt8173-gce", .data =3D (void *)&gce_pl=
at_v2},
>         {.compatible =3D "mediatek,mt8183-gce", .data =3D (void *)&gce_pl=
at_v3},
>         {.compatible =3D "mediatek,mt8186-gce", .data =3D (void *)&gce_pl=
at_v7},
>         {.compatible =3D "mediatek,mt6779-gce", .data =3D (void *)&gce_pl=
at_v4},
>         {.compatible =3D "mediatek,mt8192-gce", .data =3D (void *)&gce_pl=
at_v5},
> +       {.compatible =3D "mediatek,mt8188-gce", .data =3D (void *)&gce_pl=
at_v8},
I guess I understand your intention here... but the ordering doesn't
make sense to most people. Put this line after mt8186.

It's up to you to ignore the outlier mt6779 for now or send a separate
patch to fully sort the list by the compatible strings.

Regards,
Fei


>         {.compatible =3D "mediatek,mt8195-gce", .data =3D (void *)&gce_pl=
at_v6},
>         {}
>  };
> --
> 2.18.0
>
>
