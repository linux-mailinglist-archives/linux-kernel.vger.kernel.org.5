Return-Path: <linux-kernel+bounces-52339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D88496E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617E51F21F68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4C12B9C;
	Mon,  5 Feb 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F4RF/AGr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F4RF/AGr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5FA12B6C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126310; cv=none; b=uHLqXHy7JLLjGwsaJ52WrZIV3r29MyHxMM4a85k1qzDJwxb2ePQekObTKjfZ3j7OFBNezlKHRcVUIf7jgKMIQmqq1A5htLmdWXMRkhaWyhhjIoPuLeL+/wPSY4tdsLR4bh4ZooQf3csL8TngxJuULUsNNLh/e1AnBD7aUlUg8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126310; c=relaxed/simple;
	bh=VV9FUqOvy6Sv2vardFnlMlacSDMO7EnZbd8LVZNinuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c33rtq66f4k1QvxaD9BB22z+QA5R+7+uMCocr4q6CGWxgz0DSVmT6U9uHNUisaAj8MOYjzAY2Z7WWX7YvIIsb7MpjpuiKjv22rIwGJaK2V+UcTVTBp5Ons5Z4bzGKor63fXL0MSBllhqC229PD2EKxA+lRTK4arhW3FB2cMLLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F4RF/AGr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F4RF/AGr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD2A422117;
	Mon,  5 Feb 2024 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707126306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFUS2eDQEhftuDnZIWOnU5+uJSL4llIAh8paW0Ywd3o=;
	b=F4RF/AGrHcSLPbYB6W0Sc6LXnGhZ3hkiKNhTW5785+6Thkvh+C45vLXGw9pZYWDJi8eYMQ
	YCrLAjuCx1xqWKTKEPq6rsXLp0onu7t8nbpIUdc19aff4ZpKaHDshPGYANnwxm5fihhLrD
	MULb6f3cqsQE45HusK/TQD+ggWlv7Co=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707126306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFUS2eDQEhftuDnZIWOnU5+uJSL4llIAh8paW0Ywd3o=;
	b=F4RF/AGrHcSLPbYB6W0Sc6LXnGhZ3hkiKNhTW5785+6Thkvh+C45vLXGw9pZYWDJi8eYMQ
	YCrLAjuCx1xqWKTKEPq6rsXLp0onu7t8nbpIUdc19aff4ZpKaHDshPGYANnwxm5fihhLrD
	MULb6f3cqsQE45HusK/TQD+ggWlv7Co=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3BE413707;
	Mon,  5 Feb 2024 09:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cyp0KSKuwGU+IwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 05 Feb 2024 09:45:06 +0000
Date: Mon, 5 Feb 2024 10:45:02 +0100
From: Michal Hocko <mhocko@suse.com>
To: Yang Shi <shy828301@gmail.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
	zokeefe@google.com, david@redhat.com, songmuchun@bytedance.com,
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on
 collapse
Message-ID: <ZcCuHmCh7a8fU6_3@tiehlicka>
References: <20240201125226.28372-1-ioworker0@gmail.com>
 <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka>
 <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka>
 <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
 <Zbz_ao0uBKabzKB1@tiehlicka>
 <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
 <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="F4RF/AGr"
X-Spamd-Result: default: False [0.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,google.com,redhat.com,bytedance.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.88%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.18
X-Rspamd-Queue-Id: DD2A422117
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Fri 02-02-24 09:42:27, Yang Shi wrote:
> But if the partial range is MADV_FREE, khugepaged won't skip them.
> This is what your second test case does.
> 
> Secondly, I think it depends on the semantics of MADV_FREE,
> particularly how to treat the redirtied pages. TBH I'm always confused
> by the semantics. For example, the page contained "abcd", then it was
> MADV_FREE'ed, then it was written again with "1234" after "abcd". So
> the user should expect to see "abcd1234" or "00001234".

Correct. You cannot assume the content of the first page as it could
have been reclaimed at any time.
 
> I'm supposed it should be "abcd1234" since MADV_FREE pages are still
> valid and available, if I'm wrong please feel free to correct me. If
> so we should always copy MADV_FREE pages in khugepaged regardless of
> whether it is redirtied or not otherwise it may incur data corruption.
> If we don't copy, then the follow up redirty after collapse to the
> hugepage may return "00001234", right?

Right. As pointed above this is a valid outcome if the page has been
dropped. User has means to tell that from /proc/vmstat though. Not in a
great precision but I think it would be really surprising to not see any
pglazyfreed yet the content is gone. I think it would be legit to call
it a bug. One could argue the bug would be in the accounting rather than
the khugepaged implementation because madvised pages could be dropped at
any time. But I think it makes more sense to copy the existing content.
-- 
Michal Hocko
SUSE Labs

