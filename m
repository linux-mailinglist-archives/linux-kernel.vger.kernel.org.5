Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769517F65AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbjKWRnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKWRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:43:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E410C2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:43:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8729C433C8;
        Thu, 23 Nov 2023 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700761427;
        bh=1GRk6pF6ONArbuEDYzf53o3CAsRNhMgYXX01fUitKEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUK/QVte4vbuMVsB7J0ZDQXQPfx5ZzqhBZOhhYXYl+f0qLTL1oOdCbPQ8soI+D9Ee
         lLr90oOKzn2mI92pdKjbW39eFkQ0GSOJjcyT6adnMdiDnhRB3xMjBD5TgAH4bV6NWh
         zUYM5BmACPrvUX0Thlj/wUOp31f3cOuJrbJejyUoKR2etkkH1ile+WN036EMVW2DqT
         u6oOAbS5e4UkOdxtE5rqKgQ0AqfTWN7qYbgnZsGCaXYUVB0crrskCXVWkx/q9UsmMf
         cZPM91apJKntl3C6x/aRusganoJT+ab/o4O+hbp3yxgKP8ous4VJPWd+HHW8z9aZlX
         c6tMeQ7jEcPyQ==
Date:   Thu, 23 Nov 2023 17:43:43 +0000
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
Subject: Re: [PATCH 4/5] ASoC: codecs: Add WCD939x Soundwire slave driver
Message-ID: <ZV+PTynfbRmF0trU@finisterre.sirena.org.uk>
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-4-21d4ad9276de@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="42Lt/E9P87lWIhco"
Content-Disposition: inline
In-Reply-To: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-4-21d4ad9276de@linaro.org>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--42Lt/E9P87lWIhco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 03:49:14PM +0100, Neil Armstrong wrote:
> Add Soundwire Slave driver for the WCD9390/WCD9395 Audio Codec.

> The WCD9390/WCD9395 Soundwire Slaves will be used by the

Please avoid using outdated terminology, "device" is probably a good
alternative here.  There are some usages in APIs that need to be updated
but still, good to avoid where possible.

> +static struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
> +	WCD_SDW_CH(WCD939X_ADC1, WCD939X_ADC_1_4_PORT, BIT(0)),
> +	WCD_SDW_CH(WCD939X_ADC2, WCD939X_ADC_1_4_PORT, BIT(1)),
> +	WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_1_4_PORT, BIT(2)),
> +	WCD_SDW_CH(WCD939X_ADC4, WCD939X_ADC_1_4_PORT, BIT(3)),
> +	// TOFIX support ADC3/4 & DMIC0/1 on port 2
> +	//WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_DMIC_1_2_PORT, BIT(0)),
> +	//WCD_SDW_CH(WCD939X_ADC4, WCD939X_ADC_DMIC_1_2_PORT, BIT(1)),
> +	//WCD_SDW_CH(WCD939X_DMIC0, WCD939X_ADC_DMIC_1_2_PORT, BIT(2)),
> +	//WCD_SDW_CH(WCD939X_DMIC1, WCD939X_ADC_DMIC_1_2_PORT, BIT(3)),

Why are these commented out?

> +static int wcd9390_interrupt_callback(struct sdw_slave *slave,
> +				      struct sdw_slave_intr_status *status)
> +{
> +	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
> +	struct irq_domain *slave_irq = wcd->slave_irq;
> +	u32 sts1, sts2, sts3;
> +
> +	do {
> +		handle_nested_irq(irq_find_mapping(slave_irq, 0));
> +		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_0, &sts1);
> +		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_1, &sts2);
> +		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_2, &sts3);
> +
> +	} while (sts1 || sts2 || sts3);
> +
> +	return IRQ_HANDLED;
> +}

We do this in the other Qualcomm drivers but it doesn't seem ideal to
just ignore the interrupts.

> +static int wcd939x_sdw_component_bind(struct device *dev, struct device *master,
> +				      void *data)
> +{
> +	return 0;
> +}
> +
> +static void wcd939x_sdw_component_unbind(struct device *dev,
> +					 struct device *master, void *data)
> +{
> +}
> +
> +static const struct component_ops wcd939x_sdw_component_ops = {
> +	.bind = wcd939x_sdw_component_bind,
> +	.unbind = wcd939x_sdw_component_unbind,
> +};

Do these need to be provided if they can legitimately be empty?

--42Lt/E9P87lWIhco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVfj08ACgkQJNaLcl1U
h9AbPQf9HwduNNNq58Fi9Zk4pDIkhiO6nVd+QB5hkOPoAqoUexbSojnNREgdQUy/
S5Ek1XNG04jXfE7MYvLpIEO6bhwa6uv/Zn7UM3i0EDIzd2qXT4vH6Ce4/pl2+IsK
3bcbiKFHCpSQRCbzay9Fm4DUdMXbEIpBeZmMznljBtZmF7UIj1xVLJQEsEiwWJ7G
8NTb1aJ9QauPhZgkcuizCmNrZkQseSioyDmFZPZlD6TmofHqz2A8MiI5oLQVQr7s
zvFENMqhOHPxwb9b/orlGQqf0tKdoZZDO66P0b3g242Z2KItP/Aasq4FiQTJ24LP
/69tGglcrDDBrHEBUmmx6ULgLVUoCw==
=YBBq
-----END PGP SIGNATURE-----

--42Lt/E9P87lWIhco--
