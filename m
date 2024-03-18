Return-Path: <linux-kernel+bounces-105677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D9B87E27A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F721C20AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E91EB4B;
	Mon, 18 Mar 2024 03:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hvAxY6YE"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109881DDF4;
	Mon, 18 Mar 2024 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732106; cv=none; b=qSqfFsKBrE0i47k68x96gzzmqNmcgkpcII0Hi7Wg9+h9gUQ4izvYng4NMtHBxp+ZwJvPD912C5Ks7eDiGIsa0S/wfV3LEO8Z7x6tpKmm/inkhQb3EmFk4Mky3wOL2PFAdiR+8JSVS7PP/ugy8OQzAzq0+P00IUNzRuENEekW43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732106; c=relaxed/simple;
	bh=euqQrigYQEO2Nuzhe7As6KhlJU57iwzxOV0H2tzytvE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILm4RdDQApsEk5xOwzhI9W9doKdIGu+gTpquyZPOdG4kp/2vZ2IfyGN79Fz+BxdLCFOAFyB1rwO+w75lYUr0K/vimNlFF1uoFPKtt3HuipEnlY1taO6A472GdQ3sGNuGkrAuvogsIk4Pvv9KcqJkf8TTZyEwUhCKwM3YIfGFQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hvAxY6YE; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HMtinJ006033;
	Sun, 17 Mar 2024 20:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=b0SvvDipNi+3BeqAM1+L6/
	bF8BgJptUw4jkj7WuG7Fk=; b=hvAxY6YEN87CrNFcL5ETom5veanuK5l8VsYfgb
	R4qc+Pip6wS+xT50OvlcMUOcVpfZDdFsbQL628z0UvhEL0W6KLvepgRk3LADu3gk
	Wc16dt8piHaOSqb8mJZAuSyjH7kqPdHVhGiKj9hZaPQcXaLqI1AfUmD39HNJ9AJH
	Bj3hGju1defTwgJKDgsfPDpIOcyMzP1SoW1jeYGJhEJA/P7duqStBd0G6+59U/nv
	+6jfm0lj4XWJjP3/D7Zw7xSNn+J+8spuQ1HOufDwttuU3XwK8SYQKXEC5TguOyqn
	ztD5ED2ZDDDMXmaUKzJHqy4iupjuXQkbUZtHP8Z2fdT4t/aw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wwaxgbdt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 20:21:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 17 Mar 2024 20:21:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 17 Mar 2024 20:21:37 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 79F273F7065;
	Sun, 17 Mar 2024 20:21:34 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:51:33 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
Message-ID: <20240318032133.GA1312783@maili.marvell.com>
References: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>
X-Proofpoint-GUID: z6RW3vP--mhXmavzqM59jWGEEa_Xb4Rg
X-Proofpoint-ORIG-GUID: z6RW3vP--mhXmavzqM59jWGEEa_Xb4Rg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

On 2024-03-16 at 15:46:10, Christophe JAILLET (christophe.jaillet@wanadoo.fr) wrote:
> UTILITY_NAME_LENGTH is 16. So better use the former when defining the
> 'utility_name' array. This makes the intent clearer when it is used around
> line 260.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  net/caif/cfctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> index 8480684f2762..b6d9462f92b9 100644
> --- a/net/caif/cfctrl.c
> +++ b/net/caif/cfctrl.c
> @@ -206,7 +206,7 @@ int cfctrl_linkup_request(struct cflayer *layer,
>  	u8 tmp8;
>  	struct cfctrl_request_info *req;
>  	int ret;
> -	char utility_name[16];
> +	char utility_name[UTILITY_NAME_LENGTH];
Reverse xmas tree.

>  	struct cfpkt *pkt;
>  	struct cflayer *dn = cfctrl->serv.layer.dn;
>
> --
> 2.44.0
>

