Return-Path: <linux-kernel+bounces-56052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D484C55C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C2A1F2655F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99E1F944;
	Wed,  7 Feb 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AaqypUD/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="854zUxh0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AaqypUD/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="854zUxh0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23B1CFAF;
	Wed,  7 Feb 2024 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289219; cv=none; b=DQ2M1/ONG63hLRVj+KM6TMWN4/RmwmP1D3QZsy+GyMG+mRLZRA8clD0lLedjqIxoE9cr4IbISMvW798IruvIhipINpuyL0cMhD8o8z2/YXQXB6xw7XzPuRxff0SZa+2Qs0Am68ayj/MJEhLDmQypLqrRANt9qgL2e88yk/s2VFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289219; c=relaxed/simple;
	bh=v7msrzpyw2ptuE2fVKl5DgGja6IcIfOGzZaserJmkIY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IogYYbC0WVS1xK7Bf003ce32ZRVddOZm52jRd8oI5osOvLJ1mfHy5hESHLnGGiF8n36v8UP6Rt99mUWR/dxSCRDcG1Iv88KDFLTKYa1VhAisTjhiplJ86h2nMzCZ5//GaBhdGcgbSLFBmJSkNvERM0VgdjqwRhP16x4V3SpTTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AaqypUD/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=854zUxh0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AaqypUD/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=854zUxh0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 679411F456;
	Wed,  7 Feb 2024 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707289202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq3JEuDRzhumdt/uENPOAy/8jwo374BpY8aqwtGc6x4=;
	b=AaqypUD/ThwT5mQhX1+4Zyy1K1xtovP5sTiL+EQppv/EeGB13qVbepfFo0E9GsHdhVt1xv
	JqBzZ3vqCuUk9uD+ig0PLJSOqmZXVy0w3ELqzQe+DhedjpT0lJgRHtXGErbVi3ZVltkhyp
	L7GkqQFhYAZ4D7XlgW/tydX9Xr92ogM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707289202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq3JEuDRzhumdt/uENPOAy/8jwo374BpY8aqwtGc6x4=;
	b=854zUxh0IZJu0GRTU3i/YEtzchcM+UVIokiuwRAsnvtvh6v6zTdgm2w9BkaiOhAb0IWf1a
	8QzZZcpnWnF631Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707289202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq3JEuDRzhumdt/uENPOAy/8jwo374BpY8aqwtGc6x4=;
	b=AaqypUD/ThwT5mQhX1+4Zyy1K1xtovP5sTiL+EQppv/EeGB13qVbepfFo0E9GsHdhVt1xv
	JqBzZ3vqCuUk9uD+ig0PLJSOqmZXVy0w3ELqzQe+DhedjpT0lJgRHtXGErbVi3ZVltkhyp
	L7GkqQFhYAZ4D7XlgW/tydX9Xr92ogM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707289202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq3JEuDRzhumdt/uENPOAy/8jwo374BpY8aqwtGc6x4=;
	b=854zUxh0IZJu0GRTU3i/YEtzchcM+UVIokiuwRAsnvtvh6v6zTdgm2w9BkaiOhAb0IWf1a
	8QzZZcpnWnF631Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEDDF139D8;
	Wed,  7 Feb 2024 07:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id weg+NXEqw2XlKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Feb 2024 07:00:01 +0000
Date: Wed, 07 Feb 2024 08:00:01 +0100
Message-ID: <878r3w7o9a.wl-tiwai@suse.de>
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
In-Reply-To: <dbe544de-dc04-59a8-6642-883fc00214f3@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
	<20240203023645.31105-49-quic_wcheng@quicinc.com>
	<871q9pwy0l.wl-tiwai@suse.de>
	<dbe544de-dc04-59a8-6642-883fc00214f3@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="AaqypUD/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=854zUxh0
X-Spamd-Result: default: False [2.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.03)[56.23%];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.16
X-Rspamd-Queue-Id: 679411F456
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

On Wed, 07 Feb 2024 02:24:46 +0100,
Wesley Cheng wrote:
> 
> Hi Takashi,
> 
> On 2/6/2024 4:57 AM, Takashi Iwai wrote:
> > On Sat, 03 Feb 2024 03:36:40 +0100,
> > Wesley Cheng wrote:
> >> 
> >> In order to allow userspace/applications know about USB offloading status,
> >> expose a sound kcontrol that fetches information about which sound card
> >> index is associated with the ASoC platform card supporting offloading.  In
> >> the USB audio offloading framework, the ASoC BE DAI link is the entity
> >> responsible for registering to the SOC USB layer.  SOC USB will expose more
> >> details about the current offloading status, which includes the USB sound
> >> card and USB PCM device indexes currently being used.
> >> 
> >> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > 
> > The concept is understandable, but the control element name ("SNDUSB
> > OFFLD playback available") looks non-intrusive and non-conformant.
> > Use a bit more understandable name instead.
> > 
> > This provides a card number where the offload driver is bound, and the
> > name should indicate something about that.
> > 
> 
> Hmmm, does USB sound have a naming convention that it usually follows
> for mixer/control interfaces?

The old rule is found in Documentation/sound/designs/control-names.rst
(although the prefix and the suffix are often dropped for non-standard
controls).

> For something that is more closely related, how about:
> "USB offload capable card"

Yes, it looks better.  But usually each word begins with an upper
letter.


Takashi

