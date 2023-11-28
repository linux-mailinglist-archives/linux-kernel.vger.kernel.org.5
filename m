Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE127FB7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjK1KcG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 05:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjK1Kbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:31:39 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB1F4206;
        Tue, 28 Nov 2023 02:27:38 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db46725a531so3645418276.1;
        Tue, 28 Nov 2023 02:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701167258; x=1701772058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIGiIpNbEORiCIc0PSFrQIjsLdpdQ8g7U1Sz9jJiMDw=;
        b=ipO5H6zzwHuB5xA0xl/7fCuPiMMX0FpOeDQrdTh9oXJltlRAAW68tN3r1mdnhhkweL
         iJDo2X+ks7d90GlM5hEoTUoXqBr197HkwED1e4UT2RbPIwQ81DsLJTzvieK9LXUvxD3K
         GCX7Th8SpP5XbzuXcod668vMrt9blzlGQvc7int8yLy8cICTk1/X66qd608OtZeGvRWu
         IPAADWD0lG/dLN0bxCs29ARur1cnxjmc6AqT3qVQTqlAKXmAvKKGIa+RXlDxClCmalI5
         d9ozg4H5VuIg3a8GtnZbDg3isTNhQOUx4yDFd9TOYBKaytP0qKZ3nQOi6ax9Puccs2YD
         uSvQ==
X-Gm-Message-State: AOJu0YyoGiMZzfxHp6XVtgCl9Ru8z/mDW4lOgKnbaulMuawo9gf+zpLg
        xXZAlugnnJi03petEQpfOSjglGMtZjMJJw==
X-Google-Smtp-Source: AGHT+IHitO328tOb5Z8DDIlC/7Z8HQLMdYblfo5O4pGuk//acpQhJzo56XOKqbDoZbkUr9YJVJ72zQ==
X-Received: by 2002:a25:ca54:0:b0:d9a:b67f:94e3 with SMTP id a81-20020a25ca54000000b00d9ab67f94e3mr14230365ybg.52.1701167257842;
        Tue, 28 Nov 2023 02:27:37 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id y16-20020a258610000000b00d9c7bf8f32fsm3449771ybk.42.2023.11.28.02.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:27:36 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ce8eff71e1so34781397b3.0;
        Tue, 28 Nov 2023 02:27:36 -0800 (PST)
X-Received: by 2002:a05:690c:fcb:b0:5cf:b2cc:cf5d with SMTP id
 dg11-20020a05690c0fcb00b005cfb2cccf5dmr8410244ywb.5.1701167256195; Tue, 28
 Nov 2023 02:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20231108-wave5-v14-rebased-v14-0-0b4af1258656@collabora.com> <20231108-wave5-v14-rebased-v14-6-0b4af1258656@collabora.com>
In-Reply-To: <20231108-wave5-v14-rebased-v14-6-0b4af1258656@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Nov 2023 11:27:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUYOq=q1j=d+Eac28hthOUAaNUkuvxmRu-mUN1pLKq69g@mail.gmail.com>
Message-ID: <CAMuHMdUYOq=q1j=d+Eac28hthOUAaNUkuvxmRu-mUN1pLKq69g@mail.gmail.com>
Subject: Re: [PATCH v14 6/8] dt-bindings: media: wave5: add yaml devicetree bindings
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ivan Bornyakov <brnkv.i1@gmail.com>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        devicetree@vger.kernel.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, "R, Vignesh" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

CC TI K3

On Wed, Nov 8, 2023 at 8:29 PM Sebastian Fricke
<sebastian.fricke@collabora.com> wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
>
> Add bindings for the wave5 chips&media codec driver
>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Thanks for your patch, which is now commit de4b9f7e371a5384
("dt-bindings: media: wave5: add yaml devicetree bindings")
in media/master.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/cnm,wave521c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Chips&Media Wave 5 Series multi-standard codec IP
> +
> +maintainers:
> +  - Nas Chung <nas.chung@chipsnmedia.com>
> +  - Jackson Lee <jackson.lee@chipsnmedia.com>
> +
> +description:
> +  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,k3-j721s2-wave521c

This is the only compatible value defined which contains both "k3"
and "j72*".  I assume the "k3-" part should be dropped?

> +      - const: cnm,wave521c
> +

This also applies to the driver added in commit 9707a6254a8a6b97
("media: chips-media: wave5: Add the v4l2 layer") in media/master.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
