Return-Path: <linux-kernel+bounces-54976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164E384B5C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6DB289D93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAA4130E5F;
	Tue,  6 Feb 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vu0o+OOJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="so+rAKsH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vu0o+OOJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="so+rAKsH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5D12F386;
	Tue,  6 Feb 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224271; cv=none; b=Y8R7QqJTwgNdf+6uh4WU1Pi+pfI8QGtPrw/ciYFN6rsSF1uHsuyQmuGl23hs1RLwWySWpzVXH0vDAjlwK1iLrrZU4WG6wfUVEk/wP2h9opfSVBITnkJkQUByuWod5bYbpzPwwsys67wQ2VJKSSjydi5Vsiwgso/Ih+BKBkIs4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224271; c=relaxed/simple;
	bh=iL0HRojAzYDaeWoChYZcGEd6ts/epCRxUVQaIOugMFE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFOxX6movHkMkcO8CwNthfGh4Kup1SabrWzCcOaV+tPGXkyKZ7WWC/Lr5p9bHOby8z5nhU6lraFCbq6XRnmA2VXJnH25Mza0GmpM1YFNi08ONDDSXndA4O3U3OgRa/3uJhJJL4Np4TTDLSXsKt7Oe4C8eP8EYcb0fg++X7901oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vu0o+OOJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=so+rAKsH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vu0o+OOJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=so+rAKsH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63FFE21F97;
	Tue,  6 Feb 2024 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707224267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrPdcscD82ZUY6PH9OM5wcI+tI4zDbEnOTR3kzNVpoY=;
	b=Vu0o+OOJCFymyujwpECX00A2LCtfKTRvohJSFlRp2HCQDi2ASSyoXDk1TRT9PKwu321lSM
	DQQMpThrEAdi3gZ19WRBx0XyssIohW0LukqZnIfCIJJNNC5o5z/QvL6R32M7/sAqM4cQR1
	EAoGKcKPoWnRCVoChWgr7HnZqBqnH7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707224267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrPdcscD82ZUY6PH9OM5wcI+tI4zDbEnOTR3kzNVpoY=;
	b=so+rAKsHbAGYwYUwwIrZetLGZ3KJ5tk2kB6NITrgOAmtmPCU6vhDIr769baVDdI9a+KnWu
	RA/S6XqmGkLW6GDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707224267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrPdcscD82ZUY6PH9OM5wcI+tI4zDbEnOTR3kzNVpoY=;
	b=Vu0o+OOJCFymyujwpECX00A2LCtfKTRvohJSFlRp2HCQDi2ASSyoXDk1TRT9PKwu321lSM
	DQQMpThrEAdi3gZ19WRBx0XyssIohW0LukqZnIfCIJJNNC5o5z/QvL6R32M7/sAqM4cQR1
	EAoGKcKPoWnRCVoChWgr7HnZqBqnH7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707224267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrPdcscD82ZUY6PH9OM5wcI+tI4zDbEnOTR3kzNVpoY=;
	b=so+rAKsHbAGYwYUwwIrZetLGZ3KJ5tk2kB6NITrgOAmtmPCU6vhDIr769baVDdI9a+KnWu
	RA/S6XqmGkLW6GDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A5CB139D8;
	Tue,  6 Feb 2024 12:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jP2zBcsswmXfMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 Feb 2024 12:57:47 +0000
Date: Tue, 06 Feb 2024 13:57:46 +0100
Message-ID: <871q9pwy0l.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v13 48/53] ALSA: usb-audio: mixer: Add USB offloading mixer control
In-Reply-To: <20240203023645.31105-49-quic_wcheng@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
	<20240203023645.31105-49-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Vu0o+OOJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=so+rAKsH
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.09)[64.59%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,quicinc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.60
X-Rspamd-Queue-Id: 63FFE21F97
X-Spam-Flag: NO

On Sat, 03 Feb 2024 03:36:40 +0100,
Wesley Cheng wrote:
> 
> In order to allow userspace/applications know about USB offloading status,
> expose a sound kcontrol that fetches information about which sound card
> index is associated with the ASoC platform card supporting offloading.  In
> the USB audio offloading framework, the ASoC BE DAI link is the entity
> responsible for registering to the SOC USB layer.  SOC USB will expose more
> details about the current offloading status, which includes the USB sound
> card and USB PCM device indexes currently being used.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

The concept is understandable, but the control element name ("SNDUSB
OFFLD playback available") looks non-intrusive and non-conformant.
Use a bit more understandable name instead.

This provides a card number where the offload driver is bound, and the
name should indicate something about that.

Also, about the implementation:

> +static int
> +snd_usb_offload_create_mixer(struct usb_mixer_interface *mixer,
> +		       const struct snd_kcontrol_new *new_kctl)
> +{
> +	struct snd_kcontrol *kctl;
> +	struct usb_mixer_elem_info *elem;
> +
> +	elem = kzalloc(sizeof(struct usb_mixer_elem_info), GFP_KERNEL);
> +	if (!elem)
> +		return -ENOMEM;
> +
> +	elem->head.mixer = mixer;
> +	elem->val_type = USB_MIXER_S32;
> +	elem->control = 0;
> +	elem->head.id = 0;
> +	elem->channels = 1;
> +
> +	kctl = snd_ctl_new1(new_kctl, elem);
> +	if (!kctl) {
> +		kfree(elem);
> +		return -ENOMEM;
> +	}
> +	kctl->private_free = snd_usb_mixer_elem_free;
> +
> +	return snd_usb_mixer_add_control(&elem->head, kctl);

This control has almost little to do with the standard USB interface,
and it'll be much simpler if you create a raw control element.
Pass the bus or the sysdev to private_data, and that's all you need in
the get callback.

Also, don't forget to set the proper access bits (it's read-only).


thanks,

Takashi

