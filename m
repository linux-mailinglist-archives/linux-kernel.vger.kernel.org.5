Return-Path: <linux-kernel+bounces-49469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD96846AB9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9863B1F24398
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90C182C5;
	Fri,  2 Feb 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TOOo9rQ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0kxwgFn4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TOOo9rQ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0kxwgFn4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712C18042
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862534; cv=none; b=ApLWfMkuaOCLUm3BuN+OkbyWiTN4FDVyQpecTMT74t6o9LmxGClQ8IicJCVmJWJnsxjA8YLJvDg2RATf2MCCyhK1a6GLy5OIzngg1mifcjLTzpOyGwo6Xq1nZFJe/c4nCiO8SdwPRfqPEEpQ20ZD1xDgxY0+HO+Cju6DDOWXWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862534; c=relaxed/simple;
	bh=26F7aeq5HhWyoPhZMrZiqHwekA/hhDjFM3DWXbhyaXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6nZDoBXTBk70MBtL3PmNV6ocP7weXBRulgnnt7ylE0qymj6TbdG4tW/TiPWj01pfP+cnzRmNl17/tXDcE6OWmSqO7uKHUkbEc53KfJbL/LoW1It0inOl4uS1rOAL0hw+j2aSdigXcgUgP2BAsBXbvRsntEvl6yfOZc8kc5Derc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TOOo9rQ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0kxwgFn4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TOOo9rQ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0kxwgFn4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 789BB1F7B5;
	Fri,  2 Feb 2024 08:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706862529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUddC1I+jw2IHlukgEBRe9GvjxAroUZ7wuAoEIiY7Dw=;
	b=TOOo9rQ3411Cu7tO0NXyFJhhn6vwdhwE+NURq2A7BGcKTDbZIGevPEqVKgwQGkCxRFdh2x
	qOGGY6w4Ulyc8CBNO+l4J2Xw9djqY5Q+mPTUXUMJVgE/4pu44VSlVbDbbJZrD/Vy70uN0c
	EmmuIzp2O98ZZ4XYKFD6OAIwAfqsojk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706862529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUddC1I+jw2IHlukgEBRe9GvjxAroUZ7wuAoEIiY7Dw=;
	b=0kxwgFn4BF7Phlj0jdeUbWCxA0FtnIKVf9FqmHJPS498fCup49MaNCeCK4x6ZDLXX03lHi
	LEPynSdeoM61C7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706862529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUddC1I+jw2IHlukgEBRe9GvjxAroUZ7wuAoEIiY7Dw=;
	b=TOOo9rQ3411Cu7tO0NXyFJhhn6vwdhwE+NURq2A7BGcKTDbZIGevPEqVKgwQGkCxRFdh2x
	qOGGY6w4Ulyc8CBNO+l4J2Xw9djqY5Q+mPTUXUMJVgE/4pu44VSlVbDbbJZrD/Vy70uN0c
	EmmuIzp2O98ZZ4XYKFD6OAIwAfqsojk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706862529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUddC1I+jw2IHlukgEBRe9GvjxAroUZ7wuAoEIiY7Dw=;
	b=0kxwgFn4BF7Phlj0jdeUbWCxA0FtnIKVf9FqmHJPS498fCup49MaNCeCK4x6ZDLXX03lHi
	LEPynSdeoM61C7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 127A913A58;
	Fri,  2 Feb 2024 08:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vhFYA8GnvGXjPgAAD6G6ig
	(envelope-from <jroedel@suse.de>); Fri, 02 Feb 2024 08:28:49 +0000
Date: Fri, 2 Feb 2024 09:28:43 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, jgg@ziepe.ca,
	tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
	gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
	vaibhav@linux.ibm.com
Subject: Re: [PATCH v2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <Zbynu1YYeqpUMy2t@suse.de>
References: <170628173462.3742.18330000394415935845.stgit@ltcd48-lp2.aus.stglab.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170628173462.3742.18330000394415935845.stgit@ltcd48-lp2.aus.stglab.ibm.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TOOo9rQ3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0kxwgFn4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[lists.linux.dev,lists.ozlabs.org,vger.kernel.org,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com,ziepe.ca,raptorengineering.com,amd.com,linuxfoundation.org,linux.vnet.ibm.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: 789BB1F7B5
X-Spam-Flag: NO

On Fri, Jan 26, 2024 at 09:09:18AM -0600, Shivaprasad G Bhat wrote:
> The commit 2ad56efa80db ("powerpc/iommu: Setup a default domain and
> remove set_platform_dma_ops") refactored the code removing the
> set_platform_dma_ops(). It missed out the table group
> release_ownership() call which would have got called otherwise
> during the guest shutdown via vfio_group_detach_container(). On
> PPC64, this particular call actually sets up the 32-bit TCE table,
> and enables the 64-bit DMA bypass etc. Now after guest shutdown,
> the subsequent host driver (e.g megaraid-sas) probe post unbind
> from vfio-pci fails like,
> 
> megaraid_sas 0031:01:00.0: Warning: IOMMU dma not supported: mask 0x7fffffffffffffff, table unavailable
> megaraid_sas 0031:01:00.0: Warning: IOMMU dma not supported: mask 0xffffffff, table unavailable
> megaraid_sas 0031:01:00.0: Failed to set DMA mask
> megaraid_sas 0031:01:00.0: Failed from megasas_init_fw 6539
> 
> The patch brings back the call to table_group release_ownership()
> call when switching back to PLATFORM domain from BLOCKED, while
> also separates the domain_ops for both.
> 
> Fixes: 2ad56efa80db ("powerpc/iommu: Setup a default domain and remove set_platform_dma_ops")
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
> Changelog:
> v1: https://lore.kernel.org/linux-iommu/170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com/
>  - Split the common attach_dev call to platform and blocked attach_dev
>    calls as suggested.
> 
>  arch/powerpc/kernel/iommu.c |   37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany
https://www.suse.com/

Geschäftsführer: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)

