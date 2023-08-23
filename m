Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B326785F56
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbjHWSMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjHWSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:12:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27265CD1;
        Wed, 23 Aug 2023 11:12:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b78bf0423so461618a12.0;
        Wed, 23 Aug 2023 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692814369; x=1693419169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfi1MCjIHEtRlK5qwURcP28HIGYnPOfh0hAIrnuyXfs=;
        b=bw0Ib7Wvc3T8Jiw1TxIWLOXGEWigdrNUj+Hz6YzcrlTKkrK3yLz/GeZZkVa8tsF+9p
         pOJ4tkcJ9g5a+HU4xOKhAT3jq5ENubE7Y4PEiNP89o/cKTxdjO6sU3AGykOB6yp3y+3x
         Ope0Xn6VUoThLRJibm/zzh/ArlkhHT07L25JWfzmCm+FyqVqsO/Vq6p7GrFsX6gvIkqu
         bbKHFBl1LBjjEq3U02Hu0GMKklx1ut/SJ+qS7U4+KrYU2ds+XejZlAVaunahO7+iqhE0
         aj4VG0oZh5g4mY6wwb4iHUi/N/gORbDOSReKxzNFutkqAQ8pTEOlS/zxPw4zdMzWHIav
         RwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692814369; x=1693419169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nfi1MCjIHEtRlK5qwURcP28HIGYnPOfh0hAIrnuyXfs=;
        b=QPAKax8qgKWphtZEVIsdCr0AvRnzMm6N2TWJBci/yEwgdZ2HV9rFPtgyaTslIg64AW
         KogNY5PPkrz+iX31VluJrlb/QWqgvbJ9kRwZEu3DoIwgaGUBr778xlZOsQJxGXVvf2Fe
         85Me4kc3bSs5aNVuGN3KmY3B5ENUYqajjuYOs7h7wJDj3oL8x2GYg+s6Sy7NAkfVbqOi
         O/zULxh0Nd982xijfZ/nyfZbW4Vwb7t52rUc+8PU57f43Ys/ZciKguS2a+my1ONUkTJT
         84Ejhtz5KfASP5D4lkEVjYPsgiaGp9LHK7ZjupF2TgD/LcYovXTTIu9Aj+E6SPOMuEGN
         M4pw==
X-Gm-Message-State: AOJu0YxKPA9UFCLwhXHvk/YnEPEv2cAaE9ui7VHpkllpOIfLBAfo1o1T
        Sig0IbkctIkRUp/qIYs3U6StYI8MXFun7m3xs0EAiKcq9UE=
X-Google-Smtp-Source: AGHT+IFF6OhUZ8qx+TAuEvDeAWn7ceIKu3CsmvmhMsA1uaEzf9RUbmyJ5z0dSEIdDcW6jmU2KkQBF68KWTyCDe1AxX0=
X-Received: by 2002:a17:90a:9e2:b0:26d:1eff:619f with SMTP id
 89-20020a17090a09e200b0026d1eff619fmr11985687pjo.2.1692814369623; Wed, 23 Aug
 2023 11:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230823180055.2605191-1-Frank.Li@nxp.com> <20230823180055.2605191-3-Frank.Li@nxp.com>
In-Reply-To: <20230823180055.2605191-3-Frank.Li@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 23 Aug 2023 15:12:37 -0300
Message-ID: <CAOMZO5BBLXyn7zpmb-DKNgJhY9DDP5_TgLZzPGREt-V_curvDw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: imx93: add dma support for lpuart[2..9]
To:     Frank Li <Frank.Li@nxp.com>
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, imx@lists.linux.dev, joy.zou@nxp.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, shenwei.wang@nxp.com, sherry.sun@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Wed, Aug 23, 2023 at 3:01=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add dma support for lpuart[2..9]. The lpuart1 is debug console.

LPUART1 is the debug console on a particular board, but nothing prevents so=
meone
to design an imx93 board that has another LPUART port as the debug console.

I suggest enabling DMA for all ports. That's what we do with other i.MX dev=
ices.

By the way, the fsl_lpuart driver disables DMA for the console:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/tty/serial/fsl_lpuart.c?h=3Dv6.5-rc7#n1696
