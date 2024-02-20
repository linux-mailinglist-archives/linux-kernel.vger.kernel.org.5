Return-Path: <linux-kernel+bounces-72645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC685B6A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A90F1F2505C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F05E5F56F;
	Tue, 20 Feb 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iVVZxCPB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iVVZxCPB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C925D499
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419832; cv=none; b=CAwVYO+xqyIBk7wsgT1peT62LWW1lwJ8edBAOga+7PEs3w4QyYjo8ih9Qg+KXnn6MLhsQo3IYFRaZhTFZNrwFpqFjkz7lxIutDvwTMZB2g6BxkOMLZLBcO/Oi+xUA54WCkyCEz7CI++hJfbHaBX4WkHsDMq53Wschnizy9cbxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419832; c=relaxed/simple;
	bh=Tuah+lE/AHRBBPadh3EjYkBT0UlPgFnjpUujxIFUhdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H35Org0kFyB73Q/XQD0OAI3zgeGUXhsSQMiKLdsMP4+lIukcoJvfbSd4MpVfO3TBuLJnff5ZtwX74L6qCysP7NO2tpxo85HM+oB85478zd5Wl5w/THvZEjoX83bTyVz2TWH10IDYBNRHwDUvs4a33yXNgW1vQQkEo0fVHNafijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iVVZxCPB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iVVZxCPB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CAA521F24;
	Tue, 20 Feb 2024 09:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708419829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtYF3RuaEm+NzlpgPch3zINQmsdJoPtf6DbiXYTNMqg=;
	b=iVVZxCPBaOVzA5M9nwoBJBcpQGc2PYQwp1JIIRZT+lN1W0GPw3oSP5y8MEzxQPiElAS7QB
	r1RdtkEiniDzN0srpEAeFF75zlV1MCyZaBvIw29RAi/TRg5KTWkMxYcXX2O4DcRMyRiHcm
	zycIpZm2E1F4q6ePgMSUFnivHLg1ea0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708419829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtYF3RuaEm+NzlpgPch3zINQmsdJoPtf6DbiXYTNMqg=;
	b=iVVZxCPBaOVzA5M9nwoBJBcpQGc2PYQwp1JIIRZT+lN1W0GPw3oSP5y8MEzxQPiElAS7QB
	r1RdtkEiniDzN0srpEAeFF75zlV1MCyZaBvIw29RAi/TRg5KTWkMxYcXX2O4DcRMyRiHcm
	zycIpZm2E1F4q6ePgMSUFnivHLg1ea0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D856139D0;
	Tue, 20 Feb 2024 09:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R92XCPVq1GUvYQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 20 Feb 2024 09:03:49 +0000
Date: Tue, 20 Feb 2024 10:03:48 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Donet Tom <donettom@linux.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
	Feng Tang <feng.tang@intel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
Message-ID: <ZdRq9EM1mDFXBiiO@tiehlicka>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
 <63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
 <20240219172130.82a16c1ebecbf8ba86a8987d@linux-foundation.org>
 <21f343fa-84a7-4539-91e2-6fc963dbfb62@kernel.org>
 <87frxnps8w.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <7097ff95-6077-4744-a770-b90d224c0c9b@kernel.org>
 <b599bfe5-1c4d-4750-b0d6-a086e1c8a34c@kernel.org>
 <8734tnppls.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734tnppls.fsf@yhuang6-desk2.ccr.corp.intel.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.76
X-Spamd-Result: default: False [-1.76 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.96)[86.68%]
X-Spam-Flag: NO

On Tue 20-02-24 15:22:07, Huang, Ying wrote:
[...]
> This isn't an issue now, because mpol_misplaced() are always called with
> PTL held.  And, we can still keep thiscpu local variable.

yes, this is the case but it would be better if we made that assumption
official by lockdep_assert_held

-- 
Michal Hocko
SUSE Labs

