Return-Path: <linux-kernel+bounces-141936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A88A254B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C50E2832C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B41B977;
	Fri, 12 Apr 2024 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kruTySvx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DYLgv/65";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kruTySvx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DYLgv/65"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC81B946
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897216; cv=none; b=ch+Qzxh/rzXQs96qYLxiVDDkg81bjXX2wMEBt7iBAN4eSvNKF+0GR8TtVE8SkZi+EDsAF/0JsmfGTWc9sShKPsn7edymOh+W/DhfqGgAT/DBkU7LQ3cLbqocrne2LXW76gy2kE+xrKVLvCl+GEcEnxEdzGfRMMs5GtjHeNwd6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897216; c=relaxed/simple;
	bh=GbveZo8DTy1FqgUFY7Soxzy5Y2UI/POP8SzIhhwFCN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdUGDD6mFyQKWeY4wr31q7QG3W5bdnTYK1E5CZjsKgz0CZsYOBKyOftgmAg+om+AhZq7oWysg166lrk5ZYxpmQRVEjhdWD9KMGWGd2m7xK2tkXtxo785q+p66dBf9hmNsD5ieBb4VS8DdPJ+vOlZCfsezM5vnXu92cFpaU1RRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kruTySvx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DYLgv/65; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kruTySvx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DYLgv/65; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D4A95F7CE;
	Fri, 12 Apr 2024 04:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712897212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzAkqE+bPMpypfP3vKT+v39oEHNY7pm+SRWkVRiyy+A=;
	b=kruTySvxqabnvG8qLp1SxLD4u0HiGyhgI1koF1UrzvnNdEh53VOvjk2pXppdazKGGDgJ0L
	KjOar7RNrN1m1z204pWZPa9l3keZ1UReBTBSZK1qEOQ7W5DFWHWbLbPRcMO2IdAP+Q5Wha
	JdRYFMoKRrpmyvgASZaWYppH87J8MAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712897212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzAkqE+bPMpypfP3vKT+v39oEHNY7pm+SRWkVRiyy+A=;
	b=DYLgv/658GB+hkZYY1Zg/KmqaYNCObdzXQhKnJvr2cuyHJXMVEOAJHt0/AtroETPETfeOT
	Z8yBb7H9Z6H/jBAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712897212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzAkqE+bPMpypfP3vKT+v39oEHNY7pm+SRWkVRiyy+A=;
	b=kruTySvxqabnvG8qLp1SxLD4u0HiGyhgI1koF1UrzvnNdEh53VOvjk2pXppdazKGGDgJ0L
	KjOar7RNrN1m1z204pWZPa9l3keZ1UReBTBSZK1qEOQ7W5DFWHWbLbPRcMO2IdAP+Q5Wha
	JdRYFMoKRrpmyvgASZaWYppH87J8MAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712897212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzAkqE+bPMpypfP3vKT+v39oEHNY7pm+SRWkVRiyy+A=;
	b=DYLgv/658GB+hkZYY1Zg/KmqaYNCObdzXQhKnJvr2cuyHJXMVEOAJHt0/AtroETPETfeOT
	Z8yBb7H9Z6H/jBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12D9F1368B;
	Fri, 12 Apr 2024 04:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yKeUAby8GGZoOwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 12 Apr 2024 04:46:52 +0000
Date: Fri, 12 Apr 2024 06:46:50 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, willy@infradead.org,
	linmiaohe@huawei.com, jane.chu@oracle.com, muchun.song@linux.dev,
	nao.horiguchi@gmail.com
Subject: Re: [PATCH] mm/hugetlb: convert dissolve_free_huge_pages() to folios
Message-ID: <Zhi8uvQ87ZWUuhdC@localhost.localdomain>
References: <20240411164756.261178-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411164756.261178-1-sidhartha.kumar@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,infradead.org,huawei.com,oracle.com,linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Thu, Apr 11, 2024 at 09:47:56AM -0700, Sidhartha Kumar wrote:
> Allows us to rename dissolve_free_huge_pages() to
> dissolve_free_hugetlb_folio(). Convert one caller to pass in a folio
> directly and use page_folio() to convert the caller in mm/memory-failure.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

