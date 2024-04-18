Return-Path: <linux-kernel+bounces-150328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769A8A9D69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE941C2122E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C898616C694;
	Thu, 18 Apr 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hz68QkON";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b4H0BG2U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hz68QkON";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b4H0BG2U"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7062E168B11
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451478; cv=none; b=UJIp4F1rVfPxGMk2EBc9xZtIsOfuHXEp3FbsFhiD8qj6qrHn9juQXz+4bpUmKeZVawg1NLjA+aEc/Usa75bAFrVFs8v0ebVu9lNNI3VxbtpJTsxUJpLR4oaoKFV3hJ7t6NN+Dg7gVaQKMGprViynhsQWLoX8+0AfgEnnfkXbCQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451478; c=relaxed/simple;
	bh=BlQmiuLIrQEqw2st4D+FyeeFt0VdrzENTLOychKwUQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=odWFVxIcJ3p/yY0enYv4wG50dKpIzdiRIZZ6HqDc9YrMRF+4SQJnMSnRQHvSBeYuAwb6TPJEso1Rvxj3WuXHzJ5DTEuY0Sjc5b1FhpN11mtdQ9sJNv31mErV8vZcjGY6HMymvNzPXKvjf78glnDnTNGO7rxHvCu31goLZ+yBhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hz68QkON; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b4H0BG2U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hz68QkON; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b4H0BG2U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6CBE33D73;
	Thu, 18 Apr 2024 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713451475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cw1t8XIR2RQyDe+YcTFQS2ljZBvtQVdJupc4oRiInnA=;
	b=Hz68QkONiOBqzcnvw76R/iJ7m2axqjILcIy4GO4cS8eqR04g0liwTjWJKLLI1E9y9iyMzh
	5HagWA2rQZc9x1rAYyPVYF0HZYruczT6IUNBwSfE9FPwQcdqZiznUQHtmMPRu9DuDWLCmx
	LmJsX6vTRNZTIy/TNdKld43pvZkPSWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713451475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cw1t8XIR2RQyDe+YcTFQS2ljZBvtQVdJupc4oRiInnA=;
	b=b4H0BG2U9tLrO965gywJIZhYZ6eScARZ+4wlIE93wijs3+ioFYB5l2YDJnx3lGx+lmAtOs
	D4Lq8hr8lZ6hUxBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713451475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cw1t8XIR2RQyDe+YcTFQS2ljZBvtQVdJupc4oRiInnA=;
	b=Hz68QkONiOBqzcnvw76R/iJ7m2axqjILcIy4GO4cS8eqR04g0liwTjWJKLLI1E9y9iyMzh
	5HagWA2rQZc9x1rAYyPVYF0HZYruczT6IUNBwSfE9FPwQcdqZiznUQHtmMPRu9DuDWLCmx
	LmJsX6vTRNZTIy/TNdKld43pvZkPSWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713451475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cw1t8XIR2RQyDe+YcTFQS2ljZBvtQVdJupc4oRiInnA=;
	b=b4H0BG2U9tLrO965gywJIZhYZ6eScARZ+4wlIE93wijs3+ioFYB5l2YDJnx3lGx+lmAtOs
	D4Lq8hr8lZ6hUxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C8E13687;
	Thu, 18 Apr 2024 14:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJcTO9IxIWaAKgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 18 Apr 2024 14:44:34 +0000
Message-ID: <9e15807be09695bbc35070b558e387237a00c988.camel@suse.de>
Subject: Re: CVE-2024-26827: i2c: qcom-geni: Correct I2C TRE sequence
From: Jean Delvare <jdelvare@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Apr 2024 16:44:33 +0200
In-Reply-To: <2024041842-handrail-distaste-259b@gregkh>
References: <2024041703-CVE-2024-26827-67c1@gregkh>
	 <a1f56653f2e2be923ed47f7e968230ca8a856553.camel@suse.de>
	 <2024041842-handrail-distaste-259b@gregkh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Thu, 2024-04-18 at 15:05 +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 18, 2024 at 02:56:33PM +0200, Jean Delvare wrote:
> > Hi Greg,
> > 
> > On Wed, 2024-04-17 at 11:44 +0200, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > i2c: qcom-geni: Correct I2C TRE sequence
> > > 
> > > For i2c read operation in GSI mode, we are getting timeout
> > > due to malformed TRE basically incorrect TRE sequence
> > > in gpi(drivers/dma/qcom/gpi.c) driver.
> > > (...)
> > 
> > I was assigned the task to backport this security fix to the SUSE
> > kernels. However, from the description, I fail to see how this fix
> > qualifies as a security fix. I can't find the reason why a CVE was
> > assigned to the issue.
> > 
> > What is the considered attack vector? Or if there is no attack vector,
> > what consequence does this bug have, which would put the system
> > security at stake?
> 
> We reviewed this commit as fitting the fact that timeouts due to
> malformed messages would fit into the definition of "vulnerability" in
> the CVE world as it would cause a system to incure "negative impact to
> confidentiality, integrity, or availability".

If the timeout could be triggered on purpose, then I would agree, as
this could possibly be used for a denial-of-service type of attack. But
this isn't the case here.

All we have is a failure to read data from a random I2C device due to
an incorrect programming of the I2C controller. Simple lack of
functionality.

> If as the i2c maintainer, you don't think this would be the case, we
> will be glad to revoke this CVE and just mark it down as a "normal
> bugfix".

Yes, please.


-- 
Jean Delvare
SUSE L3 Support

