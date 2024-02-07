Return-Path: <linux-kernel+bounces-56056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6084C571
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DEB1C255A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83801F922;
	Wed,  7 Feb 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pMEPN5i+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2Y1DwWSj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BVXP1nkI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CfugtL1Q"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B81200A8;
	Wed,  7 Feb 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289520; cv=none; b=Zm3XlE8+UXdgv52WNv9hLy6uxgD/3KO/YxyolVYIghU3XFPSqgtlMOVu9NesT6oU+4hWIEMv32RzoKorEyaDPAsk2tc1EwSy9TRDA/ADPGyB2CXaCVSvTvHEGKVNd8aVKiPEUI9fM2yuxv1wgIlzH9KolSWEsAvGmB93ruuclWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289520; c=relaxed/simple;
	bh=EXW6XWWmdQH4JwkwGz7Ylm1fbJKRhblA7kQzzwKv14I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbsec2WnUKBu9KVuLo4jcYVSw2N9pY2s2r7bNQcpZHYBmXlZOrKLOrW4ve7vvhxjX9l9XiE5IpY2MKrqtg7IYLeLwyhK8IOs53R5YqveozruZLaFtPfUtBQllU6BhXgD00gndNsMnnzJPpgm9sUj1dpouhL1DrmGwDUVnjnUcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pMEPN5i+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2Y1DwWSj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BVXP1nkI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CfugtL1Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E21512216B;
	Wed,  7 Feb 2024 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707289517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8HJIOCuzaPdkBcXNr239npB0JKRrCXPsquj3JkdNAPI=;
	b=pMEPN5i+Lu13GC+jWqQ3jk1LNuadyRVmDLOj4pSTFtN6HXPyyJrtX6vdoq7OdTBKiKchz4
	ofpCwJoMZK9IZi7/hamp+jN3BmCmeJl5NCaPL+/o76VZ6e6xSa0e75RCmR0JfEWX91nH43
	krgyk298FzhRTX6CQq0y/zb9ZL/n6WQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707289517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8HJIOCuzaPdkBcXNr239npB0JKRrCXPsquj3JkdNAPI=;
	b=2Y1DwWSjCHRMwvgkzLcepI3bRq3b/rRwT1ana8e2fhUzTIepWs66oNzfG2vmsGy+xoQh+P
	G8zPS9jHT+voqkAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707289516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8HJIOCuzaPdkBcXNr239npB0JKRrCXPsquj3JkdNAPI=;
	b=BVXP1nkIDhCAx9Q5usIsQZNU6udEKJoNd64DEFApskn0IGl1EALHtmjrllSS2awdUJeTvc
	t6tPxNaMMgawjDkqj7bOtgg369T517B1NbbfW35mIPv6H+esmBJqHEpVsvspCAwpzhiUy/
	LQXNEBRQQMc1y6GnIiCmocHBO8pbkMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707289516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8HJIOCuzaPdkBcXNr239npB0JKRrCXPsquj3JkdNAPI=;
	b=CfugtL1QerC0Mii2wg1EJXe7pyXSl8GuKx7QtIMPXxxvhJaCyNmcex+gJS+FLZDcuCDCvt
	Lt7lMDGchRhPdCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43587139D8;
	Wed,  7 Feb 2024 07:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TiDJDqwrw2XfLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Feb 2024 07:05:16 +0000
Date: Wed, 07 Feb 2024 08:05:15 +0100
Message-ID: <877cjg7o0k.wl-tiwai@suse.de>
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
In-Reply-To: <ef83036f-6605-1db3-d962-ac28a10711ac@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
	<20240203023645.31105-36-quic_wcheng@quicinc.com>
	<87y1bxvj0o.wl-tiwai@suse.de>
	<ef83036f-6605-1db3-d962-ac28a10711ac@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BVXP1nkI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CfugtL1Q
X-Spamd-Result: default: False [-4.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E21512216B
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Wed, 07 Feb 2024 01:08:00 +0100,
Wesley Cheng wrote:
> 
> Hi Takashi,
> 
> On 2/6/2024 5:07 AM, Takashi Iwai wrote:
> > On Sat, 03 Feb 2024 03:36:27 +0100,
> > Wesley Cheng wrote:
> >> 
> >> With USB audio offloading, an audio session is started from the ASoC
> >> platform sound card and PCM devices.  Likewise, the USB SND path is still
> >> readily available for use, in case the non-offload path is desired.  In
> >> order to prevent the two entities from attempting to use the USB bus,
> >> introduce a flag that determines when either paths are in use.
> >> 
> >> If a PCM device is already in use, the check will return an error to
> >> userspace notifying that the stream is currently busy.  This ensures that
> >> only one path is using the USB substream.
> >> 
> >> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > 
> > Hm, I'm not sure whether it's safe to hold chip->mutex there for the
> > long code path.  It even kicks off the auto-resume, which may call
> > various functions at resuming, and some of them may re-hold
> > chip->mutex.
> > 
> 
> That's a good point.
> 
> > If it's only about the open flag, protect only the flag access with
> > the mutex, not covering the all open function.  At least the re-entry
> > can be avoided by that.
> > 
> 
> Sure, let me re-order the check/assignment and the mutex locking.
> Since this is now checked here in USB PCM and the QC offload driver,
> we want to make sure that if there was some application attempting to
> open both at the same time, we prevent any possible races.
> 
> I think the best way to address this would be something like:
> 
> static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
> {
> ...
> 	mutex_lock(&chip->mutex);
> 	if (subs->opened) {
> 		mutex_unlock(&chip->mutex);
> 		return -EBUSY;
> 	}
> 	subs->opened = 1;
> 	mutex_unlock(&chip->mutex);
> 
> //Execute bulk of PCM open routine
> ...
> 	return 0;
> 
> // If any errors are seen, unwind
> err_resume:
> 	snd_usb_autosuspend(subs->stream->chip);
> err_open:
> 	mutex_lock(&chip->mutex);
> 	subs->opened = 0;
> 	mutex_unlock(&chip->mutex);
> 
> 	return ret;
> }
> 
> Set the opened flag first, so that if QC offload checks it, it can
> exit early and vice versa.  Otherwise, if we set the opened flag at
> the same position as the previous patch, we may be calling the other
> routines in parallel to the QC offload enable stream routine.  The
> only thing with this patch is that we'd need some error handling
> unwinding.

The above is what I had in mind.

But, thinking on this again, you might be able to get the same result
by using the ALSA PCM core substream open_mutex and hw_opened flag.
This is already held and set at snd_pcm_core() (the hw_opened flag is
set after open callback, though).  The offload driver can use those
instead of the own lock and flag, too, although it's not really
well-mannered behavior (hence you need proper comments).


thanks,

Takashi

