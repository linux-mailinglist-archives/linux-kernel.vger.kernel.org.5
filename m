Return-Path: <linux-kernel+bounces-46089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0C8843A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73D11F2F814
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD56D1D4;
	Wed, 31 Jan 2024 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjYAplxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB596657DD;
	Wed, 31 Jan 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691530; cv=none; b=sTn9LYaJfLLX4pBBTDQvt4ehMSMxODfO05EC6zbZVZaYOmvAf6zPo9zytOpW21XLw8nal790Z9sVigjH59QAHwnyShUu0+vWghODE4XjeJPz6gWnhIVgO77MmJNRpAw5Q6SZ0ZW3WoS3NYwOtI/nDZiXm5eqS75fYHTCDmc1dUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691530; c=relaxed/simple;
	bh=UqpO+ZTsRWdC3QcNmOmOQIsAqQNQt/nfOlLpfSk+jHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnlDxnHMe/5ofJLL7YmlUnXjgOudZ5OQhpJuSCk40cDFfLNX5mWf5vWM2qTpOqZ8b7wNkwAU3hh00wbGYhw83/9xOZoFhWAqw9s7SmlZSB12qFmihU2tLFBc53nsOjVE6+cpk14jzlYDfqfPBee+RlUtGzksczBmUJiT13Wmpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjYAplxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0084BC433C7;
	Wed, 31 Jan 2024 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706691529;
	bh=UqpO+ZTsRWdC3QcNmOmOQIsAqQNQt/nfOlLpfSk+jHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjYAplxZycro68aVGkGnlUXGB1CpvGk9JPfk7VmwOq/Y2DF4JGEdSYdHzYEgWYB4i
	 jxBgPnIVQD2G6jRoXgQfY7k4zcu3iUxluP4XCCLsBqUCmPFbNVSOOUH7O9vL8JfbPe
	 gd6sx91ioayc2L5qv0E+6oC5lAlMHiYJg7rfv0CEu/TY2hyX4HE9cmUfk3aTt9gL/l
	 BnS4/yXPOvJQOqo1IvsBbJjoBHJh2cnOxuajl7dr7pwx50MDNV19ucyqi9P2sLM4oD
	 6Jobsi4BfgxYq3sM2lv0wWYojAOGasxupa0R5XICEUNgvgrbV6EQhD/7LjMFvX0SMG
	 AHAG3mRZX4JaA==
Date: Wed, 31 Jan 2024 08:58:42 +0000
From: Lee Jones <lee@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
	thierry.reding@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, luca.weiss@fairphone.com,
	konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
	quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/7] soc: qcom: add QCOM PBS driver
Message-ID: <20240131085842.GF8551@google.com>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
 <20231221185838.28440-4-quic_amelende@quicinc.com>
 <ut6jbawqqdgfyoxmt76hm67rbnv67x54eho3nae2dd2szbejfb@7joy57g4i3qt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ut6jbawqqdgfyoxmt76hm67rbnv67x54eho3nae2dd2szbejfb@7joy57g4i3qt>

Intentional generic top-post reply.

Please work quickly to resolve Bjorn's comments.

I'm being hounded over a broken LEDs tree due to the missing headerfile.

/end

On Tue, 30 Jan 2024, Bjorn Andersson wrote:

