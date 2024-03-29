Return-Path: <linux-kernel+bounces-124284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76489150F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F0F2861AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2604545974;
	Fri, 29 Mar 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="mz+n4RAe"
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168D40842;
	Fri, 29 Mar 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711699848; cv=none; b=W76l//wUtL3lNKrsC1UxlL/h2DWBW/VM+nUYmYec0dtdUYexU99KxWkRn4PemZ3MpFhLx4Z1j657IbtneAM6KeuytTJKc+DBrhqfp0s+2X19UH44GtaS3xGqRdqSsyP1qeUJIkAxMoMEPsGu0nb/HnlyLgedni/OaoJUHXTfZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711699848; c=relaxed/simple;
	bh=Wjl3zr/BNN56wdS4u3nAMWSo+sSz1TXRs/Ujsp1d1sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmTVcMXUBTkPDySmt2oCCdiQ3RqmjoN2n9SR82SmnUBY7Gbstt6ielJaodlDvwe856hkBJ0BkegCKut5JcIobW7/KZZvtdqpTNVH+CExuTtRegmGygnVE4yx3FIsj7Piq7INgd6wWivWLgtNcCYiUQPV71j1iqKtPSbzgJu7xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=mz+n4RAe; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id BC5A621325;
	Fri, 29 Mar 2024 08:01:57 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 20CD4260DF;
	Fri, 29 Mar 2024 08:01:49 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 1AE483E981;
	Fri, 29 Mar 2024 08:01:41 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 4F7E04007F;
	Fri, 29 Mar 2024 08:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1711699300;
	bh=Wjl3zr/BNN56wdS4u3nAMWSo+sSz1TXRs/Ujsp1d1sI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mz+n4RAeOc8uqy9kkguomSw9juCsMtDrnaou59z+I05ogwu9A2wQWZjt8A7hMFvyp
	 cqeFPBHQL9BWQ+ftSOap1PBOmWuje7hfmLA8ZwQIkJnLTVItSZPQ2v5tE2Gnj6678c
	 Dmo2hWdfUr9Uyx0PY37EQGvR5Sew46/jhNiDqh7E=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 1961F42C88;
	Fri, 29 Mar 2024 08:01:33 +0000 (UTC)
Message-ID: <47302624-6466-41a7-85db-f6872d58a4d2@pavinjoseph.com>
Date: Fri, 29 Mar 2024 13:31:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only
 where full GB page should be mapped.
To: Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
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
Content-Language: en-US
From: Pavin Joseph <me@pavinjoseph.com>
In-Reply-To: <ZgZqhWoRZoq5tJoU@gmail.com>
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
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,infradead.org,linutronix.de,redhat.com,alien8.de,zytor.com,vger.kernel.org,lists.linux.dev,gmail.com,verge.net.au,xmission.com,dbc.dk,hpe.com,antgroup.com,linux-foundation.org,google.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4F7E04007F

On 3/29/24 12:45, Ingo Molnar wrote:
> Does the 'nogbpages' kernel command line option fail on these systems
> even outside of kexec (ie. regular boot), or only in combination with
> kexec?

Original reporter here, using nogbpages allows for normal bootup, but 
kexec fails with it on my two similar systems.

Pavin.

