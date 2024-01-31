Return-Path: <linux-kernel+bounces-46346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A0843E5C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7411F2BA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6816F76052;
	Wed, 31 Jan 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="teoPUFL/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8131E522;
	Wed, 31 Jan 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700592; cv=none; b=mFmVlduvPQsqFnHR3qzmSZ2r5Z8wm64oWizsz85rekE883Jxuin0oHbl6JH4F4QVbP4QxbKkVvdDSmSF1bNJMjrBk/J10f7lysdtTkHYeL72/cKf7OH+MBrEd9Hu9vfE/1x0gZ3YQvcu8RfqTUgoFlM7NUrLzy0P735whmINKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700592; c=relaxed/simple;
	bh=qqKn/biwXyEmqx6ult4octRmHalYzxtwPzsQnX5EA2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jny7Lh0f+wXysj1eNZFKTyzK3Nh78tsnb/YXyNsrXfG66MqyRvcSjN/frhSKLqVTbNPCARUxOaYC6Pj4Bxe3LY+3JkA7Et1wkmhEqfZ0ZK7HTb1/sieE+JYyA9xoXkmFY7JqEBUaizRr8eV0Ml1kO6+Qr4aYS5gHchYUl6StCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=teoPUFL/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706700589;
	bh=qqKn/biwXyEmqx6ult4octRmHalYzxtwPzsQnX5EA2o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=teoPUFL/0ROoVKEHUzEGThvqfQM4FRTUMhwZb/7s4qYklFDOJiwzfgPm5vBTBg9dW
	 rZfzVnBk2Sy7oxYMJyq3y1rujW5vOkE+nBv75sx2h80TMYM5DIdDGEa0Vt/E+u8P7q
	 rsCg5vv0M31XaMdu0C8iM3JHmt4uMX9JaDRzOQZgEr1UNwUM4JKdkbdKDxMr27qQ0H
	 yki7hF77YS1zqxMcPsxXq5rTGdXbfZQbk/r7ITp5qM0FUFVR5UbB1wZta38I/RzGZ2
	 llYEurU6M5KBo5M4ytURWLE7LuR85XzmzynsWyeChfXabyHmyQcSe8uUAY2MQ4+VOr
	 uBvL1lvBkA1Xg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2BEF83780C22;
	Wed, 31 Jan 2024 11:29:48 +0000 (UTC)
Message-ID: <f9fe53a4-c3b0-4e61-b607-40959c2d6c4c@collabora.com>
Date: Wed, 31 Jan 2024 13:29:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Enable networking support for StarFive JH7100 SoC
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Jacob Keller <jacob.e.keller@intel.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kernel@collabora.com
References: <20231220211743.2490518-1-cristian.ciocaltea@collabora.com>
 <CAJM55Z9tKQ_hpxrGUq1Rx1kxzzs-dyd=4yT1z=8B7KQ=CZ4mjA@mail.gmail.com>
 <20240110-quaking-unlisted-dcae7229a9f8@spud>
 <ae15ab84-fb1b-4da6-803d-6fd5ad46ce24@collabora.com>
In-Reply-To: <ae15ab84-fb1b-4da6-803d-6fd5ad46ce24@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

On 1/10/24 18:17, Cristian Ciocaltea wrote:
> On 1/10/24 15:57, Conor Dooley wrote:
>> On Tue, Dec 26, 2023 at 02:38:26PM -0600, Emil Renner Berthing wrote:
>>> Cristian Ciocaltea wrote:
>>>> This patch series adds ethernet support for the StarFive JH7100 SoC and
>>>> makes it available for the StarFive VisionFive V1 and BeagleV Starlight
>>>> boards, although I could only validate on the former SBC.  Thank you Emil
>>>> and Geert for helping with tests on BeagleV!
>>>>
>>>> The work is heavily based on the reference implementation [1] and depends
>>>> on the SiFive Composable Cache controller and non-coherent DMA support
>>>> provided by Emil via [2] and [3].
>>>>
>>>> *Update 1*: As of next-20231214, dependencies [2] & [3] have been merged.
>>>>
>>>> *Update 2*: Since v5, the dwmac patches will be handled via [4], while the
>>>>             clock patches subset via [5].
>>>
>>> I'm not sure my rb my sense when I'm listed as a co-developer, but this version
>>> looks good to me:
>>>
>>> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>
>> Cool, thanks. Cristian, can you ping this series once the binding gets
>> picked up by the netdev folks after the merge window closes?
> 
> Sure, will do!

The binding has been applied on net-next [1].

Thanks,
Cristian

[1]: https://lore.kernel.org/lkml/170669882745.1676.8675995195978883744.git-patchwork-notify@kernel.org/

