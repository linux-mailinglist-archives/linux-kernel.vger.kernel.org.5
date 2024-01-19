Return-Path: <linux-kernel+bounces-31387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17DB832D99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DA32819C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F420E55C11;
	Fri, 19 Jan 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Fk4/K4wz"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC83222;
	Fri, 19 Jan 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683584; cv=none; b=gf17X4mTGsIoaUSpjznDOLnCqoJ1p/nlIJ8P1J/U/IDzBfj9flk0RNcnebihwHGMfBdHmF8hfrm8+vuZoAr/ZEp/yL23S/AZtGNIpQ1RPa/V0TEHo6JvnmZG5xGrVD0oeo9X0MyDwrtg2S99zqP7J6l5I5XY6+Vev77NT4DhyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683584; c=relaxed/simple;
	bh=/RTX58XL94ocwmizyKYw7r77E3GtN+fp1k8zVgqC6ko=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFAOKBeMUcEPg5KdPkDwT+Q4FdV3a+Rm+qPOPsfidvOpO3BNBoSxB5ijEL0+ebFejyz++hERyuGKOPmVNjlQlJHGWW/vRGKSqC7AowhscOUthyZrePI/teOwoaqfyxETiMhz08epLdbUqKvOm83Yg72BUt7xuUFR8ZjB9x5ir8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Fk4/K4wz; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J6jRvp022386;
	Fri, 19 Jan 2024 10:59:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=qbiM0GYn8wffxO9
	+row5DznyRflJJj1eUICpy3tT4Yg=; b=Fk4/K4wzwAjRsqOkOd/Ra4ITbwvHBWI
	iK8aTjIrGh8FhyB0WC8fz/SeJv7UTo83o1i2cy/uDLejTFtTLem19Iu75lY0kaCc
	HV3iuwCzkue4QoFSqwe+YCNU7jJkGCpqNGKrT8rrTmj9N4OGR8pC+3hzyh9Hfh91
	KQyb2doSchlq5vLT83dtleKzknafMDF9Po7m5RyNxvo6ADlPVlrL10FUSEpZjer2
	yXBcu2zJk9BdTAweJuWVcbadeKOat1DyFLZ+n1i6YrFuo6/VgOfgZRYIAJJPh7Gv
	dwOBjY4cIpngPhC9kfqOx1th8+aIi1ZZBQOM1n9hpSHvGM/SDv18pmg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vkrt1gyjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:59:22 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 16:59:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Fri, 19 Jan 2024 16:59:17 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D522A475;
	Fri, 19 Jan 2024 16:59:17 +0000 (UTC)
Date: Fri, 19 Jan 2024 16:59:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 6/6] ASoC: cs42l43: Add support for the cs42l43
Message-ID: <20240119165917.GC16899@ediswmail.ad.cirrus.com>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-7-ckeepax@opensource.cirrus.com>
 <Zali4qxdegY7H6eY@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zali4qxdegY7H6eY@surfacebook.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: b67HD8x2PDCOH9BQnW9KX6IsD3Or_uUa
X-Proofpoint-ORIG-GUID: b67HD8x2PDCOH9BQnW9KX6IsD3Or_uUa
X-Proofpoint-Spam-Reason: safe

On Thu, Jan 18, 2024 at 07:41:54PM +0200, andy.shevchenko@gmail.com wrote:
> Fri, Aug 04, 2023 at 11:46:02AM +0100, Charles Keepax kirjoitti:
> > +static const unsigned int cs42l43_accdet_us[] = {
> > +	20, 100, 1000, 10000, 50000, 75000, 100000, 200000
> 
> + comma.
> 
> > +};
> > +
> > +static const unsigned int cs42l43_accdet_db_ms[] = {
> > +	0, 125, 250, 500, 750, 1000, 1250, 1500
> 
> Ditto.
> 

Can do.

> > +		device_property_read_u32_array(cs42l43->dev, "cirrus,buttons-ohms",
> > +					       priv->buttons, ret);
> 
> Strictly speaking this might fail, better to check the error code again.
> 

Yeah should probably add an error check there.

> > +	int timeout_ms = ((2 * priv->detect_us) / 1000) + 200;
> 
> USEC_PER_MSEC ?
> 

Can do.

> > +	BUILD_BUG_ON(ARRAY_SIZE(cs42l43_jack_override_modes) !=
> > +		     ARRAY_SIZE(cs42l43_jack_text) - 1);
> 
> Use static_assert() instead.
> 

I am happy either way, but for my own education what is the
reason to prefer static_assert here, is it just to be able to use
== rather than !=? Or is there in general a preference to use
static_assert, there is no obvious since BUILD_BUG_ON is being
deprecated?

> > +static void cs42l43_mask_to_slots(struct cs42l43_codec *priv, unsigned int mask, int *slots)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < CS42L43_ASP_MAX_CHANNELS; ++i) {
> > +		int slot = ffs(mask) - 1;
> > +
> > +		if (slot < 0)
> > +			return;
> > +
> > +		slots[i] = slot;
> > +
> > +		mask &= ~(1 << slot);
> > +	}
> 
> for_each_set_bit() ?
> 
> > +	if (mask)
> > +		dev_warn(priv->dev, "Too many channels in TDM mask\n");
> > +}
> 

