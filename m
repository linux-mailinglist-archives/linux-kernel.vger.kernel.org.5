Return-Path: <linux-kernel+bounces-96510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CF7875D43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D482828D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08322E647;
	Fri,  8 Mar 2024 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Oa1zzPsK"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8512C1A6;
	Fri,  8 Mar 2024 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709873496; cv=none; b=TSAaTkDVUtXag/Sj/D585s0aAuHTkCxTowoupYRAPjDaKjNUPkZ0ikHUbAbjXfRJ1Ib3vPKAqGsNb/Pup4u6uaBmHfVAk49PixPNWSkIwnTo5YAO6+FV0z5tGEfLEUU6nkJWAZB9KVHNChIKdxhCyvdxpeznXbrgnMTBfXEIu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709873496; c=relaxed/simple;
	bh=5YjNoXGg6Bs8FmswpCrCP+Om2sTeGqLdQ+96OMKpJFs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T26aYC4sayvTgnkFUxEjMszqN0UjfY6NlCf/GY0iGo88rn5jDaRaX3d5C8eC9rk6B1vqPUZ5wVh94tEsEK/r2OrOVWG/VvYhhGS2HYB1g+xfll+97Msf93jmHqSV9Vpchk8XkxND/yz1N1eiuB4vvQh0lqIGXbYlQ5Zq/H2Ritc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Oa1zzPsK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427JDiLf022726;
	Thu, 7 Mar 2024 20:51:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=liNBfDir+IIS6IUcJjVY5WIWeMrz2msTky0/4R3OTKo=; b=Oa1
	zzPsKhJOayYQwbdr9ZkAYbuFKEoVevrDPS5TkQ+Wszp6LpNpHN37wE5CXC80Z8g/
	/8vNwOPkR9ejk6lCKdHbwMm0rLk8NLE0FJvPHmbr6M5/Vui7DEDvAy8u3MiPyHBQ
	WUxq3WlxN/6ZjfpKbxEQ4IghtpNTqtHd4xRyyilbg/ipH2qw6sans061Y9jyjbq/
	zg6wUr1npjZ2YApzfUTg8T9gBmfLJPH97+9YooWvjChFHWmpU95kAFNOTdT1vp36
	h4ODIwKJPNs2XwXFcluErr0xtJyTu2GWGexf5K0tMYXgZUHNfxiWN8hP8yz92mGR
	ZhGaj31J7QntNOTvVXg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wqkj61j6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 20:51:32 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 7 Mar 2024 20:51:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 7 Mar 2024 20:51:31 -0800
Received: from localhost.localdomain (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id DF9CD5B6930;
	Thu,  7 Mar 2024 20:51:29 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] net: phy: simplify a check in phy_check_link_status
Date: Fri, 8 Mar 2024 10:20:58 +0530
Message-ID: <20240308045058.1221154-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <de37bf30-61dd-49f9-b645-2d8ea11ddb5d@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VJQcQiyUU8Sal91s8wd6-8cgReF1Trvb
X-Proofpoint-ORIG-GUID: VJQcQiyUU8Sal91s8wd6-8cgReF1Trvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_03,2024-03-06_01,2023-05-22_02

On 2024-03-08 at 02:46:12, Heiner Kallweit (hkallweit1@gmail.com) wrote:
> Handling case err == 0 in the other branch allows to simplify the
> code. In addition I assume in "err & phydev->eee_cfg.tx_lpi_enabled"
> it should have been a logical and operator. It works as expected also
> with the bitwise and, but using a bitwise and with a bool value looks
> ugly to me.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index c3a0a5ee5..c4236564c 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -985,10 +985,10 @@ static int phy_check_link_status(struct phy_device *phydev)
>  		phydev->state = PHY_RUNNING;
>  		err = genphy_c45_eee_is_active(phydev,
>  					       NULL, NULL, NULL);
IMO, better to rename "err" to "ret", and do if (ret == true). OR,
we should fix syntax of genphy_c45_eee_is_active() to return bool (true/false)
than doing this, because function name suggest so , xxx_is_active(). err == 0, norm is
for success case.

> -		if (err < 0)
> +		if (err <= 0)
>  			phydev->enable_tx_lpi = false;
>  		else
> -			phydev->enable_tx_lpi = (err & phydev->eee_cfg.tx_lpi_enabled);
> +			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
>
>  		phy_link_up(phydev);
>  	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
> --
> 2.44.0

