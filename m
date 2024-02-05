Return-Path: <linux-kernel+bounces-52809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02F3849CEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E51A284263
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7424B4A;
	Mon,  5 Feb 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u7cNB4RY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u7cNB4RY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAC028E09
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143001; cv=none; b=OlYfvMtcQi2Gw6KNVot+bn5IKXTYA82V9X/JHhsTqFB6792CQWHa5UoIGY5Gec7zKVe+ULt8cv+wyoQrcPzsdEJEe4yLt6LNlofKgtXgtlJf0iA2MlHE53pq3T6iL7YuVIK5pWxNN6VDqA/q78VYX7XTSvwdFpP0G/c0OLYQK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143001; c=relaxed/simple;
	bh=8EYhnczcsUIb3MlWJWfaOwH4YbNekzdkqbRJ4kTk1ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCgPa1V08/lbyW6io6FlWqwCbt+/JPnrbgyafP1Cj1bjV46IaAJQ3JkwiC9g+GAA7ydVFVCl0uBijjh6QieYseDDjsGqjV8zWU0AfLiwXkNtJbDV2lr36nZurcR0tkLL643bNmXqTgEaFJ391U/9Qld47czUlLoEt+WhtxrBKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u7cNB4RY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u7cNB4RY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C00122290;
	Mon,  5 Feb 2024 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707142997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XalqDAiHZdL3jRZo3gAv/IjBfwZgDQ2tWTGMS7xw7ls=;
	b=u7cNB4RYq2h6IZdXCao8Ifa0Uypsx37FSVptVegd4d2+hqtvGecMv9IECKcdcMwUYuqnhL
	ILO305eTznMRcDxf4yuBle5Zt2g/tyJmqCYcPjI7xFabdooso6v5iNATEi6Q+Ejj8XzqQl
	1xNZ6N7MTM5SJNpZDKt2YenSxsT5DNQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707142997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XalqDAiHZdL3jRZo3gAv/IjBfwZgDQ2tWTGMS7xw7ls=;
	b=u7cNB4RYq2h6IZdXCao8Ifa0Uypsx37FSVptVegd4d2+hqtvGecMv9IECKcdcMwUYuqnhL
	ILO305eTznMRcDxf4yuBle5Zt2g/tyJmqCYcPjI7xFabdooso6v5iNATEi6Q+Ejj8XzqQl
	1xNZ6N7MTM5SJNpZDKt2YenSxsT5DNQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81D95136F5;
	Mon,  5 Feb 2024 14:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kqW6HFXvwGVbbQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 05 Feb 2024 14:23:17 +0000
Date: Mon, 5 Feb 2024 15:23:16 +0100
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: hugetlb: remove __GFP_THISNODE flag when
 dissolving the old hugetlb
Message-ID: <ZcDvVA84s9-Azr33@tiehlicka>
References: <6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com>
 <Zbu4cD1XLFLfKan8@tiehlicka>
 <3f31cd89-f349-4f9e-bc29-35f29f489633@linux.alibaba.com>
 <ZbylJr_bbWCUMjMl@tiehlicka>
 <f1606912-5bcc-46be-b4f4-666149eab7bd@linux.alibaba.com>
 <Zby7-dTtPIy2k5pj@tiehlicka>
 <909cee7d-0201-4429-b85d-7d2662516e45@linux.alibaba.com>
 <ZcCnNPkNpE7KTHZu@tiehlicka>
 <2613b670-84f8-4f97-ab4e-0d480fc1a3f8@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2613b670-84f8-4f97-ab4e-0d480fc1a3f8@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.74)[83.92%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.34

On Mon 05-02-24 21:06:17, Baolin Wang wrote:
[...]
> > It is quite possible that traditional users (like large DBs) do not use
> > CMA heavily so such a problem was not observed so far. That doesn't mean
> > those problems do not really matter.
> 
> CMA is just one case, as I mentioned before, other situations can also break
> the per-node hugetlb pool now.

Is there any other case than memory hotplug which is arguably different
as it is a disruptive operation already.

> Let's focus on the main point, why we should still keep inconsistency
> behavior to handle free and in-use hugetlb for alloc_contig_range()? That's
> really confused.

yes, this should behave consistently. And the least surprising way to
handle that from the user configuration POV is to not move outside of
the original NUMA node.
-- 
Michal Hocko
SUSE Labs

