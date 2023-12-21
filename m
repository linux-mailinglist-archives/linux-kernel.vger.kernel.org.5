Return-Path: <linux-kernel+bounces-8104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3A81B237
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E42E1F21BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC7E4F602;
	Thu, 21 Dec 2023 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZgGBLaUT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Rly12+U8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZgGBLaUT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Rly12+U8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C84F5E9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3BAF1FB5E;
	Thu, 21 Dec 2023 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703150250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=;
	b=ZgGBLaUTZ35sdBmN9jxBqi+ypLe/Y7Lj8/0MAODO3Ue3wxzDDLga38e2V857u71DgEbbC+
	V0HKyRC976bzKBJ3Ko00HyeHGvpXuw/7eNmYo2LkFwAIbc8UanIrpeLzUMIxjKnhqOv6Q1
	suWc+Z2QybrJtPjj2K32HWBhCC93X5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703150250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=;
	b=Rly12+U8wxzKyL98Ki48+s5PiiXsqV0wtep7Xwf7FBFlJmQs6S0pxFhMvJCn/7JSAm6uNN
	fXaed7EDXbtES/CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703150250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=;
	b=ZgGBLaUTZ35sdBmN9jxBqi+ypLe/Y7Lj8/0MAODO3Ue3wxzDDLga38e2V857u71DgEbbC+
	V0HKyRC976bzKBJ3Ko00HyeHGvpXuw/7eNmYo2LkFwAIbc8UanIrpeLzUMIxjKnhqOv6Q1
	suWc+Z2QybrJtPjj2K32HWBhCC93X5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703150250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afsZBjEJLNrRami7LX1LeXszkJWNZ3H/aGbmJJOwZlM=;
	b=Rly12+U8wxzKyL98Ki48+s5PiiXsqV0wtep7Xwf7FBFlJmQs6S0pxFhMvJCn/7JSAm6uNN
	fXaed7EDXbtES/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEEA713725;
	Thu, 21 Dec 2023 09:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hmn+NKkChGX0LgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Dec 2023 09:17:29 +0000
Date: Thu, 21 Dec 2023 10:15:15 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 08/16] nvmet-fc: untangle cross refcounting objects
Message-ID: <l3etc7ia7mx7fc6ko764amf56xrink2vyv3kdirzcuzwfls2nz@wy66e6t4oxbl>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-9-dwagner@suse.de>
 <20231219051648.GA32634@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219051648.GA32634@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.89
X-Spamd-Result: default: False [-0.89 / 50.00];
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
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.28%]
X-Spam-Flag: NO

On Tue, Dec 19, 2023 at 06:16:48AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 04:30:56PM +0100, Daniel Wagner wrote:
> > The live time of the queues are strictly bound to the lifetime of an
> 
> > +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
> >  	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
> 
> For magic prefixes we use __, not _ in Linux.  But having two arrays
> of queues right next to each other, once with rcu annotation and one
> not rings a bit far warning bell to me.  Why do we have both?  When
> are we supposed to use either?  Why is FC different from rest?

This is my attempt to solve the problem that after NULLing the rcu
pointer and wait for an RCU graceperiod I still need to cleanup the
queues. Thus I need to keep hold on the queue pointers a bit longer.
Indeed not so elegant.

I'm sure there is a better way to do it, I just didn't figure it out
when I wrote this part. Any tips are highly welcomed how to solve this
puzzle.

> I really don't have any good answers as I don't know the code in the
> FC transport very well, but I think this needs more work.

Indeed, blktests still is able to run into a hanger. So not all problems
are sovled but getting closer.

