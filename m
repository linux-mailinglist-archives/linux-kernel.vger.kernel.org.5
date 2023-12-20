Return-Path: <linux-kernel+bounces-6850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092DB819E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97D128816D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C522231A;
	Wed, 20 Dec 2023 11:53:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D921A1B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rFv8Y-0007Qd-VM; Wed, 20 Dec 2023 12:53:18 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rFv8X-000EXr-BH; Wed, 20 Dec 2023 12:53:18 +0100
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rFv8Y-007vTA-BI; Wed, 20 Dec 2023 12:53:18 +0100
Date: Wed, 20 Dec 2023 12:53:18 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	shengjiu.wang@gmail.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: pll14xx: change naming of fvco to fout
Message-ID: <20231220115318.o3ql3fjtjktsf73t@pengutronix.de>
References: <1703068389-6130-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1703068389-6130-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

thanks for the patch.

On 23-12-20, Shengjiu Wang wrote:
> pll14xx_calc_rate() output the fout clock not the fvco clock
> The relation of fvco and fout is:
> 	fout = fvco / (1 << sdiv)
> 
> So use correct naming for the clock.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

lgtm

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  drivers/clk/imx/clk-pll14xx.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 0d58d85c375e..d63564dbb12c 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -104,15 +104,15 @@ static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
>  static long pll14xx_calc_rate(struct clk_pll14xx *pll, int mdiv, int pdiv,
>  			      int sdiv, int kdiv, unsigned long prate)
>  {
> -	u64 fvco = prate;
> +	u64 fout = prate;
>  
> -	/* fvco = (m * 65536 + k) * Fin / (p * 65536) */
> -	fvco *= (mdiv * 65536 + kdiv);
> +	/* fout = (m * 65536 + k) * Fin / (p * 65536) / (1 << sdiv) */
> +	fout *= (mdiv * 65536 + kdiv);
>  	pdiv *= 65536;
>  
> -	do_div(fvco, pdiv << sdiv);
> +	do_div(fout, pdiv << sdiv);
>  
> -	return fvco;
> +	return fout;
>  }
>  
>  static long pll1443x_calc_kdiv(int mdiv, int pdiv, int sdiv,
> @@ -131,7 +131,7 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
>  {
>  	u32 pll_div_ctl0, pll_div_ctl1;
>  	int mdiv, pdiv, sdiv, kdiv;
> -	long fvco, rate_min, rate_max, dist, best = LONG_MAX;
> +	long fout, rate_min, rate_max, dist, best = LONG_MAX;
>  	const struct imx_pll14xx_rate_table *tt;
>  
>  	/*
> @@ -143,6 +143,7 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
>  	 * d) -32768 <= k <= 32767
>  	 *
>  	 * fvco = (m * 65536 + k) * prate / (p * 65536)
> +	 * fout = (m * 65536 + k) * prate / (p * 65536) / (1 << sdiv)
>  	 */
>  
>  	/* First try if we can get the desired rate from one of the static entries */
> @@ -173,8 +174,8 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
>  		pr_debug("%s: in=%ld, want=%ld Only adjust kdiv %ld -> %d\n",
>  			 clk_hw_get_name(&pll->hw), prate, rate,
>  			 FIELD_GET(KDIV_MASK, pll_div_ctl1), kdiv);
> -		fvco = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
> -		t->rate = (unsigned int)fvco;
> +		fout = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
> +		t->rate = (unsigned int)fout;
>  		t->mdiv = mdiv;
>  		t->pdiv = pdiv;
>  		t->sdiv = sdiv;
> @@ -190,13 +191,13 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
>  			mdiv = clamp(mdiv, 64, 1023);
>  
>  			kdiv = pll1443x_calc_kdiv(mdiv, pdiv, sdiv, rate, prate);
> -			fvco = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
> +			fout = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
>  
>  			/* best match */
> -			dist = abs((long)rate - (long)fvco);
> +			dist = abs((long)rate - (long)fout);
>  			if (dist < best) {
>  				best = dist;
> -				t->rate = (unsigned int)fvco;
> +				t->rate = (unsigned int)fout;
>  				t->mdiv = mdiv;
>  				t->pdiv = pdiv;
>  				t->sdiv = sdiv;
> -- 
> 2.34.1
> 
> 
> 

