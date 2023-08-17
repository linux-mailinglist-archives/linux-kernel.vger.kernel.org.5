Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73A577F31A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349458AbjHQJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbjHQJTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:19:35 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002C1FE2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:19:34 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-48be4fe0dadso133816e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692263973; x=1692868773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbGMPo3tGq+YirHQo7N71fQRLGFMALJjCkoQPoPiIHU=;
        b=Qm4ciNzlc9FRYwftkqfSAyfAJyKqfzBRh+ndFYouevcnVSonb3hkzyvNI/TpnCr7df
         YQVULPS4tC7BQPr/r0pwsUCTYp2OeYVOwQStWnaMlrdJ2CswwHkpGf3RWEeQRg7YL1c9
         NM0YInO7/bmGJBXYmx4HfUeLSpeUf0aNlJcHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263973; x=1692868773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbGMPo3tGq+YirHQo7N71fQRLGFMALJjCkoQPoPiIHU=;
        b=XnMT1q8G/YeSMnEZsOMxZO6TSozwNBBc9g/Duj7Etz4RZNJHNUA7eRV2eYRwsHkwbj
         pMTzm7mEgNw472BHya/eTtDZ/H3EGomx1LEtRJzmxMHSqKUDqzp1KudbT4lnrp7+jhbl
         IAGulDpU61urtO5BWMBCXRcJBLPtnChtYPn+afevW7gRa8Z7STzGkaYVO9JVdfSJiTv3
         cFJOAMs3iunj+kz4S/q5EG6xK3bTEFPUGvM3rdoddK4AslGjBvv8dPmoiIiN/g6QBe4z
         QnuXI9P4hK34WVQkV6KIsp9Aris/z4pCbz8BydTgIJiSMKUUbbXAVmIueTrrngrtVCo9
         9k2A==
X-Gm-Message-State: AOJu0YzpeVd0VC3g5JTKsnDusTTrR2zhtSHxc4/O5kSB7vAYmw4SSikp
        qvOiLfhVROrRG2VkTDl8bEt8Z/IZ1PRFmjTLJ7F0mQ==
X-Google-Smtp-Source: AGHT+IHwlHp84D6NTZQKO4FRUFD+68Z2Jmt2OGg+nN3JshwrNkRkLgGjAWC0Nkmq381j0LC9zkZDtC2kGHPxE51tmPw=
X-Received: by 2002:a67:ce0e:0:b0:443:7eba:e22c with SMTP id
 s14-20020a67ce0e000000b004437ebae22cmr3050838vsl.8.1692263973474; Thu, 17 Aug
 2023 02:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230816190427.2137768-1-nfraprado@collabora.com>
In-Reply-To: <20230816190427.2137768-1-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 17 Aug 2023 17:19:22 +0800
Message-ID: <CAGXv+5EnbovYSfw=_wSKyKTSbDQYu6UW8u8L5bm9PKjN1dVGyQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: cherry: Configure eDP and
 internal display
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
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

On Thu, Aug 17, 2023 at 3:04=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com=
>
>
> Add the required nodes to enable the DisplayPort interface, connected
> to the Embedded DisplayPort port, where we have an internal display.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> [nfraprado: removed always-on, added vin-supply and enable delay]
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
> The MediaTek DRM changes needed for MT8195 have already been queued for
> v6.6 [1], so this DT patch is the last missing piece needed to get
> a working display on MT8195 Tomato.
>
> [1] https://lore.kernel.org/all/20230813152726.14802-1-chunkuang.hu@kerne=
l.org/
>
> Changes in v3:
> - Split from "MT8195 Acer Tomato - devicetrees Part 3" series

The platform thermal patch from that series hasn't been merged either?

> - Removed regulator-always-on as it's no longer needed
> - Added missing vin-supply and regulator-enable-delay
>
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64=
/boot/dts/mediatek/mt8195-cherry.dtsi
> index 37a3e9de90ff..dd5b89b73190 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -47,6 +47,19 @@ memory@40000000 {
>                 reg =3D <0 0x40000000 0 0x80000000>;
>         };
>
> +       pp3300_disp_x: regulator-pp3300-disp-x {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "pp3300_disp_x";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               regulator-enable-ramp-delay =3D <2500>;
> +               enable-active-high;
> +               gpio =3D <&pio 55 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&panel_fixed_pins>;
> +               vin-supply =3D <&pp3300_z2>;
> +       };
> +
>         /* system wide LDO 3.3V power rail */
>         pp3300_z5: regulator-pp3300-ldo-z5 {
>                 compatible =3D "regulator-fixed";
> @@ -217,6 +230,20 @@ port@1 {
>                         reg =3D <1>;
>                         edp_out: endpoint {
>                                 data-lanes =3D <0 1 2 3>;
> +                               remote-endpoint =3D <&panel_in>;
> +                       };
> +               };
> +       };
> +
> +       aux-bus {
> +               panel {
> +                       compatible =3D "edp-panel";
> +                       power-supply =3D <&pp3300_disp_x>;
> +                       backlight =3D <&backlight_lcd0>;
> +                       port {
> +                               panel_in: endpoint {
> +                                       remote-endpoint =3D <&edp_out>;
> +                               };
>                         };
>                 };
>         };
> @@ -881,6 +908,12 @@ pins-bus {
>                 };
>         };
>
> +       panel_fixed_pins: panel-pwr-default-pins {
> +               pins-vreg-en {
> +                       pinmux =3D <PINMUX_GPIO55__FUNC_GPIO55>;
> +               };
> +       };
> +
>         pio_default: pio-default-pins {
>                 pins-wifi-enable {
>                         pinmux =3D <PINMUX_GPIO58__FUNC_GPIO58>;
> --
> 2.41.0
>
