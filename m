Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502AD7FD9FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjK2OoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjK2OoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:44:15 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD2ED7D;
        Wed, 29 Nov 2023 06:44:22 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7c51dd41046so385998241.2;
        Wed, 29 Nov 2023 06:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701269061; x=1701873861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTV80m9sniZZhV3ayqmHUOTEjpARmiBjH4lGv1FbT5I=;
        b=dx0z/LVUZd0Ry64k8tKwDlJhhalxoWYDRFnNJW0j+dv3Xj8KMA1GX0D5fWFuZszdPE
         bAuIJn4G+Slp99uQ2mQ4bDrvBkidXDXpFoslmJRJAuxHh7QBX4hgO9kj/Cq8CAYrTVEp
         uD1i/u3qTa2OSGgQLjEvU0GC8Ob5wFddEK7jR8EMcsh5UlrZVAnjn1zj7GOr0ZzLP92N
         pgZdMVayhoS1UI+68RvgMRXsfY5M4POnj6K3LAi4fCn5Cyp9pL66WP+FAWn8SNmfds57
         Vbn48UJo9nppZfivnjEIYvSfxE712PHPRYps5/qgff6oKZGNqPjGj9rOR3g8W+Wqyqg9
         LSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269061; x=1701873861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTV80m9sniZZhV3ayqmHUOTEjpARmiBjH4lGv1FbT5I=;
        b=hFGCOAUdj59BYF5YU/6CU7w12fNmJzSRQClsKf4O1PJG/2WP3T/eav6ZLMs32IStbJ
         BkrM33RhAhq939OTrOUHG4vsshdBdfyX2Bl5/LpCwLbpkAif2xPkXMAbfAFiawf/2Ujl
         SvkqOIkd+srwid/X2vlAnYqnZhFrxV+ET28ELsJWALoAcqcdHj4MkYYPNZVoLNzWzQmt
         24gjYebGBa1jN8+qx0TeNegz0MdE+M2cac/5qhNHwR1wUvr4LDzWHMmc7Yc1+Rwv8ndy
         xFU3VCO90KeAscRpkXeYediMvi5ug4boc5cpKAzfdlidSXvkgJzpGyymkjxMsRbeO4IN
         55Ag==
X-Gm-Message-State: AOJu0YwAO292AwQVD+JpQgjwFl50l80q3EbduzCMW/Jqq+AB3sI5gxka
        Fu8oymZCtytO//Nd4CEQ4Bwx95twgveovZDqPhE=
X-Google-Smtp-Source: AGHT+IGCDZngG6ZtwGuhcqjwolhGC3Bvfp2wdcOUa92UIOUe7pr+Bgg29exfKB/1In2II5AeSFKMuEaLbCW3MxZjhBs=
X-Received: by 2002:a05:6122:da5:b0:4ac:5a8:f45b with SMTP id
 bc37-20020a0561220da500b004ac05a8f45bmr21359729vkb.5.1701269061166; Wed, 29
 Nov 2023 06:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20231017104638.201260-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231017104638.201260-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 29 Nov 2023 14:43:32 +0000
Message-ID: <CA+V-a8t3sGn83vpgjECf5dw=bbz2yPXpnn+v2Dx2q3yJRPsKgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add missing port pins for RZ/Five SoC
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Oct 17, 2023 at 11:47=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi Geert,
>
> This patch series intends to incorporate the absent port pins P19 to P28,
> which are exclusively available on the RZ/Five SoC.
>
> Cheers,
> Prabhakar
>
> RFC -> v2:
> * Fixed review comments pointed by Geert & Biju
>
> RFC: https://lore.kernel.org/lkml/20230630120433.49529-3-prabhakar.mahade=
v-lad.rj@bp.renesas.com/T/
>
> Lad Prabhakar (3):
>   pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
>     macro
>   pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
>   riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
>
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 263 ++++++++++++++++++--
>  2 files changed, 242 insertions(+), 25 deletions(-)
>
Gentle ping.

Cheers,
Prabhakar
