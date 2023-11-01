Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8177DDD66
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjKAHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjKAHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:48:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F2FEA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:48:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50939d39d0fso1214323e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 00:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698824906; x=1699429706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FsMbYpTiMYqkAMRh2iMcSXUmtPxFHR20j5JyXg6b4M=;
        b=JCaybbtJwyYYAxDcHyl6twurY6JqtEAwIqzEKBn6MyXHpBxb5g69MwYV0E8S7HcULi
         J/uwuSx+G4apx5RtGG42ldhtguzeCFgMx8qZzKa0goxEI5QeE6++zbnN/aQc+IwsPXKC
         FS3ShB8UJpTmfi7c30DZfRQ6yobwUnrDBdzhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698824906; x=1699429706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FsMbYpTiMYqkAMRh2iMcSXUmtPxFHR20j5JyXg6b4M=;
        b=RtnsEAkwzch4fM2jrFl0C49HdFfoQsUpI1MlxmihR1pIMGTXGaSwE9AybSuKVqxCCw
         5E/1ZLPfWMJJnc9b1mlMqnrB9X+f6WbCnOHRWjHODZN6rS+Zt/kAZqjSwCO2+Prgakqb
         0dYxxpysi5sSZDAWyiM++l4ghZZ2U/rZT66KBig7MtacT+eMpyAszxBjGqOn+/AvkEBE
         WAZAPtkxg/PS82OTwgQPtc2bUYYE8o3TKEifYZc4p/EKQSPEbXg67pAfHhYO2mE9bov5
         hTglHDogYQZa3jD8SjccqZ+XiEW3CTAEiv4kDI+TAgnPbY1e7mpEczsSiPOXugbpH1zw
         hPPg==
X-Gm-Message-State: AOJu0YxfAUP5cT1Vap71pVsv7lH17PEQ5RCK1gGMGsh/hsFiR1EgvdoO
        lOOHZp5VtTIKXmZ8kWEc2VeNDZvfRLGsL8nQTWcTsA==
X-Google-Smtp-Source: AGHT+IHb720Mp++uF3jtmrbstofD30uRzGxLHYFtlscMBIS2t1anyqM04XA/N+dotAjZKWcN9wzkVE+nHn4VLLg4pJQ=
X-Received: by 2002:a19:915b:0:b0:505:8075:7c10 with SMTP id
 y27-20020a19915b000000b0050580757c10mr10829367lfj.25.1698824905985; Wed, 01
 Nov 2023 00:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231030105656.7288-1-yu-chang.lee@mediatek.com>
In-Reply-To: <20231030105656.7288-1-yu-chang.lee@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Nov 2023 15:48:14 +0800
Message-ID: <CAGXv+5EvB5_ZK02nz5USFj_cou3mr28oN+1YMKS6MxBAYE1dyw@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8188: Set clock parent for TOP_EDP and TOP_DP
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Garmin . Chang" <Garmin.Chang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 6:57=E2=80=AFPM yu-chang.lee <yu-chang.lee@mediatek=
.com> wrote:
>
> Modify MT8188 edp, dp clock and add .determine_rate() callback to
> dynamically set parent for TOP_EDP and TOP_DP. By separating tvdpll
> output into different interval, we can make sure VCO operate at optimal
> condition.

This patch does two things: a) separate eDP and DP clocks onto two separate
PLLs, and b) customize how the parent (divider) is selected. They should
be separate patches.

(a) can be done like how Angelo proposed for MT8195 [1]. If PLL separation
is all you need, please post a patch like it.

It's unclear to me how (b) is an improvement over existing code. The MediaT=
ek
clock driver library already specifies proper ranges for the PLLs, and the
mux code should go through all the clock parents and choose one that can
generate a clock rate closest to the requested one while using one of the
dividers and a PLL rate within spec. If that isn't working, it should be
fixed, not worked around.


Regards
ChenYu

[1] https://lore.kernel.org/linux-mediatek/20231018103546.48174-1-angelogio=
acchino.delregno@collabora.com/

