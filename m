Return-Path: <linux-kernel+bounces-31139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF50832998
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59D1284DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF5C524AC;
	Fri, 19 Jan 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jY9Y+fhn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jY9Y+fhn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA11524A7;
	Fri, 19 Jan 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667850; cv=none; b=LZjdUxBo0tiy7AJjwKxLvSFwmrTL5g7/YS30PzdmXmlPejY8dStaChpRjPdgu3BHSjsDDZ3YxJfX9PFf7IxvEj3FUM0OWGLgEk19jjawEYxn0tQpJXjOVjjLuzkX1WZL/eZ0iXo0gpEPHQUdm4bGEjQLaJEoLf7hrghukZljdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667850; c=relaxed/simple;
	bh=SjwwPYaDeTn8+WySgdVe2Jy3obiU1LoQMOO+RVjo+a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhP0uak7lJqCdK00GGjRrCqicYvA2qBP2z+l3wnmvA98DCzevTCsW5Laj8SksLkbNbtmLPKpyUO6ZGzykcpwhBvDoxoRlqS+8amclxFeYbXjDGOb303eoBTinJ5L+OEuciLqxuHivd3kDDTPGeA0YTR6ZjuwAtInjreyaWNW+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jY9Y+fhn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jY9Y+fhn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5A4A21E4F;
	Fri, 19 Jan 2024 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705667840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEfBPVEz5WOmoy4eOtA/Y+8nJMYZBVOx5DSCH//+zbI=;
	b=jY9Y+fhnvNswaq/yxDtvbCiumzDhzm5ENMrwoS4y0n0NiyJXo343INe4d6CoNFycCOmqKV
	pecs+YiDIxcH4jbh0nSqghSw3JggeLzAM9TdqE+Fv9L692QQIk6dXIRuNpvmidh21+MvKF
	3qQyKNDdxIBMfsko7doteRIcOkZnCKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705667840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEfBPVEz5WOmoy4eOtA/Y+8nJMYZBVOx5DSCH//+zbI=;
	b=jY9Y+fhnvNswaq/yxDtvbCiumzDhzm5ENMrwoS4y0n0NiyJXo343INe4d6CoNFycCOmqKV
	pecs+YiDIxcH4jbh0nSqghSw3JggeLzAM9TdqE+Fv9L692QQIk6dXIRuNpvmidh21+MvKF
	3qQyKNDdxIBMfsko7doteRIcOkZnCKo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D201136F5;
	Fri, 19 Jan 2024 12:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MA54GwBtqmXLDQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 19 Jan 2024 12:37:20 +0000
Date: Fri, 19 Jan 2024 13:37:19 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT flag to
 process_madvise()
Message-ID: <Zaps_0jnspsheP92@tiehlicka>
References: <20240119115104.75456-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119115104.75456-1-ioworker0@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.45
X-Spamd-Result: default: False [-1.45 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.65)[82.59%]
X-Spam-Flag: NO

Please do not start a new version until all the outstanding points are
settled. This just fragments the discussion and makes it hard to follow
it.

Thanks!
-- 
Michal Hocko
SUSE Labs

