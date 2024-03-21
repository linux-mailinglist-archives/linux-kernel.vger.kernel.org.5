Return-Path: <linux-kernel+bounces-109976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F4E885876
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41B6B21851
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C059B76;
	Thu, 21 Mar 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ymD8F85R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wuaX50Yn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zBpTmHrT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/XrvFpRf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1E59148
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021141; cv=none; b=WkK5tkWQs52iqxWrNdVaTk0jeZ1Y5tz339glsiWwl0My0HLYk+Fdzb1rJj2tBmcVRnq9DAxpOeTgTUU2edZ8Mjb2s0djrAW5pvt1seVaUXUTHMZ0lGcOXgijhqrhIvaNe8KwKejteHpX/vRfr4bI/RNjr7OH+QPZGohqVn9SEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021141; c=relaxed/simple;
	bh=YR9q8iX1LsMRbqJycj05LpnC1vzuyORxCMBLEDPHkzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK1ht8eMhRuWqJ9H7wcRP0CFdVyHacXFbJzGHtEqGs8vZWIt1224FFkNC6cjwXZzEXblW+IeQtAZ6KS7iGKVIaiqo4ri4X4lRefH42t50SHslaLFgqsObDoDzFRdHjZuj0Y4eCm730i/7Nawn/35JFvDwarD7lpaA3AvXWbJFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ymD8F85R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wuaX50Yn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zBpTmHrT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/XrvFpRf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6EAF372DF;
	Thu, 21 Mar 2024 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711021136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt3+2/nDTFR616tg5a69R25p8gHMQ8L45m+oyGrsQFM=;
	b=ymD8F85RIUZAxh/l7P9lYEmI0mPCxwGXdPCf3MkKG7U9ujXTLCodUPVWtT+F7gh3XB/yPq
	jC/cr1RMa9YSFSm5d4PZ6YCxWR065UVlnUnQXMpShGqZRHd/NpEzrvqflVCBcOVtpxR5WP
	hk3wOCkVlk6JcPG/Nqx1kqXVLAGppq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711021136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt3+2/nDTFR616tg5a69R25p8gHMQ8L45m+oyGrsQFM=;
	b=wuaX50YnFTJqwgi41Fj0EU6hhYRJw8uHlbqlduAsulFpP06KU8NmZwXbLWxAsUJdJEUALe
	JqaTToDNcVkkX+BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711021133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt3+2/nDTFR616tg5a69R25p8gHMQ8L45m+oyGrsQFM=;
	b=zBpTmHrTdPQOEMrXGSmHyxDxWSCZKqO54njWMUR/WJTe+ImBjeMlAO2gMFyEgUEU6pE6Mx
	nPNgi/x98bA4oVV0GP1MA4g1jek17RSig/i7eWdz/8ryJzD/c4snWDVQsmZhI+mtbgndF0
	Wfk7sYuJuZUOvWlj23Kfo9iP4bwZi8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711021133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt3+2/nDTFR616tg5a69R25p8gHMQ8L45m+oyGrsQFM=;
	b=/XrvFpRfPYITHNqpD+ls/w3AGp7UQfUAtaYfMJwvy90ZS5uGJW9HW5qM67PFdFmn6qCj5S
	rA/FslVbKfLFliBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C8D513976;
	Thu, 21 Mar 2024 11:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zjczJk0c/GVzNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Mar 2024 11:38:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 44C52A080F; Thu, 21 Mar 2024 12:38:49 +0100 (CET)
Date: Thu, 21 Mar 2024 12:38:49 +0100
From: Jan Kara <jack@suse.cz>
To: Joel Granados <j.granados@samsung.com>
Cc: Jan Kara <jack@suse.cz>, wenyang.linux@foxmail.com,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 8/9] fs: inotify: delete these unnecessary
 static variables it_zero and it_int_max
Message-ID: <20240321113849.hfzmnz6p3cjbmmwt@quack3>
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
 <tencent_3066A7AB308FF9F53E3B5639514306914D0A@qq.com>
 <CGME20240320103608eucas1p235f843330beda0c826ab3cc1709c65e6@eucas1p2.samsung.com>
 <20240320103603.u6uqhk6viu4qkaht@quack3>
 <20240321105555.f4qg5g3wbe57mzzx@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321105555.f4qg5g3wbe57mzzx@joelS2.panther.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zBpTmHrT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/XrvFpRf"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[foxmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,foxmail.com,xmission.com,kernel.org,chromium.org,redhat.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.11)[95.72%]
X-Spam-Score: -3.12
X-Rspamd-Queue-Id: A6EAF372DF
X-Spam-Flag: NO

On Thu 21-03-24 11:55:55, Joel Granados wrote:
> On Wed, Mar 20, 2024 at 11:36:03AM +0100, Jan Kara wrote:
> > On Tue 19-03-24 23:57:49, wenyang.linux@foxmail.com wrote:
> > > From: Wen Yang <wenyang.linux@foxmail.com>
> > > 
> > > Delete unnecessary static variables (it_zero and it_int_max)
> > > and encode them directly in the table entry.
> > > 
> > > Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> > > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Joel Granados <j.granados@samsung.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > > Cc: linux-kernel@vger.kernel.org
> > 
> > This looks as a sensible cleanup but I don't see the first patch in the
> > series (and neither it is archived at lore.kernel.org) so I cannot really
> > verify whether your conversion is correct...
> This was my original comment. If you want to see the cover letter
> look for this mail ID tencent_06797E65CFC655DCD4F0414B9380E95ECC08@qq.com
> 
> Not sure why it separates the cover letter from the rest of the patches.

No, that is actually a different email :) Based on lore the message ID
should be:
26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com

but the email is not in the archive...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

