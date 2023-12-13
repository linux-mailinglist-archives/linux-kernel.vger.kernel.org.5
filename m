Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2640811EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442092AbjLMTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379292AbjLMTUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:20:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32116AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:20:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192ACC433C8;
        Wed, 13 Dec 2023 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702495216;
        bh=pvOifwzmhzVpqy1B65sXqWWUfUoqN1GPpaLpMOsu7M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NL1y6ZXgRJFSI8gechwwAiu4XkPxMrQCZ3LQNQoh+duY2ym7IXeYgeVkjmO2P1Zbp
         hDB4oqmrb5FVjrgp7O203jYtSPqIGDoV9OS1/Jbw9Pm5ip8FfSqnjsP3MIsKZDrBGu
         YEgcG/fnfM+jv2gl1iv6i4nPkj0CyWYn80MYGVmGbS+geBXWsswLAJ0tNb6cKFCrVV
         flEZrv8+fHhFUjfVj5zJUxJ5DFdyyf8jl1rMuqrzWJFEZsL0DWeFuJy6wM7WghLieX
         wYSBun4sk1TjGGVYkzyvgslg0iWFnwrQQgInI+Cc4cE4XgUtkpXL/nkWz2ovZm43vk
         Iso4DkVscs6Kg==
Date:   Wed, 13 Dec 2023 19:20:09 +0000
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
Subject: Re: [PATCH v3 5/5] ASoC: codecs: Add WCD939x Codec driver
Message-ID: <4dae5296-9984-4c3b-803a-f6024edd0dd9@sirena.org.uk>
References: <20231207-topic-sm8650-upstream-wcd939x-codec-v3-0-6df9585ec7c8@linaro.org>
 <20231207-topic-sm8650-upstream-wcd939x-codec-v3-5-6df9585ec7c8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QxFQz7KiJT5hHtQy"
Content-Disposition: inline
In-Reply-To: <20231207-topic-sm8650-upstream-wcd939x-codec-v3-5-6df9585ec7c8@linaro.org>
X-Cookie: One size fits all.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QxFQz7KiJT5hHtQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 11:28:08AM +0100, Neil Armstrong wrote:

> +static int wcd939x_rx_hph_mode_put(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
> +	u32 mode_val;
> +
> +	mode_val = ucontrol->value.enumerated.item[0];
> +
> +	if (wcd939x->variant == WCD9390) {
> +		if (mode_val == CLS_H_HIFI || mode_val == CLS_AB_HIFI) {
> +			dev_dbg(component->dev, "%s: Invalid HPH Mode\n", __func__);
> +			return -EINVAL;
> +		}
> +	}
> +	if (mode_val == CLS_H_NORMAL) {
> +		dev_dbg(component->dev, "%s: Unsupported HPH Mode\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	wcd939x->hph_mode = mode_val;

This seems strange - the code will accept any value other than a small
number of specifically enumerated ones?  I would have expected us to
check a defined list of modes and reject anything that isn't in that
list.  This also means that the get() function can return out of bounds
values which is buggy.  Please use the mixer-test selftest on a card
with this driver running, it should identify at least that issue.

> +
> +	return 1;
> +}

This will also unconditionally report that the value of the mux changed,
the function should return 0 if the value written is the control value
hasn't changed.

--QxFQz7KiJT5hHtQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV6A+kACgkQJNaLcl1U
h9BJKQf/U5px02gwHeH7uG4m5GauMpoUmEDiaVVF7tWk02l3M27zveuoN30yDTA1
pfCa5jV8hUInQwgNXtIOyUZCfHkQN1+OHlvIdkse8NRlLja7PoAXNgu/iw6U0j66
zSqNGkvYePeMg+AJV/ZGJKfNKFomFc33V3EUC1iVKSWgsDBFjfQqau4TA9/smuaU
CT6RN5au6S7c5hg1Xyl2AK7RPadJM9rmmxJggOqNUYhYjmFMT7VWYhTta5yQXKak
Q/2L1+p91ZUr/HYHhVXzY8x/ptX3G7+w2nbIlXkOPuvdw41wGLdAPgpFw9oRmswK
OERs69V+GdvlY6g8PFruUFeS80qYgQ==
=FDxZ
-----END PGP SIGNATURE-----

--QxFQz7KiJT5hHtQy--
