Return-Path: <linux-kernel+bounces-120663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367E88DB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75D829A1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2744AEF1;
	Wed, 27 Mar 2024 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FwWQbeBu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fqycNERe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FwWQbeBu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fqycNERe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E028DD3;
	Wed, 27 Mar 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535135; cv=none; b=Q1qKyhh478xGUCqLbuzPbFbRSisaR6CMd3K1snKvzwvVREc6O4iGhDtsJrwVI1WLzMesGzbSEviw3c3BaaCQgDtNogXY5mnJD/VrCdM3Qr+S+bQ5MdogT2TdMzqjffXKuCVcBJB/+DfbyhCm9R/O9PTG+A6MBOw61re730hLKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535135; c=relaxed/simple;
	bh=0e2xfwb4U2fZ5mQQeSTGhasWsRxBW8LMen2Dviag7co=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YL1nIhw4esbKDa2O6H2Tz2Bnq5GW2R0ckrDDOC3MYZpiyiNoMmxIFpBaOqnPwn2KsKeHIHp/EStAmrcV/GC+dBCWRZgz8kiuMHsPEWPj0hbuHM+oAPhgUqI3Q68On0r3NaGOvn3JTRQH4ty2QrFWY7qR49P6N7GNSj9ljZMtbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FwWQbeBu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fqycNERe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FwWQbeBu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fqycNERe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEF59383BC;
	Wed, 27 Mar 2024 10:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711535131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AkKqHDoToHVeJHWi3Rlrg9RTE/Xa/qdhkLZfkTRhEs=;
	b=FwWQbeBu+jNh1KgAazBTY2eynypTX7882xhyrUyYy2h23a5I/AQsdGpN+lhrubcyKbeBSF
	Zv4x3bnYWFaH8b3wOO/OaYVRFjn5aAGj/jOJ2DiluOKYdc3RI10nL4QnjBZnhfdU+fBbK/
	lMveg3Mbc1HVuJArUmRXjkljhkx2Apc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711535131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AkKqHDoToHVeJHWi3Rlrg9RTE/Xa/qdhkLZfkTRhEs=;
	b=fqycNEReW9SYIVyZliwWgZ11xC8NN9G6smTEkaAZxpF30up457SWgKj1GzyI2Z+jlsNMOm
	VOGCYR3Xu/A7BPDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711535131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AkKqHDoToHVeJHWi3Rlrg9RTE/Xa/qdhkLZfkTRhEs=;
	b=FwWQbeBu+jNh1KgAazBTY2eynypTX7882xhyrUyYy2h23a5I/AQsdGpN+lhrubcyKbeBSF
	Zv4x3bnYWFaH8b3wOO/OaYVRFjn5aAGj/jOJ2DiluOKYdc3RI10nL4QnjBZnhfdU+fBbK/
	lMveg3Mbc1HVuJArUmRXjkljhkx2Apc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711535131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/AkKqHDoToHVeJHWi3Rlrg9RTE/Xa/qdhkLZfkTRhEs=;
	b=fqycNEReW9SYIVyZliwWgZ11xC8NN9G6smTEkaAZxpF30up457SWgKj1GzyI2Z+jlsNMOm
	VOGCYR3Xu/A7BPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B1A1369F;
	Wed, 27 Mar 2024 10:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J6ZxGxv0A2afJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 27 Mar 2024 10:25:31 +0000
Date: Wed, 27 Mar 2024 11:25:33 +0100
Message-ID: <87edbw7yzm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ALSA: hda/tas2781: fixes for 6.9-rc1
In-Reply-To: <cover.1711469583.git.soyer@irl.hu>
References: <cover.1711469583.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -0.34
X-Spamd-Result: default: False [-0.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.58%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Tue, 26 Mar 2024 17:18:44 +0100,
Gergo Koteles wrote:
> 
> Hi,
> 
> This series removes the no longer needed digital gain kcontrol, which 
> caused problems in tas2563, because the register does not exists there.
> 
> This series also adds locking and debug statements to the other 
> kcontrols. They sometimes ran in parallel with tasdev_fw_ready, and 
> caused weird sound problems.
> https://github.com/tomsom/yoga-linux/issues/58
> 
> Regards,
> Gergo
> 
> Changes in v2:
>  - Do not remove dvc_tlv scale from tas2781-tlv.h as it is also used by
>    sound/soc/codecs/tas2781-i2c.c
>  - Add kcontrol name to debug statements
>  - Add a new patch to remove a useless debug statement.
> 
> [1]: https://lore.kernel.org/all/cover.1711401621.git.soyer@irl.hu/
> 
> Gergo Koteles (4):
>   ALSA: hda/tas2781: remove digital gain kcontrol
>   ALSA: hda/tas2781: add locks to kcontrols
>   ALSA: hda/tas2781: add debug statements to kcontrols
>   ALSA: hda/tas2781: remove useless dev_dbg from playback_hook

Applied now.  Thanks.


Takashi

