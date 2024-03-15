Return-Path: <linux-kernel+bounces-104154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0287C9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4BD1F23270
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B1168DE;
	Fri, 15 Mar 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+tIHes/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BE15AE0;
	Fri, 15 Mar 2024 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490747; cv=none; b=vF33pvoKr65fsgrMA36SwrBwyvSyGE/dDnUsmBh4G+vInzTPi6RAZxRhQulFALbECWhD4P0Hqi/Kt17b0LjEfJQ12Fxm43CInHEhHTOyVE63PKfcmx0EYqFZbEGwXoQBRH8HGQ3x8Izz0zXbp92BfoiwyqA8bWzO8O+w9UDidDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490747; c=relaxed/simple;
	bh=/eKPOjIMzBEqqdf481aoLuRA42OFb7oCAyDNb31yBt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4/ayBmt3KlUJ27XEgELvwabBjI+27q0aoxoR965RUtFiBV0+LmKt61soEpuSxxb5NgPOM8hlWIfRyUfiBimLxWGXe4BhLKTNMPwKlHflH1yf5sQQl6IIvS8ADLk/C1KNFWwqCWr0zQe7tRsI2ODG9UszZa3IH08hi2FzqlnCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+tIHes/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8475EC433C7;
	Fri, 15 Mar 2024 08:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710490747;
	bh=/eKPOjIMzBEqqdf481aoLuRA42OFb7oCAyDNb31yBt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b+tIHes/7nOkDS7dxeJm8C6GAQoK+SGnAhxi3W06JsHEEleW8rRtRvjMo6vW/wGil
	 iKFeHErxfzh55jV2f89qVKAVFzdElDPYzLbfcOw3Oo3VW1wa30a3WFdOKCNsCLS2kT
	 WUAwlWYbfMteaBBWzbaC0hSPIAH02HwoPXO6Ms+i8IGwFfyHji29MUS6f1sHWpn67W
	 8nenEV9NH0t8q4S2FtSCV4FT6WxWBwt0046ySc731HDZefbrB0McXYD6c9GUTi4Bo/
	 WsdQev6Sb4C6zYaB2s3IxITTzNpa2AJxw5BlGhhZYBgdNriu7H8OCTH+YYcmz2XK1n
	 LYvP02JH1Ltfw==
Message-ID: <2b0511af-1b5b-4c90-a673-c9113bb58142@kernel.org>
Date: Fri, 15 Mar 2024 17:19:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for
 K230
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
 <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
 <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>
 <20240305-fascism-enrich-06483ddeb149@spud>
 <311bdf17-c16f-41d8-8366-10f9b00adf27@kernel.org>
 <tencent_FF86EF51905CFBDF1102F721663984B2F105@qq.com>
 <tencent_9543398AE3BAC424842837CEF01508D6680A@qq.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <tencent_9543398AE3BAC424842837CEF01508D6680A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 01:56, Yangyu Chen wrote:
>> Hi,
>>
>> Thanks for the review comments. After thinking about it for a while,
>> I think we don't need to change it as we have changed the help
>> message which deleted the "K210". And the dts on k210.dtsi shows
>> mmu-type is riscv.none, I think if someone noticed this would know
>> why it fails to boot on the S-Mode MMU Kernel on K210. The only
>> special thing for ARCH_CANAAN is that a loader.bin will be built
>> when M-Mode is on arch/riscv/Makefile. However, Canaan has no other
>> M-Mode chips except for K210. So I think we don't need to change
>> it.

You completely lost me here. I do not understand what you are trying to say.

>> Another reason is that SOC_CANAAN for K210 is somehow hard to change.
>> If we continue using SOC_CANAAN for K210 but not for other Canaan
>> SoCs such as K230, it will cause some confusion to users. If we
>> rename SOC_CANAAN to SOC_CANAAN_K210, it will change many drivers
>> in many subsystems like my patch v5 [1]. So I don't think we need
>> to fix it.
>>
>>
>> If we don't change it, A concern for this is that some drivers for
>> K210 will be built when SOC_CANAAN=y and if we add this to defconfig,
>> all riscv builds will also build some K210 drivers even on MMU. But
>> I think this will not be a problem just need some memory/storage
>> for a slightly bigger kernel. Also, we will enable some new configs
>> in defconfig when a new soc gets supported, it's normal for K210
>> SoC drivers.
>>
>> Thus, I think we don't need to change it. If you have some other
>> opinions, please let me know.

1) Rename SOC_CANAAN to SOC_CANAAN_K210 and use that for any conditional code or
driver selection that is specific to the K210, which is what's done now.
2) Create a "new" SOC_CANAAN config and make SOC_CANAAN_K210 depend on it and on
!MMU

You could also add SOC_CANAAN_K230 if needed and make it depend on SOC_CANAAN &&
MMU.

With that, dirvers common to both the K210 and K230 can easilly be selected and
selecting SOC_CANAAN will end up either building for the K230 or the K210,
depending on MMU being set or not.

That's my 2 cents. Feel free to ignore. I am not involved that much with riscv
these days and I am far too busy with other kernel areas to be of any help. But
I really think that allowing building the K210 when MMU is enabled and "hoping
that the user understand his mistake" is not a great approach.

-- 
Damien Le Moal
Western Digital Research


