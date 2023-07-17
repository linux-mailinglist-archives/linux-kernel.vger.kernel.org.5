Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C7C755BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjGQGjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGQGjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:39:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886B510DF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:38:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9928abc11deso590714666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1689575927; x=1692167927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWQWIk3NBqBuw9yCguIwXHMFT06skj7j/7OrSp9YvDY=;
        b=Zu+rg+BuG1hAxOszOSA9SNnREGJKzWpb2UWoMqEcW5Tj4/K02abGjZHu1q51TmbM3C
         iuxN9UAG8yzpCeTFJZIGdwTpaFWtduA6Ki5K+SspsyAS4Oiae0DDbODtrFg45dIlYbgK
         Y/7HOqr7Z75tHFqi8wL0Es6TXQGl2JcJPFleB0n/YhoCQYJAAd/z/5/06/22yzpdb7GT
         H2ImXpt7JpfSyPo6huY83aqtdsTPCG7136InpR/Xc8Q6QiSRO5w6mHBQfyTxoD+EZAfW
         gITKuest1id8VzPskXGmwCo8KeSjpQFWIp60zsfg3g+Y1pbYYTCikHdokcpgJ1p1kp+7
         0ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575927; x=1692167927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWQWIk3NBqBuw9yCguIwXHMFT06skj7j/7OrSp9YvDY=;
        b=eXEI/4tErHr5f9OTF2dIKvrOi0lhI7KAMbBQqOJ+1h8SZ6tMfl5hfG/U+3lXxbFJfX
         8hTuJtQSXrHUCyaqpe+ql7ZYLXAV7Erv/fVOpR+PO32hB7dbfQ4fQP3tQtTq/c1ocjpw
         GMDAA3wWT+471VPj815ABU5D0KggnpxHM+pT4DApsVY2eBgXJqx9gn4dXo5bIkbr7mqQ
         DEGEzDyfDIaBSdYTfA8S8M302qNR1J+R8/DATFrdZ0nf98nk19M/3C+av+nqU7PMSwbm
         Sql54ggtJw7g4DX4afDkIm7IXGtMfyCWHO+0lnh4NeZ11B2F1hG12n3+vnHhJF1b7M5J
         g77A==
X-Gm-Message-State: ABy/qLYSvXv3KPHfknusbhUCmzAf7bI0eFMNeM+ew3wrtZX7oh2NuzG6
        GFnxXVkQOKsKbKH8ee9RTQZcgMj1TPJsfuWysVUiHg==
X-Google-Smtp-Source: APBJJlEibRndF3dqviO1ZDHztBWuqoV+MM1b0aOzzqp5KEV1Wx1sAv7F2B85GB4FI4nYRU8PqIGyzTf8uKut/h3IYGk=
X-Received: by 2002:a17:906:3f57:b0:94f:449e:75db with SMTP id
 f23-20020a1709063f5700b0094f449e75dbmr8701904ejj.52.1689575926814; Sun, 16
 Jul 2023 23:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174023.4039938-1-robh@kernel.org>
In-Reply-To: <20230714174023.4039938-1-robh@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 17 Jul 2023 08:38:34 +0200
Message-ID: <CAHTX3dK1hrSU2fmK2n0LEKFZbRUfVHX0QeRFHwJ9zQdSG0=aXg@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 14. 7. 2023 v 19:40 odes=C3=ADlatel Rob Herring <robh@kernel.org> n=
apsal:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/microblaze/kernel/reset.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/microblaze/kernel/reset.c b/arch/microblaze/kernel/rese=
t.c
> index 5f4722908164..2f66c7963084 100644
> --- a/arch/microblaze/kernel/reset.c
> +++ b/arch/microblaze/kernel/reset.c
> @@ -9,7 +9,6 @@
>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> -#include <linux/of_platform.h>
>  #include <linux/reboot.h>
>
>  void machine_shutdown(void)
> --
> 2.40.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
