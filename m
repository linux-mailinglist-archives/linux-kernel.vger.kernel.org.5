Return-Path: <linux-kernel+bounces-149582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7308A9314
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CCC1C20BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4764F6F065;
	Thu, 18 Apr 2024 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tm2HkL3x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K2x9Gyy/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tm2HkL3x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K2x9Gyy/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEE58129;
	Thu, 18 Apr 2024 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421687; cv=none; b=AtSh/NILI8vQRIyCjMpYDRj6uOH4jlhUM2YvhR7tEueB08+ek+eiVjOJ+o/ByfhKZp2ISlQOH80VayPLybX7irp/aSkPqmtSOZR9+XqQKhbAkA/qTmjekWK2lxguR7h+X4HeU1YKreacesSHN+UZa8x7rfwWEpuKX7jGqvyXMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421687; c=relaxed/simple;
	bh=DhP+wdzR337uZ5KL27fznIhxVqt9DRsWldIIAKOEgm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjJvqy7yx8N4IQ7mSqS1Z5QExYmJgcy6W8hHqstwpabxWOHKcD9D0Ijd1t+4ai46OhkDEm7iyNA0s7o9w+uLTQGkTIGzncq0J4cPWZpt2mqwS3OywpBXPPMe6oLeemPGRKDjlkeJY1tuY59jdrJC5LuYRzbkr/rQMB5WRyKOEuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tm2HkL3x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K2x9Gyy/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tm2HkL3x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K2x9Gyy/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F3035C4ED;
	Thu, 18 Apr 2024 06:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713421683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGHryipV7m3ISlljFcCVSwJdP+QGddzGbQWc+EpBMrI=;
	b=tm2HkL3xVelzcBJRtWYwQkYmovSqm5VIyQt2W6YEldQAjji6WU0UirMlrJJ1JddMN77qZJ
	sUyr1dJtvdy17mHb0n7J/aQfB6K+XJPIikqZRZxIyYyn/lOzjrHP5PBiDd5IzMMjAaDg9K
	y2YEdYXMwTlxevsMic+rAZuz/EGO6gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713421683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGHryipV7m3ISlljFcCVSwJdP+QGddzGbQWc+EpBMrI=;
	b=K2x9Gyy/mYZOutVO1XXWOGeRnRGGyQRFTHqn7NC/nvMAstawRIYH3i8T4DOFImJ4AzWgP3
	O4W0GVfUHDsrAhCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tm2HkL3x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="K2x9Gyy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713421683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGHryipV7m3ISlljFcCVSwJdP+QGddzGbQWc+EpBMrI=;
	b=tm2HkL3xVelzcBJRtWYwQkYmovSqm5VIyQt2W6YEldQAjji6WU0UirMlrJJ1JddMN77qZJ
	sUyr1dJtvdy17mHb0n7J/aQfB6K+XJPIikqZRZxIyYyn/lOzjrHP5PBiDd5IzMMjAaDg9K
	y2YEdYXMwTlxevsMic+rAZuz/EGO6gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713421683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGHryipV7m3ISlljFcCVSwJdP+QGddzGbQWc+EpBMrI=;
	b=K2x9Gyy/mYZOutVO1XXWOGeRnRGGyQRFTHqn7NC/nvMAstawRIYH3i8T4DOFImJ4AzWgP3
	O4W0GVfUHDsrAhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D271D13687;
	Thu, 18 Apr 2024 06:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G62JMXK9IGb2cgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Apr 2024 06:28:02 +0000
Message-ID: <248d92b7-23b0-4c84-8c38-58d956b88a64@suse.de>
Date: Thu, 18 Apr 2024 08:28:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: API break, sysfs "capability" file
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Lennart Poettering <mzxreary@0pointer.de>
Cc: Keith Busch <kbusch@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de>
 <Zh6J75OrcMY3dAjY@gardel-login> <Zh6O5zTBs5JtV4D2@kbusch-mbp>
 <20240417151350.GB2167@lst.de> <Zh_vQG9EyVt34p16@gardel-login>
 <20240417155913.GA6447@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240417155913.GA6447@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2F3035C4ED
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On 4/17/24 17:59, Christoph Hellwig wrote:
> On Wed, Apr 17, 2024 at 05:48:16PM +0200, Lennart Poettering wrote:
>> Block devices with part scanning off are quite common after all,
>> i.e. "losetup" creates them by default like that, and partition block
>> devices themselves have no part scanning on and so on, hence we have
>> to be ablet to operate sanely with them.
> 
> Maybe and ioctl to turn on partition scanning if it is currently disabled
> or return an error otherwise would be the better thing?  It would
> do the right thing for the most common loop case, and with a bit more
> work could do the right thing for those that more or less disable it
> graciously (ubiblock, drbd, zram) and would just fail for those who are
> so grotty old code and slow devices that we never want to do a partition
> scan (basically old floppy drivers and the Nintendo N64 cartridge driver)
> 
> 
The world is going to end.
hch suggests an ioctl.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


