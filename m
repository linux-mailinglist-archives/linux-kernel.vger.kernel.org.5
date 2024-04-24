Return-Path: <linux-kernel+bounces-156453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A64B8B02F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3A11C23064
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88DA360;
	Wed, 24 Apr 2024 07:17:06 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476F13D886;
	Wed, 24 Apr 2024 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943026; cv=none; b=iDSCSqPTbB0shWWSy1vK9OxRzrVCGVtL7vTe73V3XigQu9DS+i48YroedXtqobhVI9TbTlxUX75ZjRK6/EngYyV8XGyixIx65l/NT+Dl94rfx1BgnemBep5kaJiRmBi38/9oCxDga8RVd+lOz7zAqGmZTPdWWglqagDh/tcmzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943026; c=relaxed/simple;
	bh=K6m+iz3u8NxFxDy/IZv/WjFWFnBXtXfL2AxNjjSg5wA=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=q/3fdkW+vEVoSrrA8o9RZ4swFfVYtWLLXMgT6chMn93kwZYqKk6HWf9+TYqiU8G3FwyKFH180IaGb8+7YwrmRt3F7u4oFsoalnP1Iqg43QYTGAxeEyAIGbYpL7G6IMA2ZCsewdOGnj0K1e1IRQ8JJdlpRT8HgikwsUkURj2h9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VPVb6277zz1RDGb;
	Wed, 24 Apr 2024 15:13:54 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id B439218005F;
	Wed, 24 Apr 2024 15:16:58 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 24 Apr
 2024 15:16:58 +0800
Message-ID: <6628B1E9.1050300@hisilicon.com>
Date: Wed, 24 Apr 2024 15:16:57 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH 1/9] arm64: dts: hisilicon: hip05: move non-MMIO node
 out of soc
References: <20240402193148.62323-1-krzk@kernel.org> <171394159880.43787.12383182687947213751.b4-ty@linaro.org>
In-Reply-To: <171394159880.43787.12383182687947213751.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi Krzysztof,

On 2024/4/24 14:54, Krzysztof Kozlowski wrote:
> 
> On Tue, 02 Apr 2024 21:31:40 +0200, Krzysztof Kozlowski wrote:
>> Non-MMIO devices, which are BTW not really part of the SoC, should not
>> be within simple-bus, as reported by dtc W=1 warning:
>>
>>   hip05.dtsi:301.30-305.5: Warning (simple_bus_reg): /soc/refclk200mhz: missing or empty reg/ranges property
>>
>>
> 
> Almost a month passed, no replies from maintainers about picking it up. Dunno,
> looks abandoned, so let me grab this. If anyone else wants to pick it up, let
> me know.
> 

Sorry for the late reply!
I am applying these patches which are in the following git repo.
  https://github.com/hisilicon/linux-hisi/tree/next/dt64

And it is fine to me to go through your git tree.
Thanks!

Best Regards,
Wei

> Applied, thanks!
> 
> [1/9] arm64: dts: hisilicon: hip05: move non-MMIO node out of soc
>       https://git.kernel.org/krzk/linux-dt/c/8ff69c1d04c8f2381164c5f97781d9fe79f71761
> [2/9] arm64: dts: hisilicon: hip05-d02: correct local-bus unit addresses
>       https://git.kernel.org/krzk/linux-dt/c/4e0e9c0b311e599c78f63942256ccf03e5ebb0f5
> [3/9] arm64: dts: hisilicon: hip06: move non-MMIO node out of soc
>       https://git.kernel.org/krzk/linux-dt/c/2283b9afc1b43ec941c66665cdc86dd32f9c2295
> [4/9] arm64: dts: hisilicon: hip06: correct unit addresses
>       https://git.kernel.org/krzk/linux-dt/c/6c55978774fd66c720e20e1f88a2af7daaa382df
> [5/9] arm64: dts: hisilicon: hip07: move non-MMIO node out of soc
>       https://git.kernel.org/krzk/linux-dt/c/5e607ec42116e0ecb387e2db79a662333f789fa2
> [6/9] arm64: dts: hisilicon: hip07: correct unit addresses
>       https://git.kernel.org/krzk/linux-dt/c/76dce22bc7ec9483ef37899a617f2dfde2a382c0
> [7/9] arm64: dts: hisilicon: hi6220-hikey: add missing port@0 reg
>       https://git.kernel.org/krzk/linux-dt/c/d6fcc43f764630863e3888d0b5c3ff4a09a4f094
> [8/9] arm64: dts: hisilicon: hi6220-hikey: drop unit addresses from fixed regulators
>       https://git.kernel.org/krzk/linux-dt/c/e6a91e9f20058629dca4f0c264de092049bd8e74
> [9/9] arm64: dts: hisilicon: hi6220: correct tsensor unit addresses
>       https://git.kernel.org/krzk/linux-dt/c/83d4c5e2a529e3eebde5b4d75e3ec0fe2fc92440
> 
> Best regards,
> 

