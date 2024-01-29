Return-Path: <linux-kernel+bounces-43100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F1840B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141B2B2810D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD06156977;
	Mon, 29 Jan 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XUTLamqS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XUTLamqS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D2157035
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545732; cv=none; b=ApGNeZufBwM7aPjEyqN4Y/vaWsU2yPQ1oEM4krr64lSnEIULFGDymRhN3wTDRZFRUuWUpQ9prjlO5Hzk/IuvxQE7ya4BDJA3x2PB5DcXls96oZVv3F/6hdJD9fIxF++dA1bf1iNUUOOL3Y67mmwulTektynASwyYr71P/O/NOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545732; c=relaxed/simple;
	bh=dLUua/FV/D+oSNf4wtskJdzGZLmArhy5mTtk5oBrNg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O47SyxYAqBRNIn2O6zB43k3NDt5WCAVu1pZWa3pdXcIfHNJ9Zawhi2xWsTkCK8NhAHZyD0B96MUnUnsfFhLZaVDusWzn4Iz9GnVjIaYk5he6nYfZFOzsOqLOMsUlUnmNASW+evSYwdJ9Bq1Cx+EYyOE9LrQc97/JF9AqC0xVp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XUTLamqS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XUTLamqS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50EB322113;
	Mon, 29 Jan 2024 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706545728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xNOhVEGA1+wfkSw8lLpS1nHrin/VwWv41XiZwlbriU0=;
	b=XUTLamqS6cd43HyhnadirfxcREIIdcSOwpPQRua7eYb0PQE6FwmmZFjot86SHgO4lr2i11
	qkNTftHHazJjiCwG00CUWJ+G4hiywzyL5mq/aenxyeVDiiEOVLmcwqzU3eruhQKNUVYqMV
	1SZy3nK9L/8NGIeJmwW4VTNi5A0IAjI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706545728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xNOhVEGA1+wfkSw8lLpS1nHrin/VwWv41XiZwlbriU0=;
	b=XUTLamqS6cd43HyhnadirfxcREIIdcSOwpPQRua7eYb0PQE6FwmmZFjot86SHgO4lr2i11
	qkNTftHHazJjiCwG00CUWJ+G4hiywzyL5mq/aenxyeVDiiEOVLmcwqzU3eruhQKNUVYqMV
	1SZy3nK9L/8NGIeJmwW4VTNi5A0IAjI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B30012FF7;
	Mon, 29 Jan 2024 16:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8lD2BkDSt2V0UwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 29 Jan 2024 16:28:48 +0000
Date: Mon, 29 Jan 2024 17:28:47 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
Message-ID: <ZbfSP6xt6JAE2NrH@tiehlicka>
References: <20240129054551.57728-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129054551.57728-1-ioworker0@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.81
X-Spamd-Result: default: False [-0.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.99%]
X-Spam-Flag: NO

On Mon 29-01-24 13:45:51, Lance Yang wrote:
> khugepaged scans the entire address space in the
> background for each given mm, looking for
> opportunities to merge sequences of basic pages
> into huge pages. However, when an mm is inserted
> to the mm_slots list, and the MMF_DISABLE_THP flag
> is set later, this scanning process becomes
> unnecessary for that mm and can be skipped to avoid
> redundant operations, especially in scenarios with
> a large address space.

Is this a real problem? I thought that the prctl is called
on the parent before fork/exec. Or are you aware of any
applications which do call prctl late enough that the race
would be actually observable?
-- 
Michal Hocko
SUSE Labs

