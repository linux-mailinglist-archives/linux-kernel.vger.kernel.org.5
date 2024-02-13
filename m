Return-Path: <linux-kernel+bounces-63194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8C9852C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E72AB219B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51421A0A;
	Tue, 13 Feb 2024 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0jQvgWAz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FUUCW58s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0jQvgWAz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FUUCW58s"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A11210FE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816044; cv=none; b=sSjcdJMAIdeMYmdnfpbGhUaOgmTdr8h0gND8aJXswg8sK+4AhFL2xHxAm2dQvBMn+upR8US+qmuqW02w4JZMZjnfHsF838yqPfjsuI0nzHs3+IwtQPquTMkxPNtys0rDnSolnd3wzMhjtRk07koqayDI5QOIvnopCsFPQOEYTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816044; c=relaxed/simple;
	bh=cbS2nIbbwJua53Hk52unEBjtJ1Witn8A7K0lg6Or62g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAdzfzUlpzyB9CUp1NK798gX+J3oXGnqIjfXeWxuCJnnbuf33/319PbWInGr3j0lL1V7P497voLrwBm4nxv2fG5P/J52Bt8swKdKnOypGGsNa9O9hLcTRaadIFLrCRM3UdhPo/W0QrxAwwOCCIFaePT13rQMhryviYsVOB7h9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0jQvgWAz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FUUCW58s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0jQvgWAz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FUUCW58s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CBCE721CB5;
	Tue, 13 Feb 2024 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707816040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOS35PXmDzxq8mJA/3f1NRxq/MHHhAThVo5B9zGgbyM=;
	b=0jQvgWAzsAfGieokk1BRChjKDJjs8YvOEql95YcoU9BVAhK3cLki48DmjDIeNJ6Q7gCULb
	3h+uCPvK2bPXRUTOtGmNX6y2c1EMZ1MJIvIJhg4ABIW4L7URzIwDt0J/5P16GyOCgcULf2
	KGi86YjrwV+xYDw59cuXQ4PwXTLR0fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707816040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOS35PXmDzxq8mJA/3f1NRxq/MHHhAThVo5B9zGgbyM=;
	b=FUUCW58sTyeIzP4oFj2BY4J5q1fr8u6mOVOGRUHlKhEOMQJZMWzQEsJToM6IpHCHvYxzRd
	b0wHfInYidlTxvBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707816040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOS35PXmDzxq8mJA/3f1NRxq/MHHhAThVo5B9zGgbyM=;
	b=0jQvgWAzsAfGieokk1BRChjKDJjs8YvOEql95YcoU9BVAhK3cLki48DmjDIeNJ6Q7gCULb
	3h+uCPvK2bPXRUTOtGmNX6y2c1EMZ1MJIvIJhg4ABIW4L7URzIwDt0J/5P16GyOCgcULf2
	KGi86YjrwV+xYDw59cuXQ4PwXTLR0fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707816040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AOS35PXmDzxq8mJA/3f1NRxq/MHHhAThVo5B9zGgbyM=;
	b=FUUCW58sTyeIzP4oFj2BY4J5q1fr8u6mOVOGRUHlKhEOMQJZMWzQEsJToM6IpHCHvYxzRd
	b0wHfInYidlTxvBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 51D0C13A0E;
	Tue, 13 Feb 2024 09:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id v0PeEGg0y2XQIAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 09:20:40 +0000
Date: Tue, 13 Feb 2024 10:21:50 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 4/5] mm,page_owner: Filter out stacks by a threshold
Message-ID: <Zcs0ruHxL9YOsKN_@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-5-osalvador@suse.de>
 <CANpmjNNWv1eDL5MQXtdXnsV=sCp_8MC11xBAgsNt_1K-V30H8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNWv1eDL5MQXtdXnsV=sCp_8MC11xBAgsNt_1K-V30H8Q@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.75
X-Spamd-Result: default: False [-3.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.45)[97.48%]
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 09:44:47AM +0100, Marco Elver wrote:
> On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
> > +       debugfs_create_file("set_threshold", 0600, dir, NULL,
> > +                           &proc_page_owner_threshold);
> 
> Can't you also read from "set_threshold", so the name "set_threshold"
> is misleading. Why not just "threshold"?

Yes, it can also be read.
I guess I was too focused on the set part.
I will rename that one, plus add the {READ,WRITE}_ONCE.

Thanks!

-- 
Oscar Salvador
SUSE Labs

