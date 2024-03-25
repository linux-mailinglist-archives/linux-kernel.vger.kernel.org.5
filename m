Return-Path: <linux-kernel+bounces-117918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDF88B141
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA4C1F63912
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A04E446BF;
	Mon, 25 Mar 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="RnArgM16"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6943AB6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398269; cv=none; b=PDrBpyctPzcGV8KB4X/2yyEDmNZgG8tpzOdIGco2wHMvyl9GGrSjmALjWwI8aq7XbLIbfF2RNr2XbP1s+7Y4BYgK+7Jn7rRnWrA07XXetFHS6T+Qkf6uMEurTOB880CmILWxS6ATsRe5Gc/xTWeABDuzCULF2j5Z5Yn6dtmRmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398269; c=relaxed/simple;
	bh=5UvZesYNPtO8j4TA1VB/E8o3ikeheRrS++Ntn/kkQPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qL1/QLO4qJVWgVeb/Tqxa+FLQYMaT7SMJDXhPUgCxi3VJjsICo7navcFV6G0I3zSRz97EI5Bjx2fKBeWm1NBe/oD0sFdMtCF2zvz3ZIxDfOSJddSPnfuzSX9BzP/iB+73Cw2d8Ws7Xp4S40oT59Xs3EMbIoKGP1FkRHCdeipQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=RnArgM16; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711398255; x=1712003055; i=deller@gmx.de;
	bh=5UvZesYNPtO8j4TA1VB/E8o3ikeheRrS++Ntn/kkQPY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RnArgM16PiiBbBbzyt7R3q3NCppMseBh/HMZpezEby0W1AoaeWug7tL9hE6MruJ+
	 gubXnRCEb/O8OdP3bAoJt9Af440CWCb69HnPLI3DWhX5RwA4fmxh+lzkzTcT/Ah0c
	 tFyMRMsOA7Rs0ScY6qq9CBzu1Za0SDigqTcbZistA78ZFhlhD28VF2EpfmlWxaB79
	 m9eSAmTWQFayjJNgsWVP6kCa3SaFbtU8TW/bDW2xX4fmj1ZU1TK7cL4HkbJ2k4nP3
	 yy06O51bkdVxl5dQ4nJVKezs+T+KzSi4AVL4MyeM83pd5Jy5jgOoWsD9WQg4VYU88
	 FhQEgAKiKDpiExKVTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.8]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1rsxTC2ukT-004jgW; Mon, 25
 Mar 2024 21:24:15 +0100
Message-ID: <5dc6860f-df05-457c-8b78-067f276e423b@gmx.de>
Date: Mon, 25 Mar 2024 21:24:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] mm/mmap: convert all mas except mas_detach to
 vma iterator
To: Andrew Morton <akpm@linux-foundation.org>,
 Yajun Deng <yajun.deng@linux.dev>
Cc: Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240325063258.1437618-1-yajun.deng@linux.dev>
 <20240325115308.f6344233a27f1633f642f888@linux-foundation.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240325115308.f6344233a27f1633f642f888@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2dyUoT4jKQN3PZtllaO1MqSu7iYYkIgJObdoa4Mq3iuBeUJcJ6X
 Ocb0dyWEjFAdCu9XP2ccDLcC9J0IJ/N7voy9FgjcDHlYNiLxNbh0msiTy8WVNx1wMlNgiLD
 DO9yj9pQcFF5g4R6rc1buc6o9i5JYRbsSOg0SKv+9Nx51NqRs5PJh6FQMifw+7Usm04acXH
 8l1ZNDwa4AhxNeMybOWtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DD7G8scvDRs=;r4Aj8u9nyPfbKgJLt/OErZXZJjA
 ul1klK/aWiqINY0cUPnjqDGsirwg6DK71OySTwLZzOOrxhq5cdoS5N8WbFGmAo3P+YRpvdXl+
 0qZAOwJThqOUZNjLXHJS0CNcHZDR1utByIYfxZ51XOUXb1qh9VMaaXSZC/y1f7RUX/1Qyq7px
 ALd+FQqIiR93cFStxC4zPdcf4h0+CsEWz6OIsBcBXknjRBsoN+TWTZne2CuxVRu7Og025qB4Q
 lN3MtvDGOwNR43i0MBqG5tvM+IVEkIV17jopwFiD3ofghyNFHFza7C4nZpjj8aGXOWC8KiYZh
 e8Go8nMim0G5CLx0VeUsQLcdK5XFip9wGeeGogPeS4o2PTrWqnUHFh2Kcyt6kzzCcZJJNztCG
 XOG7Lvl9mMgw6dx1LKUUdPa3lUpAk2/CxKE1tJKFUpdJvXha7WxyBdcE2GErqShcv9/rJge5E
 fn+EBgFVXcx+eSvY32jUZ+dD3veMi4rx5kgmMz6CSLcHX7FczYL3GE0bEsEEhd8fGPSQUj6pG
 X7Cg+By6njP52Tir1l4bnYWvBnoldXpXrijd46lctLTc/rtovbDIfEy+damLON0wBqCNds/KP
 2qloOOx+nYs8xY2Uk8de+4WiE9O54EEa/2fi8eg/5oGKhgO6vFDv01E48SUMChEgC0WTy5q3Y
 4AZl1oC/CLbm1EI6OWaeeRQtEE9noCtWaECGLD5ci/+YNhFvjyxmlR2UA1r+661YbxFvaKuOA
 d0BMtbwZkWV3ciR2br/qviBKIMGxWKwIpLAmX4l2i60higsuUvSsxrASxuApQtGT4c2VptNUR
 90Y8YT3v+n+pjSv28RWEuDyD7XbgAmXh1OTEoxcm6skC8=

On 3/25/24 19:53, Andrew Morton wrote:
> On Mon, 25 Mar 2024 14:32:58 +0800 Yajun Deng <yajun.deng@linux.dev> wro=
te:
>
>> There are two types of iterators mas and vmi in the current code. If th=
e
>> maple tree comes from the mm structure, we can use the vma iterator. Av=
oid
>> using mas directly as possible.
>>
>> Keep using mas for the mt_detach tree, since it doesn't come from the m=
m
>> structure.
>>
>> Remove as many uses of mas as possible, but we will still have a few th=
at
>> must be passed through in unmap_vmas() and free_pgtables().
>>
>> Also introduce vma_iter_reset, vma_iter_{prev, next}_range_limit and
>> vma_iter_area_{lowest, highest} helper functions for using the vma
>> interator.
>>
>
> I assume Liam's earlier request still applies?
>
> : Helge,
> :
> : Yajun has changed code that affects parisc with this patch, which hasn=
't
> : been tested.
> : ...
> : Can you make sure that the expand_upwards() still functions on parisc?

Oh, I didn't noticed that request earlier.
Anyway, I now tested this patch on top of 6.9-rc1, and the kernel still
boots up nicely on parisc and as such expand_upwards() seem to work as bef=
ore.
So, you may add:

Tested-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge

