Return-Path: <linux-kernel+bounces-45329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4AC842E99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2719CB23F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D5762EC;
	Tue, 30 Jan 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvXEFaVQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4579DD4;
	Tue, 30 Jan 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649684; cv=none; b=ZRnBK0KQKG1I7qaPdE+Fe8Oe3vGrmEfZO+hUOoHgxGEay9eERvx9GXkuZp1fFLQRGQGoDN88kMSxrrTpOYAHhE1lq/kHC45CwrPmANGi+O5LA1Yt103BJkTDmOdihAoNAxl8W/y4i4dNUYY9c0WlhTQgRj1D2PnkBawm6Puaesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649684; c=relaxed/simple;
	bh=Y/tuReEWcyTg7ukUl1CG5uOZXAV9/Ho0VW9jFuDkz4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrxznzFdkAjLrHp2ZYIFKkD8vcanWtU5j0shK8jfcVBV5L4Jur6+BRsoKxcHlDqfTgdf/7ktJGDvBjbLpTQdFsjxzJDnfsBp2Oe8wBPaRJhw+c7lVPnh5ADXWglwMzEeuxwnDsj32t2nM46OBTN/tgfbODpkIY7P1Sy1CTbGDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvXEFaVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B1BC433C7;
	Tue, 30 Jan 2024 21:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706649683;
	bh=Y/tuReEWcyTg7ukUl1CG5uOZXAV9/Ho0VW9jFuDkz4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvXEFaVQrp1uZoG8LjtpMFMlVD0/nBQqCzi6qUsCdLoqLko9oak8ZYAVxbT4Or3V+
	 bGp0j8OMUnfPiqPzROvG0JUNG1J0upSnt5F9TXe4Wf+rhsDkAZwzNfNo7MkBMcIElm
	 9suaaMgzyMpXdi9YzzEIzc7Q/j2oUQPVhVMtp2OEbDZuZUXfWR1L/ySRHeieARWSmU
	 JfggYuzVsD3dQ8j6FTSdMSZS3cMpDGCzO8gxV6rUeeZBp+S4EupxpNHK3tro+s0Sno
	 QJQ0oLz6hohhcOhOcKftxaNpltCYVuRt5yDGWM9j3uu0AItytuWgArCRrVeHrN3bGe
	 Yjzx4VzJJXoUA==
Date: Tue, 30 Jan 2024 15:21:20 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	agross@kernel.org, luca.weiss@fairphone.com, konrad.dybcio@linaro.org, 
	u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com, quic_gurus@quicinc.com, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/7] soc: qcom: add QCOM PBS driver
Message-ID: <ut6jbawqqdgfyoxmt76hm67rbnv67x54eho3nae2dd2szbejfb@7joy57g4i3qt>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
 <20231221185838.28440-4-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221185838.28440-4-quic_amelende@quicinc.com>

