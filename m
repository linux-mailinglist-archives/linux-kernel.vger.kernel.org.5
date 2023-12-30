Return-Path: <linux-kernel+bounces-13378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700D820430
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185741F21500
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F162104;
	Sat, 30 Dec 2023 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QiU/UuUf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yy7q7dR3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QiU/UuUf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yy7q7dR3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530742569;
	Sat, 30 Dec 2023 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FA121F7FF;
	Sat, 30 Dec 2023 09:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703929914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7SEnAfj7Gc7hlBZeB3BVW71blHARjm0RW3jbk3qL5/A=;
	b=QiU/UuUfd6rUEgP3fXXLR6KFR4PgXvUAvD57qOIojYG69y2XS2LNJcu2gvmEL2Irc6XqGK
	IjlcAQg31VydaUrx0zrb5mDeS6yBE5lNNRtmpWLknSTyTE2PngHcOvFYHfgFbccGTeXQkM
	Bm6+nLQOzQFCDmUC5gqI7OPMe6islrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703929914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7SEnAfj7Gc7hlBZeB3BVW71blHARjm0RW3jbk3qL5/A=;
	b=yy7q7dR3QC73CTv2V7Eau08K2IlbtZ7qtlMyLkmGZbIv8iuXS1Py8srSLpDzQ7IKlRbVC0
	6kleS27fLYERQTDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703929914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7SEnAfj7Gc7hlBZeB3BVW71blHARjm0RW3jbk3qL5/A=;
	b=QiU/UuUfd6rUEgP3fXXLR6KFR4PgXvUAvD57qOIojYG69y2XS2LNJcu2gvmEL2Irc6XqGK
	IjlcAQg31VydaUrx0zrb5mDeS6yBE5lNNRtmpWLknSTyTE2PngHcOvFYHfgFbccGTeXQkM
	Bm6+nLQOzQFCDmUC5gqI7OPMe6islrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703929914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7SEnAfj7Gc7hlBZeB3BVW71blHARjm0RW3jbk3qL5/A=;
	b=yy7q7dR3QC73CTv2V7Eau08K2IlbtZ7qtlMyLkmGZbIv8iuXS1Py8srSLpDzQ7IKlRbVC0
	6kleS27fLYERQTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1062136D1;
	Sat, 30 Dec 2023 09:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tH8MKTnoj2WxOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 30 Dec 2023 09:51:53 +0000
Date: Sat, 30 Dec 2023 10:51:53 +0100
Message-ID: <87sf3kvwzq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/tas2781: configure the amp after firmware load
In-Reply-To: <7f2f65d9212aa16edd4db8725489ae59dbe74c66.1703895108.git.soyer@irl.hu>
References: <7f2f65d9212aa16edd4db8725489ae59dbe74c66.1703895108.git.soyer@irl.hu>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="QiU/UuUf";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yy7q7dR3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.58)[98.13%]
X-Spam-Score: -3.09
X-Rspamd-Queue-Id: 1FA121F7FF
X-Spam-Flag: NO

On Sat, 30 Dec 2023 01:13:41 +0100,
Gergo Koteles wrote:
> 
> Make the amp available immediately after a module
> load to avoid having to wait for a PCM hook action.
> (eg. unloading & loading the module while listening
> music)
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Applied to for-next branch now.  Thanks.


Takashi

