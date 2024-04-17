Return-Path: <linux-kernel+bounces-148297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879188A8083
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213A92834D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1B13AD33;
	Wed, 17 Apr 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cIdFVddK"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046D13AD22
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348924; cv=none; b=RKnbjTS7eDD5mMGz2QSOfLfZRYNYUDroROZo3yMyiSTQmOLVf95zILvCM3xnbBG4L/pCrI2YSujxNncr6ja/BQB7TCpFKbZl/DS4BdDO9vmzCtTUSi1uGMx1zPMnWl5MW7drSokfEDvrJpH8WH4BjfMcUbg9nabo7h97oIfB9Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348924; c=relaxed/simple;
	bh=fv5yPdVJiGS5NXE2yj0uhfJpuUPlFc72Nbeee8OJh/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZKjY6MT2AubOcJBK9H3x8+3gdPnU4uFH4Es7FKMPRKB7vFfdooTIrafTRby7mBz45cUf4cXFOyd/O+tADEy3Cv4gJ/K3YXkBzZ2/vWstvJF0WG9WWfzyaObWH4wtE9e0J2a9sGazYS2ZtfrAMJl6upILmmkmdwCerICDITminCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cIdFVddK; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240417101514euoutp02331bc278fca379a7072077e3d5314656~HCcKox3qY1053510535euoutp02g
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:15:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240417101514euoutp02331bc278fca379a7072077e3d5314656~HCcKox3qY1053510535euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713348914;
	bh=27ileZGHOYtN9nZgq/UWvP1r9Ik0Fxmy7wJboV6E4CA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cIdFVddK5hwyQtRUY0GZJDPFDCXuchBE3y3vQGGGEDgSwi5jsHnhOcjZPHBjuAQdH
	 6o6tYAh1h7H9c2G3sANNz1K35uoHN+S4noifChW+UOsTdpiqh8WEAnd/juhrDcK0QH
	 ENGQe200S6Zh1+bvlQuWYiZNdi1EExLa1CWKAZ0k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240417101514eucas1p10651fb4252d053df51c3592d50e9015f~HCcKUWcw01830918309eucas1p1r;
	Wed, 17 Apr 2024 10:15:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 8F.D6.09624.231AF166; Wed, 17
	Apr 2024 11:15:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240417101514eucas1p2b86c86cfe435dec8708bbdc7d04ab963~HCcKBUFOp2346623466eucas1p2t;
	Wed, 17 Apr 2024 10:15:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240417101514eusmtrp1b68b48086571f7fa320e5f0f1c0beea9~HCcKAnSma2051020510eusmtrp1Q;
	Wed, 17 Apr 2024 10:15:14 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-fc-661fa132ddd7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.D4.09010.231AF166; Wed, 17
	Apr 2024 11:15:14 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240417101513eusmtip2de89af895e989e9365557b692c1f92ba~HCcJmJCBu1775617756eusmtip2O;
	Wed, 17 Apr 2024 10:15:13 +0000 (GMT)
