Return-Path: <linux-kernel+bounces-68984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB58582FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F92B22832
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C576C130AFE;
	Fri, 16 Feb 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u7vQAp4C";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u7vQAp4C"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8C12F36A;
	Fri, 16 Feb 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102289; cv=none; b=li5XtKXvQ5o9T8nZ22qXOqW47GeVM+LTab37WNC6BQ3oUuZK4smS6cBqZGdID4o35AXD/bh6nq6+FaE4gPnjA2DOjYBIbZR97QrGIZGXBZvWuusUejB0xFaF094Ql1NbcnIcOrHDRVsBbdHWI6DFIKFZHh7QhRYpE4lkDFdcyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102289; c=relaxed/simple;
	bh=GFdZ9x5VnyQk2XmemYZ+RhJwyg2qNpV8wiYTo3qSBFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeotcInXT4MWm0P9N2jhG0z//Bccr97v61zRR3PeXdDghq4ymZBLHEQRyyCyFGaPwOOi98NgDDOdUNy/9weC202xi0FYrm9FnGyaFOsZnlbiRudwS+wacFGYr/oOO6z20VmO+sVFakkLdTcWa4utONcOknliLcwa2h/WGo2PyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u7vQAp4C; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u7vQAp4C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 59E4C1FB76;
	Fri, 16 Feb 2024 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708102283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6kQvlK/L7iuReKt8M8eM35S1Vrh5nJKRZ/vQtmta6k=;
	b=u7vQAp4CkLoRxaZTYE7BDD3PqS4k9gTykTFSu4hXaUkUQKtXHba1yT8p8XZWQtAnYUtFHC
	vaboM5s/oSXVvBzx2RbAPT9AzHThsw1G0q3sE/On/nDZp9EI9D2gPnQ4MzvRGpQHN/Y00y
	Qks5UC4qaRtZHhafStqtbmthpldqme8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708102283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6kQvlK/L7iuReKt8M8eM35S1Vrh5nJKRZ/vQtmta6k=;
	b=u7vQAp4CkLoRxaZTYE7BDD3PqS4k9gTykTFSu4hXaUkUQKtXHba1yT8p8XZWQtAnYUtFHC
	vaboM5s/oSXVvBzx2RbAPT9AzHThsw1G0q3sE/On/nDZp9EI9D2gPnQ4MzvRGpQHN/Y00y
	Qks5UC4qaRtZHhafStqtbmthpldqme8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 410BE1398D;
	Fri, 16 Feb 2024 16:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R4gXDouSz2W5VAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 16 Feb 2024 16:51:23 +0000
Date: Fri, 16 Feb 2024 17:51:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Message-ID: <Zc-SihxiTxhDcCuK@tiehlicka>
References: <2024021430-blanching-spotter-c7c8@gregkh>
 <Zc5PycMenLBYECAn@tiehlicka>
 <2024021518-stature-frightful-e7fc@gregkh>
 <Zc5ZpB6jsuTKmhv5@tiehlicka>
 <2024021646-procedure-faceted-ea87@gregkh>
 <Zc9hBJuca3f_5KHx@tiehlicka>
 <2024021620-retrieval-lethargic-eeca@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021620-retrieval-lethargic-eeca@gregkh>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u7vQAp4C
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 59E4C1FB76
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Fri 16-02-24 16:34:57, Greg KH wrote:
> On Fri, Feb 16, 2024 at 02:20:04PM +0100, Michal Hocko wrote:
> > > Right now
> > > we are fixing lots and lots of things and no one notices as their
> > > "traditional" path of only looking at CVEs for the kernel is totally
> > > incorrect.
> > 
> > Right, there are quite a lot of people who consider CVE fixes much more
> > important than regular fixes. Their reasoning might be completely
> > misleading but there might be very good reasons to stick to minimalistic
> > approach, e.g. to reduce risk of regressions.
> > 
> > I believe it is perfectly fair to say that whoever relies on stable
> > kernels support needs to update to the latest stable kernel version to
> > be covered by security and functional fixes. On the other hand I do not
> > think it is an improvement to the process to swamp CVE database with any
> > random fixes without a proper evaluation. If the kernel community
> > doesn't believe in the CVE process then fair enough, just do not assign
> > them unless you want to explicitly call out fixes with a high impact
> > security implications. Having fewer good quality CVEs would definitely
> > improve the process.
> 
> As you know, it's almost impossible to determine if a fix is "high
> impact" or not, given that we have no idea what anyone's use case is for
> the kernel.  We have documented proof of single-byte-buffer-overflows
> resulting in complete system takeovers, and the same for very tiny
> use-after-free issues, and the same for tiny "overflow a USB string
> buffer" issues, and so on.

Right, generally speaking this is not an easy task. It requires a lot of
diligence actually. Sometimes there is no clear cut and that is _fine_.
The CVE system cannot ever be bullet proof and mark every single
security related fix (really you can be creating new security problems
just by backporting upstream fixes into stable trees).

But that is not really all that important, the main thing/question is
whether it can be _useful_. If you simply assign CVE to any fix in
stable you end up with thousands of CVEs and I really fail to see any
practical benefit from that. Well, unless you want to DoS the system and
its consumers. Who do you expect to be the user/consumer of those CVE
numbers? You have already said that community supported stable kernels
mandate the latest version to be used. Those users do not need to know
there is $BIG_NUMBER of CVEs in them.

If you want to mark a specific class of fixes with CVE because they are
known to be used for exploits then fine! That is something actually
useful. If you allow users to explicitly mark a fix as security relevant
because of XYZ argument then really great!

> So as always, we need to treat "a bug is a bug is a bug" and when
> looking at the bug fix, if it resolves something that is known to be
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> a vulnerability (again, as defined by CVE themselves), then we need to
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> mark it as such.

I am completely with you on that! That is quite far away from what the
documentation says AFAICS.
 
> If you find that we are marking things as a CVE thatt you do not feel
> should be marked as such, please let us know and we will be glad to
> discuss it on a case-by-case basis.

I've been through that exercise with the CVE process over years many
times. It has always been a pain because you were not talking to domain
experts who could evaluate the reasoning behind the dispute. I consider
the new process of a clearly defined dispute process a big improvement!
But if the real practice would be thousands of CVEs created for any
stable backport then this will DoS many existing CVE consumers.

All that being said. I do agree that taking control of CVEs and making
that kernel community thing is a good thing! But I really fail to
understand how increasing the number of CVEs by nominating all/most
stable fixes is going to help anybody or improve the existing process.

Thanks!
-- 
Michal Hocko
SUSE Labs

