Return-Path: <linux-kernel+bounces-158436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5128B2010
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907DB1C22A41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8824F84FB3;
	Thu, 25 Apr 2024 11:16:22 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678D1DDCE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043782; cv=none; b=EI2BBSZ0CuAVYf1UgiwE3LaBPHAwyoVr3fodqK93w9huObwV6mwznCRwkdOgvQnMbNXlUh4lbcX1f4knFNfBxh7KNKOu0yitecO46Aunc1y4636ejgvcVut36ObcWRV9vw0aP4WixeieNkcLImwphfsk64lTdPg4sdU3QLAYHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043782; c=relaxed/simple;
	bh=qWteCu7b7MmfkJU30E13yh/uXr9FlCF5c7d7LRLcQ/g=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=NK/oHiAR8Dxm8yphbPvbGwZxNISq5nLBJl9roFAEBqY/XzIRbXoiTuhg2pM/Zspo+inKP6OpUY34Y8vfB357BKMokn1oU7C/rDmkqJ7QbXsxXAbziO4z9M8yfOXEMaxeX8DHCPNdYzBl9N8rdYEddwK6dIRrhwHqnFSu/i/f5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQCrc4F3rzwTQh;
	Thu, 25 Apr 2024 19:13:04 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 780821401E9;
	Thu, 25 Apr 2024 19:16:16 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 25 Apr
 2024 19:16:15 +0800
Message-ID: <662A3B7F.4060003@hisilicon.com>
Date: Thu, 25 Apr 2024 19:16:15 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Huisong Li <lihuisong@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>
Subject: Re: [PATCH v2 0/2] soc: hisilicon: kunpeng_hccs: add dependency and
 enhance verification
References: <20240403081935.24308-1-lihuisong@huawei.com> <20240417094801.25393-1-lihuisong@huawei.com>
In-Reply-To: <20240417094801.25393-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi Huisong,

On 2024/4/17 17:47, Huisong Li wrote:
> Add PCC dependency and enhance verification during the probe phase.
> 
> ---
>  v2: fix the log on failure.
> 
> Huisong Li (2):
>   soc: hisilicon: kunpeng_hccs: Add the check for obtaining complete
>     port attribute
>   soc: hisilicon: kunpeng_hccs: replace MAILBOX dependency with PCC
> 
>  drivers/soc/hisilicon/Kconfig        | 2 +-
>  drivers/soc/hisilicon/kunpeng_hccs.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 

Thanks!
Series applied to the HiSilicon driver tree with minor changes in the commit msg:
https://github.com/hisilicon/linux-hisi/tree/next/drivers

Best Regards,
Wei

