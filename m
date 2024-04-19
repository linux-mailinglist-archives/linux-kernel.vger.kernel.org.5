Return-Path: <linux-kernel+bounces-151209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029CC8AAB21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6F7B21E75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3829E757F6;
	Fri, 19 Apr 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QXpQWEow"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B3651B6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517427; cv=none; b=rUvxxXZlktSDqA6AOqOZruZq/X+hYfMdnO0wN6xR3LdvEh5qUaTC0TzyJ8/GW/7fb8gM6IgcVc//xOWdwu/j1NHCl4hby56j7i0BH1bqz34pGxweKl4SdEi38oz6czT4BFUCVC+0+Afo2JItCKfJY1J0Cv/rA9cB4XvZXHi6Qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517427; c=relaxed/simple;
	bh=e4fxTG9IOEhRJ2oy+q+Z2QsiJ7pgDkrpf7Ps9FXu6MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jsz7+9qw6gzmmlk0Xa/xk+RNbk0LAPPxPn7dKNy0eU42ufwn9z7G3zYuXPgapSUElLyzgwYSxm0qoCfTjJUQLA7WXRvRVAQu3LQ4vaLj3MjhQdJvjPkENL0dVXKIlgzz7b33n6Ix2xNiB+9Pzhv9HEFFD7kQvWRSzOys7UmeTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QXpQWEow; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240419090337euoutp028afad3b3d0fa45ba09f97e525db5e25a~HowMnqGNg1247212472euoutp02x
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:03:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240419090337euoutp028afad3b3d0fa45ba09f97e525db5e25a~HowMnqGNg1247212472euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713517417;
	bh=5epo2hFNGdItoVB1/oi1I+wZXv4cgIPH4R+qqziczOI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QXpQWEowhE3Vyr+TulZX4n1uylvZEHaGK0d7NDRlG5CpHWuniEg3rSV5A4SQf4CLH
	 5OWdFn9kp8tHZqZDG+yK6eqPuJQDm9bxp0DwMHLd1kCsqtof/G4b6w26KYtAIIncc+
	 5aReWLvo+2hJKeaXG3cui2d0TNAX0oMvO7M4Y4l8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240419090336eucas1p2090739cbb7fd29dcede241151823357a~HowMR7Sfo0628006280eucas1p2Y;
	Fri, 19 Apr 2024 09:03:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.F3.09624.86332266; Fri, 19
	Apr 2024 10:03:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240419090336eucas1p17674ea65e993d1681fea157e46e2b059~HowL8xCMG2506225062eucas1p1A;
	Fri, 19 Apr 2024 09:03:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240419090336eusmtrp18787ba7327372849526ebcc458a53dac~HowL8L-Em2605826058eusmtrp1V;
	Fri, 19 Apr 2024 09:03:36 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-f0-662233687f18
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.CC.09010.86332266; Fri, 19
	Apr 2024 10:03:36 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240419090336eusmtip2fe7f576e4a49e16e0fd0fdf5701fa2ff~HowLnqshL0629206292eusmtip2c;
	Fri, 19 Apr 2024 09:03:36 +0000 (GMT)