>
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>
>
> ---
>  drivers/clk/mediatek/clk-mt8188-topckgen.c | 74 +++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/med=
iatek/clk-mt8188-topckgen.c
> index e330a4f9a0c3..921fb31fe4b1 100644
> --- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
> @@ -487,6 +487,74 @@ static const char * const dp_parents[] =3D {
>         "tvdpll2_d16"
>  };
>
> +#define VCO_OPP_LOW    7000000
> +#define VCO_OPP_MEDIUM 200000000
> +
> +enum dp_edp_parent_index {
> +       PLL_D4 =3D 2,
> +       PLL_D8,
> +       PLL_D16
> +};
> +
> +static int dp_clk_determine_rate(struct clk_hw *hw,
> +                                  struct clk_rate_request *req)
> +{
> +       const char *clk_hw_name =3D clk_hw_get_name(hw);
> +       unsigned int pow, parent_id, is_edp =3D 0;
> +       struct clk_rate_request parent_req =3D *req;
> +       struct clk_hw *parent_hw =3D clk_hw_get_parent(hw);
> +       unsigned long parent_rate =3D clk_hw_get_rate(parent_hw);
> +       int ret =3D 0;
> +
> +       if (!strncmp(clk_hw_name, "top_edp", 7))
> +               is_edp =3D 1;
> +
> +       if (req->rate < VCO_OPP_LOW)
> +               pow =3D PLL_D16;
> +       else if (req->rate < VCO_OPP_MEDIUM)
> +               pow =3D PLL_D8;
> +       else
> +               pow =3D PLL_D4;
> +
> +       if (is_edp)
> +               parent_id =3D (pow << 1) - 1;
> +       else
> +               parent_id =3D pow << 1;
> +
> +       /* re-parenting and determine rate */
> +       if (clk_hw_can_set_rate_parent(hw)) {
> +               parent_hw =3D clk_hw_get_parent_by_index(hw, parent_id);
> +               ret =3D __clk_determine_rate(parent_hw, &parent_req);
> +               if (ret)
> +                       return ret;
> +
> +               req->best_parent_hw =3D parent_hw;
> +               req->rate =3D req->best_parent_rate =3D parent_req.rate;
> +       } else {
> +               req->best_parent_hw =3D parent_hw;
> +               req->rate =3D req->best_parent_rate =3D parent_rate;
> +       }
> +
> +       return ret;
> +}
> +
> +static struct clk_ops dp_clk_ops;
> +
> +static void dp_clk_ops_init(void)
> +{
> +       dp_clk_ops =3D mtk_mux_gate_clr_set_upd_ops;
> +       dp_clk_ops.determine_rate =3D dp_clk_determine_rate;
> +}
> +
> +#define DP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs,   \
> +                _mux_clr_ofs, _shift, _width, _gate, _upd_ofs, \
> +                _upd)  \
> +       GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,  \
> +               _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> +               _gate, _upd_ofs, _upd, CLK_SET_RATE_PARENT,     \
> +               dp_clk_ops)
> +
> +
>  static const char * const edp_parents[] =3D {
>         "clk26m",
>         "tvdpll1_d2",
> @@ -1038,9 +1106,9 @@ static const struct mtk_mux top_mtk_muxes[] =3D {
>         MUX_GATE_CLR_SET_UPD(CLK_TOP_SSPM, "top_sspm",
>                              sspm_parents, 0x080, 0x084, 0x088, 24, 4, 31=
, 0x08, 3),
>         /* CLK_CFG_9 */
> -       MUX_GATE_CLR_SET_UPD(CLK_TOP_DP, "top_dp",
> +       DP_MUX(CLK_TOP_DP, "top_dp",
>                              dp_parents, 0x08C, 0x090, 0x094, 0, 4, 7, 0x=
08, 4),
> -       MUX_GATE_CLR_SET_UPD(CLK_TOP_EDP, "top_edp",
> +       DP_MUX(CLK_TOP_EDP, "top_edp",
>                              edp_parents, 0x08C, 0x090, 0x094, 8, 4, 15, =
0x08, 5),
>         MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI, "top_dpi",
>                              dpi_parents, 0x08C, 0x090, 0x094, 16, 4, 23,=
 0x08, 6),
> @@ -1267,6 +1335,8 @@ static int clk_mt8188_topck_probe(struct platform_d=
evice *pdev)
>                 goto free_top_data;
>         }
>
> +       dp_clk_ops_init();
> +
>         r =3D mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_=
fixed_clks),
>                                         top_clk_data);
>         if (r)
> --
> 2.18.0
>
>
