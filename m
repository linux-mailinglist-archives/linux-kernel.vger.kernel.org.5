Return-Path: <linux-kernel+bounces-81928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FBF867C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE67128E907
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C212C7F1;
	Mon, 26 Feb 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FoK8cc2d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5/ZXCHY5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MteP/CWz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YSPc2zIj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A046127B4D;
	Mon, 26 Feb 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965922; cv=none; b=Yd4rHA88I57+egCSEJr0Obb6tnIq9Rp61DHThH1MBahkl83+uYvXn3KwHrY8YpoCZr7zJ7nmOX8A2H7fIR1kj8fMS9Zbbp+ktTCZ8/718XvhTdogPMrFrYtYoPESTTK7C73I8IShNySx9iSBuQlcjlPt1GL5HJjuySC1xCxM1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965922; c=relaxed/simple;
	bh=htcnUineXKuRIijMZZzqAZpIfeDz5CJu5ZzPoiE2Ql0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Un2+ZaWcFqw99bfHaxurj/QltNilqiyhyB5hek9yPjUpM6Cu5KyI/TUBukG3CqmORKYAb2wJL9wOYe5D3r1BjtsxjPmnAZ/oNkcDMF3L1NyVOHVYoOdgH94kjxT3Hnm/XwXqMC268U1rrXMMIrEWwthWqvPNCNpufseq9gxOkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FoK8cc2d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5/ZXCHY5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MteP/CWz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YSPc2zIj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E490E225AF;
	Mon, 26 Feb 2024 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708965919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNKQOvX+alm4LCMtGGNsFDsIgNEjmJS+VHB4k1BcnoI=;
	b=FoK8cc2d/IpT93Anet6ZMgVmF0417NNt8kEwHcm8oR9msOJZjAsH0abIEf+b6Hi6yYnsgT
	0b7jSvdAvoKaxcdm4PhUFyPDDfunqMrKqjc9DmpjJCG1v8l3tE+DAf8iafAGutEPc9m5rf
	wL5cgfaBVgoStqphXUuG1JXhaEfj9q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708965919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNKQOvX+alm4LCMtGGNsFDsIgNEjmJS+VHB4k1BcnoI=;
	b=5/ZXCHY5e9+HWvqCTBBUuURJzTIrP5tHzUpUBcEy0uabtOxhTPUjXeX/uC8YnNKdIF5+IP
	X1FHWhuqlzrxSUCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708965918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNKQOvX+alm4LCMtGGNsFDsIgNEjmJS+VHB4k1BcnoI=;
	b=MteP/CWzWhn+dK0SaqUbv3rWE+O04xwyDiSMHgV1mF33vP1MPioucBzdaF8rq3EKJavEj4
	n81Alg6YGa6VdWOfWA2mjYG14MEWQ7FrHfqcar1ZvqWd5BGffFYXP6Dp2yp/irPNNJGfyt
	NiPemduGs6+mIj9h9s0Q3jVVHZrnjjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708965918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNKQOvX+alm4LCMtGGNsFDsIgNEjmJS+VHB4k1BcnoI=;
	b=YSPc2zIjtp7PO4Rtt9tam47ZoWA8VrgLgOl/mblznZcDxJ7YLNw1CjpA89ezIaRa8Ml/r/
	r4AFMyPi0nDKNlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D1EB13A58;
	Mon, 26 Feb 2024 16:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b4jJIR7A3GWrFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 16:45:18 +0000
Message-ID: <3b539d8d-e529-45b0-aa83-545248bc0670@suse.cz>
Date: Mon, 26 Feb 2024 17:45:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |
 __GFP_RETRY_MAYFAIL allocations
Content-Language: en-US
To: Sven van Ashbrook <svenva@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com,
 cujomalainey@chromium.org, kramasub@chromium.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-sound@vger.kernel.org, perex@perex.cz, stable@vger.kernel.org,
 tiwai@suse.com, tiwai@suse.de, Michal Hocko <mhocko@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>
References: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
 <20240221114357.13655-2-vbabka@suse.cz>
 <CAG-rBijH3GaHN2zA2_cby-RsQCVHou-WjZnxudMebPrS9imgfg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAG-rBijH3GaHN2zA2_cby-RsQCVHou-WjZnxudMebPrS9imgfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="MteP/CWz";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YSPc2zIj
X-Spamd-Result: default: False [-0.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.45)[78.91%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.75
X-Rspamd-Queue-Id: E490E225AF
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On 2/26/24 17:09, Sven van Ashbrook wrote:
> Vlastimil,
> 
> We noticed that this patch is now added to Andrew Morton's
> mm-hotfixes-unstable branch.
> 
> How can we help to get this into mm-hotfixes-stable
> and from there, into mainline ?

A Tested-by: can't hurt, but of course you need to finish the testing first.
It's encouraging you didn't hit the bug yet anymore, thought!

> We are still stress-testing using low memory suspend. Anything else
> that is required, and we can help with?

I think that's already great enough, thanks!

> Sven