Message-ID: <92492ec0-bde6-46ad-a2b4-840b60c85652@samsung.com>
Date: Fri, 19 Apr 2024 11:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: msm: check dma_map_sg() return value properly
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240419080931.30949-1-jirislaby@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOd0MY6U0g5kbtS2aF69ns3g3V8bi
	8q45bBZnFveyO7B4bFrVyeaxf+4ado/Pm+QCmKO4bFJSczLLUov07RK4Mk5e+8te8Ja/4s81
	tQbGxzxdjJwcEgImErs/LmTqYuTiEBJYwSjxdscCNgjnC6PE+YvvGCGcz4wSDSs3scC0rFzy
	FKpqOaPE4+bnLBDOR0aJqTM3MYJU8QrYSUzq+cQGYrMIqEp8fXSBGSIuKHFy5hOwSaIC8hL3
	b81gB7GFBbwktk/bygRiiwDZpyY/AZvDDDRn2pOLLBC2uMStJ/PBatgEDCW63naBzecUsJJ4
	3DeFDaJGXmL72znMIAdJCKzlkGhddZgJ4mwXiZ/dD5ghbGGJV8e3sEPYMhKnJ/ewQDS0M0os
	+H2fCcKZAPT081uMEFXWEnfO/QJawQG0QlNi/S59iLCjROv/SywgYQkBPokbbwUhjuCTmLRt
	OjNEmFeio00IolpNYtbxdXBrD164xDyBUWkWUrDMQvLmLCTvzELYu4CRZRWjeGppcW56arFh
	Xmq5XnFibnFpXrpecn7uJkZgQjn97/inHYxzX33UO8TIxMF4iFGCg1lJhNeMQzFNiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1Oqgakl3+9FUjovo2p9SMzs
	M+6LOCZ07RV6of7D//7jl8eefNEs3Lxv9xfFi9wnTnv2xbC2/IyVfm69Tn32Of+Q3616dQ1L
	gwx3/lRb9fbnQbuksK5YUzajqf/n1IoF3euRfey9lWup2uupn648eyWmscEld9PKh9rbeuKv
	7BBRUvyxLebE7W2HvkbcEkjdcitViPV6p2JQWHuJ02nW/Z6/nrf9VtjZoP8s4q3Pvh0LStnf
	NfYu3/as4T8T+8StElWq1z478mxwDHj4xS7cRuHmSofQCe3m6s8zg022NF8UDmaPv2o6J+ng
	O3Yld9Mzy845m7uGT2j8PaWH847S1sdWr6oWZ6S6bY1dd9Wp5+u+Hm0lluKMREMt5qLiRADd
	FGXflwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7oZxkppBvsOils0L17PZvFurozF
	5V1z2CzOLO5ld2Dx2LSqk81j/9w17B6fN8kFMEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZ
	WOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZZy89pe94C1/xZ9rag2Mj3m6GDk5JARMJFYuecrW
	xcjFISSwlFFicddbZoiEjMTJaQ2sELawxJ9rXVBF7xklbkzbAZbgFbCTmNTziQ3EZhFQlfj6
	6AIzRFxQ4uTMJywgtqiAvMT9WzPYQWxhAS+J7dO2MoHYIkD2qclPGEFsZqA5055cZIFYcIhR
	Yu69mSwQCXGJW0/mgzWwCRhKdL3tAlvGKWAl8bhvChtEjZlE19YuqEHyEtvfzmGewCg0C8kd
	s5CMmoWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI2jbsZ9bdjCufPVR7xAj
	Ewcj0I0czEoivGYcimlCvCmJlVWpRfnxRaU5qcWHGE2BgTGRWUo0OR8Yw3kl8YZmBqaGJmaW
	BqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUxziv5t5L8rrc5aIqCucDMhdWdNP9Nc
	l8C5ivVtQu1pFzcpunlOnuca2B9z98o11kiD0MBnM/9uVFXSuBkY+XRmNmuLQNYs77Tqpr4k
	xs27T3qqrHVPe8ZmkDLP5KToeds/cXEmS1kvG/ooTt45X22hjMx5bcGVdvI7tH7MOs7+Y8uy
	g/3t6xcEcR6tV5ujevGpKuPOZ3oytYe+rzzhdfuz4b2lu9i5DY7M4vt769UZGZljB/PiRPjn
	H3T77V0t/jnSgfHNufiCkgds+dyPgy//+yjo+uLlrYs31WLnM6jfuRvF2fIhcW1lyOu/7jX+
	ydF+J9cu2NfnWpbWEGJRUrD0majP0743neJ7v+7wO6bEUpyRaKjFXFScCABwQiw8KQMAAA==
X-CMS-MailID: 20240419090336eucas1p17674ea65e993d1681fea157e46e2b059
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240419080939eucas1p1ab74bd6b995e53135ece92bc4260d334
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240419080939eucas1p1ab74bd6b995e53135ece92bc4260d334
References: <cbf77a8b-b37c-41d8-a7b5-a1c935571a1d@samsung.com>
	<CGME20240419080939eucas1p1ab74bd6b995e53135ece92bc4260d334@eucas1p1.samsung.com>
	<20240419080931.30949-1-jirislaby@kernel.org>

On 19.04.2024 10:09, Jiri Slaby (SUSE) wrote:
> The -next commit f8fef2fa419f (tty: msm_serial: use
> dmaengine_prep_slave_sg()), switched to using dma_map_sg(). But the
> return value of dma_map_sg() is special: it returns number of elements
> mapped. And not a standard error value.
>
> The commit also forgot to reset dma->tx_sg in case of this failure.
>
> Fix both these mistakes.
>
> Thanks to Marek who helped debugging this.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/tty/serial/msm_serial.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index ae7a8e3cf467..0a9c5219df88 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -499,15 +499,18 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
>   	struct uart_port *port = &msm_port->uart;
>   	struct tty_port *tport = &port->state->port;
>   	struct msm_dma *dma = &msm_port->tx_dma;
> +	unsigned int mapped;
>   	int ret;
>   	u32 val;
>   
>   	sg_init_table(&dma->tx_sg, 1);
>   	kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1, count);
>   
> -	ret = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> -	if (ret)
> -		return ret;
> +	mapped = dma_map_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> +	if (!mapped) {
> +		ret = -EIO;
> +		goto zero_sg;
> +	}
>   
>   	dma->desc = dmaengine_prep_slave_sg(dma->chan, &dma->tx_sg, 1,
>   						DMA_MEM_TO_DEV,
> @@ -548,6 +551,7 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
>   	return 0;
>   unmap:
>   	dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
> +zero_sg:
>   	sg_init_table(&dma->tx_sg, 1);
>   	return ret;
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


