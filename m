Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532A079BA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349343AbjIKVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjIKJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:48:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E7116
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5007abb15e9so7154670e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694425677; x=1695030477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm2YmJVOriV/yRdvcbsQXLItPPHdzGLbJNDl3+HotFI=;
        b=YcceNAiVWOcbu+B4TJdxxCswMRE6NwsLtZFBhY08fUn5sZfJId5x0vP/NBdTLmDYNY
         bURsez4j5s1lE4fuCbf4/XFyf5xaVOqS6JmmMElTG40EpzeRjuSowvBo+DiyRBYK+Ykx
         9yrfOzPhEf43Ww7BeOR135MNSfmiqeA/BQSww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425677; x=1695030477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm2YmJVOriV/yRdvcbsQXLItPPHdzGLbJNDl3+HotFI=;
        b=FmOzk0Ex48BRf5OBhMJbL2Qt6Qu9u0W0pj1j4KDkIgAtY64buFEkpJAxwAawZZoK7Q
         oTfc6yJ/1yeE8fBf/cPbNaWuqZcyLGurdLIP2Y3Wsl9btWAVvF2VFcJ6j1QS+jWCTqTz
         wRfjud1vaClfg1iCyAHRMApVCmjY8CmaCbrLbHgsdHlt2g8YrnaBy0gZqR1QT9FUiomc
         UYRgTK3+5R8MzFRGO807ke1uhCy16240CTSpnWWYBA/+MAqYPIBoWAQ4qC2O/uL3FGgl
         gxi+MAMYOYBLTNrgqekikAX+qjFrRv7pmGr26B4mxdtxuTlziJoGXIEbKt4KOTl0fGfj
         qaTQ==
X-Gm-Message-State: AOJu0Yzrn9rYIcR53xln5yE72klGnbQcYAEH1DEJm2HSQsPEZQivHQMZ
        PqIwrNMieTnSQhdUD5EMWJxZF+X46jdanc4muj0B0Q==
X-Google-Smtp-Source: AGHT+IGWjA/3h5X0/Q/l0sfVCrt1QJB9gmyw19Mcqrpt2/l1xxEV7W6ZF/oF6qKEC0slUsiKK7HLJI4rHzdG3BsTnkY=
X-Received: by 2002:ac2:58e6:0:b0:501:bdde:5a49 with SMTP id
 v6-20020ac258e6000000b00501bdde5a49mr6797745lfo.15.1694425677350; Mon, 11 Sep
 2023 02:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911080927.17457-1-chun-jen.tseng@mediatek.com>
In-Reply-To: <20230911080927.17457-1-chun-jen.tseng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 11 Sep 2023 17:47:45 +0800
Message-ID: <CAGXv+5Gqpuu+QVtixOK=ULKkBaqhScFz7tgVqtczknx6CbdjLA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: change CCI OPP scaling mapping
To:     Mark Tseng <chun-jen.tseng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 4:09=E2=80=AFPM Mark Tseng <chun-jen.tseng@mediatek=
.com> wrote:
>
> The original CCI OPP table minimum frequency 500Mhz is too low to cause
> system stall, So it need update to new version, 1.4G ~ 1.05G.

This doesn't read as you think it does. I suggest the following instead:

The original CCI OPP table's lowest frequency 500 MHz is too low and causes
system stalls. Increase the frequency range to 1.05 GHz ~ 1.4 GHz and adjus=
t
the OPPs accordingly.


I also suggest making the subject more precise, like "Increase CCI frequenc=
y".

ChenYu

