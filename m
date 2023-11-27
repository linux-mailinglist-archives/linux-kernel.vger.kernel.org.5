Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7547F9D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjK0KCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjK0KCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:02:15 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B579183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:02:19 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50aa8c0af41so5091634e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701079338; x=1701684138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAjnvuy3bIc5fGjb9nb5ctNWWJSrBAlAyEp3sSpRk/w=;
        b=Ytama7R1uYLBvEJNurbzev+vvVDDdL0TEBv7tUgpCt4yPk3D7sTx9D4AmvlUgs3CHd
         NsNzGAop4H29rQbLTJWOzKkqt0lhwNsoqSJzDa51iqjd6ZHEYnqfGY/OSx6oTWeaufnO
         0nFRvWw/5/xiWHzob3WpYAU1xIWgSWVXSRLcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701079338; x=1701684138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAjnvuy3bIc5fGjb9nb5ctNWWJSrBAlAyEp3sSpRk/w=;
        b=bq0p2H1yQzEzu6iRkBDMDFGbGk3w8bhNuCW3qHZJIhj/0oe4h/dKdW2ff9EYczVpax
         EH5hTJVnUU1ZL5kqihEqwfxSLnvh1gIluLt+lM/XDXWP+zAt1ZcR8MHsIUnK80eZhfNZ
         sxCbdFQU95ggASHM8LYRG+6XPbwjJhTJJt7pdKh1YGlfEgWVhlXTxiz838eG4lx9JKb1
         BBOSjAALA2ALxy4PGE5xmHhoFOiQVlbv8DBrgia7g1uCjhtxBdb85zLnU5wckOwaOFIx
         njRzL+HRJbvkYTqfl/QBG2YUXuFSST9dA8sZ7dypzfmybomjHlBcKE6ILfsppGV02Pzs
         IkRA==
X-Gm-Message-State: AOJu0YyLhWz5LXPuNddJo1SMjVcgBMfSjRbCaqQPPXr/v4feX8T4o6GH
        czHqsYu0l5azL/5lPc+gsKyMlO+8Nv/4KpJbnSQVvg==
X-Google-Smtp-Source: AGHT+IF0wnC4g6yMuKCAZGpA/zZCG8U/CbU78D4eogjx5O8ynkFaH3hUcJ5lQcoAWF8HMw6ivUX1mBRPScw1wHlbvCM=
X-Received: by 2002:ac2:532d:0:b0:509:366b:a01c with SMTP id
 f13-20020ac2532d000000b00509366ba01cmr2846168lfh.14.1701079337688; Mon, 27
 Nov 2023 02:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20231127081511.1911706-1-lukasz.luba@arm.com>
In-Reply-To: <20231127081511.1911706-1-lukasz.luba@arm.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 27 Nov 2023 18:02:06 +0800
Message-ID: <CAGXv+5EgDk2B_FYo9hNiLVogq+mww1j140W4hsDhywExzgpf2g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add dynamic-power-coefficient to
 rk3399 GPU
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, conor+dt@kernel.org, daniel.lezcano@linaro.org
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

On Mon, Nov 27, 2023 at 4:14=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Add dynamic-power-coefficient to the GPU node. That will create Energy
> Model for the GPU based on the coefficient and OPP table information.
> It will enable mechanism such as DTMP or IPA to work with the GPU DVFS.
> In similar way the Energy Model for CPUs in rk3399 is created, so both
> are aligned in power scale. The maximum power used from this coefficient
> is 1.5W at 600MHz.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3399.dtsi
> index 9da0b6d77c8d..87cfdf570b19 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -2113,6 +2113,7 @@ gpu: gpu@ff9a0000 {
>                 interrupt-names =3D "job", "mmu", "gpu";
>                 clocks =3D <&cru ACLK_GPU>;
>                 #cooling-cells =3D <2>;
> +               dynamic-power-coefficient =3D <2640>;

For reference, in the ChromeOS downstrean v5.10 kernel we have:

gpu_power_model: power_model {
        compatible =3D "arm,mali-simple-power-model";
        static-coefficient =3D <411522>;
        dynamic-coefficient =3D <977>;
        ts =3D <32000 4700 (-80) 2>;
        thermal-zone =3D "gpu";
};

This is for the Mali kbase.

ChenYu

>                 power-domains =3D <&power RK3399_PD_GPU>;
>                 status =3D "disabled";
>         };
> --
> 2.25.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
