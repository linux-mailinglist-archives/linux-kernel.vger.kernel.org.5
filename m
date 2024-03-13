Return-Path: <linux-kernel+bounces-101556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A7087A8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CCC1F2486B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8224437D;
	Wed, 13 Mar 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aiFrZAyj"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DFE4120B;
	Wed, 13 Mar 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337535; cv=none; b=dJs9EnGPoIjgVkNNTLowRMIPWt3rLN1M0IULFr3x6tna/5N2MX/x+DMw7nSSPzI3SKpwm3nKiy748HzfBhdeW5iNe4GfPGxbSbWWqYgQm9dEuiFoYQZ4mS4oYHZUcgRMSUJyvm/sy9ove5uAUDrXSFMmzh/WWMlJIOrr/mmI+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337535; c=relaxed/simple;
	bh=WeOGJedFmOM2Tgb4d1S3JinQzz4nZviTh118O1gKX1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKunXNDvuxL4uL1cWxIE4isq/NNCSbpHbM1JL/2EAvgPY5RDmN/A5mPApEnOkd4SzK0UulDH080d4K1eOyVL9AwA+gsYFPsq3ZAr1mkdgjvNRo1235gc5fwIyku9pYG6alr09VDin/BTL8TTBQvQMOM5mSUaBD5tByHIfoTWPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aiFrZAyj; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DCnvlb016200;
	Wed, 13 Mar 2024 06:44:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=VwuvIBp1UpDExbuSxSKOlP
	wsFLpAOE9AYw6mEBoQvp8=; b=aiFrZAyj1AcWXCRSRkWzRXR9iU7achTNcubWf/
	HnaZBig1tmq8DhuJhVS8RNmEColRN5JxuwFTRTMFVJ2Y4I/vwvXdSpNp7oMIb/Ka
	ADrchOCED650x9vCEVM2FhN38jqAyMuZc8YGdxbjlrkWKK/yJmqJiSYKJDkABpRW
	5YfZW4RXfDF3mjJMhYNgwMfqS7sc/UngRNGCm5TcNC/UjUn41uIC+qBVOo0tnU1c
	brBmMVL/4CpdDtywZjUqG4poI8gfuRSRb8c4EsCpirh4HDWglDB3l0q3e9DpOjP2
	7qVgnG997jmN8ytlJ0kcko012RMiDVJiDKfsO3CBGALNLUrg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wucg2r6nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 06:44:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 13 Mar 2024 06:44:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 13 Mar 2024 06:44:48 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5879A3F704F;
	Wed, 13 Mar 2024 06:44:42 -0700 (PDT)
Date: Wed, 13 Mar 2024 19:14:41 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Julien Panis <jpanis@baylibre.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard
 Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sumit
 Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v4 0/3] Add minimal XDP support to TI AM65 CPSW Ethernet
 driver
Message-ID: <20240313134441.GA1263398@maili.marvell.com>
References: <20240223-am65-cpsw-xdp-basic-v4-0-38361a63a48b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v4-0-38361a63a48b@baylibre.com>
X-Proofpoint-ORIG-GUID: G5PU32WzbO9uPZplymCr0TA-d_XXXYnV
X-Proofpoint-GUID: G5PU32WzbO9uPZplymCr0TA-d_XXXYnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_08,2024-03-12_01,2023-05-22_02

On 2024-03-12 at 18:52:39, Julien Panis (jpanis@baylibre.com) wrote:
> This patch adds XDP support to TI AM65 CPSW Ethernet driver.

is this a net-next item ?

>
> The following features are implemented: NETDEV_XDP_ACT_BASIC,
> NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.
>
> Zero-copy and non-linear XDP buffer supports are NOT implemented.
>
> Besides, the page pool memory model is used to get better performance.
>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
> Changes in v4:
> - Add skb_mark_for_recycle() in am65_cpsw_nuss_rx_packets() function.
> - Specify napi page pool parameter in am65_cpsw_create_xdp_rxqs() function.
> - Add benchmark numbers (with VS without page pool) in the commit description.
> - Add xdp_do_flush() in am65_cpsw_run_xdp() function for XDP_REDIRECT case.
> - Link to v3: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com
>
> Changes in v3:
> - Fix a potential issue with TX buffer type, which is now set for each buffer.
> - Link to v2: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com
>
> Changes in v2:
> - Use page pool memory model instead of MEM_TYPE_PAGE_ORDER0.
> - In am65_cpsw_alloc_skb(), release reference on the page pool page
> in case of error returned by build_skb().
> - [nit] Cleanup am65_cpsw_nuss_common_open/stop() functions.
> - [nit] Arrange local variables in reverse xmas tree order.
> - Link to v1: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com
>
> ---
> Julien Panis (3):
>       net: ethernet: ti: Add accessors for struct k3_cppi_desc_pool members
>       net: ethernet: ti: Add desc_infos member to struct k3_cppi_desc_pool
>       net: ethernet: ti: am65-cpsw: Add minimal XDP support
>
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 536 +++++++++++++++++++++++++---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  13 +
>  drivers/net/ethernet/ti/k3-cppi-desc-pool.c |  36 ++
>  drivers/net/ethernet/ti/k3-cppi-desc-pool.h |   4 +
>  4 files changed, 539 insertions(+), 50 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240223-am65-cpsw-xdp-basic-4db828508b48
>
> Best regards,
> --
> Julien Panis <jpanis@baylibre.com>
>

