Return-Path: <linux-kernel+bounces-42955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F960840940
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE87E28B0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C13E1534F4;
	Mon, 29 Jan 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="saGxSX6N";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rggoIBsx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB277152E03
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540672; cv=none; b=ouqCET+sC7L/UGS5423TbAxj2w5KAyruk04KeVH0kLE0XUTz9Uj/rW0BM0FariNSK4+0LxPe1QP4sMng/ZBUTzN4Sb8TI30nS11MQt64cU3bOwFA+Nijc0V9Ym8Q1DAnRu6GBEc3kv4G0pkKJgyXJQGlg3HUxYVF7GNLZQppeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540672; c=relaxed/simple;
	bh=W71jzVeX/ucO0N44eoO+UKhuasj/ay4HyG1qWOve9E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyPcjJrKt8Dk0ARSOiisZvETK76oR8AJF+V7mXbyuQ89YqzzKbTb/oQn+J/WIRI/uTyK3dw9sXAIPG9JhdpLFMsKeVixqVzP6DSLE8iaVy3Nfq3jFmaX+Bm4Gr5Sv4PoHvWy8bQMkdg/6Lhx51YSA9gnO8LOLxXwYFnbiHh9pmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=saGxSX6N; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rggoIBsx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF0182229F;
	Mon, 29 Jan 2024 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706540669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLDYdWmw6CK2qQtrHRQgWWQYsKvJNWhiGQv/PrF1tIo=;
	b=saGxSX6N5mcW8/z9thvLMK5caQHOHCBZJOPUGc0sZVhwRuZhazmNFySksz/OUxiFGC+aii
	gFBHXnKLFwF+cae2M10qPoLPX62/20ECeUB3vaIiMFqkHNdV1VMJFP6yOGHhNchvCTFz7t
	TYb8b1Spj0lqrux2CAqcSZxPvn5OK94=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706540668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLDYdWmw6CK2qQtrHRQgWWQYsKvJNWhiGQv/PrF1tIo=;
	b=rggoIBsxma3yEW0oIshlsDtMevx74QEdciEc1yYE5AR2UwDobVchyv9b5u3O4s3D0rLLtV
	NXVXH28qVvWl1y2zAZJq5v4EeWU05vKrPBfELxDMwg0RKz1ediHLRmvctsqwICrdJWtPNZ
	CVo1J7VZboxv8X0TS+KUWSPWVFGinVo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0AC312FF7;
	Mon, 29 Jan 2024 15:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NHzoK3y+t2UQPwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 29 Jan 2024 15:04:28 +0000
Date: Mon, 29 Jan 2024 16:04:28 +0100
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
Message-ID: <Zbe-fEYUJYzq_3Ij@tiehlicka>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka>
 <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka>
 <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
 <CAAa6QmRnfTOCD0uaxVbbiDRWtwzC9y+gZDFOjYF2YWDTrXyMNQ@mail.gmail.com>
 <5adb12eb-8403-5860-28eb-5f6ab12f3c04@quicinc.com>
 <ZbOQC0mYNsX0voKM@tiehlicka>
 <CAAa6QmQwSRn=XdHjyjNxX0PrBCKbOovBVCYaDHKAzAzYYFZwug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmQwSRn=XdHjyjNxX0PrBCKbOovBVCYaDHKAzAzYYFZwug@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rggoIBsx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.54 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.53)[91.96%]
X-Spam-Score: -2.54
X-Rspamd-Queue-Id: DF0182229F
X-Spam-Flag: NO

On Fri 26-01-24 14:51:26, Zach O'Keefe wrote:
[...]
> Node 0 DMA32 free:66592kB min:2580kB low:5220kB high:7860kB
[...]
> free_pcp:8040kB local_pcp:244kB free_cma:0kB
> lowmem_reserve[]: 0 0 16029 16029
> Node 0 Normal free:513048kB min:513192kB low:1038700kB high:1564208kB
[...]
> mlocked:12344kB bounce:0kB free_pcp:790040kB local_pcp:7060kB
[...]
> mlocked:1588kB bounce:0kB free_pcp:253500kB local_pcp:12kB
[...]
> I'm not familiar with these changes, but a quick check of recent
> activity points to v6.7 commit fa8c4f9a665b ("mm: fix draining remote
> pageset") ; is this what you are referring to?

No, but looking at above discrepancy between free_pcp and local_pcp
would point that direction for sure. So this is worth checking.
vmstat is a periodic activity and it cannot really deal with bursts
of memory allocations but it is quite possible that the patch above
will prevent the build up before it grows that large.

I originally referred to different work though https://lore.kernel.org/all/20231016053002.756205-10-ying.huang@intel.com/T/#m9fdfabaee37db1320bbc678a69d1cdd8391640e0
merged as ca71fe1ad922 ("mm, pcp: avoid to drain PCP when process exit")
and the associated patches.

-- 
Michal Hocko
SUSE Labs

