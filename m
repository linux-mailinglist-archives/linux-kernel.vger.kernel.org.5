Return-Path: <linux-kernel+bounces-6131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBA8194FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447A21F25BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738001C05;
	Wed, 20 Dec 2023 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OfG2Jlwp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B9FBE0;
	Wed, 20 Dec 2023 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703031104;
	bh=ULx5xd+z/eIZKpsC2ELI2qU38ouHqgBhMuuOX3WZpCs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=OfG2Jlwpg/d7fgTNVvQ8VqO4fAYQ6lXx6bTNLWF/y6+fxHdzlVVNwmgZCGqhKuENn
	 pRGFekFWsrigklcjZ3CoeuuxWxB75uNYNDBetgEJOYWOXMSphloTSkn2q2rjimOM7X
	 8VF8S4VcL12suO/cj5Nd/UfwzDgbd44I2X3BLBjhz0IYNFE5vCJmIfizk0ByVcRpME
	 8WA4Luqw579mcDJcu12/fp1OLT+4agWcVFF/6lCDsa0afP/yN6lglovEeMfHSr7L2x
	 x68lhBC7Pw1zLAdYutPytTnh6naTLokB0a3FdnopJYg50AnCHd1Q2MiRWGtKkgmnvZ
	 iP3OsVqipc9Lg==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 559AD378000B;
	Wed, 20 Dec 2023 00:11:43 +0000 (UTC)
Message-ID: <4992a407-c59f-4d1c-a058-9a6679606103@collabora.com>
Date: Wed, 20 Dec 2023 02:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] StarFive DWMAC support for JH7100
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20231219231040.2459358-1-cristian.ciocaltea@collabora.com>
 <20231219-green-footwear-e81d37f9c63c@spud>
 <25f36378-a998-4a48-b348-1ab1df6c803e@collabora.com>
In-Reply-To: <25f36378-a998-4a48-b348-1ab1df6c803e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 01:58, Cristian Ciocaltea wrote:
> On 12/20/23 01:48, Conor Dooley wrote:
>> On Wed, Dec 20, 2023 at 01:10:38AM +0200, Cristian Ciocaltea wrote:
>>> This is just a subset of the initial patch series [1] adding networking
>>> support for StarFive JH7100 SoC.
>>>
>>> [1]: https://lore.kernel.org/lkml/20231218214451.2345691-1-cristian.ciocaltea@collabora.com/
>>
>> You need to send the binding patch alongside the driver, unless that has
>> been applied already.

You are right, the binding should stay with the driver as it provides
the top-level compatibles.  I was wrongly thinking on the base
snps,dwmac only.

> Yeah, I wasn't sure about that, that's why I initially asked in [1] for
> a confirmation regarding the split.  I chose to keep the binding in the
> same set with the dts patches because the driver is just a glue layer
> and doesn't really depend on bindings changes.
> 
> Should I still provide it here?  I was about to submit the remaining
> patch set, so it would be great if we could clarify this beforehand.
> 
> Thanks for noticing the potential issue,
> Cristian
> 
> [1]:
> https://lore.kernel.org/lkml/0451e5a9-0cfb-42a5-b74b-2012e2c0d326@collabora.com/
> 
> 

