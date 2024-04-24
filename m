Return-Path: <linux-kernel+bounces-157727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0646F8B151A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384271C23ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F915699D;
	Wed, 24 Apr 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GB1Wtd+S"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FE13B5A6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993293; cv=none; b=XsSIcq1FnJ1Y4tSiMBNN7bmsymej0iaaxIyB67F/gnniGUr98dSNsRMcDRNYMmT0j8aeXgDPf+bnxfQCMfBsg/L2KmId9wpPXVtjtN08P25LyYiTEOxS1gOnbBfSpxZ2foRF7q8oqqY6PYDOMApjDnd2NhrYX+plXbstdXK1N3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993293; c=relaxed/simple;
	bh=KDCgzX8PuNdDonI7B+kY/j04lD6INpnGa2ZP8LqTlPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8n4MWwDWO9MXdJziYsh4VbQx3H55A2vIXbk8FDG6y/dYUOvHQo48c2d6vmXufS8LU2uoNJmNfy4x09T6h2QdvJJK+vIu3DLhMPhMiy72eK8PioVo6OHO7d2KaB8CGam5OBta9cpXNnghUCgZ5q8graVpYtzthdH0Ax8s/WMlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=GB1Wtd+S; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id zd2HrrnHgtf2Qzjwzrjf8L; Wed, 24 Apr 2024 21:14:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id zjwyrgTNXmuKFzjwyr7cKo; Wed, 24 Apr 2024 21:14:44 +0000
X-Authority-Analysis: v=2.4 cv=NKjT+V6g c=1 sm=1 tr=0 ts=66297644
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=4RBUngkUAAAA:8
 a=PoZ_YbeHmJNqDTfelxsA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22 a=_sbA2Q-Kp09kWB8D3iXc:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v6t9WtKr0oqpAwD8IZNlyuQgZFWtk9VNjNeyiMuDK0k=; b=GB1Wtd+SDmSyClls+39XY35jxu
	T940MKvtR07Z1EFguPbVVy3neAhrHeBWCkDOerHlBSbMIz54TvjWG3Xr3YWl7ZEBZjHqjGA2oVhid
	l9LKOPjdh57tBqsTizxkghyMD3+dh7fRVb64yi1kZrSzB7RIwtlrGGfs/mdyaiLe4rsS+5zw/VRFt
	72sPUQyh6EBs4XG3/JGlwipVEslU6qQSNzbzCLxMl5BGOcID1O29DmcBPqe0VnB9m3Sd4qeJqSJ3h
	dHGQRrH/gNqhmbMN4nqk0kV/E1QBKbnEpGN18W/4F72h6rbfmbJRQBJJT2htqfbzMS6+tl1C4TDHG
	Tip4rybw==;
Received: from [201.172.173.147] (port=34770 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rzjwx-0031vA-23;
	Wed, 24 Apr 2024 16:14:43 -0500
Message-ID: <cfd32c82-8909-48f7-ba5c-22c08b5eb53a@embeddedor.com>
Date: Wed, 24 Apr 2024 15:14:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ubsan: Remove 1-element array usage in debug reporting
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org
References: <20240424162739.work.492-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240424162739.work.492-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rzjwx-0031vA-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.173.147]:34770
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKpJOXEP13NQgqwBxHVscd1rAh/nHHSR9dB4LED9zgrIlY+7wmaipZgjUdxjt940iULRDrpt6vV8q/T/KYIcZzHbcUsbXSfuxNsetRthxrwmeNc96YXO
 mepvf2i/I1SBz1WAu5px7wMRGZRKgfPu3YPhfaEcqgOP5iB2G1Udq/O8o1wgAnTAxuwHeKwTWyT/Z/OicQK3sTZgGrAZu/n+M/2s7cCepBDkXz4pT+nOIvNO



On 24/04/24 10:27, Kees Cook wrote:
> The "type_name" character array was still marked as a 1-element array.
> While we don't validate strings used in format arguments yet, let's fix
> this before it causes trouble some future day.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>   lib/ubsan.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 0abbbac8700d..50ef50811b7c 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -43,7 +43,7 @@ enum {
>   struct type_descriptor {
>   	u16 type_kind;
>   	u16 type_info;
> -	char type_name[1];
> +	char type_name[];
>   };
>   
>   struct source_location {

