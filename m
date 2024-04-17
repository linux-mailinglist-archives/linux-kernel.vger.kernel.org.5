Return-Path: <linux-kernel+bounces-148313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E2B8A80CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D571F21215
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078B13C8E5;
	Wed, 17 Apr 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mkJh3BtI"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAD13C3E4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349236; cv=none; b=kYTgm1N4+oWvUlKPexXLD6UwqGnrrNeKJkB0ajwrHFh3LnR6n4OmU4IyzI2tgr4iGbpPwQpbZKad/qlHlbvIxaWUQeSvq+ctfc9t4EPlzLtCl7p1P7a6+tJgu4hOe84t4dDCUCcfdb60TG6erd2vlGOrt5+RFvEO7w61myHcyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349236; c=relaxed/simple;
	bh=Hqfqwezo4j40e/O6q9Y5jOHPHshmKCtSIPdpxWSc8go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kD5ACvzplSkLKsh/2MlzLrHwqnkzLQOxcUlTWD2NY5u6EHYmcbEeLjiGWYkMoPgn9Atj4WFKKJUXibOGYusesTWRLcFC7HTukjVUxafolcTig+ULWDjXqDEb7GafbWK+zbnE9MV8m2o+wg8D3wvRW8Mw8HAzYU0HW9vFMzk5VUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mkJh3BtI; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240417102031euoutp02b611b56fd282afb6b35723ab65168020~HCgx5OOP71892718927euoutp02v
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:20:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240417102031euoutp02b611b56fd282afb6b35723ab65168020~HCgx5OOP71892718927euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713349231;
	bh=dFt6dfcqV3zT2/ZiPZ6VfWUb9Ittzgqcfr2mHlwzjko=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mkJh3BtIzO80Gg+ySnEXp6oFTse34sqblkl0o4Ue5vGXUqRxc0+v5gcoYkATjhzn6
	 f6c1HGwzkv8ogHl1K6tt3qzJSoBEp5bZMwXosy6Njj8ewelg155GGIBUg+BoN23jTr
	 pluVfCm7C5G9aCZXjpFUqCTJWeGLvXaXGuRBGTbY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240417102031eucas1p1a388b363c581a557fe3c4ca64f141a92~HCgxlaONv1596815968eucas1p1Z;
	Wed, 17 Apr 2024 10:20:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id AA.39.09875.F62AF166; Wed, 17
	Apr 2024 11:20:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240417102031eucas1p221e613c1c12e7f71449935a2090cd72e~HCgxLJvvj1176911769eucas1p27;
	Wed, 17 Apr 2024 10:20:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240417102031eusmtrp1f8fa65831e1464c22b1362499d7a4fdd~HCgxJ80f-2417024170eusmtrp1B;
	Wed, 17 Apr 2024 10:20:31 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-21-661fa26f07c1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.B5.09010.E62AF166; Wed, 17
	Apr 2024 11:20:30 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240417102030eusmtip21c4b82205fab31cb65d46fa91d3a4030~HCgwZ4A6z1594315943eusmtip2g;
	Wed, 17 Apr 2024 10:20:30 +0000 (GMT)
