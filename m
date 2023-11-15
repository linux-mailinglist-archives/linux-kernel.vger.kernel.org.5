Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708027EBCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjKOGIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOGIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:08:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D39AE7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:08:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507cee17b00so8556554e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700028526; x=1700633326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrRtND/YRUzURuoQwjKJk/HonLng3kvTj/8TZ3Odh2Y=;
        b=S5tBlUMYSc8tCkMz+qNoAyoyCed8ciKJuLDunru4IFPcL9XnYZuxEBjVlmeUnzKl7d
         N75cxkPn3PMp7CnxAG1NGOY1IWj+JnKyjuFVv0uzsZiYpl6LzRe6WA2EeUHEy4JTNFPf
         6nJLfidy3e2wz8M8fpvRV7jIHmFesUbRHYk7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700028526; x=1700633326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrRtND/YRUzURuoQwjKJk/HonLng3kvTj/8TZ3Odh2Y=;
        b=Mxux+sCBrg+q2EVpTkVu5KCEjDChmc5fc2a0XhnSPaLKh6abruJ0WitTAvpgP/bRck
         Qa4yfFr19icnMRCiJgY6oJHv1babJFFbuw9uR8G+/eQ+/PBKtgpQrz0I0EpZsciELNYJ
         8wqarXEZBouI2O7F1y/mA558iFXYeJRvbFzBnal9rNqD/qWbRBodNnFpdQkQkxuIqY63
         Rjmo8xbBrVEq5sKGEqA46iHI02fbL7L3CxtcQdsU2rRrYll1tTj9wBd4BcE+PLskcv/a
         oLOncxZyP4pPyaVsz2aOFdoODqZpbqX1E4u1aBq+uKigPjSlHm56kMcQuQZCpW1lvvBd
         UrKA==
X-Gm-Message-State: AOJu0YwjQWfEIXYBSaJXIEPB2W17uiluMpdlt0YFTbsrR4JekKR3o9Yh
        1rAdfJmqypmU7+rLC15EH6q8/pWLdHLWumGa5uVoPA==
X-Google-Smtp-Source: AGHT+IEElVyq/Wfz+fZN9g5gHhgB0rYPl8JRXgccOm8OavEsvJYgG8EGZ+VI+3AA2iv3HFdt3nFxSDC3zZjP6Wt+9vg=
X-Received: by 2002:a05:6512:b14:b0:509:8e3d:7cb0 with SMTP id
 w20-20020a0565120b1400b005098e3d7cb0mr11292990lfu.41.1700028525615; Tue, 14
 Nov 2023 22:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20231115043511.2670477-1-treapking@chromium.org>
In-Reply-To: <20231115043511.2670477-1-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 15 Nov 2023 14:08:34 +0800
Message-ID: <CAGXv+5FnzLgnNfvK-KEd4OUysUXqCuCp7AJ3iuzEGn=fry0B1g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8173: Add G2Touch touchscreen node
To:     Pin-yen Lin <treapking@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 12:35=E2=80=AFPM Pin-yen Lin <treapking@chromium.or=
g> wrote:
>
> Lenovo Ideapad C330 Chromebook (MTK) uses G2Touch touchscreen as a
> second source component.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

I assume this patch will get merged relatively soon. I can base my DT
probing work on top of it, instead of having roughly the same patch
in my series.

> ---
>
> Changes in v2:
> - Remove the label for the node
>
>  arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm=
64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> index bdcd35cecad9..8836ac3c4233 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> @@ -29,6 +29,14 @@ touchscreen3: touchscreen@20 {
>                 interrupt-parent =3D <&pio>;
>                 interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
>         };
> +
> +       touchscreen@40 {
> +               compatible =3D "hid-over-i2c";
> +               reg =3D <0x40>;
> +               hid-descr-addr =3D <0x0001>;
> +               interrupt-parent =3D <&pio>;
> +               interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;

I assume Angelo might ask you to use interrupts-extended instead, but
I'd argue it's better to be consistent throughout the file.

> +       };
>  };
>
>  &i2c4 {
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
