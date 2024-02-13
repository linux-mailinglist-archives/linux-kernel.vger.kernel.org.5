Return-Path: <linux-kernel+bounces-63387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD71852E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCC11F238B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C882BB12;
	Tue, 13 Feb 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nQPWZMsL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U704wtln";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nQPWZMsL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U704wtln"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601752BB11;
	Tue, 13 Feb 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821996; cv=none; b=ChzDXEUYZDKqCBcM1uroLSFpUmlXnbeBTfB4HS5cRN/x2u0LK77OWJcGVczFcuGSpBUao3PYjrT6n4PtEf/+TteSqJPOE3C6TCWiLyDHonT6WDAT19r4dL7qaiyq+6qb7PJ66d1dyPgJG/qspUuIb1AUDjx5FaGOOsNZHPdJdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821996; c=relaxed/simple;
	bh=z5rLb6MsNMrDpWRnjctFpUrE7AGtrnX2KDuGHeXO7Ek=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InMKC/WjJmBFA1bdo8J6Hd0jpXESrGsYAo0HVGkfC64t7VkMUCwL83tRP4UIwTMWMofdMDpqXCjWc2KCF+2oAHf8HQgwAhb3KjVsbHo5/jpkFdViH57ff8QnNfRqtrwpAoemMmqTisihiewgSjyTVy3aoRQny1yfO/dLd7pRgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nQPWZMsL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U704wtln; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nQPWZMsL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U704wtln; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C0CB1FCA1;
	Tue, 13 Feb 2024 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707821993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nssWF1i/oSbiQpzptSWDyl0IEP8C/Hz0bw8YG0ty/hY=;
	b=nQPWZMsLWCEqCIgUH0rwcQ3Luz26DlMH6dNGQuzYmrntsG9tIvn4uhY0EgiwdEkAqE5zUg
	r8zvr/ohbG9MMe/N8Ffo1Oczy5PlS9YatpC964fkkjiI6Euq7z9SBYeRsxwvL5eMn2D+Ar
	Hvz9vUqRbleHSMHv5kW0PpoSWV9GI3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707821993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nssWF1i/oSbiQpzptSWDyl0IEP8C/Hz0bw8YG0ty/hY=;
	b=U704wtln6aIUurJC7nEA0jrBRJ7dYOjWgJvYaW9Ay6lVzJEJXmSN25ik06tXw6WiEvVotX
	gy23pC7EoCMp2gAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707821993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nssWF1i/oSbiQpzptSWDyl0IEP8C/Hz0bw8YG0ty/hY=;
	b=nQPWZMsLWCEqCIgUH0rwcQ3Luz26DlMH6dNGQuzYmrntsG9tIvn4uhY0EgiwdEkAqE5zUg
	r8zvr/ohbG9MMe/N8Ffo1Oczy5PlS9YatpC964fkkjiI6Euq7z9SBYeRsxwvL5eMn2D+Ar
	Hvz9vUqRbleHSMHv5kW0PpoSWV9GI3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707821993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nssWF1i/oSbiQpzptSWDyl0IEP8C/Hz0bw8YG0ty/hY=;
	b=U704wtln6aIUurJC7nEA0jrBRJ7dYOjWgJvYaW9Ay6lVzJEJXmSN25ik06tXw6WiEvVotX
	gy23pC7EoCMp2gAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DF1913404;
	Tue, 13 Feb 2024 10:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h5x7EqlLy2UVcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 10:59:53 +0000
Date: Tue, 13 Feb 2024 11:59:53 +0100
Message-ID: <87wmr8y6hi.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v15 29/50] ALSA: usb-audio: qcom: Introduce QC USB SND offloading support
In-Reply-To: <20240213005422.3121-30-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
	<20240213005422.3121-30-quic_wcheng@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nQPWZMsL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U704wtln
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.76 / 50.00];
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
	 BAYES_HAM(-1.75)[93.51%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.76
X-Rspamd-Queue-Id: 8C0CB1FCA1
X-Spam-Flag: NO

On Tue, 13 Feb 2024 01:54:01 +0100,
Wesley Cheng wrote:
> +static int __init qc_usb_audio_offload_init(void)
> +{
> +	struct uaudio_qmi_svc *svc;
> +	int ret;
> +
> +	svc = kzalloc(sizeof(struct uaudio_qmi_svc), GFP_KERNEL);
> +	if (!svc)
> +		return -ENOMEM;
> +
> +	svc->uaudio_wq = create_singlethread_workqueue("uaudio_svc");
> +	if (!svc->uaudio_wq) {
> +		ret = -ENOMEM;
> +		goto free_svc;
> +	}

Do we need a dedicated workqueue?  I don't mind much, but an own
workqueue isn't usually needed unless specifically required such as
the request quantity control or isolation.


thanks,

Takashi

