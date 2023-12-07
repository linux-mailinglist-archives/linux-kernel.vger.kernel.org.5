Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F228082F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjLGIZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjLGIZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:25:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C25F122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:25:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC709C433C9;
        Thu,  7 Dec 2023 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701937542;
        bh=fpz3hSpcQoJnZmp0wb8Pb6jeykz0fSOXPRjRXzbi/ZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BdHVz7o7bo/SFplvfZVidqwY6Tgg8lYu2OEOsxtd103fkz7gdWZJWDMdFK0KNe4Gt
         gBay/UGWX0idnnetOLeAVWiWDVnoVz9vROfe/Jzqnht4h0nV6TzjJ0tXYlEE39p3e/
         tzNaXMCrNQCi9WbDzCs5hgUPZXXr9TrgwOgtUzpsUY4UCUC2UE/94xNGgvXvWkDPxN
         ez4Z0D58UcPt/QC32XB2u3foXTILoQsbkHgJl05jtXaHXYnZQgs1ASGvc+dUB2ctN2
         jajV0a3vuxu6TRFpcMDOKMzh8nUT9KQyOpSqTpLo3grw7sBWmi5fpbFBVPWkySFmQe
         BEo75eEcAwHgQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso75165566b.0;
        Thu, 07 Dec 2023 00:25:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yw9PkqPtLz25U5WqsLHaAQ/jW99Uu9KJis4dVP4TnxjVFouDLO5
        380eQyBKF9OZsCn6fYBOplbC1rq0kkCVbXufELA=
X-Google-Smtp-Source: AGHT+IGVol4JPnCCVW5u1xUP5SM0B8ekxDdTr4UjzQn2LIi8K5liZqacGNwq0o5zFMcSbm9sMLegOWYWoXnJXLWPbts=
X-Received: by 2002:a17:906:2c7:b0:a1e:2e2b:1b7 with SMTP id
 7-20020a17090602c700b00a1e2e2b01b7mr908589ejk.132.1701937541279; Thu, 07 Dec
 2023 00:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com> <20231206-th1520_mmc_dts-v8-4-69220e373e8f@baylibre.com>
In-Reply-To: <20231206-th1520_mmc_dts-v8-4-69220e373e8f@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 7 Dec 2023 16:25:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSrd-ywx_aMZHNGbobmF60kqEwkRgz2d_YA0suWWa-HYA@mail.gmail.com>
Message-ID: <CAJF2gTSrd-ywx_aMZHNGbobmF60kqEwkRgz2d_YA0suWWa-HYA@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and microSD
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:09=E2=80=AFPM Drew Fustini <dfustini@baylibre.com>=
 wrote:
>
> Add emmc node properties for the eMMC device and add sdio0 node
> properties for the microSD slot. Set the frequency for the sdhci
> reference clock.
>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi      | 20 ++++++++++++++=
++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arc=
h/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index a802ab110429..1365d3a512a3 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -29,6 +29,10 @@ &apb_clk {
>         clock-frequency =3D <62500000>;
>  };
>
> +&sdhci_clk {
> +       clock-frequency =3D <198000000>;
> +};
> +
>  &uart_sclk {
>         clock-frequency =3D <100000000>;
>  };
> @@ -36,3 +40,19 @@ &uart_sclk {
>  &dmac0 {
>         status =3D "okay";
>  };
> +
> +&emmc {
> +       bus-width =3D <8>;
> +       max-frequency =3D <198000000>;
> +       mmc-hs400-1_8v;
> +       non-removable;
> +       no-sdio;
> +       no-sd;
> +       status =3D "okay";
> +};
> +
> +&sdio0 {
> +       bus-width =3D <4>;
> +       max-frequency =3D <198000000>;
> +       status =3D "okay";
> +};
>
> --
> 2.34.1
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
