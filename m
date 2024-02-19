Return-Path: <linux-kernel+bounces-70907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E81859DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DFA1C221E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E634820DFC;
	Mon, 19 Feb 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sb4MAF9D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IlB1cgVw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sb4MAF9D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IlB1cgVw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3A20DD9;
	Mon, 19 Feb 2024 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330199; cv=none; b=Daqabe78D2S/aSn8cz4vx4gHUaX2x2FzZ4Z0rzenHUhrkeiix7o2cxX2g4V1qvoq0wadbMBY/sJ03VZu9kpgI6cZQ4m1+KqIx1kphsCpPChMJJH0RDoCQ0ruscAoovm/5cLloNlKf26l8GIjunlY/tk7+Xf7AB+9y2IxxST/wmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330199; c=relaxed/simple;
	bh=kYA5wdHtwjrn8oLeN1C1LqpgvH68DRjLShJ/XuooKMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9sosR7d/45krp3pJfjRuMIxfFdoohSrI/4X+g46M/9pag0Rqb9fLp/I/ZJ3aTVpaoYv/nDuaUMhPFZADfj4NSf430q6LnCulm2w7JGKOpzpzILxweMW9VGEFz1bjR8y+UfAB+Yu9JnSuqpfe5IXIxT+/xFtzwqKmgP37BzluJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sb4MAF9D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IlB1cgVw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sb4MAF9D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IlB1cgVw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 860141F7DD;
	Mon, 19 Feb 2024 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708330195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+W/bpv2D3c0ZM1YOskN3/VvP+1dFlkBTARg3DDHNZV4=;
	b=Sb4MAF9DroERnRVpTUQKSc6xiAwy9itXQnqmCAmWldYwnhwba3C+m7puLCqejqZeK9V/GQ
	+d+RqD0PG7AabQv9q52OZ4AYm2i+YsJEwgNMQM5Re5L4LYDp9o106dGDcvOv/kgnvy7o5Q
	8QEe9R8B9CpTaNiiHG0WuRdO+I7wON4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708330195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+W/bpv2D3c0ZM1YOskN3/VvP+1dFlkBTARg3DDHNZV4=;
	b=IlB1cgVwV2qR4MEjkpQRMz+jGRbWHpkHwHhdjiKwhJG6aoLRcvrsbGqsdn0VRZ56EIGyeP
	SK5KuG8f2+U1dKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708330195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+W/bpv2D3c0ZM1YOskN3/VvP+1dFlkBTARg3DDHNZV4=;
	b=Sb4MAF9DroERnRVpTUQKSc6xiAwy9itXQnqmCAmWldYwnhwba3C+m7puLCqejqZeK9V/GQ
	+d+RqD0PG7AabQv9q52OZ4AYm2i+YsJEwgNMQM5Re5L4LYDp9o106dGDcvOv/kgnvy7o5Q
	8QEe9R8B9CpTaNiiHG0WuRdO+I7wON4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708330195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+W/bpv2D3c0ZM1YOskN3/VvP+1dFlkBTARg3DDHNZV4=;
	b=IlB1cgVwV2qR4MEjkpQRMz+jGRbWHpkHwHhdjiKwhJG6aoLRcvrsbGqsdn0VRZ56EIGyeP
	SK5KuG8f2+U1dKDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F22F213585;
	Mon, 19 Feb 2024 08:09:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3gZiONIM02U6PAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Mon, 19 Feb 2024 08:09:54 +0000
Date: Mon, 19 Feb 2024 09:11:06 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org,
	ying.huang@intel.com, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: Fix a bug calling wakeup_kswapd() with a
 wrong zone index
Message-ID: <ZdMNGvUOWnNn9zDh@localhost.localdomain>
References: <20240216111502.79759-1-byungchul@sk.com>
 <517e58d4-7537-4d9f-8893-0130c65c3fdb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <517e58d4-7537-4d9f-8893-0130c65c3fdb@linux.alibaba.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Sb4MAF9D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IlB1cgVw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.41 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.90)[86.08%]
X-Spam-Score: -2.41
X-Rspamd-Queue-Id: 860141F7DD
X-Spam-Flag: NO

On Mon, Feb 19, 2024 at 02:25:11PM +0800, Baolin Wang wrote:
> This means that there is no memory on the target node？ if so, we can add a
> check at the beginning to avoid calling unnecessary
> migrate_misplaced_folio().
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e95503d7544e..a64a1aac463f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5182,7 +5182,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>         else
>                 last_cpupid = folio_last_cpupid(folio);
>         target_nid = numa_migrate_prep(folio, vma, vmf->address, nid,
> &flags);
> -       if (target_nid == NUMA_NO_NODE) {
> +       if (target_nid == NUMA_NO_NODE || !node_state(target_nid, N_MEMORY))
> {
>                 folio_put(folio);
>                 goto out_map;
>         }
> 
> (similar changes for do_huge_pmd_numa_page())

With the check in place from [1], numa_migrate_prep() will also return
NUMA_NO_NODE, so no need for this one here.

And I did not check, but I assume that do_huge_pmd_numa_page() also ends
up calling numa_migrate_prep().

[1] https://lore.kernel.org/lkml/20240219041920.1183-1-byungchul@sk.com/
 

-- 
Oscar Salvador
SUSE Labs

