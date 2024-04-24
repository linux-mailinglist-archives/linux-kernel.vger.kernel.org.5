Return-Path: <linux-kernel+bounces-156837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A4B8B08EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B34DB23723
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7315ADA0;
	Wed, 24 Apr 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qvMS+x2T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+PTqdgI6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qvMS+x2T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+PTqdgI6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6A15AAA3;
	Wed, 24 Apr 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960513; cv=none; b=aZFELEUnuubHPMO8sl2gCB4bT02QbcExeCb+9zgxjRlq7Sa4R75AH2CK24mz6XYynPn+mo6SaNBE+so6jWGwkiroerHBWLOv/lpQjiSIwchetaUax6HYNDrTeAd4cpjcE6ttRNbgAK88vmRPUyjf9nE0LhFH2D5o1sCrYn1YSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960513; c=relaxed/simple;
	bh=M3mgjjZMWslEpDdvR5BHVIkih0v7I5MbCLa/5f8E7HY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHeba4HMcI/BvFw0VF7JkhI6liyUDGdlLCjoBGoro2VyIpn65X/lNpR6XVEd4x/Z9OAjCCp+I8gVljlAgq3XsBDxnyd0I7TkQdOqDJFxCDwMmg3pobm/ldCf8jxiN0ruQ8nhnzKDpM2CcwZY1+pSsIrLnZwW9xQE1Vmns/D4b4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qvMS+x2T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+PTqdgI6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qvMS+x2T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+PTqdgI6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7392F66D5A;
	Wed, 24 Apr 2024 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713960507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPo6LYWGIcBp+mNjcHDpf4JJIugYDwxxnCTA7zK7CkQ=;
	b=qvMS+x2TVlRqhzaUOivIQIrONoqIJQBFOg0tV6E/AAXqC1Gtp7CuqKWXDuPdrfUDzOL1F5
	1C8bzidLeun0qevSGyK6NHm74x+J6djZNZwv0G6571qxQ+WaQ8YMxBBhqN+pK1IQER7FSo
	x0TF7fpEEiAVnoiFCBMn+GBQZMwJmcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713960507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPo6LYWGIcBp+mNjcHDpf4JJIugYDwxxnCTA7zK7CkQ=;
	b=+PTqdgI6NjMWRB002GnHoB0lI6wzbs2NObR5rB4OLbFyGNhxOgR8BZp1BbLwbEOKp/4Nkn
	nokt6uGBeDtfARCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qvMS+x2T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+PTqdgI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713960507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPo6LYWGIcBp+mNjcHDpf4JJIugYDwxxnCTA7zK7CkQ=;
	b=qvMS+x2TVlRqhzaUOivIQIrONoqIJQBFOg0tV6E/AAXqC1Gtp7CuqKWXDuPdrfUDzOL1F5
	1C8bzidLeun0qevSGyK6NHm74x+J6djZNZwv0G6571qxQ+WaQ8YMxBBhqN+pK1IQER7FSo
	x0TF7fpEEiAVnoiFCBMn+GBQZMwJmcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713960507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPo6LYWGIcBp+mNjcHDpf4JJIugYDwxxnCTA7zK7CkQ=;
	b=+PTqdgI6NjMWRB002GnHoB0lI6wzbs2NObR5rB4OLbFyGNhxOgR8BZp1BbLwbEOKp/4Nkn
	nokt6uGBeDtfARCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 611931393C;
	Wed, 24 Apr 2024 12:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mcABETr2KGb8ZwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 24 Apr 2024 12:08:26 +0000
Date: Wed, 24 Apr 2024 14:08:23 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC] s390/pci: Drop unneeded reference to CONFIG_DMI
Message-ID: <20240424140823.55475951@endymion.delvare>
In-Reply-To: <Zij1fJw+Ksrq5iAm@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240423162724.3966265a@endymion.delvare>
	<b5ee24107efbc943cfc8ea59bf0653d2dd6325ad.camel@linux.ibm.com>
	<Zij1fJw+Ksrq5iAm@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7392F66D5A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -6.51

On Wed, 24 Apr 2024 14:05:49 +0200, Alexander Gordeev wrote:
> On Wed, Apr 24, 2024 at 01:34:49PM +0200, Niklas Schnelle wrote:
> > I'm assuming this change should go via the s390 tree? So let me add the
> > s390x architecture maintainers to pick this up, but from my side and
> > considering that you maintain the SMBIOS/DMI support:  
> 
> Hi Jean,
> 
> Whether this patch is good to go alone via s390 tree or (as Niklas
> indicated) might depend on some SMBIOS/DMI update?


It's good to go through the s390 tree, it's a simple clean-up which
doesn't depend on anything else.

> > Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>  

Thanks to both of you!

-- 
Jean Delvare
SUSE L3 Support

