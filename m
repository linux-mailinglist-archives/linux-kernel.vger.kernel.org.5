Return-Path: <linux-kernel+bounces-54712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8C84B2C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836D51F22687
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E91EB24;
	Tue,  6 Feb 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJkjoNDI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RdMXmhk8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NJkjoNDI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RdMXmhk8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B72E1EA6E;
	Tue,  6 Feb 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216718; cv=none; b=Kp+2PsC7CyGQ3cCe8LTo+2Lor5kIrgu9j5TFBRmaXF1Argnk23vZvOBlU+DPyr52osOcs//L/vnpNEgcLom4e9KZeY8VisULY/07Qloykn6SsWed4+sFexvockSOQeZj7rlKQ7sgZw9266tQ04pHBDfm4Vose7bJ1zekaruxxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216718; c=relaxed/simple;
	bh=i69KZPWZUZzRRoaXYbJqSaOZh4hwQA5j1UC+OGY2k7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWJsz5+JPHKXkbnHucerTLH1S4iitfUEBSq3ADwuXbH+QiUXeTBooApWfguaEfbosbpKQFo6tnNghhYS0HA6q9N+lO72rSTo6wACDdM2v40kMs/QHpeQGvUW5OoS0CxFcr9jWsCV+3qlEgaKFf6eT9euxW/pwx79a72Zx2ZUiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJkjoNDI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RdMXmhk8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NJkjoNDI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RdMXmhk8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0248C21EC3;
	Tue,  6 Feb 2024 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707216715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7byREWdKUM5PPHM09jDyPBZW0eUc0SM8ZnqWwduAmI=;
	b=NJkjoNDIf6YjlOHKIF17pgJkpXAODQa6WagiYj4av8pcCL4BayjU/Iza+QWpvEhpAXDGnP
	d7nSbAPUGdOgXjE0H8e6Uklp+q/msrdQOwNQcchihijiYudLl6M1I36fMiAYFMQqZA2QgA
	AUDB85fjHRpiyApFsVhk0Rr+2BKb8A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707216715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7byREWdKUM5PPHM09jDyPBZW0eUc0SM8ZnqWwduAmI=;
	b=RdMXmhk8VtJz1K9k9owMceEAHxT/Vhp2c/wSkLEiys3pu4AbrRm4pczMU8KZ8sW1lgMhna
	T/7Ve/wT4ibDPRAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707216715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7byREWdKUM5PPHM09jDyPBZW0eUc0SM8ZnqWwduAmI=;
	b=NJkjoNDIf6YjlOHKIF17pgJkpXAODQa6WagiYj4av8pcCL4BayjU/Iza+QWpvEhpAXDGnP
	d7nSbAPUGdOgXjE0H8e6Uklp+q/msrdQOwNQcchihijiYudLl6M1I36fMiAYFMQqZA2QgA
	AUDB85fjHRpiyApFsVhk0Rr+2BKb8A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707216715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7byREWdKUM5PPHM09jDyPBZW0eUc0SM8ZnqWwduAmI=;
	b=RdMXmhk8VtJz1K9k9owMceEAHxT/Vhp2c/wSkLEiys3pu4AbrRm4pczMU8KZ8sW1lgMhna
	T/7Ve/wT4ibDPRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44D66139D8;
	Tue,  6 Feb 2024 10:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iosMCkkPwmVdCQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 06 Feb 2024 10:51:53 +0000
Message-ID: <d5e68f29d6c835848295c10bac964da7a57f1bfe.camel@suse.de>
Subject: Re: linux-next: trees being removed
From: Jean Delvare <jdelvare@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List
	 <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Miller
 <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Hector Martin <marcan@marcan.st>, "Jason
 A. Donenfeld" <Jason@zx2c4.com>, Lee Jones <lee@kernel.org>, Micah Morton
 <mortonm@chromium.org>,  Mike Marshall <hubcap@omnibond.com>, Pavel Machek
 <pavel@ucw.cz>, Theodore Ts'o <tytso@mit.edu>
Date: Tue, 06 Feb 2024 11:50:44 +0100
In-Reply-To: <20240124130101.428c09a3@canb.auug.org.au>
References: <20240124130101.428c09a3@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NJkjoNDI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RdMXmhk8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[42.12%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,xmission.com,gmail.com,marcan.st,zx2c4.com,kernel.org,chromium.org,omnibond.com,ucw.cz,mit.edu];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.01
X-Rspamd-Queue-Id: 0248C21EC3
X-Spam-Flag: NO

Hi Stephen,

On Wed, 2024-01-24 at 13:01 +1100, Stephen Rothwell wrote:
> The following trees are going to be removed from linux-next because they
> have not been updated in more than a year.  If you want a tree restored,
> just let me know (and update its branch).
> 
> Tree                    Last commit date
>   URL
>   commits (if any)
> -----------------------------------------
> (...)
> dmi                     2022-09-23 14:53:14 +0200
>   git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git#dmi-for-next

This is still where I would put updates to the DMI subsystem, but it
turns out there haven't been any for some time now, and I'm not aware
of any pending issue.

Out of curiosity, why do inactive branches bother you?

I can certainly update that branch if it makes your life easier.

-- 
Jean Delvare
SUSE L3 Support

