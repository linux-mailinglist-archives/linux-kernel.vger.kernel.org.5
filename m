Return-Path: <linux-kernel+bounces-54979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF9484B5D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FC01C25121
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316F130AD4;
	Tue,  6 Feb 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W0j0SuN+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ANiJc1Kz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W0j0SuN+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ANiJc1Kz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B7612EBD6;
	Tue,  6 Feb 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224423; cv=none; b=N4McNfpgt2KrdZdGcp2j3q93JJkwgorKaVDBqtaPCW9CaMcDt0NkgeraTPyN8J3gSZ2a8iVdO0dgm03+l7f8z2ygNEUx3T5zBYwP26gTq9gJPTYfBpHjkPfNcgHXP5xyK58Sj0/ZXesMV0VbUZvfNw82wbYIHNy5ASjMXIMKhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224423; c=relaxed/simple;
	bh=+aT0rKIS3UKpo4tm29e7syaTdpncuM29O5o+70E1SWo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0xJSVoTdKX/EzcnqyufIEjGVULUz6RopMnGXQHBsh//ig9j3g+mhjO0HhHTEAhOIif4i+q/kyHrW8vftsZmKCHgBYyvNnkteca/iQjo0Ovj8WMObUTjxHslC3YkrasLExsjxfFI0yL/0mvpTLF7naWtzVEPixRw6gioZxecqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W0j0SuN+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ANiJc1Kz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W0j0SuN+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ANiJc1Kz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26B5121F97;
	Tue,  6 Feb 2024 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707224420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPhPVGYDJ3fdMIeQrhxnapM7DO5sG2kieq0UlwBxO6I=;
	b=W0j0SuN+f3pdCTZ/eqYSrkeUibin5cCK5VUQZRbbQeVgIA+GrcC0q0bxzYOH85qV+pF3h8
	IyzuJDVmuYmw/NQQa8oeMAeSJq4nQ/eO7h2xUs2pbRczfdbWXnC1S1tCBa+/o0ZCXA7p1k
	pWtJ66CIO5nhWvmAEuF3xYlfB06bPdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707224420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPhPVGYDJ3fdMIeQrhxnapM7DO5sG2kieq0UlwBxO6I=;
	b=ANiJc1Kzkh0E1o6XsSz0NVKALAxAysv6xSiEsoyTnl62fV/+eOoyuwoQx0WVkjwFFwsrc2
	emMI+XJorrW4yzCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707224420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPhPVGYDJ3fdMIeQrhxnapM7DO5sG2kieq0UlwBxO6I=;
	b=W0j0SuN+f3pdCTZ/eqYSrkeUibin5cCK5VUQZRbbQeVgIA+GrcC0q0bxzYOH85qV+pF3h8
	IyzuJDVmuYmw/NQQa8oeMAeSJq4nQ/eO7h2xUs2pbRczfdbWXnC1S1tCBa+/o0ZCXA7p1k
	pWtJ66CIO5nhWvmAEuF3xYlfB06bPdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707224420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPhPVGYDJ3fdMIeQrhxnapM7DO5sG2kieq0UlwBxO6I=;
	b=ANiJc1Kzkh0E1o6XsSz0NVKALAxAysv6xSiEsoyTnl62fV/+eOoyuwoQx0WVkjwFFwsrc2
	emMI+XJorrW4yzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D30FD132DD;
	Tue,  6 Feb 2024 13:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OHcAM2MtwmXaNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 Feb 2024 13:00:19 +0000
Date: Tue, 06 Feb 2024 14:00:19 +0100
Message-ID: <87zfwdvjbw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
	srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com,
	perex@perex.cz,
	conor+dt@kernel.org,
	corbet@lwn.net,
	lgirdwood@gmail.com,
	andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	gregkh@linuxfoundation.org,
	Thinh.Nguyen@synopsys.com,
	broonie@kernel.org,
	bgoswami@quicinc.com,
	tiwai@suse.com,
	robh+dt@kernel.org,
	konrad.dybcio@linaro.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v13 50/53] ALSA: usb-audio: Allow for rediscovery of connected USB SND devices
In-Reply-To: <aaa76d7a-4299-4e1c-83f1-cbbea763927f@linux.intel.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
	<20240203023645.31105-51-quic_wcheng@quicinc.com>
	<aaa76d7a-4299-4e1c-83f1-cbbea763927f@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[32.59%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 R_RATELIMIT(0.00)[to_ip_from(RLjs3ec4aura4kmsd6wxjjm4hg)];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[quicinc.com,linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Mon, 05 Feb 2024 10:01:03 +0100,
Amadeusz S³awiñski wrote:
> 
> On 2/3/2024 3:36 AM, Wesley Cheng wrote:
> > In case of notifying SND platform drivers of connection events, some of
> > these use cases, such as offloading, require an ASoC USB backend device to
> > be initialized before the events can be handled.  If the USB backend device
> > has not yet been probed, this leads to missing initial USB audio device
> > connection events.
> > 
> > Expose an API that traverses the usb_chip array for connected devices, and
> > to call the respective connection callback registered to the SND platform
> > driver.
> > 
> > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > ---
> >   sound/usb/card.c                  | 19 +++++++++++++++++++
> >   sound/usb/card.h                  |  2 ++
> >   sound/usb/qcom/qc_audio_offload.c |  2 ++
> >   3 files changed, 23 insertions(+)
> > 
> > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > index 11b827b7a2a5..995b2df676ab 100644
> > --- a/sound/usb/card.c
> > +++ b/sound/usb/card.c
> > @@ -202,6 +202,25 @@ struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> >   }
> >   EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
> >   +/*
> > + * in case the platform driver was not ready at the time of USB SND
> > + * device connect, expose an API to discover all connected USB devices
> > + * so it can populate any dependent resources/structures.
> > + */
> > +void snd_usb_rediscover_devices(void)
> > +{
> > +	int i;
> > +
> > +	mutex_lock(&register_mutex);
> > +	for (i = 0; i < SNDRV_CARDS; i++) {
> > +		if (usb_chip[i])
> > +			if (platform_ops && platform_ops->connect_cb)
> > +				platform_ops->connect_cb(usb_chip[i]);
> 
> if inside if, it can just be && or maybe move callback check before
> mutex lock and just return early if it is not present?

The callback check must be inside mutex; otherwise you'll get a race
about the platform_ops registration.


thanks,

Takashi

