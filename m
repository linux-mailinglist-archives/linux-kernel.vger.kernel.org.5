Return-Path: <linux-kernel+bounces-23568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A4082AE7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CF81C22ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C315AE3;
	Thu, 11 Jan 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o81DRlNB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qlKv6ltC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sQsB0ZdR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="amNtEnDw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0115AC1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E227922176;
	Thu, 11 Jan 2024 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704975114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ6EiKm9+zrf1MVWJnt/w6kWyLkf78kIw+Odu+lYT2E=;
	b=o81DRlNBhyKgF449fCfHaSiTvUqz4GH5axcaaauVQ9LP7gd8UO+lz2uzIyLahln2/0n5iT
	lM54iIpCwlPs8FglsYmDy1gspN/5lpeFljQ39GsJW1GORt962c9W6hy8Mwqnr857VZhWUo
	CtCLU7Coq4FhzpBpXr2XMfRc7ySayiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704975114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ6EiKm9+zrf1MVWJnt/w6kWyLkf78kIw+Odu+lYT2E=;
	b=qlKv6ltCsChaGIz2v/fTuMnhKeM7v8cDWpAhUC3Yau7+FK6/HcxwtLWQNxy7lJmBn+jKhC
	qryvdVnTFxGfppBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704975111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ6EiKm9+zrf1MVWJnt/w6kWyLkf78kIw+Odu+lYT2E=;
	b=sQsB0ZdRGtVfjASu6ct/7u6Lxw4XihBNofXPVG0AR0c8sLPvVHShfuT8uYox+WULhWDcUS
	oK7lPbObYuWsH/cyKtRea09BUm1yrks9zaiiPBpOmh4hq1EmXxfp9R9VnpSnmyEUw1ikah
	xX4iyB2t6lgjXVNzKhl1KXAJGPiTcVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704975111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ6EiKm9+zrf1MVWJnt/w6kWyLkf78kIw+Odu+lYT2E=;
	b=amNtEnDwOc7rA/6MhLUL9Qq96Bc0F2XCBudpEEm68Innrln+gsZ25Gj+AHAVQcfZC0dOKj
	oWFFqbHrIZcMKKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 972A513635;
	Thu, 11 Jan 2024 12:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j4pkIwfbn2VfHwAAD6G6ig
	(envelope-from <aherrmann@suse.de>); Thu, 11 Jan 2024 12:11:51 +0000
Date: Thu, 11 Jan 2024 13:12:13 +0100
From: Andreas Herrmann <aherrmann@suse.de>
To: Neal Gompa <neal@gompa.dev>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Jason Gunthorpe <jgg@nvidia.com>, jirislaby@kernel.org,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	pinskia@gmail.com, kent.overstreet@linux.dev
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <20240111121213.GC4609@alberich>
References: <fa64c852-01c4-4e4c-8b89-14db5e0088d0@p183>
 <CAEg-Je9ahyp+asVHCcMr7KXYqDRzxJnQmqYcz1V+LH3ZEfT+Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je9ahyp+asVHCcMr7KXYqDRzxJnQmqYcz1V+LH3ZEfT+Ww@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sQsB0ZdR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=amNtEnDw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.18 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.17)[69.79%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:url,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,zytor.com,nvidia.com,kernel.org,redhat.com,vger.kernel.org,linux.dev];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.18
X-Rspamd-Queue-Id: E227922176
X-Spam-Flag: NO

On Thu, Jan 11, 2024 at 05:58:51AM -0500, Neal Gompa wrote:
> On Thu, Jan 11, 2024 at 5:56 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > > SFINAE giving inscrutable errors is why I'm saying C++20,
> > > since "concept" means you can get usable error messages.
> >
> > I'd say concepts are irrelevant for the kernel where standard library is
> > tightly controlled by the same people who write rest of the kernel and
> > no external users.
> >
> > static_assert() is all you need.
> 
> We have external users all the time, though. People who write external
> modules or new modules would fall in that classification. Why should
> it be harder for them?

I guess, I misunderstand something.

But WRT to the term 'external module' I have some comment.

My personal opinion is somewhat reflected in following article:

https://www.linuxfoundation.org/blog/blog/the-people-who-support-linux-snowden-revelations-spur-engineers-open-source-donation
(The People Who Support Linux: Snowden Revelations Spur Engineer's
Open Source Donation) [The Linux Foundation | 18 December 2013]

  „“The public needs fully open source OSes, where experts can review
  the whole code, to minimize the risk of hidden backdoors,” said
  Kies.“

Thinking more about this.

What exactly was the reason to allow Rust in the kernel?

What exactly is the reason to allow C++ in the kernel?

Besides, I think in general that complexity can be destructive -- even
in a world without bad actors.

> -- 
> 真実はいつも一つ！/ Always, there's only one truth!

