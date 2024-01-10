Return-Path: <linux-kernel+bounces-22103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A11829940
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0251F23D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2106647A78;
	Wed, 10 Jan 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i5WnrtK0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GvXLzlrm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i5WnrtK0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GvXLzlrm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E447A57
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B10B22050;
	Wed, 10 Jan 2024 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704886806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpzFTdMgzrF/bRDMqkkAF7prlioCJWL+Tr7ovzeMZ7s=;
	b=i5WnrtK0uJdHs7RZHgGjmDksyIR2vlyi6FFvgFMDOjIxPACCBiHyBa/WMMLI14g/ulKN+r
	rEgleCs5oCks41aETB7IdcrniVaoDaCUQFDVSbaVvG1Z1Xw3SZ9u9O9Wn50+2VA5kNqT67
	4EZ0pRpmDH9trUdBZXSieCuT6PTVs+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704886806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpzFTdMgzrF/bRDMqkkAF7prlioCJWL+Tr7ovzeMZ7s=;
	b=GvXLzlrmSzZknnW+/T/Ia232d/v9ocwdJHO5ltR40IolXd6isrjdqM/yXHDTFlZVn25kuf
	VX0N7dQ+s9S68gCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704886806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpzFTdMgzrF/bRDMqkkAF7prlioCJWL+Tr7ovzeMZ7s=;
	b=i5WnrtK0uJdHs7RZHgGjmDksyIR2vlyi6FFvgFMDOjIxPACCBiHyBa/WMMLI14g/ulKN+r
	rEgleCs5oCks41aETB7IdcrniVaoDaCUQFDVSbaVvG1Z1Xw3SZ9u9O9Wn50+2VA5kNqT67
	4EZ0pRpmDH9trUdBZXSieCuT6PTVs+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704886806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YpzFTdMgzrF/bRDMqkkAF7prlioCJWL+Tr7ovzeMZ7s=;
	b=GvXLzlrmSzZknnW+/T/Ia232d/v9ocwdJHO5ltR40IolXd6isrjdqM/yXHDTFlZVn25kuf
	VX0N7dQ+s9S68gCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BBFB1398A;
	Wed, 10 Jan 2024 11:40:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kKIvHhaCnmURbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Jan 2024 11:40:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14EB6A07EB; Wed, 10 Jan 2024 12:40:06 +0100 (CET)
Date: Wed, 10 Jan 2024 12:40:06 +0100
From: Jan Kara <jack@suse.cz>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com>,
	Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_quota_write
Message-ID: <20240110114006.thu3mpuvyb7pdhzz@quack3>
References: <20240106024807.3011-1-hdanton@sina.com>
 <20240110111259.3285-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110111259.3285-1-hdanton@sina.com>
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i5WnrtK0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GvXLzlrm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[a43d4f48b8397d0e41a9];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FREEMAIL_TO(0.00)[sina.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 8B10B22050
X-Spam-Flag: NO

On Wed 10-01-24 19:12:59, Hillf Danton wrote:
> On Tue, 09 Jan 2024 10:17:07 -0800
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > kernel BUG in ext4_quota_write
> > 
> > EXT4-fs error (device loop0) in ext4_process_orphan:347: Corrupt filesystem
> > EXT4-fs (loop0): 1 truncate cleaned up
> > EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
> > ext4 filesystem being mounted at /root/syzkaller-testdir1916097639/syzkaller.TbSsym/0/file1 supports timestamps until 2038-01-19 (0x7fffffff)
> > ------------[ cut here ]------------
> > kernel BUG at fs/ext4/super.c:7251!
> 
> Given the BUG_ON in the debug patch tested, could deadlock be the reason
> behind the trigger instead of IO in flight? Or is it due to corrupted
> filesystem at the first place?

Thanks for the investigation! Based on your test results as well as on
results by Edward Adam Davis <eadavis@qq.com> I'd say syzbot has created a
cycle in the quota tree or something like that. Sadly the fs image provided
by syzbot is corrupted to the extent that e2fsprogs refuse to touch it so
I'll have to check manually why the kernel is mounting this image or what's
going on with the reproducer...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

