Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782357B10BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjI1C3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1C3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:29:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3AB7;
        Wed, 27 Sep 2023 19:29:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0ecb9a075so92794155ad.2;
        Wed, 27 Sep 2023 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695868156; x=1696472956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG7bj/7CYT96iOMQmtse7TOJSFKIa4UezWf2iE4PEvE=;
        b=JtZaJFatyFf9y1FreBzXZVERY5VEw+eu0u9vuzwEm9Wy6ubvE/rCZL95DJgC0YSEgk
         dbDLxbxcOreW7hvcOTS52lmOLZqt4Uvv6GMh2m8wB+ybwvxWjwdQrK6cA4Wg4LsXGIFa
         bVuZJnbzcxPkqImgQnJXJnAiNLWtPzqN33GH0MXDDeSBjEL6aIutM4L0ezxQ84ke+XeH
         4v+N3mIITA7h216C3dqyqp1MJK4MMarMUBsrs58eAUJqGJkxtPWowDmd7XNgUwd2sjfy
         XliMdYejaD+RGMFs3XDLl7ajXPLioBhinYjo3d9FbS5zXtskC5IpoGl04cXy1DZEzTq8
         5wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695868156; x=1696472956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nG7bj/7CYT96iOMQmtse7TOJSFKIa4UezWf2iE4PEvE=;
        b=unAm0oB8wedhu5aoybDU+diGd183bYd892MYicAgHkLnZ2fy+bv77l0+a01KYfXtyY
         Jaxrqri54Jkhu2pAaySBwbYsnmBdCjED+qsYrkq+mBdjbZfe6lhGLrWnpSSDZj92KzvQ
         buZETO5zMAyRV1IunUZ7WQgI+4u3IL1ylg4AuS4l2rVRrueLuT2gu4nP6+X5uL33TtKc
         AllNGRAnKKrEl7+dfKu+uxy5sWgKyXTaG0BI8C9icsTdnSOKdULtSXpyhMlzpFseIMY8
         FKlAWPKnktgC02/vOIZpvuoHjS8Hf7epJF1/Z2vqnlHeVXG1ysF9wgArFLqMq/5CyB0M
         xwKQ==
X-Gm-Message-State: AOJu0Yy+6PvXvvnMY0m43/OlQ8wUBPvdqQb01Oo7X9IxGsuXwN/WxEwv
        tUlddvvwsP/6Bdn9sZYtmMxEmSA3DeC+TYqlHfwKmoNm
X-Google-Smtp-Source: AGHT+IHE+J9+PCCpTolKsXgabIXkyyjxEemfilvMDA9kojoN8aRInCiVaGad6KrsXMEhphmmI6D7ZB6fyXgrxFHASU0=
X-Received: by 2002:a17:90a:c256:b0:268:2543:723 with SMTP id
 d22-20020a17090ac25600b0026825430723mr3285091pjx.5.1695868155780; Wed, 27 Sep
 2023 19:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230906095143.99806-1-aford173@gmail.com> <20230906095143.99806-2-aford173@gmail.com>
In-Reply-To: <20230906095143.99806-2-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 27 Sep 2023 21:29:04 -0500
Message-ID: <CAHCN7x+w-W8FPqSmM+SSVUAshjM4gRQrnYMj1h=GrzouO4EiDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: am3517: Configure ethernet alias
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 4:52=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
>
> The AM3517 has one ethernet controller called davinci_emac.
> Configuring the alias allows the MAC address to be passed
> from the bootloader to Linux.

Gentle nudge on this series

adam
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/arch/arm/boot/dts/ti/omap/am3517.dtsi b/arch/arm/boot/dts/ti=
/omap/am3517.dtsi
> index fbfc956f4e4d..77e58e686fb1 100644
> --- a/arch/arm/boot/dts/ti/omap/am3517.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/am3517.dtsi
> @@ -15,6 +15,7 @@ / {
>         aliases {
>                 serial3 =3D &uart4;
>                 can =3D &hecc;
> +               ethernet =3D &davinci_emac;
>         };
>
>         cpus {
> --
> 2.39.2
>
