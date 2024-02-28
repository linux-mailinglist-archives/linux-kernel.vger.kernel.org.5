Return-Path: <linux-kernel+bounces-85344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED986B474
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C51286BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DE63FB87;
	Wed, 28 Feb 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f2D1H+Rh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f2D1H+Rh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3D3FB84
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136871; cv=none; b=ibT6N8dYsTU4VoPMxuOj35NQUkS+uG6CHWd+qMve7V4//SLmwFWTFo2Ml+XUQhNWmiw8tkUAg1f69gL7O+ojXt0azYo6W9XKf/Sosam7QO0KeTgp8ktt0lLslASBBnYBCnCCR2yB6g5QSflHViFv0H6S6UxjD9v+XC/TZCgf/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136871; c=relaxed/simple;
	bh=5UKELTO0yfJgdwq/+Rp2ZaQRhQKR+puxE1qnTZlvxOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBsnVfPHTI2ARw5aJgPyvpAJusN5NqX+g26wOUK/0seBTaMlfJKB0kJ48wQw0FhziEA/YlGngKlrbXPiAPAXR7ve1wzORx8RIpckoYxWTl1V8ctxPPd9ZPXCIg2axhlBxFgsqKoJI95WrEMF6xRKsI4ZVjwUHUx7iSzwUHXBCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f2D1H+Rh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f2D1H+Rh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E40E2208D;
	Wed, 28 Feb 2024 16:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709136867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j5NHauPdYRLgf8N6HfFDZgPYx3je4e+zkCprjDhdRAw=;
	b=f2D1H+RhXfNEGCEyrsGVU5YlArzN8rCzsgaQtTWVxvf6Qu0nzszwrqmyyit3pC3D/OadpO
	/I9JK0C2baDK5RQVZC5SMAyD9QBaTGoIOkz+z+iKpIuJQQysXA0SSOznPytcf6xMeOkgea
	/d2Slza9/okl2TYxoIGY1QrrMK3vzws=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709136867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j5NHauPdYRLgf8N6HfFDZgPYx3je4e+zkCprjDhdRAw=;
	b=f2D1H+RhXfNEGCEyrsGVU5YlArzN8rCzsgaQtTWVxvf6Qu0nzszwrqmyyit3pC3D/OadpO
	/I9JK0C2baDK5RQVZC5SMAyD9QBaTGoIOkz+z+iKpIuJQQysXA0SSOznPytcf6xMeOkgea
	/d2Slza9/okl2TYxoIGY1QrrMK3vzws=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9B1113A58;
	Wed, 28 Feb 2024 16:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DzP+NeJb32UjEAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 28 Feb 2024 16:14:26 +0000
Date: Wed, 28 Feb 2024 17:14:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2021-46966: ACPI: custom_method: fix potential
 use-after-free issue
Message-ID: <Zd9b3qpu3uLFP-eN@tiehlicka>
References: <2024022720-CVE-2021-46966-1469@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022720-CVE-2021-46966-1469@gregkh>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=f2D1H+Rh
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E40E2208D
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

Hi,
this seems like another example of a reasonable fix with a very dubious
CVE IMHO. Allowing access to /sys/kernel/debug/acpi/custom_method to
anybody but trusted actor is a huge security problem on its own. I
really fail to see any value marking this clear bug fix as security
related.

On Tue 27-02-24 19:47:26, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> ACPI: custom_method: fix potential use-after-free issue
> 
> In cm_write(), buf is always freed when reaching the end of the
> function.  If the requested count is less than table.length, the
> allocated buffer will be freed but subsequent calls to cm_write() will
> still try to access it.
> 
> Remove the unconditional kfree(buf) at the end of the function and
> set the buf to NULL in the -EINVAL error path to match the rest of
> function.
> 
> The Linux kernel CVE team has assigned CVE-2021-46966 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 4.4.195 with commit 4bda2b79a9d0 and fixed in 4.4.269 with commit 1d53ca5d1310
> 	Issue introduced in 4.9.195 with commit 5c12dadcbef8 and fixed in 4.9.269 with commit 8b04d57f30ca
> 	Issue introduced in 4.14.147 with commit 35b88a10535e and fixed in 4.14.233 with commit 90575d1d9311
> 	Issue introduced in 4.19.77 with commit e4467fb6ef54 and fixed in 4.19.191 with commit a5b26a2e362f
> 	Issue introduced in 5.4 with commit 03d1571d9513 and fixed in 5.4.118 with commit 72814a94c38a
> 	Issue introduced in 5.4 with commit 03d1571d9513 and fixed in 5.10.36 with commit 62dc2440ebb5
> 	Issue introduced in 5.4 with commit 03d1571d9513 and fixed in 5.11.20 with commit f16737caf41f
> 	Issue introduced in 5.4 with commit 03d1571d9513 and fixed in 5.12.3 with commit b7a5baaae212
> 	Issue introduced in 5.4 with commit 03d1571d9513 and fixed in 5.13 with commit e483bb9a991b
> 
> Please see https://www.kernel.org or a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2021-46966
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	drivers/acpi/custom_method.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/1d53ca5d131074c925ce38361fb0376d3bf7e394
> 	https://git.kernel.org/stable/c/8b04d57f30caf76649d0567551589af9a66ca9be
> 	https://git.kernel.org/stable/c/90575d1d9311b753cf1718f4ce9061ddda7dfd23
> 	https://git.kernel.org/stable/c/a5b26a2e362f572d87e9fd35435680e557052a17
> 	https://git.kernel.org/stable/c/72814a94c38a33239793f7622cec6ace1e540c4b
> 	https://git.kernel.org/stable/c/62dc2440ebb552aa0d7f635e1697e077d9d21203
> 	https://git.kernel.org/stable/c/f16737caf41fc06cfe6e49048becb09657074d4b
> 	https://git.kernel.org/stable/c/b7a5baaae212a686ceb812c32fceed79c03c0234
> 	https://git.kernel.org/stable/c/e483bb9a991bdae29a0caa4b3a6d002c968f94aa

-- 
Michal Hocko
SUSE Labs

