Return-Path: <linux-kernel+bounces-149660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178B28A942E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7812282E42
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33B6A343;
	Thu, 18 Apr 2024 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LU7VnbbG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l0h2QIar";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LU7VnbbG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l0h2QIar"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583D25757;
	Thu, 18 Apr 2024 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425833; cv=none; b=mMRPfVcGFgCLJXCAWPfFFY5K9MIK8rzEESVXXzkiC1umWtMP5LfWCdUMFvTXLCo1Xbj5suhcSgtB0FmKxYxBXD9o9mriRqV1PmOw/ZR3OGvUiSJdDntM9WajFT7feCSb/MwowEs/vQjmuqsWZrkduN8zNu7+QVWlLqfNVjfABvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425833; c=relaxed/simple;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kom1afMLDWgBOlprvWOoVwJAGeo4YSEdg4RTMKUlTOXXE35aC/45DNIP5CytlWlkQQOsWrS8X9vx6FK8tkEGJMECJuF6jm8Hr7rY/CT621492k84fYM2EeXZ+3PamUHBdGVmlbQvFWRH3WAmgKUjyO7Dhj+I6GukAgfvhTTl3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LU7VnbbG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l0h2QIar; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LU7VnbbG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l0h2QIar; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F03A5C5F1;
	Thu, 18 Apr 2024 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=LU7VnbbGLxqYzgYiX0Hkd+oCyfJ6JDgmrPqCBxEC7nCG/gruTBKgu/uUwzYRylgmCUMClU
	Mep7uMqiW8zH9nv8kyO+zTB8t0mxhUWK18aKI7dhxduoU7xNPnJGWVX35SVw4gtoxOFGUv
	Qdxi1C3JxTWqmMHFTFefZkWxvyIQHHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=l0h2QIaruQPzXMAUm1fZARD/IqHYDDTlNVCw+un+/3eeZYVK47tvEhAJ+B+sOMMyLLdjWS
	LKwOSaBvvDVrgPAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=LU7VnbbGLxqYzgYiX0Hkd+oCyfJ6JDgmrPqCBxEC7nCG/gruTBKgu/uUwzYRylgmCUMClU
	Mep7uMqiW8zH9nv8kyO+zTB8t0mxhUWK18aKI7dhxduoU7xNPnJGWVX35SVw4gtoxOFGUv
	Qdxi1C3JxTWqmMHFTFefZkWxvyIQHHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=l0h2QIaruQPzXMAUm1fZARD/IqHYDDTlNVCw+un+/3eeZYVK47tvEhAJ+B+sOMMyLLdjWS
	LKwOSaBvvDVrgPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E08641384C;
	Thu, 18 Apr 2024 07:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u0uKNaTNIGZiDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 07:37:08 +0000
Date: Thu, 18 Apr 2024 09:37:17 +0200
Message-ID: <878r1bxgsy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+3e603db0222a2db35117@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] INFO: rcu detected stall in snd_timer_user_release (2)
In-Reply-To: <000000000000f0aed206159ef199@google.com>
References: <000000000000f0aed206159ef199@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [0.23 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.97)[86.78%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	SINGLE_SHORT_PART(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[3e603db0222a2db35117];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 0.23
X-Spam-Flag: NO

#syz fix: ALSA: timer: Fix missing irq-disable at closing

