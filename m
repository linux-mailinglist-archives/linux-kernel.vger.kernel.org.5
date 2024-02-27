Return-Path: <linux-kernel+bounces-83483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7B869A14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23C61C22307
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1051420A0;
	Tue, 27 Feb 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VihdrFF9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NMhDP5Sr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VihdrFF9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NMhDP5Sr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152D31A66
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046967; cv=none; b=oVODlG1DeDxA1GVtsrIfldKp7FeLqJgsGqhRcT5m9bsHnyKtZEvY1ZbC+Y4rZcBrLLTiGyjDU7N0vYtzaLCiR7Jur5PxS+B9BNUzVuBiPsDXciNKZcm/Os3IFakMPo/t1xoQ90ml/KRIzF5kgMCC+dd/zo3lvmxAfpLGrJRWJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046967; c=relaxed/simple;
	bh=Q704lxGdAk8nqsO2ILkxfXxqEZFSFyafTT484ut52dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlTyw2pIu07KdbGTZrJ5xxY5Y8KptoSrP63wBn4rk0f+FmZxBqX5ioV7WrANj4ml74pErZlrC5q9uxjdm6YcxHGwNZpN+Htc9rUp2W5oMUwV3dXq8ZVBJxyXafJki/gtxDkgKm2PGaBPM8BwFRulQ9VeGEc1J5Xdgb7Kft707Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VihdrFF9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NMhDP5Sr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VihdrFF9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NMhDP5Sr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 126001F461;
	Tue, 27 Feb 2024 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709046964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ/KbhKK6eGZmN0r12OosY6StcJkfekJBBlgQb36fNs=;
	b=VihdrFF9d8S5FVkYKn0hTax4UqSvWcJSafsUOBjEuW/b0t3AxnpQhAzgdPA5w60MO4sHcN
	G7qED5PcgNwEsI/mnAZeVEYBiGJYL17ChY3iBVZbvP6crKra17TNR/3IOcnlSe/wftV1HN
	uG18XWA4N94q+NhpkogQxoONLXne+nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709046964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ/KbhKK6eGZmN0r12OosY6StcJkfekJBBlgQb36fNs=;
	b=NMhDP5SrF32zrAya4SDOW10wyzx20ZZS4aVxt/qGF3QwXfrXCK/7mztyv/y8GJdA013jXz
	ueH3GpsERrrDxzCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709046964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ/KbhKK6eGZmN0r12OosY6StcJkfekJBBlgQb36fNs=;
	b=VihdrFF9d8S5FVkYKn0hTax4UqSvWcJSafsUOBjEuW/b0t3AxnpQhAzgdPA5w60MO4sHcN
	G7qED5PcgNwEsI/mnAZeVEYBiGJYL17ChY3iBVZbvP6crKra17TNR/3IOcnlSe/wftV1HN
	uG18XWA4N94q+NhpkogQxoONLXne+nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709046964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ/KbhKK6eGZmN0r12OosY6StcJkfekJBBlgQb36fNs=;
	b=NMhDP5SrF32zrAya4SDOW10wyzx20ZZS4aVxt/qGF3QwXfrXCK/7mztyv/y8GJdA013jXz
	ueH3GpsERrrDxzCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8512213419;
	Tue, 27 Feb 2024 15:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uPTFHbP83WVSCAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 27 Feb 2024 15:16:03 +0000
Date: Tue, 27 Feb 2024 16:17:16 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
Message-ID: <Zd38_AYtr9QKp-F6@localhost.localdomain>
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
 <bdca97e6c59f1b58f09e18defac0c47d1e38f44b.1709041586.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdca97e6c59f1b58f09e18defac0c47d1e38f44b.1709041586.git.baolin.wang@linux.alibaba.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VihdrFF9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NMhDP5Sr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.27)[96.57%]
X-Spam-Score: -5.78
X-Rspamd-Queue-Id: 126001F461
X-Spam-Flag: NO

On Tue, Feb 27, 2024 at 09:52:26PM +0800, Baolin Wang wrote:

> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2567,13 +2567,38 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>  }
>  
>  static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
> -				     int nid, nodemask_t *nmask)
> +				     int nid, nodemask_t *nmask, int reason)

I still dislike taking the reason argument this far, and I'd rather have
this as a boolean specifing whether we allow fallback on other nodes.
That would mean parsing the reason in alloc_migration_target().
If we don't add a new helper e.g: gfp_allow_fallback(), we can just do
it right there an opencode it with a e.g: macro etc.

Although doing it in an inline helper might help hiding these details.

That's my take on this, but let's see what others have to say.

-- 
Oscar Salvador
SUSE Labs

