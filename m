Return-Path: <linux-kernel+bounces-91052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3768708FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2AC8B24B11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB9D61687;
	Mon,  4 Mar 2024 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="bLApyCSk"
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E061756D;
	Mon,  4 Mar 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575411; cv=none; b=pG0TEdMXHk7iMKFWF33RSaKWAooCQKyHxHM9WFTkKbUBmp1T/L+x1UKBHuV49stgCxHMXcXCkymn+Q7CTdoHd0S/FMmRV+cND3RzsRlHKSbavzrF5BzRIHTykCinZkWWtAil3qg9s93Yp0bIKkrtOHk4TybmAAdLFHwjJRsbDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575411; c=relaxed/simple;
	bh=0uJGpOI+Rh64wRVIQbrKMA5KI3BR1426JYHXEJX/tu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHp1C+8KMJS/MgMbGs6lH4RT0pg6pBQuMPncAtJeg3CtiTutwjQwdeKsZ2aQfvlN38NFiihGmO8e75kAM3MUA0U4lzfDJoAPukUSokSSTUX+BkDp0yEnpv8NxA/hMWuhfHqLi2BJSEhp3S+WqfiByukqPWHYLVq8lbfIcVjosoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=bLApyCSk; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 3332D2615A;
	Mon,  4 Mar 2024 18:03:27 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 43D7A3E989;
	Mon,  4 Mar 2024 19:03:19 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 19E0E4007F;
	Mon,  4 Mar 2024 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1709575398;
	bh=0uJGpOI+Rh64wRVIQbrKMA5KI3BR1426JYHXEJX/tu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bLApyCSksVMMr8pDE+OTY1DI9HM0Bb5lp9O1Dchw4popfy8F116nLrhJeIslnEYla
	 rehUDk16kxgvnEK7y1PrINwdXpLGVMF2tnFwsnB6Ku4TDjCeMv+Y7RF0YBQi65lm8F
	 K/QR0YRlpEwl2jORX2c9JcMHk0tXrnVyBDNBQ1Fc=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2E0694047D;
	Mon,  4 Mar 2024 18:03:15 +0000 (UTC)
Message-ID: <5a4e412e-e797-4db6-908e-09cb1e5f5623@pavinjoseph.com>
Date: Mon, 4 Mar 2024 23:33:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: guide on bisecting (was Re: [REGRESSION] kexec does firmware
 reboot in kernel v6.7.6)
Content-Language: en-US
To: Thorsten Leemhuis <linux@leemhuis.info>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
 <4630483e-fc4e-448d-8fd6-916d3422784e@leemhuis.info>
 <66019e35-5adb-4817-a64d-e379b6f4240a@pavinjoseph.com>
 <e1d87d5c-97ee-4e08-84c9-61a02c81ca63@leemhuis.info>
From: Pavin Joseph <me@pavinjoseph.com>
In-Reply-To: <e1d87d5c-97ee-4e08-84c9-61a02c81ca63@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 19E0E4007F

On 3/4/24 11:46, Thorsten Leemhuis wrote:
> I'm not really familiar with openSUSE, but it set up a TW container and
> found that a package kernel-install-tools provides installkernel script.
> Not sure how good it works though. Could you maybe test that?

Yep, that package got me "installkernel" and it does all the 
installation as expected. I only needed to change the symlink of 
"/boot/<initrd|vmlinuz>" to point to the new ones created by it.

> kernel-install is normally meant to copy the image over to /boot/ as
> well afaik; maybe it did not do that in your case because you already
> had placed it there manually?

kernel-install doesn't do that in my testing, it also doesn't remove 
anything AFAICT. 🧐

Kind regards,
Pavin Joseph.

