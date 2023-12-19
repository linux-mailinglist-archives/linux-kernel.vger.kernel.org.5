Return-Path: <linux-kernel+bounces-4682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73844818091
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B123EB215E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66D85C98;
	Tue, 19 Dec 2023 04:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqvhVnMO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED277468;
	Tue, 19 Dec 2023 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Yl1i0HhmIul/to3qVQu3Rd551a5SvQG/1lxtOIMQiUE=; b=vqvhVnMOOUf3joM0ZR+ZT2MS1A
	qlkJDZeIm7DU+VxeZLWtMEfXS7Uiw3tpmSYAneXMjp2zf3HTqHUBCvX/tLwqiMDkEbO0rmrKS8BXn
	5TqFZkJ6VBQshh3hiSZ6RyKVhpwHundEoIKD9dExkqummhZMHCT2rliXpa+9394Gj1D9SrKwFbuks
	tSXctmLqR/m6VwhEkWQl9uX8nUhRQSAO+82Z4bNhZOdTS2Y5pmG+UUBz/YNWd9LmO7RtGJ1IOyD/x
	+DVYMHtRTE6fJh+uR2nL4NoErD4vpj4Xb+QUfNsQm0rre4Ki//yTvElJnQNsaXlbwaoMO75cwVw+r
	Hr8MOTgQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRlU-00CneJ-3D;
	Tue, 19 Dec 2023 04:31:33 +0000
Message-ID: <62d80fec-8de4-4719-b244-86b26954d723@infradead.org>
Date: Mon, 18 Dec 2023 20:31:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: skbuff: Remove some excess struct-member
 documentation
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87cyv3javh.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87cyv3javh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/23 16:26, Jonathan Corbet wrote:
> Remove documentation for nonexistent structure members, addressing these
> warnings:
> 
>   ./include/linux/skbuff.h:1063: warning: Excess struct member 'sp' description in 'sk_buff'
>   ./include/linux/skbuff.h:1063: warning: Excess struct member 'nf_bridge' description in 'sk_buff'
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  include/linux/skbuff.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 27998f73183e..1cdab90a10a2 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -742,7 +742,6 @@ typedef unsigned char *sk_buff_data_t;
>   *	@dev_scratch: (aka @dev) alternate use of @dev when @dev would be %NULL
>   *	@cb: Control buffer. Free for use by every layer. Put private vars here
>   *	@_skb_refdst: destination entry (with norefcount bit)
> - *	@sp: the security path, used for xfrm
>   *	@len: Length of actual data
>   *	@data_len: Data length
>   *	@mac_len: Length of link layer header
> @@ -776,7 +775,6 @@ typedef unsigned char *sk_buff_data_t;
>   *	@tcp_tsorted_anchor: list structure for TCP (tp->tsorted_sent_queue)
>   *	@_sk_redir: socket redirection information for skmsg
>   *	@_nfct: Associated connection, if any (with nfctinfo bits)
> - *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
>   *	@skb_iif: ifindex of device we arrived on
>   *	@tc_index: Traffic control index
>   *	@hash: the packet hash

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

