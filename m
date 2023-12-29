Return-Path: <linux-kernel+bounces-13097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A61B81FFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A7E2833BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA311706;
	Fri, 29 Dec 2023 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RMnMj0P5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SyPFXpl2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RMnMj0P5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SyPFXpl2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA1711703;
	Fri, 29 Dec 2023 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 432E12209E;
	Fri, 29 Dec 2023 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703856091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTMDUEOCmZ1Qrqn6ErsZBP8qT5PCPSG5Mq6RwTP1Bt4=;
	b=RMnMj0P5rvQ/ka9nSfCDw12NyZem5mnqje3ZDEwGG1K0eXn7bQRckZkcaJTGPOPSeFNbVJ
	Q39Nnn6Lz+ZaTYvE8S1nkkjOqJTf2aCKAe0cJZc7h5wl4R+8erKZdRHKQql0hc4bxqW6g6
	OdzrTPcBmkBYuJgEW3qlNNrLyLCwuzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703856091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTMDUEOCmZ1Qrqn6ErsZBP8qT5PCPSG5Mq6RwTP1Bt4=;
	b=SyPFXpl2M4OlPpBwxtBcfhqgNx342x1l0WsN6k943jNbusrDcW8WwIIc3YZ5f9Zhmkq2FP
	nAWoojXL1Cg4wqAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703856091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTMDUEOCmZ1Qrqn6ErsZBP8qT5PCPSG5Mq6RwTP1Bt4=;
	b=RMnMj0P5rvQ/ka9nSfCDw12NyZem5mnqje3ZDEwGG1K0eXn7bQRckZkcaJTGPOPSeFNbVJ
	Q39Nnn6Lz+ZaTYvE8S1nkkjOqJTf2aCKAe0cJZc7h5wl4R+8erKZdRHKQql0hc4bxqW6g6
	OdzrTPcBmkBYuJgEW3qlNNrLyLCwuzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703856091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cTMDUEOCmZ1Qrqn6ErsZBP8qT5PCPSG5Mq6RwTP1Bt4=;
	b=SyPFXpl2M4OlPpBwxtBcfhqgNx342x1l0WsN6k943jNbusrDcW8WwIIc3YZ5f9Zhmkq2FP
	nAWoojXL1Cg4wqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 116B4133E5;
	Fri, 29 Dec 2023 13:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P590AtvHjmXUbgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 13:21:31 +0000
Date: Fri, 29 Dec 2023 14:21:30 +0100
Message-ID: <87o7e9xhyd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ALSA: hdsp: fix some memleaks in snd_hdsp_hwdep_ioctl
In-Reply-To: <20231227060322.3556052-1-alexious@zju.edu.cn>
References: <20231227060322.3556052-1-alexious@zju.edu.cn>
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
X-Spamd-Result: default: False [-2.86 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.55)[92.09%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RMnMj0P5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SyPFXpl2
X-Spam-Score: -2.86
X-Rspamd-Queue-Id: 432E12209E

On Wed, 27 Dec 2023 07:03:20 +0100,
Zhipeng Lu wrote:
> 
> When snd_hdsp_load_firmware_from_cache and snd_hdsp_enable_io fails,
> the hdsp->fw_uploaded needs to be free.Or there could be memleaks in
> snd_hdsp_hwdep_ioctl.
> 
> Fixes: 90caaef6a1ce ("ALSA: hdsp: improve firmware caching")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Thanks for the patch, but the patch description is misleading.
The allocated object isn't really "leaked"; it's released at the
removal of the driver.

We may apply some optimization like you did, but then it should have a
different description.


thanks,

Takashi

