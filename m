Return-Path: <linux-kernel+bounces-149664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A858A943E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5361F2242B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089826EB5A;
	Thu, 18 Apr 2024 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lnvFHSrA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OYvDBgjG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lnvFHSrA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OYvDBgjG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000E495CB;
	Thu, 18 Apr 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425897; cv=none; b=pIBxA/9FqDtOpS1aj1+f9I8AhtN9/SzdgU11P8vW0p0gelSIRIm1D2dj/i89GTr3AU9lwP93MrWb8g3XCqtetQcwPHTnfIBLKztiba+wJfQqSaaM+lz4PV9BcDLgTgQ09mswx1ZwwFh01W1UVPpRYz4Pfdc4ygYWAbghBUmxNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425897; c=relaxed/simple;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InSaKGLhoMB+rzd9fsz/wcL7ZyT7CEYGidZ/lZJxmHMpg32T2wCGbBPjc1BhdvmvlOVrsdMvVtwUO1jkHgliaItdbv3/miLlQ4MLLVNIReBRwlqZgT2aLch6+UQtTq0vTfwldlkg59ySdTkweW3SoNszweXYUPTdlo1Hk0EsVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lnvFHSrA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OYvDBgjG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lnvFHSrA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OYvDBgjG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 438275C5F7;
	Thu, 18 Apr 2024 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=lnvFHSrAn3FVeiXIQEq78rKA2dSBgZMZL1zx57hjYTFMRCT0YOvo3fqariAqew0z0/kLUH
	t4iGra0oqIFfMq9r5QFanunjUu+MyRRLsbmJJrIA4ZInzBQwn5kGO/sw8yJHf9khaMdGpc
	1llY7vsS5k934NDGstwBbv1kXN+JKaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=OYvDBgjGCDGz9OyWZ9rIjGq91iuiJY9mA7cOFSv6+y9NrijpGBVKAYCyWwoIqY32O887RF
	fkctYJ7VNku81JBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lnvFHSrA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OYvDBgjG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=lnvFHSrAn3FVeiXIQEq78rKA2dSBgZMZL1zx57hjYTFMRCT0YOvo3fqariAqew0z0/kLUH
	t4iGra0oqIFfMq9r5QFanunjUu+MyRRLsbmJJrIA4ZInzBQwn5kGO/sw8yJHf9khaMdGpc
	1llY7vsS5k934NDGstwBbv1kXN+JKaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=OYvDBgjGCDGz9OyWZ9rIjGq91iuiJY9mA7cOFSv6+y9NrijpGBVKAYCyWwoIqY32O887RF
	fkctYJ7VNku81JBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BA931384C;
	Thu, 18 Apr 2024 07:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n24bAebNIGb8DQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 07:38:14 +0000
Date: Thu, 18 Apr 2024 09:38:22 +0200
Message-ID: <8734rjxgr5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+8933e1c7c07fe8f2dcd3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] inconsistent lock state in snd_hrtimer_callback (2)
In-Reply-To: <0000000000000b0bf30616069d1e@google.com>
References: <0000000000000b0bf30616069d1e@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [0.78 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.21)[71.72%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[8933e1c7c07fe8f2dcd3];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.78
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 438275C5F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

#syz fix: ALSA: timer: Fix missing irq-disable at closing

