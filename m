Return-Path: <linux-kernel+bounces-13118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E8681FFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBA9282E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BA1172F;
	Fri, 29 Dec 2023 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tUWWuixr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6SF+C2xV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tUWWuixr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6SF+C2xV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEF1171D;
	Fri, 29 Dec 2023 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 318BE1F7B5;
	Fri, 29 Dec 2023 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703859573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sk1J0IKWRsXdd9QQ2UKg+dEA9+6uBeiucEsOi3WQhHw=;
	b=tUWWuixrP8e4bv2+acfhqoGlfUNPd4+6PkdtkMEA/U3bWiUsKVRny93TaTrqpJOlHguCeK
	pwns1TV2NN7lxCZ25HXN5hd2xQlTS408KAngmLaaGYdP2vM9rBD9VE4fhW1OUPDoBpm1Cx
	kiOSVrH3BxZvus3sskWDb6qcUCFixg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703859573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sk1J0IKWRsXdd9QQ2UKg+dEA9+6uBeiucEsOi3WQhHw=;
	b=6SF+C2xVK72eGGuqchebbs5P0nty+nx4ZITZDA0HgN2m/H/Z5tGBg7MSoslduZ+c5P9nLN
	IeI3eQjarp6TnAAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703859573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sk1J0IKWRsXdd9QQ2UKg+dEA9+6uBeiucEsOi3WQhHw=;
	b=tUWWuixrP8e4bv2+acfhqoGlfUNPd4+6PkdtkMEA/U3bWiUsKVRny93TaTrqpJOlHguCeK
	pwns1TV2NN7lxCZ25HXN5hd2xQlTS408KAngmLaaGYdP2vM9rBD9VE4fhW1OUPDoBpm1Cx
	kiOSVrH3BxZvus3sskWDb6qcUCFixg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703859573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sk1J0IKWRsXdd9QQ2UKg+dEA9+6uBeiucEsOi3WQhHw=;
	b=6SF+C2xVK72eGGuqchebbs5P0nty+nx4ZITZDA0HgN2m/H/Z5tGBg7MSoslduZ+c5P9nLN
	IeI3eQjarp6TnAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2EB4136D1;
	Fri, 29 Dec 2023 14:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PJktMnTVjmXKeAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 14:19:32 +0000
Date: Fri, 29 Dec 2023 15:19:32 +0100
Message-ID: <87jzoxxf9n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Lorenz Brun <lorenz@brun.one>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda: cs35l41: Add HP override
In-Reply-To: <20231223150912.3040328-1-lorenz@brun.one>
References: <20231223150912.3040328-1-lorenz@brun.one>
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
	none
X-Spam-Level: 
X-Spam-Score: -0.31
X-Spamd-Result: default: False [-0.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[48.27%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Sat, 23 Dec 2023 16:09:11 +0100,
Lorenz Brun wrote:
> 
> This adds an override for a series of notebooks using a common config
> taken from HP's proprietary Windows driver.
> 
> This has been tested on a HP 15-ey0xxxx device (subsystem 103C8A31)
> together with another Realtek quirk and the calibration files from the
> proprietary driver.
> 
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
> Changes in v2:
> - Use newly-introduced config table instead of function
> - Change boost cap value from 10uF to 24uF after cross-referencing my
>   sources with the preexisting 103C89C6 entry.

This doesn't apply cleanly any longer after the merge of the latest
series from Stefan, unfortunately.  Could you rebase on either
for-next or topic/cs35l41 branch of sound.git tree and resubmit?

Also, the prop_model_table[] is a sorted list.  Please add entries at
the right positions.


thanks,

Takashi

