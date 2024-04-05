Return-Path: <linux-kernel+bounces-132367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2248993A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06EB1C21E62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C2918E2A;
	Fri,  5 Apr 2024 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D6FcVcty";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oHNhJ3vp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U7k20xpg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5c+5WwEm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6ED1B966
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286645; cv=none; b=Cgwgn8AQHDx/GlnLRiH122nD8mZJzqKRixLZDy0Ff0j39/4snWLW5UuKb1B27Rst1NIPFZPlMPBT+SGs2bFxkB3jcA+qTFNbzL3TT67rEg8ilM974PlGnqtewlxNcF95K0mjmp5AYjE120odProoynrij1E8MjPWKUOwateZKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286645; c=relaxed/simple;
	bh=MWppIWojybEZ5CyEwJelLa/35EQHlPgaNnB0IEzsidA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Byfi3jqe89fuGj4y525WiU3UK87ujOOyZNzPoYM4vkqQtKyvvhlCYdYQF40E9eFxYaSr3+mliwRZWP+65YXcIvmAhsCjC4ftiV9ZL3fNLVbCkW925jhDSokI6CfyBj3f5IQoS7Y+x9olIN++j+Z7kCpqQwmJNPbWNc4m+mc1I4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D6FcVcty; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oHNhJ3vp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U7k20xpg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5c+5WwEm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E71DE1F45B;
	Fri,  5 Apr 2024 03:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712286642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swulY5EAmwEC3jQTCHtYBOcO49GPyH/xMPMHoy3k930=;
	b=D6FcVctyDq1McXF4x55Ci0QPnyYeUu1w30kc2oIMkr7tMy/J5Bel7E2Ac4Dj7KfcRTDFpn
	Og82gRHu/0PGZN/xgQIKvfHlQFL0HL+WAu5To1iR5Md3GZ3/iyo7IHsGIYcCtdlXkJbVdB
	e+g+t9pLerm3lVuv8U5YBO10L9aUxgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712286642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swulY5EAmwEC3jQTCHtYBOcO49GPyH/xMPMHoy3k930=;
	b=oHNhJ3vpy1659FSil5WPwNrJnzz0N8GxPEOnwb4tMNxWgRJgT6QZ+OiIf+TdA0HBOJSuIY
	5TLV/3eaoQgbrSAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712286641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swulY5EAmwEC3jQTCHtYBOcO49GPyH/xMPMHoy3k930=;
	b=U7k20xpgLswLVudXi3mw/sd7vALAWURlBBxKzAhg9sGP53eyMFPe9ChvVpga+49LyFWw5o
	l+bYqnP/6wEH2T/ssWgC3TGJi4A5K+BKtm5iuan8O6r3nn9dwq6T3b47kphvAr6mIc4dT9
	lQ7oTw4IdQsBNsk4kGw++N6oh5JVbn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712286641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swulY5EAmwEC3jQTCHtYBOcO49GPyH/xMPMHoy3k930=;
	b=5c+5WwEmUNQFgtpjDvk1Sza1616x18ejervJgbbACv/wBJ2mPhpF6b5WZIIjvdUlau05tf
	C0a+7zj/6grIVuCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 28E9813357;
	Fri,  5 Apr 2024 03:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CgBEBbFrD2ZjZQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Fri, 05 Apr 2024 03:10:41 +0000
Date: Fri, 5 Apr 2024 05:12:09 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, muchun.song@linux.dev,
	willy@infradead.org
Subject: Re: [PATCH v2 2/3] hugetlb: Convert hugetlb_no_page() to use struct
 vm_fault
Message-ID: <Zg9sCdZ_X7Fxkq2y@localhost.localdomain>
References: <20240401202651.31440-1-vishal.moola@gmail.com>
 <20240401202651.31440-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401202651.31440-3-vishal.moola@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

On Mon, Apr 01, 2024 at 01:26:50PM -0700, Vishal Moola (Oracle) wrote:
> hugetlb_no_page() can use the struct vm_fault passed in from
> hugetlb_fault(). This alleviates the stack by consolidating 7
> variables into a single struct.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>


Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

