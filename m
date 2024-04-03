Return-Path: <linux-kernel+bounces-129009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81906896318
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B511C221E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D2D405F2;
	Wed,  3 Apr 2024 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kjhZyHul"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CF3E48E;
	Wed,  3 Apr 2024 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115597; cv=none; b=JHXxD3Ry4L+rEmGCnm5xQ0fD0cB2ZitB5lWNMWY1tOMjq4I52ab41AB/0/qpOEseM2LUoXZnqLAT+cZmAVhnwrd1zXbZZLpVfd9z8tZwmNwRGhNLhPv97Srr+44ptWfuE/Lsk+DZQ0udNqXjEfAHq3dbbDufvZwK1N7wqaohuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115597; c=relaxed/simple;
	bh=vsYTyHZbz3YwYaV3ajc98Gk+zAeEUCnLJQKC3yldWmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2Wy/eHoRv3XYBsy1OfjhKTntME/9Mw7w4bDr9ATPR2m17Mrxzmaa7ELf5V4EUmDOVOesasI+w0XGsw57ksdmtCO3UNHTSRa+Hqa/DcHbKapi2GJAMgyiqOYAdHAwHzSRJUfLKkoggBsjYK3cByu8ziIskLsuTpmHirQDbvdQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kjhZyHul; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432K3FI4029252;
	Tue, 2 Apr 2024 20:39:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=/BY57IBLf+yABTirJWi18E
	+1Z/d+IYDmnVTMqS6JZfQ=; b=kjhZyHulAB+3lmLlWr/x1liznmQTLqF6MI3g6s
	juedvaHYkO/DSp3R6AcV651ivy0hBeMvnHDjrtcnYF1KMgrgvijS8ffFrDhddxvG
	V8vMOUDb11z6ZgOzoKjrFnN952TuMpHeyc64M62qPLtRZPZ57h+nUmrFh0iULYus
	vS29qb3/ILPaEvJUXGkZo8eOTe9UV05fFXgJ231TI7VVMYkSCaEB7aY9d+/Cikfm
	9kenj/FL8pm+mRQAeIDlwGRpiQ+lLFaCv3n4DI4rWBWmcbRafCODhyE/T7RcLgEe
	WfLK2Hhu4De3VS1tw+yqmbUcqNVjkQLgG2mC8vFEFiiu1F1w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x809fx762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 20:39:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 20:39:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 2 Apr 2024 20:39:36 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id ADB2D3F7044;
	Tue,  2 Apr 2024 20:39:33 -0700 (PDT)
Date: Wed, 3 Apr 2024 09:09:32 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
CC: Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Niklas
 =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
        <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] net: ravb: Always process TX descriptor ring
Message-ID: <20240403033932.GA1652207@maili.marvell.com>
References: <20240402145305.82148-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402145305.82148-1-paul.barker.ct@bp.renesas.com>
X-Proofpoint-GUID: lwwmbmCWzRzUI69ZRDR5BWE6p3BzwolQ
X-Proofpoint-ORIG-GUID: lwwmbmCWzRzUI69ZRDR5BWE6p3BzwolQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_02,2024-04-01_01,2023-05-22_02

On 2024-04-02 at 20:23:04, Paul Barker (paul.barker.ct@bp.renesas.com) wrote:
> The TX queue should be serviced each time the poll function is called,
> even if the full RX work budget has been consumed. This prevents
> starvation of the TX queue when RX bandwidth usage is high.
>
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> Changes from v1:
>   * Use the correct 'Fixes' tag.
>   * Call the new variable 'unmask' and drop the unnecessary initializer,
>     as requested by Sergey.
>
>  drivers/net/ethernet/renesas/ravb_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index d1be030c8848..48803050abdb 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1324,12 +1324,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	int q = napi - priv->napi;
>  	int mask = BIT(q);
>  	int quota = budget;
> +	bool unmask;
>
>  	/* Processing RX Descriptor Ring */
>  	/* Clear RX interrupt */
>  	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
> -	if (ravb_rx(ndev, &quota, q))
> -		goto out;
> +	unmask = !ravb_rx(ndev, &quota, q);
>
>  	/* Processing TX Descriptor Ring */
AFAIU, TX is processed without any budget. This wont result in rx work starvation if
TX traffic is more ?

>  	spin_lock_irqsave(&priv->lock, flags);
> @@ -1339,6 +1339,9 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	netif_wake_subqueue(ndev, q);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> +	if (!unmask)
> +		goto out;
> +
>  	napi_complete(napi);
>
>  	/* Re-enable RX/TX interrupts */
>
> base-commit: ea2a1cfc3b2019bdea6324acd3c03606b60d71ad
> --
> 2.39.2
>

