Return-Path: <linux-kernel+bounces-165343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863F88B8B81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6D41F21F06
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AA912F384;
	Wed,  1 May 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sj0Zz4Z7"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1512DDB0;
	Wed,  1 May 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571816; cv=none; b=t/y4UwR295KIY8pSV5K6rLAX2IwhtJgFF8LV/vTsPVeLEb3ytjA6E1hvK9VATycMYSL8q8+OCMl6VfP1wGSALDkfGJReSvrAJ/n22fOln46Y91Xk3LuH2stRRpyZ/cVNc0SjX9cqmavG1b1RMKYl9LGOkSrpBHfKtdjMi2keP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571816; c=relaxed/simple;
	bh=pFNsRounutZ0watyT0vICiz4MZiX/bMl6TXERH4tJEA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UlrlGHft3SyNxUHfc185eLyNxbiPoM5xT+4TgVWD5ePxXJFc6nfmSI19mgEfAJpDhMTgZ6eS8faKslIGwB7b7mas9Mc0JbZyYL+scfIB3WWIM2DFfNuUPwb7w47Pva82ku1fzNizhxMeEwwgu6bcG7zmTgBCf0f5arABlC7WsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sj0Zz4Z7; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714571742; x=1715176542; i=markus.elfring@web.de;
	bh=tQlEmKt/yFE6pJw5QP1IkuqC5w2AGb1cHSuCQpauzPE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sj0Zz4Z7WwehrcScZnEP2j/CtHXElTLzUJbSFf43oTyrmvSs3qxxoNKvJTfjy9kf
	 eKyVPlU2C6mXjSjLzgg9NwZ+D/jolsDD4ic9/8raeX3Ssde3i5mfhHz6QDH6YIMbU
	 yvyND/btLfkkfD9txKHYPJi0F9z8izKAPGtmfbb6JbeeeK4KXiESJuPeWVqlr0Car
	 nQ+MtAjgB1frlBE4a8H3oiGCKSPLbna5cdtv1t4Dzn1Nqd5BBPvJK+xfwKg6wdoGC
	 hxFK3xu0EI79y5TASZvz7tMAr7M+x8LC7pIKJTNX+GcwAFxPeMBc2r6eEdlGuOzaV
	 aXcilABJudedHnwFEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1ruVT82i28-00A9tM; Wed, 01
 May 2024 15:55:42 +0200
Message-ID: <745cc56b-0ef4-4cf9-9051-cae318866672@web.de>
Date: Wed, 1 May 2024 15:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shenghao Ding <shenghao-ding@ti.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Baojun Xu <Baojun.Xu@fpt.com>, Baojun Xu <baojun.xu@ti.com>,
 Bard Liao <bard.liao@intel.com>, Bard Liao
 <yung-chuan.liao@linux.intel.com>,
 Cameron Berkenpas <cameron.berkenpas@gmail.com>, Gergo Koteles
 <soyer@irl.hu>, Jaroslav Kysela <perex@perex.cz>, Kevin Lu
 <kevin-lu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Liam Girdwood <liam.r.girdwood@intel.com>, mimperial@lenovo.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Shenghao Ding <13916275206@139.com>, Takashi Iwai <tiwai@suse.de>
References: <20240501122252.1215-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v2] ALSA: ASoc/tas2781: Fix wrong loading calibrated data
 sequence
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240501122252.1215-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qpHfSCuTjsAcWFdlirrfvRAu9pQCfSGHdw+3AD0m9n0syVrYE01
 R0K/9DdBU5eFNpmX04d7WSAGNRDTpKJ/6hxJ/zTBfzxWHfsz/Izx9X1gQrl0j+yDj3Ngmpn
 UFC8JXaQKSBfrnf7D/rkdHjGtUSQOA7G8l5zFMedtOvx6e9QxFMnTOP5Twu4GKKHd7Ralsr
 hPHDH+DVFFXa5U2bhLYPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G76/HUMR6xA=;H06TuOOrw5lW9fWGLZgvBGyaf8X
 O1nq13maYQPevtHwMcJueYQQnADEojURhq9Ki8CXofg8Kpfyy4zGwoeXqpmJezdrA3PvgwE++
 26hRi0FlMEt7ORTlluriHHZkiJRTv9ZC+sBkX5733AV30RwBktyo6GN6qvpisGrvuxFZRTPy6
 no1JScLRuH8tZd4T+DXG+UZaAPV41IvhVRnicrEkxaNx9/wt8vdBu8F0xQBSS1ghL7F1cPqaD
 kQeYBbXIVdIlLaeXe8nNNHeh9mP3FhY0mxGzisw+lw8zBqTSfztw/KwSYLNKcTqcZswlAxXRz
 4yDbFEtiZVG6GBUHi4a3OctfsYfVmYfnfvNh0Nk/pHcj9D9bOkrOg6mEA6/XB5DZemuYr+5pl
 E5W1c0nzTkaBwVlZPKWz3fxFlX9oaS3TJEd8PwI7BLuWOkLX6656IsFVoO1WvZPT56kugP0dv
 zrFf5QOhX7SL8hMLRP6OC/oyMAsyZ2wTGCoDndMgc7pYBd7nPJ4jILDBJMFtAkhRkXlNxm03p
 yt7ewUmPXSpC/rosJKrx+zyVvUfDBtv1RDKK2dQ///3a84vOICk7VFUNwDMNu9Z8aP8JKn9xI
 /0TjDpkz6c6bxNAhUexgqmfboi9CqiFZPhu4ewUT7q6X3iV1erUfSenTQ/MQY7pbMDa7HWObX
 LUoSfIO8Qi7sJvhjjfRnw+KEr/ui3HKlZS3HC+wPn61FSLSi91KJre8lCxAK7XUt47tKsiz7x
 oeIPRW0plNaRYG/9uvsjsyrbNlRbqwAjRlxGJAU2ATXPAL0+khcdGd4GVS3fDFLzwODcPgeN6
 Vc91a+7LcKArYW7CIqRAROJgzhm/yil/EUmulyTZFgR18=

=E2=80=A6
> +++ b/sound/soc/codecs/tas2781-fmwlib.c
=E2=80=A6
> @@ -2151,6 +2151,20 @@ static int tasdevice_load_data(struct tasdevice_p=
riv *tas_priv,
>  	return ret;
>  }
>
> +static void tasdev_load_calibrated_data(struct tasdevice_priv *priv,
> +	int i)

Please put the second function parameter into the previous line.


=E2=80=A6
> +	if (cal_fmw) {
> +		struct tasdevice_calibration *cal =3D cal_fmw->calibrations;
> +
> +		if (cal)
> +			load_calib_data(priv, &cal->dev_data);
> +		return;

Would this statement be redundant at the moment?


> +	}
> +}


Regards,
Markus

