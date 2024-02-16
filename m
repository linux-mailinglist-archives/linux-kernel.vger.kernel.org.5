Return-Path: <linux-kernel+bounces-68756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF22857F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A9EB24005
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6E12EBE6;
	Fri, 16 Feb 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T7eUGnnc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dm8Eo0KK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T7eUGnnc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dm8Eo0KK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4521E481;
	Fri, 16 Feb 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094593; cv=none; b=cGH1b4jizvO4D55OuAIH8lcPKGJ1KSAJ9sHKyGjuvtpN5QfGu9kJgHkbeFDxKpYYBwJ2CKUH83uF+8AFosnh5Kg/3WCWzceszSQ7jsxRZEccUedBUmz5jCtlo9hek61br2s2vL8HJLQxJhhvlPMqTuWJeOwMoy3fM+YS0DXGoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094593; c=relaxed/simple;
	bh=gT0oseVynYTafJld86SH4XZLUTBr2p+yx+ySnBnZzZA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOvDtbxW8MXByTOm6Z1tmalqnD+YxUqVX7yRXDB1rVrTgGisQdmT41w8qPzZTFK4pvRFkfhGBZnv6l12qEfiL7FcRHEqMwDsqJwulsq+SoQMsOszBJahDUIZlfKzuoLkh3tHawPbbsoYPmAf6OmJAO5PRgMr4gQtP1WewlPiSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T7eUGnnc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dm8Eo0KK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T7eUGnnc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dm8Eo0KK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 248F921E45;
	Fri, 16 Feb 2024 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708094590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3VS8sfdW/5jDqLrreFlG1Bg57E3+t54+tk8UpEFpKA8=;
	b=T7eUGnncqvxScKHsEv9VRWckbnxO4280FIN8vQdqbLGGx4uFRDQBCt78Ija771gEfSq3Ni
	dRf+XCWDmQ/E6DCyVnDtMQXiWB8fMBNm4EWPT20I9ABnnQIkeGXqDiDoD3kL+o5s7Gwfir
	xt91pf1U37V8Eto4dstakD8524d4eyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708094590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3VS8sfdW/5jDqLrreFlG1Bg57E3+t54+tk8UpEFpKA8=;
	b=Dm8Eo0KK8NJSf6EUbW+a4cYyTLPF7prH3sEsr0lHGZZh8gp8ZVB0SdqDvz4jQ11/7AMDwr
	Ng//kbVLOdYB0iBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708094590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3VS8sfdW/5jDqLrreFlG1Bg57E3+t54+tk8UpEFpKA8=;
	b=T7eUGnncqvxScKHsEv9VRWckbnxO4280FIN8vQdqbLGGx4uFRDQBCt78Ija771gEfSq3Ni
	dRf+XCWDmQ/E6DCyVnDtMQXiWB8fMBNm4EWPT20I9ABnnQIkeGXqDiDoD3kL+o5s7Gwfir
	xt91pf1U37V8Eto4dstakD8524d4eyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708094590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3VS8sfdW/5jDqLrreFlG1Bg57E3+t54+tk8UpEFpKA8=;
	b=Dm8Eo0KK8NJSf6EUbW+a4cYyTLPF7prH3sEsr0lHGZZh8gp8ZVB0SdqDvz4jQ11/7AMDwr
	Ng//kbVLOdYB0iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79991398D;
	Fri, 16 Feb 2024 14:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RhRbM310z2WtNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Feb 2024 14:43:09 +0000
Date: Fri, 16 Feb 2024 15:43:09 +0100
Message-ID: <87zfw0h3lu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Hillf Danton <hdanton@sina.com>,
	Sven van Ashbrook <svenva@chromium.org>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-sound@vger.kernel.org,
	"Arava, Jairaj" <jairaj.arava@intel.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
