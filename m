Return-Path: <linux-kernel+bounces-130406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65AA8977AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219451C24DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C81534F2;
	Wed,  3 Apr 2024 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EjFAWg0w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3X2qWgdy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0820152DE8;
	Wed,  3 Apr 2024 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167205; cv=none; b=Kd5Kplc22AY7+1HHqUV68XCYR3APLTqQfOl6IBGDa06ifMww8JTTp+F7uMjkBdgL0WqFSnBqKXo1mLfLLT7S+KA9oBD8j5uE7ti2k+P8HaOSdKWSYs6XFdUkN0mB+bnT6cmnNFG6btjFyvKco2QKWttEjICS4O9Bnslo3ZiikUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167205; c=relaxed/simple;
	bh=akMpuOYW8d21pNYolHALUYqWPtLngxJw4oM3B3EG6/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFyLHyicJkO9ezCi+vq2woZqjoYYC+Y9nZrYHBpWn5RU/wHatTYMCzTg0LIwskMbVTAOWEf6/9EyJ/gRTGPWUzh41viJF7tdJXpP9INhvFiE6VB7KgTpYeuGc5xGzBDWDMQIuvbfRca86aqdzg2sqrE+xTWXiqW/95oK9mNpAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EjFAWg0w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3X2qWgdy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9827F5CFB7;
	Wed,  3 Apr 2024 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712167201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WVZeI3/RILOZMpa4/5S/fb/IdPQ20KwGhNOEMIQR25Y=;
	b=EjFAWg0woE/7/zENyNkKM1nI4IOz76PCg5InEyg452gd/vSbAoOXuNhCKOofe6lS53snXC
	aG08U6J/u7IhamP+v3aR795vEOQEKeeW0IudGvfCYLviQ54OeGQMfp9FjiEHwA2bzRFXoC
	x71ewbIw0y8qcFguu6SN0Tp3R7ZJ4XI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712167201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WVZeI3/RILOZMpa4/5S/fb/IdPQ20KwGhNOEMIQR25Y=;
	b=3X2qWgdyewXf65o9zL329LriohAoYdNx66WMJt1P89kCDIJWBwHc5QGKF36iii0alMT/tS
	mz8aO1JA722DadDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EF621331E;
	Wed,  3 Apr 2024 18:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qoLaASGZDWZeJAAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 03 Apr 2024 18:00:01 +0000
Date: Wed, 3 Apr 2024 19:59:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alexander Reimelt <alexander.reimelt@posteo.de>, andersson@kernel.org,
	konrad.dybcio@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add basic support for LG G4 (H815)
Message-ID: <20240403175951.GB462665@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240403104415.30636-1-alexander.reimelt@posteo.de>
 <20240403104415.30636-3-alexander.reimelt@posteo.de>
 <10f02618-f16c-47d4-a27f-074b1ecffaa1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10f02618-f16c-47d4-a27f-074b1ecffaa1@linaro.org>
X-Spam-Score: -1.03
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.03 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[posteo.de:email];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.72)[98.80%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: 9827F5CFB7

Hi all,

> On 03/04/2024 12:43, Alexander Reimelt wrote:
> > To make it easier for downstream projects and avoid duplication of work.
> > Makes the device bootable and enables all buttons, most regulators, hall sensor, eMMC and SD-Card.

> > Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile            |   1 +
> >  arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts | 422 +++++++++++++++++++
> >  2 files changed, 423 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts


> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

@Alexander arm: would be for 32bit. Correct subject prefix is:
arm64: dts: qcom: msm8992-lg-h815:

Krzysztof's comments are obviously correct.
Please Cc me on v2 to my gmail private mail. Thanks!

Kind regards,
Petr

