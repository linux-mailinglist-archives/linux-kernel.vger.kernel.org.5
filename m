Return-Path: <linux-kernel+bounces-69788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D987858E94
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBE1B21775
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848011DDFC;
	Sat, 17 Feb 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TurgWrWS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nBmFB/jt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TurgWrWS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nBmFB/jt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566F1C15;
	Sat, 17 Feb 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164504; cv=none; b=Mb5uroxbVDJ7KGC04EaDZfy7iWGMt1j3AHUOvPYgwZrPGrdPdUJ6BgGVi41KlG1LmlRMJmi597MNIeZpwVD4LqvfGsmHbDwyWrnPgOY8psmh1UlHmTlgbbZOzzJa2+QohNZ6dHuSQ+xGt2SyYwTqfHrjDZq6NnkaoxqGoAVuxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164504; c=relaxed/simple;
	bh=5yOrl7ejMhiYLXAozx5kVTkg0b8+HpBur90WSH3AXco=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1S0VvDmU3efaQF1DysTJ/UXLYsIQIAhiLuTiqtR5Ral7p9rRhk8DFu4N0wfRkZeFsgrHEyqxw0Xacq0JEQ7JEWv8W7R4+EOf7/qVRdWGt0CsXaqkiK6SJY5OICKNaUMxq5Vrq/YKKyQ4KRt7UEQwhALwpS1Dm/kh7wu1Zictrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TurgWrWS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nBmFB/jt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TurgWrWS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nBmFB/jt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E5B91F7B9;
	Sat, 17 Feb 2024 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708164500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRWhyrNas2ODukH8hQrcMU98AhP1T7F4SpR72WFtrc4=;
	b=TurgWrWSWcb/osb//n0APh3TG7biuluETL6+NAmXRJdiEywHbYvYtQkP5moBy39K9ZTb+a
	lwNW1R8tUrJsHHp7mUGG9RTvhMsN1jJ7C3RnF0Sl5zdJP+l9l4UyM6YBwPfGLoXx4yUjbu
	+3Nh266T0ViYlUg9REBTXCvMR+RjK6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708164500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRWhyrNas2ODukH8hQrcMU98AhP1T7F4SpR72WFtrc4=;
	b=nBmFB/jt4FpRyUSvQfBP4fDZWAnf/yFyC00wcyQogqtxiKJktLn7+U5D+xjFkyVUJT0QF/
	u3MXX+2LHXy7V9BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708164500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRWhyrNas2ODukH8hQrcMU98AhP1T7F4SpR72WFtrc4=;
	b=TurgWrWSWcb/osb//n0APh3TG7biuluETL6+NAmXRJdiEywHbYvYtQkP5moBy39K9ZTb+a
	lwNW1R8tUrJsHHp7mUGG9RTvhMsN1jJ7C3RnF0Sl5zdJP+l9l4UyM6YBwPfGLoXx4yUjbu
	+3Nh266T0ViYlUg9REBTXCvMR+RjK6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708164500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRWhyrNas2ODukH8hQrcMU98AhP1T7F4SpR72WFtrc4=;
	b=nBmFB/jt4FpRyUSvQfBP4fDZWAnf/yFyC00wcyQogqtxiKJktLn7+U5D+xjFkyVUJT0QF/
	u3MXX+2LHXy7V9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A05C21370C;
	Sat, 17 Feb 2024 10:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U3N8JZOF0GV+JgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 17 Feb 2024 10:08:19 +0000
Date: Sat, 17 Feb 2024 11:08:19 +0100
Message-ID: <87y1bjpfn0.wl-tiwai@suse.de>
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
In-Reply-To: <7f0c4f85-5a63-4643-8553-e3f5d6af67ec@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
	<20240208231406.27397-33-quic_wcheng@quicinc.com>
	<87v86x2a27.wl-tiwai@suse.de>
	<cb3b7857-dc6c-80db-4fa7-6772a856f328@quicinc.com>
	<7f0c4f85-5a63-4643-8553-e3f5d6af67ec@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TurgWrWS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="nBmFB/jt"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,quicinc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 4E5B91F7B9
X-Spam-Flag: NO

