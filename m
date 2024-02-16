Return-Path: <linux-kernel+bounces-68188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B13F8576FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA6E1C21C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F67179A7;
	Fri, 16 Feb 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Otm+wKMi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZYkf6rZb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Otm+wKMi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZYkf6rZb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30217BD4;
	Fri, 16 Feb 2024 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069674; cv=none; b=r+aHjGGF06UIZDyIvTlbCOwRVbduLDGWtFtU/O+DVfAWGI35fYGuOCH13nBedVATAjrhdXZnKjFex4bssKgYqQZ1fDCJnnAmJ8oeOiZ7N1mcvfmdUGUllIZRlRmK1RZG2Zmhxmz7wHEUqThU3djC10eFeB3Jq6n1Y2/c0EQnguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069674; c=relaxed/simple;
	bh=DdL5fXJfBUmO46yqJuAvOHxbIXRJnVW7VjSihxf3JXI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU+obU2n93NpjOsY4ujEBJLRwYDIZSqfA3w4toY/iTXtTcpte2OMONYRJxQ6hmU+h2rMj1zI5KaklRmDREl3b5hxKVGhLV6Vud6HOn5v+VjYsMcm33f62pwac9uF+LYO2vgJHYva3wfonazQZ+nsxKGHNsDE7eL3rEKaUrwNi5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Otm+wKMi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZYkf6rZb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Otm+wKMi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZYkf6rZb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D59B21EF8;
	Fri, 16 Feb 2024 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708069670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmxgjrxV24ZPSFK3SKTNDahiEtkpaOd7a3w/DY30uc0=;
	b=Otm+wKMi4Cmlw4h2SWT88ITzH7wad5oelE4tEd5cYAsipp8d4O89PKLQY7zIhrrZ5859Ej
	Rs8C0Opdhgazfp0spgTN7tRF0yFiqe82xZ5kXzEBke4gRdde+AoSkqJ7FTCSKknK88D4JL
	lfCqfBBaS4fG30pHmreU2cIPamqgOJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708069670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmxgjrxV24ZPSFK3SKTNDahiEtkpaOd7a3w/DY30uc0=;
	b=ZYkf6rZba5oKj5XUCcR4BQFo+yNcnIdRVsbwHOmsIIEENpaM7J4okej8vfYdspEToryzbW
	JN8McTnKdF4Y23AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708069670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmxgjrxV24ZPSFK3SKTNDahiEtkpaOd7a3w/DY30uc0=;
	b=Otm+wKMi4Cmlw4h2SWT88ITzH7wad5oelE4tEd5cYAsipp8d4O89PKLQY7zIhrrZ5859Ej
	Rs8C0Opdhgazfp0spgTN7tRF0yFiqe82xZ5kXzEBke4gRdde+AoSkqJ7FTCSKknK88D4JL
	lfCqfBBaS4fG30pHmreU2cIPamqgOJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708069670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmxgjrxV24ZPSFK3SKTNDahiEtkpaOd7a3w/DY30uc0=;
	b=ZYkf6rZba5oKj5XUCcR4BQFo+yNcnIdRVsbwHOmsIIEENpaM7J4okej8vfYdspEToryzbW
	JN8McTnKdF4Y23AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DEF413A67;
	Fri, 16 Feb 2024 07:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rAXkBSYTz2VoVAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Feb 2024 07:47:50 +0000
Date: Fri, 16 Feb 2024 08:47:49 +0100
Message-ID: <87r0hcj1ei.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Sven van Ashbrook <svenva@chromium.org>,
	Hillf Danton <hdanton@sina.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
In-Reply-To: <CAJZwx_n6sGfgNgm-WKoHEgY-=L0r1HbbZc8p5LroF0etMSx=gg@mail.gmail.com>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
	<20240215034528.240-1-hdanton@sina.com>
	<87h6iaf7di.wl-tiwai@suse.de>
	<CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
	<875xypk6d6.wl-tiwai@suse.de>
	<CAJZwx_n6sGfgNgm-WKoHEgY-=L0r1HbbZc8p5LroF0etMSx=gg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Otm+wKMi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZYkf6rZb
