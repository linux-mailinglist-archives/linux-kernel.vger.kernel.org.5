Return-Path: <linux-kernel+bounces-155100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D48AE548
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6442C1C21267
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D0713B2B3;
	Tue, 23 Apr 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCLzCIiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B013B290
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872932; cv=none; b=ZBU68JJVEF/2FLdIvtldzZI+0/UINosMWr3cRbRCKC6wNzGpoMquBRhCSoCEKzNspskl/g/4POiJjtGSYNQPUvktn/IIFI28+OHhYGUHZjQUU992H0Jkcgiuqcj1bgzchN7I7LvS9lrto43i73Ti3c4cIa1GGABNWvX06iz6uVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872932; c=relaxed/simple;
	bh=PKSrVVx4eiys/Zj2uIwEfs1FS0teIqUADyfmFNGktlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRku6RnGfub3jCu0J6NmtfAsz/34zOyfZVVLGp9jmnQLzTYFNidIX/HEeb5dp8U6qOknr2ZyhnZA8Sx00yAuVuBxoFnhH2DfWt8eSpBjHReTGK2PbgtzDH0nZm0J/HPCWQiqdvT1dc8P/M09sZd94lCZ8w7pdTSU+w49yiRbnts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCLzCIiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DAEC116B1;
	Tue, 23 Apr 2024 11:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872932;
	bh=PKSrVVx4eiys/Zj2uIwEfs1FS0teIqUADyfmFNGktlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCLzCIiHLeYTsq5I4SX0KH+cSVY797FLaVBH3OUNnmijfVjmeoWbnHB4pWszeUZdM
	 Mi3YFDW+NVSKaxr+FYx8DGyH2G7/wzf8Dp8KqNz0Heo9C1Ub5B5T95js5KtW0gLSNQ
	 CbO1jyCj77sJqL/H/TAPxc+LtNRMVvg06AfyYYyKLgIxpU8X3BsCnrCV2NeX3FLuf2
	 7xTSnOGHyIrFtJxbdnkkBdGT03rJwLneCkuplsU7LO/cyKsLmSZPZZhd/fQx94CHCR
	 /NteoVmT14gWJ1oaDe7/Y9KgZ2d0Set29DMG/SVzCpRfIYF2zmh+Vu6bAXhuqE+Qiy
	 2ThPNWJGnJ5aQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzEdm-000000005DH-2gfe;
	Tue, 23 Apr 2024 13:48:50 +0200
Date: Tue, 23 Apr 2024 13:48:50 +0200
From: Johan Hovold <johan@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: qcom: sc8280xp: add Display port Jack
Message-ID: <ZiegIgranmsYg-KL@hovoldconsulting.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-4-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422134354.89291-4-srinivas.kandagatla@linaro.org>

On Mon, Apr 22, 2024 at 02:43:53PM +0100, Srinivas Kandagatla wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add support to Display Port Jack events, by making use of common helper

s/to/for/

drop comma

> function.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/sc8280xp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 878bd50ad4a7..38f97f19add9 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -19,6 +19,7 @@ struct sc8280xp_snd_data {
>  	struct snd_soc_card *card;
>  	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
>  	struct snd_soc_jack jack;
> +	struct snd_soc_jack hdmi_jack[8];

dp_jack

>  	bool jack_setup;
>  };
>  
> @@ -27,6 +28,8 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>  	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
>  	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>  	struct snd_soc_card *card = rtd->card;
> +	struct snd_soc_jack *hdmi_jack  = NULL;

dp_jack

stray whitespace before =

> +	int hdmi_pcm_id = 0;

dp_pcm_id

no need to init

>  	switch (cpu_dai->id) {
>  	case WSA_CODEC_DMA_RX_0:
> @@ -41,10 +44,21 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
>  		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 17);
>  		snd_soc_limit_volume(card, "SpkrRight PA Volume", 17);
>  		break;
> +	case DISPLAY_PORT_RX_0:
> +		hdmi_pcm_id = 0;
> +		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
> +		break;
> +	case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
> +		hdmi_pcm_id = cpu_dai->id - DISPLAY_PORT_RX_1 + 1;
> +		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
> +		break;
>  	default:
>  		break;
>  	}
>  
> +	if (hdmi_jack)
> +		return qcom_snd_dp_jack_setup(rtd, hdmi_jack, hdmi_pcm_id);
> +
>  	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
>  }

Johan

