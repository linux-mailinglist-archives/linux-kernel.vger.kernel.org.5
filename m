Return-Path: <linux-kernel+bounces-91424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A32871155
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E677928418B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2757D3F0;
	Mon,  4 Mar 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV8VBHum"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD47CF2B;
	Mon,  4 Mar 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596234; cv=none; b=Xrc8hDgPqQyTGPbeCyDH8z4OCYS0zxeOsXwzpOUG5s6DXP8o1tcp+R13IQFsjiHufNoaV4FaW+HLo3q4g0chX+kCjzQ2YJmuPH9sIzi2AQllp8zAWvFzXK3p6zhIeCg/5m1UGhEtpKYvQacTfTJL5n208Pb9NaN6JWo1y9HWJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596234; c=relaxed/simple;
	bh=FUqV7V3jF4155KU2wYQ2VpqDEN8BLRgff07ULcK6dDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpIw2MQT4ZbZne3p9XWzzv9BhtQZWhiCPiqOaNBb706SMg71gxd9FobsDEfM9GUIPLjuJseHkJzQCVQ4pAo/cRBsW6y66V0zJ76kZ9G+3VwmgKl3+iXWFGmh5BvFIMBc7K2FJ6nAaCNM+QmQHxNSszZSQf4Ifm+qwG6CkgYLISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV8VBHum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B69C433F1;
	Mon,  4 Mar 2024 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709596234;
	bh=FUqV7V3jF4155KU2wYQ2VpqDEN8BLRgff07ULcK6dDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TV8VBHum6DhMa9heo77mkcgh5EBnsNaX7tquiD7C18YX4iQEgSqwDrOXJcKqWKyDQ
	 xA2/V+2wisq0K2kay3/O1WyD74yhX6ITb6oVQnUEUouULKCluzUMqEuD/9iPC75fEO
	 7nY4DCfKezJgEqYAoYisyEbqtRPwy6L7yQOLB4q+ooziskwwYQBgPBLd51R7DkbWKA
	 0zlVreg1ZmTWPewFZSq3y/0xV8YPYlmA39gahM2hlMsHYzbE9eHxKDQt1KCnRYl0Z2
	 yfK/aj1itIUE+WpsSPw9CPjfui40ZRp5CGrlD6BkBWjxwBedhicj5nnMbNhRwyX4/W
	 Gc+21lWvvFW1w==
Message-ID: <2a206c9b-b570-4081-b4e4-d177343482f3@kernel.org>
Date: Tue, 5 Mar 2024 08:50:29 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] riscv: config: enable SOC_CANAAN in defconfig
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_E2812086B695A334EE5E8C70C85CA3171F06@qq.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <tencent_E2812086B695A334EE5E8C70C85CA3171F06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 06:06, Yangyu Chen wrote:
> Since K230 has been supported, allow SOC_CANAAN to be selected to build dt
> and drivers for it in defconfig.
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 89a009a580fe..20b557ec28df 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=y
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_THEAD=y
>  CONFIG_SOC_VIRT=y
> +CONFIG_SOC_CANAAN=y

Given that the k210 need !MMU, including it like this in the defconfig is
odd... I do not even see how that could work. But that depends on patch 5,
which does not seem OK to me.

>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
>  CONFIG_PM=y

-- 
Damien Le Moal
Western Digital Research


