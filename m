Return-Path: <linux-kernel+bounces-92713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799098724DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187051F2247E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935FD28D;
	Tue,  5 Mar 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ubNN479q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ubNN479q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1137944F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657486; cv=none; b=pl/5O/qXynvBTxhz+INHdS8UXdSmWCVpMJ2iua+M0AuLyG+GP7I25GJrOpRlBijbhoj2ItvrZ7df3nIvVlMYwECzXbg/Vyhk6FZjNjkboKPur+/RxpbmjRggEyN4EYmG9zTzzWZuw17jLeanj8453RjbGyvj5/9i7EAvkZe8Mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657486; c=relaxed/simple;
	bh=+h3A8Bm5b0t742BYM0yFIDDKYhbGb7+Tu99VKI0WctI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5ALL7c6GjN/QMiP1eoxtGr1ccrmNmg50kheU3siBVOWr5TYc2Mdsmot4y7SKuBvzhpgiqXkKJrfgyuNj3y5xpipTsKtkZ12Zc6OjLy1AymUScjvwnFgWLAZNrnCYarKMiTNui2zsoy7pORJc4MjI6AQJAO76RgRBOdPKkSdAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ubNN479q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ubNN479q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9C5941EF;
	Tue,  5 Mar 2024 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709657475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/mHovDEYHLbXQ9vaXQEWsprbeUFOB8+RkbwNUTs8Xg=;
	b=ubNN479qhTBXGWb8A3HgqszUDG1nQljNBn1GRHygNIU/NdOkgkFcbvuB3nYM9D+0YgeBpn
	B4sr2iKUelSFO3RfSMMD/twksG2S5NIGuTHSrMn59mTfMVpMp8SSbZcTgUZw4AxjAuC1wB
	+8IrIW0giXkwDoDpSbuPFHOEAsN7XaI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709657475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/mHovDEYHLbXQ9vaXQEWsprbeUFOB8+RkbwNUTs8Xg=;
	b=ubNN479qhTBXGWb8A3HgqszUDG1nQljNBn1GRHygNIU/NdOkgkFcbvuB3nYM9D+0YgeBpn
	B4sr2iKUelSFO3RfSMMD/twksG2S5NIGuTHSrMn59mTfMVpMp8SSbZcTgUZw4AxjAuC1wB
	+8IrIW0giXkwDoDpSbuPFHOEAsN7XaI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A17B713A5B;
	Tue,  5 Mar 2024 16:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ghoJ4NN52XkBQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 05 Mar 2024 16:51:15 +0000
Date: Tue, 5 Mar 2024 17:51:11 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52560: mm/damon/vaddr-test: fix memory leak in
 damon_do_test_apply_three_regions()
Message-ID: <ZedNf9uP3_TjIy0g@tiehlicka>
References: <2024030252-CVE-2023-52560-c3de@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030252-CVE-2023-52560-c3de@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ubNN479q
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-0.994];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.95%]
X-Spam-Score: -5.00
X-Rspamd-Queue-Id: A9C5941EF
X-Spam-Flag: NO

On Sat 02-03-24 22:59:54, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()
> 
> When CONFIG_DAMON_VADDR_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
> and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.

This is a kunit test case AFAICS. Is this really a CVE material?
-- 
Michal Hocko
SUSE Labs

