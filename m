Return-Path: <linux-kernel+bounces-63493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6F85305B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3107C1C22567
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA743D99E;
	Tue, 13 Feb 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BgCj2Olw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W8XscNEP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BgCj2Olw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W8XscNEP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCC381A0;
	Tue, 13 Feb 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826685; cv=none; b=IIjZ72OX8lPRvQzVpTx3PPJtVgyyisDbNSNG2I0rOEcbp57gzIvY3lU0IFEKtBQFbyKCEup6FsSBlPcXoDEDRt/IhCq0Lxxjh+3tOzXtEUDgM/ZIeIkhyi0nxJTNzy960EIkscfGk4qmBMj7+Xq2BGlc24Wh6h+zbJsI5hEUvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826685; c=relaxed/simple;
	bh=TNsmmxa+6HeFCAOCpipUzX2RGd7pxLJG/+tp3ucMPnc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pm77CD3lwDcWTfEsh1Hj9fjscqXNGySwYk+co/LBACsG++5amED0GEHkY+Og7s1pV1OniRGYeaEcj5WFflmUjm5x6UkMBgL9xjXuzRjL5+8f/kMolOHWJCBdjRZ1p8Q7sRSH7orWIvuTfvBJzCf2cfR+UqkxMCdEQOdNtBKWfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BgCj2Olw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W8XscNEP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BgCj2Olw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W8XscNEP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B656A1FCA1;
	Tue, 13 Feb 2024 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707826681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OenRm4KDcWLHzJQS8tkPl+f9jR79iIvkYkLzvmSq+jQ=;
	b=BgCj2Olw566Htu1EG2uF4EUwJZX2KMFBPnMyUuNwpbspUfqPlZCrVcM+5f4d9F1JjJ4zBl
	KV4iug0fvq/hE34snF6uaTD8kGQOfXEOdncvZ4OAr63p3vPOHonWljidbMGbOxFR+KiArC
	up6sUx6mW6fZPM1R/pzPK0TGsvBG5bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707826681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OenRm4KDcWLHzJQS8tkPl+f9jR79iIvkYkLzvmSq+jQ=;
	b=W8XscNEPtOb8qP2wQeAZwA9zewFvjRHHl52AQn5bsIQEvWUltf3QWdCfya5b5TY8A6Mrwd
	+TWbSDJRKATZNkCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707826681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OenRm4KDcWLHzJQS8tkPl+f9jR79iIvkYkLzvmSq+jQ=;
	b=BgCj2Olw566Htu1EG2uF4EUwJZX2KMFBPnMyUuNwpbspUfqPlZCrVcM+5f4d9F1JjJ4zBl
	KV4iug0fvq/hE34snF6uaTD8kGQOfXEOdncvZ4OAr63p3vPOHonWljidbMGbOxFR+KiArC
	up6sUx6mW6fZPM1R/pzPK0TGsvBG5bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707826681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OenRm4KDcWLHzJQS8tkPl+f9jR79iIvkYkLzvmSq+jQ=;
	b=W8XscNEPtOb8qP2wQeAZwA9zewFvjRHHl52AQn5bsIQEvWUltf3QWdCfya5b5TY8A6Mrwd
	+TWbSDJRKATZNkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AEFA1370C;
	Tue, 13 Feb 2024 12:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J4IgGPldy2XVBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 12:18:01 +0000
Date: Tue, 13 Feb 2024 13:18:01 +0100
Message-ID: <87o7cky2va.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v15 46/50] ALSA: usb-audio: Add USB offloading capable kcontrol
In-Reply-To: <20240213005422.3121-47-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
	<20240213005422.3121-47-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.22)[72.28%];
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: **
X-Spam-Score: 2.18
X-Spam-Flag: NO

On Tue, 13 Feb 2024 01:54:18 +0100,
Wesley Cheng wrote:
> 
> --- a/sound/usb/Makefile
> +++ b/sound/usb/Makefile
> @@ -22,6 +22,7 @@ snd-usb-audio-objs := 	card.o \
>  			stream.o \
>  			validate.o
>  
> +snd-usb-audio-$(CONFIG_SND_USB_OFFLOAD_MIXER) += mixer_usb_offload.o
>  snd-usb-audio-$(CONFIG_SND_USB_AUDIO_MIDI_V2) += midi2.o
>  snd-usb-audio-$(CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER) += media.o

This puts the code into snd-usb-audio driver, and that causes a
dependency mess, since...

> +snd_usb_offload_available_get(struct snd_kcontrol *kcontrol,
> +		      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct device *sysdev = snd_kcontrol_chip(kcontrol);
> +	int ret;
> +
> +	ret = snd_soc_usb_device_offload_available(sysdev);

.. here you call snd_soc_usb_*() stuff that belongs to snd-soc-usb.
That is, with this patch, snd-usb-audio driver will depend on
snd-soc-usb, while snd-soc-usb also depends on snd-usb-audio for its
helpers again.

I believe the better way would be to move this whole miser_usb_offload
code into sound/usb/qcom/.  You need only usb_device and snd_card
objects at the creation, and you can get them in qcom driver side,
too.


thanks,

Takashi

