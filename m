Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4B75DC7A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGVMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGVMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:24:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C08210E;
        Sat, 22 Jul 2023 05:24:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-267f68fdccfso63390a91.1;
        Sat, 22 Jul 2023 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690028646; x=1690633446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+TXoV0EO/SD5DvE1XwqMaH8zsVLkDh0doqX0bYlwo0=;
        b=U/roaTDh96JdS/pOt4zEyp+1o6i8DXW33jtfDcgjTgx8J5GxkqE4h2B5h3xZMtAhdY
         HaRUmUgJkVMmgm69n5FSi0yavBPsUvuCf9lPT05fjby6i7es954FGGdz5tW0y+xKBvZt
         +CI1y0rHwTn9aYRhJL6wXd7KWGe+r4gxXri4ay3xxF6F7wLyU4k9C01ltjMEhd4ugDC7
         cnCMTQnCow0V8z743RQauORUrIreutY5eHr2dXh8OJt83GaEVGGVdrqWOvfaqSKmIDTA
         ArH8YbMEv3H0tBsBxPqgUHqXBVEfIdZowARe5DHI6qwFEvb4/rjnbfxm47FiBxtdNhxM
         ly/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690028646; x=1690633446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+TXoV0EO/SD5DvE1XwqMaH8zsVLkDh0doqX0bYlwo0=;
        b=EFkpFn4T8g7OOaZOsH4weumFAhTMco1vOnzhryKqe6jk1RB/PZnDNilcpZ8S2lvmvX
         stpoEid4V0eqXd6+knFYg9X+Xf8gsEwdm0bvPMcsuqocq/ZOYPi7PNGP6wLjXT5ZP1od
         KW3GdMy2dz1ttq0drZNQMVm+mrjHmpQr8TYR0uexWZHaR6EjX43uHrG0Wu2C7YEkPtPf
         m+1opWU+CF8gPIpXMg291lxOeje5Kb5vBmZdJ6t0EYsjIEHP2VIkrPB4vJEG2Uy1zPWY
         dOShluM+NkmqzUQq0Z8owQHjFuTbeS1lbnp18Nylew149k/gxr7+5EWEqFjC4HnnWkre
         JuQg==
X-Gm-Message-State: ABy/qLaLj/w9Kx3TNp0R0d34fXaEBvdFcSy9pOn7o3SUrxAwDD6IUH9V
        mp0CtkwUio/ezqnrEAke5aNeBxc8HSLIAXqDst1Y7j8Qi6g=
X-Google-Smtp-Source: APBJJlGiTJiDC3PcJ30wWNQG2ghzCiHfafNOYMz3k1tWFhoA+8Dxtjd9bun3lqD52GHxFmU2zIGR9Wgf8hE2SsElBg8=
X-Received: by 2002:a17:90a:304b:b0:262:c2a1:c01f with SMTP id
 q11-20020a17090a304b00b00262c2a1c01fmr4103581pjl.3.1690028645911; Sat, 22 Jul
 2023 05:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230721232123.2690960-1-xiaolei.wang@windriver.com>
 <CAOMZO5AMDvERRaSUYtuf_zq4foSqUuo0kErhj+hEZUuZRPXv1g@mail.gmail.com> <13c51031-ed91-d641-6336-206298f1b60a@windriver.com>
In-Reply-To: <13c51031-ed91-d641-6336-206298f1b60a@windriver.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 22 Jul 2023 09:23:54 -0300
Message-ID: <CAOMZO5AEJP2T26REbr8Wc17jENpgJq1Ktyp137zo9M1zDFRASQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Set default tuning step for imx7d usdhc0
To:     wangxiaolei <xiaolei.wang@windriver.com>
Cc:     Bough Chen <haibo.chen@nxp.com>, robh+dt@kernel.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Sat, Jul 22, 2023 at 4:29=E2=80=AFAM wangxiaolei <xiaolei.wang@windriver=
.com> wrote:

> Oh, I didn't notice this patch on linux-imx, I refer to the settings in
> https://github.com/nxp-imx/uboot-imx.git,
>
> but it should be the same, I think it is better to bring this patch in

Please send a patch that passes:

fsl,tuning-step =3D <2>;
fsl,tuning-start-tap =3D <20>;

to all usdhc instances in imx7s.dtsi.

Other imx dtsi files do this, but imx7s.dtsi currently misses these propert=
ies.

Thanks
