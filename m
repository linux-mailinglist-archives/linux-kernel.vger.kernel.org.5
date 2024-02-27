Return-Path: <linux-kernel+bounces-83478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472FA8699FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780FF1C24805
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7141214691C;
	Tue, 27 Feb 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rjmdEma7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gp5d5vbc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JlttwLCS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KTRl2pHa"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE2146909
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046581; cv=none; b=Td6gCcnJTZD1a/WTsBu93iNSLi5Hdl5+kSAQS6YAlasVbq4eR7YlRFKldFUaQR9y3UM2tpMOWYQbFZr59yk62EMw/nBNdBab/mZb+932tZYMHBSCPYSW3VEwsOyFZ7lQD6LrGIeLNji/cJBYcl/1uQeGzu5G2YNAOcUppp9wMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046581; c=relaxed/simple;
	bh=dM9SNDTnEOVm9hD0EttRoLE3t1czZ09LbkbkT6AW/to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYS4S++ISsIsanqoEC28ya5utf6+ah4FJ9m0M/5WPstBhAyR8SAdSsxeW2PT8WpCUii6AJ0+owvjHOmwKCr06BC1N0n0eDwerPx1PjXh7dIwdxrLgRSobNw8w/RgLJi+7WBTmg5cXxulUT+Hyhy/t2F9VAORpo/Ed2VlNdBNgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rjmdEma7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gp5d5vbc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JlttwLCS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KTRl2pHa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC0E822780;
	Tue, 27 Feb 2024 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709046576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhotBk457T/JQRT/U0nnmVx5cNqwJLVhgqvyWSmtT+E=;
	b=rjmdEma7A85hW8xVkU/BZFQvSVmla/EGoxuB21tUYzsyaOyiJG+RcwqH7/phWv12c4rFKd
	EE108R0LOhLSFrQfJ5X9KEm9ZJUalywqS1kSvc3EoxoR9F9+6MkBt5kzAiwLchiWaO+7qf
	gHh+gNq81DOWUExYzLbb1vevoxVo8As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709046576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhotBk457T/JQRT/U0nnmVx5cNqwJLVhgqvyWSmtT+E=;
	b=Gp5d5vbcSrreQKzX8moR6hz8TU8936HEHw783A2gYA9qdEn+Q+DTJDLS9fPN6VtPhrG5aX
	padkkVsiOGADmMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709046574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhotBk457T/JQRT/U0nnmVx5cNqwJLVhgqvyWSmtT+E=;
	b=JlttwLCSW6noIBaAF5DJ9tYenemDDuThWVYZc073FAu1FCrBKL5lexUgdIOm6+K/Qo0VBa
	GQc8vwg8CogT+gqTSQEkqF2eMvRIVpagzyTW0Fb4tdkAa1k/CPPnWhw4+covoD5dTJzHud
	BBKOWdSWgS7CDr/SsfEetCBFaL7TU/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709046574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhotBk457T/JQRT/U0nnmVx5cNqwJLVhgqvyWSmtT+E=;
	b=KTRl2pHa8fOKgnigmafZwQpeYL+klE+7Fh/oYlTGOf1+ld/BHqEzvXfUINFcFLHFU0I0He
	ybHOWqd2yB//OACQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 44C1A13419;
	Tue, 27 Feb 2024 15:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7mIMDi773WVYBgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 27 Feb 2024 15:09:34 +0000
Date: Tue, 27 Feb 2024 16:10:43 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: record the migration reason for struct
 migration_target_control
Message-ID: <Zd37c1z_pDdU3Wsx@localhost.localdomain>
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
 <d05fb0f1fea466334f44ea7b4d73a54b6c35cdc5.1709041586.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d05fb0f1fea466334f44ea7b4d73a54b6c35cdc5.1709041586.git.baolin.wang@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JlttwLCS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KTRl2pHa
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC0E822780
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

On Tue, Feb 27, 2024 at 09:52:25PM +0800, Baolin Wang wrote:
> To support different hugetlb allocation strategies during hugetlb migration
> based on various migration reasons, recording the migration reason for the
> migration_target_control structure as a preparation.

"... record the migration reason in the migration_target_control
structure..." ?


> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

