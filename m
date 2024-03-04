Return-Path: <linux-kernel+bounces-90969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41DB8707C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B923281697
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8C35C8EC;
	Mon,  4 Mar 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dmrsCZlk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ivc7oN7f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dmrsCZlk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ivc7oN7f"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031D5C90F;
	Mon,  4 Mar 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571412; cv=none; b=Ff3NXYHsqXIxZ6BfvUtdIOAHqNNrTK7/qAj0Gm+KNkDEYFplDMuCKKNh2+/1WAKtXC1nIqShQrP6pPGGAp080ML0UZOLPS/wl9nTnMb9goQaJKliSQeTHiGiObDNY5kbLBWK5jn0NMSTJBWq1tT2OJNUm3eidl6UPZyb/qR4bCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571412; c=relaxed/simple;
	bh=ZGMXcFuQrgx1SMeh//RuHHEKTwX4JgGSvJklkPh98+A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ty9y1M7HTIi37yDGW+bAkNdc3FfAGXGRSCjxkQj7YElqY1vYpooJdxQkLIPUazCnhNulDiiIdgyCMKIKM0lw9O+TiSNsBliDrIwnkIvH8TMCBkbxVKybuUcnCpn2Q9rQdltByyKjQ8Plm4WL+aXdzd00mEErOG/Xf/b7XToAbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dmrsCZlk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ivc7oN7f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dmrsCZlk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ivc7oN7f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CEDE33688;
	Mon,  4 Mar 2024 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709571409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X18wun2KPgEkmdf+nMDldpOLsokiS1pBuUIkbNKN0Jc=;
	b=dmrsCZlkGijUKt4OPFwE+aIuXT1qureSUgSqEQv3iJOtSpcVMLx4+8m00Y3BPHXLvQIy5X
	vJ38Z0PvADCOOKqMFK9HlYprqdbwV/a3NYIKje+f0SiTH5V7WSDLVeuF+Fvd/6dSfHDhr4
	d6qWybpfVftpH01YmFHzMtuUbKt0jBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709571409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X18wun2KPgEkmdf+nMDldpOLsokiS1pBuUIkbNKN0Jc=;
	b=ivc7oN7fe5rpjHA2qwoj4aFXG+p3OJvZpRqkl5c6Qs1H9K23FDr6B1gk8YDBHDq/TcOZBx
	MZNl9qLkLjZsTnAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709571409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X18wun2KPgEkmdf+nMDldpOLsokiS1pBuUIkbNKN0Jc=;
	b=dmrsCZlkGijUKt4OPFwE+aIuXT1qureSUgSqEQv3iJOtSpcVMLx4+8m00Y3BPHXLvQIy5X
	vJ38Z0PvADCOOKqMFK9HlYprqdbwV/a3NYIKje+f0SiTH5V7WSDLVeuF+Fvd/6dSfHDhr4
	d6qWybpfVftpH01YmFHzMtuUbKt0jBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709571409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X18wun2KPgEkmdf+nMDldpOLsokiS1pBuUIkbNKN0Jc=;
	b=ivc7oN7fe5rpjHA2qwoj4aFXG+p3OJvZpRqkl5c6Qs1H9K23FDr6B1gk8YDBHDq/TcOZBx
	MZNl9qLkLjZsTnAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D7DB13A5B;
	Mon,  4 Mar 2024 16:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iHG3AVH95WX1BAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 Mar 2024 16:56:49 +0000
Date: Mon, 04 Mar 2024 17:56:48 +0100
Message-ID: <87il223pgv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pavin Joseph <me@pavinjoseph.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: guide on bisecting (was Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6)
In-Reply-To: <66019e35-5adb-4817-a64d-e379b6f4240a@pavinjoseph.com>
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
	<7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
	<3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
	<a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
	<806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
	<4630483e-fc4e-448d-8fd6-916d3422784e@leemhuis.info>
	<66019e35-5adb-4817-a64d-e379b6f4240a@pavinjoseph.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dmrsCZlk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ivc7oN7f
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.93 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.92)[86.30%]
X-Spam-Score: -4.93
X-Rspamd-Queue-Id: 4CEDE33688
X-Spam-Flag: NO

On Sun, 03 Mar 2024 11:17:44 +0100,
Pavin Joseph wrote:
> 
> On 3/3/24 14:06, Thorsten Leemhuis wrote:
> 
> >> 2. The "installkernel" command is called "kernel-install" in OpenSuse,
> > 
> > Yeah, it looks like that, but that's not really the case. :-) In short:
> > on Fedora "installkernel" calls into kernel-install -- and
> > "installkernel" has a long history, so doing what Fedora does is likely
> > a wise thing for distros. And openSUSE had a "installkernel" as well,
> > which was part of the dracut package. Not sure if that is still the case
> > for current Leap and Tumbleweed. Could you check?
> 
> It's not available even as a symlink in OpenSuse TW / Slowroll I'm afraid.
> 
> suse-pc:~ # whereis installkernel
> installkernel:
> suse-pc:~ # whereis kernel-install
> kernel-install: /usr/bin/kernel-install
> /usr/share/man/man8/kernel-install.8.gz
> suse-pc:~ # man kernel-install | grep -i installkernel
>        installkernel [OPTIONS...] VERSION VMLINUZ [MAP] [INSTALLATION-DIR]
>        When invoked as installkernel, this program accepts arguments
> as specified by the kernel build system's make install command. The
> VERSION and VMLINUZ parameters

FYI, /usr/sbin/installkernel is included in kernel-install-tools
package.


Takashi

