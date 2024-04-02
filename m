Return-Path: <linux-kernel+bounces-127414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3167894B08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB79B222F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1F1862B;
	Tue,  2 Apr 2024 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k+A+ZzBr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AdWEbvUs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A517CA73;
	Tue,  2 Apr 2024 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037678; cv=none; b=azIWGNtFjmDMvWP0QqlDcuEyKLxSG2obY7W8PrfZwoIa45Zl2cOR9TzlzJ5aQhk2i1ryuWHwANPYbjWZBPsIzSDrPAjL/ZRlyqnetfDFi3HI1c3Ih+li1i8biw5xTUzXfNvYbC0hCc13eWmHjjbuVL3VoNZpQ7ByGg8Ftkzyitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037678; c=relaxed/simple;
	bh=eiridHwvvbURq+mvxqaO4gwPnk3esqKxdtP2g93Ouao=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dar8NXhLBivdGqA038obNn34vLcbUOHfpVKcpSLlqkrbRQ3/cycJ5bgZsPvnfRu4slvuw8PgRzEl/xzyGc95+SJIUznaIM8DSWvgrsRZMnlZ29/JozUB/HfT4OzXfELATLkpgb3bnpB2/ZqjyhoY4O7cq+WOzFxbrDrFxIurW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k+A+ZzBr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AdWEbvUs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CD7020C5B;
	Tue,  2 Apr 2024 06:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712037675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvwV/vPDO9C36qfxeYCNdArujqghN+pnO3Hn3P4P7CQ=;
	b=k+A+ZzBrOVaWOyt0Oi6MNmWYlVzMXUqkISZWqPpyXb02vyemWzlBrjaocDD5EEmjuVYc76
	BI8V98eyCHFO1x4tm62W65+Wy3xwLk55484r2WX4i9i5/jyJcv/tziBbGwOXXgWns2FCWc
	7IcK93QCa+90R3aa0Tcws5pVxFrSbmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712037675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvwV/vPDO9C36qfxeYCNdArujqghN+pnO3Hn3P4P7CQ=;
	b=AdWEbvUse565Tjr+k0RsTBniaW1JGJapYSPagkXH9RcOMLMojRTnLSbS4EF1fKKYK7IO4I
	ssGV6dl91IL3woAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EF7013A90;
	Tue,  2 Apr 2024 06:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id o1uDISqfC2ZBMwAAn2gu4w
	(envelope-from <tiwai@suse.de>); Tue, 02 Apr 2024 06:01:14 +0000
Date: Tue, 02 Apr 2024 08:01:19 +0200
Message-ID: <875xx0tia8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christian Bendiksen <Christian@bendiksen.me>
Cc: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	foss@athaariq.my.id,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Bendiksen <christian@bendiksen.me>
Subject: Re: [PATCH v3] Add sound quirks for Lenovo Legion slim 7 16ARHA7 models.
In-Reply-To: <20240401122603.6634-1-christian@bendiksen.me>
References: <20240329185406.9802-1-christian@bendiksen.me>
	<87r0fsnmky.wl-tiwai@suse.de>
	<20240330115554.27895-1-christian@bendiksen.me>
	<87y19x5wfs.wl-tiwai@suse.de>
	<20240401122603.6634-1-christian@bendiksen.me>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: 1.87
X-Spam-Flag: NO
X-Spamd-Bar: +
X-Spamd-Result: default: False [1.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-0.997];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.06%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0CD7020C5B

On Mon, 01 Apr 2024 14:26:10 +0200,
Christian Bendiksen wrote:
> 
> This fixes the sound not working from internal speakers on
> Lenovo Legion Slim 7 16ARHA7 models. The correct subsystem ID
> have been added to cs35l41_hda_property.c and patch_realtek.c.
> 
> Signed-off-by: Christian Bendiksen <christian@bendiksen.me>

Thanks, applied.


Takashi

