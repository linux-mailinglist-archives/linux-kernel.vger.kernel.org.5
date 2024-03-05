Return-Path: <linux-kernel+bounces-92358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23626871F12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF91C1F25C3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0DA5A4FF;
	Tue,  5 Mar 2024 12:24:40 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AF5A4D3;
	Tue,  5 Mar 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641480; cv=none; b=FRSTodWxAZKvYvv+mOkRFSVnK/RC+VEbIhGvplVwp3AeoU3OflsuupDNAkJRoHymLhuykyIxU5DVU2TxjA8ysxtFFZHIqkECNczDQy0/o5ulLyBQfQlDHsQ0pgr0NNeWzvjhfH9U5UydrC4LRZfX9DRi0W6fdJFn0qPjGgbkykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641480; c=relaxed/simple;
	bh=PohRUNojA0onN5wbko1v5Ue/xtz3QezDL8uESVZypJU=;
	h=CC:Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PD42iOAqUlWGnmZNqf6pOFRYCoHRJfxeqEv8XHqILcjzn1Ij2jxWigPRSHvuG3yRjBDiszLt4G/ufoHJgLgy5PwRgY+5HddDxUcDsaUyqr2SYQWubi+3WRAbxt/iwtMiaY3D324mlwVmQELjo/LzTJhYBcEf2BevH3Cw3NhNIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tpvqm3PSnz1vw63;
	Tue,  5 Mar 2024 20:23:48 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AD0D1A016C;
	Tue,  5 Mar 2024 20:24:28 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 20:24:28 +0800
CC: <hejunhao3@huawei.com>, <yangyicong@hisilicon.com>
Subject: Re: [PATCH -next] drivers/perf: hisi: Fix build warning of
 hisi-pcie-pmu.rst
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <sfr@canb.auug.org.au>, <linux-kernel@vger.kernel.org>,
	<linux-next@vger.kernel.org>
References: <20240305121003.4497-1-yangyicong@huawei.com>
Message-ID: <071459df-223a-516f-2300-f013e3ddc1c9@huawei.com>
Date: Tue, 5 Mar 2024 20:24:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305121003.4497-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)

The subject should be:

docs: perf: hisi: Fix build warning of hisi-pcie-pmu.rst

Will get this fixed. Sorry for the mistake.

On 2024/3/5 20:10, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> `make htmldocs SPHINXDIRS="admin-guide"` shows below warnings:
> Documentation/admin-guide/perf/hisi-pcie-pmu.rst:48: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/hisi-pcie-pmu.rst:49: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fix this.
> 
> Closes: https://lore.kernel.org/lkml/20231011172250.5a6498e5@canb.auug.org.au/
> Fixes: 89a032923d4b ("docs: perf: Update usage for target filter of hisi-pcie-pmu")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  Documentation/admin-guide/perf/hisi-pcie-pmu.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> index 678d3865560c..5541ff40e06a 100644
> --- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> @@ -44,6 +44,7 @@ The related events usually used to calculate the bandwidth, latency or others.
>  They need to start and end counting at the same time, therefore related events
>  are best used in the same event group to get the expected value. There are two
>  ways to know if they are related events:
> +
>  a) By event name, such as the latency events "xxx_latency, xxx_cnt" or
>     bandwidth events "xxx_flux, xxx_time".
>  b) By event type, such as "event=0xXXXX, event=0x1XXXX".
> 

