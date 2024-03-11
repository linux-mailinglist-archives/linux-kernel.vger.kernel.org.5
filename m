Return-Path: <linux-kernel+bounces-98909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F518780EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3392847A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821B3FB3D;
	Mon, 11 Mar 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GayqSF/P"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4541757;
	Mon, 11 Mar 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165110; cv=none; b=UpTlsEmEIkfao2HQmYScG/3tpZDs8AIPPXvoQQS2se4aMu+S0cEmajGyQczA3C1kE4JcVsdGCiAmW/4eSuTSHS5FTKEF/ak5c19HQrWl2sGCpPzzAVOLIxVbFKI02l/qCgFBzn6sNMda1Uj6BaKSdQYvy8Ufq+UwpokdOJxTbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165110; c=relaxed/simple;
	bh=zxZluahLEq/YKoQv3psEqHhhVo0QQCglDTn7W6G06nI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrYVSIduHR0YAq/FfiX7vd0T3oAAvJ/3zfEwwxoNJGE9PoW3huVnZs4mSFbsLSXwLfiZ3fOFBzyUm1ir/ZrgA6GJe+cHd0wa4qu7y4a/DTApIVnG2Jl7zWdDX6sJiPr2bYnNKLz1SxKvs1SLSgdd1Pax4xA537DiQHWX/73vv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GayqSF/P; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9mtR1016550;
	Mon, 11 Mar 2024 06:51:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=g7u7HGcDuntbzpf4OiSYBE
	y5uIO87+GTfTG2uMmDEvs=; b=GayqSF/P7YI+fmk38/4Rb4845lszsFQ1ZKxamx
	2Ule4X2/1S8LAV1cqxoPcu4CCukJowd1oBdhboA7PiOSVF9XE+YmbxKD8sCOTNNP
	bqalvh/jfpV0MIBozpjYznwVMVrXt64Mknv3Hrn7rCPgcF7XwYSfQxnSDCqWp32c
	DYyhZXqeSkR/D35sxo8Rf9jxAYbF/BVePp2nXgN72Ln+DMSIqS0MtIXMjCRHdbCE
	EQH8hdv+xDhCxb3D5GYa3+vRzzlFY7cTZsoECcm/1ybGsp3TDwcCT2i0CXAvj+Ok
	XwirLjdLxD7JyyEFESlIOI69MccWaAQ9FFWvBUCeJkTRpgBg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wsynb0ngw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 06:51:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 06:51:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 11 Mar 2024 06:51:20 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6C3453F70A1;
	Mon, 11 Mar 2024 06:51:18 -0700 (PDT)
Date: Mon, 11 Mar 2024 19:21:17 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Zheng Li <lizheng043@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <nhorman@tuxdriver.com>, <davem@davemloft.net>, <jmorris@namei.org>,
        <James.Z.Li@Dell.com>
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
Message-ID: <20240311135117.GA1244788@maili.marvell.com>
References: <20240311122401.6549-1-lizheng043@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311122401.6549-1-lizheng043@gmail.com>
X-Proofpoint-GUID: vEm6exLG96jF8wXibii2YyQBRIzmx-lw
X-Proofpoint-ORIG-GUID: vEm6exLG96jF8wXibii2YyQBRIzmx-lw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02

On 2024-03-11 at 17:54:01, Zheng Li (lizheng043@gmail.com) wrote:
>
> Inter-process communication on localhost should be established successfully even the ARP table is full,
> many processes on server machine use the localhost to communicate such as command-line interface (CLI),
> servers hope all CLI commands can be executed successfully even the arp table is full.
> Right now CLI commands got timeout when the arp table is full.
> Set the parameter of exempt_from_gc to be true for LOOPBACK net device to
> keep localhost neigh in arp table, not removed by gc.
>
> the steps of reproduced:
> server with "gc_thresh3 = 1024" setting, ping server from more than 1024 IPv4 addresses,
> run "ssh localhost" on console interface, then the command will get timeout.
it does not look correct to me. why gc has to behave differently for loopback devices.
why can't a higher gc_thresh3 value (fine tuned to your use case) wont solve the issue ?
can't you add localhost arp entry statically and get rid of gc issue ?

>
> Signed-off-by: Zheng Li <James.Z.Li@Dell.com>
> ---
>  net/core/neighbour.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 552719c3bbc3..d96dee3d4af6 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -734,7 +734,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
>  struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
>  				 struct net_device *dev, bool want_ref)
>  {
> -	return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
> +	if (dev->flags & IFF_LOOPBACK)
> +		return ___neigh_create(tbl, pkey, dev, 0, true, want_ref);
> +	else
> +		return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
>  }
>  EXPORT_SYMBOL(__neigh_create);
>
> --
> 2.17.1
>

