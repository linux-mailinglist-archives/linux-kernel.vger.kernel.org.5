Return-Path: <linux-kernel+bounces-41383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F4A83EFDA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0AC284E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A312E645;
	Sat, 27 Jan 2024 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dwg4EtIm"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40162E62E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706385189; cv=none; b=BiO8UJrWf3TahTyO+GNqOOLBKvX0MmaU1te/KzPgE+Pd9K/ogz+eCX07BIWJYC8VFL5EcXP49iK7o+Y9LkRcerPmHQlXVNyYbveDRIsaMpQOb/lyWZSJ78O2vhgghZx02vlLzLb4O2HVGplLKBmdH4xbrufcMVvUv1ySUrLQf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706385189; c=relaxed/simple;
	bh=FZmVXFIdapL7iu8nX4400qTZyydoADV9EaSrJyaqFfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSBYXaoMmF1xLdlTD5+qHflC0m+IkxhSEHjU4QXQyKtiUgPLj3tbHpZcTccA8PDIjEtHYYepi+NFxCfhfczh97kl20RcF1HX5RwYXm4TkApA2FQZyFlhwKBTufcX2ozmzl4OrjqsMY1pdcMRWI4gv626QVhhKPZSf5TGlyqU6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dwg4EtIm; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id TiO6rApIwMVQiTojhrXuHW; Sat, 27 Jan 2024 19:53:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id TojgrNmjcZKctTojhrmI09; Sat, 27 Jan 2024 19:53:05 +0000
X-Authority-Analysis: v=2.4 cv=a+kjSGeF c=1 sm=1 tr=0 ts=65b55f21
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=P8i5SpKGxzEw1qT2wqIA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UvcAktpMm8n8yFtE4REBgJw4NqtWj+ffqzp2qlJjMOk=; b=dwg4EtImrINVyEC5ecBDCGzcHH
	7KCOgo/sxT2xCao0cEZ5/Ifd0abNu+vvHDWXTp1EMSxNcJd7q0LoysTtJhvZqKWMJnplmr+iYykbC
	t8fYtJ17TjSdHKmC/Yz/FX6B9vV7aoJMESVvCfPzwF1fWfZLuNqRsdts4TxRfPoNA6NACEwGQaXnK
	xfuObyWFatqjiliDF3VG99+DvBVDo+Tp7bSeazW7pGfFL7pGp6Hdmcf26ZuMx3UJZ5sBXSULo7eLj
	Ft9CMYbYK4Om97s58eLa2IQq5DyfLQdR64whNUSnJ+IcJHfyL06RSotRf6UHLljAy/xg0KFiOmT8H
	tn07v0JA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:55292 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rToje-000TwO-2q;
	Sat, 27 Jan 2024 13:53:02 -0600
Message-ID: <0c4cc1a7-f409-4597-b110-81f9e45d1ffe@embeddedor.com>
Date: Sat, 27 Jan 2024 13:53:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 intel-xe@lists.freedesktop.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <Za6JwRpknVIlfhPF@work>
 <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
 <4907a7a3-8533-480a-bc3c-488573e18e66@embeddedor.com>
 <202401261423.7AF702239@keescook>
 <CAHk-=wiaaCatzmF6GXxP97pa8oEX7e4rBpd4JgsbKex3Ek1_9A@mail.gmail.com>
 <f00e15fcba05497a87e91182a33c888f@AcuMS.aculab.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <f00e15fcba05497a87e91182a33c888f@AcuMS.aculab.com>
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
X-Exim-ID: 1rToje-000TwO-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:55292
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHk1/dWk2SsY/KLwQFK4i5eDugQNw1D/nXeLo+cIwWjiZru6aHgGxRjCSpQphehbtpvmpollKCGUJyHzAjj8PBzdfbaUQminspsHZ9Xu7tPZNMo77VcA
 BN3VvMpiptRAQcHOWISGx/n6jiS0brIRZVIcmEvKEqj57xyCgJHhyHoJXeKb+i2ToDQqDS89qk5+bz32zDf2ZvzpGZ61NHhm4lAV0Syuw1qz64zcd65yWA/g



On 1/27/24 09:11, David Laight wrote:
> From: Linus Torvalds
>> Sent: 26 January 2024 22:36
>>
>> On Fri, 26 Jan 2024 at 14:24, Kees Cook <keescook@chromium.org> wrote:
>>>
>>> I think xe has some other weird problems too. This may be related (under
>>> allocating):
>>>
>>> ../drivers/gpu/drm/xe/xe_vm.c: In function 'xe_vma_create':
>>> ../drivers/gpu/drm/xe/xe_vm.c:806:21: warning: allocation of insufficient size '224' for type
>> 'struct xe_vma' with size '368' [-Walloc-size]
>>>    806 |                 vma = kzalloc(sizeof(*vma) - sizeof(struct xe_userptr),
>>>        |                     ^
>>
>> That code is indeed odd, but there's a comment in the xe_vma definition
>>
>>          /**
>>           * @userptr: user pointer state, only allocated for VMAs that are
>>           * user pointers
>>           */
>>          struct xe_userptr userptr;
>>
>> although I agree that it should probably simply be made a final
>> variably-sized array instead (and then you make that array size be
>> 0/1).
> 
> That entire code is odd.
> It isn't obvious that the flag values that cause the short allocate
> are the same ones that control whether the extra data is accessed.
> 
> Never mind the oddities with the 'flags |= ' assignments int the
> 'remap next' path.
> 
> Anyone know how many of these actually get allocated (and their
> lifetimes)?
> How much difference would it make to allocate 368 (maybe 384?)
> bytes instead of 224 (likely 256).

[CC+ xen list and maintainers]

Probably the xen maintainer can help us out here.

--
Gustavo

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