X-Spamd-Result: default: False [-2.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
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
	 FREEMAIL_CC(0.00)[suse.de,chromium.org,sina.com,vger.kernel.org,google.com,linux.intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D59B21EF8
X-Spam-Level: 
X-Spam-Score: -2.31
X-Spam-Flag: NO

On Thu, 15 Feb 2024 20:32:22 +0100,
Karthikeyan Ramasubramanian wrote:
> 
> On Thu, Feb 15, 2024 at 10:03 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Thu, 15 Feb 2024 17:07:38 +0100,
> > Sven van Ashbrook wrote:
> > >
> > > Hi Takashi,
> > >
> > > On Thu, Feb 15, 2024 at 3:40 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > Yes, the main problem is the indefinite hang from
> > > > dma_alloc_noncontiguous().
> > >
> > > We have a publicly-visible test [1] which readily triggers the
> > > indefinite hang on non-iommu Intel SoCs such as JasperLake.
> > > As noted in the commit message, iommu SoCs are not currently
> > > affected.
> > >
> > > > So, is the behavior more or less same even if you pass
> > > > __GFP_RETRY_MAYFAIL to dma_alloc_noncontiguous()?  Or is this flag
> > > > already implicitly set somewhere in the middle?  It shouldn't hang
> > > > indefinitely, but the other impact to the system like OOM-killer
> > > > kickoff may be seen.
> > >
> > > My incomplete understanding:
> > >
> > > Alsa specifies __GFP_RETRY_MAYFAIL because it wants to prevent triggering
> > > the OOM killer.
> >
> > Ah I forgot that we set that bit commonly in the flag.
> >
> > > This was __GFP_NORETRY in the not-too-distant past [2],
> > > but that failed too quickly, which resulted in permanent loss of audio due
> > > to failed firmware dma sg allocations.
> >
> > Hm, the change in commit a61c7d88d38c assumed that __GFP_RETRY_MAYFAIL
> > shouldn't have that big impact.  If the hang really happens with a
> > high order allocation, it's dangerous to use it in other code
> > allocations than noncontiguous case (i.e. SNDRV_DMA_TYPE_DEV and co).
> > In the tight memory situation, a similar problem can be triggered
> > quite easily, then.
> >
> > > In the iommu case, dma_alloc_noncontiguous() implements a backoff [3] loop
> > > which ORs in __GFP_NORETRY except for minimum order allocations. We observe
> > > experimentally that __GFP_RETRY_MAYFAIL does not get "stuck" on minimum order
> > > allocations. So the iommu case is not affected.
> > >
> > > In the non-iommu case however, dma_alloc_noncontiguous() actually becomes a
> > > contiguous allocator, with no backoff loop. The commit introducing it [4]
> > > states "This API is only properly implemented for dma-iommu and will simply
> > > return a contigious chunk as a fallback." In this case we observe the indefinite
> > > hang.
> > >
> > > The alsa fallback allocator is also not affected by the problem, as it does
> > > not specify __GFP_RETRY_MAYFAIL. Except in the XENPV case.
> >
> > So it sounds like that we should go back for __GFP_NORETRY in general
> > for non-zero order allocations, not only the call you changed, as
> > __GFP_RETRY_MAYFAIL doesn't guarantee the stuck.
> >
> > How about the changes like below?
> 
> We are concerned that the below proposed change might break the fix
> introduced by commit a61c7d88d38c ("FROMGIT: ALSA: memalloc: use
> __GFP_RETRY_MAYFAIL for DMA mem allocs"). More specifically in the
> IOMMU case with a large allocation, the fallback algorithm in the DMA
> IOMMU allocator[1] will not try really hard and hence may fail
> prematurely when it gets to minimum order allocations. This will
> result in no audio when there is significant load on physical memory.

Hm, then we may give __GFP_RETRY_MAYFAIL specially for iommu case,
too?  Something like v2 patch below.


thanks,

Takashi

--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -21,7 +21,11 @@
 
 #define DEFAULT_GFP \
 	(GFP_KERNEL | \
-	 __GFP_RETRY_MAYFAIL | /* don't trigger OOM-killer */ \
+	 __GFP_NORETRY | /* don't trigger OOM-killer */ \
+	 __GFP_NOWARN)   /* no stack trace print - this call is non-critical */
+#define DEFAULT_GFP_RETRY \
+	(GFP_KERNEL | \
+	 __GFP_RETRY_MAYFAIL | /* try a bit harder */ \
 	 __GFP_NOWARN)   /* no stack trace print - this call is non-critical */
 
 static const struct snd_malloc_ops *snd_dma_get_ops(struct snd_dma_buffer *dmab);
@@ -30,6 +34,13 @@ static const struct snd_malloc_ops *snd_dma_get_ops(struct snd_dma_buffer *dmab)
 static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size);
 #endif
 
+/* default GFP bits for our allocations */
+static gfp_t default_gfp(size_t size)
+{
+	/* don't allocate intensively for high-order pages */
+	return (size > PAGE_SIZE) ? DEFAULT_GFP : DEFAULT_GFP_RETRY;
+}
+
 static void *__snd_dma_alloc_pages(struct snd_dma_buffer *dmab, size_t size)
 {
 	const struct snd_malloc_ops *ops = snd_dma_get_ops(dmab);
@@ -281,7 +292,7 @@ static void *do_alloc_pages(struct device *dev, size_t size, dma_addr_t *addr,
 			    bool wc)
 {
 	void *p;
-	gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = default_gfp(size);
 
  again:
 	p = alloc_pages_exact(size, gfp);
@@ -466,7 +477,7 @@ static const struct snd_malloc_ops snd_dma_iram_ops = {
  */
 static void *snd_dma_dev_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
-	return dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr, DEFAULT_GFP);
+	return dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr, default_gfp(size));
 }
 
 static void snd_dma_dev_free(struct snd_dma_buffer *dmab)
@@ -511,7 +522,7 @@ static int snd_dma_wc_mmap(struct snd_dma_buffer *dmab,
 #else
 static void *snd_dma_wc_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
-	return dma_alloc_wc(dmab->dev.dev, size, &dmab->addr, DEFAULT_GFP);
+	return dma_alloc_wc(dmab->dev.dev, size, &dmab->addr, default_gfp(size));
 }
 
 static void snd_dma_wc_free(struct snd_dma_buffer *dmab)
@@ -539,14 +550,20 @@ static const struct snd_malloc_ops snd_dma_wc_ops = {
 static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
 	struct sg_table *sgt;
+	gfp_t gfp = default_gfp(size);
 	void *p;
 
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (cpu_feature_enabled(X86_FEATURE_XENPV))
 		return snd_dma_sg_fallback_alloc(dmab, size);
+	/* dma_alloc_noncontiguous() with IOMMU is safe to pass
+	 * __GFP_RETRY_MAYFAIL option for more intensive allocations
+	 */
+	if (get_dma_ops(dmab->dev.dev))
+		gfp = DEFAULT_GFP_RETRY;
 #endif
 	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
-				      DEFAULT_GFP, 0);
+				      gfp, 0);
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (!sgt && !get_dma_ops(dmab->dev.dev))
 		return snd_dma_sg_fallback_alloc(dmab, size);
@@ -783,7 +800,7 @@ static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size)
 	while (size > 0) {
 		chunk = min(size, chunk);
 		if (sgbuf->use_dma_alloc_coherent)
-			p = dma_alloc_coherent(dmab->dev.dev, chunk, &addr, DEFAULT_GFP);
+			p = dma_alloc_coherent(dmab->dev.dev, chunk, &addr, default_gfp(size));
 		else
 			p = do_alloc_pages(dmab->dev.dev, chunk, &addr, false);
 		if (!p) {
@@ -871,7 +888,7 @@ static void *snd_dma_noncoherent_alloc(struct snd_dma_buffer *dmab, size_t size)
 	void *p;
 
 	p = dma_alloc_noncoherent(dmab->dev.dev, size, &dmab->addr,
-				  dmab->dev.dir, DEFAULT_GFP);
+				  dmab->dev.dir, default_gfp(size));
 	if (p)
 		dmab->dev.need_sync = dma_need_sync(dmab->dev.dev, dmab->addr);
 	return p;

