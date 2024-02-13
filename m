Return-Path: <linux-kernel+bounces-63186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77915852C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2921C21710
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB632137E;
	Tue, 13 Feb 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eiuc/nb0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/y+iuUfH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eiuc/nb0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/y+iuUfH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C60120B2C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815538; cv=none; b=BMx+HzcGFn5EURBLJ5dARFCZrgAloq9pdI6ZVCDBrYxEchi1mGqB9qSdKSIcsP/eAZzw3c88LJayZ56cdIgWVh7gwiPxn3xviwG+rxnGkebAVO12xmEqUj7D54o4pvBLTrlk/+5AeIhXVsc6ZnfOkNR83khsMm0a4Jqqjr1+ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815538; c=relaxed/simple;
	bh=bTT0nEqE90gk/UOsEv/o/JeejEXpt86lXeRQukbkvYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTUL2PBUXT0x79S9l3F01Jopz/7Vy4hNGVgZECpDrAeflHN8lv4rL8yxFBJ0jKc1R0WzVrmRNAnvJTyyUE39ARJxg1TBZHc8KIGEnohH2cJ1na0mp7vv4E99azKW2JCG6Pd/RF0LLaRz66uR8zHzcFcqqI9lth7iMIt3SDqJTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eiuc/nb0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/y+iuUfH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eiuc/nb0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/y+iuUfH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DD701FD4C;
	Tue, 13 Feb 2024 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707815535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFpY1WT2w4jzHB4md+mYrF8QPTEiyTGLXAVoRLLg3Pc=;
	b=eiuc/nb0dj9EBSsDdiKLq6HYKGxQxjr7CBaAn7J+8GVHsX8Q3SMCCpsL1tx19W4bRs/f3Q
	JP4k1lNDu8O76iEb19k5aMpFqbkNbqHVt5A3g1oU6cLOa0M2X/NKh3sjI1tXIFWM/D2zVn
	SC/LBmHD8DrzM7SM9AD6Kkj+64CQonc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707815535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFpY1WT2w4jzHB4md+mYrF8QPTEiyTGLXAVoRLLg3Pc=;
	b=/y+iuUfH+2B1kDCh1JpynYqhJ1cNy/xlaMI6NbgfdnR5Y191rfblVWJz+kCh9RsR+vLUyt
	neHLxYdtdvPmi9Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707815535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFpY1WT2w4jzHB4md+mYrF8QPTEiyTGLXAVoRLLg3Pc=;
	b=eiuc/nb0dj9EBSsDdiKLq6HYKGxQxjr7CBaAn7J+8GVHsX8Q3SMCCpsL1tx19W4bRs/f3Q
	JP4k1lNDu8O76iEb19k5aMpFqbkNbqHVt5A3g1oU6cLOa0M2X/NKh3sjI1tXIFWM/D2zVn
	SC/LBmHD8DrzM7SM9AD6Kkj+64CQonc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707815535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFpY1WT2w4jzHB4md+mYrF8QPTEiyTGLXAVoRLLg3Pc=;
	b=/y+iuUfH+2B1kDCh1JpynYqhJ1cNy/xlaMI6NbgfdnR5Y191rfblVWJz+kCh9RsR+vLUyt
	neHLxYdtdvPmi9Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE13513A0E;
	Tue, 13 Feb 2024 09:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Mi6vK24yy2WnHgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 09:12:14 +0000
Date: Tue, 13 Feb 2024 10:13:24 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 5/5] mm,page_owner: Update Documentation regarding
 page_owner_stacks
Message-ID: <ZcsytJ0nL1ZIlycy@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-6-osalvador@suse.de>
 <CANpmjNMaUHMNmA7CxZkGUsJ7LCmz+PGqYAzTKxq=u_Osu8Y4sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMaUHMNmA7CxZkGUsJ7LCmz+PGqYAzTKxq=u_Osu8Y4sA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="eiuc/nb0";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/y+iuUfH"
X-Spamd-Result: default: False [-5.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.97)[99.88%];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4DD701FD4C
X-Spam-Level: 
X-Spam-Score: -5.78
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 09:45:28AM +0100, Marco Elver wrote:
> On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
> > +       echo 7000 > /sys/kernel/debug/page_owner_stacks/set_threshold > stacks_7000.txt
> 
> I think this example command is wrong.

Yes, it is, I will correct that in the next spin.

thanks!

-- 
Oscar Salvador
SUSE Labs

