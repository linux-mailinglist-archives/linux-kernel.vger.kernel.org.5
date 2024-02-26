Return-Path: <linux-kernel+bounces-81739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D986798D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E305A29C6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702612CDB0;
	Mon, 26 Feb 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="umI3cTsq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="umI3cTsq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F412B167;
	Mon, 26 Feb 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959136; cv=none; b=ihIXBPYd6iSZm/85C7kE2KFWqqRGaiVtULaBb0CJDsS87HdPbpgbk/cLNSFLxZb8BeBuUO+8nR0CXs0PhVa9qsojTAnGx0eGri3Y1lnh1lYfafMCFjcezvuN8GCpztcNfgOFnYWMvU3+vhW3MEDBmvimZQGaxRBdX4Pmdv3xL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959136; c=relaxed/simple;
	bh=ItiAnz01Jft/2QGsGtbIhpFWLHN6F9+hJjcFcV43I4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP+MnWveJpxZkuQfUj2/Si9okojmobQm2zGUGgcOGVt7/fXLlt81E5uec/LPDkHN2auiwVztq2bSGMk3kwOS9t5YoROnLSRx6bEN41HrwPmblVTB3ZsEODTVQHm13P7Lia60OgrYLVHxLWFZQuj+d+ICCwkZwr63foPTpGmapHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=umI3cTsq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=umI3cTsq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7E5B1FB47;
	Mon, 26 Feb 2024 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708959132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7e/EkstDQtyQF2BtTgiuXQXk7xq8reb9bPrNVAQNOE=;
	b=umI3cTsqQ0xSeHt46djQ3sIx51fFQwbrUR8dOIMh30VZXjKc/k4Uznx0pwoUCCBd1JqZml
	JkuCq1R0u3eHY9O4eVAFVFmlZPGawvRifj6c7KLtSS6U5rp80W0PKu+6VaRiW4GMKOdxjt
	Hs8Phgok6y3qAQC8Nvb0FhlWvV1Hsxw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708959132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7e/EkstDQtyQF2BtTgiuXQXk7xq8reb9bPrNVAQNOE=;
	b=umI3cTsqQ0xSeHt46djQ3sIx51fFQwbrUR8dOIMh30VZXjKc/k4Uznx0pwoUCCBd1JqZml
	JkuCq1R0u3eHY9O4eVAFVFmlZPGawvRifj6c7KLtSS6U5rp80W0PKu+6VaRiW4GMKOdxjt
	Hs8Phgok6y3qAQC8Nvb0FhlWvV1Hsxw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DDCE13A58;
	Mon, 26 Feb 2024 14:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GHYSH5yl3GW8dAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 26 Feb 2024 14:52:12 +0000
Date: Mon, 26 Feb 2024 15:52:11 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <Zdylmz28rZ-mCeiN@tiehlicka>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022257-CVE-2023-52451-7bdb@gregkh>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=umI3cTsq
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
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
	 BAYES_HAM(-2.70)[98.71%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A7E5B1FB47
X-Spam-Level: 
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Thu 22-02-24 17:21:58, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> powerpc/pseries/memhp: Fix access beyond end of drmem array
> 
> dlpar_memory_remove_by_index() may access beyond the bounds of the
> drmem lmb array when the LMB lookup fails to match an entry with the
> given DRC index. When the search fails, the cursor is left pointing to
> &drmem_info->lmbs[drmem_info->n_lmbs], which is one element past the
> last valid entry in the array. The debug message at the end of the
> function then dereferences this pointer:
> 
>         pr_debug("Failed to hot-remove memory at %llx\n",
>                  lmb->base_addr);

While this is a reasonable fix and the stable material it is really
unclear to me why it has gained a CVE. Memory hotplug is a privileged
operation. Could you clarify please?

-- 
Michal Hocko
SUSE Labs

