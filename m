Return-Path: <linux-kernel+bounces-40009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206B83D8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F8D1F28849
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7818C1B;
	Fri, 26 Jan 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G8tAny3F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G8tAny3F"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6412B84
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266639; cv=none; b=cQm4ZZgFnkRpxGLvP3tCjTxkvSNkM4u5y3mHFB6kEOz6VMmAyrWptf+O0DQm1syw0vT6ChJHRjagUyZu4lNdPhSj/SATgQAJkKodHYsQ9yn7aUVqc4cKP7hEIBOdD1Kjj3xgoiZDQFZoGrU1hhBwpHNagzCGc1ozOOtJhIKFWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266639; c=relaxed/simple;
	bh=NsW7tmFOoZQtL0c0IKwhjYT+xrlehqti7MvzXSJf1wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwI/ukygJSdC/6pHo5Cj2Rew/xoQz9x5hD1JQsiobSMqtVnCMEhK0z/CmWLkj4e+UkKVxJR3SAKPw/JtarAGnzY6Oz92CdbpJaxvSuop/pqVdyTJ5Cn4+lEurMDliU0VjYBx8GmjmyaS8a1Q3niTVo1+kSrv225j+16ejc3sJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G8tAny3F; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G8tAny3F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AF0C1FD9E;
	Fri, 26 Jan 2024 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706266635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJkySAAGmHdAQNOm7UkH9kJ80ptWT6pGsZVtoPtZ6kw=;
	b=G8tAny3FgdJv1kzbj03ZHA1YNTXB9ES1Ve2yiSEpPnzpjtMMPvvxuB06VYIL4bwlcEyk3G
	7InyOukpfF/LAHbjY5MPbAT09kbk+5YzofzgeJ8EGFWqZUb3E52N/U6G4Xx0zoCX0b7Z7d
	+8VpW19RrIewxJEZg2WaAyZqu64Qm0w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706266635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJkySAAGmHdAQNOm7UkH9kJ80ptWT6pGsZVtoPtZ6kw=;
	b=G8tAny3FgdJv1kzbj03ZHA1YNTXB9ES1Ve2yiSEpPnzpjtMMPvvxuB06VYIL4bwlcEyk3G
	7InyOukpfF/LAHbjY5MPbAT09kbk+5YzofzgeJ8EGFWqZUb3E52N/U6G4Xx0zoCX0b7Z7d
	+8VpW19RrIewxJEZg2WaAyZqu64Qm0w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72C9813A22;
	Fri, 26 Jan 2024 10:57:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GpwEHAuQs2XVKgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 26 Jan 2024 10:57:15 +0000
Date: Fri, 26 Jan 2024 11:57:15 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zach O'Keefe <zokeefe@google.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	david@redhat.com, vbabka@suse.cz, hannes@cmpxchg.org,
	quic_pkondeti@quicinc.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
Message-ID: <ZbOQC0mYNsX0voKM@tiehlicka>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
 <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka>
 <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
 <CAAa6QmRnfTOCD0uaxVbbiDRWtwzC9y+gZDFOjYF2YWDTrXyMNQ@mail.gmail.com>
 <5adb12eb-8403-5860-28eb-5f6ab12f3c04@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5adb12eb-8403-5860-28eb-5f6ab12f3c04@quicinc.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.23)[72.63%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.17

On Fri 26-01-24 16:17:04, Charan Teja Kalla wrote:
> Hi Michal/Zach,
> 
> On 1/25/2024 10:06 PM, Zach O'Keefe wrote:
> > Thanks for the patch, Charan, and thanks to Yosry for pointing me towards it.
> > 
> > I took a look at data from our fleet, and there are many cases on
> > high-cpu-count machines where we find multi-GiB worth of data sitting
> > on pcpu free lists at the time of system oom-kill, when free memory
> > for the relevant zones are below min watermarks. I.e. clear cases
> > where this patch could have prevented OOM.
> > 
> > This kind of issue scales with the number of cpus, so presumably this
> > patch will only become increasingly valuable to both datacenters and
> > desktops alike going forward. Can we revamp it as a standalone patch?

Do you have any example OOM reports? There were recent changes to scale
the pcp pages and it would be good to know whether they work reasonably
well even under memory pressure.

I am not objecting to the patch discussed here but it would be really
good to understand the underlying problem and the scale of it.

Thanks!
-- 
Michal Hocko
SUSE Labs