Message-ID: <0335b679-da36-42c1-a1ba-8affb7a98d44@samsung.com>
Date: Wed, 17 Apr 2024 12:15:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] tty: msm_serial: use dmaengine_prep_slave_sg()
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn
	Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <54679d54-3957-489d-a8b5-b98ea1c8a93c@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7pGC+XTDO79kLW4NeU3k8W2DhuL
	5sXr2SzezZWx6Ji8ncVi4v6z7BaXd81hszizuJfdgcNj06pONo871/aweeyfu4bd4/MmuQCW
	KC6blNSczLLUIn27BK6M3m9zmAs+Kle83P2YsYHxvFwXIyeHhICJxMGvDcwgtpDACkaJ5f+5
	uxi5gOwvjBKXt19ggUh8ZpRYu8wYpqFt+V4WiKLljBI/bz1jhHA+MkpMfLCVHaSKV8BO4uSU
	46xdjBwcLAKqEot/QIUFJU7OfAI2VFRAXuL+rRlgcWEBT4mnLbeZQcpFBBwlWv9Wg4xkFrjL
	KDFj91Y2kBpmAXGJW0/mM4HYbAKGEl1vu8DinECrrm7pZoWokZdo3jqbGaRZQuAGh8Sl5+uZ
	Ia52kbi79z+ULSzx6vgWdghbRuL05B4WiIZ2RokFv+8zQTgTGCUant9ihKiylrhz7hcbyHnM
	ApoS63fpQ4QdJebsuAX2pIQAn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9cYp7A
	qDQLKVhmIXlzFpJ3ZiHsXcDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw+Zz+d/zT
	Dsa5rz7qHWJk4mA8xCjBwawkwtsiLJsmxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9
	sSQ1OzW1ILUIJsvEwSnVwJR6TW5+0bSTp3pufv+afeSO4K7GGQ4fzZr8F9t0Nqrea7TeJbfj
	zYVthwzmV/u/qFARaPjQLJ+/nXmy6aYE+/er2ORNL7X9y0g5f+/VcYHa7GtTfs2Y5SvaO7s0
	xKP9PePv6acSF4bq+fZW3GT/YWon4Pfa+eg2Xc8Jk2aFvZi+2KXu+AmvtXXzGj99fXX5vPR5
	+4UtC22qxDcy3IkKvvzy6PxnV7TXxbUvWOvMayK1c1Hd93qZBlMptvqEzxOOTr4d+UMjQ/PX
	F4XvF6VUSoT3TKlbrKudqngwdMlVi0Bpi+Oy5/mr6zYdaktLy+6ayP2k9NI0hknv7vU/urE1
	Rfvcm2tvuljl7s7seNu6asIKJZbijERDLeai4kQAdPsA2K0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xe7pGC+XTDG4e4ra4NeU3k8W2DhuL
	5sXr2SzezZWx6Ji8ncVi4v6z7BaXd81hszizuJfdgcNj06pONo871/aweeyfu4bd4/MmuQCW
	KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M3m9z
	mAs+Kle83P2YsYHxvFwXIyeHhICJRNvyvSxdjFwcQgJLGSWW/b7HBpGQkTg5rYEVwhaW+HOt
	CywuJPCeUeLjKlkQm1fATuLklONANRwcLAKqEot/sEOEBSVOznzCAmKLCshL3L81AywuLOAp
	8bTlNjNIuYiAo0Tr32qQtcwC9xklJr48ywx1A5PEmTt/wBqYBcQlbj2ZzwRiswkYSnS9hbiB
	E2jv1S3drBA1ZhJdW7sYIWx5ieats5knMArNQnLHLCSjZiFpmYWkZQEjyypGkdTS4tz03GIj
	veLE3OLSvHS95PzcTYzAeNt27OeWHYwrX33UO8TIxMF4iFGCg1lJhLdFWDZNiDclsbIqtSg/
	vqg0J7X4EKMpMCwmMkuJJucDIz6vJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1
	CKaPiYNTqoHJQWmdofMSO4ufCYeyKqpZ/PQEJ3PUvfOb3LXoyIZV7M3sFy/p/l6cmyLr/5pR
	neEFg8GVl9zmTau3z3o25XU8K4vEI1c3PelvjqGb3rafY2/L+hZzK/3F2+Lj8b6WV/pjbm2v
	mpXMf89zu85W6agnLivZQiqXx7+afi/hdTJP/M0nN06f81dfoREkLFk69exz39evy2L7Wlev
	c3Bymzb9//Ona3nfX7J2mP5owfPHOw2/+2cd3Wj64FnI7imPeYo4a7u63Hk5HI1jbd372k03
	MXHI82hKKv15o8Sww6NunVtc7LIE+xZP144mDjmpTwWpPB9XmrBMbUqXf5Twa/vbH+5Hpl4V
	uWf5PtTeYL0SS3FGoqEWc1FxIgBMvz4WQAMAAA==
X-CMS-MailID: 20240417101514eucas1p2b86c86cfe435dec8708bbdc7d04ab963
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1
References: <20240405060826.2521-1-jirislaby@kernel.org>
	<20240405060826.2521-12-jirislaby@kernel.org>
	<CGME20240415211716eucas1p10050cc8d4024707dd6f6331111cd3ce1@eucas1p1.samsung.com>
	<d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com>
	<54679d54-3957-489d-a8b5-b98ea1c8a93c@kernel.org>

