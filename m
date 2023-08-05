Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E833771050
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 17:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjHEPBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 11:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 11:01:29 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711D9B3;
        Sat,  5 Aug 2023 08:01:28 -0700 (PDT)
Date:   Sat, 05 Aug 2023 15:01:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1691247685; x=1691506885;
        bh=RK2t5NabxjAZEjqQuJfLG/QNPZc1sOenvcsSLOMRHN4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sXgQKHPD9UFS1dL6MTT4yY7GvQYTweUc6pDyhZrfy5miRqNqcWXwRd52veEokwmUZ
         EiaJDjwsGEOsLbcRhC5cbhhg4luXLp8mIIY4aCvL8XEL4Eux4DVXjbIkClV3Vnx3Ag
         58IhWkxc5kP6VRc62ii64zRHH9pG6fgfwIgwos02kM6wX8U9mHl4iz4NUR9D8bYMt5
         gUOv+0P3tL3esDMRw1yI5rzvEeTLheZ54zR9wqZo3wSS2H7kLzGdanhgM02Kg2NKuZ
         8GWEY8jD2EnC7KWT73GfX4qsXLIFsjC6cVrMnSwY0OWJXvx0+9Ns+Z4b3NfOJk+wz0
         2CydeGX/YjLpg==
To:     David Wronek <davidwronek@gmail.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: Fix dsi1 interrupts
Message-ID: <2OIrRjpbwowKk3QS4Z0OLCq6nDxVIOTZnIYpJNlau9TG_GejGAJVgCfboTjUIVokAOAGoobJwEBXoS7udi-cwaq4AeOdLj45uYdhlMCEcCA=@protonmail.com>
In-Reply-To: <20230805130936.359860-2-davidwronek@gmail.com>
References: <20230805130936.359860-2-davidwronek@gmail.com>
Feedback-ID: 6882736:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 5th, 2023 at 2:09 PM, David Wronek <davidwronek@gmail.c=
om> wrote:

> Fix IRQ flags mismatch which was keeping dsi1 from probing by changing
> interrupts =3D <4> to interrupts =3D <5>.
>=20
>=20
> Fixes: 2752bb7d9b58 ("arm64: dts: qcom: msm8996: add second DSI interface=
")
> Signed-off-by: David Wronek davidwronek@gmail.com
>=20
> ---
> arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/=
qcom/msm8996.dtsi
> index 6f7065e8fd6c..c8e0986425ab 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1126,7 +1126,7 @@ mdss_dsi1: dsi@996000 {
> reg-names =3D "dsi_ctrl";
>=20
> interrupt-parent =3D <&mdss>;
>=20
> - interrupts =3D <4>;
>=20
> + interrupts =3D <5>;
>=20
>=20
> clocks =3D <&mmcc MDSS_MDP_CLK>,
>=20
> <&mmcc MDSS_BYTE1_CLK>,
>=20
> --
> 2.41.0

Acked-by: Yassine Oudjana <y.oudjana@protonmail.com>

