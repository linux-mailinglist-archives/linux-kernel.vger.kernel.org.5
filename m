Return-Path: <linux-kernel+bounces-148532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8582A8A840A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B6285D21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DBC13C3E0;
	Wed, 17 Apr 2024 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tURE3Q0B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AF13C684;
	Wed, 17 Apr 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359797; cv=none; b=YGUneo/tGTNTlbBfW/41OCrOYYLkD+gecxOf19NQEYdKaGrUE4WGOAonBoYzZkv4erXHzLyPEtkY5EucUIpu5Ea8fUiqqPAQaXL7Aadzsj0CPBgPdu4cgxbIQhtNoncqsM/yxGT5RRHh2649T1350ciWgBNDNMxxBk85CNKeSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359797; c=relaxed/simple;
	bh=vIF/tuUXPZ1vvCuvAOdp+pF7cW+4Rnwljj95ZI6+nsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNGhe7uT7bLOHa6AVu5DzGy3KMMi4U7khjfWewhg99a6xhhnGoAdlXSUhVS1v6IVzoB22sYqv1lwTfYa1hLbkdnluO6EbJJIlWu7VJCZ+a2qyGzSn+CQQVHLTtzwMcVE6LEd1u7eu9o5qB3gaeavZn0nPFb4uy0aNIVh2fBO1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tURE3Q0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1791DC072AA;
	Wed, 17 Apr 2024 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713359797;
	bh=vIF/tuUXPZ1vvCuvAOdp+pF7cW+4Rnwljj95ZI6+nsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tURE3Q0BqGDy7tHAmbeBItAdQakC0qmA5hO3u1m4LbRQVy6IWv7hoJLL0a4YWSscT
	 GNhv3zNn5HxqBFviAcIFm672U7gfvvzUaRUwI9rbttSokxckaa3wbX85Po5iISPYfE
	 V249m1RKrTOfsmfvMktyNhkEcmUHPAtWcHQ24MrFlrQWm08aTWljXDWvdCx26VroGd
	 DuWDNkFTWw00N9G752yyKWCPFQfpelq+BUeMmgqGqHPnEmkeTsi9qLKQk3WLccK9HQ
	 H5RLQ7MV2kHPo4diBHYJzHLY/3HBhQIYTSqpCHMkbUx86cjT1bs716SU5YuFi6F9Gz
	 fyhJ9DDxzcwRQ==
Message-ID: <156b27dd-0b3f-43b0-95ec-a69b69673e60@kernel.org>
Date: Wed, 17 Apr 2024 15:16:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] dt-bindings: rng: Add vmgenid support
To: Babis Chalios <bchalios@amazon.es>, tytso@mit.edu, Jason@zx2c4.com,
 olivia@selenic.com, herbert@gondor.apana.org.au, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sudanl@amazon.com, graf@amazon.de, xmarcalx@amazon.co.uk,
 dwmw@amazon.co.uk
References: <20240417081212.99657-1-bchalios@amazon.es>
 <20240417081212.99657-5-bchalios@amazon.es>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240417081212.99657-5-bchalios@amazon.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 10:12, Babis Chalios wrote:
> From: Sudan Landge <sudanl@amazon.com>
> 
> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
> ACPI only device.
> 
> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709 defines
> a mechanism for the BIOS/hypervisors to communicate to the virtual machine
> that it is executed with a different configuration (e.g. snapshot execution
> or creation from a template).
> The guest operating system can use the notification for various purposes
> such as re-initializing its random number generator etc.
> 
> As per the specs, hypervisor should provide a globally unique identified,
> or GUID via ACPI.
> 
> This patch tries to mimic the mechanism to provide the same functionality
> which is for a hypervisor/BIOS to notify the virtual machine when it is
> executed with a different configuration.
> 
> As part of this support the devicetree bindings requires the hypervisors or
> BIOS to provide a memory address which holds the GUID and an IRQ which is
> used to notify when there is a change in the GUID.
> The memory exposed in the DT should follow the rules defined in the
> vmgenid spec mentioned above.
> 
> *Reason for this change*:
> Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
> Without going into details of why a hypervisor would chose DT over ACPI,
> we would like to highlight that the hypervisors that have chose devicetree
> and now want to make use of the vmgenid functionality cannot do so today
> because vmgenid is an ACPI only device.
> This forces these hypervisors to change their design which could have
> undesirable impacts on their use-cases, test-scenarios etc.
> 
> The point of vmgenid is to provide a mechanism to discover a GUID when
> the execution state of a virtual machine changes and the simplest
> way to do it is pass a memory location and an interrupt via devicetree.
> It would complicate things unnecessarily if instead of using devicetree,
> we try to implement a new protocol or modify other protocols to somehow
> provide the same functionility.
> 
> We believe that adding a devicetree binding for vmgenid is a simpler,
> better alternative to provide the same functionality and will allow
> such hypervisors as mentioned above to continue using devicetree.
> 
> More references to vmgenid specs:
>  - https://www.qemu.org/docs/master/specs/vmgenid.html
>  - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-
> machine-generation-identifier
> 
> Signed-off-by: Sudan Landge <sudanl@amazon.com>

Missing SoB. Probably everywhere...



Best regards,
Krzysztof


