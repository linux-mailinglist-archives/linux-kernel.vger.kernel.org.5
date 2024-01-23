Return-Path: <linux-kernel+bounces-34850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C02838849
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B21428572C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B70053E2E;
	Tue, 23 Jan 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Btl067fn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2tgb3Y6k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Btl067fn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2tgb3Y6k"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ED952F7E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996362; cv=none; b=ASn0WMrKbgeA8N4JCKZxHHqFm3Pwm0hjdmKskfjDPzVMYdnbofMhQl9OVf3Qv41GrzWQPve8FmSyq2SePcvidrLne4kMyWKmw5zPfOaoSNt3RU3Mkp5LBqZ1YWhwUumZoOWEC6+4pgqAPiUy8KhwSGkvZqbCwSTHqSi4yunFDLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996362; c=relaxed/simple;
	bh=pFyUKCV7PckLl73NJF0nEHxcP3YgpX8KAqzVymf34Ho=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i53NnPUV+XMpKvgKbONn7FJDVnUSB7EqQIZkEYL1IjZ/loz8iJ6vHBnT/yg/CJeQbMHgdOg1DTLt8iVPnL5B3WYpY8mMUS8VpxOPCZomDHHQquuMvkMIiaJiDni1Oz1XwrypuVl7dfiXvYRMWo/iYtrCE50o7FPDIf9YNy44mIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Btl067fn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2tgb3Y6k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Btl067fn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2tgb3Y6k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AC2D21F4E;
	Tue, 23 Jan 2024 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705996359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvT3vWO52L/uHnktDoGcR4sTbjQr2MfIdjzVdS6mfY=;
	b=Btl067fn6lRnDDq9NCXx84J6dWAQopZuYVmvqMzXRrR+RVpx9ZmBRpOGISuAvXRIHiYIQR
	o7ZYGlM/dkzBw6ZO6ujOmDAchzYKXyaItbmEBtFAfyF5TrD3JZ5kkdcrazzltIPw+27mQJ
	VRkLzE72/Zflb+J2SbUn5FhTimUj/Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705996359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvT3vWO52L/uHnktDoGcR4sTbjQr2MfIdjzVdS6mfY=;
	b=2tgb3Y6kVFmEynpEywD4x7MKw0O2f7l6fOCo3iHycEJMQLD8dfRqVMEe+I40RPaY6m4wyW
	Wc/haavMLkLTnADA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705996359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvT3vWO52L/uHnktDoGcR4sTbjQr2MfIdjzVdS6mfY=;
	b=Btl067fn6lRnDDq9NCXx84J6dWAQopZuYVmvqMzXRrR+RVpx9ZmBRpOGISuAvXRIHiYIQR
	o7ZYGlM/dkzBw6ZO6ujOmDAchzYKXyaItbmEBtFAfyF5TrD3JZ5kkdcrazzltIPw+27mQJ
	VRkLzE72/Zflb+J2SbUn5FhTimUj/Ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705996359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prvT3vWO52L/uHnktDoGcR4sTbjQr2MfIdjzVdS6mfY=;
	b=2tgb3Y6kVFmEynpEywD4x7MKw0O2f7l6fOCo3iHycEJMQLD8dfRqVMEe+I40RPaY6m4wyW
	Wc/haavMLkLTnADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 540D813786;
	Tue, 23 Jan 2024 07:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qlsQE0dwr2UMZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 23 Jan 2024 07:52:39 +0000
Date: Tue, 23 Jan 2024 08:52:38 +0100
Message-ID: <87wms0mqpl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	<alsa-devel@alsa-project.org>,
	<patches@opensource.cirrus.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/cs8409: Suppress vmaster control for Dolphin models
In-Reply-To: <20240122184710.5802-1-vitalyr@opensource.cirrus.com>
References: <20240122184710.5802-1-vitalyr@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Btl067fn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2tgb3Y6k
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.18)[96.06%]
X-Spam-Score: -4.69
X-Rspamd-Queue-Id: 8AC2D21F4E
X-Spam-Flag: NO

On Mon, 22 Jan 2024 19:47:10 +0100,
Vitaly Rodionov wrote:
> 
> Customer has reported an issue with specific desktop platform
> where two CS42L42 codecs are connected to CS8409 HDA bridge.
> If "Master Volume Control" is created then on Ubuntu OS UCM
> left/right balance slider in UI audio settings has no effect.
> This patch will fix this issue for a target paltform.
> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Applied, thanks.


Takashi

