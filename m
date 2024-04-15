Return-Path: <linux-kernel+bounces-145330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7BB8A52E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E641C20B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C871730;
	Mon, 15 Apr 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b9Q13URl"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C313745D5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190671; cv=none; b=bFP3LzZ6KhD2ydNHBGC88CJpsv+wcP4bMca6s6i06m3sMgE1/5aS6p45suXqbVBMFp6hqRMozSE3T1ZCCDJww2pEhXAgGxIHzFHd0Zvqiluj2jHhQU6BcszYu1WCh/11cW5ONvAYkcR2ja1WyvMCIrREg0Wcgssw9rO6rB+UYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190671; c=relaxed/simple;
	bh=7MAAuR4nAOglbJK96XVV97nD55IJBCwFc5+BwwC1NsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=X2wwN8eJUTyp3y8CoYxJsuA+RCH62lnUiT+ROTV9YqOxH+ecTMGvRfezA4sKnXI24lPO29GF3LLx6GBdAOBLPJeThTOOUm4iWzAfyFG9cL2KijN8eaBeRrr2Eh77VqMvLtgkLvPXoYpAi0jF/nTQbcP5vDlp6qcJ5uo0nwNejeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b9Q13URl; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240415141746euoutp019d4ccffad7161970cdd4b36046d67d30~GedWLxKV60482804828euoutp01Q
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:17:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240415141746euoutp019d4ccffad7161970cdd4b36046d67d30~GedWLxKV60482804828euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713190666;
	bh=zaHlAEoiDKROJY7VOEH6En1JrEsx1/tm4GCi694dG7o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=b9Q13URlzeRiG4F0ITi/a/4+aFY0gCm05XCT180UqfbY28Z5TJVziXSjDq7RT8cFR
	 8uv0kOp0UFK+eVSpDnC/xBsmFby2HlE5C9dfeB2im6rHhFB2x72MwxSlRxlFVSH5h2
	 4zuR1GO513ZL1O1qTNIBNuKrrFVgOnCojSdD1Ni8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240415141745eucas1p2243811eae4b291a2963c6a4190d087d0~GedVySrfo0944809448eucas1p2Q;
	Mon, 15 Apr 2024 14:17:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 8A.58.09624.9073D166; Mon, 15
	Apr 2024 15:17:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240415141745eucas1p2570fd7509a5d42276a70504803c9988f~GedVY0Akn0944409444eucas1p2O;
	Mon, 15 Apr 2024 14:17:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240415141745eusmtrp230c0618bb0db5f6b21a686d02e3b0716~GedVX96FJ1064510645eusmtrp2f;
	Mon, 15 Apr 2024 14:17:45 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-82-661d370959d9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C0.4D.09010.9073D166; Mon, 15
	Apr 2024 15:17:45 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240415141744eusmtip2cf1c1d1487a68e62858ad1ebd209a3b7~GedUvxdsZ2056220562eusmtip2U;
	Mon, 15 Apr 2024 14:17:44 +0000 (GMT)
