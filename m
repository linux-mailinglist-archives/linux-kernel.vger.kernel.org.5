Return-Path: <linux-kernel+bounces-92720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2F8724E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40FEB213B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A9D520;
	Tue,  5 Mar 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AtE2uG4Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uG38+eLu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C409457
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657689; cv=none; b=bgbVkrlbDEy8NQPlZae3oVxcPT3dEBcwiMHon9sz+O1PuwfOJNr1lqEd4KHM9c0iA4W2/3v58ChWq0xZzVNZdXa15pwLlRGDzfvFpBcaAHqGr3sNhk2ntK/9Bn16d+1chl/XxCCX7o+d2TCtOX9wAdAxG7eNAZGycGg+ZYG+mjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657689; c=relaxed/simple;
	bh=R7VW3Sc7b5eZ6KpyerW+b84HFQ3Blb6GJ63R1AmyMK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuouNazaSQtEtVcxI97wLWb6ha3RWiscp4oEUx2Cus6Jq70eoV6xhvx/0qsVLRZSckxRa8XEcSu/2ZrH4bmYyrpvgdwbGzrkdCiFxFJbaCzkXcTfbV9HBs+F2qKQhFE8mkX+U5pBu9nMrWpNTkivo563QzardHyQ/1gu8KsthA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AtE2uG4Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uG38+eLu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC6EF6B9AD;
	Tue,  5 Mar 2024 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709657686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQ12qku4XFEjo7lOAHiP1outVs/2KwQNkFoPjlWDM48=;
	b=AtE2uG4YZClE/K1AxSaVoI0PrL/jd2ceTRfu7RXARKDimmFy8phidMgdANUvbidToSW8yX
	BNevTGTW4nsSx/gFqNFalJfLrdWPmkWfFSF4fQ8EMgCIqujZ6KZX5JT2wKQWDJcayiivTU
	iFho2zF+ETCqfmXbX3kELOnZ7Cc1bbU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709657685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQ12qku4XFEjo7lOAHiP1outVs/2KwQNkFoPjlWDM48=;
	b=uG38+eLu5pIAMY+AXlOwekxMuCRYw8SJq8cNKk7o2zdNNJgTtgu2/96XVz48sVZGE02r4V
	6q90wUpDmlwqENLt6hc6i9Su3nZxNLw0fjPVsjVQSkYzwhQi3oA3jhyBNWeQCFxuIMVLsL
	ZQ8C6yQmnAn6OYRFRIxCFrOvv0jhjW0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D531113A5B;
	Tue,  5 Mar 2024 16:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fIEJNFVO52XYBgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 05 Mar 2024 16:54:45 +0000
Date: Tue, 5 Mar 2024 17:54:45 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52521: bpf: Annotate bpf_long_memcpy with data_race
Message-ID: <ZedOVc9h_VTBjHLD@tiehlicka>
References: <2024030253-CVE-2023-52521-d847@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030253-CVE-2023-52521-d847@gregkh>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uG38+eLu
X-Spamd-Result: default: False [-3.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
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
	 BAYES_HAM(-2.71)[98.74%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DC6EF6B9AD
X-Spam-Level: 
X-Spam-Score: -3.52
X-Spam-Flag: NO

On Sat 02-03-24 22:53:05, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> bpf: Annotate bpf_long_memcpy with data_race
> 
> syzbot reported a data race splat between two processes trying to
> update the same BPF map value via syscall on different CPUs:
> 
>   BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update

I would like to dispute this CVE. It adds data_race annotation which
doesn't have any impact on the code generation.
-- 
Michal Hocko
SUSE Labs