>
> Fixes: 32dfbc03fc26 ("arm64: dts: mediatek: mt8186: Add CCI node and CCI =
OPP table")
>
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi | 90 ++++++++++++------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8186.dtsi
> index f04ae70c470a..b98832d032eb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -39,79 +39,79 @@
>                 compatible =3D "operating-points-v2";
>                 opp-shared;
>
> -               cci_opp_0: opp-500000000 {
> -                       opp-hz =3D /bits/ 64 <500000000>;
> -                       opp-microvolt =3D <600000>;
> +               cci_opp_0: opp-1050000000 {
> +                       opp-hz =3D /bits/ 64 <1050000000>;
> +                       opp-microvolt =3D <843750>;
>                 };
>
> -               cci_opp_1: opp-560000000 {
> -                       opp-hz =3D /bits/ 64 <560000000>;
> -                       opp-microvolt =3D <675000>;
> +               cci_opp_1: opp-1073000000 {
> +                       opp-hz =3D /bits/ 64 <1073000000>;
> +                       opp-microvolt =3D <850000>;
>                 };
>
> -               cci_opp_2: opp-612000000 {
> -                       opp-hz =3D /bits/ 64 <612000000>;
> -                       opp-microvolt =3D <693750>;
> +               cci_opp_2: opp-1096000000 {
> +                       opp-hz =3D /bits/ 64 <1096000000>;
> +                       opp-microvolt =3D <856250>;
>                 };
>
> -               cci_opp_3: opp-682000000 {
> -                       opp-hz =3D /bits/ 64 <682000000>;
> -                       opp-microvolt =3D <718750>;
> +               cci_opp_3: opp-1120000000 {
> +                       opp-hz =3D /bits/ 64 <1120000000>;
> +                       opp-microvolt =3D <862500>;
>                 };
>
> -               cci_opp_4: opp-752000000 {
> -                       opp-hz =3D /bits/ 64 <752000000>;
> -                       opp-microvolt =3D <743750>;
> +               cci_opp_4: opp-1143000000 {
> +                       opp-hz =3D /bits/ 64 <1143000000>;
> +                       opp-microvolt =3D <881250>;
>                 };
>
> -               cci_opp_5: opp-822000000 {
> -                       opp-hz =3D /bits/ 64 <822000000>;
> -                       opp-microvolt =3D <768750>;
> +               cci_opp_5: opp-1166000000 {
> +                       opp-hz =3D /bits/ 64 <1166000000>;
> +                       opp-microvolt =3D <893750>;
>                 };
>
> -               cci_opp_6: opp-875000000 {
> -                       opp-hz =3D /bits/ 64 <875000000>;
> -                       opp-microvolt =3D <781250>;
> +               cci_opp_6: opp-1190000000 {
> +                       opp-hz =3D /bits/ 64 <1190000000>;
> +                       opp-microvolt =3D <906250>;
>                 };
>
> -               cci_opp_7: opp-927000000 {
> -                       opp-hz =3D /bits/ 64 <927000000>;
> -                       opp-microvolt =3D <800000>;
> +               cci_opp_7: opp-1213000000 {
> +                       opp-hz =3D /bits/ 64 <1213000000>;
> +                       opp-microvolt =3D <918750>;
>                 };
>
> -               cci_opp_8: opp-980000000 {
> -                       opp-hz =3D /bits/ 64 <980000000>;
> -                       opp-microvolt =3D <818750>;
> +               cci_opp_8: opp-1236000000 {
> +                       opp-hz =3D /bits/ 64 <1236000000>;
> +                       opp-microvolt =3D <937500>;
>                 };
>
> -               cci_opp_9: opp-1050000000 {
> -                       opp-hz =3D /bits/ 64 <1050000000>;
> -                       opp-microvolt =3D <843750>;
> +               cci_opp_9: opp-1260000000 {
> +                       opp-hz =3D /bits/ 64 <1260000000>;
> +                       opp-microvolt =3D <950000>;
>                 };
>
> -               cci_opp_10: opp-1120000000 {
> -                       opp-hz =3D /bits/ 64 <1120000000>;
> -                       opp-microvolt =3D <862500>;
> +               cci_opp_10: opp-1283000000 {
> +                       opp-hz =3D /bits/ 64 <1283000000>;
> +                       opp-microvolt =3D <962500>;
>                 };
>
> -               cci_opp_11: opp-1155000000 {
> -                       opp-hz =3D /bits/ 64 <1155000000>;
> -                       opp-microvolt =3D <887500>;
> +               cci_opp_11: opp-1306000000 {
> +                       opp-hz =3D /bits/ 64 <1306000000>;
> +                       opp-microvolt =3D <975000>;
>                 };
>
> -               cci_opp_12: opp-1190000000 {
> -                       opp-hz =3D /bits/ 64 <1190000000>;
> -                       opp-microvolt =3D <906250>;
> +               cci_opp_12: opp-1330000000 {
> +                       opp-hz =3D /bits/ 64 <1330000000>;
> +                       opp-microvolt =3D <993750>;
>                 };
>
> -               cci_opp_13: opp-1260000000 {
> -                       opp-hz =3D /bits/ 64 <1260000000>;
> -                       opp-microvolt =3D <950000>;
> +               cci_opp_13: opp-1353000000 {
> +                       opp-hz =3D /bits/ 64 <1353000000>;
> +                       opp-microvolt =3D <1006250>;
>                 };
>
> -               cci_opp_14: opp-1330000000 {
> -                       opp-hz =3D /bits/ 64 <1330000000>;
> -                       opp-microvolt =3D <993750>;
> +               cci_opp_14: opp-1376000000 {
> +                       opp-hz =3D /bits/ 64 <1376000000>;
> +                       opp-microvolt =3D <1018750>;
>                 };
>
>                 cci_opp_15: opp-1400000000 {
> --
> 2.18.0
>