Message-ID: <c091da0b-a150-428a-bf96-75f9f3eab2e2@samsung.com>
Date: Wed, 17 Apr 2024 12:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: Anders Roxell <anders.roxell@linaro.org>, Jiri Slaby
	<jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-amlogic@lists.infradead.org,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Andersson
	<andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Neil
	Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Zh-fgtujwjiSXz7D@monster>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7r5i+TTDK5eVbC4NeU3k8W2DhuL
	5sXr2SzePDrCbPFurozFz/YtTBYdk7ezWCyYzW0xcf9ZdovLu+awWZxZ3MtucWzRSRaL9ztv
	MTrwery/0cru8XTCZHaPTas62TzuXNvD5rF/7hp2j81L6j0+b5ILYI/isklJzcksSy3St0vg
	ythw9hFLwWyRioldn9kaGA8JdDFyckgImEgsP3iNsYuRi0NIYAWjxNztx1ggnC+MEu8vdbND
	OJ8ZJd5c388E0/JidR8bRGI5o8TlUxOgnI+MEjufPger4hWwk+g9O5MNxGYRUJVY2LKNGSIu
	KHFy5hMWEFtUQF7i/q0Z7CC2sICrxKU3b8HqRQQCJbZc3wE2lFngLLPEriV3wYqYBcQlbj2Z
	D7aATcBQouttF1gDp4C6xMkTi5kgauQltr+dwwzSLCEwmVPi6PdNLBB3u0isXnsZ6gdhiVfH
	t7BD2DISpyf3sEA0tDNKLPh9nwnCmcAo0fD8FiNElbXEnXO/gNZxAK3QlFi/Sx8i7Chx82c/
	K0hYQoBP4sZbQYgj+CQmbZvODBHmlehoE4KoVpOYdXwd3NqDFy4xT2BUmoUULrOQvDkLyTuz
	EPYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZjQTv87/mUH4/JXH/UOMTJxMB5i
	lOBgVhLhbRGWTRPiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5YkpqdmlqQWgSTZeLg
	lGpg6tDesLvT3ks6+6orkza/cK6vZ1+izPTLM6N7WXImpzwQbrBYLxe24q7A028LDnBx//Z4
	84TDfOZZK/7XEiaJE3asOZnJ9Kn9Y/PdPylyS5mD+vi2b0zks9E+0+ArXFb9z+TQu/kPDK69
	vqO24ple3pZ3zRHaR8rPPC3ocPN/6v2zsnRCddfZ2yFC9jdaruZKXV+oVjjXI6DL7ALD1Hjj
	zrY128RrasNYpzc9C71y9PYU+VUGn3pfWh5lfPZejsdRTW/uqsnMnjJfkt4GHrpee19/xYWG
	av5Ivy5pWeGm3F+PWXOO9P62X6L/NdDD2vaZtmz1t1TmCf8N3i27X2Vywshh54Tc4x3bXTV1
	PecpsRRnJBpqMRcVJwIAoUmG79cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7p5i+TTDN4/sbK4NeU3k8W2DhuL
	5sXr2SzePDrCbPFurozFz/YtTBYdk7ezWCyYzW0xcf9ZdovLu+awWZxZ3MtucWzRSRaL9ztv
	MTrwery/0cru8XTCZHaPTas62TzuXNvD5rF/7hp2j81L6j0+b5ILYI/SsynKLy1JVcjILy6x
	VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy9hw9hFLwWyRioldn9kaGA8J
	dDFyckgImEi8WN3H1sXIxSEksJRR4s6yVlaIhIzEyWkNULawxJ9rXVBF7xklHu08DZbgFbCT
	6D07kw3EZhFQlVjYso0ZIi4ocXLmExYQW1RAXuL+rRnsILawgKvEpTdvwepFBAIlrt5Zwg4y
	lFngPLPEhOZ9rBAbDjBJ3F23DqyDWUBc4taT+UwgNpuAoUTX2y6wbk4BdYmTJxYzQdSYSXRt
	7WKEsOUltr+dwzyBUWgWkkNmIRk1C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+du
	YgRG8LZjP7fsYFz56qPeIUYmDsZDjBIczEoivC3CsmlCvCmJlVWpRfnxRaU5qcWHGE2BoTGR
	WUo0OR+YQvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphWKz++
	WxdkKsZh9Pla9pEchZcXTbnfBoj/8Nsod1jt2F1XsSdTT5Xvr9ix1+lCjXCwweLDuVtszzxc
	vVbdt3Lu66Ml5lptj3ImRO1YN3nKNUvpA9knP08PkZRItDt24a1PJ+eV82avT062+enwIVaL
	JdxFh2caixWbhf7bTQ7752TLmSsFy2n2n3EV3X/MVmbLM8vKvs/mU4sWnYs8KHjI7RO/YeNs
	Me19ixenvH/yvkrh8EZ192WCusFM9zaWf0vIkZhqJP6iz+fE0/QYPvGN9vHczwQz9sTP31As
	+HLrmuv8M9pssu8fqwuxvx/G57jOP3uay+pojmlPFr1p7rn/cX/PvswDQWutlQL3XlJQYinO
	SDTUYi4qTgQAEwnrVGkDAAA=
X-CMS-MailID: 20240417102031eucas1p221e613c1c12e7f71449935a2090cd72e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae
References: <20240405060826.2521-1-jirislaby@kernel.org>
	<20240405060826.2521-13-jirislaby@kernel.org>
	<CGME20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae@eucas1p2.samsung.com>
	<91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com>
	<d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org> <Zh-fgtujwjiSXz7D@monster>

On 17.04.2024 12:08, Anders Roxell wrote:
> On 2024-04-15 15:28, Jiri Slaby wrote:
>> On 15. 04. 24, 14:58, Marek Szyprowski wrote:
>>> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
>>>> Switch from struct circ_buf to proper kfifo. kfifo provides much better
>>>> API, esp. when wrap-around of the buffer needs to be taken into account.
>>>> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
>>>>
>>>> Kfifo API can also fill in scatter-gather DMA structures, so it easier
>>>> for that use case too. Look at lpuart_dma_tx() for example. Note that
>>>> not all drivers can be converted to that (like atmel_serial), they
>>>> handle DMA specially.
>>>>
>>>> Note that usb-serial uses kfifo for TX for ages.
>>>>
>>>> omap needed a bit more care as it needs to put a char into FIFO to start
>>>> the DMA transfer when OMAP_DMA_TX_KICK is set. In that case, we have to
>>>> do kfifo_dma_out_prepare twice: once to find out the tx_size (to find
>>>> out if it is worths to do DMA at all -- size >= 4), the second time for
>>>> the actual transfer.
>>>>
>>>> All traces of circ_buf are removed from serial_core.h (and its struct
>>>> uart_state).
>>>>
>>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>>> ...
>>> This patch landed in linux-next as commit 1788cf6a91d9 ("tty: serial:
>>> switch from circ_buf to kfifo"). Unfortunately it breaks UART operation
>>> on thr Amlogic Meson based boards (drivers/tty/serial/meson_uart.c
>>> driver) and Qualcomm RB5 board (drivers/tty/serial/qcom_geni_serial.c).
>>> Once the init process is started, a complete garbage is printed to the
>>> serial console. Here is an example how it looks:
>> Oh my!
>>
>> Both drivers move the tail using both kfifo and uart_xmit_advance()
>> interfaces. Bah. Does it help to remove that uart_xmit_advance() for both of
>> them? (TX stats will be broken.)
>>
>> Users of uart_port_tx() are not affected.
>>
>> This is my fault when merging uart_xmit_advance() with this series.
>>
> I'm trying to run on two dragonboard devices db410c and db845c and both
> fails to boot see the boot failure from db845c [1], linux-next tag: next-20240415.
> I tried to apply the patch [2] (that you proposed in this thread) ontop of next-20240415. However, that didn't
> help bootlog on db845c [3].

This is a different issue, which I've reported 2 days ago. See the 
following thread:

https://lore.kernel.org/all/d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com/


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


