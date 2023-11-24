Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC07F7017
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbjKXJi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:38:54 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5AD7E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:38:54 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso1609670276.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700818733; x=1701423533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geI8GtZzgpBXL5dK3wkA+z2fxGZtMOBQC6A7G59OA2k=;
        b=etL+CSQrBatydm0PGGfHEH9tq/QRETNazIDKmg5AesapV+i2MRq+fnshfUTJaUaYjZ
         Jyd9CBHN0nS8g0fGSRgwu79Fct7LDyMn7ni50M8TqPB2TfPiYqcn8Yix2Xh1Hp7EyZZ5
         I8ZuJdcJMMSRA/stKrj3j2aqvygpb+COFwkh1JSn11nOI/cfd0MypYJmTS9ot0fV0oA7
         lZIBBV59VHdZ92Ej2DppxxKY/Dm3sfSp+QfmL7SJctQVLCZaBViSQVZzJ8Dyeogzlb4F
         SiNtn7aq/8k5Cl+hGYGsM/bJdUvezST/pU6OJSptuMPbDsfuQSbunzlVocT+K+2HbSdZ
         nUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818733; x=1701423533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geI8GtZzgpBXL5dK3wkA+z2fxGZtMOBQC6A7G59OA2k=;
        b=eGPCDFgVwehF0S8+dmLOk+4Gpg60PqqeV1v3OYJqEsRDLNfp3FqX2MAGfDXkOed1bq
         9huIl6oKwW64DAvJcBUwtExUagVrrjIwk+gZJTRneHnqskEDAAhNGcj8+/IMl3Ow7G/P
         ojnMFcONWZVlEPpNqod83gG23qspgBYL1XY5IsHFpSQGadwTcPmT18cAfDF1K8cU0ol3
         xlYzPaUBDlTb9O/y9wVka6V/UMf+ueihjJxqci6BPnvw8k30dKWBWpp/BHmb+C09vqtd
         +zq6LSIS0FPCsPRnh6/7Itd2g88AVVKGyXxcJ8FhPCrpvtrvesyDsXxRtUP6AwXU4wI8
         gq/w==
X-Gm-Message-State: AOJu0YxpQk6Kq0LAfEhKkKLHJrLnrTSqTgErJO5z2DgcnGhJkQTKCkH0
        4oF10y+UI3wXI7ftMgdZz4wZb5p2WIb3urp6IXv4JA==
X-Google-Smtp-Source: AGHT+IEXXvMFd13QXsC43cgyzVVZZH5cHNcXyPv3BXDDLd7/Rf5DZugdNE2BTv/Vm4WYLEoYNSUMRpCXrTwn21upVX4=
X-Received: by 2002:a05:6902:49:b0:d9a:cd50:b99a with SMTP id
 m9-20020a056902004900b00d9acd50b99amr1760789ybh.12.1700818733666; Fri, 24 Nov
 2023 01:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20231116111441.2339-1-tychang@realtek.com> <20231116111441.2339-3-tychang@realtek.com>
In-Reply-To: <20231116111441.2339-3-tychang@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 10:38:42 +0100
Message-ID: <CACRpkdZTFWnH1iwLCeJy02OXJAgTSSVTomzDNEQ3ebWocwkgPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
To:     Tzuyi Chang <tychang@realtek.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzuyi,

On Thu, Nov 16, 2023 at 12:14=E2=80=AFPM Tzuyi Chang <tychang@realtek.com> =
wrote:

> This driver enables configuration of GPIO direction, GPIO values, GPIO
> debounce settings and handles GPIO interrupts.
>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>

Apart from the missing kerneldoc that the autobuilder is complaining about
this looks good to me. If you fix the kerneldoc:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
