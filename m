Return-Path: <linux-kernel+bounces-63484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DB885303E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C2C28A8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D723D0CF;
	Tue, 13 Feb 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e7Tq9gZ8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F5PgQKCV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wy7iPzij";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0teH5P3w"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177638DD5;
	Tue, 13 Feb 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826234; cv=none; b=gj+3AR3sbeQQAdqTTv0hkBLFcbY5cENIEwxvVnYJj4tRqwjA6qOcBxKfpSmsor7ZkorIiEbZbtEU6sPipSFp5eR8CwtZSsRoZRAn3C8Q+1rluST3cJhsVelU5OPjyF2LA4pwV3+ADpp+jkx40fPwTg2OJuvSj73pNx7dvQ4GBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826234; c=relaxed/simple;
	bh=d2Ou20cP8XYlBETKi59cPtNyA6wJ/IizK+37DPPH+lk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hin2IcRe5WlEA7HV91ZGXh22fj609/m73EJ4Zvo2HkgHmaxTDaNJQo6JGLEngFvq6emasr1nWWO8aAVFQanFy85PZnwjZcaGN26F9qKDcJkJuNkjg5tVVSuAJXkM/5RvjT+GF6BUpoDZNNgX5X1xc++XmF44l7x5tQbxjUBT/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e7Tq9gZ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F5PgQKCV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wy7iPzij; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0teH5P3w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E00B422203;
	Tue, 13 Feb 2024 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707826225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7TZDFydWHl6WRFqmAy6Kwi1dhKU2+NmuD788mtOIC8=;
	b=e7Tq9gZ8Cf8/2YdJzlYGZ8Yor99+jZfkVS5C6CNpXg+wM2mcL100PR4WrG2QB2PHPsnzqW
	5afm/XD+hoeDdi6klqonKXFktnbZwfYbFJTuHttQPPFAHthxMfUfSLY/++OytMAzy08omt
	tHHPR663G2ESiDGV/biQo0Gu3Wpvhak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707826225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7TZDFydWHl6WRFqmAy6Kwi1dhKU2+NmuD788mtOIC8=;
	b=F5PgQKCVE2cb/8sJrMMpiNrqNEuSTU0RJhJ8mS2prMp8Yz+Ct9DVxYkI2YCwIYBiC9EtEc
	DZrtzN0OugwW/VBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707826224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7TZDFydWHl6WRFqmAy6Kwi1dhKU2+NmuD788mtOIC8=;
	b=Wy7iPzijVIXWCQ+xijOFndQ+G/40mH+S991gnJxtq3WICm3Z8M52cQsegfWDzMoO2163z9
	hc/PtoT1CI2yVSK8BmC08Ro7Yinj5z2N7nuvy0vyNNL6t94Q5SggjIjdTiELqXN+zFzUaH
	KYU5qONFxgpjbwcUcb8q4px79pm12gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707826224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7TZDFydWHl6WRFqmAy6Kwi1dhKU2+NmuD788mtOIC8=;
	b=0teH5P3wlkXKW0KZnlXkIUETpXy6MAi85XeXhA6hVOjCC6y/CcGXTM6roi6O3dMfrU7Q1+
	YB5+TJz3EVFvD3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99A451370C;
	Tue, 13 Feb 2024 12:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9Nv4JDBcy2WKBAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 12:10:24 +0000
Date: Tue, 13 Feb 2024 13:10:24 +0100
Message-ID: <87plx0y37z.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v15 41/50] ASoC: Add SND kcontrol for fetching USB offload status
In-Reply-To: <20240213005422.3121-42-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
	<20240213005422.3121-42-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wy7iPzij;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0teH5P3w
X-Spamd-Result: default: False [0.19 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLe67txhfobum3fqdb5xx8e3au)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[38.30%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: E00B422203
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue, 13 Feb 2024 01:54:13 +0100,
Wesley Cheng wrote:
> 
> Add a kcontrol to the platform sound card to fetch the current offload
> status.  This can allow for userspace to ensure/check which USB SND
> resources are actually busy versus having to attempt opening the USB SND
> devices, which will result in an error if offloading is active.
> 
> An example of fetching the USB offloading status would look like:
> tinymix -D 0 get 'USB Offload Playback Route Status'
> -1, -1 (range -1->32) --> [Offload is idle]
> 
> tinymix -D 0 get 'USB Offload Playback Route Status'
> 1, 0 (range -1->32)  --> [Offload active on card#1 pcm#0]

Ah, I didn't notice until now that the second value is the PCM index.

> +static int snd_soc_usb_offload_status_info(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_usb *ctx = snd_soc_find_usb_ctx(component->dev->of_node);
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	uinfo->count = 2*ctx->num_supported_streams;
> +	uinfo->value.integer.min = -1;
> +	uinfo->value.integer.max = SNDRV_CARDS;

Then it's bogus to set SNDRV_CARDS as max.  The PCM index number is
independent from the card number.  In theory, it can be even more than
the card max (very unlikely, though).

Wouldn't it be more intuitive to provide two different controls, one
for card number and one for PCM index number?


thanks,

Takashi