Hi Jiri,

On 16.04.2024 12:23, Jiri Slaby wrote:
> On 15. 04. 24, 23:17, Marek Szyprowski wrote:
>> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
>>> This is a preparatory for the serial-to-kfifo switch. kfifo understands
>>> only scatter-gatter approach, so switch to that.
>>>
>>> No functional change intended, it's just dmaengine_prep_slave_single()
>>> inline expanded.
>>>
>>> And in this case, switch from dma_map_single() to dma_map_sg() too. 
>>> This
>>> needs struct msm_dma changes. I split the rx and tx parts into an 
>>> union.
>>> TX is now struct scatterlist, RX remains the old good phys-virt-count
>>> triple.
>>>
>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> Cc: linux-arm-msm@vger.kernel.org
>>
>> I've just found that this patch broke UART operation on DragonBoard
>> 410c. I briefly checked and didn't notice anything obviously wrong here,
>> but the board stops transmitting any data from its serial port after the
>> first message. I will try to analyze this issue a bit more tomorrow.
>
> I double checked, but I see no immediate issues in the patch too. So 
> please, if you can analyze this more…

I've spent some time digging into this issue and frankly speaking I 
still have no idea WHY it doesn't work (or I seriously mixed something 
in the scatterlist principles). However I found a workaround to make it 
working. Maybe it will help a bit guessing what happens there.

Here is a workaround:

diff --git a/drivers/tty/serial/msm_serial.c 
b/drivers/tty/serial/msm_serial.c
index ae7a8e3cf467..fd3f3bf03f33 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -169,6 +169,7 @@ struct msm_dma {
                 } rx;
                 struct scatterlist tx_sg;
         };
+       int                     mapped;
         dma_cookie_t            cookie;
         u32                     enable_bit;
         struct dma_async_tx_descriptor  *desc;
@@ -278,6 +279,7 @@ static void msm_stop_dma(struct uart_port *port, 
struct msm_dma *dma)
                 if (dma->dir == DMA_TO_DEVICE) {
                         dma_unmap_sg(dev, &dma->tx_sg, 1, dma->dir);
                         sg_init_table(&dma->tx_sg, 1);
+                       dma->mapped = 0;
                 } else
                         dma_unmap_single(dev, dma->rx.phys, mapped, 
dma->dir);
         }
@@ -434,7 +436,7 @@ static void msm_start_tx(struct uart_port *port)
         struct msm_dma *dma = &msm_port->tx_dma;

         /* Already started in DMA mode */
-       if (sg_dma_len(&dma->tx_sg))
+       if (dma->mapped)
                 return;

         msm_port->imr |= MSM_UART_IMR_TXLEV;
@@ -462,7 +464,7 @@ static void msm_complete_tx_dma(void *args)
         uart_port_lock_irqsave(port, &flags);

         /* Already stopped */
-       if (!sg_dma_len(&dma->tx_sg))
+       if (!dma->mapped)
                 goto done;

         dmaengine_tx_status(dma->chan, dma->cookie, &state);
@@ -481,6 +483,7 @@ static void msm_complete_tx_dma(void *args)
         count = sg_dma_len(&dma->tx_sg) - state.residue;
         uart_xmit_advance(port, count);
         sg_init_table(&dma->tx_sg, 1);
+       dma->mapped = 0;

         /* Restore "Tx FIFO below watermark" interrupt */
         msm_port->imr |= MSM_UART_IMR_TXLEV;
@@ -522,6 +525,7 @@ static int msm_handle_tx_dma(struct msm_port 
*msm_port, unsigned int count)
         dma->desc->callback_param = msm_port;

         dma->cookie = dmaengine_submit(dma->desc);
+       dma->mapped = 1;
         ret = dma_submit_error(dma->cookie);
         if (ret)
                 goto unmap;
@@ -549,6 +553,7 @@ static int msm_handle_tx_dma(struct msm_port 
*msm_port, unsigned int count)
  unmap:
         dma_unmap_sg(port->dev, &dma->tx_sg, 1, dma->dir);
         sg_init_table(&dma->tx_sg, 1);
+       dma->mapped = 0;
         return ret;
  }


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


