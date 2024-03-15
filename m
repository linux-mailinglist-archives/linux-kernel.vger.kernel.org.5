Return-Path: <linux-kernel+bounces-104372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D56587CCF4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E22F2830EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F71BF44;
	Fri, 15 Mar 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NN0PobY/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKf/3iGS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NN0PobY/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKf/3iGS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB91B7EA;
	Fri, 15 Mar 2024 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503484; cv=none; b=F1B1QYxyt4z8uvFlCY5EjkygdUneFpoM4+qWVJFsFo0xJXedwH4DGAqpKrs7+hGdoJM6VW6YQUuV/GQWqV2iHKoOIWv18oixzhAOs4RoOpdzsqwuBTA4+18ny/IrBL7D1sMf+od4da3jrqUkpdppWCB5tjpglzxQ8Jkgq0oB+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503484; c=relaxed/simple;
	bh=xTFqm7IClFSwRbfHDriijIbisYv3wMCRVyg507cp8m8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJffZpR4RGaR0xKmdWBRPHC0fqwHM/SgyFkG2AWbNqQJ/y1QrtvcUqGHt4FvQISs1a1Nk7ldOdBjMs7qJxdXOoqzXRDTsoYcuQD3x2rXODByv2x+g6dZcecFXkCnA7U+vf5Sdc/U3Mo+Czx3krd4MCnoC67dU6a+sKDIpXU3xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NN0PobY/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKf/3iGS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NN0PobY/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKf/3iGS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A63621DD1;
	Fri, 15 Mar 2024 11:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710503479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTFqm7IClFSwRbfHDriijIbisYv3wMCRVyg507cp8m8=;
	b=NN0PobY/aemHh1hlNv2a161XAG4ha7M/D+MR2gCYyEZszbW1PFYtGpz9bpf7mkuIlFIKs5
	/WJscXi7rRAw4agvO816FRnKYbKq4Lo7aQazO2SvEbi9Xd5oavZg0OMa0M/51uOUA0vGvD
	PGPm4X42V/tGJFTQf045zkUCBdRbIAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710503479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTFqm7IClFSwRbfHDriijIbisYv3wMCRVyg507cp8m8=;
	b=HKf/3iGSCw5zTX2ENPKIaP92jcCqKOr0cLasTZxKvWZKkyKfuc1LwcBphbQtv2DWwGQLDP
	P8EfhPKp0jKC8ABw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710503479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTFqm7IClFSwRbfHDriijIbisYv3wMCRVyg507cp8m8=;
	b=NN0PobY/aemHh1hlNv2a161XAG4ha7M/D+MR2gCYyEZszbW1PFYtGpz9bpf7mkuIlFIKs5
	/WJscXi7rRAw4agvO816FRnKYbKq4Lo7aQazO2SvEbi9Xd5oavZg0OMa0M/51uOUA0vGvD
	PGPm4X42V/tGJFTQf045zkUCBdRbIAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710503479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTFqm7IClFSwRbfHDriijIbisYv3wMCRVyg507cp8m8=;
	b=HKf/3iGSCw5zTX2ENPKIaP92jcCqKOr0cLasTZxKvWZKkyKfuc1LwcBphbQtv2DWwGQLDP
	P8EfhPKp0jKC8ABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 311EB13460;
	Fri, 15 Mar 2024 11:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XqpyCjc29GXXCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Mar 2024 11:51:19 +0000
Date: Fri, 15 Mar 2024 12:51:18 +0100
Message-ID: <87h6h7btmx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+f3bc6f8108108010a03d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com,
	tiwai@suse.de
Subject: Re: [syzbot] [sound?] possible deadlock in snd_timer_close_locked
In-Reply-To: <00000000000099d9850613b12348@google.com>
References: <00000000000099d9850613b12348@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: 0.88
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="NN0PobY/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="HKf/3iGS"
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_HAM(-0.11)[66.29%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[f3bc6f8108108010a03d];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7A63621DD1

#syz dup: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)

