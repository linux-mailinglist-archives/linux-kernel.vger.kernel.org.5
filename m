Return-Path: <linux-kernel+bounces-55000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536C84B619
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE862286978
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1253131E28;
	Tue,  6 Feb 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nzRqkNa9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xJkjNn/l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nzRqkNa9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xJkjNn/l"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46263130AEA;
	Tue,  6 Feb 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225173; cv=none; b=Ztt+VafRm2LBGrInCf3agQPpD0eoC2WYAZnE/eISCqRt/jk0v6K6Z1KxL6hSq+zuVEq4xSPd/as3UzG4jjXz4fdz9J5b9PN4Ru/u+hU/5KiwCODvRTaNqLJgaREmIqXmTsTif3cse+RLrP0yCP1lWB6lSZjLqU6uwMqQLpKhhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225173; c=relaxed/simple;
	bh=pQ5978DNg56uJKXZdg/gf4ds5wQ+oWnn70I2+3ozUwk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9iGO1XMlvYZzItdvV60LDEjFY+T9iM5d9mVkfXqnOz8WHCf07b8cer+BChb/zz+HHg74QpnTKXOTdkl36+YvLhNsv5GPSS7amgfr8PzsXhql8yicqN5lXC9EOaiG9DhbFPyT77IW362Syg23BDGWG/JHIJC/ygcc6lj2nqbqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nzRqkNa9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xJkjNn/l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nzRqkNa9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xJkjNn/l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45FA121F23;
	Tue,  6 Feb 2024 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pu0AmyhNLblBGibwDuGJkfaRqWe4VLl/6YMlZsow0qs=;
	b=nzRqkNa9xazo+VgyphXV+yGCSIvuhLB7QRfansFESogku2rqIFhrJ29YwNG/odg7xHZJeL
	pVSS7Q6U4QQGhO389T7FaAKxsyPi8WPslGHa/XfZ80qfVaQFD0s5o2AIQ5ybWlXPDzgQNe
	YF3QOT2yvdQFM+Af+oTsPzNhEoGwNYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pu0AmyhNLblBGibwDuGJkfaRqWe4VLl/6YMlZsow0qs=;
	b=xJkjNn/lmurCkg39PYsOcnXXO3go57x86ZHTuH8mOB28zShJ2cADmDVcBKuGrl5UZhMxEa
	muEzCM8RIed52rDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pu0AmyhNLblBGibwDuGJkfaRqWe4VLl/6YMlZsow0qs=;
	b=nzRqkNa9xazo+VgyphXV+yGCSIvuhLB7QRfansFESogku2rqIFhrJ29YwNG/odg7xHZJeL
	pVSS7Q6U4QQGhO389T7FaAKxsyPi8WPslGHa/XfZ80qfVaQFD0s5o2AIQ5ybWlXPDzgQNe
	YF3QOT2yvdQFM+Af+oTsPzNhEoGwNYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pu0AmyhNLblBGibwDuGJkfaRqWe4VLl/6YMlZsow0qs=;
	b=xJkjNn/lmurCkg39PYsOcnXXO3go57x86ZHTuH8mOB28zShJ2cADmDVcBKuGrl5UZhMxEa
	muEzCM8RIed52rDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0911C132DD;
	Tue,  6 Feb 2024 13:12:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Iky2AVEwwmUuOQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 Feb 2024 13:12:49 +0000
Date: Tue, 06 Feb 2024 14:12:44 +0100
Message-ID: <87wmrhvir7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: <srinivas.kandagatla@linaro.org>,
	<mathias.nyman@intel.com>,
	<perex@perex.cz>,
	<conor+dt@kernel.org>,
	<corbet@lwn.net>,
	<lgirdwood@gmail.com>,
	<andersson@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>,
	<gregkh@linuxfoundation.org>,
	<Thinh.Nguyen@synopsys.com>,
	<broonie@kernel.org>,
	<bgoswami@quicinc.com>,
	<tiwai@suse.com>,
	<robh+dt@kernel.org>,
	<konrad.dybcio@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
Subject: Re: [PATCH v13 32/53] ALSA: usb-audio: Check for support for requested audio format
In-Reply-To: <20240203023645.31105-33-quic_wcheng@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
	<20240203023645.31105-33-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.03)[56.46%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLjs3ec4aura4kmsd6wxjjm4hg)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
X-Spam-Score: 2.37
X-Spam-Flag: NO

On Sat, 03 Feb 2024 03:36:24 +0100,
Wesley Cheng wrote:
> 
> Allow for checks on a specific USB audio device to see if a requested PCM
> format is supported.  This is needed for support when playback is
> initiated by the ASoC USB backend path.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

Just cosmetic:

> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction)
> +{
> +	struct snd_usb_audio *chip;
> +	struct snd_usb_substream *subs;
> +	struct snd_usb_stream *as;
> +	const struct audioformat *fmt;
> +
> +	/*
> +	 * Register mutex is held when populating and clearing usb_chip
> +	 * array.
> +	 */
> +	mutex_lock(&register_mutex);
> +	chip = usb_chip[card_idx];
> +	if (!chip) {
> +		mutex_unlock(&register_mutex);
> +		return NULL;
> +	}
> +
> +	if (enable[card_idx]) {
> +		list_for_each_entry(as, &chip->pcm_list, list) {
> +			subs = &as->substream[direction];
> +			fmt = snd_usb_find_substream_format(subs, params);
> +			if (fmt) {
> +				mutex_unlock(&register_mutex);
> +				return as;
> +			}
> +		}
> +	}
> +	mutex_unlock(&register_mutex);

I prefer having the single lock/unlock call pair, e.g.

	struct snd_usb_stream *as, *ret;

	ret = NULL;
	mutex_lock(&register_mutex);
	chip = usb_chip[card_idx];
	if (chip && enable[card_idx]) {
		list_for_each_entry(as, &chip->pcm_list, list) {
			subs = &as->substream[direction];
			if (snd_usb_find_substream_format(subs, params)) {
				ret = as;
				break;
			}
		}
	}
	mutex_unlock(&register_mutex);
	return ret;
}

In this case, we shouldn't reuse "as" for the return value since it
can be non-NULL after the loop end.


thanks,

Takashi