In-Reply-To: <alpine.DEB.2.22.394.2402161246520.14041@eliteleevi.tm.intel.com>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
	<20240215034528.240-1-hdanton@sina.com>
	<87h6iaf7di.wl-tiwai@suse.de>
	<CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
	<875xypk6d6.wl-tiwai@suse.de>
	<20240216043426.1218-1-hdanton@sina.com>
	<87plwwiz6z.wl-tiwai@suse.de>
	<87frxsiueo.wl-tiwai@suse.de>
	<alpine.DEB.2.22.394.2402161246520.14041@eliteleevi.tm.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[sina.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,sina.com,chromium.org,vger.kernel.org,google.com,intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Fri, 16 Feb 2024 13:19:54 +0100,
Kai Vehmanen wrote:
> 
> Hi,
> 
> On Fri, 16 Feb 2024, Takashi Iwai wrote:
> 
> > On Fri, 16 Feb 2024 09:35:32 +0100, Takashi Iwai wrote:
> > > The fact that we have to drop __GFP_RETRY_MAYFAIL indicates that the
> > > handling there doesn't suffice -- at least for the audio operation.
> > 
> > Reconsidering on this again, I wonder keeping __GFP_RETRY_MAYFAIL
> > makes sense.  We did have __GFP_NORETRY for avoiding OOM-killer.
> > But it's been over ages, and the memory allocation core became smart
> > enough.
> > 
> > The side-effect of __GFP_RETRY_MAYFAIL is that the page reclaim and
> > compaction happens even for high-order allocations, and that must be
> 
> for the original problem that led to "ALSA: memalloc: use 
> __GFP_RETRY_MAYFAIL for DMA mem allocs", reclaim for low-order case
> would be enough. I.e. the case was:
> 
> > OTOH, a slight concern with the drop of __GFP_RETRY_MAYFAIL is whether
> > allowing OOM-killer for low order allocations is acceptable or not.
> > 
> > There are two patterns of calling allocators:
> [..]
> > 3. SNDRV_DMA_TYPE_NONCONTIG for large size:
> >    this is called often, once per stream open, since the driver
> >    doesn't keep the buffer.
> 
> So with SOF we have additional case where we do an allocation for the DSP 
> firmware (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG, ...)) and this is 
> called at system resume. With s/__GPF_RETRY_MAYFAIL/__GFP_NORETRY/, these 
> allocations failed (on a iommu enabled Chromebook) at system resume in a 
> case where system was not really running out of memory (reclaim was 
> possible). A failed allocation means there's no audio in the system after 
> resume, so we want to try harder.
> 
> But yeah, I think the proposed handling for (3) category would work. If 
> needed, we can further specialize the DSP firmware case with some hint 
> to snd_dma_alloc_pages().

OK, then how about the one like below?

This changes:
- Back to __GFP_NORETRY as default
- Use __GFP_RETRY_MAYFAIL for SNDRV_DMA_TYPE_NONCONTIG with IOMMU;
  this should cover the commit a61c7d88d38c
- Also use __GFP_RETRY_MAYFAIL for the SG-fallback allocations of the
  minimal order, just like IOMMU allocator does.

This should be less destructive, while still allowing more aggressive
allocations for SG buffers.


thanks,

Takashi

--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -21,9 +21,13 @@
 
 #define DEFAULT_GFP \
 	(GFP_KERNEL | \
-	 __GFP_RETRY_MAYFAIL | /* don't trigger OOM-killer */ \
+	 __GFP_NORETRY | /* don't trigger OOM-killer */ \
 	 __GFP_NOWARN)   /* no stack trace print - this call is non-critical */
 
+/* GFP flags to be used for low order pages, allowing reclaim and compaction */
+#define DEFAULT_GFP_RETRY \
+	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN)
+
 static const struct snd_malloc_ops *snd_dma_get_ops(struct snd_dma_buffer *dmab);
 
 #ifdef CONFIG_SND_DMA_SGBUF
@@ -281,7 +285,11 @@ static void *do_alloc_pages(struct device *dev, size_t size, dma_addr_t *addr,
 			    bool wc)
 {
 	void *p;
-	gfp_t gfp = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
+	gfp_t gfp = DEFAULT_GFP;
+
+	/* allow reclaim and compaction for low order pages */
+	if (size <= PAGE_SIZE)
+		gfp = DEFAULT_GFP_RETRY;
 
  again:
 	p = alloc_pages_exact(size, gfp);
@@ -539,14 +547,18 @@ static const struct snd_malloc_ops snd_dma_wc_ops = {
 static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
 {
 	struct sg_table *sgt;
+	gfp_t gfp = DEFAULT_GFP;
 	void *p;
 
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (cpu_feature_enabled(X86_FEATURE_XENPV))
 		return snd_dma_sg_fallback_alloc(dmab, size);
+	/* with IOMMU, it's safe to pass __GFP_RETRY_MAYFAIL with high order */
+	if (get_dma_ops(dmab->dev.dev))
+		gfp = DEFAULT_GFP_RETRY;
 #endif
 	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
-				      DEFAULT_GFP, 0);
+				      gfp, 0);
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (!sgt && !get_dma_ops(dmab->dev.dev))
 		return snd_dma_sg_fallback_alloc(dmab, size);

