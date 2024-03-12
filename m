Return-Path: <linux-kernel+bounces-100225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D788793B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5C3B2264D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B87A157;
	Tue, 12 Mar 2024 12:01:05 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE57A140;
	Tue, 12 Mar 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244865; cv=none; b=aiioAUYvzk6pV1tJtf76Ww6uLCxGkE2EiADHF6rD1ar2kEvuTCIB4kadeyrdMmlnSaG5kJ4CoKQ2fDGNOhlwWdE7WNBX6SZP1lanWmAniElcPQD0QLURB9m5MfR7rnenAtfkgKLK09Czwbd8m3wrXez/yzfsrYdjHg9UXhggVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244865; c=relaxed/simple;
	bh=ePk5iQwBef/BCg5M8C1xgxE/8EWgCoYElleiuQnLZ3E=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=uJyYp5HvAce+nDGjfEHAeuEXewc5ukwRLnm+BkGZ5PRv8lKYjld2qF8m3SkrDxBhvV6gmPA3G2eM+ZbHy2wvJWXxwD6EykCOfyvpIfU81gXKJ/x5nehDXaiXkyO/mhM/krrp25Z0lUILmRmbsavJXGJN10kLUpjdt7eFFFIw8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TvBxF4bSJz1Z1w9;
	Tue, 12 Mar 2024 19:58:25 +0800 (CST)
Received: from kwepemd100008.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 6591914040F;
	Tue, 12 Mar 2024 20:00:52 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd100008.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 12 Mar
 2024 20:00:51 +0800
Message-ID: <65F043F3.3040908@hisilicon.com>
Date: Tue, 12 Mar 2024 20:00:51 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yang Xiwen
	<forbidden405@outlook.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder
	<elder@linaro.org>, Peter Griffin <peter.griffin@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com> <SEZPR06MB695952078B51C4549191F8AB962B2@SEZPR06MB6959.apcprd06.prod.outlook.com> <dbdce27e-f33a-4597-b978-965c395c7169@linaro.org>
In-Reply-To: <dbdce27e-f33a-4597-b978-965c395c7169@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100008.china.huawei.com (7.221.188.193)

Hi Krzysztof,

On 2024/3/12 19:36, Krzysztof Kozlowski wrote:
> On 12/03/2024 12:19, Yang Xiwen wrote:
>>> Yang Xiwen (3):
>>>        arm64: dts: hi3798cv200: fix the size of GICR
>>>        arm64: dts: hi3798cv200: add GICH, GICV register space and irq
>>>        arm64: dts: hi3798cv200: add cache info
>>>
>>>   arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 43 +++++++++++++++++++++++++-
>>>   1 file changed, 42 insertions(+), 1 deletion(-)
>>> ---
>>> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
>>> change-id: 20240218-cache-11c8bf7566c2
>>>
>>> Best regards,
>>
>> May someone apply this patchset to their tree so that it can land in 
>> stable at the end? This is a fix, not adding new functionalities. It's 
>> been 2 weeks already.
> 
> It's merge window, what do you expect to happen now? Please observe the
> process timelines.
> 
> For arm-soc usually the cut-off is around rc6. When did you send it?
> Week before rc6, so a bit late.
> 
> Anyway, I bookmarked this patchset, so if no one applies within some
> time after merge window, I'll take it.

Thanks for your explanation and kindness!

Best Regards,
Wei

> 
> Best regards,
> Krzysztof
> 
> .
> 

