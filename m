Return-Path: <linux-kernel+bounces-36006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024EA8399FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F251C27990
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72F82D95;
	Tue, 23 Jan 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyYcwTIr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4582D89;
	Tue, 23 Jan 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040445; cv=none; b=lORvcEz1Mz3YSIULpDg9JMZY3LvbdxQvfaOeFxQjWX5/r7EJ9wKKaFevTS0pLloPyXZiqbpjKyZYFrwUWzd4W2Zj9XGCq3WFMj7njjcu+jTHZepDZ8Wi4lSO/YaqlcibLKtandql47sdEFGSZl0fsnZiKkOU9tJVmbGlLyWgopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040445; c=relaxed/simple;
	bh=qrTeZ90kKPIGHQj7Duz55R7K3bWxn9tvPLy0f4FBIh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAMUWPpCCI5S2jkxCjDL4u6jtnKx3xk+FYMnHSffuJTVP9PrhG+6TA6Zad5/hB9sjhvkTPHiCalFvqg9SKPQ1JGGrXTdIi6QlTPfmmZpqGlRE23oeZsxQxSQ7T65B1SAzvPvlHmy11BXX88dASPGsssjF4eowtoPrWvkMDz6Lyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyYcwTIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F66C433C7;
	Tue, 23 Jan 2024 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706040444;
	bh=qrTeZ90kKPIGHQj7Duz55R7K3bWxn9tvPLy0f4FBIh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lyYcwTIr2hK9QPWsLjktNe77EKjomPt43dViYbpzFU8v2prv6n22QxXcwo57Dyxx7
	 +jeXGJyVro1ruwRCVSZztVV37pWrdeJ7OZNq+R1HciKQttk4O0fUbQr01bpayzMZlX
	 KmOgx2l9400a9/bcNO4Fc+QQ2uvZtCCbegwBRQw9TC6dSigsbt2MhJZe+g5jU4SrLM
	 btaa43cP2JaYQU8ABAXfS47B2NNJW2undFZY9mDFdvWHn0yYYfx37db1dUOW53aSR0
	 Z9BQKlPHQ5hVByEIQmFOZy9F04dELGFTEBSeEdkGXoesNGVYD7ZnLaYBfWijZKkWE2
	 utvXdqqKeWy1g==
Message-ID: <9185e0b8-5e72-4b53-830b-bc2fb99ad76a@kernel.org>
Date: Tue, 23 Jan 2024 22:07:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: am642-evm: Add overlay for NAND
 expansion card
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
Cc: vigneshr@ti.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, srk@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20230920133450.54226-1-rogerq@kernel.org>
 <20230920133450.54226-3-rogerq@kernel.org>
 <20230920135802.3ej2wcuaruqjidel@uncouth>
 <e8f26137-1284-4f45-a74d-a0a5f2aa2f93@kernel.org>
 <20230920164424.rrjvm6nvtv4ysyrw@unreal>
 <c7ec6ccd-37de-244d-0b3b-cb5d13bae539@ti.com>
 <6f2b38f8-1962-46f2-a095-b1eaf99ed407@kernel.org>
 <f79f521b-bfaf-27d2-f152-2f2f21d6f2b7@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <f79f521b-bfaf-27d2-f152-2f2f21d6f2b7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 21/09/2023 20:23, Andrew Davis wrote:
