Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FEF7F7149
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbjKXKTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345526AbjKXKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:19:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1368CA2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:19:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD8AC433C8;
        Fri, 24 Nov 2023 10:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700821150;
        bh=OEZjeJvaa0W7vSTE88cnpZau4Nam/6qChCui4cXBaN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIQvHAcWdH+aWdppBQyEJjgBwjnj5PnnQhO+8xHsqSeB6JHVnW6G1hVn2zzCxm480
         H5bD3Fi5C1IuNoVzMIG9SgfodwjThbhDJjL0fgsXBSA5YCYGM1T0QVnzvKjJSkfVcC
         PvGPze6kTiRqJHjygRYv9msfNlebGeRIyr9LPvNKLPrmKxODAccrpw463vn+mwFbUC
         umgQVa122MGu4N+Yb3ab54opcbQZ+YXPTMLDqnfbqRgk4ic+347sp+IYJ5s9us5mZB
         6eYz6vPGdNc2JP4GhfqOrjurYebJVCs8OIu2U0SIUxn1IXKANYUGg1cXvQsN6R319N
         vXJKMdOHPjiDw==
Date:   Fri, 24 Nov 2023 10:19:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: codecs: Add WCD939x Codec driver
Message-ID: <ZWB4myckLrpBYLm+@finisterre.sirena.org.uk>
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-5-21d4ad9276de@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VQ2nRTjyMlGPMvXH"
Content-Disposition: inline
In-Reply-To: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-5-21d4ad9276de@linaro.org>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VQ2nRTjyMlGPMvXH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 03:49:15PM +0100, Neil Armstrong wrote:

> +	if (wcd939x->variant == WCD9390) {
> +		if (mode_val == CLS_H_HIFI || mode_val == CLS_AB_HIFI) {
> +			dev_info(component->dev, "%s: Invalid HPH Mode, default to CLS_H_ULP\n",
> +				 __func__);
> +			mode_val = CLS_H_ULP;
> +		}
> +	}
> +	if (mode_val == CLS_H_NORMAL) {
> +		dev_info(component->dev, "%s: Invalid HPH Mode, default to class_AB\n",
> +			 __func__);
> +		mode_val = CLS_H_ULP;
> +	}

This lets people spam the logs from userspace, why not just return an
error?

> +	if (hphr)
> +		wcd939x->comp2_enable = value;
> +	else
> +		wcd939x->comp1_enable = value;

Are there really no constraints on the values for these things?

> +static const struct snd_kcontrol_new wcd9390_snd_controls[] = {
> +	SOC_ENUM_EXT("EAR PA GAIN", wcd939x_ear_pa_gain_enum,
> +		     wcd939x_ear_pa_gain_get, wcd939x_ear_pa_gain_put),

Gains should be be named Volume.  Is there no TLV information?

> +static irqreturn_t wcd939x_wd_handle_irq(int irq, void *data)
> +{
> +	return IRQ_HANDLED;
> +}

Why even request the interrupt if it's just going to be ignored?

--VQ2nRTjyMlGPMvXH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVgeJoACgkQJNaLcl1U
h9AZqgf9ER6M6fjDX85XA+DwqPsutTqM7mFbCjQypc4RvoCAFr404QMv94Pqj49B
yVWWJEJ450NwalztnrIUsq8eTs9Fs/KpIhqEh202WlqHHd2EKGoAyHh6IEqF/yni
F1YbWwejYTdL+16hOhMCtr0AtdhxEOe74omNJNcePl/yWCLx14CAA/snSAgVObjQ
NO1Uhh1AgnAEO+S1jOvuGb3BzIor2UpcFNqhvKa6jkgRpEk/ZEUQjzJ/1bGdOF5r
ny1HRvZgIcwIKyioGRREjdPmIGHFg+gLe3+LESxVy32YhpKkWaqYa4UT2wcVgtTp
ej3yYYHUfeYQ6XtbWTd/o/wtzwlIWQ==
=IuYR
-----END PGP SIGNATURE-----

--VQ2nRTjyMlGPMvXH--
