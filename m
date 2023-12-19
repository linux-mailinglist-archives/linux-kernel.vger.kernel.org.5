Return-Path: <linux-kernel+bounces-6117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A548194CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B482835D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA493FB0C;
	Tue, 19 Dec 2023 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kerYq+pT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493FB40BE2;
	Tue, 19 Dec 2023 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SgTA8vVJwD0WaaMYG+OW+5wk3HbFBhi12OliC3qsMsk=; b=kerYq+pTaPy2aBRoe9FoDdHIAe
	eQtD+E6fGAbzbE4IfgZqBoHc1ojA5YE1XlB2EzoyW6tLupRy5QTQDCovCfxl67e2d6TEgRnMR30VQ
	9ilMzFehxrvFnejWYobqJz9EKS3NgB6HJuhxEpIeEQFyJQvoCJJK6YnYbfK3yetSknLDy+cNvRNJz
	A23G4htnQdM25z5HqthETZjkemzhoYX6WA990wyeX4Bpya5S3bVxM32dkhMGNgPWT0xr/YX0m9hQi
	nY7eO1QT7zpQ5TDYnjIKhvDcicZrS/BAIlfuAXTI/uNVFXZVojjSGhFPjhKnBN8fklrSZyzddHE4Q
	3WQXYcSQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFjvk-00FiUg-0s;
	Tue, 19 Dec 2023 23:55:20 +0000
Message-ID: <8e7a5e72-6b70-4623-a439-298edef90a4d@infradead.org>
Date: Tue, 19 Dec 2023 15:55:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sock: remove excess structure-member
 documentation
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <874jgdhhu7.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <874jgdhhu7.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 15:51, Jonathan Corbet wrote:
> Remove a couple of kerneldoc entries for struct members that do not exist,
> addressing these warnings:
> 
>   ./include/net/sock.h:548: warning: Excess struct member '__sk_flags_offset' description in 'sock'
>   ./include/net/sock.h:548: warning: Excess struct member 'sk_padding' description in 'sock'
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  include/net/sock.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 1d6931caf0c3..bee854b477b2 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -277,8 +277,6 @@ struct sk_filter;
>    *	@sk_pacing_status: Pacing status (requested, handled by sch_fq)
>    *	@sk_max_pacing_rate: Maximum pacing rate (%SO_MAX_PACING_RATE)
>    *	@sk_sndbuf: size of send buffer in bytes
> -  *	@__sk_flags_offset: empty field used to determine location of bitfield
> -  *	@sk_padding: unused element for alignment
>    *	@sk_no_check_tx: %SO_NO_CHECK setting, set checksum in TX packets
>    *	@sk_no_check_rx: allow zero checksum in RX packets
>    *	@sk_route_caps: route capabilities (e.g. %NETIF_F_TSO)

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

