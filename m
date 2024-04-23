Return-Path: <linux-kernel+bounces-155089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083BE8AE52E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC6E1F240DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7C134743;
	Tue, 23 Apr 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpNvhbis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06B13443C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872664; cv=none; b=RS1DS5S1CuktWtetxbN4Y5NRqgpf8X+0TEtUe2OezNDggPguK5f2VLOEJB2obkdEMCFr1E0+CEfj9uabaZN+929lZ2qxvo7u0Bpuinu9NyMNovSe1qDcqLBWmxDV4cBWwzFblJs8zMIjoC64DaSe/PV9lbzG9lrXHJkptrwQ0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872664; c=relaxed/simple;
	bh=qpvfUNzdiSw3PwDeKZ/yg/FJx0XxI/U3wt8Hpfs5xQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNJJPHecsItb42uXgdpxuAR+8oEAlSim94dfVtqSd5iwL//saonUJepcE+UJVBYpNq2iD8UUht6qXF26FA8BWxWN1XPkaaxVALojTkRVl7elDuBNH5/CvVW+By4bLNEB4SblkRIvvAAjjwIA1QZqDh5U3yC5R1KIAAvqegk6c6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpNvhbis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6064DC116B1;
	Tue, 23 Apr 2024 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872664;
	bh=qpvfUNzdiSw3PwDeKZ/yg/FJx0XxI/U3wt8Hpfs5xQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpNvhbisLI4AoWrmVir/ATpl7NxglXF6cVVihy0Fwq2p6ViLz1O72IOi0y8A5UKzC
	 0ZsIUWwx/hw+GEad/HA5JMn8rkJ2Iky0yY66yNjrNaNMvip09Yl+JerBVv7NUbCK2F
	 Z7UgJT+sZJKuX0qcEFxkcNO8kNONb9OXPlFAjV10kBLBUtW5yNcaJDDFDRIjBOZ8Vl
	 rI8OHCJy0svv4Nx0swjE1iKlqkJNkl6X5+9W6PX2+Q6zNW5kjCtXCZUTnvz6rLmLYG
	 VKgSnPLI92xy7fRt2bUP/EzEQhYYgt5H5siEfbWY+MFE7E2tIAKGMeDKaOwCqETxUu
	 BIdKDbas+unWw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzEZS-0000000058y-12fi;
	Tue, 23 Apr 2024 13:44:22 +0200
Date: Tue, 23 Apr 2024 13:44:22 +0200
From: Johan Hovold <johan@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: qcom: common: add Display port Jack function
Message-ID: <ZiefFkFOh8xoI5Bf@hovoldconsulting.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-3-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422134354.89291-3-srinivas.kandagatla@linaro.org>

On Mon, Apr 22, 2024 at 02:43:52PM +0100, Srinivas Kandagatla wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add a common function to add Display port jack, this can be used by
> multiple board files and avoid any code duplication.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/common.c | 29 +++++++++++++++++++++++++++++
>  sound/soc/qcom/common.h |  3 +++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
> index 747041fa7866..3bfe618e7bd7 100644
> --- a/sound/soc/qcom/common.c
> +++ b/sound/soc/qcom/common.c
> @@ -7,10 +7,14 @@
>  #include <sound/jack.h>
>  #include <linux/input-event-codes.h>
>  #include "common.h"

Missing newline.

> +#define NAME_SIZE	32
>  
>  static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
>  	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>  	SND_SOC_DAPM_MIC("Mic Jack", NULL),
> +	SND_SOC_DAPM_SPK("HDMI/DP0 Jack", NULL),
> +	SND_SOC_DAPM_SPK("HDMI/DP1 Jack", NULL),
> +	SND_SOC_DAPM_SPK("HDMI/DP2 Jack", NULL),
>  };
>  
>  int qcom_snd_parse_of(struct snd_soc_card *card)
> @@ -239,4 +243,29 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_snd_wcd_jack_setup);
> +
> +int qcom_snd_dp_jack_setup(struct snd_soc_pcm_runtime *rtd,
> +			   struct snd_soc_jack *hdmi_jack, int hdmi_pcm_id)

The function is called dp_jack_setup() so shouldn't the parameters
reflect that and be called dp_jack etc. for consistency (i.e. even if
you plan on using this interface also for hdmi)?

Johan