> On 9/21/23 6:37 AM, Roger Quadros wrote:
>> On 20/09/2023 20:06, Andrew Davis wrote:
>>> On 9/20/23 11:44 AM, Nishanth Menon wrote:
>>>> On 18:18-20230920, Roger Quadros wrote:
>>>>>
>>>>>
>>>>> On 20/09/2023 16:58, Nishanth Menon wrote:
>>>>>> On 16:34-20230920, Roger Quadros wrote:
>>>>>>> The NAND expansion card plugs in over the HSE (High Speed Expansion)
>>>>>>> connector. Add support for it.
>>>>>>>
>>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>>>> ---
>>>>>>>    arch/arm64/boot/dts/ti/Makefile               |   1 +
>>>>>>>    arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 140 ++++++++++++++++++
>>>>>>>    2 files changed, 141 insertions(+)
>>>>>>>    create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>>>>>> index 06d6f264f292..ece74085a6be 100644
>>>>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>>>>> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
>>>>>>>      # Boards with AM64x SoC
>>>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>>>>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtbo
>>>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>>>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>>>>>>>    dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
>>>>>>
>>>>>> Also see https://lore.kernel.org/all/20230911165610.GA1362932-robh@kernel.org/
>>>>>>
>>>>>> you may not get the dtbo installed when doing make dtbs_install
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>
>>>>> $ v8make dtbs_install INSTALL_DTBS_PATH=/tmp
>>>>>     INSTALL /tmp/ti/k3-am625-beagleplay.dtb
>>>>>     INSTALL /tmp/ti/k3-am625-phyboard-lyra-rdk.dtb
>>>>>     INSTALL /tmp/ti/k3-am625-sk.dtb
>>>>>     INSTALL /tmp/ti/k3-am625-verdin-nonwifi-dahlia.dtb
>>>>>     INSTALL /tmp/ti/k3-am625-verdin-nonwifi-dev.dtb
>>>>>     INSTALL /tmp/ti/k3-am625-verdin-nonwifi-yavia.dtb
>>>>>     INSTALL /tmp/ti/k3-am625-verdin-wifi-dahlia.dtb
>>>>>     INSTALL /tmp/ti/k3-am625-verdin-wifi-dev.dtb
>>>>>     INSTALL /tmp/ti/k3-am625-verdin-wifi-yavia.dtb
>>>>>     INSTALL /tmp/ti/k3-am62-lp-sk.dtb
>>>>>     INSTALL /tmp/ti/k3-am62x-sk-hdmi-audio.dtbo
>>>>>     INSTALL /tmp/ti/k3-am62a7-sk.dtb
>>>>>     INSTALL /tmp/ti/k3-am62p5-sk.dtb
>>>>>     INSTALL /tmp/ti/k3-am642-evm.dtb
>>>>>     INSTALL /tmp/ti/k3-am642-evm-nand.dtbo
>>>>> ^^^^
>>>>>     INSTALL /tmp/ti/k3-am642-phyboard-electra-rdk.dtb
>>>>>     INSTALL /tmp/ti/k3-am642-sk.dtb
>>>>>
>>>>>
>>>>> What did I miss?
>>>>
>>>> I missed it, actually. See Rob's comment:
>>>> https://lore.kernel.org/all/CAL_Jsq+GR3hP6hFvFn2z5aXvSXnh9butD3aKZ-y_XJgx0_YPTw@mail.gmail.com/
>>>>
>>>> Having orphan dtbo is apparently frowned upon
>>>>
>>>
>>> And if you apply these overlays to the base DTB then it gets
>>> symbols added automatically, no need for your patch [1/2] here.
>>>
>>
>> Is this OK?
>>
>>     k3-am642-evm-nand-dtbs := k3-am642-evm.dtb k3-am642-evm-nand.dtbo
>>     dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtb
>>
>> So patch 1 is not required in this case but we have an
>> extra dtb file which is not really required.
>>
> 
> While I agree we will end up with several pre-overlayed DTB files
> that are arguably not required as they could be later built/applied,
> until we find a better way to check at build time these overlays
> need applied to something as a test.
> 
>> I have 2 more issues to point out
>>
>> 1)
>> With existing examples e.g. J7200 EVM
>> wouldn't  k3-j7200-evm.dtb include the k3-j7200-evm-quad-port-eth-exp.dtbo?
>> Is this what we really want?
>>
>> likewise for k3-j721e-evm.dtb and k3-am654-gp-evm.dtb
>>
> 
> Yes, that is the idea, the base-board.dtb is just the raw main board, but
> the "EVM" when you buy it comes with the quad-port daughtercard attached.
> That is what we consider the "EVM" and the DTB names match that.
> 
>> 2)
>> Another issue (unrelated to this change) is the below warning:
>>
>>     arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #address-cells value
>>     arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #size-cells value
>>
>> This is because we use the 'ranges' property in the gpmc0 node
>> and the compiler doesn't know the #address/size-cells of the
>> parent node.
>>
>> Is there a trick to specify it in the dtso file?
>>
> 
> Hmm, seems like a tricky one. Do you really need to do the ranges here?
> Could you use the default `ranges;` for gpmc0? Then do the range translation
> down inside the nand node to keep the partition addresses sane.

I think we need to go down this route.

Your suggestion about using ranges in gpmc0 node in the EVM DT file is
fine I guess as for this board there is no other use case for GPMC.
So it should be OK to reserve Chip Select0 address space at k3-am642-evm.dts

-- 
cheers,
-roger

