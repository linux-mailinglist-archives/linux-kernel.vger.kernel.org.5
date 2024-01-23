Return-Path: <linux-kernel+bounces-35192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165E0838D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA749283250
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95F45DF18;
	Tue, 23 Jan 2024 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uJS7tBRE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uJS7tBRE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0FA5D8F6;
	Tue, 23 Jan 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009067; cv=none; b=sSQUsXUlLgyT5ivVj2Si3CR4BM47/bNX7NGF2jNHwnggCzlWITW7UP/9bVisLadJVMseTzSWref3ZIkeRMMOlbyQZbGi+gXxaf0v0Meumz5DJxES893yluPXFQkJwZ31DWfhQARFMSEc48/u33dPsiWNXzQmAWMGg1WwcdnPmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009067; c=relaxed/simple;
	bh=LdlH+FZCo/lebULxBBkvBwm3D+DJpmiMfwER226JjcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhMvlT+83SNb3LhmDpN7nrnFxMFFk9iJnps9zJ3fT/T3Fd1C5MtUo+/XcHuco6+5Qv0ODMr8n4zaFidenAWW/OnZjHZQkPliNRJMxA4BFqCaLlq5/Mja23/WvlsvkRPjFRsAvuIgD1j7npIKrva164NK/QDafk4vGscZclR9FP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uJS7tBRE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uJS7tBRE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D00F220E8;
	Tue, 23 Jan 2024 11:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706009063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJVi99//neE1A58SAwm+ZzkimX+ETFoczgCsxNWrcA4=;
	b=uJS7tBREA3lOTaaMI672V0I10P/arXodIL7GKOlYHg2iYYi/wYWT+Me/mX43BVnl0er4qR
	k56V1CwSQn7N+qCnoEggom7JjGE1jCeN3vFf2UTMhBHQCpirQzUZ63UMs8tNjjt9Bn6tZq
	5OAnyHOUwT+SE2VjpvITD4r30XrQqnk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706009063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJVi99//neE1A58SAwm+ZzkimX+ETFoczgCsxNWrcA4=;
	b=uJS7tBREA3lOTaaMI672V0I10P/arXodIL7GKOlYHg2iYYi/wYWT+Me/mX43BVnl0er4qR
	k56V1CwSQn7N+qCnoEggom7JjGE1jCeN3vFf2UTMhBHQCpirQzUZ63UMs8tNjjt9Bn6tZq
	5OAnyHOUwT+SE2VjpvITD4r30XrQqnk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44FE4136A4;
	Tue, 23 Jan 2024 11:24:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OI/eDeehr2UQKwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 23 Jan 2024 11:24:23 +0000
Date: Tue, 23 Jan 2024 12:24:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "david@redhat.com" <david@redhat.com>,
	"quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"quic_cgoldswo@quicinc.com" <quic_cgoldswo@quicinc.com>
Subject: Re: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page
 blocks before oom
Message-ID: <Za-h5t7HX5rNrVdq@tiehlicka>
References: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
 <3fe3b3edd33cd784071dd9b459d20a79605ec918.camel@infinera.com>
 <2024012205-undrilled-those-2435@gregkh>
 <PH0PR10MB461565CEE892267025BC697BF4752@PH0PR10MB4615.namprd10.prod.outlook.com>
 <2024012210-outshoot-dragonish-fe8e@gregkh>
 <01010dd280badd149291cf4d2a4a88847113cf6d.camel@infinera.com>
 <Za-PWcwmHFl3wmth@tiehlicka>
 <98318c510e39cf83beaa07a4dbf33f18209eb358.camel@infinera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98318c510e39cf83beaa07a4dbf33f18209eb358.camel@infinera.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[14.05%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

On Tue 23-01-24 11:08:28, Joakim Tjernlund wrote:
[...]
> Mar  9 12:52:40 xr kern.warn kernel: [ 1066.001379] Mem-Info:
> Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665] active_anon:18 inactive_anon:2435 isolated_anon:0
> Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665]  active_file:1 inactive_file:0 isolated_file:0
> Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665]  unevictable:267 dirty:0 writeback:0
> Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665]  slab_reclaimable:384 slab_unreclaimable:2223
> Mar  9 12:52:40 xr kern.warn kernel: [ 1066.003665]  mapped:1 shmem:0 pagetables:309 bounce:0
> Mar  9 12:52:41 xr kern.warn kernel: [ 1066.003665]  kernel_misc_reclaimable:0
> Mar  9 12:52:41 xr kern.warn kernel: [ 1066.003665]  free:1054 free_pcp:24 free_cma:0
> Mar  9 12:52:41 xr kern.warn kernel: [ 1066.037938] Node 0 active_anon:72kB inactive_anon:9740kB active_file:4kB inactive_file:0kB unevictable:1068kB isolated(anon):0kB isolated(file):0kB mapped:4kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:9
> Mar  9 12:52:41 xr kern.warn kernel: [ 1066.061723] Normal free:4216kB min:128kB low:160kB high:192kB reserved_highatomic:4096KB active_anon:72kB inactive_anon:9740kB active_file:4kB inactive_file:0kB unevictable:1068kB writepending:0kB present:36864kB managed:2944
> Mar  9 12:52:41 xr kern.warn kernel: [ 1066.087595] lowmem_reserve[]: 0 0
> Mar  9 12:52:41 xr kern.warn kernel: [ 1066.090918] Normal: 206*4kB (MEH) 198*8kB (UMEH) 79*16kB (UMEH) 13*32kB (H) 2*64kB (H) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4216kB
> Mar  9 12:52:41 xr kern.warn kernel: [ 1066.104104] 269 total pagecache pages
> Mar  9 12:52:41 xr kern.warn kernel: [ 1066.107768] 9216 pages RAM

OK, so this is really a tiny system (36MB) and having 4MB in highatomic
reserves is clearly too much. So this matches the patch you are
referencing and it migh help you indeed.

Thanks!

-- 
Michal Hocko
SUSE Labs

