Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B17DC020
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjJ3S5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJ3S5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:57:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18656C9;
        Mon, 30 Oct 2023 11:57:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2910C433C7;
        Mon, 30 Oct 2023 18:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698692228;
        bh=9k52DOYv+u+3IPK7EG4bgquyoKZQQUrVAKtdXlb4WnM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bKfWupyHNM0c0QoHxSHWTIHGryzlBNN1nLRn4EySckDpioPM22Po1PkQfPwZqhv/H
         K44hqIEEhFYSBsNw10RaA5fE0Kay4Xt9p1Bhtp552C6CPk62Th9dzQZqhAqADO6f9G
         4AhnCEi2u4EEbUCLsqegrxWK4DV0FHra/UG03VA6h9IsmOqBEpLRibT6Sj4a29qqlH
         jneXNE/sVmxjkH62aIoP5v8lV31VAmGkItEwkFk2X0rr1t28ff2wWc+SKeTI8BtNEk
         vOXUVrn1LWZMYCpfseNwGmfINSptJKqPcWXzfmyyw0m1NRPz1OkyXaq5dINeavn/eg
         ZcmQUAJlVVWDg==
Message-ID: <ac223f97efea0d5077a4e3e4dbd805b4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231030-ipq5332-nsscc-v1-4-6162a2c65f0a@quicinc.com>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com> <20231030-ipq5332-nsscc-v1-4-6162a2c65f0a@quicinc.com>
Subject: Re: [PATCH 4/8] clk: qcom: ipq5332: add gpll0_out_aux clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Date:   Mon, 30 Oct 2023 11:57:06 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan Thirumoorthy (2023-10-30 02:47:19)
> Add support for gpll0_out_aux clock which acts as the parent for
> certain networking subsystem (NSS) clocks.
>=20
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5332.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq533=
2.c
> index 235849876a9a..966bb7ca8854 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -87,6 +87,19 @@ static struct clk_alpha_pll_postdiv gpll0 =3D {
>         },
>  };
> =20
> +static struct clk_alpha_pll_postdiv gpll0_out_aux =3D {
> +       .offset =3D 0x20000,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
> +       .width =3D 4,
> +       .clkr.hw.init =3D &(struct clk_init_data) {

const initdata

> +               .name =3D "gpll0_out_aux",
> +               .parent_hws =3D (const struct clk_hw *[]) {
> +                               &gpll0_main.clkr.hw },
> +               .num_parents =3D 1,
> +               .ops =3D &clk_alpha_pll_postdiv_ro_ops,
> +       },
> +};
> +
>  static struct clk_alpha_pll gpll2_main =3D {
>         .offset =3D 0x21000,
>         .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