Can do.

> > +static int cs42l43_decim_get(struct snd_kcontrol *kcontrol,
> > +			     struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> > +	struct cs42l43_codec *priv = snd_soc_component_get_drvdata(component);
> > +	int ret;
> > +
> > +	ret = cs42l43_shutter_get(priv, CS42L43_STATUS_MIC_SHUTTER_MUTE_SHIFT);
> > +	if (ret < 0)
> > +		return ret;
> > +	else if (!ret)
> 
> Reundant 'else'
> 
> > +		ucontrol->value.integer.value[0] = ret;
> > +	else
> > +		ret = cs42l43_dapm_get_volsw(kcontrol, ucontrol);
> 
> and why not positive check?
> 
> > +	return ret;
> 
> Or even simply as
> 
> 	if (ret > 0)
> 		ret = cs42l43_dapm_get_volsw(kcontrol, ucontrol);
> 	else if (ret == 0)
> 		ucontrol->value.integer.value[0] = ret;
> 
> 	return ret;

Yeah will update, that is definitely neater.

> > +	while (freq > cs42l43_pll_configs[ARRAY_SIZE(cs42l43_pll_configs) - 1].freq) {
> > +		div++;
> > +		freq /= 2;
> > +	}
> 
> fls() / fls_long()?

Apologies but I might need a little bit more of a pointer here.
We need to scale freq down to under 3.072MHz and I am struggling
a little to see how to do that with fls.

> > +	// Don't use devm as we need to get against the MFD device
> 
> This is weird...
> 
> > +	priv->mclk = clk_get_optional(cs42l43->dev, "mclk");
> > +	if (IS_ERR(priv->mclk)) {
> > +		dev_err_probe(priv->dev, PTR_ERR(priv->mclk), "Failed to get mclk\n");
> > +		goto err_pm;
> > +	}
> > +
> > +	ret = devm_snd_soc_register_component(priv->dev, &cs42l43_component_drv,
> > +					      cs42l43_dais, ARRAY_SIZE(cs42l43_dais));
> > +	if (ret) {
> > +		dev_err_probe(priv->dev, ret, "Failed to register component\n");
> > +		goto err_clk;
> > +	}
> > +
> > +	pm_runtime_mark_last_busy(priv->dev);
> > +	pm_runtime_put_autosuspend(priv->dev);
> > +
> > +	return 0;
> > +
> > +err_clk:
> > +	clk_put(priv->mclk);
> > +err_pm:
> > +	pm_runtime_put_sync(priv->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int cs42l43_codec_remove(struct platform_device *pdev)
> > +{
> > +	struct cs42l43_codec *priv = platform_get_drvdata(pdev);
> > +
> > +	clk_put(priv->mclk);
> 
> You have clocks put before anything else, and your remove order is broken now.
> 
> To fix this (in case you may not used devm_clk_get() call), you should drop
> devm calls all way after the clk_get(). Do we have
> snd_soc_register_component()? If yes, use it to fix.
> 
> I believe you never tested rmmod/modprobe in a loop.
> 

Hmm... will need to think this through a little bit, so might take
a little longer on this one. But I guess this only becomes a problem
if you attempt to remove the driver whilst you are currently playing
audio, and I would expect the card tear down would stop the clock
running before we get here.

> > +static const struct dev_pm_ops cs42l43_codec_pm_ops = {
> > +	SET_RUNTIME_PM_OPS(NULL, cs42l43_codec_runtime_resume, NULL)
> > +};
> 
> Why not new PM macros?
> 

Already been updated in another patch.

> > +		.pm	= &cs42l43_codec_pm_ops,
> 
> pm_sleep_ptr()?
> 

Can do.

> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/soundwire/sdw.h>
> > +#include <linux/types.h>
> > +#include <sound/cs42l43.h>
> > +#include <sound/pcm.h>
> > +#include <sound/soc-jack.h>
> 
> This block is messed up. Some headers can be replaced by forward declarations,
> some are missing... Please, follow IWYU principle.
> 
> > +#ifndef CS42L43_ASOC_INT_H
> > +#define CS42L43_ASOC_INT_H
> 
> Why not guarding other inclusions? It makes build slower!
> 

Will shuffle these headers around as well.

Thanks,
Charles

