Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25B7685AC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjG3Nk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjG3Nk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:40:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7DC1B8;
        Sun, 30 Jul 2023 06:40:26 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5576ad1b7e7so476816a12.1;
        Sun, 30 Jul 2023 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690724426; x=1691329226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glTkxbBHI8FuvLUadeSjD4NNnkjJQ+H4w63ZZABdmPA=;
        b=sQN2Bi8qp05k33larDBVywlucB22K59GBsYSyF/KjdwuffLTv0aYitjRYK/xOVFmFf
         DWyQkVzHrvffItt8A7nDoO4pP5SluIqk0xEJz/ENeMMAn4+ncNoGD1W/N+NgPJCUKtwp
         amBwE44DA7jTiJCxR4q34z2/N70oom0WekXDGsCIe3u9ULPZtNGHqXE2xwxKnp6IU8o5
         TQf+qcmbii3BuBzjWoImuwYcpJDAijCVhOtk+dWQmU4GkVDzNDNaFdvfiWQHqqW6l+Ax
         QXVfMqq3y2fQo6nzy64s4bMzlYEund9vGa4r2MpMpfnaGzBFSwkeCssgMKjkxIhy93OI
         UZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690724426; x=1691329226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glTkxbBHI8FuvLUadeSjD4NNnkjJQ+H4w63ZZABdmPA=;
        b=XYsAYjR48T1eTiCxofJRH4o6pk0PFGTXA0sy0Uh/FtCfh6sr4MkIod6ZkukA+C1P/s
         gUJocUJeusHqE9UnPnULVlzXMVvehXoDwwzkL7zBvZI8Xn1fk5jhgF5O/cAifOchFsAN
         oimDvoETU4j7VV2njcVNGaKwJXj6E6Y3rg3PUF9Z8kOdJrxDtNYy1tBtH3afdnzMJ3ID
         8GGS/anYZ3sWsiHLXUK/bib8otkEWI64Sh62iae0CDOQrWxlhT9LHKMF6iTAX03p7JeA
         vhEN7nzYN1oXzrkSs8gYMuLrvsX/eai4MZ5sDl6tQHHAr6qFYjVJ0WwXDq65dSiHOZTm
         kXgw==
X-Gm-Message-State: ABy/qLZEr0QnEddjjfL3pck5SKOCl98ufHWRp4Ac4ASUNKLqsgbwuHbo
        S7jP7r8Sd/vOrXHokNde6DH9xiVp/fVKfemH2tk=
X-Google-Smtp-Source: APBJJlHHyjBcSw6Sn6fkSgL6k6N+VoMe4zmdxkqQ1fdRviyr9y5VU0Ip/xLfowgnQAULoDNBc2wyUhfASTaeQ52bmJc=
X-Received: by 2002:a17:90a:c84:b0:263:25f9:65b2 with SMTP id
 v4-20020a17090a0c8400b0026325f965b2mr4088255pja.4.1690724425701; Sun, 30 Jul
 2023 06:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230726075747.1016930-1-xiaolei.wang@windriver.com>
In-Reply-To: <20230726075747.1016930-1-xiaolei.wang@windriver.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 30 Jul 2023 10:40:14 -0300
Message-ID: <CAOMZO5D5Lrp0cVyoXjtwhwwDkOiaafX-0yzgx1NcS9UQ_5jh7g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Set default tuning step for imx6sx usdhc
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com, richardcochran@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaolei,

On Wed, Jul 26, 2023 at 4:58=E2=80=AFAM Xiaolei Wang <xiaolei.wang@windrive=
r.com> wrote:
>
> If the tuning step is not set, the tuning step is set to 1.
> For some sd cards, the following Tuning timeout will occur.
>
> Tuning failed, falling back to fixed sampling clock
>
> So set the default tuning step. This refers to the NXP vendor's
> commit below:
>
> https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
> arch/arm/boot/dts/imx6sx.dtsi#L1108-L1109
>
> Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap =
and step setting")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Thanks for your patch:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
