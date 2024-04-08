Return-Path: <linux-kernel+bounces-134998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69BA89B9C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1358E1C2209F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB83A27E;
	Mon,  8 Apr 2024 08:10:01 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B637714;
	Mon,  8 Apr 2024 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563800; cv=none; b=FrUPMcbTjQyHxejL4wtXkMrlswtb5rc/14fOyGFJY0bwqEaJn24555RPsMx95SgxUAZhGj5E52yOzlQJB3JTwtYnZJXUw/Nx++0NFplQ1aKeJnjHP75jih4rUkUTv8oUqFuubLQR4kNVXjjFUTikp1xDRnUb33/VzJmWH/jBcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563800; c=relaxed/simple;
	bh=pWtcmGsxyIKVFZBiCnrSuEFJOUkya1JEC0H7DAF8vzc=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=ijHfR3o7kch56DXpkiqeUFZeoOrS25o69Rq7Nig67DHcuiWNCuSMXu1xjahoE2WHs/hbHMQ9Fvwi3Y1HmIiqz3IyoCvILnhXoiQvRLs/xRBNS+a+pYz0Yq1g3T2hosvz9T3FQfxXdpKszRP30hjjYbhJjNZWZFwUdiO3vKAbuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VChWw6bXzztS00;
	Mon,  8 Apr 2024 16:07:08 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 985B31401E9;
	Mon,  8 Apr 2024 16:09:49 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 8 Apr
 2024 16:09:48 +0800
Message-ID: <6613A639.1070009@hisilicon.com>
Date: Mon, 8 Apr 2024 16:09:29 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>, Yang Xiwen
	<forbidden405@outlook.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com> <171256140981.12523.5652563259173425537.b4-ty@linaro.org>
In-Reply-To: <171256140981.12523.5652563259173425537.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi Krzysztof,

On 2024/4/8 15:31, Krzysztof Kozlowski wrote:
> 
> On Mon, 19 Feb 2024 23:05:25 +0800, Yang Xiwen wrote:
>> The patchset fixes some warnings reported by the kernel during boot.
>>
>> The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
>> 2.2.1 Master Processor.
>>
>> The cache line size and the set-associative info are from Cortex-A53
>> Documentation [2].
>>
>> [...]
> 
> It's rc3 and almost one month after last ping/talk, so apparently these got
> lost. I'll take them, but let me know if this should go via different tree.
> 
> 
> Applied, thanks!

Thanks!
Fine to me.

Best Regards,
Wei

> 
> [1/3] arm64: dts: hi3798cv200: fix the size of GICR
>       https://git.kernel.org/krzk/linux-dt/c/428a575dc9038846ad259466d5ba109858c0a023
> [2/3] arm64: dts: hi3798cv200: add GICH, GICV register space and irq
>       https://git.kernel.org/krzk/linux-dt/c/f00a6b9644a5668e25ad9ca5aff53b6de4b0aaf6
> [3/3] arm64: dts: hi3798cv200: add cache info
>       https://git.kernel.org/krzk/linux-dt/c/c7a3ad884d1dc1302dcc3295baa18917180b8bec
> 
> Best regards,
> 

