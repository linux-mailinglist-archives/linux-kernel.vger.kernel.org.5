Return-Path: <linux-kernel+bounces-57621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7465384DB81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64A2B21097
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE96A8B4;
	Thu,  8 Feb 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XwxPSA/r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i6LLynjM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XwxPSA/r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i6LLynjM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100C1E4A8;
	Thu,  8 Feb 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381243; cv=none; b=fpDF0WFdriZuL0HRNSHY6ftoq5o7ACPi+L6PoIieB9Wue79fQQ6UTWsD0lK5IfpH8bZHtztRTiLqv5K1rYzarioiu3MRLYWpdi/MnZ2nQKkFYWj0Rqm9B8HQaB/K3mogmitUSIu8yVoocR0OF6VZDlw101JnlZt3NMxI66ndqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381243; c=relaxed/simple;
	bh=yQIpBBEIxx4/IIjfHNRw5tmPHKF8fKnfitNKVQcauKM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDbqNcXkKCeYR3DvnxoxX02+7ZU4xKBiqxmKwmInSd38DUzEsVjSrNos98oaeiUGsDvfmGVSoUgnfjIvSP5+E5plPMmTcIboAnX0t/gOVGITw6EbWfZTYuJNYrt+TONfq5YqxOTXRxNRDx0eZeMsWM6O4ylFQgf5SFVzeBVkpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XwxPSA/r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i6LLynjM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XwxPSA/r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i6LLynjM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AE3B1FCA1;
	Thu,  8 Feb 2024 08:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707381239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fs8rzxLNmwlqkJjO3hZMPEHaTXcNfexMZfLhq/hjgdw=;
	b=XwxPSA/rqRdkAUNLQ/eUO8vFDXbq1aFN8h/uaNasK1TfkwxIBlQhi2TAE8i8L3H+1t88Vk
	76PfcZZ7PnA/fQeEftPJ6rFfxrb7AQF3D+799ZSE/r4WSzPLean+TQ6JiGGePIZRDKE+07
	rhC6rZi823vuLFBW0VXgVbERTTJw5wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707381239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fs8rzxLNmwlqkJjO3hZMPEHaTXcNfexMZfLhq/hjgdw=;
	b=i6LLynjMBh/8H/AooDcHNVFovAsslhIUYIayIg3A/Vx8vg0BQmtFCwuR2NPT6hyBMTTSgw
	ImtDrMVHWMH6RNBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707381239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fs8rzxLNmwlqkJjO3hZMPEHaTXcNfexMZfLhq/hjgdw=;
	b=XwxPSA/rqRdkAUNLQ/eUO8vFDXbq1aFN8h/uaNasK1TfkwxIBlQhi2TAE8i8L3H+1t88Vk
	76PfcZZ7PnA/fQeEftPJ6rFfxrb7AQF3D+799ZSE/r4WSzPLean+TQ6JiGGePIZRDKE+07
	rhC6rZi823vuLFBW0VXgVbERTTJw5wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707381239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fs8rzxLNmwlqkJjO3hZMPEHaTXcNfexMZfLhq/hjgdw=;
	b=i6LLynjMBh/8H/AooDcHNVFovAsslhIUYIayIg3A/Vx8vg0BQmtFCwuR2NPT6hyBMTTSgw
	ImtDrMVHWMH6RNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDBCD1326D;
	Thu,  8 Feb 2024 08:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /uiqOPaRxGWSIAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 08 Feb 2024 08:33:58 +0000
Date: Thu, 08 Feb 2024 09:33:58 +0100
Message-ID: <87zfwb4ao9.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v13 35/53] ALSA: usb-audio: Prevent starting of audio stream if in use
In-Reply-To: <0cb39613-ec01-50aa-807f-b537f201dac0@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
	<20240203023645.31105-36-quic_wcheng@quicinc.com>
	<87y1bxvj0o.wl-tiwai@suse.de>
	<ef83036f-6605-1db3-d962-ac28a10711ac@quicinc.com>
	<877cjg7o0k.wl-tiwai@suse.de>
	<810161b3-4d98-755f-163f-fdfc9fe37063@quicinc.com>
	<0cb39613-ec01-50aa-807f-b537f201dac0@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.40
