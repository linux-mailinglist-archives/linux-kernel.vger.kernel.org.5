Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C85F7F97D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjK0DHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjK0DHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:07:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2CD123
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:07:40 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50ba75e33f3so2549032e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701054459; x=1701659259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlaRJlvg6SkH3iVCCMUur0uADxqCqngF5eSxepb74eo=;
        b=nfT7tdICMIesqGQtcjuIgaf0csctl9yePlEA6YHx+rQHLtwbpR0+mOnpP05dHEQjjK
         L7BVjxF1GtskmgBBB+guCAbgvmqv/h0BN1HJ/j3N/r4DqsqOIU82arQbx6xbunelX1Eq
         j9dR3/gjI4Vrqx2YuAMgFtMTzv3qGXM6RNntM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701054459; x=1701659259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlaRJlvg6SkH3iVCCMUur0uADxqCqngF5eSxepb74eo=;
        b=sd2HgrMkD/CVSszxMxzFYckzq3x4ku6s/nVTmkK96l9vuZHEczOSqRzwFkDbAl8dnZ
         hWuI5cIiEt0PIrjYgOLxxYV9WvHwD/1bCoJIk2x62+bONf3xaBcUO4jfjz9yDcHHd/uI
         pIV10EKugkUhDHAHOB5uQtW/5twxFT+/QuvA3jrS7k4L8EATVKgIOsYuZ+oEtW1/hHH/
         nOYSXBHc/xpcbMLvxyLb7IZQhyGoFNLQCCp/wYjDhYuoPc/+wypG/fT8buK093u3Khfi
         5JuWU6hizXYEqnrn677jGV2X0z/hKfy1XRQBlHrMTh+3YNGdfPCfvXEc0gfhlQ1u9YJ1
         2wCg==
X-Gm-Message-State: AOJu0Yzx2SYzqr4ol/XSIgfVcPgRLRk9ME9UqdviuFOn75tdS8cREkbe
        8yfgWmiWLv+jSBfkCs1Net9C0R8Q5t+3YqTV6pUhxQ==
X-Google-Smtp-Source: AGHT+IF6iA8pXDpSmsO5bEY3xSd26XCL631sAXkpfn6+jD0thwzCwvWTVnjzWxDvI99Qtb6aAqinHNpBcziXbA/wSss=
X-Received: by 2002:ac2:4c48:0:b0:507:b7db:1deb with SMTP id
 o8-20020ac24c48000000b00507b7db1debmr8091073lfk.38.1701054458668; Sun, 26 Nov
 2023 19:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20230913084457.1638690-1-wenst@chromium.org>
In-Reply-To: <20230913084457.1638690-1-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 27 Nov 2023 11:07:27 +0800
Message-ID: <CAGXv+5E5BWzMP981Agn01XVAO=KC5CE04oOi8xWwx=DT=N61dw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Matthias, Angelo,

On Wed, Sep 13, 2023 at 4:45=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> The ldo_vcn33_bt and ldo_vcn33_wifi regulators are actually the same
> regulator, having the same voltage setting and output pin. There are
> simply two enable bits that are ORed together to enable the regulator.
>
> Having two regulators representing the same output pin is misleading
> from a design matching standpoint, and also error-prone in driver
> implementations.
>
> Now that the bindings have these two merged, merge them in the device
> tree as well. Neither vcn33 regulators are referenced in upstream
> device trees. As far as hardware designs go, none of the Chromebooks
> using MT8183 w/ MT6358 use this output.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Please remember to queue this up. All the driver changes were merged in
the last cycle.

ChenYu

> ---
> This was part of the series "regulator: mt6358: Remove bogus regulators
> and improvements". Since the driver parts related to this patch have all
> been picked up, so I'm sending this separately.
>
>  arch/arm64/boot/dts/mediatek/mt6358.dtsi | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6358.dtsi
> index 96ba8490b629..ad5e4022e06d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> @@ -292,15 +292,8 @@ mt6358_vrf18_reg: ldo_vrf18 {
>                                 regulator-enable-ramp-delay =3D <120>;
>                         };
>
> -                       mt6358_vcn33_bt_reg: ldo_vcn33_bt {
> -                               regulator-name =3D "vcn33_bt";
> -                               regulator-min-microvolt =3D <3300000>;
> -                               regulator-max-microvolt =3D <3500000>;
> -                               regulator-enable-ramp-delay =3D <270>;
> -                       };
> -
> -                       mt6358_vcn33_wifi_reg: ldo_vcn33_wifi {
> -                               regulator-name =3D "vcn33_wifi";
> +                       mt6358_vcn33_reg: ldo_vcn33 {
> +                               regulator-name =3D "vcn33";
>                                 regulator-min-microvolt =3D <3300000>;
>                                 regulator-max-microvolt =3D <3500000>;
>                                 regulator-enable-ramp-delay =3D <270>;
> --
> 2.42.0.283.g2d96d420d3-goog
>
