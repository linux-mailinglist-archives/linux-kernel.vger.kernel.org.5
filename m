Return-Path: <linux-kernel+bounces-92828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1A87268F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EF51F286FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0D18E06;
	Tue,  5 Mar 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJAR8Ul1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aKbSySJf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJAR8Ul1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aKbSySJf"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE71426F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663452; cv=none; b=ec0GzDaaMzW0M6xYWrJ5m3U2npLcX0sTR7Z5wrvmFFAOTPHby+Nqo0sfU11/6UC+VBRG2obG/YLFpXfBPNjKuwm9bpnOYQ6A03FXRaBUVV2sWJY3HKj02tyWazktoRQnVqeFSRNeNmowW2ffsBWUvUWKaKT2fBbrCNYZRTQkDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663452; c=relaxed/simple;
	bh=CLmlynWBG/U75g72BFPT/SesteZ32XdWuToauo/TJiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIjC1ovQr1AROt1pILlWhcLROEvj97IRX/Sw9aYMh2ePpF3d8Q7JXby9ZEWPcXCRI0qdYUPmcJ2rVM4zhgzq+j3VR2JqSvk4wkVZK26HGHJNhsmgVGUx2x01BhrkdoCjq0tFBef2N9+dtla+KKhpH9fx9ONc1egHgMlYe2uUzvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fJAR8Ul1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aKbSySJf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fJAR8Ul1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aKbSySJf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31783201B2;
	Tue,  5 Mar 2024 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709663449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMu5HmvynOe/MMK0jk+PVyidIMgicZj9hoHUigAVxzQ=;
	b=fJAR8Ul10zui5eofS/kWyX9sF4Fe131zqkqr2ti8656ZzIwQaWtHEY4sS2EbPLA2uUWmE/
	tIATZFhuVUVpmNQ6PwHfaq9usK2rarWu6lhRSGfeUIsfp8K0jGkficADN6HSb610fQ41Cy
	3ArMaNVD4OqNhA75NL6xwBexEp+SL5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709663449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMu5HmvynOe/MMK0jk+PVyidIMgicZj9hoHUigAVxzQ=;
	b=aKbSySJfJrP6NGQQHeWEx5ZKDiGWYUHhHwhLmL0Vc/sWRQSx6zF0KCRNT99SDXxTdkcKQk
	Juze+ha6K0Ph8WAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709663449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMu5HmvynOe/MMK0jk+PVyidIMgicZj9hoHUigAVxzQ=;
	b=fJAR8Ul10zui5eofS/kWyX9sF4Fe131zqkqr2ti8656ZzIwQaWtHEY4sS2EbPLA2uUWmE/
	tIATZFhuVUVpmNQ6PwHfaq9usK2rarWu6lhRSGfeUIsfp8K0jGkficADN6HSb610fQ41Cy
	3ArMaNVD4OqNhA75NL6xwBexEp+SL5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709663449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMu5HmvynOe/MMK0jk+PVyidIMgicZj9hoHUigAVxzQ=;
	b=aKbSySJfJrP6NGQQHeWEx5ZKDiGWYUHhHwhLmL0Vc/sWRQSx6zF0KCRNT99SDXxTdkcKQk
	Juze+ha6K0Ph8WAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DEBA13A5D;
	Tue,  5 Mar 2024 18:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eL/3H9hk52XjfgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 05 Mar 2024 18:30:48 +0000
Date: Tue, 5 Mar 2024 19:32:02 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm,page_owner] 4bedfb314b:
 BUG:KASAN:null-ptr-deref_in_init_page_owner
Message-ID: <ZedlIv2ECH08KJcM@localhost.localdomain>
References: <202403051032.e2f865a-lkp@intel.com>
 <ZeblmHyVlxl_6HGC@localhost.localdomain>
 <CANpmjNMOazCrzJr+Ckx0vM73P86dPM_0qbcv=Nu44jUtPERD+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMOazCrzJr+Ckx0vM73P86dPM_0qbcv=Nu44jUtPERD+A@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fJAR8Ul1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aKbSySJf
X-Spamd-Result: default: False [-3.08 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,kvack.org,linux-foundation.org,suse.cz,gmail.com,google.com,suse.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.77)[98.99%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 31783201B2
X-Spam-Level: 
X-Spam-Score: -3.08
X-Spam-Flag: NO

On Tue, Mar 05, 2024 at 02:02:35PM +0100, Marco Elver wrote:
> On Tue, 5 Mar 2024 at 10:26, Oscar Salvador <osalvador@suse.de> wrote:
> > Marco, could it be that stackdepot was too overloaded, that by the time
> > page_owner gets initialized, there are no more space for its stacks, and
> > hence return 0-handles?.
> 
> That's possible. But it's unclear to me what exactly happens. Are you
> able to reproduce the issue? (I haven't been able to because the
> config enables CFI which seems to cause other issues for me,
> presumably toolchain related. :-/ )

I am out of luck here, I cannot reproduce the issue.
I set up the environment just as [1] says, building the kernel with
their config and launching bin/lkp just as [1] states, but it
boots fine here.

[1] https://download.01.org/0day-ci/archive/20240305/202403051032.e2f865a-lkp@intel.com/reproduce

-- 
Oscar Salvador
SUSE Labs