X-Spamd-Result: default: False [1.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
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
X-Spam-Flag: NO

On Thu, 08 Feb 2024 02:12:00 +0100,
Wesley Cheng wrote:
> 
> Hi Takashi,
> 
> On 2/7/2024 4:02 PM, Wesley Cheng wrote:
> > Hi Takashi,
> > 
> > On 2/6/2024 11:05 PM, Takashi Iwai wrote:
> >> On Wed, 07 Feb 2024 01:08:00 +0100,
> >> Wesley Cheng wrote:
> >>> 
> >>> Hi Takashi,
> >>> 
> >>> On 2/6/2024 5:07 AM, Takashi Iwai wrote:
> >>>> On Sat, 03 Feb 2024 03:36:27 +0100,
> >>>> Wesley Cheng wrote:
> >>>>> 
> >>>>> With USB audio offloading, an audio session is started from the ASoC
> >>>>> platform sound card and PCM devices.  Likewise, the USB SND path
> >>>>> is still
> >>>>> readily available for use, in case the non-offload path is
> >>>>> desired.  In
> >>>>> order to prevent the two entities from attempting to use the USB bus,
> >>>>> introduce a flag that determines when either paths are in use.
> >>>>> 
> >>>>> If a PCM device is already in use, the check will return an error to
> >>>>> userspace notifying that the stream is currently busy.  This
> >>>>> ensures that
> >>>>> only one path is using the USB substream.
> >>>>> 
> >>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> >>>> 
> >>>> Hm, I'm not sure whether it's safe to hold chip->mutex there for the
> >>>> long code path.  It even kicks off the auto-resume, which may call
> >>>> various functions at resuming, and some of them may re-hold
> >>>> chip->mutex.
> >>>> 
> >>> 
> >>> That's a good point.
> >>> 
> >>>> If it's only about the open flag, protect only the flag access with
> >>>> the mutex, not covering the all open function.  At least the re-entry
> >>>> can be avoided by that.
> >>>> 
> >>> 
> >>> Sure, let me re-order the check/assignment and the mutex locking.
> >>> Since this is now checked here in USB PCM and the QC offload driver,
> >>> we want to make sure that if there was some application attempting to
> >>> open both at the same time, we prevent any possible races.
> >>> 
> >>> I think the best way to address this would be something like:
> >>> 
> >>> static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
> >>> {
> >>> ...
> >>>     mutex_lock(&chip->mutex);
> >>>     if (subs->opened) {
> >>>         mutex_unlock(&chip->mutex);
> >>>         return -EBUSY;
> >>>     }
> >>>     subs->opened = 1;
> >>>     mutex_unlock(&chip->mutex);
> >>> 
> >>> //Execute bulk of PCM open routine
> >>> ...
> >>>     return 0;
> >>> 
> >>> // If any errors are seen, unwind
> >>> err_resume:
> >>>     snd_usb_autosuspend(subs->stream->chip);
> >>> err_open:
> >>>     mutex_lock(&chip->mutex);
> >>>     subs->opened = 0;
> >>>     mutex_unlock(&chip->mutex);
> >>> 
> >>>     return ret;
> >>> }
> >>> 
> >>> Set the opened flag first, so that if QC offload checks it, it can
> >>> exit early and vice versa.  Otherwise, if we set the opened flag at
> >>> the same position as the previous patch, we may be calling the other
> >>> routines in parallel to the QC offload enable stream routine.  The
> >>> only thing with this patch is that we'd need some error handling
> >>> unwinding.
> >> 
> >> The above is what I had in mind.
> >> 
> >> But, thinking on this again, you might be able to get the same result
> >> by using the ALSA PCM core substream open_mutex and hw_opened flag.
> >> This is already held and set at snd_pcm_core() (the hw_opened flag is
> >> set after open callback, though).  The offload driver can use those
> >> instead of the own lock and flag, too, although it's not really
> >> well-mannered behavior (hence you need proper comments).
> >> 
> > 
> > I think I had looked into this as well previously, and it was
> > difficult to achieve, because from the USB offloading perspective,
> > we don't ever call: snd_usb_pcm_open()
> > 
> > This is actually where we populate the pcm_substream parameter
> > within struct snd_usb_substream based on when userspace opens the
> > USB SND PCM device (which is not the case for offloading).  So the
> > offload driver doesn't have a way to fetch the struct snd_pcm that
> > is allocated to the PCM device created by the USB SND card.
> > 
> 
> Sorry, took a look at it again, and found a way.  Although not pretty,
> we can access it using:
> subs->stream->pcm->streams[direction].substream->hw_opened

Yes, it's not easy to follow it.  So if we want to this path, worth
for a detailed comment.  That said, I don't mind to introduce the new
local mutex and flag as you did if the above became too messy in the
end.


thanks,

Takashi

