Return-Path: <linux-kernel+bounces-86291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C9886C37B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD081F23B05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B169842054;
	Thu, 29 Feb 2024 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cFQ0Eisi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cFQ0Eisi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1C4F8B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195426; cv=none; b=KQRFT1FeKdzmttms+CYPv+/oKSKOX70fYF9cCFwJHRX6FAuIWziBcl5jT5QCRH1IlgZGB5kpt+f/saYm9KmrspJ/ruJq3uT2DVzXnPwbtgemcvv58qscz769RMH0T+6gsRAaKaaq0cDgMzoM58T+oxR45KKelDE//wVnEtlBDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195426; c=relaxed/simple;
	bh=nvXnwWang543Kg4c1rLsND678RJN37g+hl7NuEMNX84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhwZi0LdTkop4kG830tA8Et0T8ww1s3B9eQUErXbBnwWvUKf16MsBByqLL8yMiWEMsDnW3womf0y4ieywfTAQ+0TDfqDDPGf39XzKr/OUcDOiT7cbgwg6+xNI8AzGd4KbBclv7K7vANc7OHdZ0h+dnUpfvdeJXViohqAKh5P+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cFQ0Eisi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cFQ0Eisi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 06D4E1F7D3;
	Thu, 29 Feb 2024 08:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709195417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3SgLAMcbyt4cYjxm3x7G7TRZQSDQ3+8ndmLBLajk+0=;
	b=cFQ0Eisi6y+xRU4yxRwMby5dwuB6KBXeIm0d0jk3KMQqs5gL3QbtGFaBOyAI4CypXc3/lT
	sQhqpUdxPn6A1eAzwQAZgry7638nQaw/+IoCEY1sh8sHo5UQ5J7PaWokfPk/THP8OJW2oJ
	9iX1aprQetoDWPUAtbwWhl03eNScpOQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709195417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3SgLAMcbyt4cYjxm3x7G7TRZQSDQ3+8ndmLBLajk+0=;
	b=cFQ0Eisi6y+xRU4yxRwMby5dwuB6KBXeIm0d0jk3KMQqs5gL3QbtGFaBOyAI4CypXc3/lT
	sQhqpUdxPn6A1eAzwQAZgry7638nQaw/+IoCEY1sh8sHo5UQ5J7PaWokfPk/THP8OJW2oJ
	9iX1aprQetoDWPUAtbwWhl03eNScpOQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFB1A13A58;
	Thu, 29 Feb 2024 08:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5L9+NJhA4GXmSwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 29 Feb 2024 08:30:16 +0000
Date: Thu, 29 Feb 2024 09:30:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2021-46966: ACPI: custom_method: fix potential
 use-after-free issue
Message-ID: <ZeBAlGNuNZNuCsE5@tiehlicka>
References: <2024022720-CVE-2021-46966-1469@gregkh>
 <Zd9b3qpu3uLFP-eN@tiehlicka>
 <2024022902-prancing-judgingly-c9ee@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022902-prancing-judgingly-c9ee@gregkh>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.67)[92.96%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.27

On Thu 29-02-24 06:22:34, Greg KH wrote:
> On Wed, Feb 28, 2024 at 05:14:22PM +0100, Michal Hocko wrote:
> > Hi,
> > this seems like another example of a reasonable fix with a very dubious
> > CVE IMHO. Allowing access to /sys/kernel/debug/acpi/custom_method to
> > anybody but trusted actor is a huge security problem on its own. I
> > really fail to see any value marking this clear bug fix as security
> > related.
> 
> It was picked because it was a use-after-free fix, AND it is part of the
> "import the GSD database into the CVE database" that the CVE project
> asked us to do.

OK I see. So now, does it make any sense to consider a bug fix in a
security sensitive interface (that is even locked down) a security fix?
-- 
Michal Hocko
SUSE Labs

