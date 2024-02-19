Return-Path: <linux-kernel+bounces-71274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBC385A2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54D11F247CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93B2D05F;
	Mon, 19 Feb 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="To78uyru";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A1NLMhrb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164382D045
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344134; cv=none; b=UPq9m8fG5RQnIQCrlYPGMpP751mB7ISqHuiEMJipREjcXhuDQP2DGn+qBizFf11XCqZUU3ALIj39uZT3E9oNtD01RCuwN1e3OYKTS1AdczjuIBS/h0elv/p/ZuXPpPTVeQobm6IEUO8hL3hQ+j+ASGOLurNlVpW9W9xZXOKmubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344134; c=relaxed/simple;
	bh=Bb6kPvv5oK092ISD8O2j3930bKBc8I2L5B8ZYVbUHDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8ND7WIalMqlN7b8Q4YH6sWqwovtneb+l5hIzIrtcIXZBj99kOTSxZ5nL0huCKkTvOeb2E2FUT0Vu0kMUrWAoFcwYflhpROBQS5+r6FOxotiMP0eUqNuQALoRLniNHeSSPZtbKk4SXb3maleUT7aVWZtfNjLK4D11VET4jEHhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=To78uyru; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A1NLMhrb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B7FB222F6;
	Mon, 19 Feb 2024 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708344131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQ67GULT9b2cq8o8yDuQQdBKS5DXm9sCybmVYMJMEs8=;
	b=To78uyrujPNe5UELxtzj2tigRKklvQJMo5Bv7bYjY6EM2HIKrbTpY0wcePEEYrEXoPuHrd
	IL8uqPD9sqMNi4Yt6UZhhEHBfb86stjJewTsS8cgZO+IGe8bAy4P7UzSVieM3EsM4HwdDo
	7OHSpE7LsHeA5ik/pEQaRYy3j3QvpEY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708344130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQ67GULT9b2cq8o8yDuQQdBKS5DXm9sCybmVYMJMEs8=;
	b=A1NLMhrb/o9+kAV69g5AXZVzzWIWvKlqCyj0Cb5nrQN8F1oLnbcBGvRZO0W3lL8ceMuiHH
	bMd2WSW19aOStA57+gs+lCfrH3Wv4OtMk8ZoI0Fs21SCtvaupNgvsHe5ED+9t6RfjToDeb
	ls2EMCTxMaQpPgDU958wMOiHLnFeTWU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D25E139D0;
	Mon, 19 Feb 2024 12:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XM7hAEJD02UfPAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 19 Feb 2024 12:02:10 +0000
Date: Mon, 19 Feb 2024 13:02:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Aneesh Kumar <aneesh.kumar@kernel.org>,
	Huang Ying <ying.huang@intel.com>,
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
Subject: Re: [PATCH 2/3] mm/mempolicy: Avoid the fallthrough with MPOLD_BIND
 in mpol_misplaced.
Message-ID: <ZdNDQUZrhz5kfR2f@tiehlicka>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <bf7e6779f842fb65cf7bb9b2c617feb2af271cb7.1708097962.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7e6779f842fb65cf7bb9b2c617feb2af271cb7.1708097962.git.donettom@linux.ibm.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=A1NLMhrb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.51)[91.79%]
X-Spam-Score: -2.52
X-Rspamd-Queue-Id: 3B7FB222F6
X-Spam-Flag: NO

On Sat 17-02-24 01:31:34, Donet Tom wrote:
> We will update MPOL_PREFERRED_MANY in the follow up patch. This change
> is required for that.

Why is it a separate patch then? Does it make review of the next patch
easier? If so make it explicit in the changelog.

> 
> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  mm/mempolicy.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 8478574c000c..73d698e21dae 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2515,7 +2515,15 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>  				break;
>  			goto out;
>  		}
> -		fallthrough;
> +
> +		if (node_isset(curnid, pol->nodes))
> +			goto out;
> +		z = first_zones_zonelist(
> +				node_zonelist(thisnid, GFP_HIGHUSER),
> +				gfp_zone(GFP_HIGHUSER),
> +				&pol->nodes);
> +		polnid = zone_to_nid(z->zone);
> +		break;
>  
>  	case MPOL_PREFERRED_MANY:
>  		/*
> -- 
> 2.39.3

-- 
Michal Hocko
SUSE Labs

