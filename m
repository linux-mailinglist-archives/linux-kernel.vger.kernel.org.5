Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53486755D07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjGQHfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjGQHfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:35:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D033E4E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:35:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6f943383eso59252301fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689579338; x=1692171338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNtMWDdxQcQ/Rgdh5YpqsNpdLBgiRfEqCbrvhZRgZSc=;
        b=snVbM6xsVnMQ3wBc3rNvxsJBU4mpBFIX3tnXHJ0CohWJrW91+ub0JNZX06H9vtPyiX
         Q7JuYJKE1ehamQDiWhEYCZqCNai0BX2SLMRf12QaRufs++NJrUJMIK6JzqQ+pJu5ezGN
         +fXnVDdd/u1M3ngcZYITZIwUgZGxad1J3gVuI58ZZR0T/PxmYSg52Es8bINsyMeOsA7z
         KMosbRb0Jbw68iIizjoiGt/C5spVG4OTdTjj/EoCubVpoXIPxf49hONRbSN7sTS2TVUo
         kIzbfue6zl9iWPXKDjePuxDqH107NZQsUGoZcVbHSRmBnKBSgqq/XKRR69EFYsLwS3/u
         2BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579338; x=1692171338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNtMWDdxQcQ/Rgdh5YpqsNpdLBgiRfEqCbrvhZRgZSc=;
        b=UM9H3Kjuyii/1J+FfpnEuYOSBZNcc8MWwu7dl8y92GING3odfV8Lac4USjvbHi++4p
         an8Yz/qdY8aIMO2Q38q6PQ4NfbTgKg1ER+4FqSCHWFLPRNYdO8vgPr5vSJ5QnLg+3Ahq
         mG0RyFWAO5URbPKd8XulGJdXvWUv4cNrVaBFVStj3nVLhuf+HPFB1obMtC5j9RqOzbT9
         4QZoOcCh2YwEbzTqM4jipUstBe9jAly7AsnYCAlQNiCU2cldzF3CmlYRslqbl3gf3ISE
         zEhrH3C34QsInolELuQJdOJg3XVfFmexXa+hgDWhHzT/NipBWn5iv0WSTfnnf6dzEi3I
         dvlQ==
X-Gm-Message-State: ABy/qLbBR8lwAChtIT4i92tFuFN/6p710yp6iBTPNH0H3fa7OnqemTek
        6SRBlQjLdEZjbK1uESSyYr/23L64T2e+KUBlgs4zLw==
X-Google-Smtp-Source: APBJJlEnPNz6Ao9ExqCpxpa/oaGoY0KEh0WQFxxXtxEH3ecR5ZkfO0rOdJUWaoEDSGZgREKnV7bPWvQ145XHDX81zgM=
X-Received: by 2002:a2e:b710:0:b0:2b9:45d1:da10 with SMTP id
 j16-20020a2eb710000000b002b945d1da10mr510722ljo.48.1689579338276; Mon, 17 Jul
 2023 00:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230622121141.218623-1-brgl@bgdev.pl> <CAMRc=MdegR2e7sFC+PQAy5WcQ3avb5Sz5VV0xCxAHqP2ZBJzCg@mail.gmail.com>
In-Reply-To: <CAMRc=MdegR2e7sFC+PQAy5WcQ3avb5Sz5VV0xCxAHqP2ZBJzCg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Jul 2023 09:35:26 +0200
Message-ID: <CAMRc=MfOBNB3Jsk43aGdehAZzXPcH6Mek-bht6wKhTJ8ddXM=g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] arm64: defconfig: enable the SerDes PHY for
 Qualcomm DWMAC
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:10=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Thu, Jun 22, 2023 at 2:11=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Enable the SGMII/SerDes PHY driver. This module is required to enable
> > ethernet on sa8775p platforms.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Resending separately as driver updates have now been picked up into the
> > maintainer tree.
> >
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 0777bcae9104..63f54d02c994 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -1380,6 +1380,7 @@ CONFIG_PHY_QCOM_USB_HS=3Dm
> >  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=3Dm
> >  CONFIG_PHY_QCOM_USB_HS_28NM=3Dm
> >  CONFIG_PHY_QCOM_USB_SS=3Dm
> > +CONFIG_PHY_QCOM_SGMII_ETH=3Dm
> >  CONFIG_PHY_R8A779F0_ETHERNET_SERDES=3Dy
> >  CONFIG_PHY_RCAR_GEN3_PCIE=3Dy
> >  CONFIG_PHY_RCAR_GEN3_USB2=3Dy
> > --
> > 2.39.2
> >
>
> Gentle ping now that the merge window is over.
>
> Bart

Gentle re-ping.

Bartosz
