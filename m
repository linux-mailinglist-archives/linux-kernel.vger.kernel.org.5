Return-Path: <linux-kernel+bounces-59330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEED84F581
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452071C21DB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6025376F2;
	Fri,  9 Feb 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EHaT4ps2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k6O7++Wk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EHaT4ps2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k6O7++Wk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EF374F8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483721; cv=none; b=KM7gp734/Cv5teAFn1AUJM2t8cefGu4r9yFuBU6U4Xrx731XIqkzqcpFGT+f3ibLbKhPRNy8snNu96UVcOv+MmoKg0/XpjikxOl90vxpj9AdoIZeYXcgY5aBufmi73dQ7AVhrwaWknt1R5x3IqemcC+b/nQRYIjspgtKtlfJ3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483721; c=relaxed/simple;
	bh=uk+kzoCASqZmZnqekuxPV+sUaNOX7ZH8i3a3pm1Ynl4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/BLKZEIm9W7dCdOtmmdwC2HlCD77a0pKbUvbGN21l4Rqy7fQa+NkQmKzFI5HzVnLzgSf/gueZpbuwVASz53EGN5CvQDwYf+jsBWk1q1Gd+jrDa8k5bodPn8D1ZXLLj80wof1Xu5R28XfVb5pJxVq7qzGxL+9073YDIMcTtVlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EHaT4ps2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k6O7++Wk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EHaT4ps2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k6O7++Wk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F02C1FD40;
	Fri,  9 Feb 2024 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707483717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y8iC/kwLc3EVquXaBjRInwt4CwoNth/+iK0Wr9bVro=;
	b=EHaT4ps2bfpx1hA7NW0CjjJNjkF5/gt2qgNiYwAUWM4u1GN6nu4WYvzx48rn+PnC5Cods8
	wscVgB3U2Wcx+2RwDEEHNnJm2DxMNPFP9sL144Oo1zfk95nFFObfdvCr3diyVvKrlfdW1X
	pirv5kpUXBHz4OeK2r1vgB2dg+V8xt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707483717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y8iC/kwLc3EVquXaBjRInwt4CwoNth/+iK0Wr9bVro=;
	b=k6O7++WksDAnfAqyU4ldkaMrHp4IV186RM0LQhBHcndxZnsOLi48imfcD667AXtBhh1f3S
	ZwgOYUcYKhTBsBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707483717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y8iC/kwLc3EVquXaBjRInwt4CwoNth/+iK0Wr9bVro=;
	b=EHaT4ps2bfpx1hA7NW0CjjJNjkF5/gt2qgNiYwAUWM4u1GN6nu4WYvzx48rn+PnC5Cods8
	wscVgB3U2Wcx+2RwDEEHNnJm2DxMNPFP9sL144Oo1zfk95nFFObfdvCr3diyVvKrlfdW1X
	pirv5kpUXBHz4OeK2r1vgB2dg+V8xt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707483717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y8iC/kwLc3EVquXaBjRInwt4CwoNth/+iK0Wr9bVro=;
	b=k6O7++WksDAnfAqyU4ldkaMrHp4IV186RM0LQhBHcndxZnsOLi48imfcD667AXtBhh1f3S
	ZwgOYUcYKhTBsBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 491D71326D;
	Fri,  9 Feb 2024 13:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZkR2EEUixmVgVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Feb 2024 13:01:57 +0000
Date: Fri, 09 Feb 2024 14:01:56 +0100
Message-ID: <877cjd23ln.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: mst@redhat.com,
	jasowang@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: [v2 PATCH 0/1] ALSA: virtio: add support for audio controls
In-Reply-To: <20240115133654.576068-1-aiswarya.cyriac@opensynergy.com>
References: <20240115133654.576068-1-aiswarya.cyriac@opensynergy.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.43%]
X-Spam-Flag: NO

On Mon, 15 Jan 2024 14:36:53 +0100,
Aiswarya Cyriac wrote:
> 
> From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> 
> Changes in v2
> - Fix reporting of incorrect number of items for ENUMERATED controls
> 
> Implementation of support for audio controls in accordance with the
> extension of the virtio sound device specification[1] planned for
> virtio-v1.3-cs01.
> 
> Design　of virtual audio controls is based on and derived from ALSA
> audio controls. It allows the driver to perform all standard operations,
> such as reading and writing audio control value, as well as working with
> metadata (represented in the TLV form).
> 
> The driver part was tested on top of the Linux 5.10 kernel.
> 
> As a device part was used OpenSynergy proprietary implementation.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html
> 
> Anton Yakovlev (1):
>   ALSA: virtio: add support for audio controls

Applied now.  Thanks.


Takashi

