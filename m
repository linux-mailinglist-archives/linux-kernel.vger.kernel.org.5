Return-Path: <linux-kernel+bounces-509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62667814234
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E261F23067
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF1D2E5;
	Fri, 15 Dec 2023 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HuUfVCfp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0KMe7wA7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HuUfVCfp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0KMe7wA7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C87D28F;
	Fri, 15 Dec 2023 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 309241F81D;
	Fri, 15 Dec 2023 07:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702624439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DueD1ycJeZpomdNur64/vGkxE0MwuO7XBirtEWUESXQ=;
	b=HuUfVCfp+L4OZuCGMUNjNj2K5u3Z3MXxBjt26N6AHE3o3XUXvArLAyp68XL3A0LoL738LR
	0lSl3LY3Ga3PsnoE5avswzuT/xA7AA8fPXv+FiykNA+ylPDplJcStRORjwsSiAbXKj5JR1
	jKNnRFWD0O+KYgoTl6TNcjozEvFFaew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702624439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DueD1ycJeZpomdNur64/vGkxE0MwuO7XBirtEWUESXQ=;
	b=0KMe7wA79ifaIm0aeQz0UntgBIGdqNGyyie3rjDoLYS2fkGpFareUueG0rKiaHkX9VY6U5
	PQJtJMznpY6TVyDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702624439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DueD1ycJeZpomdNur64/vGkxE0MwuO7XBirtEWUESXQ=;
	b=HuUfVCfp+L4OZuCGMUNjNj2K5u3Z3MXxBjt26N6AHE3o3XUXvArLAyp68XL3A0LoL738LR
	0lSl3LY3Ga3PsnoE5avswzuT/xA7AA8fPXv+FiykNA+ylPDplJcStRORjwsSiAbXKj5JR1
	jKNnRFWD0O+KYgoTl6TNcjozEvFFaew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702624439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DueD1ycJeZpomdNur64/vGkxE0MwuO7XBirtEWUESXQ=;
	b=0KMe7wA79ifaIm0aeQz0UntgBIGdqNGyyie3rjDoLYS2fkGpFareUueG0rKiaHkX9VY6U5
	PQJtJMznpY6TVyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E206E13726;
	Fri, 15 Dec 2023 07:13:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BZfVNbb8e2VyKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Dec 2023 07:13:58 +0000
Date: Fri, 15 Dec 2023 08:13:58 +0100
Message-ID: <87a5qcos3t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: select program 0, conf 0 by default
In-Reply-To: <038add0bdca1f979cc7abcce8f24cbcd3544084b.1702596646.git.soyer@irl.hu>
References: <038add0bdca1f979cc7abcce8f24cbcd3544084b.1702596646.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: ****
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HuUfVCfp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0KMe7wA7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.86 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.95)[-0.954];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.89)[99.55%]
X-Spam-Score: -6.86
X-Rspamd-Queue-Id: 309241F81D
X-Spam-Flag: NO

On Fri, 15 Dec 2023 00:33:27 +0100,
Gergo Koteles wrote:
> 
> Currently, cur_prog/cur_conf remains at the default value (-1), while
> program 0 has been loaded into the amplifiers.
> 
> In the playback hook, tasdevice_tuning_switch tries to restore the
> cur_prog/cur_conf. In the runtime_resume/system_resume,
> tasdevice_prmg_load tries to load the cur_prog as well.
> 
> Set cur_prog and cur_conf to 0 if available in the firmware.
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> CC: stable@vger.kernel.org
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thanks, applied now.


Takashi

