Return-Path: <linux-kernel+bounces-118623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C57CB88BD65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F25B2326B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF4482D3;
	Tue, 26 Mar 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e3//BtmD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZrMDHEeC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e3//BtmD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZrMDHEeC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805A12E71;
	Tue, 26 Mar 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444519; cv=none; b=Yw/r+EvXwpn+BPfCU5fB9z3M8w6vXo84l+trzTG9RFUywmCoJQByEcWap9NbWf5S721z/nwOMi9iDBNsn6Rg4pxigvmn5gpUtGIgJDDnCZHSHkvII+c2I71ghxCS4brKEgceFGcBFXv9bsmPgXZgEYILNHvGYXZXdfNZxlmapb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444519; c=relaxed/simple;
	bh=/w1rMR/RsI7YUGioZ5VYFougOxYezZ5nebqI9JEo7Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5oeo1mrcoOiQS2aWxk9tPpxcbFy1PfnIM0oYCJu0MVm6G1cxVegLZOa8riBzOThcjSgBvW6KVSxLAvw17uDub1WmLT81DbZX153+sEY0iPgv2K2I6y1EwpjY/2UOXl6pKB8hXVtOTHFT6+7JGCiN9ZiZ1qQGQNhmMTDa7qQs68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e3//BtmD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZrMDHEeC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e3//BtmD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZrMDHEeC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 863AA5CAFF;
	Tue, 26 Mar 2024 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711444516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KVxLwH7OYog7GQroatyhSHlgdnjAUGhNH65+zOf/pbA=;
	b=e3//BtmDX//tOSy5JJvz1axljqE5y8Qj2rYdls/SSyA68pOkPSqP5BJR6EzuPZhk1MOwNR
	rQBxeOTVtNpdF3tLJV03ITzn/6CI57b7yfNDl9K7yplDC290i+4vMe6uS4JJhYhqwr7Uyb
	0nEbVchAKN9t+k6JZnb6YJkS73ttzow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711444516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KVxLwH7OYog7GQroatyhSHlgdnjAUGhNH65+zOf/pbA=;
	b=ZrMDHEeCjYWu8oDySMOH+Cxal45QE5wqJn6vMfdp26jEStDogwMpW6t/N1oKRjkQI1PINf
	XTS6x9qdR2Ob/hAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711444516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KVxLwH7OYog7GQroatyhSHlgdnjAUGhNH65+zOf/pbA=;
	b=e3//BtmDX//tOSy5JJvz1axljqE5y8Qj2rYdls/SSyA68pOkPSqP5BJR6EzuPZhk1MOwNR
	rQBxeOTVtNpdF3tLJV03ITzn/6CI57b7yfNDl9K7yplDC290i+4vMe6uS4JJhYhqwr7Uyb
	0nEbVchAKN9t+k6JZnb6YJkS73ttzow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711444516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KVxLwH7OYog7GQroatyhSHlgdnjAUGhNH65+zOf/pbA=;
	b=ZrMDHEeCjYWu8oDySMOH+Cxal45QE5wqJn6vMfdp26jEStDogwMpW6t/N1oKRjkQI1PINf
	XTS6x9qdR2Ob/hAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 29CD513587;
	Tue, 26 Mar 2024 09:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Ry+JBySSAma4AgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 26 Mar 2024 09:15:16 +0000
Date: Tue, 26 Mar 2024 10:16:44 +0100
From: Oscar Salvador <osalvador@suse.de>
To: syzbot <syzbot+73c1dfb19c10b7e49777@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] usb-testing boot error: WARNING: refcount bug in
 __reset_page_owner
Message-ID: <ZgKSfNM3lujt38-R@localhost.localdomain>
References: <000000000000151f4a06148c0966@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000151f4a06148c0966@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.39
X-Spamd-Result: default: False [-0.39 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.59)[81.65%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[73c1dfb19c10b7e49777];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO

On Tue, Mar 26, 2024 at 01:25:40AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
..
> ------------[ cut here ]------------
> refcount_t: decrement hit 0; leaking memory.
> WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31

This is fixed by [1]

[1] https://lore.kernel.org/linux-mm/20240326063036.6242-1-osalvador@suse.de/


