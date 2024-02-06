Return-Path: <linux-kernel+bounces-55326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CC684BB22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7171B268B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C6346AD;
	Tue,  6 Feb 2024 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="FYm38sxs"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D3D527
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237387; cv=none; b=u0wI7UyrlNPeFA84M3WfKeotn7GRsLzH6lfVlDLex5GsCFxDZHFosVxGHXNR3jiIkdfW5Q+5jIFvDl6mymGJaMhKBYYjVm3bW8f6vsHxKHycNToVpxVg6keQ+0h+mu2lm0ZagKyvQLeCcOoPaqF8QLE5Fopt8pOkF2DoXfDxETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237387; c=relaxed/simple;
	bh=mgZOgLB1HuathAGqKmjNnG/0xoJq5roM2WNaXcdTp9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLdO7ieWrwfNZvSwerh4vZYQ8dTv0oyyyFlyfkvv0U/Dh1qLulFuN/TU3TFuf19j/XWtxcsYG7ivvltqRwZgbmqhdAoL0IJggwasXs5lGFwEDSy3Fpv9DTYFDoPRFLqvhtyJt3XHTPtkuLjf9cRe14/XcbXQ9dzYyiQwiV8ZpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=FYm38sxs; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id XKpvrG1oK80oiXOQlrrgX7; Tue, 06 Feb 2024 16:36:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id XOQkruWp4OmWYXOQkrn8UU; Tue, 06 Feb 2024 16:36:18 +0000
X-Authority-Analysis: v=2.4 cv=T/MvTOKQ c=1 sm=1 tr=0 ts=65c26002
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=lXWNAtzADcZZgIjtGc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=8LfgHNaa6p4A:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ho3hrp7XcTsBErJhywPAagDi6Mkqk4q72L1K4GsdTRQ=; b=FYm38sxsIiXyEaRic6gNnCyQPN
	jieaLQ1ZUefC3lameJVtACCu3wIbgJUUS6oVj3kQ+T7XD7iHEv/92rQ1LXloUwkRIyVUn01oN42l/
	vgdZLOhtn8Z3YWHilM6+epHYQ4yIlsBW10IoRD7WoBBSIg5vnBL9M4hzpZF95UVj9cS5BaY6NeDWo
	G9ULvv2gM2B20XmTUxPloOo1w1kCxMo6qeQFDJWzZh2dUnXSNjVBAHJ6cGmfyVKwOMWVBJ+G7S9Rs
	bj4sTK5brhJDOxaaw5Gmx48u0cmt7mfa0mpI4FgzRnCyntjdpXjv2BuMT067jS/wH+j5/7tjQg4gS
	iOLAF0jg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36786 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rXOQj-003Ba7-1b;
	Tue, 06 Feb 2024 10:36:17 -0600
Message-ID: <89a743fb-37fa-40b9-8ce5-d118ae95af38@embeddedor.com>
Date: Tue, 6 Feb 2024 10:36:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] overflow: Adjust check_*_overflow() kern-doc to
 reflect results
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, Marco Elver <elver@google.com>,
 Eric Biggers <ebiggers@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20240206102354.make.081-kees@kernel.org>
 <20240206103201.2013060-1-keescook@chromium.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240206103201.2013060-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rXOQj-003Ba7-1b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36786
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBue6D50HEGO5CIPVHuIETEoeaAIr2DRy5TuyMNZwJwFgavRXvf6hwLfezPzMzHqubHEr+pmzVBNNfKBrUazMRD7gzPuO4ANs6QYOMrwzpYfmuKLhW1J
 1di6FgJbZy6xdIBcvN2IcohGxIz7R9E8pxeYnUrKtYVrEDArqQCQK8EmFksNj4/4LBsz64LtQuZHAQPo0/Ct3GpIR02SGBwFoODXjw6pv7MaV4iieFNyQFWL



On 2/6/24 04:31, Kees Cook wrote:
> The check_*_overflow() helpers will return results with potentially
> wrapped-around values. These values have always been checked by the
> selftests, so avoid the confusing language in the kern-doc. The idea of
> "safe for use" was relative to the expectation of whether or not the
> caller wants a wrapped value -- the calculation itself will always follow
> arithmetic wrapping rules.
> 
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Better to be concise and direct. 🙂

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   include/linux/overflow.h | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 7b5cf4a5cd19..4e741ebb8005 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>    * @b: second addend
>    * @d: pointer to store sum
>    *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.
>    *
> - * *@d holds the results of the attempted addition, but is not considered
> - * "safe for use" on a non-zero return value, which indicates that the
> - * sum has overflowed or been truncated.
> + * *@d holds the results of the attempted addition, which may wrap-around.
>    */
>   #define check_add_overflow(a, b, d)	\
>   	__must_check_overflow(__builtin_add_overflow(a, b, d))
> @@ -72,11 +70,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>    * @b: subtrahend; value to subtract from @a
>    * @d: pointer to store difference
>    *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.
>    *
> - * *@d holds the results of the attempted subtraction, but is not considered
> - * "safe for use" on a non-zero return value, which indicates that the
> - * difference has underflowed or been truncated.
> + * *@d holds the results of the attempted subtraction, which may wrap-around.
>    */
>   #define check_sub_overflow(a, b, d)	\
>   	__must_check_overflow(__builtin_sub_overflow(a, b, d))
> @@ -87,11 +83,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>    * @b: second factor
>    * @d: pointer to store product
>    *
> - * Returns 0 on success.
> + * Returns 0 on success, 1 on wrap-around.
>    *
> - * *@d holds the results of the attempted multiplication, but is not
> - * considered "safe for use" on a non-zero return value, which indicates
> - * that the product has overflowed or been truncated.
> + * *@d holds the results of the attempted multiplication, which may wrap-around.
>    */
>   #define check_mul_overflow(a, b, d)	\
>   	__must_check_overflow(__builtin_mul_overflow(a, b, d))

