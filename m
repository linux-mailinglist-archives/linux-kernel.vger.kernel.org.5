Return-Path: <linux-kernel+bounces-101194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CA187A3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A786E1C21228
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6942199C7;
	Wed, 13 Mar 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GOTScVv+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+6955uT7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GOTScVv+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+6955uT7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99A171CD;
	Wed, 13 Mar 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316900; cv=none; b=j2v8Yk70pb4YZtDJ+3U9lGAQshNX/33Tx72KNmP+5aN0QqdD6ZaF8CsWBTz/eGMU0HKDP/1kU167WqCazK5FdSI+2Qw6cX7GMe9Lw3Rv1ZoxSxmCYs14TgjXVLChMvtYYK3YUbSmrVtdouiKKjJ2Ky4SSBwSxjGMhIfqs+V0A+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316900; c=relaxed/simple;
	bh=zzF39wbBFLQpMMK5tl7DOkFx1UJkZZYFH9+mF0L5mvM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHiPxeR5PNgi1cvyYAp7LuYYw0lGaAbxnodZIwP9H0pga0SDBt55kTV//ThJfOIkUu2wJykCxVnGYrQuhUCtnuADi/PCHaZbdnpbSvrR7gV8V1b1nLGCAb55vVKuBgbFMXcEvPte8Vs5gKwMrnOzusaPWeISYs8VRk4kb2iMrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GOTScVv+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+6955uT7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GOTScVv+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+6955uT7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B3C21F7A9;
	Wed, 13 Mar 2024 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710316896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0qthPn3S9E58p/GBHkUsM8gPcmA8wvG8nKdT1IAbbo=;
	b=GOTScVv+GxurN+B5v9fnSaU+kP68pw3kt2e6KuznSjRMAUkOpoTTgaGQ0vsANmg7bwXr3j
	5xAsP0cwlCQAOtrO7B4lf19vrxxf/AR1fbFcyNBH+vMm83vlzvmQ4qPQA2qDpNiK2pokH0
	Pwr45VgRodWC6YudpXUTIJW55R9srD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710316896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0qthPn3S9E58p/GBHkUsM8gPcmA8wvG8nKdT1IAbbo=;
	b=+6955uT7Cl5YeMd3/+uIXYBo7ksbIarH+QQi16MmG/p3RDkfiqHwMEVxdzqtmbfGpFFgbl
	AhhoFa6l1k3ETjCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710316896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0qthPn3S9E58p/GBHkUsM8gPcmA8wvG8nKdT1IAbbo=;
	b=GOTScVv+GxurN+B5v9fnSaU+kP68pw3kt2e6KuznSjRMAUkOpoTTgaGQ0vsANmg7bwXr3j
	5xAsP0cwlCQAOtrO7B4lf19vrxxf/AR1fbFcyNBH+vMm83vlzvmQ4qPQA2qDpNiK2pokH0
	Pwr45VgRodWC6YudpXUTIJW55R9srD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710316896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o0qthPn3S9E58p/GBHkUsM8gPcmA8wvG8nKdT1IAbbo=;
	b=+6955uT7Cl5YeMd3/+uIXYBo7ksbIarH+QQi16MmG/p3RDkfiqHwMEVxdzqtmbfGpFFgbl
	AhhoFa6l1k3ETjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DC4D1397F;
	Wed, 13 Mar 2024 08:01:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LNnjBWBd8WVxWAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Mar 2024 08:01:36 +0000
Date: Wed, 13 Mar 2024 09:01:35 +0100
Message-ID: <87frwupnkw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Takashi Iwai <tiwai@suse.de>,
	Johan Carlsson <johan.carlsson@teenage.engineering>,
	Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sound-current tree
In-Reply-To: <20240313085136.056eaf24@canb.auug.org.au>
References: <20240313085136.056eaf24@canb.auug.org.au>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GOTScVv+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+6955uT7
X-Spamd-Result: default: False [-0.36 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.de:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 TO_DN_ALL(0.00)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.05)[87.67%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Spam-Score: -0.36
X-Rspamd-Queue-Id: 4B3C21F7A9
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, 12 Mar 2024 22:51:36 +0100,
Stephen Rothwell wrote:
> 
> Hi all,
> 
> After merging the sound-current tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> sound/usb/stream.c: In function 'convert_chmap':
> sound/usb/stream.c:306:34: error: 'chmaps' undeclared (first use in this function); did you mean 'chmap'?
>   306 |                         if (c == chmaps->channels)
>       |                                  ^~~~~~
>       |                                  chmap
> sound/usb/stream.c:306:34: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   a94566ace3ca ("ALSA: usb-audio: Stop parsing channels bits when all channels are found.")
> 
> I have reverted that commit for today.

My bad, I dropped the bad patch.  Sorry for inconvenience.


Takashi

