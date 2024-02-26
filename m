Return-Path: <linux-kernel+bounces-81781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B1867A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9D82A32A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7912AAD6;
	Mon, 26 Feb 2024 15:18:54 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC49605D5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960734; cv=none; b=lTXcfbMdtxLMmDfQSCKtVub0PRJYm/Bh6IFWdQ8rki/VVzYi0ybJWyYzHin3KzkyDUKlWwjQrLmndjTwuFijcaC0EbK6BTQ13OsCx0xSw3h6rV2MwmoGVgMYG2GWKzOh9bSB4eTRhWjDj2w9X/ybjc6nIkSj47QqerI06cE854g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960734; c=relaxed/simple;
	bh=vS9ppAlEeGRg+Ftxbz0cFjl0VgM8GrBZC+p1kJ9tmt4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ii6/LGwfB8BxA6dsUqduIo5SiZM7PhFAHk43B8sBu2gNGkKaB80/JyNRKCrXCmrIJWNBGmLyplM7CLfqRQcLrti1pgYU9AYmQ4nhALcDnqFESuqfBgoGmSO4e413+Zwnk7GKKLQh9+ETUP2ZHrPuLAa47UgaxxINCiLRrrUzXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk4081JPBz6JBV0;
	Mon, 26 Feb 2024 23:14:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 91128140A70;
	Mon, 26 Feb 2024 23:18:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:18:50 +0000
Date: Mon, 26 Feb 2024 15:18:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v2 7/8] drivers/perf: hisi_pcie: Merge
 find_related_event() and get_event_idx()
Message-ID: <20240226151849.00004d17@Huawei.com>
In-Reply-To: <20240223103359.18669-8-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
	<20240223103359.18669-8-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 18:33:58 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> The function xxx_find_related_event() scan all working events to find
> related events. During this process, we also can find the idle counters.
> If not found related events, return the first idle counter to simplify
> the code.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Seems like a small optimization, but worthwhile.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


