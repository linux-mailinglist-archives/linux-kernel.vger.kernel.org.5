Return-Path: <linux-kernel+bounces-98701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A6877E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609291F21AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351BB34CD7;
	Mon, 11 Mar 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="luUOnhRA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="luUOnhRA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1B2EB08
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153177; cv=none; b=GzddZoISWkwVoPKN2hb1JkCrimBKx+/D/y558SDpylsJ1elkYrs7L08/DlJDWj3H5X9IxtBVcG/NKKJLMLeycE1XyLf4YgQxpOelxtp/Kaf+wjvQJS5lGWHJzqolhMVmPrvxdXr7bsFYszaS//iCFEvu1RnExFqIAvIYmhAjjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153177; c=relaxed/simple;
	bh=K9fAzrPJPqvu+B2JJF+RlAUiHT2VWJJP/pYMaj9WJy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcAztOM1WjIKUz0aFLpjZ0sJYNwotkSWrWE4OWwraBAu4M+UPeJAkWglkB04IUB3E26aHwdT+vlCTxFJ93Yn3wydubfb8HZnPLXIErQD1+4mi9FF/POGE0cLGFKDH1lE2JpVCw+EOASJ6trhbaocMGq3RZ4FBOqOBGxBV2stYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=luUOnhRA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=luUOnhRA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C621534B20;
	Mon, 11 Mar 2024 10:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710153173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YcWnpkr3AVvyBd0JYv/JEgu59vwaca6JStQ0tLDgRo=;
	b=luUOnhRAVAnPI0tdSYTTUjuEFmhHyUSKsaA+1yAmKxMI/ewU2AwuGAKWdhCGTypd89n0n+
	rNqMmuDzUZAalgoTOxpaHXW3ztqDvL11ow+9DqyiT9iaGt8JVtjN3UNzt1W+mZERQonuk3
	pTicxi2KGOqisLg0R/GUdZiXPe2Ue14=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710153173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YcWnpkr3AVvyBd0JYv/JEgu59vwaca6JStQ0tLDgRo=;
	b=luUOnhRAVAnPI0tdSYTTUjuEFmhHyUSKsaA+1yAmKxMI/ewU2AwuGAKWdhCGTypd89n0n+
	rNqMmuDzUZAalgoTOxpaHXW3ztqDvL11ow+9DqyiT9iaGt8JVtjN3UNzt1W+mZERQonuk3
	pTicxi2KGOqisLg0R/GUdZiXPe2Ue14=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB9E413777;
	Mon, 11 Mar 2024 10:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PanJLdXd7mWYHAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 11 Mar 2024 10:32:53 +0000
Date: Mon, 11 Mar 2024 11:32:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: CVE-2023-52514: x86/reboot: VMCLEAR active VMCSes before
 emergency reboot
Message-ID: <Ze7d0YCDKdu_LJWc@tiehlicka>
References: <2024030251-CVE-2023-52514-c93d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030251-CVE-2023-52514-c93d@gregkh>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.30)[90.09%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Sat 02-03-24 22:52:59, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> x86/reboot: VMCLEAR active VMCSes before emergency reboot
> 
> VMCLEAR active VMCSes before any emergency reboot, not just if the kernel
> may kexec into a new kernel after a crash.  Per Intel's SDM, the VMX
> architecture doesn't require the CPU to flush the VMCS cache on INIT.  If
> an emergency reboot doesn't RESET CPUs, cached VMCSes could theoretically
> be kept and only be written back to memory after the new kernel is booted,
> i.e. could effectively corrupt memory after reboot.
> 
> Opportunistically remove the setting of the global pointer to NULL to make
> checkpatch happy.
> 
> The Linux kernel CVE team has assigned CVE-2023-52514 to this issue.

I do not really see the security aspect of this fix. Guests systems
shouldn't be able to trigger host reboot nor any untrusted entity should
on the host either or this would be a serious security hole.

Or am I missing something?
-- 
Michal Hocko
SUSE Labs

