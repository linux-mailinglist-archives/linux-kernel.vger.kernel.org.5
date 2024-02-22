Return-Path: <linux-kernel+bounces-76021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5F85F206
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF22D283CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FB1799F;
	Thu, 22 Feb 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ev/wKbj7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A8vK9tsN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ev/wKbj7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A8vK9tsN"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAE17583
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587908; cv=none; b=p9GtgOnPbDQ2eXhCyCb7iVw0hajG9bRKycLo7UdvikGi2vgxDykfd3WTvFCx/gYsbBXsBSm9uyKQgDSFXObX8MTVTb5/jh2WXmYRX7BPU8BlwE9amVPqEh2THGcAhKuefY7mBhW7rn15lprkneKzIe4eE6HXcF8Uyd5PG0bdBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587908; c=relaxed/simple;
	bh=NGw3m+vYzCsoVBjM4auFjsR8rAuJpOq6jTi0UQHbHbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2CCmkXA5tdAvbXVXvhPShPAVi7e82NmyvvPImAJY6ZYVhmojYTVgye2x5qV1dIL60ojcjFnPKJ6e/lvOsLiNs8AI298jXcqi7VNZXar0yfAxqxckfiB2vMe+KToIwoTnklHY6DZzA/pdWe3rf4fGliwFsaH48YLcUFZ3vYcezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ev/wKbj7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A8vK9tsN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ev/wKbj7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A8vK9tsN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45F4722280;
	Thu, 22 Feb 2024 07:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708587904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=;
	b=Ev/wKbj7mutRHm61bCp9Y9yogY7qN4fVkrf8mZxovT6LGK0UNyibfEFjFQ7FaLmher2JsH
	AG6bymldnKSTFNC62Ok9/nE2cxqHzkwLFwiLFpehTgIVHq60KdNc4HzZ7yCYrdr8mNIa7U
	g/saKCvAoCrfq4z4dyILcWUfVm5zZgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708587904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=;
	b=A8vK9tsNjWriImdmlEn/E+uJhA7fWEtI9c20/pKWnghzHoorFzzBJvt4hzpPQqs6zIAC1f
	oh6UGGcWMwTGEMDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708587904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=;
	b=Ev/wKbj7mutRHm61bCp9Y9yogY7qN4fVkrf8mZxovT6LGK0UNyibfEFjFQ7FaLmher2JsH
	AG6bymldnKSTFNC62Ok9/nE2cxqHzkwLFwiLFpehTgIVHq60KdNc4HzZ7yCYrdr8mNIa7U
	g/saKCvAoCrfq4z4dyILcWUfVm5zZgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708587904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS/oBuhqVCRAaM1P3lEPeO1fB5jBvOrtamH5uOtmETA=;
	b=A8vK9tsNjWriImdmlEn/E+uJhA7fWEtI9c20/pKWnghzHoorFzzBJvt4hzpPQqs6zIAC1f
	oh6UGGcWMwTGEMDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 31A0513A6B;
	Thu, 22 Feb 2024 07:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id DDirCoD71mUDCgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 22 Feb 2024 07:45:04 +0000
Date: Thu, 22 Feb 2024 08:45:03 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Message-ID: <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
 <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.58%]
X-Spam-Flag: NO

On Thu, Feb 22, 2024 at 07:46:12AM +0100, Hannes Reinecke wrote:
> On 2/21/24 17:37, Daniel Wagner wrote:
> > On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
> > In this case yes, I've tested on top of this patch. This breaks the loop
> > where the provided key is invalid or is missing. The loop would happy
> > retry until reaching max of retries.
> 
> But that's to be expected, no?

Why? If the key is wrong/missing it will be likely wrong/missing the
next retry again. So what's the point in retrying?

> After all, that's _precisely_ what
> NVME_SC_DNR is for;
> if you shouldn't retry, that bit is set.
> If it's not set, you should.

Okay, in this case there is a bug in the auth code somewhere.

> So why is NVME_SC_AUTH_REQUIRED an exception?

status is either NVME_SC_AUTH_REQUIRED or -ECONNREFUSED for the first
part of the nvme/041 (no key set). In this case DNR bit is not set.

Note, when -ECONNREFUSED is return

	if (status > 0 && (status & NVME_SC_DNR))

will not catch it either.

Glad we have these tests now.

