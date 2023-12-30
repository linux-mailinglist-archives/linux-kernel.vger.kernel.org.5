Return-Path: <linux-kernel+bounces-13371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F582041B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3281C20C09
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BAC20EA;
	Sat, 30 Dec 2023 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2IuES+5r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="918YNzGQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2IuES+5r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="918YNzGQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4E63C4;
	Sat, 30 Dec 2023 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F35622111;
	Sat, 30 Dec 2023 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703927595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juDSCuSZKi75OdYbZI/wIeZL0Qy62bQFE+aWStVoyOM=;
	b=2IuES+5rRL3i53Tzo/C8/VNiDWfzFbFLASJXH0jcOF4XDByCYob8nPQG1zbMDiasn7DHSL
	/ekqh5g739Xnx3CZSPYFtsZuJlXLxfNT9b2f3gIbAE5r/VuJ49DPeh/GP37LBm/XCzcwOJ
	nK59XCUn1QWwigNJi+OMq19ZpkAdIJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703927595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juDSCuSZKi75OdYbZI/wIeZL0Qy62bQFE+aWStVoyOM=;
	b=918YNzGQmkVOUdHr2qklOfiZ32z5HwCidcTvE+eFPNZ4Tc2gK4m0Ppzdl2KVJYbQkqgewA
	mI6v2UC58bQkHZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703927595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juDSCuSZKi75OdYbZI/wIeZL0Qy62bQFE+aWStVoyOM=;
	b=2IuES+5rRL3i53Tzo/C8/VNiDWfzFbFLASJXH0jcOF4XDByCYob8nPQG1zbMDiasn7DHSL
	/ekqh5g739Xnx3CZSPYFtsZuJlXLxfNT9b2f3gIbAE5r/VuJ49DPeh/GP37LBm/XCzcwOJ
	nK59XCUn1QWwigNJi+OMq19ZpkAdIJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703927595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=juDSCuSZKi75OdYbZI/wIeZL0Qy62bQFE+aWStVoyOM=;
	b=918YNzGQmkVOUdHr2qklOfiZ32z5HwCidcTvE+eFPNZ4Tc2gK4m0Ppzdl2KVJYbQkqgewA
	mI6v2UC58bQkHZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A614136D1;
	Sat, 30 Dec 2023 09:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r4FVFCvfj2U9NQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 30 Dec 2023 09:13:15 +0000
Date: Sat, 30 Dec 2023 10:13:14 +0100
Message-ID: <87y1dcvys5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <set_pte_at@outlook.com>,
	Yu Liao <liaoyu15@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ALSA: mark all struct bus_type as const
In-Reply-To: <2023121945-immersion-budget-d0aa@gregkh>
References: <2023121945-immersion-budget-d0aa@gregkh>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2IuES+5r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=918YNzGQ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.53 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.02)[95.15%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[outlook.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[suse.com,perex.cz,vger.kernel.org,outlook.com,huawei.com,kernel.org,redhat.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.53
X-Rspamd-Queue-Id: 9F35622111
X-Spam-Flag: NO

On Tue, 19 Dec 2023 14:34:46 +0100,
Greg Kroah-Hartman wrote:
> 
> Now that the driver core can properly handle constant struct bus_type,
> move all of the sound subsystem struct bus_type structures as const,
> placing them into read-only memory which can not be modified at runtime.
> 
> Note, this fixes a duplicate definition of ac97_bus_type, which somehow
> was declared extern in a .h file, and then static as a prototype in a .c
> file, and then properly later on in the same .c file.  Amazing that no
> compiler warning ever showed up for this.
> 
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Dawei Li <set_pte_at@outlook.com>
> Cc: Yu Liao <liaoyu15@huawei.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-sound@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to for-next branch now.  Thanks.


Takashi

