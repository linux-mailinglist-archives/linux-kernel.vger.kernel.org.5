Return-Path: <linux-kernel+bounces-6121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E58194D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D15B2273F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A840BE1;
	Tue, 19 Dec 2023 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I43QO99F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC53405DA;
	Tue, 19 Dec 2023 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703030310;
	bh=9ot1i5HIItHqTBppVifdZueNQoMSqIGzNGpHOD0XAqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I43QO99FBAD+LAYUHaX0jD0j7R3pbtTunfbwq3SrhABMgkPe8NqQRgvTuixWDE7bi
	 h20n+Au7JiN1soqOvjeDMKJUd4Tu291QWEP+bzcrgXs6PdSt2jPhL3RyP1QRmpG0fx
	 XBZ+R4rnIxVCjT7JBGXdKlJUTGKwXnIxMS5LFaSWu1c+kXlwKDp/UuBGH4SmNpsD5I
	 /Fjnik7GOhKzRqNQFjCJUQXXobMrSWIwk0mcW59H7TkymIcox7TEmhSpEqHz/xDwFC
	 E9qCFLXc0vUhj9tGMEpVuGRKaOvOZx3VbURU4DnG5rfdJiZg7QVp82PiIEcibLo8Ih
	 1nKgF43MkQQjA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 912B237811D4;
	Tue, 19 Dec 2023 23:58:29 +0000 (UTC)
Message-ID: <25f36378-a998-4a48-b348-1ab1df6c803e@collabora.com>
Date: Wed, 20 Dec 2023 01:58:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] StarFive DWMAC support for JH7100
Content-Language: en-US
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
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20231219-green-footwear-e81d37f9c63c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 01:48, Conor Dooley wrote:
> On Wed, Dec 20, 2023 at 01:10:38AM +0200, Cristian Ciocaltea wrote:
>> This is just a subset of the initial patch series [1] adding networking
>> support for StarFive JH7100 SoC.
>>
>> [1]: https://lore.kernel.org/lkml/20231218214451.2345691-1-cristian.ciocaltea@collabora.com/
> 
> You need to send the binding patch alongside the driver, unless that has
> been applied already.

Yeah, I wasn't sure about that, that's why I initially asked in [1] for
a confirmation regarding the split.  I chose to keep the binding in the
same set with the dts patches because the driver is just a glue layer
and doesn't really depend on bindings changes.

Should I still provide it here?  I was about to submit the remaining
patch set, so it would be great if we could clarify this beforehand.

Thanks for noticing the potential issue,
Cristian

[1]:
https://lore.kernel.org/lkml/0451e5a9-0cfb-42a5-b74b-2012e2c0d326@collabora.com/



