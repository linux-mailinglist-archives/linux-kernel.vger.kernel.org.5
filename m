Return-Path: <linux-kernel+bounces-60272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C185027C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6591F2659C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18686121;
	Sat, 10 Feb 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="nf82ab/H"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AE569F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707536878; cv=none; b=LMnBYRETluW1WySj8EbOCJpLAKTMiNsH9UDNPzFQgNGgpXzBNxk4LCVoKj1BjlKhnWzwbJuwJTOUF9Fgln+aYYGLor6XIBsVvl0Pca6fo9+26r0xQEJbJd5oLblQw8oXGv6+jlS3RTGYMBHaoL77y2TvnLkDzeDE+sPdzmUQopY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707536878; c=relaxed/simple;
	bh=DJJEW7LwZJzt13k40aZ5YP9MC+QrfxIXMspjA9NlxBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZJQiX14H05s3Hs5jmRh2ZzhN5aWccuXEJiBVIWnQWRh19lZEuKC4/kNbBi8jQxbCWnFgwdnvmE6iV8CC0+TkRd+qTKWXeXf+PT/m3pDdWJUphFNrEL91NABVthWPvf3j8ShxHgXMtms8pV5PFfqkjPDk3YiKwdd3IU814I9NAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=nf82ab/H; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id YQAKrRDtNTHHuYeLGrbNak; Sat, 10 Feb 2024 03:47:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id YeLFr3N9L46LDYeLFrlayb; Sat, 10 Feb 2024 03:47:49 +0000
X-Authority-Analysis: v=2.4 cv=YrysRJYX c=1 sm=1 tr=0 ts=65c6f1e5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=MhnL__LWAAAA:8 a=pGLkceISAAAA:8 a=vaJtXVxTAAAA:8
 a=cm27Pg_UAAAA:8 a=VQoFvWr1TuYTowxckCsA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=DArMNfZabhNmbrQIurc0:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pXHTcn/aJQT+pG0+DyZQLt/S325fM/XgyAnSIueU0jM=; b=nf82ab/HT3PxDSv0uH1Gb9Us6r
	W/yF5yq6ZhVU0rMVz2IdnrH8brNxWaqoFxBwlhqahAlTgnUSvERMNF9GoOMtt3718KthqCKhJiQR/
	Yo7bmuQykAZu4OP0+c52dPFs4ub/7McLCM5nD0mausOhI9W/WpYxMsMQcm0Kiihclv0tLrWusfS+1
	ILsDuWZbTU3vV0jitx8azgQ06AAgxDsRE4JpsKEGG2tD+r40TfaW/wWj9fzARLm76YSeflHzCUW9i
	DIWI7xygoESAkNUYeOJbbtcknao2fIgHPv8OpOqTkGSXtBBR/5d3m2ZETHXndj5iJF2++FniTQ7RW
	yLP+MeaQ==;
Received: from [201.172.172.225] (port=48392 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rYeLD-0031L3-0e;
	Fri, 09 Feb 2024 21:47:47 -0600
Message-ID: <bb815cbf-c019-4328-9857-b53cba2dbdd4@embeddedor.com>
Date: Fri, 9 Feb 2024 21:47:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] stddef: Allow attributes to be used when creating
 flex arrays
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Dan Williams <dan.j.williams@intel.com>, Keith Packard <keithp@keithp.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Dmitry Antipov <dmantipov@yandex.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240210011452.work.985-kees@kernel.org>
 <20240210011643.1706285-1-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240210011643.1706285-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rYeLD-0031L3-0e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:48392
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEOQwX+HDxsqh/7LLweVWh6pblFoO7BoEgrOSgZvXxHYFkJNqw1pkiZcmW5X1kUBgNdFUKIYAu55Wktkspxmu6IjFCRqfuU3tEgfIqrGLdDBxW9jLVf+
 B3e3cr1MifNbdJhq+EEqUMSYQTxYUvbN99C6Wh0THTCOhoO132acFaBUHx24CWSDNleO4EuizEakzD6pRlGXv7gDn2JeJ0rMGUxd6pBrkl0IBwcSc50ehFoU



On 2/9/24 19:16, Kees Cook wrote:
> With the coming support for the __counted_by struct member attribute, we
> will need a way to add such annotations to the places where
> DECLARE_FLEX_ARRAY() is used. Introduce DECLARE_FLEX_ARRAY_ATTR() which
> takes a third argument: the attributes to apply to the flexible array.
> 
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Keith Packard <keithp@keithp.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Nice!

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/linux/stddef.h      | 16 ++++++++++++++--
>   include/uapi/linux/stddef.h | 25 +++++++++++++++++++------
>   2 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index 929d67710cc5..eb51f6727ecf 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -81,8 +81,20 @@ enum {
>   	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
>   
>   /**
> - * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> + * DECLARE_FLEX_ARRAY_ATTR() - Declare a flexible array usable in a union
> + * @TYPE: The type of each flexible array element
> + * @NAME: The name of the flexible array member
> + * @ATTRS: The list of member attributes to apply
>    *
> + * In order to have a flexible array member in a union or alone in a
> + * struct, it needs to be wrapped in an anonymous struct with at least 1
> + * named member, but that member can be empty.
> + */
> +#define DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS) \
> +	__DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)
> +
> +/**
> + * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
>    * @TYPE: The type of each flexible array element
>    * @NAME: The name of the flexible array member
>    *
> @@ -91,6 +103,6 @@ enum {
>    * named member, but that member can be empty.
>    */
>   #define DECLARE_FLEX_ARRAY(TYPE, NAME) \
> -	__DECLARE_FLEX_ARRAY(TYPE, NAME)
> +	DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, /* no attributes */)
>   
>   #endif
> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
> index 2ec6f35cda32..5499c08ad011 100644
> --- a/include/uapi/linux/stddef.h
> +++ b/include/uapi/linux/stddef.h
> @@ -31,24 +31,37 @@
>   
>   #ifdef __cplusplus
>   /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
> -#define __DECLARE_FLEX_ARRAY(T, member)	\
> -	T member[0]
> +#define __DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)	\
> +	TYPE NAME[0] ATTRS
> +#define __DECLARE_FLEX_ARRAY(TYPE, NAME)		\
> +	__DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, /* no attributes */)
>   #else
>   /**
> - * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> - *
> + * __DECLARE_FLEX_ARRAY_ATTR() - Declare a flexible array usable in a union
>    * @TYPE: The type of each flexible array element
>    * @NAME: The name of the flexible array member
> + * @ATTRS: The list of member attributes to apply
>    *
>    * In order to have a flexible array member in a union or alone in a
>    * struct, it needs to be wrapped in an anonymous struct with at least 1
>    * named member, but that member can be empty.
>    */
> -#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> +#define __DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)	\
>   	struct { \
>   		struct { } __empty_ ## NAME; \
> -		TYPE NAME[]; \
> +		TYPE NAME[] ATTRS; \
>   	}
> +/**
> + * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> + * @TYPE: The type of each flexible array element
> + * @NAME: The name of the flexible array member
> + *
> + * In order to have a flexible array member in a union or alone in a
> + * struct, it needs to be wrapped in an anonymous struct with at least 1
> + * named member, but that member can be empty.
> + */
> +#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> +	__DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, /* no attributes */)
>   #endif
>   
>   #ifndef __counted_by