On Sat, 17 Feb 2024 00:42:18 +0100,
Wesley Cheng wrote:
> 
> Hi Takashi,
> 
> On 2/9/2024 1:34 PM, Wesley Cheng wrote:
> > Hi Takashi,
> > 
> > On 2/9/2024 2:42 AM, Takashi Iwai wrote:
> >> On Fri, 09 Feb 2024 00:13:45 +0100,
> >> Wesley Cheng wrote:
> >>> 
> >>> Allow for checks on a specific USB audio device to see if a
> >>> requested PCM
> >>> format is supported.  This is needed for support when playback is
> >>> initiated by the ASoC USB backend path.
> >>> 
> >>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> >>> ---
> >>>   sound/usb/card.c | 31 +++++++++++++++++++++++++++++++
> >>>   sound/usb/card.h | 11 +++++++++++
> >>>   2 files changed, 42 insertions(+)
> >>> 
> >>> diff --git a/sound/usb/card.c b/sound/usb/card.c
> >>> index 7dc8007ba839..1ad99a462038 100644
> >>> --- a/sound/usb/card.c
> >>> +++ b/sound/usb/card.c
> >>> @@ -155,6 +155,37 @@ int snd_usb_unregister_platform_ops(void)
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
> >>> +/*
> >>> + * Checks to see if requested audio profile, i.e sample rate, # of
> >>> + * channels, etc... is supported by the substream associated to the
> >>> + * USB audio device.
> >>> + */
> >>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> >>> +            struct snd_pcm_hw_params *params, int direction)
> >>> +{
> >>> +    struct snd_usb_audio *chip;
> >>> +    struct snd_usb_substream *subs;
> >>> +    struct snd_usb_stream *as;
> >>> +
> >>> +    /*
> >>> +     * Register mutex is held when populating and clearing usb_chip
> >>> +     * array.
> >>> +     */
> >>> +    guard(mutex)(&register_mutex);
> >>> +    chip = usb_chip[card_idx];
> >>> +
> >>> +    if (chip && enable[card_idx]) {
> >>> +        list_for_each_entry(as, &chip->pcm_list, list) {
> >>> +            subs = &as->substream[direction];
> >>> +            if (snd_usb_find_substream_format(subs, params))
> >>> +                return as;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    return NULL;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
> >>> +
> >>>   /*
> >>>    * disconnect streams
> >>>    * called from usb_audio_disconnect()
> >>> diff --git a/sound/usb/card.h b/sound/usb/card.h
> >>> index 02e4ea898db5..ed4a664e24e5 100644
> >>> --- a/sound/usb/card.h
> >>> +++ b/sound/usb/card.h
> >>> @@ -217,4 +217,15 @@ struct snd_usb_platform_ops {
> >>>   int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
> >>>   int snd_usb_unregister_platform_ops(void);
> >>> +
> >>> +#if IS_ENABLED(CONFIG_SND_USB_AUDIO)
> >>> +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> >>> +            struct snd_pcm_hw_params *params, int direction);
> >>> +#else
> >>> +static struct snd_usb_stream
> >>> *snd_usb_find_suppported_substream(int card_idx,
> >>> +            struct snd_pcm_hw_params *params, int direction)
> >>> +{
> >>> +    return NULL;
> >>> +}
> >>> +#endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
> >> 
> >> The usefulness of ifdef guard here is doubtful, IMO.  This header is
> >> only for USB-audio driver enablement, and not seen as generic
> >> helpers.  So, just add the new function declarations without dummy
> >> definitions.
> >> 
> > 
> > Got it, will remove it.  We also have a dependency in place for the
> > qc_audio_offload driver and SND USB AUDIO in the Kconfig.
> > 
> 
> Looking at this again after trying some mixed Kconfig settings.  These
> declarations aren't specific for USB-audio.  They are helpers that are
> exposed to soc usb, so that it can do some basic verification with soc
> usb before allowing the enable stream to continue.

Then rather the question is why snd-soc-usb calls those functions
*unconditionally*.  No matter whether we have dependencies in Kconfig,
calling the function means that the callee shall be drug when the
corresponding code is running.

If it were generic core API stuff such as power-management or ACPI,
it'd make sense to define dummy functions without the enablement, as
many code may have optional calls.  If the API is enabled, it's anyway
in the core.  If not, it's optional.  That'll be fine.

OTOH, the stuff you're calling certainly belongs to snd-usb-audio.
Even if the call is really optional, it means that you'll have a hard
dependency when snd-usb-audio is built, no matter whether you need or
not.

> Since the ASoC
> layer doesn't have insight on what audio profiles are supported by the
> usb device, this API will ensure that the request profile is
> supported.
>
> Issues are seen when we disable SND USB audio config and enable the
> ASoC parts.

If snd-usb-audio is disabled, what snd-soc-usb would serve at all?
Does it still make sense to keep it enabled? 
That said, the statement above (building snd-soc-usb without
snd-usb-audio) looks already dubious; isn't it better to have a proper
dependency in Kconfig, instead?


thanks,

Takashi

