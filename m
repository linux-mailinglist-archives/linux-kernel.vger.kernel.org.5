Return-Path: <linux-kernel+bounces-93414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF3872F70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB6B1C21559
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D3B5BAF0;
	Wed,  6 Mar 2024 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KojWK95l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qDCwZvlf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KojWK95l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qDCwZvlf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501E5BACE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709506; cv=none; b=F46iQLpDizUwqxhkpD1xYfmF254yNZyFcIWYvrxC709qbBGWH7rQT69phx45mrZHlrFYTPNV86ROdxMXOD4HW2KOg8i4lmGE3v+NMhrr+RpR3n9OpQ+/EhMUTTRd6S8hZttT9Vi8wlv/lYqw7EZH+8vlmA9s7EX9c/Q79rHqVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709506; c=relaxed/simple;
	bh=AXYajY2U+Z5syUU9moej2Uf1Mod4PTuKh3eK0Bnxjek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db3JeqLKUtbvaS5p1a/OEP2RJnfx6Nc70Gnya9cyldrIgPIXKOJQWES/VeIA1MkCf5mm30UuG8d4pKfroIUykOlFUVWOQT8dXXOAaU8IAXcXg7tCWUR/3agco2wFPkS+hKJ3QcpVO2pboSaBzDeAff7NoL5KnV926+6xaUQN3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KojWK95l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qDCwZvlf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KojWK95l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qDCwZvlf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46AD24D86C;
	Wed,  6 Mar 2024 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUQr1xvU/HmWnyZi7rd9MHflgE+MVTNA8Pa29gacj80=;
	b=KojWK95lbUNcOhMutLDRrgPCMAPSG1jqiIoD34bkBaZ4fBXOZ2L/OcI/1OuoS+YlVqxBqE
	8IDpzhsB6TLp21oHWo73h9ZQATbCGfVjAdmNPrt3/xSf9idBtRWabYs24s/s03xuTizJM6
	uuvpmApegmidEs/pmhJiih4gnCrlHkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUQr1xvU/HmWnyZi7rd9MHflgE+MVTNA8Pa29gacj80=;
	b=qDCwZvlfBUkSpmw78ZJs6fUm2b703Y94syoIkkIuDyBBeVKX7qclC6qJrufpy9L3HvdW8k
	o6lxXRFAAXLoXgCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUQr1xvU/HmWnyZi7rd9MHflgE+MVTNA8Pa29gacj80=;
	b=KojWK95lbUNcOhMutLDRrgPCMAPSG1jqiIoD34bkBaZ4fBXOZ2L/OcI/1OuoS+YlVqxBqE
	8IDpzhsB6TLp21oHWo73h9ZQATbCGfVjAdmNPrt3/xSf9idBtRWabYs24s/s03xuTizJM6
	uuvpmApegmidEs/pmhJiih4gnCrlHkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUQr1xvU/HmWnyZi7rd9MHflgE+MVTNA8Pa29gacj80=;
	b=qDCwZvlfBUkSpmw78ZJs6fUm2b703Y94syoIkkIuDyBBeVKX7qclC6qJrufpy9L3HvdW8k
	o6lxXRFAAXLoXgCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A25E613A79;
	Wed,  6 Mar 2024 07:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id RozhJL4Y6GXlCQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 06 Mar 2024 07:18:22 +0000
Date: Wed, 6 Mar 2024 08:19:37 +0100
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
Message-ID: <ZegZCaFJrnAWL4kb@localhost.localdomain>
References: <202403051032.e2f865a-lkp@intel.com>
 <ZeblmHyVlxl_6HGC@localhost.localdomain>
 <CANpmjNMOazCrzJr+Ckx0vM73P86dPM_0qbcv=Nu44jUtPERD+A@mail.gmail.com>
 <ZedlIv2ECH08KJcM@localhost.localdomain>
 <Zedmst0pEtGuY6B6@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zedmst0pEtGuY6B6@localhost.localdomain>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.07
X-Spamd-Result: default: False [-4.07 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.988];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,kvack.org,linux-foundation.org,suse.cz,gmail.com,google.com,suse.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.77)[99.02%]
X-Spam-Flag: NO

On Tue, Mar 05, 2024 at 07:38:42PM +0100, Oscar Salvador wrote:
> But they point out to 
> 
> commit 4bedfb314bdd85c1662ecc46fa25b33b998f994d (HEAD, bisection)
> Author: Oscar Salvador <osalvador@suse.de>
> Date:   Thu Feb 15 22:59:03 2024 +0100
> 
>     mm,page_owner: maintain own list of stack_records structs
> 
> which the only thing it does is to retrieve the stack_record for
> {dummy,failure}.handle and increment their refcount and link them.
> I am pretty sure the problem comes from either dummy_handle or
> failure_handle being 0 and the stack_record we get is NULL.

Yes, jfyi: I "artificially" reproduced this by making
dummy_handle explicitly = 0 again.
And I see that KASAN points to the same location.

I am kind of surprised stackdepot ran out of space that early, but I
guess we cannot take anything for granted.

I am alrady working on a fixup to now blow up here.


-- 
Oscar Salvador
SUSE Labs

