Return-Path: <linux-kernel+bounces-102795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF787B764
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120E21C22452
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21161C8F3;
	Thu, 14 Mar 2024 05:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zl94Rkwx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I+V2Jn7Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zl94Rkwx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I+V2Jn7Q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A887946F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395188; cv=none; b=a6E12Pzvu107vg4YMl5+mxLl+zaI28swOxOPwbqVnKlGjKjpqpTX6FKW1FJYz2y7O/BFHn25T858HmiUwvUIQp4wqGsO4rxnroP4KtVmifTqOGqnsakv3mSXOQd1Mz9kwf7KhJy0yRfIr9SrOOJ/IxDe6XBQjRnmrWZlw7T+DRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395188; c=relaxed/simple;
	bh=D8zExSI2OK4S0nyC+LQjbDlvMCm93aBzf8E89A6gvLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpPzOf6vAbc9tuF5auXTYniHUohi+6qNjo8e69HYqReBRGOFCVrDhTltu6k+UWunBzSMx7h0LELq6KEV5fClqaZRy04fuNCGIrknozEtQq20jooPVJmwVlicZBj0xNYxd91kckOe9LHd+VDwpHjKnRYVW0WruhxP+V4PTowMZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zl94Rkwx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I+V2Jn7Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zl94Rkwx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I+V2Jn7Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 633491F385;
	Thu, 14 Mar 2024 05:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710395184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xplSUO906Kg9ND3q4B9jv0ocDlR66ubyYqeKd2JXDvI=;
	b=Zl94Rkwxbd7QmhMYg9eTLyAlcEKuW1d3lMTrU9SmhWxgMga6zIh79FRl+VFxCpZ6yWy0Dd
	hdcBSAsPGedurGunElP0GFPWqHlpZgDNGiNiJptqDLOK/RmkLM3mokal5diV+54D2MHSXP
	LiY2f7Hy/vWQE/Ih4KkSxqrhdnpLzE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710395184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xplSUO906Kg9ND3q4B9jv0ocDlR66ubyYqeKd2JXDvI=;
	b=I+V2Jn7QgibeQwroEqDD5X6iIRNxWBOgRDH5Q2w1VY19HoaQ3KiP4w2hTLBIW3neejbAOO
	6H8tDLSVlVjcLpCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710395184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xplSUO906Kg9ND3q4B9jv0ocDlR66ubyYqeKd2JXDvI=;
	b=Zl94Rkwxbd7QmhMYg9eTLyAlcEKuW1d3lMTrU9SmhWxgMga6zIh79FRl+VFxCpZ6yWy0Dd
	hdcBSAsPGedurGunElP0GFPWqHlpZgDNGiNiJptqDLOK/RmkLM3mokal5diV+54D2MHSXP
	LiY2f7Hy/vWQE/Ih4KkSxqrhdnpLzE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710395184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xplSUO906Kg9ND3q4B9jv0ocDlR66ubyYqeKd2JXDvI=;
	b=I+V2Jn7QgibeQwroEqDD5X6iIRNxWBOgRDH5Q2w1VY19HoaQ3KiP4w2hTLBIW3neejbAOO
	6H8tDLSVlVjcLpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9AA413961;
	Thu, 14 Mar 2024 05:46:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kLhTLi+P8mVLcQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 Mar 2024 05:46:23 +0000
Date: Thu, 14 Mar 2024 06:47:43 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lei Yang <leiyang@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] mm,page_owner: Fix recursion
Message-ID: <ZfKPf_pGxv-xtSPN@localhost.localdomain>
References: <20240313234245.18824-1-osalvador@suse.de>
 <2ff96a50-fc65-4e42-b15d-097c0f15a455@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff96a50-fc65-4e42-b15d-097c0f15a455@I-love.SAKURA.ne.jp>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zl94Rkwx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I+V2Jn7Q
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.81 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.30)[90.09%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -4.81
X-Rspamd-Queue-Id: 633491F385
X-Spam-Flag: NO

On Thu, Mar 14, 2024 at 12:01:24PM +0900, Tetsuo Handa wrote:
> Maybe culprit for a page owner refcount bug reported at
> https://syzkaller.appspot.com/bug?id=8e4e66dfe299a2a00204ad220c641daaf1486a00 , for
> that commit went to next-20240214 and syzbot started failing to test since next-20240215 ?
> 
> Please send this patch to linux-next.git as soon as possible (or can someone experiencing
> this bug try booting linux-next.git with this patch applied, so that we can check whether
> syzbot can resume testing linux-next.git), and then send to linux.git together (so that
> various trees which depend on linux.git won't start failing to boot).

No, that is something else that I already started fixing a few days ago.
I think I will have the fix ready today.


-- 
Oscar Salvador
SUSE Labs

