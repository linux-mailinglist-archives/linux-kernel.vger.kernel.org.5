Return-Path: <linux-kernel+bounces-20947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750F98287B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE68285B21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E7839AE5;
	Tue,  9 Jan 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kPi6NH8C"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636C39AC5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id NAm4rdC8xTHHuNCiOrjYvt; Tue, 09 Jan 2024 14:04:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id NCiNrik5hD6lhNCiNrwfz2; Tue, 09 Jan 2024 14:04:23 +0000
X-Authority-Analysis: v=2.4 cv=LNR1/ba9 c=1 sm=1 tr=0 ts=659d5267
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GfQleyYEO+cc22AUyTT7qQ==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=mDV3o1hIAAAA:8 a=Twlkf-z8AAAA:8 a=NEAV23lmAAAA:8
 a=1aWQwmh1cChWapziH08A:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22 a=_FVE-zBwftR9WsbkzFJk:22 a=-74SuR6ZdpOK_LpdRCUo:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uvdyQdGzfT0A8h+hoTqs6rlhElqEBmHJSqddMJ5qdek=; b=kPi6NH8CRvPxouEWeClMnHA7jf
	/LRlRLQu4hrPNkXUermY1YK7HfZ6O9ejSDLZyoBh4JGH/EKRKAg118auyA8mbZ1Rv7tZDbtpv3Yfu
	v02r+md2I1q450BfoN6bdmQLG9IS75blkmyaITNg2E6Mh7kJ1V/dLuqe240Xwg+ADzb/UkRXPWkc6
	41cIy0afe9Ru8NZc8tsWQ+ZH1SV4U4W3xpWsXDkUUg1p/BVXhuTmVR48yy9c4kR06QfFZNVtzvUHK
	MAjePADpKn/camno87g9HLHHMH9R0zyB4Qo5dt6vOlSu+JQQfFtNIUbI06uT5SAFWwqs9nt4IOLKZ
	69r8zn9A==;
Received: from 187.184.157.186.cable.dyn.cableonline.com.mx ([187.184.157.186]:58081 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rNCiM-0004lh-1x;
	Tue, 09 Jan 2024 08:04:22 -0600
Message-ID: <374bf411-9f51-4326-adb3-ca384ded1e4a@embeddedor.com>
Date: Tue, 9 Jan 2024 08:04:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Compiler Attributes: counted_by: bump compiler versions
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Miguel Ojeda <ojeda@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240109133633.1103876-1-senozhatsky@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240109133633.1103876-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.186
X-Source-L: No
X-Exim-ID: 1rNCiM-0004lh-1x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.157.186]:58081
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFUTr32L11+bYSq6rumseHnTf+acT3G5jFrva7As+SZrmG9KQxYYLZNCCqoSLjyqRNA3tLfuEkH/ph17IVgH7g8+pTIytMLoVlYqU3GD9tutD8P3qo49
 v/BbhxbFsGPEJ+cIXtlUIXNw/SjxdeX9/Vjgp4YnMoaQq2Ak9z/gUIqC+KZpylLeazy/gXuSp6LoOAupNz45tKL021T80dyBWOIUHiylB4lBSDw6/ontCfFc



On 1/9/24 07:36, Sergey Senozhatsky wrote:
> Bump compiler versions, as GCC is expected to implement it
> in version 15 and current clang-18 still has no support for
> counted_by(). Also fix clang URL - the project has moved
> to github.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   include/linux/compiler_attributes.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 28566624f008..1829c24c3357 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -95,11 +95,11 @@
>   #endif
>   
>   /*
> - * Optional: only supported since gcc >= 14
> - * Optional: only supported since clang >= 18
> + * Optional: only supported since gcc >= 15
> + * Optional: only supported since clang >= 19
>    *
>    *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> - * clang: https://reviews.llvm.org/D148381
> + * clang: https://github.com/llvm/llvm-project/pull/76348
>    */
>   #if __has_attribute(__counted_by__)
>   # define __counted_by(member)		__attribute__((__counted_by__(member)))

