Return-Path: <linux-kernel+bounces-159999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26768B377C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143C6284DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8116146D52;
	Fri, 26 Apr 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PLoiJEXY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7ja7n9F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PLoiJEXY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P7ja7n9F"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435C146A7E;
	Fri, 26 Apr 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135824; cv=none; b=vC/FWVUI8xPXnW1nzjoBfuAzmOmBZX0fynjL9JzO2VDLumxeDToxMm79vQQ4+Pqj6KP1YOowRN257cGiHvfmJQ2vqA25SzmEwvBsPgBKBWF5DOd4FqR0RvJRMRQ/f0rvTLtYntJtSl9yqj0dSqFwTSFz6ViJalzZKSLjOG6TSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135824; c=relaxed/simple;
	bh=zQgcqjDLU4rXiwYQKS1OFiTU6+v3iMUTYfNZyPzyHP4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sj7OoiNbX4BTPL8NLyqx29wfZ1Vd6P2J/4+34ApSkg73AAdwGTMPzT7bt0kl++hOH16Wk13AZcn8atDVOlsGih5srsWxlIOr6VMBEfMCArdy0UqUDCxN0cPCE+nUKvcQ6B24rXwGHc94emO0ltsDezfDTG8Ld99C/4AooL05pEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PLoiJEXY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7ja7n9F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PLoiJEXY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P7ja7n9F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2C9C5D0B6;
	Fri, 26 Apr 2024 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714135416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7XH3EvW1LrbRnIuU9A2pUcjAGgJdRh2s3ZQN36W5UU=;
	b=PLoiJEXYkAAu+kmpjrkAiuoP6q/nP7wCfKKBZ8esRlunuBwGHpkwIc+fm/h06mj1yeKa8k
	hZ+fsXfeOnA4AevG9pGfU38YsCqMNK6WLFmLD5iNsdbva3AZev0RCf9NugScv7keXwielX
	gwn7wtC1lyhTbx3r/Jir7QZcy/O7xAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714135416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7XH3EvW1LrbRnIuU9A2pUcjAGgJdRh2s3ZQN36W5UU=;
	b=P7ja7n9FWoBrHTj8A89XPDP00j5HzgT55nzox/OYFvbaiCoSq7xk81QBGdu5LjvkfqDWpH
	PkHO/LeCj1PberAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714135416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7XH3EvW1LrbRnIuU9A2pUcjAGgJdRh2s3ZQN36W5UU=;
	b=PLoiJEXYkAAu+kmpjrkAiuoP6q/nP7wCfKKBZ8esRlunuBwGHpkwIc+fm/h06mj1yeKa8k
	hZ+fsXfeOnA4AevG9pGfU38YsCqMNK6WLFmLD5iNsdbva3AZev0RCf9NugScv7keXwielX
	gwn7wtC1lyhTbx3r/Jir7QZcy/O7xAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714135416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7XH3EvW1LrbRnIuU9A2pUcjAGgJdRh2s3ZQN36W5UU=;
	b=P7ja7n9FWoBrHTj8A89XPDP00j5HzgT55nzox/OYFvbaiCoSq7xk81QBGdu5LjvkfqDWpH
	PkHO/LeCj1PberAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECAB01398B;
	Fri, 26 Apr 2024 12:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BKtNOHehK2ZkVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Apr 2024 12:43:35 +0000
Date: Fri, 26 Apr 2024 14:43:46 +0200
Message-ID: <877cgks399.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rajashekar kuruva <quic_kuruva@quicinc.com>
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
	<robh@kernel.org>,
	<konrad.dybcio@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
Subject: Re: [PATCH] [RFC PATCH] ALSA: usb-audio: endpoint: Prevent NULL pointer deference in snd_usb_endpoint_close
In-Reply-To: <20240426122511.547755-1-quic_kuruva@quicinc.com>
References: <20240426122511.547755-1-quic_kuruva@quicinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -0.63
X-Spam-Level: 
X-Spamd-Result: default: False [-0.63 / 50.00];
	BAYES_HAM(-1.83)[93.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]

On Fri, 26 Apr 2024 14:25:11 +0200,
Rajashekar kuruva wrote:
> 
> When multiple plug-in and plug-out events occur,
> there is a risk of encountering a NULL pointer dereference
> leading to a kernel panic during a headset use-case.
> this issue arises in the snd_usb_endpoint_close function

Such a scenario can't happen: ep->iface_ref is changed only in
chip->mutex lock, hence it can't be NULL there.


thanks,

Takashi

