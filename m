Return-Path: <linux-kernel+bounces-150106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5438D8A9A77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA09282CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF81494D7;
	Thu, 18 Apr 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d//EmpV7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qhIZOI/M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d//EmpV7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qhIZOI/M"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955714534A;
	Thu, 18 Apr 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444999; cv=none; b=sEPRTQydx2dnNeY6qam7EqvGghb9IMjaOqym4+V/KgqV3qnOvKpQpARvzuBXKAfqfIdw/CMcAcNZRFWpNh/VOWyqeqdP65KtpLENmUzcvOrknN5HUHPa+k3nO/GdshlLjs8sXZsFJkqbif0hW+VJUGQh+Qf+CtKUp9Is/L2HqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444999; c=relaxed/simple;
	bh=tZwZbH3t9+jI8ZPj+pbNwDFfO8ad6j/2fNSpYtZ936o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2vSF/hqnrQY7vrWFPJl11qrp5wudbJPPvNBuepUZP5EXSgQB9vc3Vaaxyc8k/eiaqGzB0uaaK0TAfg9+TO3lRTzfRvdn8odC/dJzFm3kiblPe9mfBl2z8Kdf1QAJ6cH1I25ezQxUjJKDoh7gGNSohTgx7y4deUGHM4SYl2flh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d//EmpV7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qhIZOI/M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d//EmpV7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qhIZOI/M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4562334F41;
	Thu, 18 Apr 2024 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713444996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFkNbHloo6eDmJBBEFb5kMyTCFOG6CeK8eS1GXeDLw0=;
	b=d//EmpV7KJUrjBhQ68Q91DnE6Cio86i1PFi0Ko+rIGaBsd4llaD6hyJe097aTXlhIMlMxN
	/LKAWpG5uQ0cRTnoRBkFX9eXAdcT758YNlQAmYFQF/xYk0Ma8yBWfWBiNBGjy+C9FNGJ7D
	MMaH50sQRIN8HdCdLmt3BT802m3aJaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713444996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFkNbHloo6eDmJBBEFb5kMyTCFOG6CeK8eS1GXeDLw0=;
	b=qhIZOI/MEmcKDL3Fp0J2ij62hopqbzTPWbxaOcQFmp5yKZfTFKm8X1tkxJ3dSW204NbRK9
	BLeSt5coAD2GaADQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713444996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFkNbHloo6eDmJBBEFb5kMyTCFOG6CeK8eS1GXeDLw0=;
	b=d//EmpV7KJUrjBhQ68Q91DnE6Cio86i1PFi0Ko+rIGaBsd4llaD6hyJe097aTXlhIMlMxN
	/LKAWpG5uQ0cRTnoRBkFX9eXAdcT758YNlQAmYFQF/xYk0Ma8yBWfWBiNBGjy+C9FNGJ7D
	MMaH50sQRIN8HdCdLmt3BT802m3aJaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713444996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFkNbHloo6eDmJBBEFb5kMyTCFOG6CeK8eS1GXeDLw0=;
	b=qhIZOI/MEmcKDL3Fp0J2ij62hopqbzTPWbxaOcQFmp5yKZfTFKm8X1tkxJ3dSW204NbRK9
	BLeSt5coAD2GaADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E9071384C;
	Thu, 18 Apr 2024 12:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bu8KHIMYIWakAwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 18 Apr 2024 12:56:35 +0000
Message-ID: <a1f56653f2e2be923ed47f7e968230ca8a856553.camel@suse.de>
Subject: Re: CVE-2024-26827: i2c: qcom-geni: Correct I2C TRE sequence
From: Jean Delvare <jdelvare@suse.de>
To: cve@kernel.org, linux-kernel@vger.kernel.org, 
	linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 18 Apr 2024 14:56:33 +0200
In-Reply-To: <2024041703-CVE-2024-26827-67c1@gregkh>
References: <2024041703-CVE-2024-26827-67c1@gregkh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.25 / 50.00];
	BAYES_HAM(-2.95)[99.78%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.25
X-Spam-Flag: NO

Hi Greg,

On Wed, 2024-04-17 at 11:44 +0200, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> i2c: qcom-geni: Correct I2C TRE sequence
> 
> For i2c read operation in GSI mode, we are getting timeout
> due to malformed TRE basically incorrect TRE sequence
> in gpi(drivers/dma/qcom/gpi.c) driver.
> (...)

I was assigned the task to backport this security fix to the SUSE
kernels. However, from the description, I fail to see how this fix
qualifies as a security fix. I can't find the reason why a CVE was
assigned to the issue.

What is the considered attack vector? Or if there is no attack vector,
what consequence does this bug have, which would put the system
security at stake?

From my perspective, all we have here is a functional bug in newly
introduced code. It's not even a regression.


-- 
Jean Delvare
SUSE L3 Support

