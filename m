Return-Path: <linux-kernel+bounces-67363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEC7856A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BC5B2921F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904661369AC;
	Thu, 15 Feb 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gZZZsrpj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6p0JrjT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gZZZsrpj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6p0JrjT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E71754B;
	Thu, 15 Feb 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016589; cv=none; b=ZHs4VnQ5Ua/MSUTOraIRNGmEA7/aDKchd2ihxeoVtQpc+nBsRpMz1FR9kKpZBywe2zZDxGrMoadArkcrvaWLaW8B4rHR0ixJG9X/WOQzfjUutAjIwnfpfEsLOr3ZSHeSaogWDcBtdNhtFuPVZN+P+1Sa4oRgdFfepyXhYfEJ3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016589; c=relaxed/simple;
	bh=0uOtVcCv5by+PmmDNB00H+v5Het0bum/Kk0ohbRlwIM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9m2LdA8EyPIX+qqxPZttQpVOxWtgO19qq20idjbyyf/yqZMd6jdlriTvDO3Z81FJjmUN98S/5RlDPVbcptyo4cBRU4sDxzFKekPYxaDpt9NhElqyA/E1KrlQDHHHAHyazrWUOGffYQHeKyCfjcMbCcb6y/Xi0IPKt4w0BroFik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gZZZsrpj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6p0JrjT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gZZZsrpj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6p0JrjT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDF4A1F8C0;
	Thu, 15 Feb 2024 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708016581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE2C3TS0NQyhae+V1iqq4n7gnKw4vfeeFaL7iWqrHjw=;
	b=gZZZsrpjpmQlhBDxgDO1spokU/6v0eP6bD7xCleZkHwdXIM8ulgd2vT4uajBfiBFLjMoeM
	3G9RDHq8oANn4s8747R5adZxZ54rvRTAsXcIojwOt0ApkMrRgdOUoK7rhLg+v/jWs7M/f1
	8CytI4SbppkD2H53lAbaSzSrafBnyUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708016581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE2C3TS0NQyhae+V1iqq4n7gnKw4vfeeFaL7iWqrHjw=;
	b=s6p0JrjTp0pjN0GbdbXaqdZiElav81pS29+7FBwWDiyNegJ2BA45SA2Xp18+0igXMh1bvv
	2xJB/6/RLRPsnWAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708016581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE2C3TS0NQyhae+V1iqq4n7gnKw4vfeeFaL7iWqrHjw=;
	b=gZZZsrpjpmQlhBDxgDO1spokU/6v0eP6bD7xCleZkHwdXIM8ulgd2vT4uajBfiBFLjMoeM
	3G9RDHq8oANn4s8747R5adZxZ54rvRTAsXcIojwOt0ApkMrRgdOUoK7rhLg+v/jWs7M/f1
	8CytI4SbppkD2H53lAbaSzSrafBnyUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708016581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE2C3TS0NQyhae+V1iqq4n7gnKw4vfeeFaL7iWqrHjw=;
	b=s6p0JrjTp0pjN0GbdbXaqdZiElav81pS29+7FBwWDiyNegJ2BA45SA2Xp18+0igXMh1bvv
	2xJB/6/RLRPsnWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 818ED13A53;
	Thu, 15 Feb 2024 17:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jMYSHsVDzmVVDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Feb 2024 17:03:01 +0000
Date: Thu, 15 Feb 2024 18:03:01 +0100
Message-ID: <875xypk6d6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sven van Ashbrook <svenva@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Hillf Danton <hdanton@sina.com>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
In-Reply-To: <CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
	<20240215034528.240-1-hdanton@sina.com>
	<87h6iaf7di.wl-tiwai@suse.de>
	<CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gZZZsrpj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s6p0JrjT
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,sina.com,chromium.org,vger.kernel.org,google.com,linux.intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BDF4A1F8C0
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Thu, 15 Feb 2024 17:07:38 +0100,
Sven van Ashbrook wrote:
> 
> Hi Takashi,
> 
> On Thu, Feb 15, 2024 at 3:40 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > Yes, the main problem is the indefinite hang from
> > dma_alloc_noncontiguous().
> 
> We have a publicly-visible test [1] which readily triggers the
> indefinite hang on non-iommu Intel SoCs such as JasperLake.
> As noted in the commit message, iommu SoCs are not currently
> affected.
> 
> > So, is the behavior more or less same even if you pass
> > __GFP_RETRY_MAYFAIL to dma_alloc_noncontiguous()?  Or is this flag
> > already implicitly set somewhere in the middle?  It shouldn't hang
> > indefinitely, but the other impact to the system like OOM-killer
> > kickoff may be seen.
> 
> My incomplete understanding:
> 
> Alsa specifies __GFP_RETRY_MAYFAIL because it wants to prevent triggering
> the OOM killer.

Ah I forgot that we set that bit commonly in the flag.

> This was __GFP_NORETRY in the not-too-distant past [2],
> but that failed too quickly, which resulted in permanent loss of audio due
> to failed firmware dma sg allocations.

