Return-Path: <linux-kernel+bounces-120440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF9F88D77A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D78299F38
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C22C69D;
	Wed, 27 Mar 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d6Ekj9b6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g6A4UAyx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d6Ekj9b6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g6A4UAyx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36F2C1AA;
	Wed, 27 Mar 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525230; cv=none; b=hrnBvGWjLN7YghrjMeXqhGWvFHS3X6s6nRVof3psox6osK/H/PR5XPX7GcUbLU20kv8d+QDaUdbkw7dsTn+9LItfr5yqllgLmIqCOqjhw6tTI7NULnIZuLG/4My0N57H+F9fcvJU7+Ng9ZuInA7PBxDscAtS+IwAILNfToEc114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525230; c=relaxed/simple;
	bh=nn2BDOr2BCIekUSUO9oL3jzqNlqdrqYPxziN82NCkrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1zyfsIaEv80jorXs5I9ACIjvGEfNP+YxKEo62ADMeglnBUdCTokDyia2Z2EaPB1xrACWQTpT7gHuPRc8F5Z4Uev0Ojm+9GPzySaZOjEsuJLNGa3HiIl+BRuNelnFNP0pldi/TFir2sUDH7lgeX9S9TkXHP8s8QwNkCPU0OvLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d6Ekj9b6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g6A4UAyx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d6Ekj9b6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g6A4UAyx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8A8D60010;
	Wed, 27 Mar 2024 07:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711525226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thcqS+vw6Usq7MYZ7czl11khcu2wqBEm+Lcfikv4tgs=;
	b=d6Ekj9b6oB4yrYj3hmvCy7RpYniA8W6bBY7viSSwSp33vzrqUqFLbNrNqEUZoQGRmj0D/Y
	qqh88zp/T2M+7NAIZiuiVSfI0jp5OVb7RR6h/o+o8yR+2iN9nc36P586HPDDaySFeFoh3c
	mQSH+iosB44feCz9zRfOFMSz4fUiSZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711525226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thcqS+vw6Usq7MYZ7czl11khcu2wqBEm+Lcfikv4tgs=;
	b=g6A4UAyxG5rVoaC7eyoPyfcwedap2u1OoO4C1B1XWk9zUzJ+xwvwlit02AOLHnfZptL851
	6O+Cmw3MCK0KBtDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711525226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thcqS+vw6Usq7MYZ7czl11khcu2wqBEm+Lcfikv4tgs=;
	b=d6Ekj9b6oB4yrYj3hmvCy7RpYniA8W6bBY7viSSwSp33vzrqUqFLbNrNqEUZoQGRmj0D/Y
	qqh88zp/T2M+7NAIZiuiVSfI0jp5OVb7RR6h/o+o8yR+2iN9nc36P586HPDDaySFeFoh3c
	mQSH+iosB44feCz9zRfOFMSz4fUiSZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711525226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thcqS+vw6Usq7MYZ7czl11khcu2wqBEm+Lcfikv4tgs=;
	b=g6A4UAyxG5rVoaC7eyoPyfcwedap2u1OoO4C1B1XWk9zUzJ+xwvwlit02AOLHnfZptL851
	6O+Cmw3MCK0KBtDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 245101369F;
	Wed, 27 Mar 2024 07:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6TiVNmjNA2aZfQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 Mar 2024 07:40:24 +0000
Message-ID: <65576638-2d23-4916-8e2a-84f949d360c1@suse.de>
Date: Wed, 27 Mar 2024 08:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] scsi: mylex: fix sysfs buffer lengths
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, llvm@lists.linux.dev,
 Hannes Reinecke <hare@kernel.org>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326223825.4084412-1-arnd@kernel.org>
 <20240326223825.4084412-8-arnd@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240326223825.4084412-8-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d6Ekj9b6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g6A4UAyx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -5.50
X-Rspamd-Queue-Id: B8A8D60010
X-Spam-Flag: NO

On 3/26/24 23:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The myrb and myrs drivers use an odd way of implementing their sysfs files,
> calling snprintf() with a fixed length of 32 bytes to print into a page
> sized buffer. One of the strings is actually longer than 32 bytes, which
> clang can warn about:
> 
> drivers/scsi/myrb.c:1906:10: error: 'snprintf' will always be truncated; specified size is 32, but format string expands to at least 34 [-Werror,-Wformat-truncation]
> drivers/scsi/myrs.c:1089:10: error: 'snprintf' will always be truncated; specified size is 32, but format string expands to at least 34 [-Werror,-Wformat-truncation]
> 
> These could all be plain sprintf() without a length as the buffer is
> always long enough. On the other hand, sysfs files should not be overly
> long either, so just double the length to make sure the longest strings
> don't get truncated here.
> 
> Fixes: 77266186397c ("scsi: myrs: Add Mylex RAID controller (SCSI interface)")
> Fixes: 081ff398c56c ("scsi: myrb: Add Mylex RAID controller (block interface)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/myrb.c | 20 ++++++++++----------
>   drivers/scsi/myrs.c | 24 ++++++++++++------------
>   2 files changed, 22 insertions(+), 22 deletions(-)
> 
Yeah, counting is hard ...

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


