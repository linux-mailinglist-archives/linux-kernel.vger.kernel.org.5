Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792418134FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573850AbjLNPjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573844AbjLNPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:39:42 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F99135
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:39:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d0b2752dc6so74156545ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702568387; x=1703173187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdjSPhIyB1xzNvePwzN4Lv4667HwZ9Mo32XFQbt5RU0=;
        b=CjorwqaMiPGQidFhMzoDJnRgw5CvHfMjnV0O3bnJ1c+7nfTT8pBgXYUBAx+xONuqdm
         PoEwNuy8OExz/JPKygfkdgYZqI62xgBpcHptaSsBD7UzDcOdBJ8geEagtvW2x0OisLMc
         2+6C5IWQ3kQRwZ5Ae1bxVUgZC9iqV3sAlbMg5SrmdF8sy9RU8NmZddpgmCMiFX5HGpss
         h/37tCS94e9A5xhiP6TepgZ0EDJP+pgXjAsXs0qxy9eA5LpW2jE2l0HUz2fC8wqWS8jE
         POMnLIdAjrxhbFAlj0BlUYT8iYQvMU5CVKrCpdB+osbkNAP8nswuTOepaVGcC6yfEH0M
         +ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702568387; x=1703173187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdjSPhIyB1xzNvePwzN4Lv4667HwZ9Mo32XFQbt5RU0=;
        b=k5ZwDXFbW+clv0TD3PIKYXJv5Q4Zetjd+LzP7VJtWO6tZLImDzytsS0yr9kbmq9rWv
         pgTTLa+ocT0LS4lndkXF9+IOcdDIF5EEahQ1nH5KXKXwFRFXIge3rRO5jKGE/VY+iY4L
         FY3s85Gct/AQenNwcF+JMBnan69CBiN0wr1E/7H/AqIdeGqWB7kG/USKujzYIyl5IdUc
         131q7jwKFqqJxNEkHjCtVKVbd5ZJWLzOfrY0GMJeLIm/O4TpM+0X+DJ7gbWtJfg0hn9w
         xTOkPuFEdMTS7gj8UOkyHRwuDu31dhXJSnvZTpL2h5+nOUsyuNIrAJmiMoPnnva0ypyS
         vpyA==
X-Gm-Message-State: AOJu0Yz1n3FwN+h3w/+zqe2dsPq8dTWGfZA85yWJSJeIOBR1DzahzJQ7
        xngdBAzP4mMsWubDyyn5NotYNo+qelZzmAwD/ALYBQ==
X-Google-Smtp-Source: AGHT+IGirM4+nryJ8CQwEZU0IegMIG64eLAF/7DoRqfynsZoP/h4uO2l7qynqj6arTSz3lMXlgfoKAyn+JsuJdyqzHo=
X-Received: by 2002:a17:90a:e50:b0:286:964d:c with SMTP id p16-20020a17090a0e5000b00286964d000cmr7480168pja.86.1702568387270;
 Thu, 14 Dec 2023 07:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org> <20231214105243.3707730-9-tudor.ambarus@linaro.org>
In-Reply-To: <20231214105243.3707730-9-tudor.ambarus@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:39:35 -0600
Message-ID: <CAPLW+4=bfcemh-dd7r9hOe0RbtC01+sNpj3ZMMfc8rMezKQfNA@mail.gmail.com>
Subject: Re: [PATCH 08/13] arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Enable the cmu-peric0 clock controller. It feeds USI and I3c.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index 9747cb3fa03a..d0b0ad70c6ba 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -339,6 +339,18 @@ ppi_cluster2: interrupt-partition-2 {
>                         };
>                 };
>
> +               cmu_peric0: clock-controller@10800000 {
> +                       compatible =3D "google,gs101-cmu-peric0";
> +                       reg =3D <0x10800000 0x4000>;
> +                       #clock-cells =3D <1>;
> +                       clocks =3D <&ext_24_5m>,
> +                                <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
> +                                <&cmu_top CLK_DOUT_CMU_PERIC0_IP>;
> +                       clock-names =3D "oscclk",
> +                                     "dout_cmu_peric0_bus",

I'd pull this line to the above line. Other than that:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> +                                     "dout_cmu_peric0_ip";
> +               };
> +
>                 sysreg_peric0: syscon@10820000 {
>                         compatible =3D "google,gs101-peric0-sysreg", "sys=
con";
>                         reg =3D <0x10820000 0x10000>;
> --
> 2.43.0.472.g3155946c3a-goog
>
