Return-Path: <linux-kernel+bounces-55150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB784B8C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0192B2F445
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219B1332B8;
	Tue,  6 Feb 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gd8XC4jH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KlIBRPwB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gd8XC4jH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KlIBRPwB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FD131E40;
	Tue,  6 Feb 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231228; cv=none; b=bOheV+cEtcACrHeEY02/BeBb7Z6fSETI7TucQOUvqWFGBBg3pOjpVR+ojav6qWVyFZyTwcYLWSc0vMI/RN0b5d8oVI0OoGTRzjNWHNHAg9ipLmk7JDm3iyXIE6vMBP6co8gDoaJaauf3lWL7ysRccaRmhACV9ofWSkkHvPM+x5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231228; c=relaxed/simple;
	bh=6imiZNz13DtNsVm7OhjM91Tu6n6+upch3RjcbTaBXbo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo0s8OlMXUSr3/VFrf7GUAHVWrnDJ5Sg36Im770oJdFgQcpZRi1bKj6kMO3cJ9CtzrlPOkZo1gsp9EXDq0oS68sB8AX10gRo9ulbSRXVVaRCcXnP6M5HvYo7JqUKPqY4baLaVev3V4DXwDjYOQZxczQW7jLuIaInVyhRbaYdMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gd8XC4jH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KlIBRPwB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gd8XC4jH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KlIBRPwB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 890D8220AD;
	Tue,  6 Feb 2024 14:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707231224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGImGG0Ff6z25ekPfLY3b5KTypKA7hNz0dlcxRASQs=;
	b=Gd8XC4jHmAO2wIh9frwlto9XxCy5MYvJewPaeif1JTc76zhIL49XXS+ftX3Nrk5y5F+0Ib
	kb8zevdT/b2sOVr+QUkTw6EwrWVxuckdhiafBvDzV0N9OaXfGzC/QBrFNDJJRGXPG3Gu2Q
	6w5NhzyGSL+gLom0GAbnm4gRoV5pe20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707231224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGImGG0Ff6z25ekPfLY3b5KTypKA7hNz0dlcxRASQs=;
	b=KlIBRPwBqPNyqo9m1MMtV8YIVgZTYkqY4/WYuTbYOsetUNgX+vC8/51oPkoo8pHPgzYyZX
	CNIYGmYF15FKqCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707231224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGImGG0Ff6z25ekPfLY3b5KTypKA7hNz0dlcxRASQs=;
	b=Gd8XC4jHmAO2wIh9frwlto9XxCy5MYvJewPaeif1JTc76zhIL49XXS+ftX3Nrk5y5F+0Ib
	kb8zevdT/b2sOVr+QUkTw6EwrWVxuckdhiafBvDzV0N9OaXfGzC/QBrFNDJJRGXPG3Gu2Q
	6w5NhzyGSL+gLom0GAbnm4gRoV5pe20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707231224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEGImGG0Ff6z25ekPfLY3b5KTypKA7hNz0dlcxRASQs=;
	b=KlIBRPwBqPNyqo9m1MMtV8YIVgZTYkqY4/WYuTbYOsetUNgX+vC8/51oPkoo8pHPgzYyZX
	CNIYGmYF15FKqCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46FC3139D8;
	Tue,  6 Feb 2024 14:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K0myEPhHwmUiVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 06 Feb 2024 14:53:44 +0000
Date: Tue, 06 Feb 2024 15:53:43 +0100
Message-ID: <87sf25wsnc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
	srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com,
	perex@perex.cz,
	conor+dt@kernel.org,
	corbet@lwn.net,
	lgirdwood@gmail.com,
	andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
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
Subject: Re: [PATCH v13 32/53] ALSA: usb-audio: Check for support for requested audio format
In-Reply-To: <2024020617-limb-name-f852@gregkh>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
	<20240203023645.31105-33-quic_wcheng@quicinc.com>
	<87wmrhvir7.wl-tiwai@suse.de>
	<2024020617-limb-name-f852@gregkh>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Gd8XC4jH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KlIBRPwB
X-Spamd-Result: default: False [2.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_HAM(-0.08)[63.26%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[quicinc.com,linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,synopsys.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.11
X-Rspamd-Queue-Id: 890D8220AD
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Tue, 06 Feb 2024 15:50:21 +0100,
Greg KH wrote:
> 
> On Tue, Feb 06, 2024 at 02:12:44PM +0100, Takashi Iwai wrote:
> > On Sat, 03 Feb 2024 03:36:24 +0100,
> > Wesley Cheng wrote:
> > > 
> > > Allow for checks on a specific USB audio device to see if a requested PCM
> > > format is supported.  This is needed for support when playback is
> > > initiated by the ASoC USB backend path.
> > > 
> > > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > 
> > Just cosmetic:
> > 
> > > +struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
> > > +			struct snd_pcm_hw_params *params, int direction)
> > > +{
> > > +	struct snd_usb_audio *chip;
> > > +	struct snd_usb_substream *subs;
> > > +	struct snd_usb_stream *as;
> > > +	const struct audioformat *fmt;
> > > +
> > > +	/*
> > > +	 * Register mutex is held when populating and clearing usb_chip
> > > +	 * array.
> > > +	 */
> > > +	mutex_lock(&register_mutex);
> > > +	chip = usb_chip[card_idx];
> > > +	if (!chip) {
> > > +		mutex_unlock(&register_mutex);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	if (enable[card_idx]) {
> > > +		list_for_each_entry(as, &chip->pcm_list, list) {
> > > +			subs = &as->substream[direction];
> > > +			fmt = snd_usb_find_substream_format(subs, params);
> > > +			if (fmt) {
> > > +				mutex_unlock(&register_mutex);
> > > +				return as;
> > > +			}
> > > +		}
> > > +	}
> > > +	mutex_unlock(&register_mutex);
> > 
> > I prefer having the single lock/unlock call pair, e.g.
> > 
> > 	struct snd_usb_stream *as, *ret;
> > 
> > 	ret = NULL;
> > 	mutex_lock(&register_mutex);
> > 	chip = usb_chip[card_idx];
> > 	if (chip && enable[card_idx]) {
> > 		list_for_each_entry(as, &chip->pcm_list, list) {
> > 			subs = &as->substream[direction];
> > 			if (snd_usb_find_substream_format(subs, params)) {
> > 				ret = as;
> > 				break;
> > 			}
> > 		}
> > 	}
> > 	mutex_unlock(&register_mutex);
> > 	return ret;
> > }
> > 
> > In this case, we shouldn't reuse "as" for the return value since it
> > can be non-NULL after the loop end.
> 
> Why not just use guard(mutex) for this, making it all not an issue?

Heh, it's too new ;)
That should work gracefully, yes.


Takashi

