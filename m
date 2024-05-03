Return-Path: <linux-kernel+bounces-167290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8C8BA747
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB061F216D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAF1465A5;
	Fri,  3 May 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YZ1rNmbr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pi4MyNql";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UB8VjV2+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mB4wMTHQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AA139D00;
	Fri,  3 May 2024 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714719468; cv=none; b=XltiWbsIqVEnqDTQqeccY+Fao2BQo0B/GCssedMKCmo8t6zaJMb8RxtecQHsm8o3vCrPMhIFCyAatAG5o4bOucr7xgbd1Kh/6+Kp2vB1bizEDnt9V3BE7OjLPwBb9YA6QEmAimDZ7s2FXruN/ff62TGVTeaCjQoRPZrEFyBhlw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714719468; c=relaxed/simple;
	bh=joQqh3QSOY/472f0avmrUum+JUEohKnHf2cJ0A/y9r0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBfqAPzhoZoPd0WSyTH0R0ebtKrsiEuRSJymKZELvHqaP3yc/rWwM84vV94XYbH4Y8zW2dPn5urtxEURVWW1lbmeR7hofRoD7rh+qCSunsvPCqrIo2yy6I956shLqVB936NyvKGEOSP93eVDXhhqDUVJzonZKVFsEEAovIDFaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YZ1rNmbr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pi4MyNql; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UB8VjV2+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mB4wMTHQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4FB41FB61;
	Fri,  3 May 2024 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714719465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxRxPWAdxzXr4foLnpsqB7K/Is9SJ1N4uUXBELbk9JI=;
	b=YZ1rNmbrWnmHUtf3dUA37kiCmYUCrKNde4GFwzX51P9JCx12bnV3Xu0mGKddNyRIGZD48p
	2CYxhT5oQNqf1N9+1hhxO6t6IxTru2hyRjf8bJBAu5qIdogJ6sMLNwzC7zzaVVe7azy8Ye
	OKGKeBcjDvQWLkHLirCZ4/YAPPOpRg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714719465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxRxPWAdxzXr4foLnpsqB7K/Is9SJ1N4uUXBELbk9JI=;
	b=pi4MyNqluUYmYJF78N2Q+nVxwjx5c01ikH75sipkorgVrQuhxm8oem/SmYDPitKLNSbhto
	C/wUtY67WDHE8rDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714719463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxRxPWAdxzXr4foLnpsqB7K/Is9SJ1N4uUXBELbk9JI=;
	b=UB8VjV2+RlKOjDZ1N5qqM5ruKkcxB1N/SzbvW8Za52ibCF9I+uNcwn3Fn8D4TLBBz7pRgB
	geMgduv2swE4rfdtrChv4dKAVENwIGAMIhgQyAajwEqFEwLt84+8bhC66iSKqXhGz9+LJN
	UZ+hPeCibUynNC65fSFQq1IYwG6q5O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714719463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VxRxPWAdxzXr4foLnpsqB7K/Is9SJ1N4uUXBELbk9JI=;
	b=mB4wMTHQ9ivVUGc4l2IWMO943bwluJ1e46d7bot5lJvKiyEs227mIKUWqJLqHjtOksDzEV
	QEkGgXNxH3CHjYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 420B113991;
	Fri,  3 May 2024 06:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k87NCOeKNGbifAAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 03 May 2024 06:57:43 +0000
Date: Fri, 3 May 2024 08:57:40 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the dmi tree
Message-ID: <20240503085740.478d564b@endymion.delvare>
In-Reply-To: <20240430165017.4fa14188@canb.auug.org.au>
References: <20240430114613.0cef65fc@canb.auug.org.au>
	<20240430165017.4fa14188@canb.auug.org.au>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auug.org.au:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi Stephen,

On Tue, 30 Apr 2024 16:50:17 +1000, Stephen Rothwell wrote:
> On Tue, 30 Apr 2024 11:46:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > After merging the dmi tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> > 
> > In file included from include/asm-generic/bug.h:22,
> >                  from arch/arm/include/asm/bug.h:60,
> >                  from include/linux/bug.h:5,
> >                  from include/linux/thread_info.h:13,
> >                  from include/asm-generic/preempt.h:5,
> >                  from ./arch/arm/include/generated/asm/preempt.h:1,
> >                  from include/linux/preempt.h:79,
> >                  from include/linux/spinlock.h:56,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:7,
> >                  from include/linux/umh.h:4,
> >                  from include/linux/kmod.h:9,
> >                  from include/linux/module.h:17,
> >                  from drivers/firmware/dmi_scan.c:5:
> > drivers/firmware/dmi_scan.c: In function 'dmi_decode_table':
> > include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'int' [-Wformat=]
> >     5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
> >       |                         ^~~~~~
> > include/linux/printk.h:429:25: note: in definition of macro 'printk_index_wrap'
> >   429 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
> >       |                         ^~~~
> > include/linux/printk.h:510:9: note: in expansion of macro 'printk'
> >   510 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
> >       |         ^~~~~~
> > include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
> >    12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
> >       |                         ^~~~~~~~
> > include/linux/printk.h:510:16: note: in expansion of macro 'KERN_WARNING'
> >   510 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
> >       |                ^~~~~~~~~~~~
> > drivers/firmware/dmi_scan.c:109:25: note: in expansion of macro 'pr_warn'
> >   109 |                         pr_warn(FW_BUG
> >       |                         ^~~~~~~
> > 
> > Introduced by commit
> > 
> >   868577e6bfe1 ("firmware: dmi: Stop decoding on broken entry")
> > 
> > Include printk.h?  
> 
> This caused i386 defconfig build fail, so I have reverted this commit
> for today.

Sorry about that. I have amended the commit to use format %zd instead
of %ld. This passes my local user-space testing so hopefully it will
fix the i386 and armv7 builds as well.

-- 
Jean Delvare
SUSE L3 Support

