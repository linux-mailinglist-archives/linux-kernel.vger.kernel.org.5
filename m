Return-Path: <linux-kernel+bounces-3140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C38167E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B18282F07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AA9107BA;
	Mon, 18 Dec 2023 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ycVO0Sqe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ky82sSBM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ycVO0Sqe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ky82sSBM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3BC1079D;
	Mon, 18 Dec 2023 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0E9B21E2D;
	Mon, 18 Dec 2023 08:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702887418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjntMNoS0FPhkGeK4kbpUFQ9Eav4f1akEt5QtGcHi2k=;
	b=ycVO0SqeV7MdKRfvn/RBd7OqMOUbvYpDzzEGaZY9ObatHNXhgshsthX385hnvTDNFFVqA3
	R4ngyjcTjvcKqMv1i5uz2b6rtdfH2xMrftssGvc+JO+Ck6B+mGn80uqSMgZyfPT6XBFoRe
	sk6hWPw2T0Z58gPtDihMWrwYwrr3Is0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702887418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjntMNoS0FPhkGeK4kbpUFQ9Eav4f1akEt5QtGcHi2k=;
	b=ky82sSBM21TqT1Ms2od9ndpIGT8GnQe1pl4mG2XPVOFeKt5sIIHkTuGf2KIuTjO/n2PdKv
	1NSfd8qMOBcqDADw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702887418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjntMNoS0FPhkGeK4kbpUFQ9Eav4f1akEt5QtGcHi2k=;
	b=ycVO0SqeV7MdKRfvn/RBd7OqMOUbvYpDzzEGaZY9ObatHNXhgshsthX385hnvTDNFFVqA3
	R4ngyjcTjvcKqMv1i5uz2b6rtdfH2xMrftssGvc+JO+Ck6B+mGn80uqSMgZyfPT6XBFoRe
	sk6hWPw2T0Z58gPtDihMWrwYwrr3Is0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702887418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjntMNoS0FPhkGeK4kbpUFQ9Eav4f1akEt5QtGcHi2k=;
	b=ky82sSBM21TqT1Ms2od9ndpIGT8GnQe1pl4mG2XPVOFeKt5sIIHkTuGf2KIuTjO/n2PdKv
	1NSfd8qMOBcqDADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65CB813454;
	Mon, 18 Dec 2023 08:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VwpxF/r/f2WMYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 18 Dec 2023 08:16:58 +0000
Date: Mon, 18 Dec 2023 09:16:58 +0100
Message-ID: <87cyv4ylfp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: au88x0: fixed a typo
In-Reply-To: <20231218065442.43523-1-ghanshyam1898@gmail.com>
References: <20231218065442.43523-1-ghanshyam1898@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.53)[97.90%]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ycVO0Sqe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ky82sSBM
X-Spam-Score: -2.84
X-Rspamd-Queue-Id: A0E9B21E2D

On Mon, 18 Dec 2023 07:54:42 +0100,
Ghanshyam Agrawal wrote:
> 
> Fixed typo in the word communicate
> 
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

Thanks, applied.


Takashi

