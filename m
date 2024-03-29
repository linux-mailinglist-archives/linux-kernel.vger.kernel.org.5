Return-Path: <linux-kernel+bounces-124300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D0891548
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD98287996
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE5381C9;
	Fri, 29 Mar 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="GN6A20EK"
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F32C18E;
	Fri, 29 Mar 2024 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711702587; cv=none; b=rPCpFVWXCDtoWLSMsncVGSTraO7rz6ET2kGRbKLndJGoAi3XiA6Z1DMGZqOkK8lP893O8kZP2AgxPtO4NNB2mxk9mrUh9TcwzgLH/aIFiz6+b7+k+kv69wAn5u07bnllyRkuPzKh6dS80iyE5ILjdE3EyVFFc6O4BX8ryahiTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711702587; c=relaxed/simple;
	bh=BhxWWD1/6hpzW0ZuCB47ZyZpGCd1UhWx6YWmIPxtGBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVs/kv4rs185rjp/t4GFEubJngwMFrKFlgzVK9CLWs730IZSatCvYpOvyeo/8OW7yS7z0x7rjXmvHwDiFSPEnSSmhg2bGDTh3UuXoT4NB1Hys55G3qLhzJ1cIvGEhHKgzzR7dlaxWar+QBAVvEq5xW7Rf58rOfKbdtWqy4aHuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=GN6A20EK; arc=none smtp.client-ip=159.100.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id B23F3260DF;
	Fri, 29 Mar 2024 08:56:23 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id E9E573E870;
	Fri, 29 Mar 2024 09:56:15 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id AC4664007F;
	Fri, 29 Mar 2024 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1711702575;
	bh=BhxWWD1/6hpzW0ZuCB47ZyZpGCd1UhWx6YWmIPxtGBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GN6A20EKSr0i3BIX2IzE0nB/Ew0aNAsUezWnAnuNzPOQ2Dqrr204U/GDkPhfvm/cq
	 1xAHVVZhFbAcwaLCQjBMgmf/PSiUr3BWQb6oxveH91T5TByQ4drEsgKp0m3/taOlwd
	 PNH61X+daeSDKLdoqbibhvhlgu0VuXurPiKcnFws=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0931040FCD;
	Fri, 29 Mar 2024 08:56:09 +0000 (UTC)
Message-ID: <be5982f8-3928-455e-969c-1e4c419d80a2@pavinjoseph.com>
Date: Fri, 29 Mar 2024 14:26:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only
 where full GB page should be mapped.
To: Ingo Molnar <mingo@kernel.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org, Eric Hagberg <ehagberg@gmail.com>,
 Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
 Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
 Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20240328160614.1838496-1-steve.wahl@hpe.com>
 <ZgZqhWoRZoq5tJoU@gmail.com>
 <47302624-6466-41a7-85db-f6872d58a4d2@pavinjoseph.com>
 <ZgZ4qlbncvxhboQ0@gmail.com>
Content-Language: en-US
From: Pavin Joseph <me@pavinjoseph.com>
In-Reply-To: <ZgZ4qlbncvxhboQ0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[hpe.com,linux.intel.com,kernel.org,infradead.org,linutronix.de,redhat.com,alien8.de,zytor.com,vger.kernel.org,lists.linux.dev,gmail.com,verge.net.au,xmission.com,dbc.dk,antgroup.com,linux-foundation.org,google.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AC4664007F

On 3/29/24 13:45, Ingo Molnar wrote:
> Just to clarify, we have the following 3 upstream (and soon to be upstream) versions:
> 
>   v1: pre-d794734c9bbf kernels
>   v2: d794734c9bbf x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
>   v3: c567f2948f57 Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."
> 
> Where v1 and v3 ought to be the same in behavior.
> 
> So how does the failure matrix look like on your systems? Is my
> understanding accurate:
> 
> 
>             regular boot  | regular kexec | nogbpages boot | nogbpages kexec boot
>   ------------------------|---------------------------------------------------
>   v1:       OK            | OK            | OK             | FAIL
>   v2:       OK            | FAIL          | FAIL           | FAIL

Slight correction:

    regular boot  | regular kexec | nogbpages boot | nogbpages kexec boot
-----------------|---------------|----------------|------------------
v1:       OK     | OK            | OK             | FAIL
v2:       OK     | FAIL          | OK             | FAIL

Pavin.

