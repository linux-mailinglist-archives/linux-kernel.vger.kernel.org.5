Return-Path: <linux-kernel+bounces-27155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD7E82EB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F928541B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B2B125DC;
	Tue, 16 Jan 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gr8TO5zK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c83cIKpT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cpheKOxy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7ZnOlsG4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34612E40;
	Tue, 16 Jan 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77A6D21D3A;
	Tue, 16 Jan 2024 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705396351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwFA2m/Z66wKrG/1bMhcSd3/CmtOmzK1Avqei0bF3Ls=;
	b=gr8TO5zKc04OXwKaXq+wdLvp9kuFI5RlazoAyoXJGkcRhiuEUo4/UZXbTNklzt5fY0VYRs
	5JmN1++4oOZmROAr2VZM4rGct2deigqXNgmzOXJIjdAA2wG/1LxTDx58uBGhwD8ofrwUTI
	ZgSXci0y0e8Ay7mt/0hlBDtro/RhP2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705396351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwFA2m/Z66wKrG/1bMhcSd3/CmtOmzK1Avqei0bF3Ls=;
	b=c83cIKpTx0vRsgSBMctBb8F492GgzhU3AUgPnPVmWmNruLRRMJr0FvY81PutaXen9Eg6vr
	DezYSozPFkSoo/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705396350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwFA2m/Z66wKrG/1bMhcSd3/CmtOmzK1Avqei0bF3Ls=;
	b=cpheKOxyGu7EdNT+rqyodvejn2o55sm/0pvChAXgcn3/o56gzdC3V5sQowiIiD3zDj4DL4
	Kci603hxXI49P793N9Neg42ESLBmV2fkKIiu+t7+7a+BUyR0kZqYGSuaYSg+iFLL8H7IaW
	cl5wCahWN7Ny2d0e/FZjDoyR4Mh6oOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705396350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwFA2m/Z66wKrG/1bMhcSd3/CmtOmzK1Avqei0bF3Ls=;
	b=7ZnOlsG4KYj7w4el0Mk8/rzXNp50tvm+6hdAw9Or3G2EMklMAKNB0fAb1RCkCkThlHN3Hv
	8iVjGMeaTG18iVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 502FA132FA;
	Tue, 16 Jan 2024 09:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zhd0En5IpmXHDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 16 Jan 2024 09:12:30 +0000
Date: Tue, 16 Jan 2024 10:12:29 +0100
Message-ID: <875xztwsjm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-3?Q?=C7a=BBhan?= Demir <caghandemir@marun.edu.tr>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx
In-Reply-To: <20240115172303.4718-1-caghandemir@marun.edu.tr>
References: <20240113023734.10817-2-caghandemir@marun.edu.tr>
	<20240115172303.4718-1-caghandemir@marun.edu.tr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-3
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cpheKOxy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7ZnOlsG4
X-Spamd-Result: default: False [-0.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[marun.edu.tr:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.27)[89.78%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.58
X-Rspamd-Queue-Id: 77A6D21D3A
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, 15 Jan 2024 18:23:03 +0100,
Ça»han Demir wrote:
> 
> This HP Laptop uses ALC236 codec with COEF 0x07 idx 1 controlling
> the mute LED. This patch enables the already existing quirk for
> this device.
> 
> Signed-off-by: Ça»han Demir <caghandemir@marun.edu.tr>

Thanks, applied now.


Takashi

