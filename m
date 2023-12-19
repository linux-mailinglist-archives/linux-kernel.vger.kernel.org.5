Return-Path: <linux-kernel+bounces-5249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31461818887
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B391F248CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBD18EB0;
	Tue, 19 Dec 2023 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1wTMgGGD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341451944B;
	Tue, 19 Dec 2023 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702992060;
	bh=TsO3xC5LiEC2Q1rDd6j5HFyylembdHw/NQAvbMXny7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1wTMgGGDN41nxiK38PIzsZRseLY07AikSD3kZrb6PZ/3ByZMDE7oCm8FOQWDXzzFD
	 ym4/CBeHqaC2rghNXq8jIxH5xOeU2qE3gXG8fQoQPo8Lb6cy/mHXSIDQp41qpMLEWK
	 EI6d1quKbBpZCn8o4BaTxt8nmkSCmPgueu7RmSk/IDBQl2PEMAB58kYAObV3Ng1oyT
	 nzaIHtWLIKRUZVA2BWM/XL91BQ9ZUl824xjvkjFDZME9LagsP8wkrWOlSDwPWWielV
	 cVmXBkCGeo1OAX1vfUxbC90Cv6/ref42de0inLmjCDs0RtMkow7xpCvtrNlAPPsjbM
	 lOkKmBOzqlhng==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5AB9F378145A;
	Tue, 19 Dec 2023 13:20:58 +0000 (UTC)
Message-ID: <0451e5a9-0cfb-42a5-b74b-2012e2c0d326@collabora.com>
Date: Tue, 19 Dec 2023 15:20:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Enable networking support for StarFive JH7100 SoC
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231218214451.2345691-1-cristian.ciocaltea@collabora.com>
 <a37d2df9-e593-476f-bfef-d9abaf063daa@lunn.ch>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <a37d2df9-e593-476f-bfef-d9abaf063daa@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/23 11:03, Andrew Lunn wrote:
> On Mon, Dec 18, 2023 at 11:44:40PM +0200, Cristian Ciocaltea wrote:
>> This patch series adds ethernet support for the StarFive JH7100 SoC and makes it
>> available for the StarFive VisionFive V1 and BeagleV Starlight boards, although
>> I could only validate on the former SBC.  Thank you Emil and Geert for helping
>> with tests on BeagleV!
> 
> You will need to split this into patch sets per subsystem. The changes
> to the stmmac driver can then go via netdev, and the rest via each
> subsystem maintainer. It should then all meet in linux-next and work
> there.

Thanks for the reviews and your support to get those networking issues
properly handled!

Just to confirm the split will be done correctly, I'm going to keep just
the bindings and dts patches in v5, while the networking driver and
clock related patches will be submitted as part of two additional sets.

Regards,
Cristian