Message-ID: <1dd9e3a1-29d0-4628-9b6a-b7e9fc09bf0f@samsung.com>
Date: Mon, 15 Apr 2024 16:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
	linux-amlogic@lists.infradead.org, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn
	Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
	Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7qc5rJpBi+bTSy2ddhYNC9ez2bx
	5tERZot3c2UsfrZvYbLomLydxWLBbG6LifvPsltc3jWHzeLM4l52i2OLTrJYvN95i9GBx+P9
	jVZ2j6cTJrN7bFrVyeZx59oeNo/9c9ewe2xeUu/xeZNcAHsUl01Kak5mWWqRvl0CV8bld0eZ
	Cx4KVFw7OpmpgfEwbxcjB4eEgInEiRccXYxcHEICKxgldly8ywjhfGGU+NB2mQnC+cwoMWHR
	ShaYjnWvayHiyxkl/n7cyArhfGSUmL3/MHsXIycHr4CdxNEp3WwgNouAqsTD9/fYIOKCEidn
	PmEBsUUF5CXu35oBVi8s4Cpx6c1bNpBBIgIrGSUuPLgG5jALnGSSuPu8EayKWUBc4taT+Uwg
	NpuAoUTX2y6wqZxA217ff8sIUSMvsf3tHGaQZgmBfk6Jr18+soIkJARcJL7tusEEYQtLvDq+
	hR3ClpH4v3M+E0RDO6PEgt/3oZwJjBINz28xQlRZS9w594sNFALMApoS63fpQ4QdJW7+7GeF
	BAyfxI23ghBH8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAspYGYheXMWkndmIexd
	wMiyilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzCJnf53/NMOxrmvPuodYmTiYDzEKMHB
	rCTC2yIsmybEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXA
	ZP3y+L2jwa1NNjd83+5V7FNulOia1OLiM7kmdb/F08NSkw9ti8tYKHr019u/9n6MneemsfVG
	FK2acmhy6ARf9eBezmN7KpvV2g4l+mgzLxPomv3jof0u7/RPmeKT8/1mzi+srfsZt2RR98X3
	mcG1ZTZZwklPdZsn8j4Uk/m2qVtF+iDD/gsqN3u/LPZeZySeEb5a9eMToWM7FjZOq3GW+1h0
	/vmCGxPTPj1aJvDScCKzzfI/2darXbdsyWra9+bqKfc7rOobN/8V2qE2SUI9693HST8mHazi
	veb1Um8uh2fg+oC+S086ju57mLDB0vWciuj1tlU9cmcPZBzL+3TnrXc198dl04vPOnPqfI4s
	Z1ZiKc5INNRiLipOBABzmhc10QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xe7qc5rJpBr+2SFhs67CxaF68ns3i
	zaMjzBbv5spY/GzfwmTRMXk7i8WC2dwWE/efZbe4vGsOm8WZxb3sFscWnWSxeL/zFqMDj8f7
	G63sHk8nTGb32LSqk83jzrU9bB77565h99i8pN7j8ya5APYoPZui/NKSVIWM/OISW6VoQwsj
	PUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzL744yFzwUqLh2dDJTA+Nh3i5GDg4J
	AROJda9ruxi5OIQEljJKfF90n6mLkRMoLiNxcloDK4QtLPHnWhcbRNF7RokTs1+zgCR4Bewk
	jk7pZgOxWQRUJR6+v8cGEReUODnzCViNqIC8xP1bM9hBbGEBV4lLb96CDRIRWMkoMXH7SnYQ
	h1ngNJPE6osPWaHuYJK49a8R7A5mAXGJW0/mg9lsAoYSXW+7wFZwAq1+ff8tI0SNmUTX1i4o
	W15i+9s5zBMYhWYhuWQWklGzkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmDc
	bjv2c8sOxpWvPuodYmTiYDzEKMHBrCTC2yIsmybEm5JYWZValB9fVJqTWnyI0RQYHBOZpUST
	84GJI68k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWniynX53Dv4
	vms6v7pgkHE5fHLp5HWr3yjx1mhcXxdoMW1bluPiTWZLpy26VTJncuGv26+W3T1iKO27v7FU
	3CHcwz+Or9DBrFz3xJa53QHfvPZ5RkX47Jq8q3viyhmaZfMV88+2zPb8wvpUZJp1gF2bd92k
	b3duRZ8qtDKTmXSX24ax+YmLwLs8x4RbOa2T35399elzpbaZu5/6xM2Fux0EX056mnhrBn9X
	2hPf2C1CqydMUOuQ7yxaO3f/03Nh35vEo7S15l8VyPJ/NOvZ/H3Z3h+fVvknhqpl8y/5f884
	pcEl/tWP80+uHkiI283+dXO67icX+SiB5Gs//i/VTisru+j0OuU7P1/p1vOvNiYrsRRnJBpq
	MRcVJwIAN2bmOGQDAAA=
X-CMS-MailID: 20240415141745eucas1p2570fd7509a5d42276a70504803c9988f
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
	<d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>

On 15.04.2024 15:28, Jiri Slaby wrote:
> On 15. 04. 24, 14:58, Marek Szyprowski wrote:
>> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
>>> Switch from struct circ_buf to proper kfifo. kfifo provides much better
>>> API, esp. when wrap-around of the buffer needs to be taken into 
>>> account.
>>> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for 
>>> example.
>>>
>>> Kfifo API can also fill in scatter-gather DMA structures, so it easier
>>> for that use case too. Look at lpuart_dma_tx() for example. Note that
>>> not all drivers can be converted to that (like atmel_serial), they
>>> handle DMA specially.
>>>
>>> Note that usb-serial uses kfifo for TX for ages.
>>>
>>> omap needed a bit more care as it needs to put a char into FIFO to 
>>> start
>>> the DMA transfer when OMAP_DMA_TX_KICK is set. In that case, we have to
>>> do kfifo_dma_out_prepare twice: once to find out the tx_size (to find
>>> out if it is worths to do DMA at all -- size >= 4), the second time for
>>> the actual transfer.
>>>
>>> All traces of circ_buf are removed from serial_core.h (and its struct
>>> uart_state).
>>>
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> ...
>>
>> This patch landed in linux-next as commit 1788cf6a91d9 ("tty: serial:
>> switch from circ_buf to kfifo"). Unfortunately it breaks UART operation
>> on thr Amlogic Meson based boards (drivers/tty/serial/meson_uart.c
>> driver) and Qualcomm RB5 board (drivers/tty/serial/qcom_geni_serial.c).
>> Once the init process is started, a complete garbage is printed to the
>> serial console. Here is an example how it looks:
>
> Oh my!
>
> Both drivers move the tail using both kfifo and uart_xmit_advance() 
> interfaces. Bah. Does it help to remove that uart_xmit_advance() for 
> both of them? (TX stats will be broken.)
>
> Users of uart_port_tx() are not affected.
>
> This is my fault when merging uart_xmit_advance() with this series.

Yes, removing uart_xmit_advance() from both drivers seems to be fixing 
the console output.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


