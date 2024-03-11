Return-Path: <linux-kernel+bounces-98527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BFD877B86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24AD2822BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AC10A23;
	Mon, 11 Mar 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pRv47pMC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pRv47pMC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D3F9D3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710144691; cv=none; b=O4mV3abY1kvSXIQulxE8bC5zT/sM0Psj7vdiuNrwYYNN743H+vn1WbDMUp2crK+Yd2yKdHs2ltcF7uYB3P3Ari+XxAI/BpwY8Zz0A8kNEqsQWRNQkmu848Rtte7tR6+GUdLk0jWy0xE0aaqjRgMiUSC20hT2ajiTJn4ZvamwbqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710144691; c=relaxed/simple;
	bh=GvMVwhc7m6QqztXIaZwXvKk6QhgmIbDJEgQhO3GK9TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2FOS7I7SKyMUCYYWXxAeRHBcqLHbG7k4hfm+Kqvh8GIycmd0LCErdRssfoZACxQiizbrunqGP/Zj0b2R5hzjXHQtPYmEqs6fZoC3x+iCY1z24pDulWLj0m6fdijf8dv2yCmIcA+um4MpH9LGGHIKn7PloKIXGHYDb15L/VjF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pRv47pMC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pRv47pMC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AAC5C5C3C9;
	Mon, 11 Mar 2024 08:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710144687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsgL6s5daCw4QS+x/VpUdCA1STEMpGAP/P9W7655jgY=;
	b=pRv47pMCwWHzJTCoj13uWA4NbkQ4f8dwnSTZOyc14ohlRI9ECju9IqJRfQtC+pPCqs7Bus
	LKpxNWMpAHQ5W9UzTEB7FLDTlqIellb8llAwpqiMzThekr/RfqPh7VYBtj6SDSus1PY1bw
	NhLqZTKiPR/m3TwxgnUFV/7VDd7AqtM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710144687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsgL6s5daCw4QS+x/VpUdCA1STEMpGAP/P9W7655jgY=;
	b=pRv47pMCwWHzJTCoj13uWA4NbkQ4f8dwnSTZOyc14ohlRI9ECju9IqJRfQtC+pPCqs7Bus
	LKpxNWMpAHQ5W9UzTEB7FLDTlqIellb8llAwpqiMzThekr/RfqPh7VYBtj6SDSus1PY1bw
	NhLqZTKiPR/m3TwxgnUFV/7VDd7AqtM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2C381383D;
	Mon, 11 Mar 2024 08:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oky5J6+87mWrZwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 11 Mar 2024 08:11:27 +0000
Date: Mon, 11 Mar 2024 09:11:27 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <Ze68r7_aTn6Vjbpj@tiehlicka>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030645-CVE-2023-52596-b98e@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.24)[89.50%]
X-Spam-Score: -0.84
X-Spam-Flag: NO

On Wed 06-03-24 06:45:54, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> sysctl: Fix out of bounds access for empty sysctl registers
> 
> When registering tables to the sysctl subsystem there is a check to see
> if header is a permanently empty directory (used for mounts). This check
> evaluates the first element of the ctl_table. This results in an out of
> bounds evaluation when registering empty directories.
> 
> The function register_sysctl_mount_point now passes a ctl_table of size
> 1 instead of size 0. It now relies solely on the type to identify
> a permanently empty register.
> 
> Make sure that the ctl_table has at least one element before testing for
> permanent emptiness.

While this makes the code more robust and more future proof I do not think
this is fixing any real issue not to mention anything with security
implications. AFAIU there is no actual code that can generate empty
sysctl directories unless the kernel is heavily misconfigured.

Luis, Joel, what do you think?

-- 
Michal Hocko
SUSE Labs

