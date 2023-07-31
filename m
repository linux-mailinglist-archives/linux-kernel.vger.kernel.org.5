Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E103A76A0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjGaTOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjGaTOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB3D1BD2;
        Mon, 31 Jul 2023 12:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D443B6129E;
        Mon, 31 Jul 2023 19:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE9C433C7;
        Mon, 31 Jul 2023 19:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690830885;
        bh=SyJU7Qt2aBIN4OyFcC5oEmHd0DxKwQmqDlVAGFvHAGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfZY9GbnMx+aOUhNak8hhNx+W4RQngWJkELmDVGW8q222cnSMnvbobDN1oms+zhPq
         cbVaocl89DiKxBWlHYimi8lIVjOKKdGuWYEqGxdADX6HTYgNkF/bhaNpRm+5thXsSY
         95pSQw5/dAnIbHeWNjq0VSi+To/RKfwFY9qNzU6d/4/eUCt6xAJXOAcUW5q+AntKar
         0ORk/O7jvBbHgP4x2jVPEcuU93ljKLAk2vQDp2COzlYpPQo/dsMr+jYANsNy2HLrST
         UBrBWz75Wxw3pzn3gUxpb0wnlkuByXvUEP/1l3Fv5WdcsVQuTaTpKYdvVRdwI4VJOk
         N5mKreLQOiTOQ==
Date:   Mon, 31 Jul 2023 20:14:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ASoC: starfive: Add JH7110 PWM-DAC driver
Message-ID: <9b03c7ed-845c-494b-8c40-10d1fe923b15@sirena.org.uk>
References: <20230731032829.127864-1-hal.feng@starfivetech.com>
 <20230731032829.127864-3-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7WRSfejFGo+r56WO"
Content-Disposition: inline
In-Reply-To: <20230731032829.127864-3-hal.feng@starfivetech.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7WRSfejFGo+r56WO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2023 at 11:28:28AM +0800, Hal Feng wrote:

> +static const struct jh7110_ct_pwmdac pwmdac_ct_data_shift[] = {
> +	{ .name = "left 0 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_0 },
> +	{ .name = "left 1 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_1 },
> +	{ .name = "left 2 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_2 },
> +	{ .name = "left 3 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_3 },
> +	{ .name = "left 4 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_4 },
> +	{ .name = "left 5 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_5 },
> +	{ .name = "left 6 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_6 },
> +	{ .name = "left 7 bit", .vals = PWMDAC_DATA_LEFT_SHIFT_BIT_7 }
> +};

It's not clear to me why this is user selectable - what does the control
do?

> +static int jh7110_pwmdac_put(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol,
> +			     int pwmdac_ct)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct jh7110_pwmdac_dev *dev = snd_soc_component_get_drvdata(component);
> +	int sel = ucontrol->value.enumerated.item[0];
> +	unsigned int items;

> +	if (pwmdac_ct == PWMDAC_CT_SHIFT)
> +		dev->shift = pwmdac_ct_shift[sel].vals;
> +	else if (pwmdac_ct == PWMDAC_CT_DUTY_CYCLE)
> +		dev->duty_cycle = pwmdac_ct_duty_cycle[sel].vals;
> +	else if (pwmdac_ct == PWMDAC_CT_DATA_CHANGE)
> +		dev->data_change = pwmdac_ct_data_change[sel].vals;
> +	else if (pwmdac_ct == PWMDAC_CT_DATA_MODE)
> +		dev->data_mode = pwmdac_ct_data_mode[sel].vals;
> +	else if (pwmdac_ct == PWMDAC_CT_DATA_SHIFT)
> +		dev->data_shift = pwmdac_ct_data_shift[sel].vals;
> +
> +	return 0;
> +}

_put() operations should return 1 if the control value changes so event
generation works - please test a card using this driver with the
mixer-test selftest, it'll identify this and a bunch of other potential
issues.

> +static int jh7110_pwmdac_component_probe(struct snd_soc_component *component)
> +{
> +	snd_soc_add_component_controls(component, jh7110_pwmdac_snd_controls,
> +				       ARRAY_SIZE(jh7110_pwmdac_snd_controls));
> +	return 0;
> +}

The driver can just point to the controls from the _driver struct and
skip having a probe() function.


--7WRSfejFGo+r56WO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTICB4ACgkQJNaLcl1U
h9Bkogf7B5sn9Y3g1mTAAspid/NHj9EJnpyylKVFcCH8D0UOo11qJLylO7cb8DQw
3M6ifjvdgMPSgZiwoshQnv3dS0yPr422sWUV65Dnm9pI0lwju9mFo4mh6i0zexdi
AvQWj6reLoNjF1zn3ZSLU0qkqSTxaOebz1O9RkldqqmbcVixM4sLJOoDzhb5K76O
lfD2y7zU3/GBt/+OwRObmMLz/AlrPbPkT2YF+0txEYEIitxWHgMoqJFWJI9cdg9I
8WBjG+5nh/yKozj2EYOEGhKNjBegDGOOp/7sqWdUMdrkRNdtczS3sp5/jRHLv6ph
1AMqKDncC9OfgKfFLfJy2saNmIxWlg==
=JSoy
-----END PGP SIGNATURE-----

--7WRSfejFGo+r56WO--
