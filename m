Return-Path: <linux-kernel+bounces-124251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5120891469
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA551C22B39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AAC4086C;
	Fri, 29 Mar 2024 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ezeeq575";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9ZZ1kCM3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AB111AA;
	Fri, 29 Mar 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697893; cv=none; b=V5NWl8edMg/DV4k7TUbtF8k08dMOug8a9rUdalFD8LddJFhgnhTDCyaL6KdkoNwRZ1/mJWVcTk2PbX4jiD6XgMxPHkVaJiU6B/sv81K6yFLQe3+qzDPki5pB1lLrkn+H+m+JpE7GTLFuuhmvyrw5L3XMk8NvgzQ0W7irNwfo/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697893; c=relaxed/simple;
	bh=opYRELNRgzeZW7E1JHSDPHg/xw4e1gMY1XsmC5fZYNE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XL5bioR9FOoSBLvZsk/PQ3QTamSLZtkpzYUwIitmxwkFwhItASrz02LXxJPAgyvzV5hbPD675j2B5HFty2A6LoxC7sguO932Uq4OZwqU06Lh/ODOlr4KrBDlg0fkMz3Zrl/fTgyzg4N+KfqR1VDDWMtvxje6qO/siVmXWydfsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ezeeq575; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9ZZ1kCM3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05FA733D86;
	Fri, 29 Mar 2024 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711697889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qr/NlwU4Fj7vdoto26TFYwaxntfyHuHSAx6yQeeZ3q0=;
	b=ezeeq575IMEZ6eYt6/e9VyQIvmrAn8iS8VLRUgA33MmZW+XmtII98nzwkLzzMJc7S92rMe
	VaW6BUIY90WNw77mWVQSSNq3IW5L9etnMLjCRLJMA6vAUQqZ857/AJxxM6gc9PjF9+UnrK
	baMTGPlKKWgDtutoLbKRmlplDe1QoKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711697889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qr/NlwU4Fj7vdoto26TFYwaxntfyHuHSAx6yQeeZ3q0=;
	b=9ZZ1kCM3/Zop7VbM3rcDJMXmFX2tPKOIHVoXFCm9Bogl2kFypo1WSjS2J+trs6yh4LzcFg
	hE5eIcWemm9fdRBA==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AC93113A9F;
	Fri, 29 Mar 2024 07:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4WqrKOBvBmaEcwAAn2gu4w
	(envelope-from <tiwai@suse.de>); Fri, 29 Mar 2024 07:38:08 +0000
Date: Fri, 29 Mar 2024 08:38:11 +0100
Message-ID: <87o7ax8p3w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: tas2781: mark dvc_tlv with __maybe_unused
In-Reply-To: <0e461545a2a6e9b6152985143e50526322e5f76b.1711665731.git.soyer@irl.hu>
References: <0e461545a2a6e9b6152985143e50526322e5f76b.1711665731.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -0.49
X-Spamd-Result: default: False [-0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.19)[70.84%]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 28 Mar 2024 23:47:37 +0100,
Gergo Koteles wrote:
> 
> Since we put dvc_tlv static variable to a header file it's copied to
> each module that includes the header. But not all of them are actually
> used it.
> 
> Fix this W=1 build warning:
> 
> include/sound/tas2781-tlv.h:18:35: warning: 'dvc_tlv' defined but not
> used [-Wunused-const-variable=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403290354.v0StnRpc-lkp@intel.com/
> Fixes: ae065d0ce9e3 ("ALSA: hda/tas2781: remove digital gain kcontrol")
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thanks, applied now.


Takashi

