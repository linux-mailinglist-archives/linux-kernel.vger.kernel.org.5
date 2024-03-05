Return-Path: <linux-kernel+bounces-91692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E3871537
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6811C2159D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AE35D738;
	Tue,  5 Mar 2024 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kCACNL11"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4945BFB;
	Tue,  5 Mar 2024 05:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616286; cv=none; b=B0CPvYgJMpdxBaB/G4sjZySnAcM741m72MkbEt7zIbynbF8t71Wuh/wjVZ0QjjAgvQQkhLItboMgb8EPpF69oHs4LenfvE0ExTB2aI3TDjVx5lIzZ84tsZidRt1emuNRBMtWP4TMoBrzaIhgxK4IS4sogIgSuy2s4d4LpbEnWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616286; c=relaxed/simple;
	bh=ovMFF2p5oK8EYHVURck+QPJEApIyCDpbd/gzNOK+sI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItDDu5me6Ue6kw52eO3gBD+h8ZY2vPXoSa6bVDpUk5ujHCM+ZgdKhLCAk0cZNWOHZQ+ZCqg42LGyCQl3QX0M/Nubkc9GhL6XUy+wiWIIoEms+7wgW7NsYV5oudPeGt54tfV9SHXoVXeXHXuGVS5x5qhTlYrGhRItZRqd7xR0TTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kCACNL11; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42513ex4003078;
	Mon, 4 Mar 2024 21:24:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=NBR8u97z8Hokb2nrGzdEzBZWH1fBhn7WMLp1Je3wzUY=; b=kCA
	CNL11YUluYAdzgxU/wzJw5pyMKQ4KASgI2d0RIDCMIN5PT2UIx0fitW6hm7liXrS
	LRZ3TFQxVNIMI7tZYlsUdaYhUKvQBTlZxcf68GxT5EU9czuzm73iKxWQBjkdfnQz
	1QpLZEx2yc+Jjoyt6XH8QKq/0xQ/U0dk/EawYrmb8SXG7tYkUMh3iCLjarhtZicz
	uzo/masjP1Wz6th36DDVTiHOIre/JoitHZPWqM53tRDM22G5ecQxMVZtswO1TJ0o
	yxIpLaf21dg8w+ML8mlFhZpc9wRMIX4IiO9leCwhYbmljfXIOD81FPgemzY3Kmd0
	dEKeYhPPBs/a5xAKMbw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wngqe2mqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 21:24:38 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 4 Mar 2024 21:24:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 4 Mar 2024 21:24:37 -0800
Received: from localhost.localdomain (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 149BA3F704E;
	Mon,  4 Mar 2024 21:24:35 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH v1] ps3_gelic_net: Use napi routines for RX SKB
Date: Tue, 5 Mar 2024 10:54:21 +0530
Message-ID: <20240305052421.1180221-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ddb7f076-06a7-45df-ae98-b4120d9dc275@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _i7ui0_ej6wrQG6PMJ8Dqtz7EyIxeKRG
X-Proofpoint-ORIG-GUID: _i7ui0_ej6wrQG6PMJ8Dqtz7EyIxeKRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_02,2024-03-04_01,2023-05-22_02

On 2024-03-01 at 13:50:11, Geoff Levand (geoff@infradead.org) wrote:
> +	if (unlikely(!napi_buff))
> +		return -ENOMEM;
>
> -	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
> -	if (!descr->skb) {
> -		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
> +	descr->skb = napi_build_skb(napi_buff, napi_buff_size);
> +
> +	if (unlikely(!descr->skb)) {
> +		skb_free_frag(napi_buff);
>  		return -ENOMEM;
>  	}
>
> -	offset = ((unsigned long)descr->skb->data) &
> -		(GELIC_NET_RXBUF_ALIGN - 1);
> -	if (offset)
> -		skb_reserve(descr->skb, GELIC_NET_RXBUF_ALIGN - offset);
> -	/* io-mmu-map the skb */
> -	cpu_addr = dma_map_single(ctodev(card), descr->skb->data,
> -				  GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);
> -	descr->hw_regs.payload.dev_addr = cpu_to_be32(cpu_addr);
> -	if (dma_mapping_error(ctodev(card), cpu_addr)) {
> -		dev_kfree_skb_any(descr->skb);
> +	cpu_addr = dma_map_single(dev, napi_buff, napi_buff_size,
> +				  DMA_FROM_DEVICE);
> +
> +	if (dma_mapping_error(dev, cpu_addr)) {
> +		skb_free_frag(napi_buff);
skb->head is freed; dont you need to free skb as well ?

>  		descr->skb = NULL;

