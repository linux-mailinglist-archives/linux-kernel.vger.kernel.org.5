Return-Path: <linux-kernel+bounces-40674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F083E3EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4A5B21BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1A24A09;
	Fri, 26 Jan 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Uph02T/k"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C4249F9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304637; cv=none; b=mSUfbvR1DR1+4l/ERgU8VifEG07aLD2t5ZDp+jHPwz0++gHdZ/aIPA4PodC3AuOxX7+B11eG/q/NxR/gd8uY3IUphXcvfnyDxgPRsDWqK6gbPlY7I9wHZufXu7/+St71vBVHgm7npkePZaBKdO5zFuO/u7nX5P/rYOsi3piipM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304637; c=relaxed/simple;
	bh=fnFSbqC73BjDiRJQDKm25AQEt8LU69o6DM+yCe6wRZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrp7sZET/XRNZyfZNop44iW81bNDpBvl9Iob1eujCFpXS6jKB+Le3ddQ65APJblUtL6cuiC/EzRrsSsO6V0KP+M7W4HmF7PyebW6mBwc0QBjT+rvEw9pMHEjDECBdvuZfwtpotCN6gj0oiZbWvd+y/F4OlkU4w4c0U/gyDItUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Uph02T/k; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id TOrvrueHyCF6GTTmPr3mHg; Fri, 26 Jan 2024 21:30:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id TTmOrrnpCL3AmTTmOr8Y0p; Fri, 26 Jan 2024 21:30:29 +0000
X-Authority-Analysis: v=2.4 cv=Sdrky9du c=1 sm=1 tr=0 ts=65b42475
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=Gc1-N3_vkRdohSFN-fAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gtdu07UB76ceLZHCruNCNqNVA0XFxMCp0HAaC2jM0KY=; b=Uph02T/kShK7aMSLjSTStLHeXR
	R4KR68vHbu7KdyJ+qr9MKZ9UZWUaB39jPFkO4XzFZUIvKcMQNmG5zwUy6SrXT//vjZ3skiaoMwFpJ
	ikRshOEPOALsroWwcuh3Z27p8V1rWpB455/CMP6u8lXPEBwryLy9LHey4h8mfU8P3IbuheahCTUMD
	le08p352EdkOiFbdS8wdkl+ezhqZ8E1c46am1dScJQm4TQj5DqdAUL9cjNG0CpoO7KIB2c4qTZGvc
	sy6QrLxIG00c7KvweUDexF3eb+FFrJLvJ8xnbLYyI8pJgRKus/Jw7IFSiepB/SXG0CQAeFGPH7DJP
	WbXiuA4g==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48192 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rTTmO-003Zp9-0G;
	Fri, 26 Jan 2024 15:30:28 -0600
Message-ID: <4907a7a3-8533-480a-bc3c-488573e18e66@embeddedor.com>
Date: Fri, 26 Jan 2024 15:30:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Za6JwRpknVIlfhPF@work>
 <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rTTmO-003Zp9-0G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48192
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLtwuml11NBETn947nwXZao9LHA5B9a2kKz2Qit3YazpNaF2VCBqkjVdv5bozT+0STAtAfrVVu1CywrWadkpteLynsAXXD/nR0PRPpomP/dk4bGyJmMr
 4MYCeIs4KDsW/pvJMAhBPEId5DiZFsLsiuUfNOTHxY5Y81QwEwj8aMc7ERR7D1IofPfk9PmzQKs5S9J295Ija7xDKFyhYH+VdDwRpu/cL7Vmciz4ZGbdidR4



On 1/26/24 15:22, Linus Torvalds wrote:
> On Mon, 22 Jan 2024 at 07:29, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>>
>> Enable -Wstringop-overflow globally
> 
> I suspect I'll have to revert this.
> 
> On arm64, I get a "writing 16 bytes into a region of size 0" in the Xe driver
> 
>     drivers/gpu/drm/xe/xe_gt_pagefault.c:340
> 
> but I haven't looked into it much yet.
> 
> It's not some gcc-11 issue, though, this is with gcc version 13.2.1
> 
> It looks like the kernel test robot reported this too (for s390), at
> 
>      https://lore.kernel.org/all/202401161031.hjGJHMiJ-lkp@intel.com/T/
> 
> and in that case it was gcc-13.2.0.
> 
> So I don't think the issue is about gcc-11 at all, but about other
> random details.

Let me take a look.

--
Gustavo