Hm, the change in commit a61c7d88d38c assumed that __GFP_RETRY_MAYFAIL
shouldn't have that big impact.  If the hang really happens with a
high order allocation, it's dangerous to use it in other code
allocations than noncontiguous case (i.e. SNDRV_DMA_TYPE_DEV and co).
In the tight memory situation, a similar problem can be triggered
quite easily, then.

> In the iommu case, dma_alloc_noncontiguous() implements a backoff [3] loop
> which ORs in __GFP_NORETRY except for minimum order allocations. We observe
> experimentally that __GFP_RETRY_MAYFAIL does not get "stuck" on minimum order
> allocations. So the iommu case is not affected.
> 
> In the non-iommu case however, dma_alloc_noncontiguous() actually becomes a
> contiguous allocator, with no backoff loop. The commit introducing it [4]
> states "This API is only properly implemented for dma-iommu and will simply
> return a contigious chunk as a fallback." In this case we observe the indefinite
> hang.
> 
> The alsa fallback allocator is also not affected by the problem, as it does
> not specify __GFP_RETRY_MAYFAIL. Except in the XENPV case.

So it sounds like that we should go back for __GFP_NORETRY in general
for non-zero order allocations, not only the call you changed, as
__GFP_RETRY_MAYFAIL doesn't guarantee the stuck.

How about the changes like below?

And, Kai, could you verify whether this change with the recent kernel
code won't give significant regressions for the issues you tried to
address with commit a61c7d88d38c?


thanks,

Takashi

--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -19,17 +19,22 @@
 #include <sound/memalloc.h>
 #include "memalloc_local.h"
 
-#define DEFAULT_GFP \
-	(GFP_KERNEL | \
-	 __GFP_RETRY_MAYFAIL | /* don't trigger OOM-killer */ \
-	 __GFP_NOWARN)   /* no stack trace print - this call is non-critical */
-
 static const struct snd_malloc_ops *snd_dma_get_ops(struct snd_dma_buffer *dmab);
 
 #ifdef CONFIG_SND_DMA_SGBUF
 static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size);
 #endif
 
+/* default GFP bits for our allocations */
+static gfp_t default_gfp(size_t size)
+{
+	/* don't allocate intensively for high-order pages */
+	if (size > PAGE_SIZE)
+		return GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY;
+	else
+		return GFP_KERNEL | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
+}
+
 static void *__snd_dma_alloc_pages(struct snd_dma_buffer *dmab, size_t size)
 {
 	const struct snd_malloc_ops *ops = snd_dma_get_ops(dmab);
@@ -281,7 +286,7 @@ static void *do_alloc_pages(struct device *dev, size_t size, dma_addr_t *addr,
 			    bool wc)
 {
 	void *p;
-	gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = default_gfp(size);
 
  again:
 	p = alloc_pages_exact(size, gfp);
@@ -466,7 +471,7 @@ static const struct snd_malloc_ops snd_dma_iram_ops = {
  */
 static void *snd_dma_dev_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
-	return dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr, DEFAULT_GFP);
+	return dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr, default_gfp(size));
 }
 
 static void snd_dma_dev_free(struct snd_dma_buffer *dmab)
@@ -511,7 +516,7 @@ static int snd_dma_wc_mmap(struct snd_dma_buffer *dmab,
 #else
 static void *snd_dma_wc_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
-	return dma_alloc_wc(dmab->dev.dev, size, &dmab->addr, DEFAULT_GFP);
+	return dma_alloc_wc(dmab->dev.dev, size, &dmab->addr, default_gfp(size));
 }
 
 static void snd_dma_wc_free(struct snd_dma_buffer *dmab)
@@ -546,7 +551,7 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
 		return snd_dma_sg_fallback_alloc(dmab, size);
 #endif
 	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
-				      DEFAULT_GFP, 0);
+				      default_gfp(size), 0);
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (!sgt && !get_dma_ops(dmab->dev.dev))
 		return snd_dma_sg_fallback_alloc(dmab, size);
@@ -783,7 +788,7 @@ static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size)
 	while (size > 0) {
 		chunk = min(size, chunk);
 		if (sgbuf->use_dma_alloc_coherent)
-			p = dma_alloc_coherent(dmab->dev.dev, chunk, &addr, DEFAULT_GFP);
+			p = dma_alloc_coherent(dmab->dev.dev, chunk, &addr, default_gfp(size));
 		else
 			p = do_alloc_pages(dmab->dev.dev, chunk, &addr, false);
 		if (!p) {
@@ -871,7 +876,7 @@ static void *snd_dma_noncoherent_alloc(struct snd_dma_buffer *dmab, size_t size)
 	void *p;
 
 	p = dma_alloc_noncoherent(dmab->dev.dev, size, &dmab->addr,
-				  dmab->dev.dir, DEFAULT_GFP);
+				  dmab->dev.dir, default_gfp(size));
 	if (p)
 		dmab->dev.need_sync = dma_need_sync(dmab->dev.dev, dmab->addr);
 	return p;

