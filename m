Return-Path: <linux-kernel+bounces-59237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515584F3A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D87A281A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A522075;
	Fri,  9 Feb 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="orGtqKTJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FrJirbGZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JyrDe80N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ArZdDtex"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE531D549;
	Fri,  9 Feb 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475350; cv=none; b=Flgb1pXCymlfZhA/PPwhoZC7UICd3bOu2awne9yIj3bhl0qhecwXtuiTJRYZeoZIGIuoDYxk5G/IuTUk1FKL6Sp20NMIVVzmAunIo1PuX0t3f4xgCbJNzhjLuyt0Z5cIqZD6SGPRiUGY/oMi1imYzijvylb6DHp3Zply3QYZmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475350; c=relaxed/simple;
	bh=u3LjFcDXcTxz+p0kDEWc5CRRjqLePcSSXEO5/NjrY/8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk5Wje5cqVkKt/Cpbmvr8NgWU5d2Z6br6WAMZ+dVph2o8gkCUMUrHDTy+TSgq4+LeboM4WTsTTZ8vfsUjOgcNMMQVubZh2KGnZ3XFcp4YzPhgSob0FId2cwbFB4n4FvSl4utai1E9QsDzPCIKKacc1a//jnDuHnICeQBlPvUOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=orGtqKTJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FrJirbGZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JyrDe80N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ArZdDtex; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82D6E1F7F9;
	Fri,  9 Feb 2024 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707475347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMSOHc/inGGyuv3x57KLOxL8WKaH1QEOP7FHD0HM1vI=;
	b=orGtqKTJd1jaVvNWKMbksSoQK4TVID+vUSzByBerljLsn4UXdwyrPEsjmhBij8d4XOjBfp
	F4u3JGLse7PDvStVIAOcoqPF+4fI6JFumMU2WN9HbM5Fyd2griah252GmaFAvYZ7FifrYY
	q8y6lJyvAc4ZRyfSWaQyPEBctnSEMDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707475347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMSOHc/inGGyuv3x57KLOxL8WKaH1QEOP7FHD0HM1vI=;
	b=FrJirbGZCWLNvdKUUAj2lGVuNRz+UZcQfJto3XvNQq664Bm4gy3851vULxhkljZTgemwjz
	XXLfybBrCa4ddxAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707475345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMSOHc/inGGyuv3x57KLOxL8WKaH1QEOP7FHD0HM1vI=;
	b=JyrDe80NI7rgysm3IrJd5xzv9lo9q2OtkD8k3vEvoQXj5WXu2xxNmuH/2GApGob5w7pXbv
	f5/FnG1pw9TyzOFTGv7m/JDc368K4Vn2Z8OdE+mgStOGtepX0XlQGZvBhf7JGd+t41BYBu
	zLWnTYWtrGETkLH7KYPgE4TFokiFd98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707475345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMSOHc/inGGyuv3x57KLOxL8WKaH1QEOP7FHD0HM1vI=;
	b=ArZdDtexB7hw8ujutiuUqYqDnWN1oG0jdrHK9vDtQz8iGL2sxP4f9OzW57/TP1wgaQT8sh
	KKLv5H1nnCFXmrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0B761326D;
	Fri,  9 Feb 2024 10:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UY1tMZABxmUVKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Feb 2024 10:42:24 +0000
Date: Fri, 09 Feb 2024 11:42:24 +0100
Message-ID: <87v86x2a27.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v14 32/53] ALSA: usb-audio: Check for support for requested audio format
In-Reply-To: <20240208231406.27397-33-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
	<20240208231406.27397-33-quic_wcheng@quicinc.com>
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
X-Spam-Level: *
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[18.54%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLjs3ec4aura4kmsd6wxjjm4hg)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri, 09 Feb 2024 00:13:45 +0100,
Wesley Cheng wrote:
> 
> Allow for checks on a specific USB audio device to see if a requested PCM
> format is supported.  This is needed for support when playback is
> initiated by the ASoC USB backend path.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  sound/usb/card.c | 31 +++++++++++++++++++++++++++++++
>  sound/usb/card.h | 11 +++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 7dc8007ba839..1ad99a462038 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -155,6 +155,37 @@ int snd_usb_unregister_platform_ops(void)
>  }
>  EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
>  
> +/*
> + * Checks to see if requested audio profile, i.e sample rate, # of
> + * channels, etc... is supported by the substream associated to the
> + * USB audio device.
> + */
> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction)
> +{
> +	struct snd_usb_audio *chip;
> +	struct snd_usb_substream *subs;
> +	struct snd_usb_stream *as;
> +
> +	/*
> +	 * Register mutex is held when populating and clearing usb_chip
> +	 * array.
> +	 */
> +	guard(mutex)(&register_mutex);
> +	chip = usb_chip[card_idx];
> +
> +	if (chip && enable[card_idx]) {
> +		list_for_each_entry(as, &chip->pcm_list, list) {
> +			subs = &as->substream[direction];
> +			if (snd_usb_find_substream_format(subs, params))
> +				return as;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
> +
>  /*
>   * disconnect streams
>   * called from usb_audio_disconnect()
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 02e4ea898db5..ed4a664e24e5 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -217,4 +217,15 @@ struct snd_usb_platform_ops {
>  
>  int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
>  int snd_usb_unregister_platform_ops(void);
> +
> +#if IS_ENABLED(CONFIG_SND_USB_AUDIO)
> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction);
> +#else
> +static struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> +			struct snd_pcm_hw_params *params, int direction)
> +{
> +	return NULL;
> +}
> +#endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */

The usefulness of ifdef guard here is doubtful, IMO.  This header is
only for USB-audio driver enablement, and not seen as generic
helpers.  So, just add the new function declarations without dummy
definitions.


thanks,

Takashi