> On Thu, Dec 21, 2023 at 10:58:33AM -0800, Anjelique Melendez wrote:
> > diff --git a/drivers/soc/qcom/qcom-pbs.c b/drivers/soc/qcom/qcom-pbs.c
> [..]
> > +static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
> > +{
> > +	int ret, retries = 2000, delay = 1100;
> 
> retries and delay are not variable, please use defines instead.
> 
> > +	unsigned int val;
> > +
> > +	ret = regmap_read_poll_timeout(pbs->regmap,  pbs->base + PBS_CLIENT_SCRATCH2,
> > +					val, val & BIT(bit_pos), delay, delay * retries);
> > +
> > +	if (ret < 0) {
> > +		dev_err(pbs->dev, "Timeout for PBS ACK/NACK for bit %u\n", bit_pos);
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	if (val == PBS_CLIENT_SCRATCH2_ERROR) {
> > +		ret = regmap_write(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, 0);
> > +		dev_err(pbs->dev, "NACK from PBS for bit %u\n", bit_pos);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(pbs->dev, "PBS sequence for bit %u executed!\n", bit_pos);
> > +	return 0;
> > +}
> > +
> > +/**
> > + * qcom_pbs_trigger_event() - Trigger the PBS RAM sequence
> > + * @pbs: Pointer to PBS device
> > + * @bitmap: bitmap
> > + *
> > + * This function is used to trigger the PBS RAM sequence to be
> > + * executed by the client driver.
> > + *
> > + * The PBS trigger sequence involves
> > + * 1. setting the PBS sequence bit in PBS_CLIENT_SCRATCH1
> > + * 2. Initiating the SW PBS trigger
> > + * 3. Checking the equivalent bit in PBS_CLIENT_SCRATCH2 for the
> > + *    completion of the sequence.
> > + * 4. If PBS_CLIENT_SCRATCH2 == 0xFF, the PBS sequence failed to execute
> > + *
> > + * Returns: 0 on success, < 0 on failure
> 
> Return: without the 's' is the appropriate form here.
> 
> > + */
> > +int qcom_pbs_trigger_event(struct pbs_dev *pbs, u8 bitmap)
> > +{
> > +	unsigned int val;
> > +	u16 bit_pos;
> > +	int ret;
> > +
> > +	if (!bitmap) {
> > +		dev_err(pbs->dev, "Invalid bitmap passed by client\n");
> 
> No one is going to spot that hidden in the kernel log, and if someone
> sees it it does not give an indication to which client it is that's
> broken (if there are multiple clients...)
> 
> Instead do:
> 
> 	if (WARN_ON(!bitmap))
> 		return -EINVAL;
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (IS_ERR_OR_NULL(pbs))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&pbs->lock);
> > +	ret = regmap_read(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, &val);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if (val == PBS_CLIENT_SCRATCH2_ERROR) {
> > +		/* PBS error - clear SCRATCH2 register */
> > +		ret = regmap_write(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2, 0);
> > +		if (ret < 0)
> > +			goto out;
> > +	}
> > +
> > +	for (bit_pos = 0; bit_pos < 8; bit_pos++) {
> > +		if (!(bitmap & BIT(bit_pos)))
> > +			continue;
> > +
> > +		/* Clear the PBS sequence bit position */
> > +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2,
> > +					BIT(bit_pos), 0);
> > +		if (ret < 0)
> > +			goto error;
> > +
> > +		/* Set the PBS sequence bit position */
> > +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1,
> > +					BIT(bit_pos), BIT(bit_pos));
> > +		if (ret < 0)
> > +			goto error;
> > +
> > +		/* Initiate the SW trigger */
> > +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_TRIG_CTL,
> > +					PBS_CLIENT_SW_TRIG_BIT, PBS_CLIENT_SW_TRIG_BIT);
> > +		if (ret < 0)
> > +			goto error;
> > +
> > +		ret = qcom_pbs_wait_for_ack(pbs, bit_pos);
> > +		if (ret < 0)
> > +			goto error;
> 
> In the case that this fails, you're jumping to error, which clears all
> of SCRATCH1, but you're leaving SCRATCH2 untouched.
> 
> > +
> > +		/* Clear the PBS sequence bit position */
> > +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1,
> > +					BIT(bit_pos), 0);
> > +		if (ret < 0)
> > +			goto error;
> 
> Does it make sense to handle this error by jumping to error and trying
> to clear it once more - while leaving SCRATCH2?
> 
> Perhaps you should just ignore the errors from clearing SCRATCH1 and
> SCRATCH2? You where able to trigger the PBS and you got your ack...
> 
> > +
> > +		/* Clear the PBS sequence bit position */
> > +		ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH2,
> > +					BIT(bit_pos), 0);
> > +		if (ret < 0)
> > +			goto error;
> > +	}
> > +
> > +error:
> 
> We're passing "error" in the successful case as well, please name this
> "out_clear_scratch1" (or something) instead, to not confuse the reader.
> 
> > +	/* Clear all the requested bitmap */
> > +	ret = regmap_update_bits(pbs->regmap, pbs->base + PBS_CLIENT_SCRATCH1, bitmap, 0);
> > +
> > +out:
> > +	mutex_unlock(&pbs->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_pbs_trigger_event);
> > +
> > +/**
> > + * get_pbs_client_device() - Get the PBS device used by client
> > + * @dev: Client device
> > + *
> > + * This function is used to get the PBS device that is being
> > + * used by the client.
> > + *
> > + * Returns: pbs_dev on success, ERR_PTR on failure
> 
> Return:
> 
> Regards,
> Bjorn

-- 
Lee Jones [李琼斯]