On Thu, Dec 21, 2023 at 10:58:33AM -0800, Anjelique Melendez wrote:
> diff --git a/drivers/soc/qcom/qcom-pbs.c b/drivers/soc/qcom/qcom-pbs.c
[..]
> +static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
> +{
> +	int ret, retries = 2000, delay = 1100;

retries and delay are not variable, please use defines instead.

> +	unsigned int val;
> +
> +	ret = regmap_read_poll_timeout(pbs->regmap,  pbs->base + PBS_CLIENT_SCRATCH2,
> +					val, val & BIT(bit_pos), delay, delay * retries);
> +
> +	if (ret < 0) {
> +		dev_err(pbs->dev, "Timeout for PBS ACK/NACK for bit %u\n", bit_pos);
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (val == PBS_CLIENT_SCRATCH2_ERROR) {
> +		ret = regmap_write(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, 0);
> +		dev_err(pbs->dev, "NACK from PBS for bit %u\n", bit_pos);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(pbs->dev, "PBS sequence for bit %u executed!\n", bit_pos);
> +	return 0;
> +}
> +
> +/**
> + * qcom_pbs_trigger_event() - Trigger the PBS RAM sequence
> + * @pbs: Pointer to PBS device
> + * @bitmap: bitmap
> + *
> + * This function is used to trigger the PBS RAM sequence to be
> + * executed by the client driver.
> + *
> + * The PBS trigger sequence involves
> + * 1. setting the PBS sequence bit in PBS_CLIENT_SCRATCH1
> + * 2. Initiating the SW PBS trigger
> + * 3. Checking the equivalent bit in PBS_CLIENT_SCRATCH2 for the
> + *    completion of the sequence.
> + * 4. If PBS_CLIENT_SCRATCH2 == 0xFF, the PBS sequence failed to execute
> + *
> + * Returns: 0 on success, < 0 on failure

Return: without the 's' is the appropriate form here.

> + */
> +int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
> +{
> +	unsigned int val;
> +	u16 bit_pos;
> +	int ret;
> +
> +	if (!bitmap) {
> +		dev_err(pbs->dev, "Invalid bitmap passed by client\n");

No one is going to spot that hidden in the kernel log, and if someone
sees it it does not give an indication to which client it is that's
broken (if there are multiple clients...)

Instead do:

	if (WARN_ON(!bitmap))
		return -EINVAL;

> +		return -EINVAL;
> +	}
> +
> +	if (IS_ERR_OR_NULL(pbs))
> +		return -EINVAL;
> +
> +	mutex_lock(&pbs->lock);
> +	ret = regmap_read(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, &val);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (val == PBS_CLIENT_SCRATCH2_ERROR) {
> +		/* PBS error - clear SCRATCH2 register */
> +		ret = regmap_write(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, 0);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	for (bit_pos = 0; bit_pos < 8; bit_pos++) {
> +		if (!(bitmap & BIT(bit_pos)))
> +			continue;
> +
> +		/* Clear the PBS sequence bit position */
> +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2,
> +					BIT(bit_pos), 0);
> +		if (ret < 0)
> +			goto error;
> +
> +		/* Set the PBS sequence bit position */
> +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1,
> +					BIT(bit_pos), BIT(bit_pos));
> +		if (ret < 0)
> +			goto error;
> +
> +		/* Initiate the SW trigger */
> +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_TRIG_CTL,
> +					PBS_CLIENT_SW_TRIG_BIT, PBS_CLIENT_SW_TRIG_BIT);
> +		if (ret < 0)
> +			goto error;
> +
> +		ret = qcom_pbs_wait_for_ack(pbs, bit_pos);
> +		if (ret < 0)
> +			goto error;

In the case that this fails, you're jumping to error, which clears all
of SCRATCH1, but you're leaving SCRATCH2 untouched.

> +
> +		/* Clear the PBS sequence bit position */
> +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1,
> +					BIT(bit_pos), 0);
> +		if (ret < 0)
> +			goto error;

Does it make sense to handle this error by jumping to error and trying
to clear it once more - while leaving SCRATCH2?

Perhaps you should just ignore the errors from clearing SCRATCH1 and
SCRATCH2? You where able to trigger the PBS and you got your ack...

> +
> +		/* Clear the PBS sequence bit position */
> +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2,
> +					BIT(bit_pos), 0);
> +		if (ret < 0)
> +			goto error;
> +	}
> +
> +error:

We're passing "error" in the successful case as well, please name this
"out_clear_scratch1" (or something) instead, to not confuse the reader.

> +	/* Clear all the requested bitmap */
> +	ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1, bitmap, 0);
> +
> +out:
> +	mutex_unlock(&pbs->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pbs_trigger_event);
> +
> +/**
> + * get_pbs_client_device() - Get the PBS device used by client
> + * @dev: Client device
> + *
> + * This function is used to get the PBS device that is being
> + * used by the client.
> + *
> + * Returns: pbs_dev on success, ERR_PTR on failure

Return:

Regards,
Bjorn

