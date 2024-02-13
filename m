Return-Path: <linux-kernel+bounces-63380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A5852E71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F8328752A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663D73611A;
	Tue, 13 Feb 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ptWaMmHC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="utgGMOWR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ptWaMmHC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="utgGMOWR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0635532C60;
	Tue, 13 Feb 2024 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821699; cv=none; b=Q9rlhBAfiTZ4+VkOPxVkidekELaii/W+iP722QshF9XDTpTyCuRBhBNbK90GIOBVJTwGR/6UzwVKUsS5WbT837ydQM1v4pyfqcfeTHpRczt6DWDJlRgFyINEKBEyWuC4JwqTJj7FF7pRoqRumMNzK8MAHLmuTjMUeVSkPL0qHVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821699; c=relaxed/simple;
	bh=K3t6IqIKVeRKOMmSmTLavxByRukWLKFnqr8MqyIR7DE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1T+KmhCKPyPSiTWCwo+8VXi+eAv4umXsKDwZcLhQtg/77OHoz8piX4AqKfwuI3ElDe2m2hOUs8Y119HcvqV4rgJi/bf1KnElfUaavm3GwJhSpZpnALeyc2N4lClJRsCk4C47UCHUwgGt+DJdOp3Tf+fmF+BV5/9Cs6HWmck20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ptWaMmHC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=utgGMOWR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ptWaMmHC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=utgGMOWR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 193D01FC81;
	Tue, 13 Feb 2024 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707821696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBmU54n2WXwfimAjDCe1BZ77s/sceqYcDk/8NeTsA4A=;
	b=ptWaMmHCu0WmXUctmHEU4mCeId9zOiG5a0iQQBRxFuY8QC/GafoaKTiU1V2jEmQDgCPwCQ
	VTR3JZyPeesRR0C8sdcg3xYe2D1HV5oPut5gyCIuGktzlytdfqvGffdACMFJQEwvVMZmzN
	K5pD4u0APQoNHkN/ZmV7xEtABWhhXJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707821696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBmU54n2WXwfimAjDCe1BZ77s/sceqYcDk/8NeTsA4A=;
	b=utgGMOWRS0M2GQZ6TPczOuJhSlppGUoiB+pe2BYHst1BPNtqP56qiBOaCPVFDbN+u4MGVy
	yLrTGGdjCV86kaAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707821696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBmU54n2WXwfimAjDCe1BZ77s/sceqYcDk/8NeTsA4A=;
	b=ptWaMmHCu0WmXUctmHEU4mCeId9zOiG5a0iQQBRxFuY8QC/GafoaKTiU1V2jEmQDgCPwCQ
	VTR3JZyPeesRR0C8sdcg3xYe2D1HV5oPut5gyCIuGktzlytdfqvGffdACMFJQEwvVMZmzN
	K5pD4u0APQoNHkN/ZmV7xEtABWhhXJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707821696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cBmU54n2WXwfimAjDCe1BZ77s/sceqYcDk/8NeTsA4A=;
	b=utgGMOWRS0M2GQZ6TPczOuJhSlppGUoiB+pe2BYHst1BPNtqP56qiBOaCPVFDbN+u4MGVy
	yLrTGGdjCV86kaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2B4C13404;
	Tue, 13 Feb 2024 10:54:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PNvnMn9Ky2WsbwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 10:54:55 +0000
Date: Tue, 13 Feb 2024 11:54:55 +0100
Message-ID: <87y1boy6ps.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v15 39/50] ASoC: Introduce SND kcontrols to select sound card and PCM device
In-Reply-To: <20240213005422.3121-40-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
	<20240213005422.3121-40-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ptWaMmHC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=utgGMOWR
X-Spamd-Result: default: False [0.88 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.31)[75.28%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.88
X-Rspamd-Queue-Id: 193D01FC81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue, 13 Feb 2024 01:54:11 +0100,
Wesley Cheng wrote:
> 
> +static int soc_usb_get_offload_dev(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_usb *ctx = snd_soc_usb_find_priv_data(component->dev);
> +	int ret = 0;
> +
> +	mutex_lock(&ctx_mutex);
> +	if (ctx && ctx->get_offload_dev)
> +		ret = ctx->get_offload_dev(kcontrol, ucontrol);
> +	mutex_unlock(&ctx_mutex);

It might be safer to initialize the values with -1 in case when the
callback isn't available?

>  /**
>   * snd_soc_usb_get_components_tag() - Retrieve SOC USB component tag
>   * @playback: direction of audio stream
> @@ -157,6 +218,12 @@ EXPORT_SYMBOL_GPL(snd_soc_usb_free_port);
>   */
>  int snd_soc_usb_add_port(struct snd_soc_usb *usb)
>  {
> +	int ret;
> +
> +	ret = snd_soc_usb_control_init(usb->component);
> +	if (ret < 0)
> +		return ret;
> +
>  	mutex_lock(&ctx_mutex);
>  	list_add_tail(&usb->list, &usb_ctx_list);
>  	mutex_unlock(&ctx_mutex);

We may need to remove the control element upon the driver removal,
too?  In theory, you can unload the offload stuff while snd-usb-audio
is still active.


thanks,

Takashi

