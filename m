Return-Path: <linux-kernel+bounces-127453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DAC894B95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579191C223B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D32BCE3;
	Tue,  2 Apr 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BN9Pu55U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gODISPjK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778321A0A;
	Tue,  2 Apr 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040061; cv=none; b=tiQ7UhAofiuDVbh/2JAJKhXBQi6iOD5hkVwho66KMgaDlREeBP0PIGAg0iKJfYkBZhmLq4gcpGCaD0y/CFKF8idyMGveS0ejI3DRPiCTnzFrmWpKkp+Zzt/iZHH0WMCmeoZX+f6wWu6CaEUfFS/2Fpm6Boxt5G8pQQhvq8YS/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040061; c=relaxed/simple;
	bh=qH0D3AhRYnb6bjEzB+stgfVObi4cQW3F92hHyMZ/AG4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uk2kbnCxjeAjfVEjie8ynuf3nDfDIObBzLhoKg9ij/PBScOMJIxW7aAPftLLET0sbzypQ9Ob5gT9x5GWf8/OYvA1ft13o5arMucQnDFD+7yRAPf91oJI4EQSoJXA0xg837FmcMd5qFgcoUpAQsGP7dXGkX4qHyKlw31GpwUjWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BN9Pu55U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gODISPjK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 755CD34376;
	Tue,  2 Apr 2024 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712040058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mzXMyPJdq2oR/609Gwa9Fp+XSu7c9aHRHlkUdrdW1g=;
	b=BN9Pu55UEX5XoTzQN30DlZmr4seOr0zE2OtjRtTHpmQzfrbFv15Tnr/fQ6u4A8/1qKX3Jc
	LjNdLEGWkJwpUNGAMHmzMViwuIMDUAADWwLClyKAesPucHbTWW6caGQYT8/vQquoZ2JC2F
	rmNbP91e9mIBkUExOOBOYOgAuHFDnNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712040058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4mzXMyPJdq2oR/609Gwa9Fp+XSu7c9aHRHlkUdrdW1g=;
	b=gODISPjKHgAy9B8B+QMXz7vM5eMe+dvO4XanrpoGesUxpcAnaAL2dXAk3NJGrNXxvt/9ug
	BLZIm42fFJyKRYCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A32913AA3;
	Tue,  2 Apr 2024 06:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ga26DHqoC2btPgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Tue, 02 Apr 2024 06:40:58 +0000
Date: Tue, 02 Apr 2024 08:41:02 +0200
Message-ID: <87ttkks1vl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <broonie@kernel.org>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/3] ASoC: Use snd_ctl_find_id_mixer() instead of open-coding
In-Reply-To: <20240401100210.61277-1-rf@opensource.cirrus.com>
References: <20240401100210.61277-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: 1.37
X-Spam-Flag: NO
X-Spamd-Bar: +
X-Spamd-Result: default: False [1.37 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.02)[52.73%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 755CD34376

On Mon, 01 Apr 2024 12:02:07 +0200,
Richard Fitzgerald wrote:
> 
> The first two patches change snd_soc_card_get_kcontrol() to use the
> core snd_ctl_find_id_mixer() functionality instead of open-coding its
> own list walk.
> 
> The last patch adds a KUnit test for this, which was tested on the
> original and modified code.
> 
> Changes in V2:
> Only change is in the KUnit test (patch #3) to make the const strings
> more consty.
> 
> Richard Fitzgerald (3):
>   ALSA: control: Introduce snd_ctl_find_id_mixer_locked()
>   ASoC: soc-card: Use snd_ctl_find_id_mixer() instead of open-coding
>   ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol

I suppose this goes via Mark's tree.  Feel free to take my ack:

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

