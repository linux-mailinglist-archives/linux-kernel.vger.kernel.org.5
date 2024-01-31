Return-Path: <linux-kernel+bounces-46618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1B844210
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C8928F508
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878BB84A3C;
	Wed, 31 Jan 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SAmT8yb+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZjKJ/bg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SAmT8yb+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZjKJ/bg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DE8288F;
	Wed, 31 Jan 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712082; cv=none; b=M1c0MVykpO8+n25eatGa5JWMNdzNIpif6c2JsFhw4jv70JH7/wqepPSyyxyLyTuwZyO6U5eeGaGunSLwZVWRZf9BckpVVpnOZmg7lvdXVStD6moGz2niPlQ5VIfp71w5ew12Si7x6gyWpmE5mq2n0wJPyxeKfK1/YPprp8C4v0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712082; c=relaxed/simple;
	bh=xPx3iN0ojkqzszqkm3GWkgqST3pDNJKsrDziRfmPaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcoX161zua4Fr5gqMEae3k4BN7WYJQF3zefGeZEep/v8284E/1bLbHswbmkgAjUWIEkm4EroCyl4hpUeS0M6b4ffOmf76ACBPctiwmmQHtpoqA9muXx/xonNNXNDjy/nTh0fO3NnuCzM/EbofkL6elx6MmAvS//0ZiCpatitHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SAmT8yb+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZjKJ/bg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SAmT8yb+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZjKJ/bg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3538F22116;
	Wed, 31 Jan 2024 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706712079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2rR4EDjBpBp2ZRAgGsekZbOfQMmZZ+CtFOtPw+I9Hs=;
	b=SAmT8yb+lHkh4u8g0BtekBPMYmkF095hnQZ92L82jtJav7y8VICQ55rHUyy0ZeP/Pba36e
	h23ehyv/x9zZQ9E3JJ3t94TEmez7GmYVGQJCnOtWrN1ocW6A6FhaVehxiLIUlg0QK/XTP4
	4Ft/8ZKp8pPyO+i6wckCscwCSn2has4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706712079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2rR4EDjBpBp2ZRAgGsekZbOfQMmZZ+CtFOtPw+I9Hs=;
	b=XZjKJ/bgTeAXWAaw8D51ErxCh0bojBPEi5jO9kAIFAmuy4tbPBQIWoGrRL2cVoyqHiq0Q4
	6ZW9Buv6S0EyhzAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706712079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2rR4EDjBpBp2ZRAgGsekZbOfQMmZZ+CtFOtPw+I9Hs=;
	b=SAmT8yb+lHkh4u8g0BtekBPMYmkF095hnQZ92L82jtJav7y8VICQ55rHUyy0ZeP/Pba36e
	h23ehyv/x9zZQ9E3JJ3t94TEmez7GmYVGQJCnOtWrN1ocW6A6FhaVehxiLIUlg0QK/XTP4
	4Ft/8ZKp8pPyO+i6wckCscwCSn2has4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706712079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2rR4EDjBpBp2ZRAgGsekZbOfQMmZZ+CtFOtPw+I9Hs=;
	b=XZjKJ/bgTeAXWAaw8D51ErxCh0bojBPEi5jO9kAIFAmuy4tbPBQIWoGrRL2cVoyqHiq0Q4
	6ZW9Buv6S0EyhzAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 20BBC139D9;
	Wed, 31 Jan 2024 14:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id God9Bg9cumWDcQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 14:41:19 +0000
Date: Wed, 31 Jan 2024 15:41:18 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: Re: Re: [PATCH] scsi: lpfc: use unsigned type for num_sge
Message-ID: <seilf7ml5oymtl7etdblfj3obtah7b36ygjw5vvql46suksm53@mk3xrjiyq3v3>
References: <20231220162658.12392-1-dwagner@suse.de>
 <CAGx+d6cGuC8S2+_ipyKMtOxNQ5a0RW_H46jrwWJjwRx5TRw-ww@mail.gmail.com>
 <bhbx4emtgs4dxwryeorgq2igq3b2lu3k2ycdyn4ebwpbw4kxtp@aijstnvpilho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bhbx4emtgs4dxwryeorgq2igq3b2lu3k2ycdyn4ebwpbw4kxtp@aijstnvpilho>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.15
X-Spamd-Result: default: False [-2.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.988];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.36)[90.54%]
X-Spam-Flag: NO

On Wed, Jan 17, 2024 at 11:56:27AM +0100, Daniel Wagner wrote:
> Hi Dick,
> 
> On Fri, Dec 22, 2023 at 10:04:50AM -0800, Dick Kennedy wrote:
> > The change is good, however, I  don't think this was really the
> > problem.
> 
> I tried to write the commit message based on the bug report we got. So
> yes, it's possible the it is not correct as I was not really involved
> and might missinterpret it.

Any chance to get this moving forward?

