Return-Path: <linux-kernel+bounces-93587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 546CE873235
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C90FB28DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BB75803;
	Wed,  6 Mar 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dkYhWR9+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dkYhWR9+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD160B95
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715413; cv=none; b=S4ULMRBUxAb+ew3ARiRKaoZ1xI3On2UlokbVu0WZ7smIkTGGAYeinmkRucjEueGLoD7nxS+O/4FxdfaX+Mxrt2u+NXFw+bMJiV+WbgODR+eg14yhJ/CJPfoaLZjSiI440tQsRxx21KSaZn+XwgsOFDc7hUAdluaJxfUQmEDMo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715413; c=relaxed/simple;
	bh=4nvFQc5+G18sYCQZQXyX7kk6D0mhWRA+LSxQm3IlA0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA2CyZ7CBaCjH7BfeekErEgzDagM9fMW6eCCqletJkKksGxb8OgokqTzfGoiMrrDy2ujHLWHuULIc0YbQ5ZcbNvx5woP/ogBRvn4hEzfCfLf7/YTom66CLVcpku/m/xIzG77r2ocuqs8UiJbezuL/mlLOZnuDaezblrVNk1CoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dkYhWR9+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dkYhWR9+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAE0C4DD02;
	Wed,  6 Mar 2024 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709715409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdycLrzJy1w4EUGhhUtMStsknbzgfSCFfV2j5KkcqJg=;
	b=dkYhWR9+0U0gYjGbTxaRHZA5/1OXeHwvTRr0o0CTjPb1UZnpKrLt8z53kZ5JT5dKsu57i4
	8ihZhhkPzno1Pun56CbpSWfxkxblMqWIk+ZPtSzEz+qZq5VXWh2GiRhQCevLQzRlX5I2cW
	mHUa4t7gv223+yW7zT82qcM3yXLTD3M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709715409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdycLrzJy1w4EUGhhUtMStsknbzgfSCFfV2j5KkcqJg=;
	b=dkYhWR9+0U0gYjGbTxaRHZA5/1OXeHwvTRr0o0CTjPb1UZnpKrLt8z53kZ5JT5dKsu57i4
	8ihZhhkPzno1Pun56CbpSWfxkxblMqWIk+ZPtSzEz+qZq5VXWh2GiRhQCevLQzRlX5I2cW
	mHUa4t7gv223+yW7zT82qcM3yXLTD3M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A19E613AAD;
	Wed,  6 Mar 2024 08:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O1ObJdEv6GVEbwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 06 Mar 2024 08:56:49 +0000
Date: Wed, 6 Mar 2024 09:56:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52560: mm/damon/vaddr-test: fix memory leak in
 damon_do_test_apply_three_regions()
Message-ID: <Zegv0XmFyNzNYORb@tiehlicka>
References: <2024030252-CVE-2023-52560-c3de@gregkh>
 <ZedNf9uP3_TjIy0g@tiehlicka>
 <2024030527-sinless-platter-510a@gregkh>
 <ZeggFvhW-nLqM6G-@tiehlicka>
 <2024030604-unstuffed-grant-758c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030604-unstuffed-grant-758c@gregkh>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dkYhWR9+
X-Spamd-Result: default: False [-6.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BAE0C4DD02
X-Spam-Level: 
X-Spam-Score: -6.31
X-Spam-Flag: NO

On Wed 06-03-24 08:42:07, Greg KH wrote:
> On Wed, Mar 06, 2024 at 08:49:42AM +0100, Michal Hocko wrote:
> > On Tue 05-03-24 22:25:11, Greg KH wrote:
> > > On Tue, Mar 05, 2024 at 05:51:11PM +0100, Michal Hocko wrote:
> > > > On Sat 02-03-24 22:59:54, Greg KH wrote:
> > > > > Description
> > > > > ===========
> > > > > 
> > > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > > 
> > > > > mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()
> > > > > 
> > > > > When CONFIG_DAMON_VADDR_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
> > > > > and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
> > > > 
> > > > This is a kunit test case AFAICS. Is this really a CVE material?
> > > 
> > > People run kunit tests on real systems (again, we do not dictate use
> > > cases.)  So yes, fixing a memory leak that can be triggered is resolving
> > > a weakness and so should get a CVE I would think, right?
> > 
> > This is stretching the meaning of CVE beyond my imagination. Up to you
> > to decide but I yet have to see a real production system that casually
> > runs unit test just for <looking for a reason .... but failed>.
> 
> I know of at least one place that uses kunit tests in "production", and
> I know of more that will be enabling them in newer releases, so this is
> a real thing.

I would be really curious to hear more details.

> Again, we just mark "fixes for a weakness" as a CVE and
> let others decide what to do with it.

OK, this is something we have discussed and concluded to disagree. Not
my call though but I would really like to hear _who_ outside of the stable
tree userbase is really appreciating this approach.
-- 
Michal Hocko
SUSE Labs

