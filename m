Return-Path: <linux-kernel+bounces-129568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A13896CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C69B28DDB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691721386A7;
	Wed,  3 Apr 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BQxZwLro"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE617BA8;
	Wed,  3 Apr 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140525; cv=none; b=XJiKHcISWwwTsFp/g22IMmGHuxco04aBzDcux+XSP1yr7NDhergcrCHAow6AWGxj1uLSUNxRp8yOCB5GpmN/WMDSdHaPAdcKJseQ34suart8E59/7yvVVg06hbgtegD2VblUOY+skAYPbe90BSjbemhGz+byCPn0TsarHOsDs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140525; c=relaxed/simple;
	bh=dxuPcDMSHg6WEwqpznWa9U8ja7BsjSSnId/aW7PBfYY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peCDn+kksfNkGJuO3KOhR7hIrhdHB+ENOhA3dGpSI1QviN5lj5EvwxQzpcrWKniOArmNabDB6+A6rRokUiRUxnEXRMiP748Lytxf6VJNPteHRLaz08vdhoIc3wevwXiViE7SNr7QtiHdSu+ruH4uFKJO2hm2aMXIjUE8ZMfVMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BQxZwLro; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43364Zua019128;
	Wed, 3 Apr 2024 03:35:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=c7ldmWssB6B+OJa6cGc2Lj
	S4gSz7Yqc8tAcVhXFWxd0=; b=BQxZwLro9yFL4FpWjqbCUrQu9/DDl6HdnIDA8D
	b5c3cH+LgeEWLtFbsNZJ5V+4oi8bsKqNhs5x0MVAYzfzK9xysVctWw09dPMFzLUM
	297ycZOtUgAzrIF/oiOnczH8n1HhF92aKY9Kd7B7RpBrs6b8bpTUS0jkTXc9Jyzs
	LUxNpKYDKEDnQ0vHIj0Z4waB7snEihXB380rHTFW64yhqEccbc16/30EvGm6EaJ7
	AOGvzOHELVR6764bjrk7bpJjaEqAZ2HYDokKKnCuFFw2bRRS8dXlvIzqBVqI2Ddv
	aIuFFuBOMEy3DpHajIPcSwlTMI6s89HdQfzmw3/7tbKKBOlA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x91h6gsp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 03:35:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 03:35:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 3 Apr 2024 03:35:05 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5772C3F7044;
	Wed,  3 Apr 2024 03:35:00 -0700 (PDT)
Date: Wed, 3 Apr 2024 16:04:59 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Vladimir
 Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun
 Ramadoss <arun.ramadoss@microchip.com>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, David Ahern <dsahern@kernel.org>,
        Simon
 Horman <horms@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v2 2/9] net: dsa: microchip: add IPV information
 support
Message-ID: <20240403103459.GA1654809@maili.marvell.com>
References: <20240403092905.2107522-1-o.rempel@pengutronix.de>
 <20240403092905.2107522-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240403092905.2107522-3-o.rempel@pengutronix.de>
X-Proofpoint-ORIG-GUID: dYiCHvOCuwTLy81e6vH58KvuzxAt7XsV
X-Proofpoint-GUID: dYiCHvOCuwTLy81e6vH58KvuzxAt7XsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_09,2024-04-01_01,2023-05-22_02

On 2024-04-03 at 14:58:58, Oleksij Rempel (o.rempel@pengutronix.de) wrote:
> Most of Microchip KSZ switches use Internal Priority Value associated
> with every frame. For example, it is possible to map any VLAN PCP or
> DSCP value to IPV and at the end, map IPV to a queue.
>
> Since amount of IPVs is not equal to amount of queues, add this
> information and make use of it in some functions.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> ---
>
>  	dev->dev_ops->enable_stp_addr(dev);
>
> +	/* Make sure driver provide plausible queue and IPV values */
> +	if (!dev->info->num_tx_queues ||
> +	    dev->info->num_tx_queues > dev->info->max_ipvs) {
> +		dev_err(dev->dev, "Number of TX queues exceeds maximum supported IPVs\n");
if dev->info->num_tx_queues == 0, error message seems to be wrong.

> +		return -EINVAL;
> +	}
>
>  #define KSZ9477_PORT_TC_MAP_S		4
> -#define KSZ9477_MAX_TC_PRIO		7
>
>  /* CBS related registers */
>  #define REG_PORT_MTI_QUEUE_INDEX__4	0x0900
> --
> 2.39.2
>

